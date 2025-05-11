Return-Path: <linux-pci+bounces-27553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D2AB2751
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 10:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D482177F9D
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4291B042C;
	Sun, 11 May 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRAnEud2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFE191F66
	for <linux-pci@vger.kernel.org>; Sun, 11 May 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951906; cv=none; b=ggbMTKwOUaJRr6O5V675KX89l15JfywNF7uYqyp4jtd4DI/cAXNBihfVqj43bWDaCMAQgOYS55xmHUjf6xx7PUi+rhgi/cJJGop/qefqJ9c3tktQA7+NSK2794kdCkXpI0sv05xzTEPHnnD7lFAcTHmLKjN+nIVWXLMR4W8hsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951906; c=relaxed/simple;
	bh=axlzh8wdBSnRAj1XihJUWHBLhaR7tOyyavylk1fO3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D65H/3tpgz41G4j12Yn7wmm78BVDAegDqpeDu0MuKgbsNKspXaASYT9Em8LIh/DK6AG74hNiO9ttVeaw6tmnAb2pX4rFndyKSRyAtT/VcIaihN+Lpt7RRxJ4bguFvWPPkCjtZ/ccOmuUsYB+uWr/NIxWp67l4kJvEPLjkQtOQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRAnEud2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so35210535e9.1
        for <linux-pci@vger.kernel.org>; Sun, 11 May 2025 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746951903; x=1747556703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGDVeACw/jp0C4k4Wd6moCgif1Pfm842wvA1qG0yCD4=;
        b=FRAnEud2utrkUbirh9TSp5wX3z0gZ/03sP+PQwaYgJHnjzK6tJfkNH43xZwUN7xNuH
         6bukQ1Lw+crhXlZQcqRDzhR+1WoPv2gD9SF61oZMCkmELmwLQWGCR2qYz+C+GUzaT86i
         MBCRVTINCjFZwY5ZSNUAmZpUScykS0NsAKbpMQuYojUubW6n0vTZJkWi0Fc8PiYVd2Yw
         LDoa+eEWW8ujaXGfChYfLipTCDEeKG7MlNakw9doySGJVljmSJW+wHo3IFv0LacWnoXK
         PE22Tcc/wywX+znBEpiTuZjrvvaK0V9JADc83R2HgswqLr8OAaITRFeln5g9WRFJWbX/
         aVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746951903; x=1747556703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGDVeACw/jp0C4k4Wd6moCgif1Pfm842wvA1qG0yCD4=;
        b=RJRkoE5okAB8OlOIntHIw5seW/o341FqQoRZZPLTjkmqsZSI9LxZ9qpcsykRTYYvAV
         UpyUoKwhjujXGPH7oGG4NljBwxI6KCSLovp9ZMB+vb8TOutKLX0HIymZx72qIdzlMm1/
         J6Fhk0b0b/oQ0Uf0AEoV90LmB3WEbZRuNxj0qucvoy48XmghoENLBRyAtlgbR2VQKvPc
         7aByIzg5NKN0yh/1YWZIJOiYGvZFQYWwh9nQAzjS+PXl1FW57OlsyFiHq1HleoOPepSn
         26pDBKPV8rV4l52wMgtc6hocyJnCEGkD2oNTWjixnoJYd/aTy2g0QhYX4kxQThBO329X
         rM+w==
X-Forwarded-Encrypted: i=1; AJvYcCWT5eOYbpRuzuIbq1W2xeGYVZFqleJRl3locWT4DpKlMUFmt8O4Pgmk5LT6ku/2f40Updb/gKS3zK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj2DXwZdS/9rIJYRIf1iF+CeQpPdzEPLUbzMOp8YP0s2i+s5u
	FuNDPQcsQLxWvjgTSunDogm5w3BC53NviU/IIWy/dQXesB452zHRAQ9pr4LYGQ==
X-Gm-Gg: ASbGncvw1rlTm7Czqjd9SUkesCE1EVPSI3zlCYhTR7YcRdANvbD9Uf8daKZoDnBWvk2
	jXfPoVtQudjfozsc9EVdLM14ZACLdw09DO84o5wUM+FICzXE0kkP9ztFUrJg/UmcVW4lLnEwl9l
	zpXapRJGpO6N7oaNSe8qZd68YfajHVFfDr/y1JVydD9I7YGUw7s8WB4Xv9VR3Bd/SGh5pPlKVuH
	29DhqG9od+nROhZE8rqeLYYroZgZ36e1PMTJvrxvYvzqawhlEg/og5ovrj5AqmhXQCggBR0wtTK
	Q0yYvoUQRlt5OEgw2arCRo9LicqpYGTIQv4umFKCG1I7ipS3DEKiBTTQN3pg21s=
X-Google-Smtp-Source: AGHT+IGIgwTqFwghplknMmhn0PhrkMbkYatLkYI+iiXeqPEmbShj2REeefkdrAzhOMUJoVnfgrJgUQ==
X-Received: by 2002:a05:6000:2902:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3a1f6444a44mr7489435f8f.24.1746951903183;
        Sun, 11 May 2025 01:25:03 -0700 (PDT)
Received: from thinkpad ([130.93.163.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec912sm8487327f8f.23.2025.05.11.01.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 01:25:01 -0700 (PDT)
Date: Sun, 11 May 2025 13:54:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
	jdmason@kudzu.us, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v18 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <4oyhjtoedh66sdyhebltwskskksy5ask4avvuekoxbckibdxmb@bqwe72b5q4en>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
 <87y0v7ko8o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0v7ko8o.ffs@tglx>

On Thu, May 08, 2025 at 07:26:31PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 14 2025 at 14:30, Frank Li wrote:
> > This patches add new API to pci-epf-core, so any EP driver can use it.
> >       platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> >       irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
> >       irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
> >       dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map
> >       irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
> 
> I applied the interrupt related changes in the tip tree. They are on a
> seperate rc1 based branch and contain no other changes so that they can
> be pulled into the PCI tree as prerequisite for the actual endpoint
> changes. This can be pulled from the following tag:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-platform-msi-05-08-25
> 

Thanks! I'd like to have a closer look at the endpoint patches and want to try
them out on some hardware before merging. Unfortunately, this cannot happen for
the next two weeks as I'll be on vacation.

So please take the interrupt changes for the upcoming cycle and we will deal
with endpoint patches after 6.16-rc1. The major blocker for this series has been
the interrupt related changes. I'm so glad that it got resolved finally.

Frank, thanks for your persistence!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

