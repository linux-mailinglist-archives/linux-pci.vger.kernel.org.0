Return-Path: <linux-pci+bounces-25744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA3A872E6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380EB1722FE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE271EEA57;
	Sun, 13 Apr 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaqUHXp0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5241DF969
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564633; cv=none; b=D6caLQ0ESR+CeMH55Yv/O9H1/1iVS7ihAH6OJzoLJ37kVrVkieQFzlo9RSgkjxniRS2EjtLYFQUWXkC1PuqvbBhzHe+UtRtyj7kkI1rNmTEEGYwHnN0DqKLt4RryCPl92Oe5hE9uUQn5YZOB7+xXb598qLB2OQEpbfY2X/kO4ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564633; c=relaxed/simple;
	bh=yzmYr4JLOS40LoDlK4MgPp+nJ9KhGdxaumE41jBjK4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVrdMGv2DoYjoZSlICF6KDf6cSymt9HLU0rhQZFXbXd2OJI2VRzy4PsfQFD8khTfepqasrzMw5szoHokU2XxQ6vjKoiRi+j/PpVbg/nb+CK215k94NtzI67gHrSM3wdsYjOr56JubbfALXv2mSTalANehUzh0we9sNuKa8iy9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaqUHXp0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22928d629faso33988655ad.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744564631; x=1745169431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fvXB1Wjux2MAoUVYX6W6dWHZg8CiYEv8//Po5T1hVMY=;
        b=OaqUHXp0MKXECUMrJIJCDFeAzQMhGK0fYAM/othAcpZ6CfzTueYmYlI+ad5Yo0zGA9
         IpdAwyhxmGkVB79Erb/aT0/sIx7lYF0zNTQ3HGMtVfU4Vv9B9V4c9Dm+sC4SlxKasTGf
         yz5m96M6lvoTfRSnYKNU9aeUM0TiybxFFwqK65YdeGaV0oQhfnXFagqCDA/VCo/kfhrH
         fQ1HNy2DRXjfrwxI+a8xJhq+xGwStUKNTjutusruUH2orXjjqS9yucbzNkAPwzqdepWu
         HVQyNRYfl5SUrBFMIMD2k0D18j8+cCCltShrmfKymhzXQvQt6hvgosQPrPS1SJgI9SFK
         PDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564631; x=1745169431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvXB1Wjux2MAoUVYX6W6dWHZg8CiYEv8//Po5T1hVMY=;
        b=sbb+zi82t+4G7lggc4Jhq9B1CPyIj1lR9FYEHNZxriT5oZHLut3atnmQsEQjrUNn6u
         Pm5BTMb3cKPf5gTeXO+xHFiAufsXbHV6JRMI0CFueHFdp9uqYVxGWyT2WU3reQ6biipe
         +ZRXDs8zXdloncgf/QJZx3tTdbD2z0zd4W+IFg//jj4q4/U810ueTJRjROW2beIvRx0V
         sMtnmdWfWsDjMI903RYNqWwPBR3r0Bd/wC2hIABJuNpmzxrN/I8SAoHX3Q35Jj+zRsMT
         LUfUEcfDdhg5EmcF1rNUfrba+srPbbIwRJmGJ5Pmi5EaNNpiey4VKpLD0QYY44Fgwo7V
         urCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEZQgJ7olM/eLoneC4ByAm+VCheoN5yOi9FZD/ikWRAN7skVw3VEn9cobOKsXySAHn2si/XUaMkCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmZcbIZ2R7Y8d+cID8vgpu/HBGmI/iq02emgYA2C9QiNsYFwr
	nXgZiboRABVA8FrbUYvAhdQxmVJh+SRJmCiWRDem3yERx37s4ouq2wsqtNE7DA==
X-Gm-Gg: ASbGncsTMxwp7VuaSKAH4ztx/qAl0VA5fyGJSglY/hw60eCRJ4KhVlSY1e7N71XvwPE
	h45P6K1cW5IW/+s1msoBNSNLzPOEa0zzmCn5ZnW1FDYUIarBnaNHAQCj88GXkWw7WCMmM96s1ci
	eoxA4mfzozaQM2NWNt9Z+ebpMnKyaIAbSQcpVGIPV34XPoidYaTsX/HolSXXQMi8BnymEqGqiPA
	NQ7o53Kh0QG0W9YgxNUAErOsIyeCdVuGXt7/O0yMrmGeQaIz0RX/QY/apICFaAupibNItOhozDY
	hCEF/HwUkovesvStOH1QiOEtVXxs5667dduMOaTaqOKrEfmZewwp
X-Google-Smtp-Source: AGHT+IEtOLc2J65A5BztfZy5lJCUWgfZuua8Ed0F/wWmVQ49XJn2NKHTr6y3ixbdHzeiNIvZR7HI/w==
X-Received: by 2002:a17:902:e5c9:b0:21f:1549:a563 with SMTP id d9443c01a7336-22bea4954bfmr127432855ad.2.1744564630883;
        Sun, 13 Apr 2025 10:17:10 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c97228sm84677405ad.128.2025.04.13.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:17:10 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:47:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 10/13] PCI: apple: Drop poll for
 CORE_RC_PHYIF_STAT_REFCLK
Message-ID: <rzrouiqucgtdpapcqwf6pbdrbsrxeii6khx3h2q26etu3772tb@qxxdjuv5uias>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-11-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-11-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:10AM +0100, Marc Zyngier wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This is checking a core refclk in per-port setup which doesn't make a
> lot of sense, and the bootloader needs to have gone through this anyway.
> 
> It doesn't work on T602x, so just drop it across the board.
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
>  drivers/pci/controller/pcie-apple.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 94c49611b74df..c00ec0781fabc 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -475,12 +475,6 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
>  	u32 stat;
>  	int res;
>  
> -	res = readl_relaxed_poll_timeout(pcie->base + CORE_RC_PHYIF_STAT, stat,
> -					 stat & CORE_RC_PHYIF_STAT_REFCLK,
> -					 100, 50000);
> -	if (res < 0)
> -		return res;
> -
>  	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
>  	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
>  
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

