Return-Path: <linux-pci+bounces-11143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913429454B7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5110B28522D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421014A4F9;
	Thu,  1 Aug 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td8TtUsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743ED2F5;
	Thu,  1 Aug 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553508; cv=none; b=NAcISH7ooyPp3N5ebKkkW52CZgGnTSnX6qxUVcqSUTv1SeSx/rsWu17vGyWmVceTkZlfILkJQ1b4UHDzGyfivvx7g4mB5kBtN72Xu2X/Pds25dnGDeuvCuIMv/8xjO2N07Tn2pVrd/1VUQgI4pu8B6Xq7EMZB7xG9afuM8W5H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553508; c=relaxed/simple;
	bh=NgjJZVwF78QFOXnlTZN3l5y3pDbWwaW0cG0FwDmENu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZoP3ZwEgPGdDrIAeF76awRtzrx+MtUg0i+JR4iPVLnnT3oy5aDK6498APHCUJD6V6hbUGiLeQ25DCpTZwQ+COXlgJ9wHbbFNLMFe1XC6KKjXvERR4kTAdULyNKZxQDfoGnAGfp3pPbKQmNO5hz404bQgQwd5MbinMThKi9fJMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td8TtUsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB86C32786;
	Thu,  1 Aug 2024 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722553507;
	bh=NgjJZVwF78QFOXnlTZN3l5y3pDbWwaW0cG0FwDmENu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=td8TtUskaqZ1B/4IbtWpcGGOCbY01Fz1jMlLtTstWqA9YrDVkYqZ/ZNWHMopkSMau
	 jDt+opSz/1UaCHQP4timwKgqQxHXV4JaGuz38qCOu7khKYGS8ih+MERsLooqYP+YA9
	 TSGSCqKs1KqV2xFjIf5n0N5HY9K+TX9wylxdCSvoOaZbZuwDXzuos4cQuXdeDQgoQP
	 QP5y+MJm3/jWFiEPwTb/zi5mQ+KtPu+KuOKSdWBE2q+sJXlOJD9f6ZnzV0r2Bs79TD
	 vAeps9/6vuVXsh8YLgSqCT+DdSq9gFeJOilKsQ32m+hLut0QTFQu2tQk6r1XIG/38x
	 g2WdFOIOwr0cw==
Date: Thu, 1 Aug 2024 18:05:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: Re: [PATCH] PCI/ACPI: Increase the number of Loongson's PCI host up
 to 8
Message-ID: <20240801230505.GA127410@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726092911.2042656-1-chenhuacai@loongson.cn>

On Fri, Jul 26, 2024 at 05:29:11PM +0800, Huacai Chen wrote:
> Begin with Loongson-3C6000, the number of PCI host can be as many as 8
> for multi-chip machines. To support these machines we also increase the
> number of entries in mcfg_quirks up to 8.
> 
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied to pci/controller/loongson for v6.12, thanks!

> ---
>  drivers/acpi/pci_mcfg.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 860014b89b8e..58e10a980114 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -181,6 +181,18 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	LOONGSON_ECAM_MCFG("LOONGSON", 0),
>  	LOONGSON_ECAM_MCFG("\0", 1),
>  	LOONGSON_ECAM_MCFG("LOONGSON", 1),
> +	LOONGSON_ECAM_MCFG("\0", 2),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 2),
> +	LOONGSON_ECAM_MCFG("\0", 3),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 3),
> +	LOONGSON_ECAM_MCFG("\0", 4),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 4),
> +	LOONGSON_ECAM_MCFG("\0", 5),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 5),
> +	LOONGSON_ECAM_MCFG("\0", 6),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 6),
> +	LOONGSON_ECAM_MCFG("\0", 7),
> +	LOONGSON_ECAM_MCFG("LOONGSON", 7),
>  #endif /* LOONGARCH */
>  };
>  
> -- 
> 2.43.5
> 

