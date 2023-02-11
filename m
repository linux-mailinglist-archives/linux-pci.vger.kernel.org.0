Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3F692BEB
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBKA0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKA0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:26:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41167BFEC;
        Fri, 10 Feb 2023 16:26:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0984B8261F;
        Sat, 11 Feb 2023 00:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D048C433EF;
        Sat, 11 Feb 2023 00:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676075190;
        bh=8cDzTwCErfy73HJPnQ9KOyOAOEuiW4YsBNnlZC6He+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YSf1R+V7pjr5oD8cjJeUsfdCSaLbdNjlgZ5HdfsF34YwU8ls9ci68SycpgTooooOH
         iGW6/LHSzqmWPu+y9Lwqd6OvAM+MFrN2RWPvwp7eHWCmhc9OIXZuPy/gynYo0GN2i6
         gFrawX7oJ/R/IsGIarT4NfySiB/2fQCde45X0dKzPl9DFSGA6nrelkuNQu9mW3WrMz
         t2PYBsCR1fq6B/zOAGHZhPLRIa38teUDn3kC0fUQhEgm5x5sT8LvkM08Rgl81Ci064
         dYPCzYO/9ktdEVEYXBYsnyttdsUB88E77k/+Su2a5wsAGIP7DL4yk4e8SjvYRJQdfk
         8JXAqkeGXRYlQ==
Date:   Fri, 10 Feb 2023 18:26:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, ira.weiny@intel.com,
        bhelgaas@google.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Message-ID: <20230211002628.GA2718027@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e6d58d7c371_1db5d0294b6@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 03:38:53PM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
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
> 
> Oh, I had asked Dave to do that to try to satisfy your request for a
> system wide policy. So that if someone wanted to modify what errors get
> unmasked globally just look at that value rather than re-read the
> register, but it seems I over-intepreted what you and Jonathan were
> talking about here when you mention "system policy":
> 
> https://lore.kernel.org/linux-cxl/20221229172731.GA611562@bhelgaas/

Yeah, I should have worded that more like "I think the PCI core, not
individual drivers, should be responsible for AER configuration."

Even if the PCI core does it all, that doesn't mean AER configuration
is known at compile-time because it depends on _OSC negotiation and
some kernel parameter special cases.

Bjorn
