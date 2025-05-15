Return-Path: <linux-pci+bounces-27784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0BCAB8595
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B0D9E4CC4
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCF253923;
	Thu, 15 May 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMrsw/vL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A91F16B
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310617; cv=none; b=Dnu9KLjaA2Z8XPUxHvY0cvQ7ulIZKxsVzZV7IqPKeOp9UjUg2ykYdZsV4Nx6D92zFxwt3H7HRE3Tm9T0QDskOBc4riF8HF+iEq9a4Fse4JMtQ9eomOIr4cR2abR1ueTBdQhNewzD1USCxRUPqTvRo2EGPAPom1PVdasMTcSenS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310617; c=relaxed/simple;
	bh=rIaiGOYbokETxOKXtmP8wukLdDqxoOnSlsPQovNIqD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji2ZjmHA3iJ/H6T9/9xWGdOZ50GvAz07/3Xf47iIKWcdgBnfBjTB/PGBiN10dVceWMkrbNjScv7nQKNanYxEn65Rn5lGcpdNTzjxiLGhD9sgxxGJdl0fFyAkXj8qVvsmZJP7Ncejeh/uQwIsr9wwsL3SKHOHLq506A0OCUxxW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMrsw/vL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso8574175e9.0
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747310613; x=1747915413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5Dm294PbrWONSf7K3CLqY0H7cYyRoYEw+bT1IPWQHo=;
        b=gMrsw/vLV/MCIMZNu6II4h4X7lqvaP/PTjAsv5aB4WMPGa7GEgP1VJwBDIDihYVgqz
         erkAWAxLqSi7dqogJrUcJ/hUO7KPIS6lWRKFtDLQRCFmoYyEz19WiL6tDFMGF95nHszM
         CutiDuLF7PgsunUcrU8MmGEM2yUjepWhtSSj+io7sk4nWBSkWsYKO039jVpZYknru/VC
         Tjnhz6ljBDunOJjv11mrpN6FrM+FfJzCnBN+lHJJEN36uxEZf1NudvQ+JXUF/Ao58yNq
         4cgnSmPcgVYotU327oCJFJLi4pHThTTHMkTzenGiHYPQGlSxTLhymTw0LJ5NKbMgVL4m
         iJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747310613; x=1747915413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Dm294PbrWONSf7K3CLqY0H7cYyRoYEw+bT1IPWQHo=;
        b=bDdYuJD7QzgwqG1VNpB237mLUorhGf47Q+Uh/AsNZ2kjSUqbS1hWebJP11U/yqmMAf
         Kl8VpUirgtxeyKPCogbEcVerHlrXi6gYroFNg+g6W47xdTEDd3HGXGG8qjScDUuzSn+r
         3pOxEgFQExgg0soMJn0seTbz/zrP4zIwx30UHSdC15wQZOyaFQgaHu2ul5QKMu8KU04I
         iohkZLz6BbaKY+oTimX1HJohBr6zwi0HLZbQSL6j1oJdcqKlTjuEZJWSbHRehOsrbHnL
         BBoI7qLn72HMBf80Ds0uNp7mNAAWAo/I3c3rTy98PM5yZRWJ49tCnbqeFAVmSOH6lgIQ
         bJOg==
X-Forwarded-Encrypted: i=1; AJvYcCWh+c9cDFXzfburrkSl11qEmTpk1vMUj2VtMaXWEGKdJWOhmDvLs8Nv60viLiEpGuXDtaE7OKXXujc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uMxebbdI3N0pGVIDfhENs1rhAH+D4r/vSnFPef/fxcGWKKi4
	bKDmZHK4/GKQ+tIL1h2WAnYBS/CBUd4LGztwWj2vFIv+1BxWbwaOzDnydCeRuA==
X-Gm-Gg: ASbGncuveUjEceERH3+vddpvcULQusUKi+AzhUNMrFidoDKvcRV8f8UGoKXIRw/vXgM
	TOZRnHQRs5rl9XC7mIREicoV+S6nYCgcC6J5Pu721lVVdNx1HsZqzepcLkPswM7Hnj/veco87jP
	JgxtClEHkhTem+tZF46/mMo5BiJKwDYIeKdcxhtF+TMM0TAx5PuMQvItC0NjVuqbe0aVTMajx/8
	ILbfzSJMVuufRNPwjP0Q9+Tc0JWyQJpYdbKdaXXiVo/qR8IA67Ea9FOsdf+4bTdR7GGRuqYvwfB
	guHZTSvdRJmqDVaI5ldHGVJr9TRoOhOtJikGtCWEMGNqG9ZUUXYTf4vRX0qM3MO74D271cfZyPe
	wr3bmJZnRM0Sveg==
X-Google-Smtp-Source: AGHT+IHlVMLx2LBOebfEdakAr7jMaTKb4vKCXk6oSYtrA1JygFEFmKNR3fFjnt2BvUb5BojRv/MYmQ==
X-Received: by 2002:a05:600c:a42:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-442f217a65fmr61066245e9.29.1747310612978;
        Thu, 15 May 2025 05:03:32 -0700 (PDT)
Received: from thinkpad (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2961sm22525510f8f.45.2025.05.15.05.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:03:32 -0700 (PDT)
Date: Thu, 15 May 2025 13:03:30 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de, yue.wang@amlogic.com, neil.armstrong@linaro.org, 
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <wqzay2jvimjvpsj5rzh6xwxgmrerma5qesbwa6fkjepibhdv6e@hi4dpp4kmt5u>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
 <20250509160025.s65aw5ix6s7533b5@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509160025.s65aw5ix6s7533b5@pali>

On Fri, May 09, 2025 at 06:00:25PM +0200, Pali Rohár wrote:
> On Friday 09 May 2025 12:38:48 Manivannan Sadhasivam wrote:
> > On Wed, May 07, 2025 at 06:36:20PM +0200, Pali Rohár wrote:
> > > On Wednesday 07 May 2025 23:06:51 Hans Zhang wrote:
> > > > On 2025/5/7 23:03, Hans Zhang wrote:
> > > > > On 2025/5/7 01:41, Pali Rohár wrote:
> > > > > > On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
> > > > > > > The Aardvark PCIe controller enforces a fixed 512B payload size via
> > > > > > > PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
> > > > > > > core negotiations.
> > > > > > > 
> > > > > > > Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
> > > > > > > PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
> > > > > > > during device initialization, leveraging root port configurations and
> > > > > > > device-specific capabilities.
> > > > > > > 
> > > > > > > Aligning Aardvark with the unified MPS framework ensures consistency,
> > > > > > > avoids artificial constraints, and allows the hardware to operate at
> > > > > > > its maximum supported payload size while adhering to PCIe
> > > > > > > specifications.
> > > > > > > 
> > > > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > > > ---
> > > > > > >   drivers/pci/controller/pci-aardvark.c | 2 --
> > > > > > >   1 file changed, 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c
> > > > > > > b/drivers/pci/controller/pci-aardvark.c
> > > > > > > index a29796cce420..d8852892994a 100644
> > > > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > > > @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct
> > > > > > > advk_pcie *pcie)
> > > > > > >       reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > > > >       reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
> > > > > > >       reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> > > > > > > -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > > > >       reg &= ~PCI_EXP_DEVCTL_READRQ;
> > > > > > > -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
> > > > > > >       reg |= PCI_EXP_DEVCTL_READRQ_512B;
> > > > > > >       advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > > > > -- 
> > > > > > > 2.25.1
> > > > > > > 
> > > > > > 
> > > > > > Please do not remove this code. It is required part of the
> > > > > > initialization of the aardvark PCI controller at the specific phase,
> > > > > > as defined in the Armada 3700 Functional Specification.
> > > > > > 
> > > > > > There were reported more issues with those Armada PCIe controllers for
> > > > > > which were already sent patches to mailing list in last 5 years. But
> > > > > > unfortunately not all fixes were taken / applied yet.
> > > > > 
> > > > > Hi Pali,
> > > > > 
> > > > > I replied to you in version v2.
> > > > > 
> > > > > Is the maximum MPS supported by Armada 3700 512 bytes?
> > > 
> > > IIRC yes, 512-byte mode is supported. And I think in past I was testing
> > > some PCIe endpoint card which required 512-byte long payload and did not
> > > worked in 256-byte long mode (not sure if the card was not able to split
> > > transaction or something other was broken, it is quite longer time).
> > > 
> > > > > What are the default values of DevCap.MPS and DevCtl.MPS?
> > > 
> > > Do you mean values in the PCI-to-PCI bridge device of PCIe Root Port
> > > type?
> > > 
> > > Aardvark controller does not have the real HW PCI-to-PCI bridge device.
> > > There is only in-kernel emulation drivers/pci/pci-bridge-emul.c which
> > > create fake kernel PCI device in the hierarchy to make kernel and
> > > userspace happy. Yes, this is deviation from the PCIe standard but well,
> > > buggy HW is also HW.
> > > 
> > > And same applies for the pci-mvebu.c driver for older Marvell PCIe HW.
> > > 
> > 
> > Oh. Then this patch is not going to change the MPS setting of the root bus. But
> > that also means that there is a deviation in what the PCI core expects for a
> > root port and what is actually programmed in the hw.
> 
> Yes, exactly this aardvark PCIe controller deviates from the PCIe spec
> in lot of things. That is why it is needed to be really careful about
> such changes.
> 
> Same applies for pci-mvebu.c. Both are PCIe controllers on Marvell
> hardware, but it questionable from who both these IPs and hence source
> of the issues.
> 
> Also these PCIe controllers have lot of HW bugs and documented and
> undocumented erratas (for things which should work, but does not).
> 
> So it is not just as "enable or disable this bit and it would work". It
> is needed to properly check if such functionality is provided by HW and
> whether there is not some documented/undocumented errata for this
> feature which could say "its broken, do not try to set this bit".
> 
> > Even in this MPS case, if the PCI core decides to scale down the MPS value of
> > the root port, then it won't be changed in the hw and the hw will continue to
> > work with 512B? Shouldn't the controller driver change the hw values based on
> > the values programmed by PCI core of the emul bridge?
> 
> Marvell PCIe controllers has their own ways how to configure different
> things of PCIe HW via custom platform registers. This is something which
> needs to be properly understood and implemented as 1:1 mapping to kernel
> root port emulator. Drivers should do it but it is unfinished. And as I
> already said I stopped any development in this area years ago when PCIe
> maintainers stopped taking my fixes for these drivers. As I said I'm not
> going to spend my free time to investigate again issues there, prepare
> fixes for them and just let them dropped into trash as nobody is
> interested in them. I have other more useful things to do in my free
> time.
> 

If the patches are not related to unloading the driver which acts as a msi
controller, I don't see issues with them ;) But I have no visibility on the past
conversations.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

