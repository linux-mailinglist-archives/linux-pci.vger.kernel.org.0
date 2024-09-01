Return-Path: <linux-pci+bounces-12579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9772967BA2
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C06281EE3
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168817E919;
	Sun,  1 Sep 2024 18:04:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3517B50B;
	Sun,  1 Sep 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213856; cv=none; b=Kuj9aS6A6piH7fS7PwGzvOEcLHFttYuM2kEEY78R9PNXR8ZUFpOQU72IgKU4TiL4r3Z7ViZOx+dhT7xoWbBrz74MSR96cA1EOqSbwEPzYxQUikXsZOJNbnRyrI+k6KfCvUk5yCOW0Tm3h0XkOWj/mWjU6F133Ehf5gGwlbMAO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213856; c=relaxed/simple;
	bh=mnSq0J+JAKAOOwz0q8Iy/LxdUvgMeeHZ4n9wNNQXTNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpykAe+3VOdJA/b4YUHBXxJFgE8uRiayWVSjXlRZlCr3f5hvvYDv0vmzHM+Mz6PJEqzTq/KOCXSRw0njMPXzRKmjJ6vN74jTjqvvQQj2XpObgvBgP9C8rz4heKq5W3Bx7qwc3DkwddvZiA3xm+tspmqFEXyWX1lYdEl5BrksNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-715abede256so2562574b3a.3;
        Sun, 01 Sep 2024 11:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213855; x=1725818655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG0+yx6lkiBOBo9wZ1TUCw/nC9WNNgBDrOrRdXxDmtQ=;
        b=HyNI20b4+8TUnrVGskOh2T7f6Y/Cn2zUMEImDuNGlPDfJ/pFlEIjDpQS4cK4Loc8be
         JMc3OhZJv3rgWP+zZIUzV59tWMsBilpaUy/v1EClkmTJv08ESFmomaZ6VbmJFvc/rRbb
         BzFiod4UdfA1GzhRPu6gHO6hyRBKqcaiezbPU8h3jLKYXyhooE5GTCQ845ALeiAYxx9f
         /QGqHyT2TE8IM0DG8B1vn1VjQD/E34FoZ1XYoLPi1kSt8B1zXxL0aPTT/yM+JLR7Hw/n
         bqgYmZXKztbznDy++n5/MUAEcXHHrmN3HBlP72tzr5MIkaH4mrOpRW6gYU+p49Jw67FZ
         Gb2w==
X-Forwarded-Encrypted: i=1; AJvYcCV4vOMaMcMNXyzs/K4JfO3Z9PyHAG0nSv+T9lXyUQFEeKEWNbuivIGKGp4mPLYoVJw641iKysbfAxjPrek=@vger.kernel.org, AJvYcCVgDEmiYC+B6Mspm9yKQQqX8enfFlUJiSbnQv3hSQ3R+kcnG3Z37CnOCZsjyO72sVGhfEFHUNDoqAmz@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJw1ipi6gf9sp3nB4dWe9w6vHwimTxgmVRTxRbiCTfsVAGsmN
	dm2Mp+G8mGPPe/VCF6VgDU0tV33Eh6y5BmsTWm8bsEdqLABQmcX8
X-Google-Smtp-Source: AGHT+IFdF25jKRbqtpt6HeDfX5701wEoMfBbhZ9oPZdruUyO5yZDmR2lDVhK/v7B8dw7IreFesMVOQ==
X-Received: by 2002:a05:6a00:c94:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-717449b190cmr2631254b3a.24.1725213854767;
        Sun, 01 Sep 2024 11:04:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm5791529b3a.17.2024.09.01.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:04:14 -0700 (PDT)
Date: Mon, 2 Sep 2024 03:04:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240901180413.GO235729@rocinante>
References: <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com>
 <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de>
 <CA+-6iNykVzd1do=dHDVD3_prJkvfRbA2U-DsLFhSA2S48L_A8A@mail.gmail.com>
 <87b38984-0a54-4773-ba20-3445d9c9c149@suse.de>
 <CA+-6iNwJZ+OfYaCBBx04-hO1FmpDE36uJWd1jYvaVs_o4iwWqA@mail.gmail.com>
 <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de>
 <CA+-6iNy7souF-BZHV1sBk2nx04LwshB=6amnOixfPPza96RmWw@mail.gmail.com>
 <9b7cff3f-7d22-4bb5-a56e-11d93bd11456@suse.de>
 <CA+-6iNwAfur96=kftP_pqZDGUoGkb3_rjKnxiGJmL4xxmzTNaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwAfur96=kftP_pqZDGUoGkb3_rjKnxiGJmL4xxmzTNaA@mail.gmail.com>

Hello,

[...]
> Let me ask the HW folks if it is acceptable to leave the bridge reset
> unasserted on remove() or suspend().  Note that if RPi decides to give
> <clocks> and <clock-names>  valid props then problem will still be
> there.

I took this series, but if you have some concerns, especially given the
conversation here, then do let me know... We can always hold for now, and
get whatever changes you would need to be part of v7.

	Krzysztof

