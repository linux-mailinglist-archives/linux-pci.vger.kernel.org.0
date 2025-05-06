Return-Path: <linux-pci+bounces-27293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE6AACC62
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6921C0537D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77685280029;
	Tue,  6 May 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ13y8A2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA081FF5E3;
	Tue,  6 May 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553274; cv=none; b=unYh3VgCy9bGy3SW0ZU2VcRKu3OblMZWGS/dSznQdU5mHjN/kyBoDncsoFAtmPMeAxUx2td/o5tVpbFteFQXLXQGCKPTWCku8He2+8U4GKICR5P3paM8glIuzw4XFXlwMXvJCKrwRBqf8RUVS2J+sG+sUWXeK9HmG277jlUyEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553274; c=relaxed/simple;
	bh=addtd2tD+DOVZOCpE3AbYsDQUYIQPT10US31SZtt2d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWlGh8a6gLLempF5cgSpIFd8yj/BiRINxbIlkj3dzPj//rEztWDQQnfKxeFv8q4l9pnpW6EUodfhEyikXZegL/N9uslpWNMGhCr1SIxsmf0bN10Hq8OZ6eOaHoZ9sOMK61UhizoK+P86Sy0rw0Ku3y3vukONvHKAfP6Dz/suMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ13y8A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5E3C4CEEB;
	Tue,  6 May 2025 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746553273;
	bh=addtd2tD+DOVZOCpE3AbYsDQUYIQPT10US31SZtt2d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQ13y8A2z2q3OM1MObsbWCM3zla4VJlDmuJTvyfkO9aLQ99ypDNhNEN5oIxX8/CF2
	 L7PE7DWzOZPp8ZoJDpDZlpxNWTk5Ih4sWfsD84tNapMnA3Y2KOw5B9Y4QZvvndl1mh
	 OaqinBL3jRrAXKDx1+2yyGAihpf5tY7CMaH3ajYjdYUoCrccekKFDzi+RY471N+O6g
	 DLNKlwl5z4KVODs9zh9AM0Y9QIoVY2JiKb7Wvkg8siHRf9KFynN7ZtDScFTVNASztZ
	 HHcK779OBDwABXOTxQ233HRRs0qXWSGtkHiFvT9ZytMwZVGnlGYVjBiQXW/Wq4izM5
	 uuVjbbjUkI0dw==
Received: by pali.im (Postfix)
	id B53EE67E; Tue,  6 May 2025 19:41:10 +0200 (CEST)
Date: Tue, 6 May 2025 19:41:10 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <20250506174110.63ayeqc4scmwjj6e@pali>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506173439.292460-4-18255117159@163.com>
User-Agent: NeoMutt/20180716

On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
> The Aardvark PCIe controller enforces a fixed 512B payload size via
> PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
> core negotiations.
> 
> Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
> PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
> during device initialization, leveraging root port configurations and
> device-specific capabilities.
> 
> Aligning Aardvark with the unified MPS framework ensures consistency,
> avoids artificial constraints, and allows the hardware to operate at
> its maximum supported payload size while adhering to PCIe specifications.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index a29796cce420..d8852892994a 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>  	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>  	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>  	reg &= ~PCI_EXP_DEVCTL_READRQ;
> -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>  	reg |= PCI_EXP_DEVCTL_READRQ_512B;
>  	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>  
> -- 
> 2.25.1
> 

Please do not remove this code. It is required part of the
initialization of the aardvark PCI controller at the specific phase,
as defined in the Armada 3700 Functional Specification.

There were reported more issues with those Armada PCIe controllers for
which were already sent patches to mailing list in last 5 years. But
unfortunately not all fixes were taken / applied yet.

