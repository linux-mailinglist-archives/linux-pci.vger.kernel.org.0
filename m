Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412DC63B9F2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 07:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiK2GsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 01:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2GsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 01:48:16 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C925C7A
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 22:48:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DCCED30001EA2;
        Tue, 29 Nov 2022 07:48:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CF96BC26E9; Tue, 29 Nov 2022 07:48:12 +0100 (CET)
Date:   Tue, 29 Nov 2022 07:48:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221129064812.GA1555@wunner.de>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
 <20221128203932.GA644781@bhelgaas>
 <20221128150617.14c98c2e.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128150617.14c98c2e.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 03:06:17PM -0700, Alex Williamson wrote:
> Agreed.  Is this convoluted removal process being used to force a SBR,
> versus a FLR or PM reset that might otherwise be used by twiddling the
> reset attribute of the GPU directly?  If so, the reset_method attribute
> can be used to force a bus reset and perform all the state save/restore
> handling to avoid reallocating BARs.  A reset from the upstream switch
> port would only be necessary if you have some reason to also reset the
> switch downstream ports.  Thanks,

A Secondary Bus Reset is only offered as a reset_method if the
device to be reset is the *only* child of the upstream bridge.
I.e. if the device to be reset has siblings or children,
a Secondary Bus Reset is not permitted.

Modern GPUs (including the one Mika is referring to) consist of
a PCIe switch with the GPU, HD audio and telemetry devices below
Downstream Bridges.  A Secondary Bus Reset of the Root Port is
not allowed in this case because the Switch Upstream Port has
children.

See this code in pci_parent_bus_reset():

	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
		return -ENOTTY;

The dev->subordinate check disallows a SBR if there are children.
Note that the code should probably instead check for...
(dev->subordinate && !list_empty(dev->subordinate->devices))
...because the port may have a subordinate bus without children
(may have been removed for example).

The "no siblings" rule is enforced by:

	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
		if (pdev != dev)
			return -ENOTTY;

Note that the devices list is iterated without holding pci_bus_sem,
which looks fishy.

That said, it *is* possible that a Secondary Bus Reset is erroneously
offered despite these checks because we perform them early on device
enumeration when the subordinate bus hasn't been scanned yet.

So if the Root Port offers other reset methods besides SBR and the
user switches to one of them, then reinstates the defaults,
suddenly SBR will disappear because the subordinate bus has since
been scanned.  What's missing here is that we re-check availability
of the reset methods on siblings and the parent when a device is
added or removed.  This is also necessary to make reset_method
work properly with hotplug.  However, the result may be that the
reset_method attribute in sysfs may become invisible after adding
a device (because there is no reset method available) and reappear
after removing a device.

So the reset_method logic is pretty broken right now I'm afraid.

In any case, for Mika's use case it would be useful to have a
"reset_subordinate" attribute on ports capable of a SBR such that
the entire hierarchy below is reset.  The "reset" attribute is
insufficient.

Thanks,

Lukas
