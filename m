Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC36FF072
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjEKLTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjEKLTJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 07:19:09 -0400
X-Greylist: delayed 15746 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 04:19:04 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85765A8;
        Thu, 11 May 2023 04:19:04 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 075E110029C2F;
        Thu, 11 May 2023 13:19:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D240D160E2E; Thu, 11 May 2023 13:19:02 +0200 (CEST)
Date:   Thu, 11 May 2023 13:19:02 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230511111902.GA10720@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
> Clear all capabilities in Device Control 2 register as they are optional
> and it is not determined whether the next device inserted will support
> these capabilities. Moreover, Section 6.13 of the PCIe Base
> Specification [1], recommends clearing the ARI Forwarding Enable bit on
> a hot-plug event as its not guaranteed that the newly added component
> is in fact an ARI device.

Clearing ARI Forwarding Enable sounds reasonable, but I don't see
why all the other bits in the Device Control 2 register need to be
cleared.  If there isn't a reason to clear them, I'd be in favor of
leaving them alone.

As for clearing ARI Forwarding Enable, it seems commit b0cc6020e1cc
("PCI: Enable ARI if dev and upstream bridge support it; disable
otherwise") already solved this problem.  Quoth its commit message:

   "Currently, we enable ARI in a device's upstream bridge if the bridge and
    the device support it.  But we never disable ARI, even if the device is
    removed and replaced with a device that doesn't support ARI.
    
    This means that if we hot-remove an ARI device and replace it with a
    non-ARI multi-function device, we find only function 0 of the new device
    because the upstream bridge still has ARI enabled, and next_ari_fn()
    only returns function 0 for the new non-ARI device.
    
    This patch disables ARI in the upstream bridge if the device doesn't
    support ARI.  See the PCIe spec, r3.0, sec 6.13."

My superficial understanding of that patch is that we do find function 0,
while enumerating it we clear the ARI Forwarding Enable bit and thus the
remaining functions become accessible and are subsequently enumerated.

Are you seeing issues when removing an ARI-capable endpoint from a
hotplug slot and replacing it with a non-ARI-capable device?
If you do, the question is why the above-quoted commit doesn't avoid them.


> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -104,6 +104,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
>  		pci_dev_get(dev);
> +		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, 0xffff);
>  		pci_stop_and_remove_bus_device(dev);
>  		/*
>  		 * Ensure that no new Requests will be generated from

This clears the Device Control 2 register on the hotplugged device,
but to clear ARI Forwarding Enable, you'd have to clear the register
of the hotplug port, i.e. the *parent* of the hotplugged device.

Also, this patch doesn't apply cleanly to v6.4-rc1 because of a context
change by f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock between
reset_lock and device_lock").

Thanks,

Lukas
