Return-Path: <linux-pci+bounces-31320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC9AF65ED
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7CE189D8BE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C42522A1;
	Wed,  2 Jul 2025 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+5de+S9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED824468B
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497493; cv=none; b=qQ1QcKry+WU4MDH//jZpGqgClfmMhFHXGWQNc/7azQi3MbFlu/zPLcnZE3ZbP4l4JiFrZVE+xFjPjf8QCEwunOX3nZZcKeyM0lg7DaZ/8REYEEI9Mn6wi1kEtqEJEGuVH1nK1RHWF8Z2BE96ohbiGu+eTXiqyVcGFVXhlp/WvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497493; c=relaxed/simple;
	bh=IMv4Ezb5f0WY6OCORhW7j27W9GPItKLfM5PXJBnfnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkwRH8OM8PcpbrzV53ZdpSlHvj3u723jR/AmWB2plGU7QDI8h7Z2ZaKw2nvecyyGUHFOV/wyRT5+rbZ0+zQQ8n9AO1X5LyTzaJoCjsks4t2mDLmiVzEP49XyA/ZatHsvnjRv4de7f9ASKgB/hXBBjz6qSv8UDk/WTGxfZGYSSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T+5de+S9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4962293a12.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751497492; x=1752102292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx4WaXEvD5xkEryT7lxX9d80zSIO5EP0Y+0rVZMvvko=;
        b=T+5de+S9shwNcy2XsraA+KZ4KO7dGI2jidsScbp++ZL6IIW+uZ2uRML/Zc8YjiRJbw
         IuYokG5/S9FG24uwJjdk3Ro9SJ+syJxPbfoadUZWX5OC5fqHlP9XVQPoOcYxYPj8F3pt
         HhCLI11N807UTOYJAyfx8NJAaWY/UU3cKpKQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497492; x=1752102292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx4WaXEvD5xkEryT7lxX9d80zSIO5EP0Y+0rVZMvvko=;
        b=srnCCxFSmSWZglV1tOHxz1P4vh/OPPA3ZfroNkMbKpGQCvziG4EkQHydcEu1kge+Ox
         cH3RhZ0dvYh49/Qoz9nQqiEUgL1eS3KMbTtmXPqedce4A4nH3HQFAWxIAe/sPyqsPKvy
         4jsO/vaOwFezLIAtBMoEfzzH+6pGF0PFiDhL0quUa+QuQJS8Vi/sBbXAzZM3Q3+m4Eoy
         6HEqJJIOpL4cJ/huwNrkK6sQzW59s3kMbcN8fSTdd3H8Q0BTbIFa28xA0rXNDA1an9IN
         7tprkGGL70kye8xsffiOCkQ6TT1BtN7jdoFeOhf1R/FTtS188YkuLbdawZ4JxVYm9Bhz
         Oydw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQ7N9B8gTRcyTYUi8NxfPTYCvS7XHip8AhR2zvsGByF3PLkY/6TLlZjCgoATWqE/ZTGwIqRWULq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99fbn0Y9EDHz8xVtwURTDnb5nfd0awOFnQX3HS9xSqnZhsor2
	wGcMMnia1/LHqxen7702wWi04y1UOiSJlBvbInRVyJeW53/jLM2QzlfNHxBc6oQsHw==
X-Gm-Gg: ASbGncuu68eAGDOMN8o9YoUZZZ6tLRILtyWHUnmGs65ljhH/P0N3Hm4cxqrB9vH2n2V
	s5E0Y5C5Phec9fOPv2h/mVy13opVsRLLklz9WsxyQhSp1ImJ8Ljb6fgRhPul7Agiw3hNEBjcBoX
	p17bMc3zEva+UBtZ7YO7VBGilU8Hgu6UKL/ggrG6jdrNsDd3SeDOTE2RHwNGJd/ehZseANdSzms
	vLwsP59UzuhHn3tznjpVdvnGT9GLewMBQsUb+IYbg26B0Pl3eV1xWDPGYPS6pyUY9B0LSOnjHAj
	LEzRw+lzUecCjWejB3As/yAbXe2rYeOcnKZMsgssUF3VXgIBCUsoOaVgchOaw33xvpZlvvnG/7Q
	g9j3EwJK+8ZCMlMkSrzXOrE8=
X-Google-Smtp-Source: AGHT+IFhH3mmXTu0dRC1SKOttV24IRzD6AP2asUl8wAduYaCcQfRJ9VxViud0WL82yyv30ah36Lt1w==
X-Received: by 2002:a17:90b:264a:b0:313:dcf4:37bc with SMTP id 98e67ed59e1d1-31a90c17cd6mr6040506a91.34.1751497491705;
        Wed, 02 Jul 2025 16:04:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a88f:fae1:55b0:d25])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31a9ccf8711sm694817a91.27.2025.07.02.16.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 16:04:50 -0700 (PDT)
Date: Wed, 2 Jul 2025 16:04:46 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aGW7DgTwQwgZayQW@google.com>
References: <20250702223841.GA1905230@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702223841.GA1905230@bhelgaas>

Hi Bjorn,

I'm not so familiar with layerscape, but I'm familiar with parts of
this:

On Wed, Jul 02, 2025 at 05:38:41PM -0500, Bjorn Helgaas wrote:
> I see "aer" mentioned in layerscape DT 'interrupt-names':
> 
>   $ git grep "interrupt-names.*aer" Documentation/devicetree/bindings/pci/ arch
>   Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml: interrupt-names = "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi: interrupt-names = "pme", "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
>   ...

NB: in fsl-ls1012a.dtsi at least, the &pcie1 node has 'msi-parent =
<&msi>' that points at a 'fsl,ls1012a-msi'-compatible irqchip. I expect
that's how MSIs are getting resolved, and so that's likely how portdrv
gets its PME IRQ to enable AER among other things.

I think the other SoCs you point at above do something similar, or with
GIC ITS.

> 
> But I don't know whether or how these are connected to the AER driver
> (drivers/pci/pcie/aer.c).
> 
> Does the AER driver actually work on these platforms?
> 
> Is there some magic that connects the 'interrupt-names'/'interrupts'
> DT properties to the pcie_device.irq that aer_probe() requests and
> hooks up with the aer_irq() handler?

I think you're right to notice the disconnect. I believe a typical DWC
implementation does not actually route the root port's PME/AER through
its MSI line, so many SoCs will have a dedicated platform IRQ for them
instead -- but I also don't know of any that actually hook those
platform IRQs up to the AER driver properly [1]. If they want AER, they
do something like commit ("9c4cd0aef259 arm64: dts: qcom: x1e80100:
enable GICv3 ITS for PCIe").

Brian

[1] Although I've seen some try to abuse interrupt-map to pretend that
    their platform-AER interrupt is actually an INTx source... But that
    breaks actually INTx support.

