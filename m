Return-Path: <linux-pci+bounces-19078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAD99FD51D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CC163172
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10161F4E22;
	Fri, 27 Dec 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHkUYaGp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFD3F9C5
	for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308002; cv=none; b=qCQXL86dYnjtNXAkr8WFXkZMF3S7Eam8DISFj9RpP67OAlHJ6KGXfox12BLQFOYtigs4BuAQGTXNg+WaNLFtDrWaCJfzDOW9hmpk6OhWTlBWvDhfCSLqrHkYuYx4RBKDvP2xLSqeBeNZshxyRjBahq8yRHtcO3FFmvq/WTtCYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308002; c=relaxed/simple;
	bh=KnTwypsODTYKcfQ+5eeuenyq9SnltN7W23aSn8NFLng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4WPuqZMjMUbzgloBZXalOjNXi5bueBbr+VaLIUVVWzyvuoErtFx7DwneAQo5H6oWIVG3QBih+GYGy5g7+TiQX8pHCcyJ4ATDfJnCfc8DyarP6DSA6nv+4g+Urtc+3YYFgzIzzsJjDmhKL1MnEKia/xDh1YMKRJocGkM/04Iw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHkUYaGp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21631789fcdso69178375ad.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2024 06:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735308000; x=1735912800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=55X/40ED4suy4tEhRhJkavXvZ2omQygaYh5J1H8jr1M=;
        b=OHkUYaGp/ZlaRscj0Fthq8NHaQAJFVGQtlHnbHj7+fMkBLIuHxLlJJiNk/Asj5gQrh
         tJOWBpYkpP2S65MfcfsHJuwD6lUw2A1TugrVp6I/wEktT7JAmLdpZ2K5jLP7xfvqZkwJ
         72cPzCUM6v3v7oybTua633AR25OjXCCIPTf+ii1XV3/uZE0ELbaf/gag/GhJDl9jovmD
         CMJAijXWpntNJpckUZ1PFpIOBFumpY++wJ2JQdBCCxBhg1k/A6G47ovFJ2qSPPmIGQ07
         K/bjl+xsoBXS+iCtlc5mZroyXqW59F6vRAfcZKgvN+iXutKuYBSVwqSnyrWeGogFex5s
         X9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735308000; x=1735912800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55X/40ED4suy4tEhRhJkavXvZ2omQygaYh5J1H8jr1M=;
        b=xBUBErXXToHY5R0EAawtq5hGdGFItGFypYrjui0iLGszD5T9E7sCbswoHPpiDgakLV
         Y+PTCOnI1C5Hfs49/as/q9bI6deaANjX4YrW3KoItgzcSgNMJXsbEDoeLL1hng3f8olw
         oRNP2zjECaINzIOcsDRpQhvnPbcI2o4hxQ341vc7MqiSjuy+QXyGRGoCdIPspp67+svD
         GPS1hPTrkt8O0h9M6nW7HADk0xIfiNmyLgdg+6ERFNGOvp3khAQ+uwN/82fPx48CpJNH
         osBpKSuPJO9IFs99MwoWdSoiRkyUNj7XNksbtnRPe5HaCrI0smlGQ8eEVU1cAK0VZkKk
         SsLw==
X-Forwarded-Encrypted: i=1; AJvYcCU4z1gAehzwRl515Hayqso/omQlTpuI1zDdYpTKxlJ6h+IJdQ560//tt5PmxMclfZpu8vxcUZRidoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27s1CPjH0r47aIsEqlQT0RxClIwCDWdhOIDDMeVVrYoVHJYXR
	OP7f5hWPsl+lV8RoZBAuF1yfK0rcBptbq7i3C+EM1VT8Ll4xHza1E0ggn3ISyw==
X-Gm-Gg: ASbGncuyKCubXb5rV3WJcHZ0q9kQYGtrrh3yUWase0pNg7DWDz4wYU0u2GDr0uXRaka
	Rv3FP+ci8gb3UaA8mrbuTAEZrNF+Xw56KIM1fUSbk4c1jFAYJA1Q+ChtmxaWlJqcFS+qESKgqP4
	tq7tG++dNNdKC5sMGmHdCrSwb+GD2aXikuRxgYVZbUm+E9L5J/MjflXCc/AsyitarRHIlcQfzUW
	k4XIzqD4IQSf1lQK/gOtEe4liP+FxkS7GGkvgGb8vYVII2Td7FAG5xsFS4pmODjqKd1
X-Google-Smtp-Source: AGHT+IFDncOOCRiWPfmSqbq1hsnxix5Z3tZSk/434Ys5dUSyhS2rwgpdlE2d0O9LL+3ul9ALitLfOA==
X-Received: by 2002:a05:6a21:3989:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1e5e1e0460bmr45155437637.2.1735308000456;
        Fri, 27 Dec 2024 06:00:00 -0800 (PST)
Received: from thinkpad ([120.60.143.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8157d7sm15094009b3a.21.2024.12.27.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:59:59 -0800 (PST)
Date: Fri, 27 Dec 2024 19:29:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mohamed Khalfella <khalfella@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Set RX DMA channel to NULL after
 freeing it
Message-ID: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
References: <Z2Z7Ru9bEhCEFqmc@ryzen>
 <20241221173453.1625232-1-khalfella@gmail.com>
 <20241226163121.n2itccd4glm6vum4@thinkpad>
 <Z22XqedgvDYsc-QR@ceto>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z22XqedgvDYsc-QR@ceto>

On Thu, Dec 26, 2024 at 09:51:37AM -0800, Mohamed Khalfella wrote:
> On 2024-12-26 22:01:21 +0530, Manivannan Sadhasivam wrote:
> > On Sat, Dec 21, 2024 at 09:34:42AM -0800, Mohamed Khalfella wrote:
> > > Fix a small bug in pci-epf-test driver. When requesting TX DMA channel
> > > fails, free already allocated RX channel and set it to NULL.
> > > 
> > 
> > Patch description should accurately describe what the patch does. Here, the
> > patch is fixing the NULL ptr assignment to dma_chan_rx pointer and that's it.
> > 
> > Reword it as such.
> 
> PCI: endpoint: pci-epf-test: Fix NULL ptr assignment to dma_chan_rx
> 
> When allocating dma_chan_tx fails set dma_chan_rx to NULL after it is
> freed.
> 

s/"When allocating dma_chan_tx fails"/"If dma_chan_tx allocation fails,"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

