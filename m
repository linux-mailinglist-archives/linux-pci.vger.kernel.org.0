Return-Path: <linux-pci+bounces-8038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CD8D3B2A
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D134B25C29
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9E18133A;
	Wed, 29 May 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9MADuwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D6181321
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997214; cv=none; b=eafyvqZDDhtLx1EBhudg0bzpNP020ykV95kijXh1JkP0Y8w87ZJ3xyvH8Bbt0F7TyvmMMzaMUrLMjE0jLqCa3Y9kJN0UR69fxVY+vujLUY9B6lIhFLyGslu56oa/p+8PWWa4GGFFGpt/L7JJZ3mSAZ3oBfBJpwh6NTdcvwLXpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997214; c=relaxed/simple;
	bh=IFOmGV0vWvRAZdlnTt5Bq1GYCYOnDFt46fVjLLHhJTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giqQcIqdbNwfDOeCLnR3VYvCyIbgp6I2eVwclJ9663dkrzgLMZ5Lvq09vvIbGZEtJNer3+A43sJ3E7nl4W+vCstgAfXXvZ6JyAwq4aj90EGU1UWdDEsbAGQeeYsLySWpY5Uqf5HE18UJnTC+I1uaDCgVMadibKueb1WqOGKcDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9MADuwM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so1912311b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716997212; x=1717602012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LzVA10vObpsycwyiswICs0XaduWj1dQ93AUm+q0MDso=;
        b=a9MADuwMmqJuWBf7kgz0ijiZv3nl1YITi7of8gb/HT7x+TgvC7ZAQWzVAJ23CSRT/9
         yma3Jn6g7O3z+s3SlLbLrdd7v1kgNp4a975aRe4oscb93VKPO1VEgvEPDNaar1tHyjCU
         BXAg1XuO8PzweIzFf/hM/COe7a5biVM0qaVpgMQVx4QGd/EQrk3w3BsYbWXUAZxTDIqW
         1atctWVIFeii/1ORr1Eq43Cl6iH1mCrFAkQm276H2DXVu9t8+EQrj7k02JcuMg6+eWvH
         crCmI4IkL6mzHBii4sCci7E/QUViF6Ca8VwcXWLlQdaHBI0923V4cjAvIJiDqdgPulnb
         lGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997212; x=1717602012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzVA10vObpsycwyiswICs0XaduWj1dQ93AUm+q0MDso=;
        b=SP52g6PZjMxfyYnwLNkmVr5OqPFyDe7lK2uA97KXqcGxHQjVWLvmZinFOAF60fx7mT
         m0uu2cqxeRTH6haMNAvrWyaZo41GXjNB1JCB9Fqbo7szKrhlMWmn/dfROcJsQWYZku6a
         owdYsI6GxK0NagctSmq0Hp259EzR4AFISN7quu3bh56WJLSGzti9FLU9xXguCFzIEE5I
         JNDognGA4o+tbQyW9Guso7Fpzr/nEKh6+iA1bWEn21RYjtx+KT7Io9ulzbX+32rWwQno
         zVZYpzUKxbkwNHVB2ydtLPWrVW0xRsYpUa8sb6E0HAMrr0OjLZqpjgr/tCKhJnpPIszl
         fz8A==
X-Forwarded-Encrypted: i=1; AJvYcCUSwfBJITvAKDAQDiZmKpgDLbgxJZuliAHhiiYiZOH26E8wimchDDDTmhrzfd6p1EuPdzBeFCrcc75eU4aOkQHjOnOo3IoXbSVh
X-Gm-Message-State: AOJu0YxHN7+Sqq0qXSiXdAFIZb5zibujmsdZ8mlxHEQpR4fFDLqCc3m6
	ItLMP970CLV1tfWCQyNrWpNSDVlWJau76RauhpatUFxl70KaXI0vcm17aebqvg==
X-Google-Smtp-Source: AGHT+IFBxlW4PTpknwYur8HAS9MbsWapQZBU+AtNJ5LUuRrt5ilj0v9pHL2t9Y9gTIink6slxwHAKw==
X-Received: by 2002:a05:6a00:4c82:b0:6ea:df65:ff7d with SMTP id d2e1a72fcca58-6f8f32a9bf1mr17969693b3a.10.1716997211761;
        Wed, 29 May 2024 08:40:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682226fc4dcsm9294199a12.42.2024.05.29.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:40:11 -0700 (PDT)
Date: Wed, 29 May 2024 21:10:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <20240529154006.GB3293@thinkpad>
References: <ZlYt1DvhcK-ePwXU@ryzen.lan>
 <20240528195539.GA458945@bhelgaas>
 <Zlba0OfNCGecFYj8@ryzen.lan>
 <20240529141614.GA3293@thinkpad>
 <ZldBwUwyekUM-b9i@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZldBwUwyekUM-b9i@ryzen.lan>

On Wed, May 29, 2024 at 04:54:57PM +0200, Niklas Cassel wrote:
> On Wed, May 29, 2024 at 07:46:14PM +0530, Manivannan Sadhasivam wrote:
> > 
> > That's fine. Thanks a lot for stepping in to fix the build issue. I was on
> > vacation, so couldn't act on your query/series promptly.
> 
> Welcome back ;)
> 
> 
> > 
> > Let us conclude the fix here itself as we have more than 1 threads going on.
> > I did consider adding the stubs to pci-epc.h, but only the deinit API requires
> > that. So I thought it will look odd to add stub for only one function, that too
> > for one of the two variants (init/deinit).
> > 
> > So I went ahead with the ugly (yes) conditional for the deinit_notify API.
> > 
> > Ideally, I would've expected both dwc and EP subsystem to provide stubs for the
> > APIs used by the common driver (host and EP). But since the controller drivers
> > were using the conditional check to differentiate between host and EP mode,
> > compilers were smart enough to spot the dead functions and removes them. So
> > there were no reports so far.
> > 
> > But in this case, the pci_epc_deinit_notify() is called in a separate helper and
> > hence the issue.
> > 
> > So to conclude, I think it is best if we can add stub just for
> > pci_epc_deinit_notify() in pci-epc.h and get rid of the dummy
> > dw_pcie_ep_init_notify() wrapper to make the init/deinit API usage consistent.
> > 
> > Also I do not want to remove the wrapper for dw_pcie_ep_linkup() since its
> > conterpart dw_pcie_ep_linkdown() is required.
> 
> I see, sounds good.
> 
> However, if we add a stub for pci_epc_deinit_notify(), it makes sense to also
> add a stub for pci_epc_init_notify(). (I'm quite sure tegra will fail to link
> if you change it from dw_pcie_ep_init_notify() to pci_epc_init_notify()
> otherwise.)
> 

No it doesn't. Reason is, the EP IRQ handler itself gets optimized out due to
the CONFIG_PCIE_TEGRA194_EP check in tegra_pcie_dw_probe().

> We should probably also address Bjorn comment:
> "ls and qcom even use *both*: pci_epc_linkdown() but dw_pcie_ep_linkup()."
> 
> As far as I can tell, it is only ls (not sure why Bjorn also mentioned qcom):
> drivers/pci/controller/dwc/pci-layerscape-ep.c:         pci_epc_linkdown(pci->ep.epc);
> But this should probably also be fixed to use dw_pcie_ep_linkdown().
> 

Agree. I will fix that also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

