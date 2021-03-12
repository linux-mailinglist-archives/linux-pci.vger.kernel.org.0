Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C13396C7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhCLSlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 13:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhCLSlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 13:41:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE1C061574;
        Fri, 12 Mar 2021 10:41:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s21so2471876pfm.1;
        Fri, 12 Mar 2021 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4yRPxufzWT3thQ7Bv+f09drpbgtD2Z1Oj1m47AWLtpw=;
        b=XW4UHta53j/lMCQhf6ZIWbHCTtIkoPjRHjL0Y3ZT9eSjftYN418B5pVvbexerz/rb/
         JwRTG+v8LcqiY409epXxWGrojOVTZ14YZZ4clda2vG4nm9mnUv+gimOj+xaQ1GZKyE4e
         Kk09hRUU1VvtrMrWFPkKxgm1epfBndvbr7D6zKWoCZowENAXebbGCVyTdZ6oU4/pFUJ5
         8fxlIg07MF7F9r0Ae3cj9DvkZWBZvjuxz9DE37hdhfGADWJEgQz5uO2laQ+5iOBvNhCk
         4OvAoGNmYmydYS9uHLJBk6tt71cV8HYBXghCyDS9NN+J83/uO4LMKC5dt5sAQVOItXa0
         3bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4yRPxufzWT3thQ7Bv+f09drpbgtD2Z1Oj1m47AWLtpw=;
        b=Ae6raJVoLRsXXkoHAC+hLIbcquRZqvNqfjVj1rv5mVPYL6G9NLF3eqY8OAMU1QJfb4
         sAIP0ZbJYzGThKTSOK50DDgHd2LQES2l2st7jBJ1ZXuCSMhYJdo59kklQM7VpKswIFPD
         V0weauXLOcHD4wCV3NnTjqq1i8YXyDF3lBzlyssTEZQ67kSYFvUXdRmIvmlacjY6bfXZ
         vtBtM2EG4Y13Y6aipb0GdJ+PIfrqhBftOGPqHmYhD3ichAwEzn3cRvAKv55sVAlVW1b4
         9xqH38gTbg293SBWP68YsqhKAwvJfaYry4UZq++1ymTO76xOoGonBX6trSmWytdW/dCE
         IiEA==
X-Gm-Message-State: AOAM5304EqVwNw2vB8EBd/3LwLE+TH7ti+BeEBPUZns4fQVeBrPuCbi3
        aB6ZHFUrMUlyE2v9CESJfX9hHnuea0dPHw==
X-Google-Smtp-Source: ABdhPJzX+Kk6OzaJLcGb4y3lU8P7acpzzlbTVaWA3v23i0E2TNvrXi406JAmWEYpkU4MvEGaPDXmKg==
X-Received: by 2002:a63:7885:: with SMTP id t127mr12651569pgc.237.1615574477523;
        Fri, 12 Mar 2021 10:41:17 -0800 (PST)
Received: from localhost ([103.248.31.144])
        by smtp.gmail.com with ESMTPSA id v27sm6104554pfi.89.2021.03.12.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:41:17 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:10:38 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, raphael.norwitz@nutanix.com
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Message-ID: <20210312184038.to3g3px6ep4xfavn@archlinux>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312112043.3f2954e3@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312112043.3f2954e3@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/12 11:20AM, Alex Williamson wrote:
> On Fri, 12 Mar 2021 23:04:48 +0530
> ameynarkhede03@gmail.com wrote:
>
> > From: Amey Narkhede <ameynarkhede03@gmail.com>
> >
> > PCI and PCIe devices may support a number of possible reset mechanisms
> > for example Function Level Reset (FLR) provided via Advanced Feature or
> > PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> > Currently the PCI subsystem creates a policy prioritizing these reset methods
> > which provides neither visibility nor control to userspace.
> >
> > Expose the reset methods available per device to userspace, via sysfs
> > and allow an administrative user or device owner to have ability to
> > manage per device reset method priorities or exclusions.
> > This feature aims to allow greater control of a device for use cases
> > as device assignment, where specific device or platform issues may
> > interact poorly with a given reset method, and for which device specific
> > quirks have not been developed.
> >
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> Reviews/Acks/Sign-off-by from others (aside from Tested/Reported-by)
> really need to be explicit, IMO.  This is a common issue for new
> developers, but it really needs to be more formal.  I wouldn't claim to
> be able to speak for Raphael and interpret his comments so far as his
> final seal of approval.
>
> Also in the patches, all Sign-offs/Reviews/Acks need to be above the
> triple dash '---' line.  Anything between that line and the beginning
> of the diff is discarded by tools.  People will often use that for
> difference between version since it will be discarded on commit.
> Likewise, the cover letter is not committed, so Review-by there are
> generally not done.  I generally make my Sign-off last in the chain and
> maintainers will generally add theirs after that.  This makes for a
> chain where someone can read up from the bottom to see how this commit
> entered the kernel.  Reviews, Acks, and whatnot will therefore usually
> be collected above the author posting the patch.
>
> Since this is a v1 patch and it's likely there will be more revisions,
> rather than send a v2 immediately with corrections, I'd probably just
> reply to the cover letter retracting Raphael's Review-by for him to
> send his own and noting that you'll fix the commit reviews formatting,
> but will wait for a bit for further comments before sending a new
> version.
>
> No big deal, nice work getting it sent out.  Thanks,
>
> Alex
>
Raphael sent me the email with
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com> that
is why I included it.
So basically in v2 I should reorder tags such that Sign-off will be
the last. Did I get that right? Or am I missing something?

Thanks,
Amey

> > Amey Narkhede (4):
> >   PCI: Refactor pcie_flr to follow calling convention of other reset
> >     methods
> >   PCI: Add new bitmap for keeping track of supported reset mechanisms
> >   PCI: Remove reset_fn field from pci_dev
> >   PCI/sysfs: Allow userspace to query and set device reset mechanism
> >
> >  Documentation/ABI/testing/sysfs-bus-pci       |  15 ++
> >  drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
> >  drivers/crypto/qat/qat_common/adf_aer.c       |   2 +-
> >  drivers/infiniband/hw/hfi1/chip.c             |   4 +-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
> >  .../ethernet/cavium/liquidio/lio_vf_main.c    |   4 +-
> >  .../ethernet/cavium/liquidio/octeon_mailbox.c |   2 +-
> >  drivers/net/ethernet/freescale/enetc/enetc.c  |   2 +-
> >  .../ethernet/freescale/enetc/enetc_pci_mdio.c |   2 +-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
> >  drivers/pci/pci-sysfs.c                       |  68 +++++++-
> >  drivers/pci/pci.c                             | 160 ++++++++++--------
> >  drivers/pci/pci.h                             |  11 +-
> >  drivers/pci/pcie/aer.c                        |  12 +-
> >  drivers/pci/probe.c                           |   4 +-
> >  drivers/pci/quirks.c                          |  17 +-
> >  include/linux/pci.h                           |  17 +-
> >  17 files changed, 213 insertions(+), 117 deletions(-)
> >
> > --
> > 2.30.2
> >
>
