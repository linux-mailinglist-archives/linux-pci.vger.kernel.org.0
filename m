Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0E525B634
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBV4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 17:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgIBV4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 17:56:14 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDB2208C7;
        Wed,  2 Sep 2020 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599083773;
        bh=d+rQ7xmqiTjn/8WtG7+CiHQNlFpV1Vx+xClMhlXgkSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RLtC+RrVT6dtacmvbzVE+hAxl+BEhhULzt2i/gefdp/KQPyu0JtQiOvpdkZwOcH2V
         g3B5Zm1ytGaVKQQdIEw9aLSHnbnY/PUEdOxy/m+Ktj4tWPefPxOQWYte6gJfgXpGPR
         1oO/n1f6hEIGKlY2cwdzNFOSTl73hswMbAm9Dg4o=
Date:   Wed, 2 Sep 2020 16:56:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
Subject: Re: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Message-ID: <20200902215612.GA271679@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 02:42:03PM -0400, Andrey Grodzovsky wrote:
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some blocks might be even gated and so best is to avoid touching it.
> 
> v2: Rename in_dpc to more meaningful name
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>  6 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c311a3c..b20354f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>  	atomic_t			throttling_logging_enabled;
>  	struct ratelimit_state		throttling_logging_rs;
>  	uint32_t			ras_features;
> +	bool                            in_pci_err_recovery;
>  };
>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 74a1c03..1fbf8a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>  	uint32_t ret;
>  
> +	if (adev->in_pci_err_recovery)
> +		return 0;

I don't know the whole scheme of this, but this looks racy.

It looks like the normal path through this function is the readl(),
which I assume is an MMIO read from the PCI device.  If this is called
after a PCI error occurs, but before amdgpu_pci_slot_reset() sets
adev->in_pci_err_recovery, the readl() will return 0xffffffff.

If this is called after amdgpu_pci_slot_reset() sets
adev->in_pci_err_recovery, it will return 0.  Do you really want those
two different cases?

>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>  		return amdgpu_kiq_rreg(adev, reg);

> @@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  
>  	pci_restore_state(pdev);
>  
> +	adev->in_pci_err_recovery = true;
>  	r = amdgpu_device_ip_suspend(adev);
> +	adev->in_pci_err_recovery = false;
>  	if (r)
>  		goto out;
