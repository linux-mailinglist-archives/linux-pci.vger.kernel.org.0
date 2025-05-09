Return-Path: <linux-pci+bounces-27493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B7AB0B41
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 09:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17162520412
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1192701B5;
	Fri,  9 May 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBmFxLYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F411270ECD
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774534; cv=none; b=J/hGoeAan9xcpe0saZEHrENpnJMB4ZaY6ZEZhG3KOrHlfLGUK25yG3kl5EVvLQuoQRG1G0oGDQ5u7PpXy41VCZ1aj8x+XRhic3+vqPjcxej1VwNRa6gyS1SvFKGCsoTVH3SQRO72k9uvkwWmYd4wXggEdslCYplTe7snZtPdGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774534; c=relaxed/simple;
	bh=oZnnaQahcN2zA4vvZs+wzg11udFQZV8cb83SiP8IQXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppSFXT+xqD99mF42Jj76gMAsvOwe8F5HKtOGS1S1HaF/7g9IBeI2UL8jXczlxy1zKazkWoOqHYZmaIIcu4lTzWzPDGW9nJc0xmv+cgiSsCWND3um7XDL5TIDFXoLPRtuvJ9ezdaUVHtW3qLhRXr/Wy57EN++pZFwECdapXyx5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GBmFxLYS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so20098815e9.1
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 00:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746774530; x=1747379330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77qkoKjDKq6SXETuhF5rMrUj8XsUUdj7U8eiTVCOHj0=;
        b=GBmFxLYSjCjfIfMTnXY09zej7BMiTYFQvhkBiY96e9Mb/6Qw2KfokBCwzvM0hb+CyX
         iLKfBMfxmdD8yYkIUGmBXKvTspn9YjEYzwvbPdmlHYEvfzzmFicQvnHU/+AgOpYi00G1
         SyY/66gpbyZ+L5B8NlStieSur/Thyn8IxZIl1R3V8bWYAU9BJUi3TYFZFdDp0DfzNdDc
         cC6ulrBISaNuBmBcVlkoDaTrxvwrKCbUF3uEleGNTIziez5fzemlETeSDIpYl2Zo0Q5j
         GrC2PTRt7gJftxSLw4RqJ1dJamPey3c1r4dnfGYrtYMhOoeaJ31WhJtB1lrRfKJpTQeF
         ee3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774530; x=1747379330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77qkoKjDKq6SXETuhF5rMrUj8XsUUdj7U8eiTVCOHj0=;
        b=Vd3WtZ+ndYHGVDvtmKas2V+oaTTmnZjfRqOHSaQMKYEDtG8l9qdZikC4BtwOVr+clq
         Sj1NhqkCQsxNuYpFOMMf65GQMPirDlEguFXzYJfOFTeV8/nocCit5LAjm+rESX3tHZ2+
         OgiLaA9fbniFBwRgJm185F2gp0y4kDXzgZaXI3RcsA4rZuy0/XqF6g51RS3MuMcAo5TC
         CRJQz9TNZLVTxbLMD2Teqf/yle3EqIIB85Ah6EBviy/MR/+JWRxEVw4guwUTN5r/8001
         tMfaXEhm1/SLBOvOUNuAY8wZHM9IB0Qgd57M8lBSbhWK3/eN4LFO1UpmH1lk4AfPpNpR
         cSHg==
X-Forwarded-Encrypted: i=1; AJvYcCU337VZFWykTnyt8amW56Zu982WfjGYOv9BYV61/vWfWobZK9lrZPltVbBfJrxhoVzW/YqYxzuuo/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4K5hy9svEgRQdFk01VhcLCd0EXEVqBZwnR14bvwhK9+S2Qlk
	OXMet7yA6hXaJXKq9L4Cqkkjip1W6zDMw721vp2pWbSTeR4CQD0mOOUy0VOdLw==
X-Gm-Gg: ASbGncvX+bFed2O7ytPPu5llO0mIm1iTK832lkUDJsFERJpkDOQhrezw8zaWWd5xaiZ
	VQ5fO/L4NtwlfnxuqS2l9gI+Z+vVIMHoT/0haAl0aaQx+v/+aEZ3GNAQvdwXrpwy03dhDzwIoZE
	oBWt276J1Bq0OSxnacdeXcLSzJZBDylKRYVoiDYf3bAXvznRcz3/3RPxNWwse0hyE2eOALcS5uE
	Otc5rEcTiDbOMRobXyi4gW8ggoipoLaMZq+6m6vDIyKphBTqFoJ94qD/Vxt3R7JXmNBW8zp+iI7
	JwQjV7AResM+VsHhVobfcsbxCI+Tu9JMa7Gdpi3Z0C0PrN+BcYxARg68yWxoWeEzKdoSfsLX3Eb
	HxjUZhnlD3f27ad98iImyFnY=
X-Google-Smtp-Source: AGHT+IHR5+ZqZWgRoRLa1o1Gg2Cvw+npoLGEsXcz8CnQxm7QZTBi9ul3cXloYS+TYHobQ2CzSJpuaQ==
X-Received: by 2002:a5d:5f51:0:b0:3a1:f563:f84e with SMTP id ffacd0b85a97d-3a1f6a4370emr1630423f8f.16.1746774530584;
        Fri, 09 May 2025 00:08:50 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde1asm2305688f8f.8.2025.05.09.00.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:08:49 -0700 (PDT)
Date: Fri, 9 May 2025 12:38:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de, yue.wang@amlogic.com, neil.armstrong@linaro.org, 
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507163620.53v5djmhj3ywrge2@pali>

On Wed, May 07, 2025 at 06:36:20PM +0200, Pali Rohár wrote:
> On Wednesday 07 May 2025 23:06:51 Hans Zhang wrote:
> > On 2025/5/7 23:03, Hans Zhang wrote:
> > > On 2025/5/7 01:41, Pali Rohár wrote:
> > > > On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
> > > > > The Aardvark PCIe controller enforces a fixed 512B payload size via
> > > > > PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
> > > > > core negotiations.
> > > > > 
> > > > > Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
> > > > > PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
> > > > > during device initialization, leveraging root port configurations and
> > > > > device-specific capabilities.
> > > > > 
> > > > > Aligning Aardvark with the unified MPS framework ensures consistency,
> > > > > avoids artificial constraints, and allows the hardware to operate at
> > > > > its maximum supported payload size while adhering to PCIe
> > > > > specifications.
> > > > > 
> > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > ---
> > > > >   drivers/pci/controller/pci-aardvark.c | 2 --
> > > > >   1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c
> > > > > b/drivers/pci/controller/pci-aardvark.c
> > > > > index a29796cce420..d8852892994a 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct
> > > > > advk_pcie *pcie)
> > > > >       reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > >       reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
> > > > >       reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> > > > > -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > >       reg &= ~PCI_EXP_DEVCTL_READRQ;
> > > > > -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
> > > > >       reg |= PCI_EXP_DEVCTL_READRQ_512B;
> > > > >       advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > > -- 
> > > > > 2.25.1
> > > > > 
> > > > 
> > > > Please do not remove this code. It is required part of the
> > > > initialization of the aardvark PCI controller at the specific phase,
> > > > as defined in the Armada 3700 Functional Specification.
> > > > 
> > > > There were reported more issues with those Armada PCIe controllers for
> > > > which were already sent patches to mailing list in last 5 years. But
> > > > unfortunately not all fixes were taken / applied yet.
> > > 
> > > Hi Pali,
> > > 
> > > I replied to you in version v2.
> > > 
> > > Is the maximum MPS supported by Armada 3700 512 bytes?
> 
> IIRC yes, 512-byte mode is supported. And I think in past I was testing
> some PCIe endpoint card which required 512-byte long payload and did not
> worked in 256-byte long mode (not sure if the card was not able to split
> transaction or something other was broken, it is quite longer time).
> 
> > > What are the default values of DevCap.MPS and DevCtl.MPS?
> 
> Do you mean values in the PCI-to-PCI bridge device of PCIe Root Port
> type?
> 
> Aardvark controller does not have the real HW PCI-to-PCI bridge device.
> There is only in-kernel emulation drivers/pci/pci-bridge-emul.c which
> create fake kernel PCI device in the hierarchy to make kernel and
> userspace happy. Yes, this is deviation from the PCIe standard but well,
> buggy HW is also HW.
> 
> And same applies for the pci-mvebu.c driver for older Marvell PCIe HW.
> 

Oh. Then this patch is not going to change the MPS setting of the root bus. But
that also means that there is a deviation in what the PCI core expects for a
root port and what is actually programmed in the hw.

Even in this MPS case, if the PCI core decides to scale down the MPS value of
the root port, then it won't be changed in the hw and the hw will continue to
work with 512B? Shouldn't the controller driver change the hw values based on
the values programmed by PCI core of the emul bridge?

But until that is fixed, this patch should be dropped.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

