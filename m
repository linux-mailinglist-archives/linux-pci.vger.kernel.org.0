Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5467B7279
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjJCU3e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCU3d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:29:33 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B5AB
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 13:29:30 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5311B2800BBF9;
        Tue,  3 Oct 2023 22:29:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 468571E8252; Tue,  3 Oct 2023 22:29:29 +0200 (CEST)
Date:   Tue, 3 Oct 2023 22:29:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003202929.GA28239@wunner.de>
References: <20231002180906.82089-1-mario.limonciello@amd.com>
 <20231003200034.GB16417@wunner.de>
 <33524298-88fe-461e-afdd-85f0763beec9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33524298-88fe-461e-afdd-85f0763beec9@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 03:16:47PM -0500, Mario Limonciello wrote:
> On 10/3/2023 15:00, Lukas Wunner wrote:
> > The pcie_find_root_port() function you're
> > using here will walk up the hierarchy until it finds the Root Port,
> > i.e. it's specifically for the case where there are switches between
> > the USB controller and Root Port (which I think you want to exclude).
> > I would have expected that you just call pci_upstream_bridge(dev) once
> > and check whether the returned device is a PCI_EXP_TYPE_ROOT_PORT.
> > 
> 
> Is there an advantage to using pci_upstream_bridge() given it's just one
> step up with pcie_find_root_port()?

Not really, no.  The information I was missing is that these Device IDs
are unique to the SoC and will never appear in a Thunderbolt-attached
device.

> That's exactly what I was worried about - what if other callers end up using
> pci_d3cold_disable/pci_d3cold_enable for some reason. We're all fighting for
> the same policy bits.
> 
> This being said, I am tending to agree with Bjorn, it's better to just clear
> the PME bits.

Fair enough, I'm sorry I led you down the wrong path with that
suggestion.  I guess no_d3cold is generally only useful for the
"D3cold is known to be broken *permanently*" use case.  Incidentally,
there's only a single driver in the tree calling pci_d3cold_enable()
and that's i915.  And it likewise disables and re-enables the flag at
the Root Port, just like you did.

Thanks,

Lukas
