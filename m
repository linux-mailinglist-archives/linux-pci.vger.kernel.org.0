Return-Path: <linux-pci+bounces-12132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F095D4DB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8910D1C22622
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE218FDD6;
	Fri, 23 Aug 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvkvwJes"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5318BBB6;
	Fri, 23 Aug 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436286; cv=none; b=DoTgk9/FPY0Fi3Sia3mDEI7XLQ0Ez8R5L+Oy0TMGq7NfPuumgbXgBz1qIXhqEfL2jus/aC+Q/2cvShxwV/2dZll10sr/pY2mn3xWUL4xFpWjBoiStksnoLkwR+RbAtp/XdfLj68NbdnlhvJ/mjBlZgdvB6b1vs3udhVbr2i313k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436286; c=relaxed/simple;
	bh=d7EGDtbN0hddOp+GDsOFauqRCeZzmJJsvv0km29SQIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PoZlg3l8P4I0QKNTO9uY8u5ZyW5ZqSWWfE3mw6V0+H9zC+QbfQSEqaDsqkA3NDvzk2HKJZj6lKim78jrloe86KcGtMpg/qkLb8W3BdW+iS/DOj1LfSI6yIM82uH2SGSncRufem60aJZkeGxyFo5JswBM1kyA6jWQ+vdGYEP7GCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvkvwJes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDECC32786;
	Fri, 23 Aug 2024 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436285;
	bh=d7EGDtbN0hddOp+GDsOFauqRCeZzmJJsvv0km29SQIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FvkvwJesdwBPVPM7AA3zo0dE2WvhjVkNcX1N3e/rX3fiQmKQZACYs4k2CyQ5Tr9I8
	 SWs+3NhBAC69xMi1OZ8QswayfZHfEyUDkAg+sZz4gBK2Tp5z2SEFsZbxlJpVgEWsti
	 0aUAP5T4k5oueG57eWeT4/6w5aoliawtcI6D6xXiG8D0s9ICSLGsbPFW/jqbiTNb4J
	 MKVc+5KtSBV+nW2NXU9C5CFxLHVRiF0/1wzmMbeEOlJ922+Pj7h0Wf9kt1Ne+x9gEF
	 RKcKPoNDjE0G9wpYrASHWfnhywJAR4LxPhEZdkxNgSzq1M34w3WHmrY8iWqno7j54L
	 IVDb+gApIaAHw==
Date: Fri, 23 Aug 2024 13:04:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: bhelgaas@google.com, siyuli@glenfly.com, perex@perex.cz, tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	maarten.lankhorst@linux.intel.com, peter.ujfalusi@linux.intel.com,
	kai.vehmanen@linux.intel.com, rsalvaterra@gmail.com,
	suijingfeng@loongson.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	jasontao@glenfly.com, reaperlioc@glenfly.com,
	guanwentao@uniontech.com, linux@horizon.com, pat-lkml@erley.org,
	alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Add function 0 DMA alias quirk for Glenfly arise
 chip
Message-ID: <20240823180442.GA377418@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com>

On Fri, Aug 23, 2024 at 05:57:08PM +0800, WangYuli wrote:
> Add DMA support for audio function of Glenfly arise chip,
> which uses request id of function 0.
> 
> Link: https://lore.kernel.org/all/20240822185617.GA344785@bhelgaas/
> Signed-off-by: SiyuLi <siyuli@glenfly.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Applied with Takashi's reviewed-by to pci/iommu for v6.12, thanks!

I changed the hex to lower-case to match nearby code and dropped the
#defines for PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO and
PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO since they aren't used.
If those values are used in more places than the quirk, we can add
them and use the #defines in all the places.

> ---
>  drivers/pci/quirks.c      | 6 ++++++
>  include/linux/pci_ids.h   | 4 ++++
>  sound/pci/hda/hda_intel.c | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dd75c7646bb7..7aad5311326d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4259,6 +4259,12 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  
> +/*
> + * Some Glenfly chips use function 0 as the PCIe requester ID for DMA too.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D40, quirk_dma_func0_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D41, quirk_dma_func0_alias);
> +
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 1)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e388c8b1cbc2..536465196d09 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2661,6 +2661,10 @@
>  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
>  #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
>  
> +#define PCI_VENDOR_ID_GLENFLY	    0x6766
> +#define PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO	 0x3D40
> +#define PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO	 0x3D41
> +
>  #define PCI_VENDOR_ID_INTEL		0x8086
>  #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index b33602e64d17..e8958a464647 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2671,7 +2671,7 @@ static const struct pci_device_id azx_ids[] = {
>  	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>  	  AZX_DCAPS_PM_RUNTIME },
>  	/* GLENFLY */
> -	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
>  	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
> -- 
> 2.43.4
> 

