Return-Path: <linux-pci+bounces-14185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9B9983E6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5EB1C2196F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48B1BF7E5;
	Thu, 10 Oct 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRp6KLrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4919E7D0
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556623; cv=none; b=CWE69EfW9CrK1B/7OF6D8ik4U9Txn/U6PKlXHTskZiYJOwqha9dHNmQeo1Iy1H748jv634nfONa/xFRfhx27w92IpfhVK4TTt3BpTNZw0ZNlzcPmmdNAwDv4bJFD+CCHyxiy/LFeL0BNynrLLbc0XfitCqlAIL2ClGfe6g/6fEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556623; c=relaxed/simple;
	bh=xrcCvr6cYjS1RxxuNWmLWKg9qlwjebDzFF2vbBSibn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV0hexrs6ao22B7vr5hm7mcZkf6C2VwfMSKhrc1Gm9UHdK4PLDZrMaq2a0R9A8qq88aPpMUvWPWZKf3T3wf+yINmsKCyGglURWGFcjkRCLOl52taPAypE47T8oHwNGrtwzBwOjdnF9XU/DkjXqP8po4E5d8iFvMyF3SKQkpm0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRp6KLrY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7259be6fso8076885ad.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728556621; x=1729161421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qCYAf6ESDJaF8h/E6C6LcLUhPQEg3bLqnr89jUbXqs4=;
        b=dRp6KLrYxbQkjm0EVlAHewrWm8jIpespDQvNOHdj39RbD4g284tzjr0Pc5jhUzQt1I
         ZoXihGEDk7gMASvTKGk14NSW3S/1ddbe4KDRMbW0PWgySDNnMYgAXuatL6mASNjJd9fv
         1nEr5D6WbuHTFGo8NX/HaPkFk23yQoyQaPSZ+D/Kohc5p3NQCVkiwBPwdSpwCHTcgEAU
         hyOkIlKlB5LzmuxmFhiIqbLPtJRzqZcKsajk/ghkQN6BSDSB1Ad5wiZwbpzOPkrLs5C+
         aRCOxBdJlLo9rNwm5GDlOJha8WZnvrYEwuJy+dPh2nzx8JvtA0yNsOHM9/t1sJ4Fq/k7
         l8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556621; x=1729161421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCYAf6ESDJaF8h/E6C6LcLUhPQEg3bLqnr89jUbXqs4=;
        b=ZQeO8bVUAOy0IByeVJdMAJ5Uh0ZYqazRni6MkWEufqAJmwDBF79gWVQINCi9nT5qDX
         oNSmxcdOcTEhRd1mlhDoguX80R1Ol72DKByHghCdaQIagbqe6JT+S+UscOKdAaWQg+rs
         cpWIiM9Uqds1BRssYF2XZw72hpm1Zk7yiJ/jHBk5y3ECmXJo7JqE6B1E0KER8G+C5llU
         v111cWUaq3tHgQdkvunM5Rf7nb9Tm7woXT3GJMdvMbSylKBLlfJYK0C+cHgaJY6ndAX9
         mw2XV0pIQqU+pPWD2/60oBj6cyKPB7ZGDSDC2mhE6lrsnkwPthm57boQXN/pCJpuK1nr
         Cx7w==
X-Forwarded-Encrypted: i=1; AJvYcCVdHu1+jw9olEFTx0pQfRtP6sp6/dhLrFotDUN6XryeNDXV//fFQPGHVkf+Ll1+B3v0F3UZ1vNtUPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFft76aZ40x++QOBYlm7eAsA99oXjtqJktzCY1TXeVxQjTeZPB
	16HwyOOHtClhu6Vbz2/ch1vhh97S++m27GvJnqIPkjpsvYziBEAcRuUU5wy8IUXalzR2ut4Vmvc
	=
X-Google-Smtp-Source: AGHT+IEwmkW/UOhppKl/eNVEZv+OwfFQ3W7u6qUF28b6WfCwiMcxAelS1R2T42W7e+n6yhRW56O8LA==
X-Received: by 2002:a17:902:d2d1:b0:20c:5698:75bc with SMTP id d9443c01a7336-20c637992bdmr64864145ad.60.1728556621085;
        Thu, 10 Oct 2024 03:37:01 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1c39fsm7234845ad.92.2024.10.10.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:37:00 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:06:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 01/12] PCI: rockchip-ep: Fix address translation unit
 programming
Message-ID: <20241010103654.3qmsdtymto55nfl4@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-2-dlemoal@kernel.org>
 <20241010070242.3i2f53kpdpr4fgl6@thinkpad>
 <016bb5a6-5f05-404c-acaf-e0a3ed6fcede@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016bb5a6-5f05-404c-acaf-e0a3ed6fcede@kernel.org>

On Thu, Oct 10, 2024 at 05:41:56PM +0900, Damien Le Moal wrote:
> On 2024/10/10 16:02, Manivannan Sadhasivam wrote:
> > On Mon, Oct 07, 2024 at 01:12:07PM +0900, Damien Le Moal wrote:
> >> The rockchip PCIe endpoint controller handles PCIe transfers addresses
> >> by masking the lower bits of the programmed PCI address and using the
> >> same number of lower bits masked from the CPU address space used for the
> >> mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
> >> the number of bits masked is the number of address bits changing in the
> >> address range [pci_addr..pci_addr + size - 1].
> >>
> >> However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
> >> using the size of the mapping, resulting in an incorrect number of mask
> >> bits depending on the value of the PCI address to map.
> >>
> >> Fix this by introducing the helper function
> >> rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
> >> mask bits to use to program the address translation unit. The number of
> >> mask bits iscalculated depending on both the PCI address and size of the
> >> mapping, and clamped between 8 and 20 using the macros
> >> ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS.
> >>
> > 
> > How did you end up with these clamping values? Are the values (at least MAX
> > applicable to all SoCs)?
> > 
> > Btw, it would be helpful if you referenced the TRM and the section that
> > describes the outbound mapping. I'm able to find the reference:
> > 
> > Rockchip RK3399 TRM V1.3 Part2, Section 17.5.5.1.1
> 
> OK. Will add that.
> 
> I really appreciate very much all the reviews you are sending, but given that
> this patch series depends on the series "[PATCH v4 0/7] Improve PCI memory
> mapping API", could we start with that one and get it queued ASAP ?
> 

Sure. Sorry for being late btw. Personal errands are eating up the review time.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

