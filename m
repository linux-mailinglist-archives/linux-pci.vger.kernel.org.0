Return-Path: <linux-pci+bounces-18495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654BD9F2E83
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2141885EF5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADAA41;
	Mon, 16 Dec 2024 10:51:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E152AF03
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346277; cv=none; b=R0iqA4VQQJ8KoWmGyyn4FZZs5KRe5/7QILb0y7nOVKCy8olBvhFTDBbJTlGdFCJTHGfIUK5C5vtuLpXpVGI3kQYkBE+Io18cvm2kOMkQop3/Z5nffgBHn88Vvuo/nZd+YEU62XyNqdbBtMoCtfbihg1yFoOoJt1vki85nLCJYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346277; c=relaxed/simple;
	bh=EomUZui5xpa4ZMWLNVObTirV+gcBYO1I9kzMU+rdqKA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qka3pfSr59SsddDWyjFry8cqTh9OwrugpaFIyIdDRC0otXcFGYU5gk+jnXE0evqV3xVx5tmV+4x/vPypr0ZQthfBiIX/uemHZadoKJKl0A5sCXvk/en9KQpmoD+MY5599j7UPxg9TIOwWa8yv/ZNmck1idXh3rq8Px21RvDjOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBcCl3kghz6LDFf;
	Mon, 16 Dec 2024 18:50:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4975C140CB1;
	Mon, 16 Dec 2024 18:51:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 11:51:12 +0100
Date: Mon, 16 Dec 2024 10:51:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>, "Niklas
 Schnelle" <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed
 is undefined
Message-ID: <20241216105111.000053b8@huawei.com>
In-Reply-To: <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	<1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 15 Dec 2024 11:20:51 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> Broken PCIe devices may not set any of the bits in the Link Capabilities
> Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
> which is the lowest possible PCIe speed.  It must be supported by every
> device per PCIe r6.2 sec 8.2.1.
> 
> Emit a message informing about the malformed field.  Use KERN_INFO
> severity to minimize annoyance.  This will help silicon validation
> engineers take note of the issue so that regular users hopefully never
> see it.
> 
> There is currently no known affected product, but a subsequent commit
> will honor the Max Link Speed field when determining supported speeds
> and depends on the field being well-formed.  (It uses the Max Link Speed
> as highest bit in a GENMASK(highest, lowest) macro and if the field is
> zero, that would result in GENMASK(0, lowest).)
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Seems like this is the best we can do for this (hopefully)
theoretical hardware bug.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f249b86..ab0ef7b6c798 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	u32 lnkcap2, lnkcap;
>  	u8 speeds;
>  
> +	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
> +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +	}
> +
>  	/*
>  	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
>  	 * Speeds Vector to allow using SLS Vector bit defines directly.
> @@ -6244,8 +6251,6 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	if (speeds)
>  		return speeds;
>  
> -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  	/* Synthesize from the Max Link Speed field */
>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
>  		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;


