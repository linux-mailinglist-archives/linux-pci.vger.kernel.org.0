Return-Path: <linux-pci+bounces-11374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE74949739
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE7E1F24267
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A87757F8;
	Tue,  6 Aug 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji9ZQzYp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79E74402;
	Tue,  6 Aug 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967148; cv=none; b=icU1ymya8jjSCA/43fXxoHjahNYmbx6LCiPI0gdxbpqtxulQC4Q1Kd8h+e91H96Ki5p/NG0Nssez12nuGQirMR1QCAdhYFqcnLWvBWv8tBbAAhEsPvmvcVPJPqpo9WLV/6KW2MqwsXJC/HxuJKmXzWEXm6kIKNc9zZqMZR2JrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967148; c=relaxed/simple;
	bh=F755KLDI+ys7bWTNSoeWrgEfMJzHK86ZXXHPHScYM38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pvvK5z7569773fy5wCDOfdbTxiNDwuDY7EexdcEdgPEiMX50LDQVg3zOrTHSKJT09Ufw2n9eeSUfsmPDE85cUv3o7XQY0FQXDkogSJA5RvuGutS8hXIkXm94JVMU53diF41RBZPbaAiMMXekbKUUZR7E9lv0hnjDZPLOQGQkG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji9ZQzYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D33EC32786;
	Tue,  6 Aug 2024 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722967147;
	bh=F755KLDI+ys7bWTNSoeWrgEfMJzHK86ZXXHPHScYM38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ji9ZQzYpN8tKy6EghID+xHUGnDq+qFZWTIw82FfmMk5NlbmRNPRoBI1EbjTeiGlB5
	 yvRDpU36mo8FqM8VZShVNVNooRKdnvElJ+ROTP3dJjWffraWCjY/M2bTrb1cfzgwZe
	 8rnwty7OGzlsV2liiyeuD8ZBFn26SXoIXS40R/8upcEM5k+sMx/SfzGfzBmNfR9JYS
	 mtGfBXCCNd/rks6o9zfPqGmAuQapdCoXKVRzrb2MYoGdTMeVshGvjiT9Z5+dWLzjNY
	 3MA6mmWZPenOY2neLzIsHKTenctx5mghui/LkcmTw0barrUJhz4nRwlekSGsGAIbeU
	 HF9suq6lEfQTw==
Date: Tue, 6 Aug 2024 12:59:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: 412574090@163.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Message-ID: <20240806175905.GA70868@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806022746.16353-1-412574090@163.com>

On Tue, Aug 06, 2024 at 10:27:46AM +0800, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capability
> ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will want
> this whilst doing Gen6 accesses.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..cc875534dae1 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -741,6 +741,7 @@
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> +#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s */

It probably makes sense to add this (with the corrections noted by
Ilpo), but I *would* like to see where it's used.

I asked a similar question at
https://lore.kernel.org/all/20230531095713.293229-1-ben.dooks@codethink.co.uk/
when we added PCI_EXT_CAP_ID_PL_32GT, but never got a specific
response.  I don't really want to end up with drivers doing their own
thing if it's something that could be done in the PCI core and shared.

>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
> -- 
> 2.25.1
> 

