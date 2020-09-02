Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4322125B5F5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBVg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 17:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgIBVg2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 17:36:28 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7B9207EA;
        Wed,  2 Sep 2020 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599082587;
        bh=WtN5ltS9PHHpdTZya+dK5ycxCgNnaYjKvrzI0N35L7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fFbOZpfrBzvv2/XsBGaT9H1DlGZW08pDQNjf7OPiQ6TxJS2U3kpfeneJqK2aubOrT
         1VoK0IECBc/Hp/q++VFYMbmXNDEWBrFS/6LQ4MJ5FlEwyajOoUai2YFBZSpujMuEKd
         YgH1UbCdcyxMJukiRgSEoseDkERa6mCUlAUzSQv8=
Date:   Wed, 2 Sep 2020 16:36:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Message-ID: <20200902213625.GA269978@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 02:42:02PM -0400, Andrey Grodzovsky wrote:
> Many PCI bus controllers are able to detect a variety of hardware PCI errors on the bus, 
> such as parity errors on the data and address buses,  A typical action taken is to disconnect 
> the affected device, halting all I/O to it. Typically, a reconnection mechanism is also offered, 
> so that the affected PCI device(s) are reset and put back into working condition. 
> In our case the reconnection mechanism is facilitated by kernel Downstream Port Containment (DPC) 
> driver which will intercept the PCIe error, remove (isolate) the faulting device after which it 
> will call into PCIe recovery code of the PCI core. 
> This code will call hooks which are implemented in this patchset where the error is 
> first reported at which point we block the GPU scheduler, next DPC resets the 
> PCI link which generates HW interrupt which is intercepted by SMU/PSP who 
> start executing mode1 reset of the ASIC, next step is slot reset hook is called 
> at which point we wait for ASIC reset to complete, restore PCI config space and run 
> HW suspend/resume sequence to resinit the ASIC. 
> Last hook called is resume normal operation at which point we will restart the GPU scheduler.
> 
> More info on PCIe error handling and DPC are here:
> https://www.kernel.org/doc/html/latest/PCI/pci-error-recovery.html
> https://patchwork.kernel.org/patch/8945681/
> 
> v4:Rebase to 5.9 kernel and revert PCI error recovery core commit which breaks the feature.

What does this apply to?  I tried 

  - v5.9-rc1 (9123e3a74ec7 ("Linux 5.9-rc1")),
  - v5.9-rc2 (d012a7190fc1 ("Linux 5.9-rc2")),
  - v5.9-rc3 (f75aef392f86 ("Linux 5.9-rc3")),
  - drm-next (3393649977f9 ("Merge tag 'drm-intel-next-2020-08-24-1' of git://anongit.freedesktop.org/drm/drm-intel into drm-next")),
  - linux-next (4442749a2031 ("Add linux-next specific files for 20200902"))

but it doesn't apply cleanly to any.

> Andrey Grodzovsky (8):
>   drm/amdgpu: Avoid accessing HW when suspending SW state
>   drm/amdgpu: Block all job scheduling activity during DPC recovery
>   drm/amdgpu: Fix SMU error failure
>   drm/amdgpu: Fix consecutive DPC recovery failures.
>   drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
>   drm/amdgpu: Disable DPC for XGMI for now.
>   drm/amdgpu: Minor checkpatch fix
>   Revert "PCI/ERR: Update error status after reset_link()"
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 247 +++++++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 ++-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
>  drivers/pci/pcie/err.c                     |   3 +-
>  10 files changed, 222 insertions(+), 79 deletions(-)
> 
> -- 
> 2.7.4
> 
