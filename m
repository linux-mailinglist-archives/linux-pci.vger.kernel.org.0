Return-Path: <linux-pci+bounces-20238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B5A191D3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED954188D6E8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA9212F83;
	Wed, 22 Jan 2025 12:53:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FDB212F82;
	Wed, 22 Jan 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550404; cv=none; b=DcLEQiYoCbRIJ8LLJlD3Wmw1Mv3DQ+X9nc0opVeG5aMOm4NKywkygw++zWULrWKfIYTKRlxH4KnzYAOO5MDhPsG1zoJpGTGsWKf0aButjUpTTiVlpGKW1gV0887r+2QCKpCEMNugZ7VFDWswnOo2VRLk7mULpBjam26AZOLcg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550404; c=relaxed/simple;
	bh=JY1TKLKpW6PU1gTosJg8FTxSozbl1gKoowmSko2t8TU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q5ZOtvM5/YQzuzrhoLacvy+U/Uk4a9DxvzRiv09oBw6co0gyVIrxnoedc7KmY/ntEOO1sz7JgcldZ24DIzJiuaugOaT6JKkVnXEYd7xVTACn+NzmWnwZ9m2SeqZvg4AryImeVuKqjIUyd6qlG5VGh19yCMx6+rTaYQosT0wipYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2B6E792009D; Wed, 22 Jan 2025 13:53:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2592292009B;
	Wed, 22 Jan 2025 12:53:15 +0000 (GMT)
Date: Wed, 22 Jan 2025 12:53:15 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiwei Sun <sjiwei@163.com>
cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    helgaas@kernel.org, lukas@wunner.de, ahuang12@lenovo.com, 
    sunjw10@lenovo.com, jiwei.sun.bj@qq.com, sunjw10@outlook.com
Subject: Re: [PATCH v3 1/2] PCI: Fix the wrong reading of register fields
In-Reply-To: <20250122080610.902706-2-sjiwei@163.com>
Message-ID: <alpine.DEB.2.21.2501221247290.27203@angie.orcam.me.uk>
References: <20250122080610.902706-1-sjiwei@163.com> <20250122080610.902706-2-sjiwei@163.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just use
> the link speed field of the registers. However, there are many other
> different function fields in the Link Control 2 Register or the Link
> Capabilities Register. If the register value is directly used by the two
> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

 The change proposed seems right to me, however...

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..c571f5943f3d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -337,12 +337,14 @@ void pci_bus_put(struct pci_bus *bus);
>  
>  #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
>  ({									\
> -	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
> +	u32 __lnkcap = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
> +									\
> +	(__lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\

 ... wouldn't it make sense to give the intermediate variable a meaningful 
name reflecting data it carries, e.g. `lnkcap_sls'?

> @@ -357,13 +359,17 @@ void pci_bus_put(struct pci_bus *bus);
>  	 PCI_SPEED_UNKNOWN)
>  
>  #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
> -	((lnkctl2) == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
> -	 PCI_SPEED_UNKNOWN)
> +({									\
> +	u16 __lnkctl2 = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
> +									\
> +	(__lnkctl2 == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :	\
> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :	\
> +	 PCI_SPEED_UNKNOWN);						\
> +})

 And likewise e.g. `lnkctl2_tls'?

  Maciej

