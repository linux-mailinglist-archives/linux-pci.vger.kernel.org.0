Return-Path: <linux-pci+bounces-32389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FFB08D36
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D2C189073E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1B28C013;
	Thu, 17 Jul 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjK5XcOQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A177E9;
	Thu, 17 Jul 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756135; cv=none; b=TqEzAlrQDe/UoLsxDKErR0tfUnt2I+EY9y2o21ulZl7evU8Tru9yCMcY1uRa3rXWSC7sQuiFjhiJHzRZoNZLmYQa1HdIzmUUMF4OoFeoM7nYG3Nmsan/gxWBoXAo7VuUDxhfEhVaqywj3LjFYTwenjrkNlLZqiCZuUUaXnpLdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756135; c=relaxed/simple;
	bh=ZBY36t6x50q8YzRo+BWSKkd27H/7AfalmvHRzL44imU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VATUlAzUiRfQl/0aPLWdN175P22Oy8Dmdjh7B+AsXQ7r4SzCY8xKreMCeEbMgN5L0smayVB/CUCSiRSvGAeHQNlPxrltblxha/sO6gkgTmq81IlQ+K1ymmPg+okx5J6bxnG52H7wCoD9pGV0q2Uj0QWfKUoCq1/wV97Iek1Xfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjK5XcOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E99C4CEE3;
	Thu, 17 Jul 2025 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752756135;
	bh=ZBY36t6x50q8YzRo+BWSKkd27H/7AfalmvHRzL44imU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjK5XcOQBtD8/L1ha67M2mu0f609rbwi7BfOqhatr1LcEPBfC1s3ow72ilT5tERiO
	 mzR8YMBo4AJ5Vlw8cHTNNPx+CiMgz2Q8M5It4a7caKGpUu5uVJWn+JRBWb5p7wZf4X
	 Chhy1h2Awqn4RxoC9mBUKEkiplJ3gsSTlUfDI41FVjtDn8yOgkFY58I4TDxq5B2I7K
	 wPQrybzH/jnHJU1pzUVKxKL0RqSYB+R4XkT202uXP77PdkWNOBcgqRNHQOuVW2pKsx
	 ocD27OmpjCu6FAUKTvEjtmfbP60vVEqtvTER3+qlJkZyNXtE/DlT+uhRQqK1pQbWm8
	 m9xpMBL6obipA==
Date: Thu, 17 Jul 2025 18:12:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, nsaenz@kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Drop Nicolas from maintaining
 pcie-brcmstb
Message-ID: <bulofvsxrn7qm7vcuxhweqwlzaf7rkvzsmyg4ox67gi6gc55lg@xl2hlxd5fii5>
References: <20250624231923.990361-1-florian.fainelli@broadcom.com>
 <20250624231923.990361-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624231923.990361-2-florian.fainelli@broadcom.com>

+ Nicolas (who was not CCed)

On Tue, Jun 24, 2025 at 04:19:22PM GMT, Florian Fainelli wrote:
> Nicolas indicated a long time back that he would not have the bandwidth
> and indeed, has not provided any review or feedback since.
> 

Nicolas, I hope you are fine with this change. So I'm going ahead and merging
it. If you don't feel so, please let me know.

- Mani

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41d95e7c60c6..439edc5babb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5093,7 +5093,6 @@ F:	include/linux/platform_data/brcmnand.h
>  
>  BROADCOM STB PCIE DRIVER
>  M:	Jim Quinlan <jim2101024@gmail.com>
> -M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
>  M:	Florian Fainelli <florian.fainelli@broadcom.com>
>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>  L:	linux-pci@vger.kernel.org
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

