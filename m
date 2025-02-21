Return-Path: <linux-pci+bounces-22002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B6A3FB52
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D13189F285
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778C1DDA24;
	Fri, 21 Feb 2025 16:26:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAF286298;
	Fri, 21 Feb 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155174; cv=none; b=udzCEzVyVegajumeLqqOn6qNNo1YI9cLcrsnI24/EvJUaXMRZtYHyRs45VZABDPDKxBmhugfqKqx3tKjdRMFDXnovh+SVv1hOGbkOtsjX+xdh+/1WEc7eKcdJt1APx2JhyDwbPUBXgRkR15HuUFNGH47ChP1/Y378yamCpG2E9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155174; c=relaxed/simple;
	bh=bwyfdE/FLFiMluP9iNmNaFqs+Q/d+RJXSoF40a55j+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwMitHGIar4y6iLL09lAkF/AXMeElU0p/Kq9hijlsqY39IKXlz5PZPBJLyG2FaGjLGjEVu+xdGvldjORDUf+Z94URMMAmL7vEEJuEfQOQgcgaZO9i/HKV6TTgR4Hb/9XSG0yC6I1yVjOhDQIMStiDfF3AHZzQmZEV8XWThX612U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f44353649aso3581357a91.0;
        Fri, 21 Feb 2025 08:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155172; x=1740759972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z6O4IkxuL3soFsgl5HuaRJCPykEjaleOKC87F2y/io=;
        b=bG1E2z1FNaXtkyfWPOOtXrTxmemFk/yMIElbCv9Xsy5e01K3qFoZcljyuAm5GU+fwr
         k8nMF259Ulfu5/jvqKpwTCufutI2w1kKdmyGqw86K9KW0RAWiUuvOCB0c4iGS9VtkYd3
         fy9CdyQkSTzvwh+jvpM3bY4GBlJCqndNOnmGlzk0BRlm6FQBqJIUVaSlNozUOqTKumYh
         pPIsLdzwmrU6UGzNjx2e4xHBIMZI2SMcE+5ekwJj5EvOycDBQAZYm3koqSXb0TqdbgPt
         URRAdlKI5LHhO8eHJEju2m1YfpmqGOWmdfN3jBk49vDMmGUwCFV0arJe3gDJTlsfXAKc
         Mc2A==
X-Forwarded-Encrypted: i=1; AJvYcCVCCRnzB3Sm4kvPYLB8LEBc7b+kqA9Ut6cj9tHiF5iPSPgl0x4Ssf8bmb+EGGldlcozW4S4EvXCsKgm@vger.kernel.org, AJvYcCVfnoOipcHyOz8FexjvvBu7OAPcMC/HQBXGjanAS+wwG88k5Ej0XbAKpVUmiSqW7yCQN5cvHn913PeZ@vger.kernel.org, AJvYcCXBTN69GD7XJtVN1cpmQeuRgToZ5PWdALIRbVeEzUEJiQYZ9U6nlBpxjxypEv2W7KU++Ap9eAJ/YjgdUnse@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXcGpnp0pfMGr8lIOzPnSH/NW/9RX4DfKfvmwQMOzp8uOdlpz
	cTNS8pByX7ZpNVguLMTjotXFIjsAwTvgdp1UdXL6ZcErIL63BNTE
X-Gm-Gg: ASbGncvDKX79cucMlG2btMJ2XTTWxbZzCb/E2xC+O3ZJ9uqdVVsrmXDD2Xim51yEkkT
	GocRq/4KKLQFDCKfJ9qE6bYT1MOAB8oxkITzvXEKFJ+neY7DQWdXvgGQ1aMIWdGCiCJ3LvZxLcF
	lcmcfZCQvtNvB/jSCNiosZ/w3KrCwutoIF6Gb/IlXlU1/7eU+pLyeRCV02wKdjbn4y4+dOn4jlP
	yztyYwScOzRCWbgAvfVNl14LXEMJ3FyUvagfVaj3t2dnvic6DCJ2fJwr8jHzYwYFTVCAOUH3OGT
	oW+5SveJVTQPMuK96wQVQzyA61WxFacLzKARSP4gjo8rB0bvMl/10gbx9j8X
X-Google-Smtp-Source: AGHT+IG50X4zqXhTHhqI02RRZLr0tYQJLiTV1L9LZNvdYSx6bY2d/dTV4UtvP0Y/8m772MSFX/Z4OA==
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2fce78b778cmr6540511a91.15.1740155172321;
        Fri, 21 Feb 2025 08:26:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb02df46sm1603022a91.9.2025.02.21.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:26:11 -0800 (PST)
Date: Sat, 22 Feb 2025 01:26:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 03/11] irqchip: Add Broadcom bcm2712 MSI-X
 interrupt controller
Message-ID: <20250221162609.GD3753638@rocinante>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-4-svarbanov@suse.de>
 <87bjvs86w8.ffs@tglx>
 <b1009877-6749-4bb1-95b9-ae976bef591c@broadcom.com>
 <320db9bc-3610-4336-a691-a8926cdb7e24@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320db9bc-3610-4336-a691-a8926cdb7e24@suse.de>

Hello,

[...]
> >> As this is a new controller and required for the actual PCI muck, I
> >> think the best way is to take it through the PCI tree, unless someone
> >> wants me to pick the whole lot up.
> > 
> > Agreed, the PCI maintainers should take patches 1 through 9 inclusive,
> 
> Just small correction, patch 09/11 [1] has a new v2 at [2]. And I think
> PCI maintainer have to take v2.

No problem.  I dropped #9 when applying.  Thank you!

	Krzysztof

