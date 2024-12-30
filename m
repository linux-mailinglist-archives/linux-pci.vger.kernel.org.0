Return-Path: <linux-pci+bounces-19100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669849FE9EB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 19:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2925216131D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93C17C228;
	Mon, 30 Dec 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwIHIXFl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642B1632D3;
	Mon, 30 Dec 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583796; cv=none; b=KP3aezCqycd6DORrSwxbHtRQRv2crFudJ88SY0TAxDI8I6AZZO9oGO7+F7wZYtLMPIm80Y96xcHWm1CY7Uou1yUNbwVNJ4bctWjboYf7R3ksPRUAd+dmny7GxL1JxkUmPWvT/F09Fv2kemFdktkpPDw3h/6qJJPebCdd+CF29tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583796; c=relaxed/simple;
	bh=yGzK7nXzKseOBgGf+hf0weMlv09lolduNvjfosSpVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUoH/JX4+006yERuA0jY1x3d8xmmkL6W5G4c0kvX+mRoWBKxUJx9xl5KDUhg7D765nz5HyvcfhTmuYbkEgLyDT3TmXd9F3QYKdHsc7OhKZc/o7ZRdZDRguP6qCddw1grW56bmC/R5T8IuITDl2pMrajnNPKcemqYa+7UTY8l5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwIHIXFl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166651f752so140892695ad.3;
        Mon, 30 Dec 2024 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735583795; x=1736188595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc8/0JPMEYgxA6hclI2koGhS9yd3XA0kgA3Wu9YPtIQ=;
        b=FwIHIXFlczyxZF9Lx5Bpa0ESVurPVaSwjtlT74D1QL/g7PWEGhh3JYCr+j559L5tMs
         +szP7o0p1Ut4d5z+Olfe3aCHqyhIlyLAZenBV0CYUCGU6CNYmJwu19nXp0uJKG9RGmLK
         pIqpLyXp0Uq0oD4cgaDisf0gLdaD/ZBVQZwOpvO1i+Azy7c88umS0Ar62GS8Vgf31UHe
         tPQPkTgaLguKiA4oO2bciHYrS0irr3oYjRs4ApDX+PiPE5XS5tDjOotnlxe9lYnjvcQ3
         XLAFdJMT77UUw+gLrdrYAKjnKGq6hzkZ8icllJv3i2EzMJBTt5R09SlJtIkqrfRpQhFK
         t7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735583795; x=1736188595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc8/0JPMEYgxA6hclI2koGhS9yd3XA0kgA3Wu9YPtIQ=;
        b=W/M1WlqAdrAwVNlJHyK3b9G+/E4RO1EhcrEVNxcEjf7Xh7mi49heDnSNCJ3nIY7lns
         diL8ijYbIc2jjoIH72GbirkAUTE7Gh3Vdmh/4nS8TzRH2dvqc19VL+PPQpUXmSknFhlG
         1J5WUfVXB68JENWV8Zivcf0hA1AGZTsMr1e/32kQIFPqKE0vz6NeCE6/OBoB5Wxou+Jr
         p2ldYpN4g7ObyAUByS8B6A6f3StxyH1yI1QCyaQTZtjGs3D30K3RnDivzBFIOEBK+CLz
         Z28RNX+Y3bdshgrliESytT7AKja1pjS+ArQM+Tx5Jx36t3RN5twZNsYW6qnA/cfttdYe
         xZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+zqvGvRZi86ojsHx5pw6KwTiDT21x8zt3wlDfzQvsofgIUJzavz2GWNmQ6ZNLQKmOf9MRMHgF6TIBXOM=@vger.kernel.org, AJvYcCXA+duB6bZx53MHD3GIv0X+fQKUMn9OPz0hUAMsrf3o4Il8pzUP+Yz3dDQ0drYdVIhptEl94z79jTWM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iGH0Zoq93j5BCOTlI3+sW0s3gKsB8o6riTtDQkF9WWCbvF+w
	q9QMK60GKe4BhXrbeTIpNEGr+iqcfnyk2YCAVyQnU5BNYiMcKerCGPfBz2Xz
X-Gm-Gg: ASbGncupo9BfO0BeIpVPWhCNs4i40djb2TbIGbwUy+7FCG3tgnqAGL6TSwwxGUDy69Q
	Q6ySOxSf1crZC9hRId3DnG7mDAa2jfnsTs8rtDseehPTJZ+c1d5DUh9Uq7Khfuz3uYf8Ov2Paw/
	i7+3rb0KS1QhPsKtjqaWplGRCUyh7JYSj2Rq38G71woBr2IELQdW/wavCgbQqXecN8BcGgfd2/0
	es5yzTLu2K8eB8Y3wOEyP3+DEVNHWX7deC7gaLH6LTZLaf/gA6y4l3C2an1CwF9813MkmN7piYu
	vZlLdNZwxaXS0p9u0Pxrz2fo
X-Google-Smtp-Source: AGHT+IG7E8EpTwpUJPJN/X+yYpdoFoNbCBWUWJgWrHhqQli7gxjkRczgnc2f5EZ1omQa+Uhb9jNCQw==
X-Received: by 2002:a05:6a21:1519:b0:1db:ed7c:b8f6 with SMTP id adf61e73a8af0-1e5e044da56mr53494205637.2.1735583794604;
        Mon, 30 Dec 2024 10:36:34 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dd089089sm17904966a12.58.2024.12.30.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:36:34 -0800 (PST)
Date: Mon, 30 Dec 2024 10:36:32 -0800
From: Mohamed Khalfella <khalfella@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank.Li@nxp.com, bhelgaas@google.com, cassel@kernel.org,
	dlemoal@kernel.org, jiangwang@kylinos.cn, kishon@kernel.org,
	kw@linux.com, kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Fix NULL ptr assignment
 to dma_chan_rx
Message-ID: <Z3LoMC-fcxTHbPIj@ceto>
References: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
 <20241227160841.92382-1-khalfella@gmail.com>
 <20241230072645.6x4awglfwbjis27e@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230072645.6x4awglfwbjis27e@thinkpad>

On 2024-12-30 12:56:45 +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 27, 2024 at 08:08:41AM -0800, Mohamed Khalfella wrote:
> > If dma_chan_tx allocation fails, set dma_chan_rx to NULL after it is
> > freed.
> > 
> > Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> > Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Btw, you are sending next version as a reply to the previous one. But you should
> send it separately.
> 

Noted. Next time will try to do that.

