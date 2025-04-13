Return-Path: <linux-pci+bounces-25741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF478A872DB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B24171001
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A81EA7D3;
	Sun, 13 Apr 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJ1o6Ppo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BE1DF242
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564387; cv=none; b=fps+XOo2G3TZ1osVBzgwc+d21onexvlTJLdzYfA53v0RKbZ/+BS/BKOooyCbB/SQtF27gKZquZxpCHiFGLc7J/GOuNtOYdVR6ndBGAsAPU4aSxBmIJQkW4PMJz5vfHf7rOpX3WlYw//Us0p5+UZJfViE0KWgaqNxyvWlZmb3gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564387; c=relaxed/simple;
	bh=aEQzF99LQ0NNvpBhqm+RkEYHYTmZEcGMdv8X4Shek58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in80eVvyYcn1bRYqUWCXHwTnOGw0/i7mNmV40DF3uVeXI98shmZKRMIM0tSxVlJDtbQu746Ftg8+I1QfimggpwnUBQVO7o1vYGjDMuMsacs0q4/yrscnpKQObOi1OceAcjE5t5GKuh9qy9Sq4itShbPcMNYONfbyfjlaqKhJEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WJ1o6Ppo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ad51f427054so2568652a12.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744564385; x=1745169185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/+QNJQggYnXDj8WNcyWPPzk0l3SA6QGoTwofzMyuGw=;
        b=WJ1o6PpoGCrYnpqZAmVei44ACeQTVXdmF2fssALerxWoHgkgBdmnZanC5JcXS9vOsn
         eFzM4PY75zftdWu3iSTyeYfKLBjh49YV01W28egCYs7xZd76840J8Yj+uApGPI68J1Xi
         fe+4e4msRQv9q8K1JP2c69mBXiw/2SiItsW60AGyFZCONc7nzZ7ya6hF7EgxOtIcRCkR
         pVvRHquhCVTHGtcUwOYqP9DArA7VbklHXkcdvhQBbKwbvE1Bp4b8+Y3sbYevXoeB1AeZ
         fA7Zz32BZ6Vz0JcNm+DvVILyTBqzjlTQT0FfPwdRTmIavqwj/VGEpT6KKVNfLtyGYFuS
         aydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564385; x=1745169185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/+QNJQggYnXDj8WNcyWPPzk0l3SA6QGoTwofzMyuGw=;
        b=MvA1bYW8ZEyvHnGT6eOPryz+cqKJg43nQIUu/StR6w3SijpcX/VRHbpnqNplyER6Pt
         kBZ7d2DWZQyrKlmkHyHL1vC2v0GLdNsEqOfyMEg61sCztE6clVKCawii6hMtzIBXkkMl
         ylnQrBPmW9ZGbEKe4GQRrHQUB1WaLnh40VZ0qscAAKnzOxpWC2SQWeW+x63DuEVMIv/j
         r6+/1d0i5HCeBKggzCqHOQDjqmhd/6Hh9qRgzNkU0mMk9g8L3b65C62oYN6DpDOrnmXg
         PTYNtrhPBtYKNAWy14bqWP+BSsh9/x0SKKZMKyfJIBSCaKD/Tm04m5UgEMoFHS7wHud+
         e6hA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKVXr3Z22UyLN0eLSELVpPH+FpCSOxQ+3ohk0lra9T4DHk6aiveQdWMh6RZxoMdNc0+dX/DD8UQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzpR6aOR83KicVmLqmj9ouwbdjRi2G57m5jN/C56dk/w5nwCKj
	SwRxz711VUqDmOWbEd18D5/9f6XSu6PDPhYaWeFD/wDhzkp66XXKGAohsfkxXg/II6/ehvC1rek
	=
X-Gm-Gg: ASbGncswRIVCm9hsenssc0PjYu2wZIXqGT2ZjtHZliqoffvYsVE/iGznl9bvaqns4mJ
	uppfzq1GtENRtDm3sJMJByW6GHj0o1UysWsN+uJAXRANZcJnyVIM7FXsChTMv/TU5W0322GKp+B
	suR4OPulSjQ8F4lL73/09/RRjtRZSdGZRqb0cm/5GSztEgzyXcXzMDMCCDdI4DUw5Gq/IhO9v5D
	BkN2ywjvuDAI3wHPSY7xBlkwP2olqRlJyCHTJ0dxM1IUJs9CNS1MHGnd4t8fGjsDk0sHbDJ2ouN
	tNB6ydNtRXxXjykaZ8iu80rqDFtWDq5jCfKZs0a/OqFE0sTAgcCi
X-Google-Smtp-Source: AGHT+IFgvRixxj4CWBFzEA4Rqd/cLujQYErvo4nd7qcvFFaJWGEF/g+XbRNPiPM5DyBrqssz2FfknA==
X-Received: by 2002:a17:90b:274e:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-30823664092mr18167375a91.12.1744564385379;
        Sun, 13 Apr 2025 10:13:05 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10c41fsm10783830a91.8.2025.04.13.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:13:04 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:42:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 08/13] PCI: apple: Fix missing OF node reference in
 apple_pcie_setup_port
Message-ID: <bw5hh2mlgaxxxy6rcjksrqfkpencjx36iywy7kp4s65ah5qe6c@ye6dmhzhdlck>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-9-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-9-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:08AM +0100, Marc Zyngier wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> In the success path, we hang onto a reference to the node, so make sure
> to grab one. The caller iterator puts our borrowed reference when we
> return.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-apple.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 6b04bf0b41dcc..23d9f62bd2ad4 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -593,6 +593,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	list_add_tail(&port->entry, &pcie->ports);
>  	init_completion(&pcie->event);
>  
> +	/* In the success path, we keep a reference to np around */
> +	of_node_get(np);
> +
>  	ret = apple_pcie_port_register_irqs(port);
>  	WARN_ON(ret);
>  
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

