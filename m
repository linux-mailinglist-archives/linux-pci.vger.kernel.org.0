Return-Path: <linux-pci+bounces-12034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9295BE93
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215A2B240A9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7651CFEBC;
	Thu, 22 Aug 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRbic2QM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872003BBC0;
	Thu, 22 Aug 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352979; cv=none; b=Jd6ZCxFUphRzDid9fahMnuYTWiggysD4+W7iaHq/Q/6SnNFVegfw3T3FFZ9reeVkfSjr3omkdE3ZnFUuIbacXxb/pFWVaFfBfIZjLI+GKOsLAyquygc5hqI40A2m0F1mDkh+ROz3c9eng28Mng/WhSvwLsa3I7z03PNSr+/Aw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352979; c=relaxed/simple;
	bh=D/WEuPxAWCE5qjbCjA/R3PoIjmwKckIjRCtrhBTZQP8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XjatAm7/PWC6WX+CrhJdU9AbTi3k1vMoDo9nyb8TFfKdKqIKJ2Q1P2yQTL8TI2n7jCIPMQSUzD3o9lmssBvSlY0JftVV/pZgW+5A8+l3sKp72pa6LlAsotRaqwiGQTw6JvNnlJxckkXUSFb239wb4ioxdZBNTGR9gKVeAAVS768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRbic2QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E43C32782;
	Thu, 22 Aug 2024 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724352979;
	bh=D/WEuPxAWCE5qjbCjA/R3PoIjmwKckIjRCtrhBTZQP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uRbic2QMuCBVaZaM3fUbXRQAjwbag9+/sOOXi3USDHWSvrJ3SM8dtyY6lw+6N2Y2c
	 vjIs7kIi7pWapOcPlLLiXApZ46iUEykXoHV0mBO1w7gNcQ4VyYXQVb+GIcUks3ptr2
	 CGUnCyVpselKZmhevocG51LFHYlytpnlV+IGWmIVoRGoiY9BDot4k+OQ9ufUnCymh5
	 4phsfQTBphZmq9V+WNITQgSBGryfiWvIQzSrzrGqcmbikQsfi2RGz+CxGKtiujCzaG
	 NAYGUjemj/w4a/KOr38FZA3HwbNhsCxMiWqTCXDZPg25i9Wpo/BRNcI+IRne7bg84H
	 +hJg3THt0PqpQ==
Date: Thu, 22 Aug 2024 13:56:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: bhelgaas@google.com, siyuli@glenfly.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	linux@horizon.com, pat-lkml@erley.org, alex.williamson@redhat.com
Subject: Re: [PATCH] PCI: Add function 0 DMA alias quirk for Glenfly arise
 chip
Message-ID: <20240822185617.GA344785@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB918DA5CBA08DE8+20240802161109.240191-1-wangyuli@uniontech.com>

On Sat, Aug 03, 2024 at 12:11:09AM +0800, WangYuli wrote:
> Add DMA support for audio function of Glenfly arise chip,
> which uses request id of function 0.
> 
> Signed-off-by: SiyuLi <siyuli@glenfly.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/pci/quirks.c    | 6 ++++++
>  include/linux/pci_ids.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a2ce4e08edf5..a6cb8b314fae 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4246,6 +4246,12 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  
> +/*
> + * Some Glenfly chips use function 0 as the PCIe requester ID for DMA too.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO, quirk_dma_func0_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO, quirk_dma_func0_alias);
> +
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 1)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e388c8b1cbc2..35d2314cc433 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1654,6 +1654,10 @@
>  #define PCI_DEVICE_ID_RICOH_R5C832	0x0832
>  #define PCI_DEVICE_ID_RICOH_R5C843	0x0843
>  
> +#define PCI_VENDOR_ID_GLENFLY	    0x6766

From include/linux/pci_ids.h:

 *      Please keep sorted by numeric Vendor ID and Device ID.
 *
 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

The Vendor ID definition is OK, but needs to be moved so the file
stays sorted.

> +#define PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO	 0x3D40
> +#define PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO	 0x3D41

Use the bare hex values in the quirk instead.

If/when there are more uses for them, we can add #defines here.

I see this in sound/pci/hda/hda_intel.c:

        /* GLENFLY */
        { PCI_DEVICE(0x6766, PCI_ANY_ID),
          .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
          .class_mask = 0xffffff,
          .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
          AZX_DCAPS_NO_MSI | AZX_DCAPS_NO_64BIT },

Since you're adding PCI_VENDOR_ID_GLENFLY here, it would be nice to
update hda_intel.c to use the definition.

>  #define PCI_VENDOR_ID_DLINK		0x1186
>  #define PCI_DEVICE_ID_DLINK_DGE510T	0x4c00
>  
> -- 
> 2.43.4
> 

