Return-Path: <linux-pci+bounces-26786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8CA9D04B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AED1B6097F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D121576A;
	Fri, 25 Apr 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWawd3FC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949611F76A8;
	Fri, 25 Apr 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604829; cv=none; b=M382JNUgbnZ8NJKwv34Vzxzczwq5qNQka40hGxBBbbg24q2Dfz1CwKGSHQo2IYv/tpmGglaqS5NSCxK5VFu6xHDf4wQltmTgX2fbtOHlUXi/jER8MvedVIFPMi8ko3UO1VW7WcaMAEbcUvQB7lIq5a0sIfdLhjn1A1aWcHB9a8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604829; c=relaxed/simple;
	bh=+R7PIio0jdtEKpan0a9pq9Eg4ukFgKIiHhho8TZ3TVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BahFlgzmOojLt0KCpoO8AhZUgHGLUdvnKUhCphPHmDC+0rao1EW8davoEHIJ4TSmDmydMu5ZDMl0jF4IqA96KM8qf9HCvNdlGy3tAx/cQexYmxc9WmSQQioCXYGuVuzATs0CB0z7ku+t11yJnGPJDcY5JywwdS+Ln8OMtzRfqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWawd3FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF013C4CEE4;
	Fri, 25 Apr 2025 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604829;
	bh=+R7PIio0jdtEKpan0a9pq9Eg4ukFgKIiHhho8TZ3TVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWawd3FCDXLQyP3oEO5T2ceR+TcSbYfbLR3o4X4X4ik9GlDlD5RaZn0/m5DVZHrDj
	 Kl+1DjYkvmLsI8kgTz9/0kk1+f+Bxr8FX8DvB9y66tz3SCtgoaFj8nMCOS+nRmvhpR
	 aK1Kj1OR3QFhqyh5pH96Y/mItoaIC8GdoZC3tngiDyUlnLF1Nz8uQmrVLIf6nYt++a
	 A7F/42LG/xOgOBA80oR1s8EL70PNiq/iVpIn681FTDQh48eHs44IFV3p4m+gFYztq9
	 54yBDjRarWqBmz96F2LClKtL6JKLeiUxs/QSsejfrupm45Rlo8FVZ/jUMsRqjZuDgm
	 XwH0m3MgSRYGA==
Received: by pali.im (Postfix)
	id CD881880; Fri, 25 Apr 2025 20:13:45 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:13:45 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, thomas.petazzoni@bootlin.com,
	manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com,
	neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
Message-ID: <20250425181345.bybgcht5tweyg43k@pali>
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425095708.32662-3-18255117159@163.com>
User-Agent: NeoMutt/20180716

On Friday 25 April 2025 17:57:08 Hans Zhang wrote:
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

