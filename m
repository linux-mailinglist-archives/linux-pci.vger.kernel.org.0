Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46CD692BCB
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBKALu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBKALt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:11:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617ED4ECE;
        Fri, 10 Feb 2023 16:11:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB2861EE5;
        Sat, 11 Feb 2023 00:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3067AC433D2;
        Sat, 11 Feb 2023 00:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676074306;
        bh=afYZ1b3HTXxa+B/cWldCTO+pwBoRTWKZK02+Um3tSfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FwI/aTmyhAYnc936Z2SN5K2XgsKgUzl2yFvWL2NmGOSsqLlgV/B6My4nhlt9iNEnp
         kktoiatedjtF8NpPG1s+e5zn8EiYnexsyFxKCDZ2RqFvCJa3QZ3cX1ciKwcCcjQuO8
         F2JDifMVxA0wDQIqJ4PJ9smmKmeJx3c/5oh0VGkBryCPnlWjDzD29B+GXK8jGIjEDt
         BImUnHJgo6Ztu1RjjFJ+w/HK/kmMvdpWSiEh9mLMwsWroigQ9RBx4WvP59iVa2uMdP
         qlYT/u2mpadz4s19hoU8o5eWmyoNBcn4TZzZglptgZh50NlolXPg1tn+5mkvb3TwfD
         W0gQGnjWpgUXA==
Date:   Fri, 10 Feb 2023 18:11:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com, bhelgaas@google.com,
        Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Message-ID: <20230211001144.GA2716712@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a3eb31-ebeb-2a8c-e504-4ea52e720844@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 04:46:15PM -0700, Dave Jiang wrote:
> On 2/10/23 3:52 PM, Bjorn Helgaas wrote:
> > On Fri, Feb 10, 2023 at 10:04:03AM -0700, Dave Jiang wrote:
> > > By default the CXL RAS mask registers bits are defaulted to 1's and
> > > suppress all error reporting. If the kernel has negotiated ownership
> > > of error handling for CXL then unmask the mask registers by writing 0s.
> > > 
> > > PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
> > > allows exposure of system enabled PCI error flags for the driver to decide
> > > which error bits to toggle. Bjorn suggested that the error enabling should
> > > be controlled from the system policy rather than a driver level choice[1].
> > > 
> > > CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
> > > unmasking.
> > > 
> > > [1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af
> > 
> > > +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > > +	void __iomem *addr;
> > > +	u32 orig_val, val, mask;
> > > +
> > > +	if (!cxlds->regs.ras)
> > > +		return -ENODEV;
> > > +
> > > +	/* BIOS has CXL error control */
> > > +	if (!host_bridge->native_cxl_error)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {
> > 
> > 1) I don't really want to expose PCI_EXP_AER_FLAGS in linux/pci.h.
> > It's basically a convenience part of the AER implementation.
> > 
> > 2) I think your intent here is to configure the CXL RAS masking based
> > on what PCIe error reporting is enabled, but doing it by looking at
> > PCI_EXP_AER_FLAGS doesn't seem right.  This expression is a
> > compile-time constant that is always true, but we can't rely on
> > devices always being configured that way.
> > 
> > We call pci_aer_init() for every device during enumeration, but we
> > only write PCI_EXP_AER_FLAGS if pci_aer_available() and if
> > pcie_aer_is_native().  And there are a bunch of drivers that call
> > pci_disable_pcie_error_reporting(), which *clears* those flags.  I'm
> > not sure those drivers *should* be doing that, but they do today.
> > 
> > I'm not sure why this needs to be conditional at all, but if it does,
> > maybe you want to read PCI_EXP_DEVCTL and base it on that?
> 
> Ok I'll read the PCI_EXP_DEVCTL. Looking to only unmask the relevant RAS
> reporting if respective PCIe bits are enabled.

That sounds OK to me, but leaves the question of those drivers that
call pci_disable_pcie_error_reporting() because CXL won't know about
that.  But maybe that's not a problem, I dunno.

> > I see you're just adding a check of return value here, but I'm not
> > sure you need to call pci_enable_pcie_error_reporting() in the first
> > place.  Isn't the call in the pci_aer_init() path enough?
> 
> I guess I'm confused by the kernel documentation:
> "
> pci_enable_pcie_error_reporting enables the device to send error
> messages to root port when an error is detected. Note that devices
> don't enable the error reporting by default, so device drivers need
> call this function to enable it.
> "
> 
> Seems to indicate that driver should always call this if it wants AER
> reporting?

Oh, thanks for pointing that out!  I'll update that doc to match the
current code, which *does* enable reporting by default:

commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
Author: Stefan Roese <sr@denx.de>
Date:   Tue Jan 25 08:18:20 2022 +0100

    PCI/AER: Enable error reporting when AER is native

    If we have native control of AER, set the following error reporting enable
    bits:

      - Correctable Error Reporting Enable
      - Non-Fatal Error Reporting Enable
      - Fatal Error Reporting Enable
      - Unsupported Request Reporting Enable

    Note that these bits are all in the Device Control register and are not
    AER-specific.

    This affects all devices with an AER capability, including hot-added
    devices.

    Please note that this change is quite invasive, as error reporting now will
    be enabled for all available PCIe Endpoints, which was previously not the
    case.

    When "pci=noaer" is selected, error reporting stays disabled of course.
