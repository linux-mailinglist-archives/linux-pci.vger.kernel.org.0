Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D775F10539E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfKUNzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 08:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUNzS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 08:55:18 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EC920679;
        Thu, 21 Nov 2019 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344517;
        bh=6E0YF8yMllj8qK0e/SPC6Lbz+lUTP0OyTKxxgQareDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tECdPZzF8HyX9TTmeeiSmLmAIGiDqt8CoZWvW9wj9PVeU71Sq3d/ytdFURHqVq75T
         N15fg7oPvR15OANOzCtplXs4LfnKht8DXDXpiVb/mlaQWVKyJgRZhlpOaVYfbM86mG
         fsIFutGcLyCjWv35or3z/6Uexha4fojCRpm/8wcI=
Date:   Thu, 21 Nov 2019 07:55:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/1] drm: Prefer pcie_capability_read_word()
Message-ID: <20191121135505.GA37567@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 12:42:25PM -0500, Alex Deucher wrote:
> On Mon, Nov 18, 2019 at 3:37 AM Frederick Lawler <fred@fredlawl.com> wrote:
> >
> > Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> > added accessors for the PCI Express Capability so that drivers didn't
> > need to be aware of differences between v1 and v2 of the PCI
> > Express Capability.
> >
> > Replace pci_read_config_word() and pci_write_config_word() calls with
> > pcie_capability_read_word() and pcie_capability_write_word().
> >
> > Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> >
> > ---
> > V2
> > - Squash both drm commits into one
> > - Rebase ontop of d46eac1e658b
> > ---
> >  drivers/gpu/drm/amd/amdgpu/cik.c | 63 ++++++++++++++++-----------
> >  drivers/gpu/drm/amd/amdgpu/si.c  | 71 +++++++++++++++++++------------
> >  drivers/gpu/drm/radeon/cik.c     | 70 ++++++++++++++++++------------
> >  drivers/gpu/drm/radeon/si.c      | 73 ++++++++++++++++++++------------
> 
> Can you split this into two patches?  One for amdgpu and one for radeon?

I split this, and I also went back and split the related patches that
preceded this one.  I'll post the resulting series for reference.
