Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310AA7A3DEA
	for <lists+linux-pci@lfdr.de>; Sun, 17 Sep 2023 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIQVk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 17:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjIQVkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 17:40:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5348130
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 14:40:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481BC433C7;
        Sun, 17 Sep 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694986818;
        bh=QrF6MrTe9f9OqgsWZdmZBLwBSHa4EFoNxo5jCjd5ESo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MCkjurcesONVRY0oURk0EKAltGHlbNyAqE5q4Aj5Zb0WzXOSzx5tNzC5N1FE4LgFs
         oLHTEs9+f+/GK6G5hHsuqNjMYHHt0V0oCHTaSR5Fk+3lAcEkjdOImbf/pqQXetVDKT
         6sxvEci0k/xrq0ZSszxpnRhC0ivo6IgXjuUgAIrl4fJT3avVX/IhgTLBJYK7tpBhl7
         w0xLbweDaQQFWTDCFfd8llJWTZaEF+VSFzJfmRohMg8P8zwuU32l+HYns97K7pk5ek
         8l6UZynwHxANDwrJvaBeqmU8xQGUZQpLb1x1bVaZHcbXW+VkkeuBgBXrpAfgxLKyoM
         9n6ryWs2HXQSQ==
Date:   Sun, 17 Sep 2023 16:40:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230917214015.GA171862@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916133650.GA26241@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 16, 2023 at 03:36:50PM +0200, Lukas Wunner wrote:
> On Sat, Sep 16, 2023 at 08:09:19AM -0500, Mario Limonciello wrote:
> > On 9/15/2023 23:48, Lukas Wunner wrote:
> > > On Fri, Sep 15, 2023 at 07:04:11AM -0500, Mario Limonciello wrote:
> > > > On 9/15/2023 02:08, Lukas Wunner wrote:
> > > > > On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
> > > > > > +static bool child_has_amd_usb4(struct pci_dev *pdev)
> > > > > > +{
> > > > > > +	struct pci_dev *child = NULL;
> > > > > > +
> > > > > > +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
> > > > > > +		if (child->vendor != PCI_VENDOR_ID_AMD)
> > > > > > +			continue;
> > > > > > +		if (pcie_find_root_port(child) != pdev)
> > > > > > +			continue;
> > > > > > +		return true;
> > > > > > +	}
> > > > > > +
> > > > > > +	return false;
> > > > > > +}
> ...

> The "pcie_find_root_port(child) != pdev" check is always false:

If we were using pci_walk_bus() and only looking at devices below
pdev, I would agree, but since we're using pci_get_class(), which
searches all PCI devices in the system, I'm confused about why it
would always be false.

I don't really see the point of checking for USB4, because the commit
log doesn't say anything about why this would be specific to USB4.

I know Mario has mentioned something about how "internal interrupt
routing works with the USB4 controller connected to this root port,"
but I don't understand what that means.

Is the USB4 controller integrated into the Root Port?  Or is this
interrupt routed via some non-PCIe mechanism?  If the USB4 controller
is connected via standard PCIe, I don't see why the issue sould be
specific to USB4.

I could believe that BIOS configures the Root Port differently based
on whether the downstream device is USB4, but I haven't heard anything
about that.

Bjorn
