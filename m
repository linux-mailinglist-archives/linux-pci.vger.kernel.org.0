Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52BE242A6
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfETVTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 17:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfETVTf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 May 2019 17:19:35 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E5C216B7;
        Mon, 20 May 2019 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558387174;
        bh=nxe0kbIuLKT/xy3J74NILjx7UDLG36T7kPJSCiqfvp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRjZjA5X5K1lb6sP8jtqhu8V2TF1EwxkHF5G/ML9b/wRzNQJjTF84E3i1oaP2VjVi
         G+xExagQXRTvTkx3Ya+wq29mEdk57VWbMBfKlqCQSB1d+q3LqpPgyhHLxGt9KQtckb
         5YB1SLQPGEUPzM0/QYOWYL5NQYYRLj7hxav4iUls=
Date:   Mon, 20 May 2019 16:19:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] pci: save the boot pcie link speed and restore it
 on fini
Message-ID: <20190520211933.GA57618@google.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
 <20190507201245.9295-5-kherbst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507201245.9295-5-kherbst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 10:12:45PM +0200, Karol Herbst wrote:
> Apperantly things go south if we suspend the device with a different PCIE
> link speed set than it got booted with. Fixes runtime suspend on my gp107.
> 
> This all looks like some bug inside the pci subsystem and I would prefer a
> fix there instead of nouveau, but maybe there is no real nice way of doing
> that outside of drivers?

I agree it would be nice to fix this in the PCI core if that's
feasible.

It looks like this driver changes the PCIe link speed using some
device-specific mechanism.  When we suspend, we put the device in
D3cold, so it loses all its state.  When we resume, the link probably
comes up at the boot speed because nothing did that device-specific
magic to change it, so you probably end up with the link being slow
but the driver thinking it's configured to be fast, and maybe that
combination doesn't work.

If it requires something device-specific to change that link speed, I
don't know how to put that in the PCI core.  But maybe I'm missing
something?

Per the PCIe spec (r4.0, sec 1.2):

  Initialization – During hardware initialization, each PCI Express
  Link is set up following a negotiation of Lane widths and frequency
  of operation by the two agents at each end of the Link. No firmware
  or operating system software is involved.

I have been assuming that this means device-specific link speed
management is out of spec, but it seems pretty common that devices
don't come up by themselves at the fastest possible link speed.  So
maybe the spec just intends that devices can operate at *some* valid
speed.

> v2: squashed together patch 4 and 5
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> ---
>  drm/nouveau/include/nvkm/subdev/pci.h |  5 +++--
>  drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++++++--
>  drm/nouveau/nvkm/subdev/pci/pcie.c    | 24 ++++++++++++++++++++----
>  drm/nouveau/nvkm/subdev/pci/priv.h    |  2 ++
>  4 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
> index 1fdf3098..b23793a2 100644
> --- a/drm/nouveau/include/nvkm/subdev/pci.h
> +++ b/drm/nouveau/include/nvkm/subdev/pci.h
> @@ -26,8 +26,9 @@ struct nvkm_pci {
>  	} agp;
>  
>  	struct {
> -		enum nvkm_pcie_speed speed;
> -		u8 width;
> +		enum nvkm_pcie_speed cur_speed;
> +		enum nvkm_pcie_speed def_speed;
> +		u8 cur_width;
>  	} pcie;
>  
>  	bool msi;
> diff --git a/drm/nouveau/nvkm/subdev/pci/base.c b/drm/nouveau/nvkm/subdev/pci/base.c
> index ee2431a7..d9fb5a83 100644
> --- a/drm/nouveau/nvkm/subdev/pci/base.c
> +++ b/drm/nouveau/nvkm/subdev/pci/base.c
> @@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
>  
>  	if (pci->agp.bridge)
>  		nvkm_agp_fini(pci);
> +	else if (pci_is_pcie(pci->pdev))
> +		nvkm_pcie_fini(pci);
>  
>  	return 0;
>  }
> @@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
>  	struct nvkm_pci *pci = nvkm_pci(subdev);
>  	if (pci->agp.bridge)
>  		nvkm_agp_preinit(pci);
> +	else if (pci_is_pcie(pci->pdev))
> +		nvkm_pcie_preinit(pci);
>  	return 0;
>  }
>  
> @@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
>  	pci->func = func;
>  	pci->pdev = device->func->pci(device)->pdev;
>  	pci->irq = -1;
> -	pci->pcie.speed = -1;
> -	pci->pcie.width = -1;
> +	pci->pcie.cur_speed = -1;
> +	pci->pcie.def_speed = -1;
> +	pci->pcie.cur_width = -1;
>  
>  	if (device->type == NVKM_DEVICE_AGP)
>  		nvkm_agp_ctor(pci);
> diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
> index 70ccbe0d..731dd30e 100644
> --- a/drm/nouveau/nvkm/subdev/pci/pcie.c
> +++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
> @@ -85,6 +85,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
>  	return 0;
>  }
>  
> +int
> +nvkm_pcie_preinit(struct nvkm_pci *pci)
> +{
> +	pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
> +	return 0;
> +}
> +
>  int
>  nvkm_pcie_init(struct nvkm_pci *pci)
>  {
> @@ -105,12 +112,21 @@ nvkm_pcie_init(struct nvkm_pci *pci)
>  	if (pci->func->pcie.init)
>  		pci->func->pcie.init(pci);
>  
> -	if (pci->pcie.speed != -1)
> -		nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
> +	if (pci->pcie.cur_speed != -1)
> +		nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
> +				   pci->pcie.cur_width);
>  
>  	return 0;
>  }
>  
> +int
> +nvkm_pcie_fini(struct nvkm_pci *pci)
> +{
> +	if (!IS_ERR_VALUE(pci->pcie.def_speed))
> +		return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16);
> +	return 0;
> +}
> +
>  int
>  nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
>  {
> @@ -146,8 +162,8 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
>  		speed = max_speed;
>  	}
>  
> -	pci->pcie.speed = speed;
> -	pci->pcie.width = width;
> +	pci->pcie.cur_speed = speed;
> +	pci->pcie.cur_width = width;
>  
>  	if (speed == cur_speed) {
>  		nvkm_debug(subdev, "requested matches current speed\n");
> diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
> index a0d4c007..e7744671 100644
> --- a/drm/nouveau/nvkm/subdev/pci/priv.h
> +++ b/drm/nouveau/nvkm/subdev/pci/priv.h
> @@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
>  int gk104_pcie_version_supported(struct nvkm_pci *);
>  
>  int nvkm_pcie_oneinit(struct nvkm_pci *);
> +int nvkm_pcie_preinit(struct nvkm_pci *);
>  int nvkm_pcie_init(struct nvkm_pci *);
> +int nvkm_pcie_fini(struct nvkm_pci *);
>  #endif
> -- 
> 2.21.0
> 
