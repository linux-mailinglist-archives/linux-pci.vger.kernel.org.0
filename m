Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8293F9C9D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLVww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 16:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfKLVww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 16:52:52 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1991620818;
        Tue, 12 Nov 2019 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573595571;
        bh=PkD7kozdq2k/ZSyLZ865j/R/PKysg7H3vyHzIHb35IM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XfDpUs2+mCT6Tu1Su3Sfzl6nCJBIR/YUImx1TOoKhirMGvnLPd0r7RTcQc+BAj1gT
         ydYvDW6OObycoi4ztocywwoxYYIXrJD+NE6Ob+Lr7LpalawqZQMyENlHel9+x8dUnZ
         FlN/1pPXPv3WZuTl/hsFDswydjTpnpPT5XdMkaVk=
Date:   Tue, 12 Nov 2019 15:52:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH V3 0/3] drm: replace magic numbers
Message-ID: <20191112215249.GA214212@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR12MB1813200B2297DB19D1921A83F7770@CY4PR12MB1813.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 07:35:53PM +0000, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Bjorn Helgaas
> > Sent: Tuesday, November 12, 2019 12:35 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> > <daniel@ffwll.ch>
> > Cc: Frederick Lawler <fred@fredlawl.com>; linux-pci@vger.kernel.org;
> > Michel Dänzer <michel@daenzer.net>; linux-kernel@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Bjorn Helgaas
> > <bhelgaas@google.com>; Ilia Mirkin <imirkin@alum.mit.edu>
> > Subject: [PATCH V3 0/3] drm: replace magic numbers
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > amdgpu and radeon do a bit of mucking with the PCIe Link Control 2 register,
> > some of it using hard-coded magic numbers.  The idea here is to replace
> > those with #defines.
> > 
> > Since v2:
> >   - Fix a gpu_cfg2 case in amdgpu/si.c that I had missed
> >   - Separate out the functional changes for better bisection (thanks,
> >     Michel!)
> >   - Add #defines in a patch by themselves (so a GPU revert wouldn't break
> >     other potential users)
> >   - Squash all the magic number -> #define changes into one patch
> > 
> > Since v1:
> >   - Add my signed-off-by and Alex's reviewed-by.
> > 
> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> I'm happy to have it go through whatever tree is easiest for you.

OK, thanks!  I applied your reviewed-by and put these on my pci/misc
branch for v5.5, in hopes that we might get a followup patch from Fred
along the lines of 6133b9204c0a ("cxgb4: Prefer
pcie_capability_read_word()")

> > Bjorn Helgaas (3):
> >   PCI: Add #defines for Enter Compliance, Transmit Margin
> >   drm: correct Transmit Margin masks
> >   drm: replace numbers with PCI_EXP_LNKCTL2 definitions
> > 
> >  drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
> > drivers/gpu/drm/amd/amdgpu/si.c  | 22 ++++++++++++++--------
> >  drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
> >  drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
> >  include/uapi/linux/pci_regs.h    |  2 ++
> >  5 files changed, 58 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> > 
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
