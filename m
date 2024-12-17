Return-Path: <linux-pci+bounces-18661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E09F5366
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC661700D6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B31F8EED;
	Tue, 17 Dec 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmgT13Fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E81F8AE2
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456315; cv=none; b=fsZeqYYU5o1Vi6nmJuoMV6iOCsuqSw1RqKknFltXnD97lN4xCXi6Z8LLTci0WK5deTJfLPD8+J3/QZf4egx+Fkjfj9DxaZWtw39QNRZapsx20lrPVm40CnKK4CAx7nykeE530e/HG9eBOpbKR48KM5nA771huPrFwpfAz4SFCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456315; c=relaxed/simple;
	bh=qtebKg4/588ML/A2XNGyueKXuWay492/kzv5TfXOmiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSoO0YcdmwJ0ko6RRQw4EmixkEHU34cp+6049R1OUm6tjILIT9A6fkDySdx2B8AFrExL8v/tg9YTZUm+VIkTtOjf+rCZh9kQBCMyIZhZav148CAQkS8iY8saUrhlg1SLdhpJMNgYmgRH5jQE8WPYV7pQ1Zhk/zV7KQW7bhKByx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CmgT13Fq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f337a921so5804954b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734456313; x=1735061113; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOPV+rKrhFxhfr/BDT97d+AUMncXtvhCP8Kd1bZ9mu0=;
        b=CmgT13FqGAlm0J8YffbIYRYnbw5SzOgHxAoO/gMCSxqEWbr8S8Iee7Ut+ll0CtFAib
         3Yb57Tmm1tskyJ1AuznBZbu9QCzTweVq5PgJl6VU8JUy6VCsqD1tin+ilHTA5lscW8iZ
         jmfbBJRqkq01G6RqUWhd0j0NS5qkc9NH4ZcG7bhuHp/jZmL7ZEHhaUNR6sFOBvxJBMjo
         yjQUpK0NHqRB66RIXzGQ9M1iqyD8Gm7kbANf+e05dS7NgC4nfmYwg9CwaOy0MK0yYm/T
         eRwKgJuGOC8d487wRjgDXYIGtk9qbT7taygJG+GaydpAFeELCBeX3la2vjhfutDH/gGN
         TQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456313; x=1735061113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOPV+rKrhFxhfr/BDT97d+AUMncXtvhCP8Kd1bZ9mu0=;
        b=VUDino1ASiyU6AaTUZA+knhCCqJYY4tKVAjX5/Pazj5gNgfFMSGvuXJ5lUvxoadE0Z
         02pve+/815gExr1Z/uMI0cV/vdMX3JUiZf62x3hsgSBlikwq3/3HodiIbL/oW6EYJAT2
         Kl+xcc6BXyDH4NT1IVUYnVduMi/duIw/TVnX4Y/z9XduOTRVHFYl1p2wusdedlkzVsqK
         4BnlaTVUp3PPTU3UmQBIJ8MsgIFFJ7iv4zB954J7z4CjTJaM4h8WpLbZj5z4JMTekmHm
         /F+JbHXDHxMkujExgrhObuaGWDz+Kx3r2vXyQ1KVXRhjZTduy/bB0Q1M0pfmcg6rFyyu
         IKJA==
X-Forwarded-Encrypted: i=1; AJvYcCXWzEBS3QiRMARhUpEk1fSu/UCgkEHiWy+WJr81a8OQ2wX/8Lp7N8e7rYgw5ogNTv2aSMT2baRwPvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/W4KPv2AJRCYx6WTYa06zl+bSK9Z05Vp11tTNfYgjxGOjvTt
	dE6MZ6OonhPUcfuHym8fx5WXf405YiO82IxE5YQ9CVWf8GdHo3zjrs9O8hQLCQ==
X-Gm-Gg: ASbGncs52iL7Wnr/1uHHS7KeLWgF3XfTSENFgrQ4R2yU57REt/WzABzJ3AHsYAvGzKu
	0Fsf6bb2+OCy2QZFP8zkx2v9PZoQWE9jmiI2bFf8SWbyicvpdcVRwPj/HQ92tStjgxJBw1IxD6F
	52YbOVJgpeS9w7MdeH5cZItTHxf+5jVhnAZAngVga2mUAgjpQ+lb8WxRP0hJRMXDKJvbkDsA/SR
	4qxCqpW7GBmFmxbMclNZHWO/OAw9hXAwmONnnGmohW2C7eGfdfz/dFFK+HEnicto+5R
X-Google-Smtp-Source: AGHT+IEiyPtAWgyu8zoCPimND9mRn/6YCnmBDMVc1DmVYS+iQJlok+y8D22roOKEWjuOJV17xvafEw==
X-Received: by 2002:a05:6a00:3d06:b0:725:cfd0:dffa with SMTP id d2e1a72fcca58-7290c0ee463mr28517272b3a.5.1734456312913;
        Tue, 17 Dec 2024 09:25:12 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcfecbsm6907193b3a.195.2024.12.17.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:25:12 -0800 (PST)
Date: Tue, 17 Dec 2024 22:55:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241217172502.borj2oy4rpxcteag@thinkpad>
References: <20241205172022.GA3053765@bhelgaas>
 <d976d74c-80c0-4446-bb9b-960a990c552b@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d976d74c-80c0-4446-bb9b-960a990c552b@foss.st.com>

On Tue, Dec 17, 2024 at 04:53:48PM +0100, Christian Bruel wrote:
> 
> > Makes sense.  What about phys, resets, etc?  I'm pretty sure a PHY
> > would be a per-Root Port thing, and some resets and wakeup signals
> > also.
> > 
> > For new drivers, I think we should start adding Root Port stanzas to
> > specifically associate those things with the Root Port, e.g.,
> > something like this?
> > 
> >    pcie@48400000 {
> >      compatible = "st,stm32mp25-pcie-rc";
> > 
> >      pcie@0,0 {
> >        reg = <0x0000 0 0 0 0>;
> >        phys = <&combophy PHY_TYPE_PCIE>;
> >        phy-names = "pcie-phy";
> >      };
> >    };
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml?id=v6.12#n111
> > is one binding that does this, others include apple,pcie.yaml,
> > brcm,stb-pcie.yaml, hisilicon,kirin-pcie.yaml.
> > 
> 
> On a second thought, moving the PHY to the root-port part would introduce a
> discrepancy with the pcie_ep binding, whereas the PHY is required on the
> pcie_ep node.
> 
> Even for the pcie_rc, the PHY is needed to enable the core_clk to access
> the PCIe core registers,
> 

But why that matters? You can still parse the child nodes, enable PHY and
configure PCIe registers.

> So that would make 2 different required PHY locations for RC and EP:
> 
>     pcie_rc: pcie@48400000 {
>       compatible = "st,stm32mp25-pcie-rc";
> 
>       pcie@0,0 {
>         reg = <0x0000 0 0 0 0>;
>         phys = <&combophy PHY_TYPE_PCIE>;
>         phy-names = "pcie-phy";
>       };
>     };
> 
>     pcie_ep pcie@48400000 {
>       compatible = "st,stm32mp25-pcie-ep";
>       phys = <&combophy PHY_TYPE_PCIE>;
>       phy-names = "pcie-phy";
>     };
> 
> Simplest seems to keep the PHY required for the pcie core regardless of the
> mode and keep the empty root port to split the design
> 

No please. Try to do the right thing from the start itself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

