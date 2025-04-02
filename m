Return-Path: <linux-pci+bounces-25118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8DA788D1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C333AEFB2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A332080DD;
	Wed,  2 Apr 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6wiP/Gl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEF232368
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578692; cv=none; b=N/Zq28qk4XID/wWPpqZem6K4eBwa79MJcypZou5f29gVMjba0qF/WJ7z0DXnhFQNWKy53tziCIk+P/2s+MUSpC+fHOP9CoNfh+RvsKCBUnFO1ANeaU6GgBZWSGimEHnYOBZSo1SrxMGIV9s+HfPavOja+yrMiHqra+yQ8buNfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578692; c=relaxed/simple;
	bh=z4zXzEEM6488eph4XXF0b3TmnWQx9jpWrhSlG4E8/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOdeeFTQ0xVeZXVjCzfeMC6xw8vvJQdW0iTl/2SEYj5Q7nU0g1bYoig4ARkAbG786ogoLiOpl47c/+U2a891/7YrFdJNFFDnUSeOok92Y1UGrdznpnGUWMWn55Ie0r5B3LN9z1vt8D6GpKdOrmGuHppOQoZYFUYnyr29vrRbHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6wiP/Gl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so123447385ad.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743578690; x=1744183490; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ph/WNnmzsBCerzFt9WZb8x3hC6of/SCnGtCoahC4exE=;
        b=K6wiP/GlbgujTUT+Kv9xGN88bTncTtZgE693UCixLDd9Kl58mHXVRREpGF/SwS2FO5
         8bIWVbazgHk9WU+KmV4XIf5vDVmGZkS2eIsGCdhDosEh8CEZo6gpcEkF5DGww3Ki05+c
         Yvyjpi5n9/k4gE/K0PaskKDVtLzcITgLBpNYJ7U2bMwks9RVfm784tuW2rCO+GWDm4M9
         WMS5iTfDkn31QiKaazYEtYgDuk4arN60Z62i2BB4uU//5DoE0r0Sq/sCG57OxUg0kPo6
         +qE2cjHFXMvCZNydTSAgPYhypWjhIKi+hHm4dGUEiZGCjEtwk1cq6oDTSd2OWkLpg65o
         AfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578690; x=1744183490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph/WNnmzsBCerzFt9WZb8x3hC6of/SCnGtCoahC4exE=;
        b=YMBiXEj7SrMkogCSvp66obqejhkJR+F7J6FtyPj2Qj0vrDyU9LPf1FbJHw3lGSo/xX
         xmYWGHcNfoy1kc0nVApaTgDWN070eiqKSTJiOWdIDE/EnlI9Mtyo5jEfl6T+HPVMuo0A
         QPzbskKA/bYLuFUE5ShLI4zQ2kIW5aa58OFofGgtktyuteW8h+ibleNzqR63i73+jcRw
         lmRtcwUBI0IZm9IHwKSwWzZgA4Gkn+5GfYYdIvSACQuRmC7w/QJ0DuEUGs3Yna0mvIQg
         mAk/H++wock9j9YmowQDWpA769jsvZMj4RV3M8im3cQ3Z5uLVr40wS659paEYzkHObIW
         KoJA==
X-Forwarded-Encrypted: i=1; AJvYcCXdhGrl2O7fDIXqOWwPiN9AxfTpgZqh4JNkOwtmVWy6SZpcJmvrcVTRP6Ufw4iRAjB2DqcUhehmutQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QBVxZgztc6D0gpWdqKiNzbs6zhdN1cDX68xBBV8fO2SBHdby
	qtEUEpzt4YEoLOMP4tNZqghTYxUovh99Zm018LPxWGPxhKC4YHTNYFbC+315CE262ogUHWGTmzs
	=
X-Gm-Gg: ASbGncsmb/xky43lzZa1lOZJokzA8DLmd1Juv90tiTJ32OH0KX4+xvs6mGMlRIWGz28
	qOqAnExjB91/1RELGRsx1gtr6BffDdLxT3IWihPp2nVy97gR+jq6wGWKtnF6ztGMwXMwgegkxib
	pqhWniFsrG6x21YVh49JfIQHYmM0iOZJV8txbO9UVRkTADQZlHQbBwSnHQWXfvwx8aBbfFhs3JU
	K/l7ena+h93x6Gj/cIgELzk2uTLOflONmMjJeeOqxfUR5eGtRG+1cKr/cQFnTXUMJ4hsvfWA8bP
	HhtqfGpmNpSU/dHtV/o7cD0pn8iJs1LZlQdGXRumYKG/qfne2n4d0a7r
X-Google-Smtp-Source: AGHT+IFdLWFYiACDauEbg5cQX4A8B6hyWbH7RuHYeaUxrKTptKpzhiLHs1jTHxl9bS2Dm1CCE7hHHw==
X-Received: by 2002:a17:902:ebd1:b0:223:3630:cd32 with SMTP id d9443c01a7336-2292fa162abmr256125885ad.53.1743578690448;
        Wed, 02 Apr 2025 00:24:50 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ded78sm101287545ad.197.2025.04.02.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:24:49 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:54:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <gi25vqmydz6ybnebskjv4c6v5g5lxdnw5vpkdijhmsngza7ipv@fnrevrwfw6hq>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <01676177-4757-41D3-BEC2-F61C0C7C3F69@kernel.org>
 <bbgwy44nxf4h4hiycyue56uzfktfqzzwvw73bovtz42uklhuri@ejqrp5kjqbqh>
 <Z+RT4BxBzK68Crac@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+RT4BxBzK68Crac@x1-carbon>

On Wed, Mar 26, 2025 at 08:22:08PM +0100, Niklas Cassel wrote:
> On Wed, Mar 26, 2025 at 09:47:18PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 26, 2025 at 10:39:50AM -0400, Niklas Cassel wrote:
> > > 
> > > Can all Qcom platforms raise INTx in EP mode?
> > > 
> > 
> > Yes, all Qcom platforms support INTx. But if we start setting the flag to true,
> > there is no need to set it to false as that would be the default value. So let's
> > just set 'true' for INTx capable platforms and assume others as not supported. I
> > know that you had added justification in the commit message, but I think we'd
> > have to drop the below commit:
> > 
> > PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts
> 
> Well, with that logic, we should also remove the following:
> 
> $ git grep "msi_capable = false"
> drivers/pci/controller/dwc/pcie-tegra194.c:     .msi_capable = false,
> 
> $ git grep "msix_capable = false"
> drivers/pci/controller/dwc/pci-dra7xx.c:        .msix_capable = false,
> drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
> drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
> drivers/pci/controller/dwc/pcie-artpec6.c:      .msix_capable = false,
> drivers/pci/controller/dwc/pcie-qcom-ep.c:      .msix_capable = false,
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:    .msix_capable = false,
> drivers/pci/controller/dwc/pcie-tegra194.c:     .msix_capable = false,
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
> drivers/pci/controller/pcie-rcar-ep.c:  .msix_capable = false,
> drivers/pci/controller/pcie-rockchip-ep.c:      .msix_capable = false,
> 
> Feel free to send patches that removes all:
> {msi_capable,msix_capable,intx_capable}=false;
> 

Sure. Will do once I get some spare cycles.

> I will be happy to help out with reviews.
> 
> However, I'm slightly leaning towards thinking that there actually is some
> value in _explicitly_ seeing that something is not supported.
> 

No. We should only set 'true' for capable controllers as 'false' is implied.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

