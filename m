Return-Path: <linux-pci+bounces-593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29780760F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFA61F21100
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903037160;
	Wed,  6 Dec 2023 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu6/zwGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72764597B
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00977C433CA;
	Wed,  6 Dec 2023 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701882469;
	bh=bLTnwDn3Jiu3/drePnXNUKRZRyvC9sryoEXthKuzXU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bu6/zwGlO/moKGVxZVrNljA/XHmVtK61dWS/2Z1JxswaonKZQJhKzurie/D1BFRe0
	 kFoQKjy2BxC/cUSDGkNOD+n9F32AUBIHkcDXM7MRHi1VpgvhfFZaTtPCKzg2aCJewR
	 Q1sMLOcnmtVcdBIh2k+XgKQHjPm37pc6rXRfWDniE1yxf48O4X6GYnKp4T8mLm1/Le
	 IXG+qbxnIJ8wbuNVWYm1eCiVDM3A4x9fh3ch18Yrjyu1emt84t1RwvU4/qFzWqD4sS
	 5K8jvQvJKXhYgWa/6ALdjFEEsO2Cd1LbjjAezM22QM25Vk75yqMrYMEE+Ic2aN3FI2
	 NjJiR7rpdG+SA==
Date: Wed, 6 Dec 2023 11:07:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jieyy.yang@mediatek.com,
	chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
	jian.yang@mediatek.com, jianguo.zhang@mediatek.com
Subject: Re: [PATCH 1/2] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent
Message-ID: <20231206170747.GA718062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206083753.18186-2-jianjun.wang@mediatek.com>

On Wed, Dec 06, 2023 at 04:37:52PM +0800, Jianjun Wang wrote:
> Use 'dmam_alloc_coherent' to allocate the MSI address, instead of using
> 'virt_to_phys'.

s/'dmam_alloc_coherent'/dmam_alloc_coherent()/
s/'virt_to_phys'/virt_to_phys()/

In subject also.

> @@ -732,8 +740,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	val &= ~INTX_MASK;
>  	writel(val, port->base + PCIE_INT_MASK);
>  
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		mtk_pcie_enable_msi(port);
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		err = mtk_pcie_enable_msi(port);
> +		if (err)
> +			return err;

Is failure to enable MSI a fatal issue?  It looks like this will make
the host controller completely unusable if we can't set up MSI, even
if downstream PCI devices could use INTx and get along without MSI.

Bjorn

