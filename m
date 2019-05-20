Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2EA242D1
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfETVZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 17:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfETVZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 May 2019 17:25:53 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF19521479;
        Mon, 20 May 2019 21:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558387552;
        bh=EZgkni4DNO+ASMOiX5iJl6LI+25MQk7l1ObGY1mpLHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTkS+RwwjRYacnPZQmzKI9AzE3NacNhpyJ2BjzgoKeGJQrbV3AJAQZ7EEkg3oPKGA
         yyQMGFJqhT6mjrAsYyhEfgqEHETALgUMllknELORmjojbdvlmAvvkHXTC9q/ifH4i5
         SAJaGgonbYn0cmR+x82Um5n/AMPLIiTINOPOKLig=
Date:   Mon, 20 May 2019 16:25:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pci: enable pcie link changes for pascal
Message-ID: <20190520212551.GB57618@google.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
 <20190507201245.9295-3-kherbst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507201245.9295-3-kherbst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 10:12:43PM +0200, Karol Herbst wrote:
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> ---
>  drm/nouveau/nvkm/subdev/pci/gk104.c |  8 ++++----
>  drm/nouveau/nvkm/subdev/pci/gp100.c | 10 ++++++++++
>  drm/nouveau/nvkm/subdev/pci/priv.h  |  5 +++++
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drm/nouveau/nvkm/subdev/pci/gk104.c b/drm/nouveau/nvkm/subdev/pci/gk104.c
> index e6803050..66489018 100644
> --- a/drm/nouveau/nvkm/subdev/pci/gk104.c
> +++ b/drm/nouveau/nvkm/subdev/pci/gk104.c
> @@ -23,7 +23,7 @@
>   */
>  #include "priv.h"
>  
> -static int
> +int
>  gk104_pcie_version_supported(struct nvkm_pci *pci)
>  {
>  	return (nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x4) == 0x4 ? 2 : 1;
> @@ -108,7 +108,7 @@ gk104_pcie_lnkctl_speed(struct nvkm_pci *pci)
>  	return -1;
>  }
>  
> -static enum nvkm_pcie_speed
> +enum nvkm_pcie_speed
>  gk104_pcie_max_speed(struct nvkm_pci *pci)
>  {
>  	u32 max_speed = nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x300000;

Some of this looks pretty similar to the PCI core code that reads
PCI_EXP_LNKSTA to find the link speed (but admittedly there's not
really a good interface to do that unless bus->cur_bus_speed already
has what you need).

It doesn't look like this is directly reading the PCI_EXP_LNKSTA from
PCI config space; maybe it's reading a mirror of that via a
device-specific MMIO address, or maybe it's reading something else
completely.

But it makes me wonder if there's a way to make generic PCI core
interfaces for some of this stuff.

> @@ -146,7 +146,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum nvkm_pcie_speed speed)
>  	nvkm_mask(device, 0x8c040, 0x1, 0x1);
>  }
>  
> -static int
> +int
>  gk104_pcie_init(struct nvkm_pci * pci)
>  {
>  	enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
> @@ -178,7 +178,7 @@ gk104_pcie_init(struct nvkm_pci * pci)
>  	return 0;
>  }
>  
> -static int
> +int
>  gk104_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
>  {
>  	struct nvkm_subdev *subdev = &pci->subdev;
> diff --git a/drm/nouveau/nvkm/subdev/pci/gp100.c b/drm/nouveau/nvkm/subdev/pci/gp100.c
> index 82c5234a..eb19c7a4 100644
> --- a/drm/nouveau/nvkm/subdev/pci/gp100.c
> +++ b/drm/nouveau/nvkm/subdev/pci/gp100.c
> @@ -35,6 +35,16 @@ gp100_pci_func = {
>  	.wr08 = nv40_pci_wr08,
>  	.wr32 = nv40_pci_wr32,
>  	.msi_rearm = gp100_pci_msi_rearm,
> +
> +	.pcie.init = gk104_pcie_init,
> +	.pcie.set_link = gk104_pcie_set_link,
> +
> +	.pcie.max_speed = gk104_pcie_max_speed,
> +	.pcie.cur_speed = g84_pcie_cur_speed,
> +
> +	.pcie.set_version = gf100_pcie_set_version,
> +	.pcie.version = gf100_pcie_version,
> +	.pcie.version_supported = gk104_pcie_version_supported,
>  };
>  
>  int
> diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
> index c17f6063..a0d4c007 100644
> --- a/drm/nouveau/nvkm/subdev/pci/priv.h
> +++ b/drm/nouveau/nvkm/subdev/pci/priv.h
> @@ -54,6 +54,11 @@ int gf100_pcie_cap_speed(struct nvkm_pci *);
>  int gf100_pcie_init(struct nvkm_pci *);
>  int gf100_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8);
>  
> +int gk104_pcie_init(struct nvkm_pci *);
> +int gk104_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
> +enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
> +int gk104_pcie_version_supported(struct nvkm_pci *);
> +
>  int nvkm_pcie_oneinit(struct nvkm_pci *);
>  int nvkm_pcie_init(struct nvkm_pci *);
>  #endif
> -- 
> 2.21.0
> 
