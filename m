Return-Path: <linux-pci+bounces-28189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A6ABF039
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BCE4E28E7
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8A253F04;
	Wed, 21 May 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcfS6tBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81194250BED;
	Wed, 21 May 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820487; cv=none; b=SsfjfvVoGueote0eHN06a3jyXeEXtpy751tP0xo9dh58yvrw8VtkhV/AmtQQFieM+K0Yioh5Zg7tydqsw9WkLCQ58gMoGf5zKTHh77bkpv4RX86JIO63qnxEeTiR5rDx7NQGcK2FLj2KWTB7NLURVY4x9HDrUPeLMM9pCgR2tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820487; c=relaxed/simple;
	bh=+2ACf2EVUznzds3MDpxXdhMN6A2gN/hs5eEw4sfUYDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j226va1jP1b/fre8PcKLm00MsAfrgqDQPIgzi+y61JOyOpJeU38ucxhwdevi+aQRzoSnipV4T265FvlooqxLY4fAhmNhrmHBWoQfYnlDjdh18a10Rjw0QUp9VdR3yd962NiTOs2FBk3Z2iFzy4f6rhEaXoJHIdGhRuYNr/K/3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcfS6tBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C36BC4CEEA;
	Wed, 21 May 2025 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820487;
	bh=+2ACf2EVUznzds3MDpxXdhMN6A2gN/hs5eEw4sfUYDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcfS6tBaeh1ph8fLFgw+Mz//8rf1DUFHHXN3rXWNj51CElqQ6DP+LG/MepdP7wJUO
	 /7jVlQ1uejYjHZBfKkXwNcnohWb+bVw+rcmaDQiQWaLltKAyORjspTh2oLV3j8MQjk
	 Mi68gOYvOXxPZamX6GKA0DcKY5nC0ye/v1eadSFN7+y+O64FrrOTfy96J7gytVB8Oo
	 ZzCF+vARlOq9p6isPWAcn9r4dxIe3I/qTp9/eYYrIabXF2pfmKg+e2yO/LcWL2WQIt
	 Gfox0cdL72JffPforo3G681RVmJcjMzlhKUBMEwFbe/lv1BfZrZhKnNAfB9tPTawxR
	 9ipeqIDz4iRGQ==
Date: Wed, 21 May 2025 11:41:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	Hrishikesh Dileep <hrishikesh.d@samsung.com>
Subject: Re: [PATCH 02/10] PCI: exynos: Remove unused MACROs in exynos PCI
 file
Message-ID: <20250521-succinct-roadrunner-from-avalon-f1fa4c@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c@epcas5p3.samsung.com>
 <20250518193152.63476-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-3-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:44AM GMT, Shradha Todi wrote:
> Some MACROs are defined in the exynos PCI file but are
> not used anywhere within the file. Remove such unused
> MACROs.
> 
> Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 1c70b036376d..990aaa16b132 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -31,8 +31,6 @@
>  #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
>  #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
>  #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> -#define EXYNOS_PCIE_IRQ_LEVEL			0x004

Fix order of patches. Why renaming something just to remove it? No
point.

Best regards,
Krzysztof


