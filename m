Return-Path: <linux-pci+bounces-19134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734079FF156
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 19:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F731881204
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1B2AE8C;
	Tue, 31 Dec 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfDdlI4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023717BA9
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735670963; cv=none; b=gSODEIZiwdSDm0Sk3iQxpNlj8Xhzsh8chc9PomJDyJcdcUDTCkPoilHdONR/5D/8JFrEj4KkhoWoP7I8PL8HQjnSgbXA55T7X8CU89KWSFwwnYS0rLoKaZ5GU/eqVe/qLlrhn+REagkMby99K5Z+OU7/unohq4eHbHZ4ZXjkCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735670963; c=relaxed/simple;
	bh=lQHUsMftatnTmSSlNLmb4sAl6RHvstyviIaWWEhCQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6Bzv46FlkM3NUtWRVjENMhq4C4EsMiZCHEwt0SSVmJd2E19JurmbK5labsCbAqydpAbLxxF6RV3xig5FHccqJKHJMh5U01FEUyMMAzLRxP6Nm0aeO8XkZM91XYN6WFlvQQeSyAOph1j7j5a5msHxi32l8sDfveFxeGPs2fVp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfDdlI4/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f441791e40so11260917a91.3
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735670961; x=1736275761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7xZU56PC2QyLHG4Sizx7h7Jygszd+kVofn0qT/FHW/4=;
        b=EfDdlI4/gpqSs23tXYpeGbXzcE/J+mvr1XXnnfI5DJuIzGfxTxaxx6l87o+OzKZSXL
         1SyYieUNLCUmFU1ilHABfbQDuC/p4XT1QMQW81fHQSWFxhIj6SCUOaFShBIYL5hMtc8C
         5khfaqu2DGf/jTwVLHNdDx6HhbLanf7sT0/0ng0Dy/cib1Phgyv3vY3OuWEMy0p7MNCv
         0SL5OYTfXJwrwVk26WT5z63J9DwZ71sXwdhFm2nWnADUV1ZryYjjq+VvkAa9/5TuWXgB
         iEY2/RkEciKJ8bLW9c+WeEenVrSCKjvr9jIyeO7NSEceY3MHHpbBp/f4SPBKhxdGhD2Q
         7jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735670961; x=1736275761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xZU56PC2QyLHG4Sizx7h7Jygszd+kVofn0qT/FHW/4=;
        b=j7LWGkDbrCezePuKNqqDVK5GOBmKgzESegyRxp7YE8AcGBd1dy6EJiEWGO8ljSOW3s
         ntj4S3MpeqQfHxBBqvw0BZV78CjmO2zJR3PFbwRsuv9gq2H34DT4TDVic4S8gIuq7Lwe
         PLta0gKruV46QXPsJ/KmpqIn0pZ38NnwDOA8+YG6THvwbCRaHW+nCE8BkXoeuvcSUfu3
         0tQI2oexbtM83PzosRc/wsCisCNf2Ucdtdbsjuibb6ABI6XQ1U4V4fhka2uQN0lfwbDE
         Ygf15f8N7llP5Pox6Z0VnuCjPLhdfzQXAIl0C3X2ymgXCmJ1qBWrP3qH8UxC2vShW8L0
         fFrA==
X-Forwarded-Encrypted: i=1; AJvYcCWa+4ndiSutCHQufU5pm98rE1JJtpY1XoOthtHzjWS8o2YVB1BaRZ/46vGBDrbCPSo89eClVVD5XfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+rintDyn9OHvSdNRM3/tNRra0ApuMFl7R/OkgEVUuSCsFOq2
	FkAhkhJBL90Edq0x4nvJCFQ0Q9I9hLyVd3hRIuWZxiQgSZI13lmvNRYI3aA8YA==
X-Gm-Gg: ASbGncuxGdrv+kRjNcz4KxJ/NgXD+Kt0LkHut/sfAW2zMd0fDA09pmqx1j9489Fm7P+
	EdbZlIoQ6XMIy6P2phM5omiLXst8f1IZxNyOJN4VxVkSKF1YmC3fbpA3vy8jqcT9U2KSqQeIl5J
	yO+POsRpXKjEWqgULLpZjgRFeKz0BAtsdrZM2UqIUnzvVszPXHZf800GsD4+bPbprZEahAqv1yj
	Cc0/jjOM3VFH67LIt/zw93DhBQ1T+3Upim50rSEHMiqxp3pd/OU++FeW93m4NbfK18WSQ==
X-Google-Smtp-Source: AGHT+IHMbyqF/wP80oaWAz2pBDCyR8xcElMbWpRz51pIUjskvcfPBcJb+WkrCO9/WwUFSiHgw8s0TA==
X-Received: by 2002:a17:90b:2b86:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f452ee9d18mr60388424a91.35.1735670960801;
        Tue, 31 Dec 2024 10:49:20 -0800 (PST)
Received: from thinkpad ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447798934sm23145876a91.3.2024.12.31.10.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 10:49:20 -0800 (PST)
Date: Wed, 1 Jan 2025 00:19:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Reject a negative nr_irqs value in
 dw_pcie_edma_irq_verify()
Message-ID: <20241231184913.s24umoi2yi4wowod@thinkpad>
References: <20241220072328.351329-2-cassel@kernel.org>
 <20241231155158.5edodo2r5zar3tfe@thinkpad>
 <Z3Q0TY873woxmsEC@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3Q0TY873woxmsEC@ryzen>

On Tue, Dec 31, 2024 at 07:13:33PM +0100, Niklas Cassel wrote:
> On Tue, Dec 31, 2024 at 09:21:58PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 20, 2024 at 08:23:29AM +0100, Niklas Cassel wrote:
> > > Platforms that do not have (one or more) dedicated IRQs for the eDMA
> > > need to set nr_irqs to a non-zero value in their DWC glue driver.
> > > 
> > > Platforms that do have (one or more) dedicated IRQs do not need to
> > > initialize nr_irqs. DWC common code will automatically set nr_irqs.
> > > 
> > > Since a glue driver can initialize nr_irqs, dw_pcie_edma_irq_verify()
> > > should verify that nr_irqs, if non-zero, is a valid value. Thus, add a
> > > check in dw_pcie_edma_irq_verify() to reject a negative nr_irqs value.
> > > 
> > 
> > Why can't we make dw_edma_chip::nr_irqs unsigned?
> 
> dw_edma is defined in drivers/dma/dw-edma/dw-edma-core.h
> in struct dw_edma.
> 
> struct dw_pcie (defined in drivers/pci/controller/dwc/pcie-designware.h)
> simply has a struct dw_edma as a struct member.
> 
> If you bounce on nr_irqs in:
> drivers/dma/dw-edma/dw-edma-core.c
> and in
> drivers/dma/dw-edma/dw-edma-pcie.c
> you can see that this driver uses signed int for this everywhere.
> 
> I didn't feel like refactoring a whole DMA driver.
> 

There is no need to refactor. Both 'dma' and 'dwc' drivers do not assume that
'nr_irqs' is signed. So simply changing the type to 'unsigned int' is enough.
I don't see a valid reason to keep it signed and check for negative value.

> 
> dw_pcie_edma_irq_verify() is supposed to verify that nr_irqs is either
> initialized to a valid value by a DWC PCIe glue driver, or that common
> code initializes it.
> 

Yes, but the glue drivers do not set negative value explicitly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

