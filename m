Return-Path: <linux-pci+bounces-22847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F268A4E228
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF07B188ACBD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DD27C15F;
	Tue,  4 Mar 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ4Vsen9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338F20A5EB
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100074; cv=none; b=rS4VLRPUOl8Lx4Ihn69O6KJ40gNJTvIP3HXn9uQpcdbTdf+ICM5MwKVyWERzQtsMgXVh6aPHcviaKqLiV8Sr/qqZHjvpezDYZb/x3OmrydjCpDOUXvyxfy4A1XxSQKHn1Dsvu33pbumwM5areJk+nK4WYYA2WjphVqEFOsixxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100074; c=relaxed/simple;
	bh=UBoe1XShmX3P7j6hT5643LUFLy9aSuTJBPLFULrG/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3/3BM+XOg4/GN8dPwbEgkbOuTcagTeqIPRi1Y13vvSAzfkajWgwG/Wr0dQEuIjSMNxyZ1Wn/V2GobtwAJDIWGKmv8tv+tZS3wYh8VXrp86edFpT2PdKG0hjYAXWjUxl+FdM6GgKq1z/OgHxgLRRhz2C4CGByUhKX8Q0ZxHhfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQ4Vsen9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22334203781so108492535ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100073; x=1741704873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fX1Owrn1AszAewAaO9ydb9Cq7XmK0rDK8G2P8SgcArg=;
        b=fQ4Vsen9CieS3KnKkbPLZE2g9yixxVuCKJTLtEffihSIU2bRS0EmMhhEwLKMnaNJXe
         5m4b2b8kYsFNeXWE0Crszoix4nQDaTTDyER9otBRhDfN9qX846Xhc+1OHskKjJ9fStfN
         eBDQFrQ1X2ioYOC9tCP6Tv5LySeLJl2ATnhW+tp7nK3VniKcfmS5FdgnhcPUxTrZV1BK
         nLyUvPtjT6jrLrjlBzBgRSDfBbT++SAXjfBl0AoSFW15NnvrI0+X95aQPqZ41QFyvwCX
         YSGKYsZmPNZpDLpk/3C74zIT+jRWt8MBJBnCxxGomSbd9OXn4Yee+bMtNnGuszQEawCm
         YFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100073; x=1741704873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fX1Owrn1AszAewAaO9ydb9Cq7XmK0rDK8G2P8SgcArg=;
        b=b28txCeEjyc2pJegjM0pHn4msQTbxJFdSzHHwwtb/PfwpUnqPBeOIAxLTf3BRneKZC
         GRlA58yu3KprlFpn1St7bgI+l/LCe7wds7vMJVmIbpslQTq6rmYyvf7gWHfJbo7HptuY
         4fDwha04Kg7fJKWeUksaJowrvCL30uFljQUqxVqsoZ0+NIlJ3wfcXpc47IjRVQvVxD7F
         nInmrJkw89UQWzIZOk60R2aGGpzZhijF+Ri6Kfe2NEWMYibC3taNf6QanApDmzL+crfN
         tAMlQswEFmv6LdUM9CylPKspbMClheCIU2R9kPb+sjsUswR4vEh0Wgx3rv5W0Q+Jyi9J
         CJdg==
X-Gm-Message-State: AOJu0Yx147wcifOEB2++uDhM4I7ch6ywGK54OmmX1vaqZa4vbBoV35p0
	MJHwTakjvq/raUBO1HzachlrCm/hMwLwFFmsQSOUxsPJHLephdlw2LH1ehMlvw==
X-Gm-Gg: ASbGncuBDwWi7bKvlBUBhCoZLXQZzCPKNJ1/txrEVjJ4OScAenKa07yuKvWYOgYq1vn
	Y2kMUzW9i3aamEDFCNSKunWf5MGhzz6U4Rxf3/nM6yL+ZhkFIgIYbUer39s4t0rZBSUEcu9ORO9
	wM8Se9SyGj5nDw0iXVcN/8Ug5sf2j5/BxpmbgrajWdkUlCwtIG2AMmCwBbctw08e68OlTo9daq0
	oIEoCnLC19MrIXUpP2m5wfKINcwlYLfE5N++D3fykR0vlgh4jBsB8/CUnuAXdKDJo/xGgfIthoh
	CrwwlAnGUAaAlEcd7naKV7ptJDTtwhwaGYJHX2nffObVWoyIJqEh5dc=
X-Google-Smtp-Source: AGHT+IFOAFZRsvKQ5dtlmg9hihcEFbJufYkzxSZoZRlfkF27sYRSEvn0Q3zH2r9qpC5gI/Bx2ZfWFw==
X-Received: by 2002:a17:903:2447:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-223d9137f1bmr50389425ad.7.1741100072628;
        Tue, 04 Mar 2025 06:54:32 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223852162bcsm58948015ad.8.2025.03.04.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:54:31 -0800 (PST)
Date: Tue, 4 Mar 2025 20:24:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] PCI: brcmstb: Write to internal register to
 change link cap
Message-ID: <20250304145425.rayj5zowyxp7s4se@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-3-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-3-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:30PM -0500, Jim Quinlan wrote:
> The driver was mistakenly writing to a RO config-space register
> (PCI_EXP_LNKCAP).  Although harmless in this case, the proper destination
> is an internal RW register that is reflected by PCI_EXP_LNKCAP.
> 

You mean to say that writing to RO register doesn't cause any issue, but what
about the link capability not getting updated? It is a bug nevertheless.

> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> 

Same comment as previous patch.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 64a7511e66a8..98542e74aa16 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -413,10 +413,10 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
>  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  {
>  	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> -	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
>  	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> -	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
>  	lnkctl2 = (lnkctl2 & ~0xf) | gen;
>  	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

