Return-Path: <linux-pci+bounces-14509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FA99DD37
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 06:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF8FB21BCD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 04:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55416A382;
	Tue, 15 Oct 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/pUaM1t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB843ACB
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967149; cv=none; b=GWvTf4iggbvI8rZDe1ZPdFWGmMkmFlM6hU9j3YVE6/qFzwfQ5yDoGw6a+lx5596VtsYTi7R8Yvpwolv2Caq7kpDamzAN7NlQSk8KG+3PopheBL9v6tAKwuqAks0cjVq3jQtRUYD92LrLGd7BgTD+hgabaLByg2HN072+ok9+q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967149; c=relaxed/simple;
	bh=jh7xylnB3sPgYnLH/Q8khd5/Ku8vuL8jppv2JExA6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXhhfA4C0ZSP7Big0ec9SeBR/L6c89IeoQ9/MvvUxNtG4JVUU3ODHHHmfBc8xsyPWtBkrxLkGNS8e2MGpK6xcecYfmh0phMxw6Kw9MkgPkE66tigM74msxPy/D04jCKp0JrvVI6CWHwRl30UTGBGuLmyeqDfa8VEbPCQwLEASyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/pUaM1t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso3236946a91.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728967147; x=1729571947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJynfKVQDflANhJ64n4kOsY801zOhbhkmmcsAv5LdWE=;
        b=b/pUaM1tDC6gLxEvqhCZ25c88NP/qOKi8dqhSGWWb3u/6JY0gDEamTxDhcejl/Oxkg
         CPuI8mxtM6zwhWtoPPoFy0zS53Kiw/O9+MRvalr6E2DzKWUchDMM7ktsPGAdq0cBq9EB
         OSbV4tYH+MAc6rvz0lC5+w8ywZb5wrw0u0ds9el1c7kYC6aK+df9bosppq/LjYYXJRWe
         yplqrGsA+wAqc1ceYV6SsWHaVDUk4RNyJCmCS3KIIpwPtm9Yxv0SuYIumlnmud2ybOYm
         +zl/TPGUxkdOsENKH95bl/cV/lfCGsDC3yfoQPp8llSSRoDn4UJANEcx/A7kobzoaYj3
         0bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728967147; x=1729571947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJynfKVQDflANhJ64n4kOsY801zOhbhkmmcsAv5LdWE=;
        b=J9LDuYd9rfXLbukcFbAUXBGRouVzRTJRHGB+jVZZsj6961TCl6ys3vZ4pQJ75v+Q5v
         +A1aoPK0R/K6yk5GdfBSrTs9ZGU+J9ngYyjphM9uxLrD2KVWS1Tn3Y5Ya0awXfO3jzUq
         VFe63Rv2WTGgjIHKGxL/kwbR9za4oNiCa9pBjrQX3pN1KeTe9Vn1mgpsj7vTEeftj2Mo
         xkuqo181/b9KA95b8zUMBnwyhUfl8SAM54Ib0l8XbSzY1a0nJcftXjcey8OmAHKCbFuK
         p1Do4BiATqZ9g/LmRx13PnykTQkZH8EnCNPg/RWUTIALUM4GNtVh2WZv0MwpiSJSJr65
         gezg==
X-Forwarded-Encrypted: i=1; AJvYcCUxBRXqhRw75rJIdRUAlN5KWv+YuhfoQsGELRCiQdhw4pBau4ZiwE1Z9mQ7unTAhFkelN1028XWlvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYqJreZxJsdr353GXQa33B4SIbIM5slOhJFpvQOPOLOWtbhxa
	xjsYTslNZDyDrMQvG83VNWMJesU5xHpbSAIgHYkaKdlwZb+Aoa4bJMFiIEhPfA==
X-Google-Smtp-Source: AGHT+IEr7R59FAO98rpKKUVnCK37geRIvg8ePNXNuf3uQK5yL+pqDgFHGRuED+RGAhFDNXIrmDMgaQ==
X-Received: by 2002:a17:90a:784f:b0:2d3:c976:dd80 with SMTP id 98e67ed59e1d1-2e2f0da0e7bmr16506702a91.39.1728967146745;
        Mon, 14 Oct 2024 21:39:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f62c21sm484160a91.46.2024.10.14.21.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 21:39:06 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:09:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241015043901.gys454ykv7lgwtvm@thinkpad>
References: <20241014174817.i4yrjozmfbdrm3md@thinkpad>
 <20241014180841.GA613986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014180841.GA613986@bhelgaas>

On Mon, Oct 14, 2024 at 01:08:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 11:18:17PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > > > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > > > bridge device. To enable runtime PM of PCIe host bridge device (child
> > > > device), it is must to enable parent device's runtime PM to avoid seeing
> > > > the below warning from PM core:
> > > > 
> > > > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > > > with active children
> > > > 
> > > > Fix this issue by enabling starfive pcie controller device's runtime PM
> > > > before calling pci_host_probe() in plda_pcie_host_init().
> > > > 
> > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > I want this in the same series as Krishna's patch to turn on runtime
> > > PM of host bridges.  That's how I know they need to be applied in
> > > order.  If they're not in the same series, they're likely to be
> > > applied out of order.
> > 
> > There is no harm in applying this patch on its own. It fixes a legit
> > issue of enabling the parent runtime PM before the child as required
> > by the PM core. Rest of the controller drivers follow the same
> > pattern.
> > 
> > I fail to understand why you want this to be combined with Krishna's
> > patch. That patch is only a trigger, but even without that patch the
> > issue still exists (not user visible ofc).
> 
> I don't want it *combined* with Krishna's patch.
> 
> I want this applied *before* Krishna's patch because if we apply
> Krishna's patch first, we have some interval where we report the
> "Enabling runtime PM for inactive device with active children" error.
> 

No, I was asking why can't this be applied *first* and then Kirshna's patch? Why
do you want this to be again resent in a separate series?

Both patches are in a mergeable state already. So they can be applied in order.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

