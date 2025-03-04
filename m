Return-Path: <linux-pci+bounces-22852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCEA4E32E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0289E3AD41E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA022673BA;
	Tue,  4 Mar 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUAQLQPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A3254B01
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100699; cv=none; b=byuzowoJgNYW9yZ+W0ij721NGMUVSH+9rsfw4yXVPy8Yzz5Hj5UCYmMRdzRXkFKXEz2yHG4fBr5Q8C0trOEjLJ07ktX8T4IBW2SO3vN4H0GONOAK7DYtXmXA6m5Gk0hDzLxCnY6mGCtXBxnO0X/havbz4iOQ5yRsvwv79G4YrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100699; c=relaxed/simple;
	bh=yy7TjOny+SHFDuA0DiXOqVBMP22iyf/J8Yd3sP3lIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7viIn5kAuv9X5FfaX5cZIHzChHPVLRG/AbZsDg6r72LfNv/j/2A/1j/80tei3FfJ9GGRtf/IJuxCXHxO1WuIGPijMxGltCGN03KqKW4KlzG3IcX5nHgcuAFq4lVG1BNGp0x9dvX1e/AP10orzrPAjNbS/b7y3nzcxxhFkU9M9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUAQLQPs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso9844293a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100697; x=1741705497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wLAYT8VOg5n+EhJivIskvTTTLfV5w4lbqOOhOs3qFM=;
        b=AUAQLQPsBTfBGY5+0EzU2IQuyFCTSn1vB9rR/lag1UmEqOCyxjgiahWpQntW6vzIb7
         3tfb9uXRf4wUrQbSZWzjH+wZeeZb1aowS7iaACjauE8p3muRGEnDHo4Co1Nho53U7K5i
         YsFbVVSWq3181qMlMwGaoDPVVSu+f/CiUocq5e1YAObUWX9eooRjLDaLkwoF22spH+Hs
         VXap+aj5Ed9V0B7MzsBvcPKWRc0UT0fAMkld8qF+is+nNgs8BDSwingAI5gJioxga41y
         dXSIzz75TbTJbbNJ99YtEDYvZpkgKA9O8ujziyTfQvgKPfEj6AQ8FhblK+VKN2iC9KHG
         v9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100697; x=1741705497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wLAYT8VOg5n+EhJivIskvTTTLfV5w4lbqOOhOs3qFM=;
        b=uYMso1ynmU0gP0SbeU/grZxYt+YB7UKKap0kOSrIB08iZJ8uxpDZ2ZBh2dCApp/lLO
         TxIu5AM3VhiV8/g9+suXuZN/L0ICLCTUnMNd/dypTQ6/5fzkVghSkNXZLlegH8KWgvjw
         bvbSIv1RBSUWkNqMDysy5OpTcROvfE5hkOELYASY+lYk/YzjFaZMtmxKV1En4lguotFV
         i0AvODgQaQXdo5EexS3Ky0ckhIJw/lWbI3TpDJNWIm0j+jB3KU2SMqH1PQFdQggU9ly+
         wuOgXoMKzqp+oLIZa1qdNjiYrqHZzmIa8LJbjf4zzdTUpFG/15c31nPLqA7pbLqoHGmh
         fujA==
X-Gm-Message-State: AOJu0YzYlJuMjuDoTLQDrcS3uzC3SDpVyHVQaPaa9uzoP/wObkaAfXAG
	RQNK0IDvDKE2gAjhiJ+e9rjYfufvxX5kKEY506LY9p3AIx5kvossIX/I/T1HAw==
X-Gm-Gg: ASbGncvoOH+dpKKLo4dW4Dt0BjlIwKkyBQswd6DeVmrdRZ8qCz1hQW1Poe2/yrMgh3O
	ftwjCVXlqNLBsGhDvvpk2EtZ718FrkelcMmqIDMbhZodrLSSA9taPZ75Zpfp31B6AixHfE8JT9g
	Dbiq1qOJvdkkIOQuR7vaC/7+E4eUQsinfVL2bbXrT3jF5Kc9P9bVTg1PUUtGXrAk+jZYilkMrOW
	mHdpQvc/nK88MwhHxAKmMso0F/dYRynIbG7aw7J/uf3jDvNWegWdiqfpB8uLTTbY21h/Z0qSOlb
	g7Cg1J6yTRZ5qUstJ9euGWUU6bge7xisndkXApHq0CSuIngyV4Zk7bM=
X-Google-Smtp-Source: AGHT+IF2IqujVL9FAIrlKbmlEjSg+DENq4yc4FJP79iYPxBvL+hS29J2rkPg6a94cXi9du0du7pQgA==
X-Received: by 2002:a17:90b:5684:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2ff33b937f1mr6451097a91.8.1741100696841;
        Tue, 04 Mar 2025 07:04:56 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f076sm13270159a91.42.2025.03.04.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:04:56 -0800 (PST)
Date: Tue, 4 Mar 2025 20:34:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] PCI: brcmstb: Fix potential premature regulator
 disabling
Message-ID: <20250304150448.r42maovz4xggbqdx@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-6-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-6-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:33PM -0500, Jim Quinlan wrote:
> Our system for enabling and disabling regulators is designed to work only

'system'? Perhaps 'logic'?

> on the port driver below the root complex.  The conditions to discriminate
> for this case should be the same when we are adding or removing the bus.
> Without this change the regulators may be disabled prematurely when a bus
> further down the tree is removed.
> 
> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 56b49d3cae19..e1059e3365bd 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1440,7 +1440,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
>  	struct subdev_regulators *sr = pcie->sr;
>  	struct device *dev = &bus->dev;
>  
> -	if (!sr)
> +	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
>  		return;
>  
>  	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

