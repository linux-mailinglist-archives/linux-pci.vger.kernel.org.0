Return-Path: <linux-pci+bounces-21909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E1CA3DFBB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D16700EC7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3081FCCE4;
	Thu, 20 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7VuRydA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34A282F5;
	Thu, 20 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067243; cv=none; b=CujxiWHNr46ieV/n21SOUy1p4vL9zGPV3JezQEnX6IgZm9cNHnbivniKQFnTVeAPd6TpclwYqaEEKJfMj1M+oCBSJVYHbEel+SsoPfVVjqjvL/8IFw6NgYTG2aAZjRnWFwf2lsF5PsQsB790yKbOUM8sVm8DZJiRNJLp58Wrqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067243; c=relaxed/simple;
	bh=9L4HEH//kcH7ypLCadQEdfvBlWvdbCpj7JQG7mIJkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYFn5F8i18gZ2dUsafP8lhVEGGE7cb8vrapoBO4VV5IBNYdqabyeuSjXNK0hGd/MrPdQ7AVu30DDSouQlEolkymj/oiRoYNJbYvPYnDZtSEl6o776nRuPhum+X/4sPasUiJie/qoj4hjF86vUaV2j2KftEqWMf8w4pxPBRPRoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7VuRydA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E431C4CED1;
	Thu, 20 Feb 2025 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740067243;
	bh=9L4HEH//kcH7ypLCadQEdfvBlWvdbCpj7JQG7mIJkuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7VuRydACqsGAt79jQbZLbzefJUUsO52VYd/EUKCf1jz4/bRVeiwMEDFNTEO0ZyUz
	 e4xwI6AaldSYBguc5k7ClGijTcgIIQlUjeCz3a3HiYMGXUAscj78eaZhLuT4FcT1/z
	 zc7UWAFTZb9e80meNgP0iHwMztOkernuHnPyFbc4Z/Q5W3rViVaRdxZj6AucgmSZQ0
	 wCylTcmdJD6BVhFl/RwhvBfg50N093qyFT9Ydir/yBdH2t2l8v0iDVJvRWPDW7U+0/
	 TR/32AHUgfXcPYkfhd415AVDdYET+cwBxdubyaNJXRbDOxwtP8UAjYpyCREFtKYfHp
	 S3RdwL+IZZOsw==
Date: Thu, 20 Feb 2025 16:00:35 +0000
From: Lee Jones <lee@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org, Chen Wang <unicornxw@gmail.com>
Subject: Re: (subset) [PATCH v3 3/5] dt-bindings: mfd: syscon: Add sg2042
 pcie ctrl compatible
Message-ID: <20250220160035.GB824852@google.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <a9b213536c5bbc20de649afae69d2898a75924e4.1736923025.git.unicorn_wang@outlook.com>
 <173928439078.2206727.3592689089610946034.b4-ty@kernel.org>
 <BM1PR01MB2433B351262A2963B192F0A8FEFC2@BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB2433B351262A2963B192F0A8FEFC2@BM1PR01MB2433.INDPRD01.PROD.OUTLOOK.COM>

On Wed, 12 Feb 2025, Chen Wang wrote:

> Hello, Lee
> 
> I would request that this patch not be merged yet, because it is related to
> PCIe changes, and the PCIe changes (bindings and dts) have not been
> confirmed yet.
> 
> Although this patch is small and will not affect other builds, it is best to
> submit it together with the PCIe patch after it is confirmed.
> 
> Sorry for the trouble.

Unapplied, thanks.

-- 
Lee Jones [李琼斯]

