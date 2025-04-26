Return-Path: <linux-pci+bounces-26809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCAA9DBAE
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0144A3B8C1E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF725C713;
	Sat, 26 Apr 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbxTovUF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3879CF;
	Sat, 26 Apr 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680014; cv=none; b=BIFCSYIUcuUJZH55jU/Nh9wUYEmk2ddcIERyiQylAMkuGMWKR7NQZV9TvyU+9Ly5A/2NIehb6YAOuerO+79BuBjfjPbdS8wWwceWjEhzfC8TIjtzJX+G2A44BfKtlV5FB1fDINU8OKWJKYEE/CZXA7arF8L6ghHVseqpcI00pJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680014; c=relaxed/simple;
	bh=ldltt6Txk7jsfPZAR7Ijlb8uPp+jNfir4K8QBlkQzkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4rfxjR37U8DwnC+LRPa2xAURivUko9PNQSTp2+HjtPkOg74ZXI3L0mzgrsPV5iI1fPs+2Xgnj03BMEaAVNUjJd9BqX1OnoVoAocW/8npVc/fIyAprKMXuPA09wk62/WqG5sRzoqByJjUPOjGc2CIIOjvc79wJ88zaeBeN0XH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbxTovUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A4C4CEE2;
	Sat, 26 Apr 2025 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680014;
	bh=ldltt6Txk7jsfPZAR7Ijlb8uPp+jNfir4K8QBlkQzkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbxTovUF6JPsV4EAqGEuw1RmjADnKA4zydRGySU/qn2Z1cXvDHPKY7T50PJmpLTJP
	 5zNsSzqeqr/kUHy2/xORoIMr8rRMpRtX7bPDyYpAf++CcoSAaIkdX6/3WHszYBSo7A
	 j+ivJ0XF5AtBZ0MZ5BOSueBGi0Od72CgDNxKG05WcTPHNTISotWMxbZ2AeSbnvxLxK
	 q6YogLKhtcTPloClGq1mCZQ9YAXomgreIlxNMRlfXSR1piipkuEkKDdtpUelOb5Kfw
	 PJcHJJk6hfNRQm3qw/6qBS50v5+pShpf8EO+IZW6RhsWt2o8L35jjjO7AUUVltPRp6
	 kDAvLcDympExg==
Received: by pali.im (Postfix)
	id A3E6198A; Sat, 26 Apr 2025 17:06:50 +0200 (CEST)
Date: Sat, 26 Apr 2025 17:06:50 +0200
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
Message-ID: <20250426150650.c63x62ugtnwx5nzy@pali>
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
 <20250425181345.bybgcht5tweyg43k@pali>
 <5e2844cc-8359-4b87-a8ce-eb5ebb85f8ff@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e2844cc-8359-4b87-a8ce-eb5ebb85f8ff@163.com>
User-Agent: NeoMutt/20180716

On Saturday 26 April 2025 23:02:08 Hans Zhang wrote:
> On 2025/4/26 02:13, Pali Rohár wrote:
> > On Friday 25 April 2025 17:57:08 Hans Zhang wrote:
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index a29796cce420..d8852892994a 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > >   	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > >   	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
> > >   	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> > > -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > >   	reg &= ~PCI_EXP_DEVCTL_READRQ;
> > > -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
> > >   	reg |= PCI_EXP_DEVCTL_READRQ_512B;
> > >   	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > -- 
> > > 2.25.1
> > > 
> > 
> > Please do not remove this code. It is required part of the
> > initialization of the aardvark PCI controller at the specific phase,
> > as defined in the Armada 3700 Functional Specification.
> 
> Hi Pali,
> 
> This series of patches is discussing the initialization of DevCtl.MPS by the
> Root Port. Please look at the first patch I submitted. If there is a
> reasonable method in the end, DevCtl.MPS will also be configured
> successfully.

This does not matter what would be configured in DevCtl.MPS at the end.

> The PCIe maintainer will give the review opinions. Please rest
> assured that it will not affect the functions of the aardvark PCI
> controller.

This patch is modifying initialization of the aardvark PCIe controller
and is removing the mandatory step of the controller configuration as
required and defined in the Armada 3700 Functional Specification.
It says exactly in which order and which values to which registers has
to be written.

> Rockchip's RK3588 also has the same problem.
> 
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
> 
> Best regards,
> Hans
> 

