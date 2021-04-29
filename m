Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35436E5B4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhD2HPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhD2HPM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 03:15:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE30C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:14:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z5so40789151edr.11
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7nI6BbyPEzw70igWdcsrF8qw/i2ynGf/Q5HrAwzuVLM=;
        b=fhlsQxmAMDnUg+hbv7vkOxh/vuBqXQsuz4NZ18+YlE+toEQqmLp97uXxW5O2MQyLSA
         lmQJUoOOrSQ58GuPDOHtFL3CTQ31z5eX1IazA0EhkM2uiLhFoCQ6DJAaqnzPlMQJW15S
         ua/h++/J2hXc8r9tSX+1mN1lhHHBRTu6rGNowcVN30fNHEZ4iNyDankqKBOLm/p9RwLA
         XtPwPDNtesH02ar7FdbFvUB6gN9n3F28vxj38JhifDzrMMNgyFMq+OYbbe2IkTCM9ZMc
         kPa3FFIJAI0FidO2nJgUfZ6P03zHDJSGMLErQjG7O3dAL+QNOTjq6USLp9eAa+FPVbNy
         i7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7nI6BbyPEzw70igWdcsrF8qw/i2ynGf/Q5HrAwzuVLM=;
        b=YRxkJgvqul93rrlFKK6Y021h6QH95TZUNTpAvwjHcG30XCEvhUPYzUYeIEc+QOOfmE
         ZuI8V7jWJ/MyB8PsiSj98GaDqi5aS/P5vWXjWSs5cqTw6ZWMQKfCH7s3DAwlnerMvzao
         nb3UGiQKTX+gG3dRik5BBLOZK3NUuI3pfbxP/YgphxB189CUveiwfWoidsz2WWwb+nwP
         WUsCUZugQ1rUGGQ3N0fASNTEbwYD60c9RXRcHv4Et0o4LGCPum3zXE3MdTrGy4DOHn0V
         PwKu3lXllrD3gknsyoI5HiMN1aAmCKhIUS8btJ7oDqh7921/1hGMW9SXVClFQX7cn1Cs
         CEFw==
X-Gm-Message-State: AOAM533eRlHKaa11tFHlMeQIV6GZzEw61cGbKIBWBrUPDVVPpeynes/V
        2/x43WNDz0eviDyipPuBpnHne3gqzjc=
X-Google-Smtp-Source: ABdhPJyrdOaVXVjRy/IEAwGB0753boXhOgLOdQfxZhF5D7vMKbL5heCNyoMiOXcxbZrStTeY/uQATg==
X-Received: by 2002:aa7:c957:: with SMTP id h23mr16000188edt.301.1619680463195;
        Thu, 29 Apr 2021 00:14:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e? ([2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e])
        by smtp.gmail.com with ESMTPSA id x20sm1604570edd.58.2021.04.29.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:14:22 -0700 (PDT)
Subject: Re: [PATCH v5 10/27] drm/amdgpu: Guard against write accesses after
 device removal
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-11-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f67282df-bc1d-495b-2e11-e4e4ee34f6d9@gmail.com>
Date:   Thu, 29 Apr 2021 09:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428151207.1212258-11-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> This should prevent writing to memory or IO ranges possibly
> already allocated for other uses after our device is removed.
>
> v5:
> Protect more places wher memcopy_to/form_io takes place
> Protect IB submissions
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  75 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   9 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        | 228 +++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 115 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  70 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  49 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  31 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  11 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  22 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   7 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  44 ++--
>   drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |   8 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |   8 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  26 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  22 +-
>   .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |   2 +
>   17 files changed, 425 insertions(+), 305 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 91594ddc2459..22b09c4db255 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -71,6 +71,8 @@
>   #include <linux/pm_runtime.h>
>   
>   
> +#include <drm/drm_drv.h>
> +
>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> @@ -279,48 +281,55 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   	unsigned long flags;
>   	uint32_t hi = ~0;
>   	uint64_t last;
> +	int idx;
>   
> +	if (drm_dev_enter(&adev->ddev, &idx)) {

In general I think it would be better to do stuff like this as

if (!drm_dev_enter(...))
     return; /* or goto error_nodev; */

...

drm_dev_exit();

This is essentially error handling and we avoid modifying the whole 
function for adding the prerequisite.

Regards,
Christian.


>   
>   #ifdef CONFIG_64BIT
> -	last = min(pos + size, adev->gmc.visible_vram_size);
> -	if (last > pos) {
> -		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> -		size_t count = last - pos;
> -
> -		if (write) {
> -			memcpy_toio(addr, buf, count);
> -			mb();
> -			amdgpu_asic_flush_hdp(adev, NULL);
> -		} else {
> -			amdgpu_asic_invalidate_hdp(adev, NULL);
> -			mb();
> -			memcpy_fromio(buf, addr, count);
> -		}
> +		last = min(pos + size, adev->gmc.visible_vram_size);
> +		if (last > pos) {
> +			void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> +			size_t count = last - pos;
> +
> +			if (write) {
> +				memcpy_toio(addr, buf, count);
> +				mb();
> +				amdgpu_asic_flush_hdp(adev, NULL);
> +			} else {
> +				amdgpu_asic_invalidate_hdp(adev, NULL);
> +				mb();
> +				memcpy_fromio(buf, addr, count);
> +			}
>   
> -		if (count == size)
> -			return;
> +			if (count == size) {
> +				drm_dev_exit(idx);
> +				return;
> +			}
>   
> -		pos += count;
> -		buf += count / 4;
> -		size -= count;
> -	}
> +			pos += count;
> +			buf += count / 4;
> +			size -= count;
> +		}
>   #endif
>   
> -	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -	for (last = pos + size; pos < last; pos += 4) {
> -		uint32_t tmp = pos >> 31;
> +		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> +		for (last = pos + size; pos < last; pos += 4) {
> +			uint32_t tmp = pos >> 31;
>   
> -		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -		if (tmp != hi) {
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -			hi = tmp;
> +			WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +			if (tmp != hi) {
> +				WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> +				hi = tmp;
> +			}
> +			if (write)
> +				WREG32_NO_KIQ(mmMM_DATA, *buf++);
> +			else
> +				*buf++ = RREG32_NO_KIQ(mmMM_DATA);
>   		}
> -		if (write)
> -			WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -		else
> -			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
> +		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +
> +		drm_dev_exit(idx);
>   	}
> -	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>   
>   /*
> @@ -402,6 +411,7 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>    */
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   {
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> @@ -542,6 +552,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>    */
>   void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   {
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index fe1a39ffda72..1beb4e64b884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -31,6 +31,8 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
>   
> +#include <drm/drm_drv.h>
> +
>   /**
>    * amdgpu_gmc_get_pde_for_bo - get the PDE for a BO
>    *
> @@ -98,6 +100,10 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   {
>   	void __iomem *ptr = (void *)cpu_pt_addr;
>   	uint64_t value;
> +	int idx;
> +
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return 0;
>   
>   	/*
>   	 * The following is for PTE only. GART does not have PDEs.
> @@ -105,6 +111,9 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	value = addr & 0x0000FFFFFFFFF000ULL;
>   	value |= flags;
>   	writeq(value, ptr + (gpu_page_idx * 8));
> +
> +	drm_dev_exit(idx);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7645223ea0ef..b3a1ff04c10f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -31,6 +31,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_debugfs.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "atom.h"
> @@ -138,7 +139,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	bool secure;
>   
>   	unsigned i;
> -	int r = 0;
> +	int idx, r = 0;
>   	bool need_pipe_sync = false;
>   
>   	if (num_ibs == 0)
> @@ -170,142 +171,151 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		return -EINVAL;
>   	}
>   
> -	alloc_size = ring->funcs->emit_frame_size + num_ibs *
> -		ring->funcs->emit_ib_size;
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
>   
> -	r = amdgpu_ring_alloc(ring, alloc_size);
> -	if (r) {
> -		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> -		return r;
> -	}
> -
> -	need_ctx_switch = ring->current_ctx != fence_ctx;
> -	if (ring->funcs->emit_pipeline_sync && job &&
> -	    ((tmp = amdgpu_sync_get_fence(&job->sched_sync)) ||
> -	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
> -	     amdgpu_vm_need_pipeline_sync(ring, job))) {
> -		need_pipe_sync = true;
> -
> -		if (tmp)
> -			trace_amdgpu_ib_pipe_sync(job, tmp);
> -
> -		dma_fence_put(tmp);
> -	}
> +		alloc_size = ring->funcs->emit_frame_size + num_ibs *
> +			ring->funcs->emit_ib_size;
>   
> -	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
> -		ring->funcs->emit_mem_sync(ring);
> +		r = amdgpu_ring_alloc(ring, alloc_size);
> +		if (r) {
> +			dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> +			goto exit;
> +		}
>   
> -	if (ring->funcs->emit_wave_limit &&
> -	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> -		ring->funcs->emit_wave_limit(ring, true);
> +		need_ctx_switch = ring->current_ctx != fence_ctx;
> +		if (ring->funcs->emit_pipeline_sync && job &&
> +		    ((tmp = amdgpu_sync_get_fence(&job->sched_sync)) ||
> +		     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
> +		     amdgpu_vm_need_pipeline_sync(ring, job))) {
> +			need_pipe_sync = true;
>   
> -	if (ring->funcs->insert_start)
> -		ring->funcs->insert_start(ring);
> +			if (tmp)
> +				trace_amdgpu_ib_pipe_sync(job, tmp);
>   
> -	if (job) {
> -		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			return r;
> +			dma_fence_put(tmp);
>   		}
> -	}
>   
> -	if (job && ring->funcs->init_cond_exec)
> -		patch_offset = amdgpu_ring_init_cond_exec(ring);
> +		if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
> +			ring->funcs->emit_mem_sync(ring);
>   
> -#ifdef CONFIG_X86_64
> -	if (!(adev->flags & AMD_IS_APU))
> -#endif
> -	{
> -		if (ring->funcs->emit_hdp_flush)
> -			amdgpu_ring_emit_hdp_flush(ring);
> -		else
> -			amdgpu_asic_flush_hdp(adev, ring);
> -	}
> +		if (ring->funcs->emit_wave_limit &&
> +		    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> +			ring->funcs->emit_wave_limit(ring, true);
>   
> -	if (need_ctx_switch)
> -		status |= AMDGPU_HAVE_CTX_SWITCH;
> +		if (ring->funcs->insert_start)
> +			ring->funcs->insert_start(ring);
>   
> -	skip_preamble = ring->current_ctx == fence_ctx;
> -	if (job && ring->funcs->emit_cntxcntl) {
> -		status |= job->preamble_status;
> -		status |= job->preemption_status;
> -		amdgpu_ring_emit_cntxcntl(ring, status);
> -	}
> +		if (job) {
> +			r = amdgpu_vm_flush(ring, job, need_pipe_sync);
> +			if (r) {
> +				amdgpu_ring_undo(ring);
> +				goto exit;
> +			}
> +		}
>   
> -	/* Setup initial TMZiness and send it off.
> -	 */
> -	secure = false;
> -	if (job && ring->funcs->emit_frame_cntl) {
> -		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
> -		amdgpu_ring_emit_frame_cntl(ring, true, secure);
> -	}
> +		if (job && ring->funcs->init_cond_exec)
> +			patch_offset = amdgpu_ring_init_cond_exec(ring);
> +
> +	#ifdef CONFIG_X86_64
> +		if (!(adev->flags & AMD_IS_APU))
> +	#endif
> +		{
> +			if (ring->funcs->emit_hdp_flush)
> +				amdgpu_ring_emit_hdp_flush(ring);
> +			else
> +				amdgpu_asic_flush_hdp(adev, ring);
> +		}
>   
> -	for (i = 0; i < num_ibs; ++i) {
> -		ib = &ibs[i];
> +		if (need_ctx_switch)
> +			status |= AMDGPU_HAVE_CTX_SWITCH;
>   
> -		/* drop preamble IBs if we don't have a context switch */
> -		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> -		    skip_preamble &&
> -		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> -		    !amdgpu_mcbp &&
> -		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> -			continue;
> +		skip_preamble = ring->current_ctx == fence_ctx;
> +		if (job && ring->funcs->emit_cntxcntl) {
> +			status |= job->preamble_status;
> +			status |= job->preemption_status;
> +			amdgpu_ring_emit_cntxcntl(ring, status);
> +		}
>   
> +		/* Setup initial TMZiness and send it off.
> +		 */
> +		secure = false;
>   		if (job && ring->funcs->emit_frame_cntl) {
> -			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> -				amdgpu_ring_emit_frame_cntl(ring, false, secure);
> -				secure = !secure;
> -				amdgpu_ring_emit_frame_cntl(ring, true, secure);
> +			secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
> +			amdgpu_ring_emit_frame_cntl(ring, true, secure);
> +		}
> +
> +		for (i = 0; i < num_ibs; ++i) {
> +			ib = &ibs[i];
> +
> +			/* drop preamble IBs if we don't have a context switch */
> +			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +			    skip_preamble &&
> +			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> +			    !amdgpu_mcbp &&
> +			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> +				continue;
> +
> +			if (job && ring->funcs->emit_frame_cntl) {
> +				if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> +					amdgpu_ring_emit_frame_cntl(ring, false, secure);
> +					secure = !secure;
> +					amdgpu_ring_emit_frame_cntl(ring, true, secure);
> +				}
>   			}
> +
> +			amdgpu_ring_emit_ib(ring, job, ib, status);
> +			status &= ~AMDGPU_HAVE_CTX_SWITCH;
>   		}
>   
> -		amdgpu_ring_emit_ib(ring, job, ib, status);
> -		status &= ~AMDGPU_HAVE_CTX_SWITCH;
> -	}
> +		if (job && ring->funcs->emit_frame_cntl)
> +			amdgpu_ring_emit_frame_cntl(ring, false, secure);
>   
> -	if (job && ring->funcs->emit_frame_cntl)
> -		amdgpu_ring_emit_frame_cntl(ring, false, secure);
> +	#ifdef CONFIG_X86_64
> +		if (!(adev->flags & AMD_IS_APU))
> +	#endif
> +			amdgpu_asic_invalidate_hdp(adev, ring);
>   
> -#ifdef CONFIG_X86_64
> -	if (!(adev->flags & AMD_IS_APU))
> -#endif
> -		amdgpu_asic_invalidate_hdp(adev, ring);
> +		if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
> +			fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
>   
> -	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
> -		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +		/* wrap the last IB with fence */
> +		if (job && job->uf_addr) {
> +			amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
> +					       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> +		}
>   
> -	/* wrap the last IB with fence */
> -	if (job && job->uf_addr) {
> -		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
> -				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> -	}
> +		r = amdgpu_fence_emit(ring, f, fence_flags);
> +		if (r) {
> +			dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> +			if (job && job->vmid)
> +				amdgpu_vmid_reset(adev, ring->funcs->vmhub, job->vmid);
> +			amdgpu_ring_undo(ring);
> +			goto exit;
> +		}
>   
> -	r = amdgpu_fence_emit(ring, f, fence_flags);
> -	if (r) {
> -		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> -		if (job && job->vmid)
> -			amdgpu_vmid_reset(adev, ring->funcs->vmhub, job->vmid);
> -		amdgpu_ring_undo(ring);
> -		return r;
> -	}
> +		if (ring->funcs->insert_end)
> +			ring->funcs->insert_end(ring);
>   
> -	if (ring->funcs->insert_end)
> -		ring->funcs->insert_end(ring);
> +		if (patch_offset != ~0 && ring->funcs->patch_cond_exec)
> +			amdgpu_ring_patch_cond_exec(ring, patch_offset);
>   
> -	if (patch_offset != ~0 && ring->funcs->patch_cond_exec)
> -		amdgpu_ring_patch_cond_exec(ring, patch_offset);
> +		ring->current_ctx = fence_ctx;
> +		if (vm && ring->funcs->emit_switch_buffer)
> +			amdgpu_ring_emit_switch_buffer(ring);
>   
> -	ring->current_ctx = fence_ctx;
> -	if (vm && ring->funcs->emit_switch_buffer)
> -		amdgpu_ring_emit_switch_buffer(ring);
> +		if (ring->funcs->emit_wave_limit &&
> +		    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> +			ring->funcs->emit_wave_limit(ring, false);
>   
> -	if (ring->funcs->emit_wave_limit &&
> -	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> -		ring->funcs->emit_wave_limit(ring, false);
> +		amdgpu_ring_commit(ring);
>   
> -	amdgpu_ring_commit(ring);
> -	return 0;
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +exit:
> +	drm_dev_exit(idx);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 839917eb7bc3..638b7fd1857c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -25,6 +25,7 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/dma-mapping.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_psp.h"
> @@ -38,6 +39,8 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_securedisplay.h"
>   
> +#include <drm/drm_drv.h>
> +
>   static int psp_sysfs_init(struct amdgpu_device *adev);
>   static void psp_sysfs_fini(struct amdgpu_device *adev);
>   
> @@ -249,7 +252,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
>   {
>   	int ret;
> -	int index;
> +	int index, idx;
>   	int timeout = 20000;
>   	bool ras_intr = false;
>   	bool skip_unsupport = false;
> @@ -257,6 +260,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	if (psp->adev->in_pci_err_recovery)
>   		return 0;
>   
> +	if (!drm_dev_enter(&psp->adev->ddev, &idx))
> +		return 0;
> +
>   	mutex_lock(&psp->mutex);
>   
>   	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> @@ -267,8 +273,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr, fence_mc_addr, index);
>   	if (ret) {
>   		atomic_dec(&psp->fence_value);
> -		mutex_unlock(&psp->mutex);
> -		return ret;
> +		goto exit;
>   	}
>   
>   	amdgpu_asic_invalidate_hdp(psp->adev, NULL);
> @@ -308,8 +313,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   			 psp->cmd_buf_mem->cmd_id,
>   			 psp->cmd_buf_mem->resp.status);
>   		if (!timeout) {
> -			mutex_unlock(&psp->mutex);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto exit;
>   		}
>   	}
>   
> @@ -317,8 +322,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   		ucode->tmr_mc_addr_lo = psp->cmd_buf_mem->resp.fw_addr_lo;
>   		ucode->tmr_mc_addr_hi = psp->cmd_buf_mem->resp.fw_addr_hi;
>   	}
> -	mutex_unlock(&psp->mutex);
>   
> +exit:
> +	mutex_unlock(&psp->mutex);
> +	drm_dev_exit(idx);
>   	return ret;
>   }
>   
> @@ -355,8 +362,7 @@ static int psp_load_toc(struct psp_context *psp,
>   	if (!cmd)
>   		return -ENOMEM;
>   	/* Copy toc to psp firmware private buffer */
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->toc_start_addr, psp->toc_bin_size);
> +	psp_copy_fw(psp, psp->toc_start_addr, psp->toc_bin_size);
>   
>   	psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp->toc_bin_size);
>   
> @@ -571,8 +577,7 @@ static int psp_asd_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->asd_start_addr, psp->asd_ucode_size);
> +	psp_copy_fw(psp, psp->asd_start_addr, psp->asd_ucode_size);
>   
>   	psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
>   				  psp->asd_ucode_size);
> @@ -727,8 +732,7 @@ static int psp_xgmi_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->ta_xgmi_start_addr, psp->ta_xgmi_ucode_size);
> +	psp_copy_fw(psp, psp->ta_xgmi_start_addr, psp->ta_xgmi_ucode_size);
>   
>   	psp_prep_ta_load_cmd_buf(cmd,
>   				 psp->fw_pri_mc_addr,
> @@ -983,8 +987,7 @@ static int psp_ras_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->ta_ras_start_addr, psp->ta_ras_ucode_size);
> +	psp_copy_fw(psp, psp->ta_ras_start_addr, psp->ta_ras_ucode_size);
>   
>   	psp_prep_ta_load_cmd_buf(cmd,
>   				 psp->fw_pri_mc_addr,
> @@ -1220,8 +1223,7 @@ static int psp_hdcp_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->ta_hdcp_start_addr,
> +	psp_copy_fw(psp, psp->ta_hdcp_start_addr,
>   	       psp->ta_hdcp_ucode_size);
>   
>   	psp_prep_ta_load_cmd_buf(cmd,
> @@ -1372,8 +1374,7 @@ static int psp_dtm_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->ta_dtm_start_addr, psp->ta_dtm_ucode_size);
> +	psp_copy_fw(psp, psp->ta_dtm_start_addr, psp->ta_dtm_ucode_size);
>   
>   	psp_prep_ta_load_cmd_buf(cmd,
>   				 psp->fw_pri_mc_addr,
> @@ -1518,8 +1519,7 @@ static int psp_rap_load(struct psp_context *psp)
>   	if (!cmd)
>   		return -ENOMEM;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -	memcpy(psp->fw_pri_buf, psp->ta_rap_start_addr, psp->ta_rap_ucode_size);
> +	psp_copy_fw(psp, psp->ta_rap_start_addr, psp->ta_rap_ucode_size);
>   
>   	psp_prep_ta_load_cmd_buf(cmd,
>   				 psp->fw_pri_mc_addr,
> @@ -2928,7 +2928,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	void *cpu_addr;
>   	dma_addr_t dma_addr;
> -	int ret;
> +	int ret, idx;
>   	char fw_name[100];
>   	const struct firmware *usbc_pd_fw;
>   
> @@ -2937,47 +2937,66 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>   		return -EBUSY;
>   	}
>   
> -	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> -	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> -	if (ret)
> -		goto fail;
> +	if (drm_dev_enter(ddev, &idx)) {
>   
> -	/* We need contiguous physical mem to place the FW  for psp to access */
> -	cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
> +		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> +		ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> +		if (ret)
> +			goto fail;
>   
> -	ret = dma_mapping_error(adev->dev, dma_addr);
> -	if (ret)
> -		goto rel_buf;
> +		/* We need contiguous physical mem to place the FW  for psp to access */
> +		cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
>   
> -	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> +		ret = dma_mapping_error(adev->dev, dma_addr);
> +		if (ret)
> +			goto rel_buf;
>   
> -	/*
> -	 * x86 specific workaround.
> -	 * Without it the buffer is invisible in PSP.
> -	 *
> -	 * TODO Remove once PSP starts snooping CPU cache
> -	 */
> +		memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> +
> +		/*
> +		 * x86 specific workaround.
> +		 * Without it the buffer is invisible in PSP.
> +		 *
> +		 * TODO Remove once PSP starts snooping CPU cache
> +		 */
>   #ifdef CONFIG_X86
> -	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
> +		clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
>   #endif
>   
> -	mutex_lock(&adev->psp.mutex);
> -	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
> -	mutex_unlock(&adev->psp.mutex);
> +		mutex_lock(&adev->psp.mutex);
> +		ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
> +		mutex_unlock(&adev->psp.mutex);
>   
>   rel_buf:
> -	dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
> -	release_firmware(usbc_pd_fw);
> -
> +		dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
> +		release_firmware(usbc_pd_fw);
>   fail:
> -	if (ret) {
> -		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
> -		return ret;
> +		if (ret) {
> +			DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
> +			return ret;
> +		}
> +
> +		drm_dev_exit(idx);
> +		return count;
> +	} else {
> +		return -ENODEV;
>   	}
> +}
> +
> +void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
> +{
> +	int idx;
>   
> -	return count;
> +	if (!drm_dev_enter(&psp->adev->ddev, &idx))
> +		return;
> +
> +	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> +	memcpy(psp->fw_pri_buf, start_addr, bin_size);
> +
> +	drm_dev_exit(idx);
>   }
>   
> +
>   static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
>   		   psp_usbc_pd_fw_sysfs_read,
>   		   psp_usbc_pd_fw_sysfs_write);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index cb50ba445f8c..0dbbedb84c84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -417,4 +417,7 @@ int psp_init_ta_microcode(struct psp_context *psp,
>   			  const char *chip_name);
>   int psp_get_fw_attestation_records_addr(struct psp_context *psp,
>   					uint64_t *output_ptr);
> +
> +void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b644c78475fd..f9f71008f454 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -35,6 +35,8 @@
>   #include "amdgpu.h"
>   #include "atom.h"
>   
> +#include <drm/drm_drv.h>
> +
>   /*
>    * Rings
>    * Most engines on the GPU are fed via ring buffers.  Ring
> @@ -459,3 +461,71 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>   	ring->sched.ready = !r;
>   	return r;
>   }
> +
> +void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
> +{
> +	int idx;
> +	int i = 0;
> +
> +	if (!drm_dev_enter(&ring->adev->ddev, &idx))
> +		return;
> +
> +	while (i <= ring->buf_mask)
> +		ring->ring[i++] = ring->funcs->nop;
> +
> +	drm_dev_exit(idx);
> +
> +}
> +
> +void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
> +{
> +	int idx;
> +
> +	if (!drm_dev_enter(&ring->adev->ddev, &idx))
> +		return;
> +
> +	if (ring->count_dw <= 0)
> +		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> +	ring->ring[ring->wptr++ & ring->buf_mask] = v;
> +	ring->wptr &= ring->ptr_mask;
> +	ring->count_dw--;
> +
> +	drm_dev_exit(idx);
> +}
> +
> +void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
> +					      void *src, int count_dw)
> +{
> +	unsigned occupied, chunk1, chunk2;
> +	void *dst;
> +	int idx;
> +
> +	if (!drm_dev_enter(&ring->adev->ddev, &idx))
> +		return;
> +
> +	if (unlikely(ring->count_dw < count_dw))
> +		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> +
> +	occupied = ring->wptr & ring->buf_mask;
> +	dst = (void *)&ring->ring[occupied];
> +	chunk1 = ring->buf_mask + 1 - occupied;
> +	chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
> +	chunk2 = count_dw - chunk1;
> +	chunk1 <<= 2;
> +	chunk2 <<= 2;
> +
> +	if (chunk1)
> +		memcpy(dst, src, chunk1);
> +
> +	if (chunk2) {
> +		src += chunk1;
> +		dst = (void *)ring->ring;
> +		memcpy(dst, src, chunk2);
> +	}
> +
> +	ring->wptr += count_dw;
> +	ring->wptr &= ring->ptr_mask;
> +	ring->count_dw -= count_dw;
> +
> +	drm_dev_exit(idx);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 0f195f7bf797..c2b83f48e6d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,53 +297,12 @@ static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
>   	*ring->cond_exe_cpu_addr = cond_exec;
>   }
>   
> -static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
> -{
> -	int i = 0;
> -	while (i <= ring->buf_mask)
> -		ring->ring[i++] = ring->funcs->nop;
> -
> -}
> -
> -static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
> -{
> -	if (ring->count_dw <= 0)
> -		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> -	ring->ring[ring->wptr++ & ring->buf_mask] = v;
> -	ring->wptr &= ring->ptr_mask;
> -	ring->count_dw--;
> -}
> +void amdgpu_ring_clear_ring(struct amdgpu_ring *ring);
>   
> -static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
> -					      void *src, int count_dw)
> -{
> -	unsigned occupied, chunk1, chunk2;
> -	void *dst;
> -
> -	if (unlikely(ring->count_dw < count_dw))
> -		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> -
> -	occupied = ring->wptr & ring->buf_mask;
> -	dst = (void *)&ring->ring[occupied];
> -	chunk1 = ring->buf_mask + 1 - occupied;
> -	chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
> -	chunk2 = count_dw - chunk1;
> -	chunk1 <<= 2;
> -	chunk2 <<= 2;
> +void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v);
>   
> -	if (chunk1)
> -		memcpy(dst, src, chunk1);
> -
> -	if (chunk2) {
> -		src += chunk1;
> -		dst = (void *)ring->ring;
> -		memcpy(dst, src, chunk2);
> -	}
> -
> -	ring->wptr += count_dw;
> -	ring->wptr &= ring->ptr_mask;
> -	ring->count_dw -= count_dw;
> -}
> +void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
> +					      void *src, int count_dw);
>   
>   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index e2ed4689118a..df47f5ffa08f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -32,6 +32,7 @@
>   #include <linux/module.h>
>   
>   #include <drm/drm.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -375,7 +376,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   	void *ptr;
> -	int i, j;
> +	int i, j, idx;
>   	bool in_ras_intr = amdgpu_ras_intr_triggered();
>   
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
> @@ -403,11 +404,15 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>   		if (!adev->uvd.inst[j].saved_bo)
>   			return -ENOMEM;
>   
> -		/* re-write 0 since err_event_athub will corrupt VCPU buffer */
> -		if (in_ras_intr)
> -			memset(adev->uvd.inst[j].saved_bo, 0, size);
> -		else
> -			memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
> +		if (drm_dev_enter(&adev->ddev, &idx)) {
> +			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
> +			if (in_ras_intr)
> +				memset(adev->uvd.inst[j].saved_bo, 0, size);
> +			else
> +				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
> +
> +			drm_dev_exit(idx);
> +		}
>   	}
>   
>   	if (in_ras_intr)
> @@ -420,7 +425,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   	void *ptr;
> -	int i;
> +	int i, idx;
>   
>   	for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
>   		if (adev->uvd.harvest_config & (1 << i))
> @@ -432,7 +437,10 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   		ptr = adev->uvd.inst[i].cpu_addr;
>   
>   		if (adev->uvd.inst[i].saved_bo != NULL) {
> -			memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> +			if (drm_dev_enter(&adev->ddev, &idx)) {
> +				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> +				drm_dev_exit(idx);
> +			}
>   			kvfree(adev->uvd.inst[i].saved_bo);
>   			adev->uvd.inst[i].saved_bo = NULL;
>   		} else {
> @@ -442,8 +450,11 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
>   			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
> -					    le32_to_cpu(hdr->ucode_size_bytes));
> +				if (drm_dev_enter(&adev->ddev, &idx)) {
> +					memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
> +						    le32_to_cpu(hdr->ucode_size_bytes));
> +					drm_dev_exit(idx);
> +				}
>   				size -= le32_to_cpu(hdr->ucode_size_bytes);
>   				ptr += le32_to_cpu(hdr->ucode_size_bytes);
>   			}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index ea6a62f67e38..833203401ef4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -29,6 +29,7 @@
>   #include <linux/module.h>
>   
>   #include <drm/drm.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -293,7 +294,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>   	void *cpu_addr;
>   	const struct common_firmware_header *hdr;
>   	unsigned offset;
> -	int r;
> +	int r, idx;
>   
>   	if (adev->vce.vcpu_bo == NULL)
>   		return -EINVAL;
> @@ -313,8 +314,12 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>   
>   	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
>   	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -	memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> -		    adev->vce.fw->size - offset);
> +
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> +			    adev->vce.fw->size - offset);
> +		drm_dev_exit(idx);
> +	}
>   
>   	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 99b82f3c2617..b42db22761b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -27,6 +27,7 @@
>   #include <linux/firmware.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -267,7 +268,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   	void *ptr;
> -	int i;
> +	int i, idx;
>   
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> @@ -284,7 +285,10 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   		if (!adev->vcn.inst[i].saved_bo)
>   			return -ENOMEM;
>   
> -		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> +		if (drm_dev_enter(&adev->ddev, &idx)) {
> +			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> +			drm_dev_exit(idx);
> +		}
>   	}
>   	return 0;
>   }
> @@ -293,7 +297,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   	void *ptr;
> -	int i;
> +	int i, idx;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
> @@ -305,7 +309,10 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   		ptr = adev->vcn.inst[i].cpu_addr;
>   
>   		if (adev->vcn.inst[i].saved_bo != NULL) {
> -			memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> +			if (drm_dev_enter(&adev->ddev, &idx)) {
> +				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> +				drm_dev_exit(idx);
> +			}
>   			kvfree(adev->vcn.inst[i].saved_bo);
>   			adev->vcn.inst[i].saved_bo = NULL;
>   		} else {
> @@ -315,8 +322,11 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
>   			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
> -					    le32_to_cpu(hdr->ucode_size_bytes));
> +				if (drm_dev_enter(&adev->ddev, &idx)) {
> +					memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
> +						    le32_to_cpu(hdr->ucode_size_bytes));
> +					drm_dev_exit(idx);
> +				}
>   				size -= le32_to_cpu(hdr->ucode_size_bytes);
>   				ptr += le32_to_cpu(hdr->ucode_size_bytes);
>   			}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ae18c0e32347..7b622056df58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -31,6 +31,7 @@
>   #include <linux/dma-buf.h>
>   
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> @@ -1604,7 +1605,10 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	struct amdgpu_vm_update_params params;
>   	enum amdgpu_sync_mode sync_mode;
>   	uint64_t pfn;
> -	int r;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return -ENODEV;
>   
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
> @@ -1713,6 +1717,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
> +	drm_dev_exit(idx);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index c325d6f53a71..94cce172b98e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -23,6 +23,7 @@
>   #include <linux/firmware.h>
>   #include <linux/module.h>
>   #include <linux/vmalloc.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_psp.h"
> @@ -269,10 +270,8 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy PSP KDB binary to memory */
> -	memcpy(psp->fw_pri_buf, psp->kdb_start_addr, psp->kdb_bin_size);
> +	psp_copy_fw(psp, psp->kdb_start_addr, psp->kdb_bin_size);
>   
>   	/* Provide the PSP KDB to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -302,10 +301,8 @@ static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy PSP SPL binary to memory */
> -	memcpy(psp->fw_pri_buf, psp->spl_start_addr, psp->spl_bin_size);
> +	psp_copy_fw(psp, psp->spl_start_addr, psp->spl_bin_size);
>   
>   	/* Provide the PSP SPL to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -335,10 +332,8 @@ static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy PSP System Driver binary to memory */
> -	memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> +	psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
>   
>   	/* Provide the sys driver to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -371,10 +366,8 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy Secure OS binary to PSP memory */
> -	memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> +	psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
>   
>   	/* Provide the PSP secure OS to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -608,7 +601,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   	uint32_t p2c_header[4];
>   	uint32_t sz;
>   	void *buf;
> -	int ret;
> +	int ret, idx;
>   
>   	if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
>   		DRM_DEBUG("Memory training is not supported.\n");
> @@ -681,17 +674,24 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   			return -ENOMEM;
>   		}
>   
> -		memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> -		ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
> -		if (ret) {
> -			DRM_ERROR("Send long training msg failed.\n");
> +		if (drm_dev_enter(&adev->ddev, &idx)) {
> +			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> +			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
> +			if (ret) {
> +				DRM_ERROR("Send long training msg failed.\n");
> +				vfree(buf);
> +				drm_dev_exit(idx);
> +				return ret;
> +			}
> +
> +			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +			adev->hdp.funcs->flush_hdp(adev, NULL);
>   			vfree(buf);
> -			return ret;
> +			drm_dev_exit(idx);
> +		} else {
> +			vfree(buf);
> +			return -ENODEV;
>   		}
> -
> -		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> -		adev->hdp.funcs->flush_hdp(adev, NULL);
> -		vfree(buf);
>   	}
>   
>   	if (ops & PSP_MEM_TRAIN_SAVE) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index c4828bd3264b..618e5b6b85d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -138,10 +138,8 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy PSP System Driver binary to memory */
> -	memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> +	psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
>   
>   	/* Provide the sys driver to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -179,10 +177,8 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy Secure OS binary to PSP memory */
> -	memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> +	psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
>   
>   	/* Provide the PSP secure OS to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> index f2e725f72d2f..d0a6cccd0897 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -102,10 +102,8 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy PSP System Driver binary to memory */
> -	memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
> +	psp_copy_fw(psp, psp->sys_start_addr, psp->sys_bin_size);
>   
>   	/* Provide the sys driver to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> @@ -143,10 +141,8 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
>   	if (ret)
>   		return ret;
>   
> -	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
>   	/* Copy Secure OS binary to PSP memory */
> -	memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
> +	psp_copy_fw(psp, psp->sos_start_addr, psp->sos_bin_size);
>   
>   	/* Provide the PSP secure OS to bootloader */
>   	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 37fa163393fd..fd859c778df0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -25,6 +25,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vce.h"
> @@ -555,16 +556,19 @@ static int vce_v4_0_hw_fini(void *handle)
>   static int vce_v4_0_suspend(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int r;
> +	int r, idx;
>   
>   	if (adev->vce.vcpu_bo == NULL)
>   		return 0;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -		void *ptr = adev->vce.cpu_addr;
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> +			void *ptr = adev->vce.cpu_addr;
>   
> -		memcpy_fromio(adev->vce.saved_bo, ptr, size);
> +			memcpy_fromio(adev->vce.saved_bo, ptr, size);
> +		}
> +		drm_dev_exit(idx);
>   	}
>   
>   	r = vce_v4_0_hw_fini(adev);
> @@ -577,16 +581,20 @@ static int vce_v4_0_suspend(void *handle)
>   static int vce_v4_0_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int r;
> +	int r, idx;
>   
>   	if (adev->vce.vcpu_bo == NULL)
>   		return -EINVAL;
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -		void *ptr = adev->vce.cpu_addr;
>   
> -		memcpy_toio(ptr, adev->vce.saved_bo, size);
> +		if (drm_dev_enter(&adev->ddev, &idx)) {
> +			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> +			void *ptr = adev->vce.cpu_addr;
> +
> +			memcpy_toio(ptr, adev->vce.saved_bo, size);
> +			drm_dev_exit(idx);
> +		}
>   	} else {
>   		r = amdgpu_vce_resume(adev);
>   		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index def583916294..5ac8ffe197aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -34,6 +34,8 @@
>   #include "vcn/vcn_3_0_0_sh_mask.h"
>   #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
>   
> +#include <drm/drm_drv.h>
> +
>   #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
>   #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
>   #define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET			0x10
> @@ -263,16 +265,20 @@ static int vcn_v3_0_sw_init(void *handle)
>   static int vcn_v3_0_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int i, r;
> +	int i, r, idx;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		volatile struct amdgpu_fw_shared *fw_shared;
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_fw_shared *fw_shared;
>   
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sw_ring.is_enabled = false;
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sw_ring.is_enabled = false;
> +		}
> +
> +		drm_dev_exit(idx);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index aae25243eb10..d628b91846c9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -405,6 +405,8 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
>   				UCODE_ID_MEC_STORAGE, &toc->entry[toc->num_entries++]),
>   				"Failed to Get Firmware Entry.", r = -EINVAL; goto failed);
>   	}
> +
> +	/* AG TODO Can't call drm_dev_enter/exit because access adev->ddev here ... */
>   	memcpy_toio(smu_data->header_buffer.kaddr, smu_data->toc,
>   		    sizeof(struct SMU_DRAMData_TOC));
>   	smum_send_msg_to_smc_with_parameter(hwmgr,

