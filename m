Return-Path: <linux-pci+bounces-27533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79653AB2162
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 07:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039917AF7BF
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C91D86F7;
	Sat, 10 May 2025 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRyxEYiN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A15103F
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746856681; cv=none; b=X0LDNwifF16qWv1BFjJofx/7mHaO03mj7CvBxzXga1B0qlUo4k+7YS+taXdro2Okxxlj/RPa/gNuKQjkFRy2+2scLUE07DnA50ctPP+HhIpFOTpep3YugScE0ZAkAj57fnNtcwTYd3tz9b3rgehWvytMdb3G+1OT4i0KVLfxO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746856681; c=relaxed/simple;
	bh=K6z6edK3lFTL/kSHRn+ThsqnpfyRq0fTLuw1yJrKoF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx0UP/xPvczc5ZSoqurnvL3du6k6rbGHMt3Oi4bgdtoCECG27EhYaEa4P2Eq7vef2loOnoK/5ty1ks7tJ4OcOAXk1YBu5pKfrwoYSMxyN9VFSDy/gBkkhpw/rUmpT4gc7O9OsThtUsttW6sYFgu1Nm6um8W4GWIkcf5kT3PZM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRyxEYiN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0be50048eso1883143f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746856677; x=1747461477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJN6wrUkuIam/6zZ9lLTQnhGT0VTQ6z1Frmo9OWygOQ=;
        b=sRyxEYiNWhxffx0fmpJgbqPGu5nPp0kNarLI06ZkEilTcr11yRPrwaC4Yjq0lurcsh
         QZR0bSBkZslkxGQf0lDN+Cj/KVe1k5TFuYeo2gzS1XzCUdlDF87FNYZ4/kNxBN6dIpSx
         JTHZSodZCQWWWGEf/9QLyX9MS+vLVxcA0USdMO6cGGCrzLhLZ07md9givSlJs4aEz2hu
         nYCI8a9KpsGmtp+cn1OYKpFBhHvRzant3bONpQg05mv7bMbRbPHBUfRYeiKX2uu4o7pe
         kxonkq2xKbI8tznPz+792TY/8ylEJZpMHV+dn3ZCxqyAbQh7oqTeCMX+kqbkEtJe7Dtu
         /4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746856677; x=1747461477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJN6wrUkuIam/6zZ9lLTQnhGT0VTQ6z1Frmo9OWygOQ=;
        b=KTjvX9AJ8YolAtCOP3tzXBTCNpSeGobg5ueM1RbSF4/k1Y0E7acjSbCx52w3ztWRRP
         RDZuEpnJGRg8z5dWNZBj8dDtaCMyrv2WeF307uNcyJBtmVLP3upEY9p+H8kFUKZWBm6K
         Vy+5r0o9Yfb9FHwPe7tOhN8Tw2B7F3jmBD35HOQSVpnduNjt1c8RJ0wpOTe6VcL1Qn/5
         zHIUiVVZEcgzhW50vtDXR1dx5190mEnD0DGBIjtY8s5k1noNiXbUAUbX1CpwXEUIPTct
         RU94N7RQue/jM8+v1vKI6hJIK7J1dmI0XBRrFOo8iRLk5Y1/E49xT10ilBsUjCaqyeTa
         KZNA==
X-Forwarded-Encrypted: i=1; AJvYcCV90+EuK8XVQ4UeYryoW050ZzxVXFzIPZ/q2mo4t01DW7KcoXcOuXrLtAuhjBXcnMvOHi2Vk4g4OnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkBDTe9bShm10qxtI8po5ytX3gGFFPWkKc1mRlSH0uLFu6/ed
	xeV2oNlt0nN79IiTsrMgXVg4Ycx0mENOBuloUYvm+E2Y6c8Z6x6eCQsF69VItA==
X-Gm-Gg: ASbGncuI3l/T/tofoj5oj+lQf7CtC/cZ9qFMBljEDTSxXuBbxeExt5BWKZmEztxjj2o
	c3l7UcTydKbri3PO90sA4jddMBJZtogZHpgyS5uavVlazfFm+kRVa/V27rYYNWNbeDn4JmwZyw/
	9njxI11R6S/nV0wFoX1iEeyuaUjOejpJPegN/q3UqtVOzh1jmX5zUHHP6abxUog67ZxAwEzrgdV
	kRil8dNU0g/H9c6xq+85hXMcgr06d1cHxrvyEHuhPAnL2R5ZmC6RuXnFfVSV2EobIy37HjN739d
	joWMQZE/wuXyIASi3KkWRPbFHNbH4y++AUeilTlQAycRNrco46yzyThMZyXy6uNCDA7eHXX9L5z
	wujSRMBXeDpEno9QVd/j6swMQkOIHNehJcQ==
X-Google-Smtp-Source: AGHT+IE2+JLv2hN9Ru8gsU8y2n3N7FmZ7Jurw7jte14ljGLXFkzsgRBYD0JW4jm+92bGG7p7zUKztg==
X-Received: by 2002:adf:fad1:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3a1f645eb8amr3865974f8f.34.1746856677232;
        Fri, 09 May 2025 22:57:57 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5e1sm5284449f8f.89.2025.05.09.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 22:57:56 -0700 (PDT)
Date: Sat, 10 May 2025 11:27:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dlemoal@kernel.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Message-ID: <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>
References: <20250430123158.40535-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430123158.40535-3-cassel@kernel.org>

On Wed, Apr 30, 2025 at 02:31:59PM +0200, Niklas Cassel wrote:
> While the parameter 'interrupts' to the functions pci_epc_set_msi() and
> pci_epc_set_msix() represent the actual number of interrupts, and
> pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
> interrupts.
> 
> These endpoint library functions just mentioned will however supply
> "interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
> pci_epc_ops->set_msix(), and likewise add 1 to return value from
> pci_epc_ops->get_msi() and pci_epc_ops->get_msix(),

Only {get/set}_msix() callbacks were having this behavior, right?

> even though the
> parameter name for the callback function is also named 'interrupts'.
> 
> While the set_msix() callback function in pcie-designware-ep writes the
> Table Size field correctly (N-1), the calculation of the PBA offset
> is wrong because it calculates space for (N-1) entries instead of N.
> 
> This results in e.g. the following error when using QEMU with PCI
> passthrough on a device which relies on the PCI endpoint subsystem:
> failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
> 
> Fix the calculation of PBA offset in the MSI-X capability.
> 

Thanks for the fix! We should also fix the API discrepancy w.r.t interrupts as
it is causing much of a headache. One more example is the interrupt vector. API
expects the vectors to be 1-based, but in reality, vectors start from 0. So the
callers of raise_irq() has to increment the vector and the implementation has to
decrement it.

If you want to fix it up too, let me know. Otherwise, I may do it at some point.

> Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")

This doesn't seem like the correct fixes commit.

- Mani

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1a0bf9341542..24026f3f3413 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -585,6 +585,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dw_pcie_ep_func *ep_func;
>  	u32 val, reg;
> +	u16 actual_interrupts = interrupts + 1;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msix_cap)
> @@ -595,7 +596,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
>  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= ~PCI_MSIX_FLAGS_QSIZE;
> -	val |= interrupts;
> +	val |= interrupts; /* 0's based value */
>  	dw_pcie_writew_dbi(pci, reg, val);
>  
>  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
> @@ -603,7 +604,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
>  
>  	reg = ep_func->msix_cap + PCI_MSIX_PBA;
> -	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> +	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
>  	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

