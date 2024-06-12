Return-Path: <linux-pci+bounces-8623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A0904A11
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D632281AA9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B15286A6;
	Wed, 12 Jun 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mO1SE5N/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253320DC8
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166989; cv=none; b=awS2hGI1geLLWB+EoEXIiFztr269uQt/eD6NX/ljXeRuyLzxwP0yn5A2hy1iBLhyvmo44YLj7u6y8QwMp+v9R/rRioFKODrXxi4XnxKUQf1RRo/e4mwaciHSFCG3o+5wukdBmlvbVxynmMGPiF7vpApzfQMb+uLPsE5+QNoQ9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166989; c=relaxed/simple;
	bh=EO0aImAqYw7a/OBDl+S8gijoba1Ra+Y0nG8ZUi4cOaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNpCMXu+lIxfklmQnvXQ8derFWuZpWUVmQeRIqAa09f1C1httJWoL6Hkow/feKYyzopf0WZj+TpWO218NLRJzQDnzB+Iah1oJPzfgucKECjQvZOKQ/oFnQ5b+4t6K3ZzT5zjkpAdAiWUpSoPSHUhNp+NusMoYA1SWtt/FFLSV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mO1SE5N/; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f99555c922so1972853a34.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718166987; x=1718771787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vH+4iQ0Kxj/vMdKXd1GL4axukTJSkL87xzz/uOsZjd0=;
        b=mO1SE5N/M0tG01ESL1v165Gc2cXKhIEQpVMvkNmR1k8hD6LT/GUQH9T67w1/ZiUnJV
         BTE/83PZ0qb7z5x+EYoUI+EXNIzw4/Oy+0N+HB4DqIWlH7QzI1mvaOHg1hR3sMefS5QJ
         n2Fv8qOybF+xsyHxwyd9be3qbW3T6Zp2025NcTeFJtwPbUJBl2L/Mi5BWQXBjQhdaZ+c
         uy8wBEIcxYZDH/aWFLgpYggu8LUM9H1fxKni/vLZ0RR0bUKVs5Ufx6wU5rJTzMtRvvPx
         8aRoU4+jvADQXEwVgeVkicXj1fENT4Tgg3sW159UCvmNSigq2yBEDPfGy+oUYp6U66+J
         1+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166987; x=1718771787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+4iQ0Kxj/vMdKXd1GL4axukTJSkL87xzz/uOsZjd0=;
        b=vivmlAw2+t4pwtfixZ2jzK/B8/0J+L/0Hi5XvNO+fbu7J5XF/ST5BUBFRW7BJVwysh
         ZlZCOb9rU+2n+4XAs07LXkYNjQtOL3FSCgiIFduWG6XhuqmW2s0U9T4ik+I/RdfJxaWY
         IGbz6xrPoEQeCA0N6nUF0QcAoPSOSYU+9HdzXET+hHELkyLkzj+0GhPM4saGj8ZEQ6dL
         nFxrc+cpOW1cEz7qjg0WvO/ga6Y2S008OWk/y6R9QPEYre/xhY9pPCfl1cGI5x8QSu8Q
         uSGz2zOtyb6aX6Q20jVR7FogaQuZaMB01H2UtZrDtq07U1w9DrXoigucCBZJLeIvHDFN
         qUow==
X-Forwarded-Encrypted: i=1; AJvYcCUy+0gZs+tmhPcJIExwoWbPHlylKO1e+rbI/KhFKe1lOTlD6+13GbLpu3K2+6AOQF/6nXLLQERy4KdprlmLnVdH1hsqc4V7afVn
X-Gm-Message-State: AOJu0YyyF3pSOICD1apxFCEmn/Hc22gIUlq3ptTjLQsAxmAmmcPH2XMJ
	led9Uv3ISTUjR1Nda/zWvzQClki/Zq3pgybJwenKqf3eNXLI3H4NM9NFSA9B6A==
X-Google-Smtp-Source: AGHT+IF/i1Z4g1iXpug+xajahacKVwnIvfnsiSOznBlRwgjL1WHJ0xairr9brTYDWvv7YNpLZYuzDg==
X-Received: by 2002:a05:6870:d186:b0:251:46d:d32a with SMTP id 586e51a60fabf-25514b4e021mr927373fac.8.1718166986969;
        Tue, 11 Jun 2024 21:36:26 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e9a52a3012sm5409033a12.30.2024.06.11.21.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:36:26 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:06:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 2/5] PCI: endpoint: Introduce 'epc_deinit' event and
 notify the EPF drivers
Message-ID: <20240612043612.GC2645@thinkpad>
References: <20240606-pci-deinit-v1-2-4395534520dc@linaro.org>
 <20240611220640.GA1001976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611220640.GA1001976@bhelgaas>

On Tue, Jun 11, 2024 at 05:06:40PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 06, 2024 at 12:56:35PM +0530, Manivannan Sadhasivam wrote:
> > As like the 'epc_init' event, that is used to signal the EPF drivers about
> > the EPC initialization, let's introduce 'epc_deinit' event that is used to
> > signal EPC deinitialization.
> > 
> > The EPC deinitialization applies only when any sort of fundamental reset
> > is supported by the endpoint controller as per the PCIe spec.
> > 
> > Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.
> 
> PCIe r6.0, sec 4.2.5.9.1 and 6.6.1.
> 
> (Not 4.2.4.9.1, which no longer exists in r6.x)
> 

Ammended the commit in pci/endpoint, thanks!

- Mani

> > Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
> > PERST# as the fundamental reset. So the 'deinit' event will be notified to
> > the EPF drivers when PERST# assert happens in the above mentioned EPC
> > drivers.
> > 
> > The EPF drivers, on receiving the event through the epc_deinit() callback
> > should reset the EPF state machine and also cleanup any configuration that
> > got affected by the fundamental reset like BAR, DMA etc...
> > 
> > This change also warrants skipping the cleanups in unbind() if already done
> > in epc_deinit().
> > 
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

-- 
மணிவண்ணன் சதாசிவம்

