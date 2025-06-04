Return-Path: <linux-pci+bounces-28986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF1AACE2CC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F05018913B7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903618DB24;
	Wed,  4 Jun 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYrKdtTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFD1E5B9E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057019; cv=none; b=WKpt75o1VP2WaJpuMX6hzR8Hqf5jMF0Lh/qUHqD4LLmigg7eezgbbItV9mZmk4iAGhjHoGMUIXXFNm15alZNanJoZwzGo5kMssJJ8rodrij6xQp/YLq98YM5lzeynPl1k3DBGOYGnHwnnfxP5tPUM7Wp31e7/K8QxHtdEkEfQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057019; c=relaxed/simple;
	bh=7vBr2iyMggTvBYe7YB+uVc387ytvwEfmWj5juqMnVls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZIuUyXgp5ecvZB7f0GiaXZnA/hziXmyG0jwoCuX4DF8K5LWzDILhXkYkPwHOFNtSxoptyBtGzB7wdB1PehugPkZMaLm0Cqm+QMd+luFUEgCwD32sKAOnKKVJ559uIyPJc4U9PCDgdZ0Vm4bUFyIDCUu/g83cLXBTvyBHAkuYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bYrKdtTn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74267c68c11so158823b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749057016; x=1749661816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/psGtim6qYd78+PihMTMNmgRMTiPXj9RR2qxzIsxV0=;
        b=bYrKdtTnf/s3weHcUoMfyGje9hS5PqODprKBwhjJVVzw5YGw7v7Zf+87Ir9ThR2MGT
         UvOaVNadVUkzrPsbK301Oyhq5dkSCgygBcIJnyDv67LwosG2mFrGl0s0HHuMY4XIhuAp
         XRQ6u4P3CS22jVn8PjRKyUwFi4+Um9zORuLhAHIQ8uimVj50rAETNOiKp8XP0YfdXaL9
         8ixgAurJOM/qFohzI0ESw3Jx7NvEZ0IH6BrrFU0AnJFk8oRHtaMb4y/+iM3v14Ec9yXX
         3ZhCAqz3BGxVBnN9zR2mXSiRo1AgibarJbThgsQsn353OZYuy5C1twI3yfsBRoVL2B2H
         HeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057016; x=1749661816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/psGtim6qYd78+PihMTMNmgRMTiPXj9RR2qxzIsxV0=;
        b=fcnEivaFSMV7yth9VZv7vDLa1+GQERxaCb7EWi0NR6fCdLKfZhBrNhMqevhmtwtuQD
         y4rNs3ax/X4T2NJe5rHMJjWwosR0fng2AjGo0ujzb9GG8W8uiuKm7DVGK3rzpE/DH+v4
         AmWGAPCRC6bMoCq8Ydjc+iiUOXIu+GIQTQqRq8kl9FY8aaKWBCR8RR35a2T87s9TFeEK
         GY+vyWDQJpj46HYXE8u7J0sGO0FB8Kz4/zMVbT+gN++7N70GxXOStOGTTQTmQXS2TIkz
         8bYFINnVfMLjdHhnErvmAz/za25Vu+BzUGNEL5/DJHwY3nFuMCGn4lM6Y+TGIbPTeoX7
         F9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW28HLK6JvawoPeDKBsA0xX9ulMXeDTJuI1yEkiOJa8hiRSl5odF19IqAbHD0dl24oieqNIpk4AMqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zJYXdVP0CcYrBPTNAsV/89dmsnVSeTveb7UnQ/KzvMerm54q
	3oM7IVia9kAlwGYRHbmdskp3hbjHu8ztBa2hH8GC2npswSB1m7MK1P7tdeWG38FXsw==
X-Gm-Gg: ASbGncvj1V22xZ1P3mQ46KVyHzKW1vkIuYd4xycLH3Osi1E4A+0uop/JnB72flW4YIR
	wAIx2zfnKvKYUMhMhhNJI6MmFZt9weejJby5W+57XJUEoYKXDxk6J8avTEIwj7VEc62N6Paj2uP
	ltwULdBgH0xk5tKhnHwnMu7Vb9m+Q2lXUCO7J73xyYGvBgchyUZNVLmTjWhgcTl9SELUDrhfljq
	Hoj1SFvvLDyBOSoSOOp/yqSjWLOTs7NYfo4d5MnYpFoBdKo/+NHbHgXP/yAFgLIH1A00a62s+JQ
	qSMwTXSSwtKbvbxAjbNuG3eYG5ybCdXMeWdh0o0+yiSHIejfFsmZqAx0LvDukQ==
X-Google-Smtp-Source: AGHT+IEOw6il7mDOYzfg80Vp5UmC2qNm3ax6rT9gftYx3483bHLkDut/HlymS/lHemQQjcW6U7fWaA==
X-Received: by 2002:a05:6a00:1823:b0:746:2591:e531 with SMTP id d2e1a72fcca58-7480b4974dfmr5191876b3a.12.1749057015947;
        Wed, 04 Jun 2025 10:10:15 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcfa0csm11731132b3a.131.2025.06.04.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:10:15 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:40:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <rrtrcwajj4vjvbqzosskdnroqnijzaafncgckoh2dlk3c4njvs@twop3vyidmh7>
References: <aD8Bz4CkdnAd8Col@ryzen>
 <20250603181250.GA473171@bhelgaas>
 <aEAwxFysCgdJCD54@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEAwxFysCgdJCD54@ryzen>

On Wed, Jun 04, 2025 at 01:40:52PM +0200, Niklas Cassel wrote:
> On Tue, Jun 03, 2025 at 01:12:50PM -0500, Bjorn Helgaas wrote:
> > 
> > Hmmm, sorry, I misinterpreted both 1/4 and 2/4.  I read them as "add
> > this delay so the PLEXTOR device works", but in fact, I think in both
> > cases, the delay is actually to enforce the PCIe r6.0, sec 6.6.1,
> > requirement for software to wait 100ms before issuing a config
> > request, and the fact that it makes PLEXTOR work is a side effect of
> > that.
> 
> Well, the Plextor NVMe drive used to work with previous kernels,
> but regressed.
> 
> But yes, the delay was added to enforce "PCIe r6.0, sec 6.6.1"
> requirement for software to wait 100ms, which once again makes
> the Plextor NVMe drive work.
> 
> 
> > 
> > The beginning of that 100ms delay is "exit from Conventional Reset"
> > (ports that support <= 5.0 GT/s) or "link training completes" (ports
> > that support > 5.0 GT/s).
> > 
> > I think we lack that 100ms delay in dwc drivers in general.  The only
> > generic dwc delay is in dw_pcie_host_init() via the LINK_WAIT_SLEEP_MS
> > in dw_pcie_wait_for_link(), but that doesn't count because it's
> > *before* the link comes up.  We have to wait 100ms *after* exiting
> > Conventional Reset or completing link training.
> 
> In dw_pcie_wait_for_link(), in the first iteration of the loop, the link
> will never be up (because the link was just started),
> dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
> before trying again.
> 
> Most likely the link training took way less than 100 ms, so most of those
> 90 ms will probably be after link training has completed.
> 
> That is most likely why Plextor worked on older kernels (which does not
> use the link up IRQ).
> 
> If we add a 100 ms sleep after wait_for_link(), then I suggest that we
> also reduce LINK_WAIT_SLEEP_MS to something shorter.
> 

No. The 900ms sleep is to make sure that we wait 1s before erroring out
assuming that the device is not present. This is mandated by the spec. So
irrespective of the delay we add *after* link up, we should try to detect the
link up for ~1s.

And for adding the delay, it should be done after the check for retry count:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b3615d125942..92eb661babeb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -700,6 +700,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
                return -ETIMEDOUT;
        }
 
+       msleep(PCIE_T_RRS_READY_MS);
+
        offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
        val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);

> 
> > 
> > We don't know when the exit from Conventional Reset was, but it was
> > certainly before the link came up.  In the absence of a timestamp for
> > exit from reset, starting the wait after link-up is probably the best
> > we can do.  This could be either after dw_pcie_wait_for_link() finds
> > the link up or when we handle the link-up interrupt.
> > 
> > Patches 1 and 2 would fix the link-up interrupt case.  I think we need
> > another patch for the dwc core for dw_pcie_wait_for_link().
> 
> I agree, sounds like a plan.
> 
> 
> > 
> > I wish I'd had time to spend on this and include patches 1 and 2, but
> > we're up against the merge window wire and I'll be out the end of this
> > week, so I think they'll have to wait.  It seems like something we can
> > still justify for v6.16 though.
> 
> I think it sounds good to target this as fixes for v6.16.
> 

Yeah. Atleast patch 1 is fixing a regression, so it should be included for
v6.16.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

