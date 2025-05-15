Return-Path: <linux-pci+bounces-27781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C20AB8506
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC411BC20F6
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2F298245;
	Thu, 15 May 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BroJG+gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA61819
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308848; cv=none; b=VE92Fk2n6z9EntvEexWc2V+tgCdYxgrR6RV/zc05o7XqXnzULfyczTo1sDKQ1n1Vh0y4a2UKuAlsIOzkR6Tlzeiisb6KEgcW2V20qoEjOTLLO9vQS/lSTnMHVuEjglCMMlBpazEvBWs24XWDpd7PLX4Jz4dMBjTaFqwPY0zq6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308848; c=relaxed/simple;
	bh=7+LcErtOI1nFXpZU0Rnztgx5X/pwtGQnCWrKPIFskJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACrvCnJndmT5thVXsMdA0qGMEDafNhMp1Xar+Q4kmbN9OCR8RaeLQlukiF9f27x+4uAfWY8SVkO14fWBc8Jw3IgNxZu8v/HFdh8hVthJCOnapfzMnnjHGZcw5Fu7nmr018FOqV873tdOHaFf+cJumM3OCH+5Cxs5bVUfYg0aai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BroJG+gb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so11689415e9.0
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747308844; x=1747913644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=98/YbywBcXa3bCYk1LSZyotuk6UHXpn6YTL3rzPy1R4=;
        b=BroJG+gbt8NPY47x3lrxw+r/0yZHgU0YoF+ACJ3UYElZwCtVby1cHB3hvEVf2gFRtc
         UZQam4J+NGnXuwt0J07ZZPy4PyzQlGBhuwy+/rRWpNjTtoBMXqlzBhow5EPIxG/h9/7r
         y9oV4MQRDitGvTU2mjTWh5LjDi4YnqKXMAE26CHZtSKhQ9RQGBPMBjYW7UDs+xr5KiIz
         4qncH/LW+mUZHJV1/t5V3lU+ZpP05xnbULuy3Zvz6QfEaCOQOPXnWB1lY9tAuivzulJm
         poRphBU+SjOpe7UBQmxWnGL4LWQ6yFspvI9EkwhNV/mzfZkGPM4c9/6uHoEsSPQHAaYa
         QwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308844; x=1747913644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98/YbywBcXa3bCYk1LSZyotuk6UHXpn6YTL3rzPy1R4=;
        b=RSn+NtGrGVbTeltTJK+uinMVpyBGjoCYpz3PVu/FOvk4rqUxJr+kDADe8fk61M9cdf
         0ukvyVuq+hGHex67srh0wUVHuYpXvxFQYG8O46gvtU5+XCGcIL/kPsPvMaHPCEqZI6mB
         hH5FUrAt4qXF7Fpj+TqjHV/qL+ta0H8nP0hcz0V9GA+CwHL0fZrW/pw6NVrmATU0EQc4
         0WWdUtmPA5XNsv+wqnpypSObKz8wIJaAFM8m+YnRpTxLcbLCGEWwLU9gTE1ZcKpCabH4
         3eBGOp3qZLXSDel7KJo72BVqyqjK1T/BYHUcSGNKpx2bSVe4/FusBKQDNHf4Pw1s8V8I
         iEKA==
X-Forwarded-Encrypted: i=1; AJvYcCXPMX8sRuy3/0uVGhD18OwXnfvLrh6rSlJnySbBZb3R4PIKAfIj70/waF5Qrl08+DI5MAhx4jXxSW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZSYQmsfHPS2TOCOUA0JFax9ddCtI/JKlcuEvOJUkwvsLVskx
	b6Ys/JLOBf3QObnrlYsm4xiHIJZduBW0eHQHmnuteu75bLq3110indBztaUaAQ==
X-Gm-Gg: ASbGncusfcNNPsqxmURjkr0hf31PEiV7vGNWKzFcamgDG9ibHhfHtcBa1fHo601MhB6
	CTnRaRdOY1tZuS33h2Yr+zPUXEBw0eVev7jTVSVmvXIxB3+GjksDkiAFPFSWv2tOZOYVzLSmaK9
	qubg5007n9Q2skaQU6D8pQkd1uTnJRAYk+TBMIvpRQLPzK8MlD5zep8YchBweamvvbdjy1qDOPw
	GDeXWz4/8MdCodrB0mN2TQOc/0ytHf2e3Cem3oAFGo+wKDYh1Cvdrxe1BS/FRG499GSnTDAsRe7
	MyE4uCY0jH9rwj/soz1C5YoHflL2y42MPgmvgi7L17mZv3j7NYsYI99/kKR2D4AWkKIMiYsb/yw
	UiiA8h/RxALNNvw==
X-Google-Smtp-Source: AGHT+IGS0y1s75v6MoXkkoAkzaCFl9AOH+xLlK5hMP3H1elKbtTAhzDq+G0r/OXCG71L82GXmpSfxw==
X-Received: by 2002:a05:600c:828e:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-442f850c4f5mr32380145e9.13.1747308844028;
        Thu, 15 May 2025 04:34:04 -0700 (PDT)
Received: from thinkpad (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db95sm67146915e9.10.2025.05.15.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:34:03 -0700 (PDT)
Date: Thu, 15 May 2025 12:33:59 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, Vidya Sagar <vidyas@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <6xtdhtiy7bypq36wx5pvaye6oc5wo4os4w37ylrmhcfhwrzcgb@55vxzrwrjh7r>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
 <174722268141.85510.14696275121588719556.b4-ty@kernel.org>
 <aCSUfiwnZRTgMKGT@ryzen>
 <aCSX5gKsehupIC35@vaman>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCSX5gKsehupIC35@vaman>

On Wed, May 14, 2025 at 02:17:26PM +0100, Vinod Koul wrote:
> On 14-05-25, 15:02, Niklas Cassel wrote:
> > Hello Vinod, Krzysztof,
> > 
> > On Wed, May 14, 2025 at 12:38:01PM +0100, Vinod Koul wrote:
> > > 
> > > On Thu, 08 May 2025 10:49:22 +0530, Vidya Sagar wrote:
> > > > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > > > check for the Tegra194 PCIe controller, allowing it to be built on
> > > > Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> > > > by requiring ARM64 or COMPILE_TEST.
> > > > 
> > > > 
> > > 
> > > Applied, thanks!
> > > 
> > > [1/1] PCI: dwc: tegra194: Broaden architecture dependency
> > >       (no commit info)
> > > [1/1] phy: tegra: p2u: Broaden architecture dependency
> > >       commit: 0c22287319741b4e7c7beaedac1f14fbe01a03b9
> > > 
> > > Best regards,
> > > -- 
> > 
> > I see that Vinod has queued patch 1/2.
> > 
> > Please don't forget that this series requires coordination.
> > 
> > There are many ways to solve it.
> > 
> > 1) One tree takes both patches.
> > 
> > 2) PHY tree puts the PHY patch on an immutable branch with just that
> > commit, and PCI merges that branch, so the same SHA1 of the PHY patch
> > is in both trees.
> > 
> > 3) Send PHY patch for the upcoming merge window. Send PCI patch for
> > merge window + 1.
> 
> 1, 3 works for me, for 2 pls let me know, I need to prep a branch with
> this patch and tag on it...
> 

Feel free to take the patch 1 through PHY tree with:

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I believe there should be no conflict with the PCI tree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

