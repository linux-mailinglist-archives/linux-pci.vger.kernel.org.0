Return-Path: <linux-pci+bounces-14398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B054D99B4C8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E1AB21837
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285C16BE1C;
	Sat, 12 Oct 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYUgf64M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D974145A19
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728735160; cv=none; b=fPKccUI/uNYLlPDJq4+JyHpFszumiANIH/vlLy418KCC3U8jtFiWSEsI53+yPbWBcTPDhu9InlKGAsjD5BRBU+bWCb62TJZmnlnmFRMpGndw2nh7tV8C2Zbs/m4jmWp3yjKgouzVYgt8AoajKhXd0kCHDMoH7YDgfhccU/8F5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728735160; c=relaxed/simple;
	bh=bLMNDWnEogF9s5f7XKNsSDnFY3X4yw+Fr0M9XvpqsOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6mjiFIWbc2hhnkuMt89MNW/GwHw8nx4e+QAw5ZlrLCriz8wSrB7dUZJRrKy8ldoh8vNB9tn3KAJa8mC9ISYkYTfoBhu+1g/CAvB08C/7Rw6ydNNDoUuAxrI3gcmz1HncXiTlemqBY5DmBBY9S3bcD6BZYUDOYlto+Kluu5L0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iYUgf64M; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2175539a12.2
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728735159; x=1729339959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21O66+SU3YfelK3nlXJ5Y2o3jZna0jsz3r+miBWwveA=;
        b=iYUgf64Mlbg29oE3cxm1KkUDVwdnd5heDxXhnt/0HRHGoI1amljY5IYw8ESESx/PXR
         UtNbUB7/cc0G1FNaK7SvdWfO1CX1NhG130MIrHfg0Ku95GgMA6quelew9+x1SiFhOfTN
         EyzZSm13XRmj3JFw+hXALARQTEezfZwkKLuGuDECbfLC4syjktbB536xJ8sxkzlbR3qs
         O0qutr2boaYCyv2oiZvf3e/KjgkHK+/x5vGxJ7FsnrYy/c9c4xd+PC6nwfJbSYFKmz2E
         gg/7yOMk+9Z8x/28ZrrwaZW/YtTe75hWQnuL0HQYSBGgw44lOgMM5KbzQjNmBMEtcrzm
         EhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728735159; x=1729339959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21O66+SU3YfelK3nlXJ5Y2o3jZna0jsz3r+miBWwveA=;
        b=L3v8Fefh10MY/kC9xyt8HvIgvIZ8u4rVLVvIR6ABwBDe2MHPvvhq0RQzioE5xKsxmd
         EStaRbq9fxy5rEqqtt9/e+eX8QxkRWKG65sc+TOtvhq9ZHPku3WEoYeETRh7kUf2jXp0
         gbcL/oKndC1XAqACwufvVkJMtM/c9a/ZvMMAq5GWOPmaXEmEWCmHn6KfxRPT5Ru7R1dF
         jxSex0NOBanZGWMKjFI8AVe+CyIY3BRi/sF+WjF/LCcidvZ6kIQ1AZXtp3CQKDEzpFes
         XLEst7MBp2Hlrn110bJkoqeXdR252vGYylTv6XPkUdIwhnVC1EYPGEvJKfsiEJx0Q8Yk
         36Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVBecu1GA8Z4JQ2gU91FO0kaOOIlOKC4YSS/yvrskSEDrUrk35xjv1RgWvvmtZxbE3093faehFvOOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgDFRAaPD5V5X7wVJtRRtT9A1yLqQbd8lHF2EuLZKaKh1B7Vu
	D6TCSP1oaJsOiKzvmx0HhprFilrCI7G6HfOgfU/ufEt6du1m1vS/IUtnnnPFgg==
X-Google-Smtp-Source: AGHT+IG9vPOVD8vUEqJwuKkm3f16T3uzMK7nqJJkJNeda4s7TAV4woX7mMgayOACf8Ywhe0NJfW+nw==
X-Received: by 2002:a17:90a:e00e:b0:2e2:ede0:91c with SMTP id 98e67ed59e1d1-2e2f0dc2e8cmr7840262a91.36.1728735158763;
        Sat, 12 Oct 2024 05:12:38 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeb093sm4919451a91.23.2024.10.12.05.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 05:12:38 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:42:31 +0530
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
Subject: Re: [PATCH v3 07/12] PCI: rockchip-ep: Refactor
 rockchip_pcie_ep_probe() MSI-X hiding
Message-ID: <20241012121231.glddtpfjmsu6wiwz@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-8-dlemoal@kernel.org>
 <20241010072512.f7e4kdqcfe5okcvg@thinkpad>
 <11cf07c7-08d6-425d-9590-1afab6d052d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11cf07c7-08d6-425d-9590-1afab6d052d2@kernel.org>

On Fri, Oct 11, 2024 at 05:25:56PM +0900, Damien Le Moal wrote:
> On 10/10/24 16:25, Manivannan Sadhasivam wrote:
> > On Mon, Oct 07, 2024 at 01:12:13PM +0900, Damien Le Moal wrote:
> >> Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
> >> to its own function, rockchip_pcie_ep_hide_msix_cap(). No functional
> >> changes.
> >>
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Btw, can someone from Rockchip confirm if this hiding is necessary for all the
> > SoCs? It looks to me like an SoC quirk.
> 
> All SoCs ? Are there several versions of the RK3399 ?

There seems to be some:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=296602b8e5f7

> As far as I know, there is only one. This is unlike the designware IP block used
> in the RK3588 which can also be found in other SoC and may have some variations
> due to different synthesis parameters.
> 

But anyway, let's keep the quirk until we hear otherwise.

- Mani

> -- 
> Damien Le Moal
> Western Digital Research

-- 
மணிவண்ணன் சதாசிவம்

