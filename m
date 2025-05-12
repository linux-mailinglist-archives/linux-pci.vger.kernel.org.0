Return-Path: <linux-pci+bounces-27565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CCAB3089
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677023B910E
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6416CD33;
	Mon, 12 May 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsghooqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AF2571BB
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035007; cv=none; b=K6kZLCBiyG5SBsqMtO7zUM0DEEhaoDH0pOrwTRudAYl1OScGwjbmj3l8U9gO49qtS9ZK1791TEEckHhTYEOg09Y4dVPQGSY1yaKsq6sWIMmMQy5CKtGFC645/vsolpCQIG3vJdMS3PBOuzg33i76BGvx7/sl5flvOfO8tn+P2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035007; c=relaxed/simple;
	bh=T6Vn4GgLIU1Q3gG83rSMJ8g3o6okK7Gzj5uMRzgUsBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM2+FjLNXiZRkvbSrXOpNqr6CRbfBKECe9AIkPP5+A7GOb9MctGjUUsOkeosUi7yL7BVtfJJGWl+AxJo1pN8WLYihg/m+vfdSaN+iTMmM673hBHEmDqgpH+1Ia6VnBp0SZmNIZ1Qf1eR9FEHN9pT+2aQLleOtOIyvYsr2tL3VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lsghooqh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso1430386f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747035003; x=1747639803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNVQ0d+KLCGQs7KKKO99vlGq5fz7ltsWNDVFutGH2HA=;
        b=lsghooqhci/hoACOamegdWvpUewsFFg3ohBaB7b3orcHC55YtIwp+qiKv6uRR/pY6O
         FUEU9PP+Y0z2Wr1PRevVN6MWDb0vpwHZpPcsIVnON1Vw5IMh6PjJ7AqnzKuIRUo1LDsO
         jURo0eVvl5jl57TVGEc9RucLX0zSnLb0JSqf1wzZQYchF7ILNNFFohF2mUyBxKBmp4Zc
         quCar023cmlVlXK2tIwiWO4SAsd8kewKANgzVXxIRYHHQYyMXOdRuw5FK+UdB+lzzJ0i
         8yG/NHfF/zJwpX2CtvSag4XD5z0jXUAu0h4CQ+ttTbJ7VCgOYVyAw1zLwxN0DQOAs/0V
         xL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747035003; x=1747639803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNVQ0d+KLCGQs7KKKO99vlGq5fz7ltsWNDVFutGH2HA=;
        b=S1eWU/QQKR5bCG82yV+3UqakugRbplz+J3a7cJB1d9ZF31H4lV1ona+IIhu1Jtcy+i
         YB4OqTHOrsko6rk75MYwGmf5q6Dx/XKt9JBacM3tiVJ9+FlZPiBwwwqoEdX10SdqojNG
         Q286M4j68dW/FmIIBTFfVBXYbV7iSJ76ZB/nXetyS5VIsd7y9JjQm1rHp4RtrOHPuD9M
         8SCOiKFsf2wErYE5EvOJPRGp/3iapSUJYmpYJoYGhfQ+XugzpF8TuwHOwZmlR4ijTshW
         76m8PcgtkkDqBOnCCKzha2qajiBclbqUZSXO2GhYPa3PN2EovkM3aZ04W7+l1TUEJknt
         kH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWlzkdzDiDBtCL4T44f/Jkj4kJrKDDXX+b3Djv/mdQ62sjupID9Gx/rElQKdxCoumwF2vWg66mye10=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8HBQtvtUTlETw1ii081eI5elDwgFaGj9tzrdiw5R/q7hXETo
	Sduc1S1UsSPfLAMsECpbn/MPinREMyf2vEbO5gDLjIWl4WnL/jxCP7MkdiYFhg==
X-Gm-Gg: ASbGncvHfrVIEQfcJttGafb9yWphjey5t0+wSC8m2LVPb13vGkEIbJySsBXbl/Ab2kl
	L3u4fCdwJBIiy8yp34MzO6MsWTbdl9BCa3OblWHeDu6muAEmR247qwPD+FYZNSQPxM4YyL9L6gy
	PnklIlUhEI1/Q82zoT63qhmaJdS8sH5SpbQrn9pEie7sefWDetJ5mN4XUF6dDx9sPXLqJz77lCn
	YQ+eDRKHcvLUKFbgNFk/xyCrG3JaoEKsa4P/jdEMnHLUF7EAEGvitOL/B/Hc5NDnLfEYQ1A/r/r
	SsTG1uzY5F+Qs6ahBpGZsTQPg6KuzLjVuXROubvKnSuGd2avZgJYv3FNG05d5zw=
X-Google-Smtp-Source: AGHT+IHopbBpWAMBUE7jBEBciLTBfLvvGYKMEx8+u7KnvSB1keB822jVfThgXOHUHjPaCKRKmOtXUw==
X-Received: by 2002:a05:6000:144b:b0:3a0:b65b:78ef with SMTP id ffacd0b85a97d-3a1f64b6931mr10131279f8f.52.1747035003477;
        Mon, 12 May 2025 00:30:03 -0700 (PDT)
Received: from thinkpad ([130.93.163.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm11439607f8f.75.2025.05.12.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:30:02 -0700 (PDT)
Date: Mon, 12 May 2025 13:00:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dlemoal@kernel.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Message-ID: <kgw4y5mrvt3g6vnnkiaicufticbpyc5vmhbo6ee4g7ayg2hntt@fogtz5lizk5f>
References: <20250430123158.40535-3-cassel@kernel.org>
 <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>
 <aB8762GD_iI5G5LY@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB8762GD_iI5G5LY@ryzen>

On Sat, May 10, 2025 at 01:43:39PM +0200, Niklas Cassel wrote:
> On Sat, May 10, 2025 at 11:27:55AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 30, 2025 at 02:31:59PM +0200, Niklas Cassel wrote:
> > > While the parameter 'interrupts' to the functions pci_epc_set_msi() and
> > > pci_epc_set_msix() represent the actual number of interrupts, and
> > > pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
> > > interrupts.
> > > 
> > > These endpoint library functions just mentioned will however supply
> > > "interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
> > > pci_epc_ops->set_msix(), and likewise add 1 to return value from
> > > pci_epc_ops->get_msi() and pci_epc_ops->get_msix(),
> > 
> > Only {get/set}_msix() callbacks were having this behavior, right?
> 
> pci_epc_get_msix() adds 1 to the return of epc->ops->get_msix().
> pci_epc_set_msix() subtracts 1 to the parameter sent to epc->ops->set_msix().
> 
> pci_epc_get_msi() does 1 << interrupt from the return of epc->ops->get_msi().
> So a return of 0 from epc->ops->get_msi() will result in pci_epc_get_msi()
> returning 1. A return of 1 from epc->ops->get_msi() will result in
> pci_epc_get_msi() returning 2.
> 
> Similar for pci_epc_set_msi(). It will call order_base_2() on the parameter
> before sending it to epc->ops->set_msi().
> 

Yeah. I was pointing out the fact that bitshifting != incrementing/decrementing
1. And you just mentioned the latter for both msi/msix callbacks. I can ammend
it while applying.

> So pci_epc_get_msi() / pci_epc_set_msi() takes a interrupts parameter
> that actually represents the number of interrupts.
> 
> epc->ops->set_msi() / epc->ops->get_msi() takes an interrupts parameter,
> but that value does NOT represent the actual number of interrupts.
> It is instead the value encoded per the Multiple Message Enable (MME)
> field in the "7.7.1.2 Message Control Register for MSI". So it is quite
> confusing that these the parameter for epc->ops->set_msi() /
> epc->ops->get_msi() is also called interrupts. A better parameter name
> would have been "mme".
> 

Yeah. But I would try not to name it as 'mme' and rather keep the semantics for
'interrupt'.

> It is however called 'interrupts' in the pci-epc.h header:
> https://github.com/torvalds/linux/blob/v6.15-rc5/include/linux/pci-epc.h#L102-L103
> 
> and in the DWC driver and RCar driver:
> static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
> static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 interrupts)
> 
> However, some drivers have seen this weirdness and actually named the parameter
> differently:
> static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
> static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 multi_msg_cap)
> 
> TL;DR: all of these callbacks are a mess IMO, not only {get/set}_msix().
> 
> I did the smallest fix possible, because doing a cleanup of this will
> require changing all drivers that implement these callbacks, which seems
> different from a fix.
> 

Agree.

> 
> > 
> > > even though the
> > > parameter name for the callback function is also named 'interrupts'.
> > > 
> > > While the set_msix() callback function in pcie-designware-ep writes the
> > > Table Size field correctly (N-1), the calculation of the PBA offset
> > > is wrong because it calculates space for (N-1) entries instead of N.
> > > 
> > > This results in e.g. the following error when using QEMU with PCI
> > > passthrough on a device which relies on the PCI endpoint subsystem:
> > > failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
> > > 
> > > Fix the calculation of PBA offset in the MSI-X capability.
> > > 
> > 
> > Thanks for the fix! We should also fix the API discrepancy w.r.t interrupts as
> > it is causing much of a headache. One more example is the interrupt vector. API
> > expects the vectors to be 1-based, but in reality, vectors start from 0. So the
> > callers of raise_irq() has to increment the vector and the implementation has to
> > decrement it.
> > 
> > If you want to fix it up too, let me know. Otherwise, I may do it at some point.
> 
> As you know, I'm working on adding SRNS/SRIS support for dw-rockchip,
> I might send a cleanup for the Tegra driver too.
> 
> I do not intend to clean up all the drivers.

Okay, that's totally fine.

> I am a bit worried about patches after the cleanup getting backported, which
> will need to be different before and after this cleanup.

We can add stable+noautosel to mark the patches to not backport.

> Perhaps renaming the
> callbacks at the same as the cleanup might be a good idea?
> 
> It should be a simple cleanup though, just do the order_base_2() etc in the
> driver callbacks themselves.
> 
> We really should rename the parameter of .set_msi() though, as it is totally
> misleading as of now.
> 

As I said above, we should keep the semantics for 'interrupt' and make changes
accordingly i.e., by doing order_base_2() inside the callbacks as you suggested.

> 
> > 
> > > Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
> > 
> > This doesn't seem like the correct fixes commit.
> 
> It is correct.
> 
> Commit 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
> added the PBA offset to dw_pcie_ep_set_msix().
> 
> dw_pcie_ep_set_msix() already wrote the interrupts value (zeroes based) to the
> QSIZE register. Commit 83153d9f36e2 added this code:
> +       val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> 
> So it used a zeroes based value to calculate the size,
> which is obviously wrong.
> 

Ah okay. I only looked into the 'interrupt' argument and missed the PBA change.
Thanks for clarifying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

