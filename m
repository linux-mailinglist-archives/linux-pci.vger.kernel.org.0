Return-Path: <linux-pci+bounces-24487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C48A6D50C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B9D16CD94
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58363153800;
	Mon, 24 Mar 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIjUrsF5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E3198857
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801120; cv=none; b=hGxgcl1NQ2eEdxKeJxAGnNIzULuvmByrbyUKFtkukxicpGSrR2OsGLY0zlvZosy5FRknoaHF+ARHm2EnfyUX4M3yJkH65flEf0jHrDQFZydM5fCh71+6eov49mlzxYzwR79HdciJVQkQ9PGt9GPfGTuQGKIHGUXVGkkdYohfPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801120; c=relaxed/simple;
	bh=8MUuV6FO1ojBEDGqgDokijmkV6ruJlTuzs9K4PJfpJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4CDZ1f5YkSwjil8wWONcMc/2vph0mCVN1gPazH6b0vVkglgTTR9VzMOYN/eW3GeqUTrb4777pMX8SNnav19C/CcdlroEAQHFNRp3RVSB+dxswlkZumIi0EoY29P2L6K06mwP5qmx5pPd5Zc4+ZPi6hMyg8fiu0FoHUnlquSkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qIjUrsF5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3014ae35534so6047577a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742801118; x=1743405918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vj0JbxrXAVA6oD7VcAtXgMKT4fAYOqVFgdHGQAEeEsQ=;
        b=qIjUrsF5/h4qhsTO/VIrQGTf6hYaNo+ItFq2CDKkBgwVPRgOUZ1ne7g7FHIDfsE4T+
         /9pMRMUM9qB5aBDipdNlw/2YBKoT++CHNEkDQI02sNxGUz+TtOkhGPmlyxC+nE6H9ywR
         Js3InfnEHx+7eMGYLIEwP83/D/+aj73GTyLQbU4WW4fKSY/vMhBye5PkwPMRMpqOwOs4
         RRlGr1PntMJmm9ClsnrnP71CDDXofhP0dTCG1tyRj1FLjTqeeJ4U0ghOkX0u7ul0h80y
         BA17pkaWIEoU/289Pt7465da9wkhhxvza4BU6N7ZP1Cs9QSMT7+iCEWMJF20EllQfubZ
         8Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801118; x=1743405918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj0JbxrXAVA6oD7VcAtXgMKT4fAYOqVFgdHGQAEeEsQ=;
        b=MA1gF7fYPFBLhMsGtHtxrJ7wGGL+lmkpp2ULq+hqgLbzXk1/Nd8SHke60spnZ2hONj
         utBYZ2BDbj6iVj3wOffTgFDZlfgtBnjmKcfRuoVV1dw9HwJON42MVS/K5YTG3xMNtdXs
         Sz08waBwt8gRO26+7LT88vDp/ouYpzXtehYep4sMl4pHqsBCyx9h+JXDcAGc1lQ+zT0x
         ICP0QQj0eu9x/6eW+2Z0cvMjnGmkQn7t6Ajs3QF7TppXpKEF4KIYllRuWrbAQVn7gkZ4
         r5C6Sr15LjNvwMXSjLZV/AO3IoXWhyAl9FMjMf++nDSmcO5sUK7GBj7vnxU32WdH/VPQ
         WwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAVbam9A6U2Ra/vuiBIetV54bLkZXhREqDiLYeyzZw+Onw+h64aEqCsusYheUtsRfUxGy/rUlKTG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvednPDQquNQ5PUL2fVH7NocgTKaTo+YvtS1WlroIMuT7cxt+b
	Vr0RzB425bNUJcMPFWAubM50zoLivjGRCYjNy+PH+G54Vzwxp+ACpho2zRYLLQ==
X-Gm-Gg: ASbGncuwuiwWTOZLWnM4ylECI9SuKLhjeSNhuVcFV9jV6YVCHZMq9JCmbm3z0UNwS4C
	lW2Q0r9z2MX9uA+Sd55WYonZx9DR6rYP1QlnUztwJmtrGXazVwvOCRiAvI7YUG2g9Y/j/EFtGsn
	ssrQjTwMjQmcSLyC4MzHS5EKNRUcb+ppJW8NceaZ+lfkaE9XJFAxopZNwYwUi0lJxtnKEhr1Yc1
	ZI2VyEllMfT+wfU4UACFWF3QBFsoYQvfdyuO2H5vq+k8DvUsQvIljxs3yfMk5wpv/55ZJg32CHz
	l3zNHtV26C4VWlnfXY2PNoEkOb5tgKO3Us+xbGCeVu7OZFpuxZHzNXL4
X-Google-Smtp-Source: AGHT+IFkcSPlya/dghCtIGB6baE4UY9siigdCJhCAQ1aprxfhPsqNa0EHD4upA3IZyCq4ENwSZDhpA==
X-Received: by 2002:a17:90b:4d05:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-3030fe8d50amr13269772a91.4.1742801117734;
        Mon, 24 Mar 2025 00:25:17 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f806fa3sm7307502a91.42.2025.03.24.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:25:17 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:55:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: dra7xx: Try to clean up
 dra7xx_pcie_cpu_addr_fixup()
Message-ID: <5lyvmuk7o3nj6xaozyghxnhivwcmx2yisnbhwugklx5u5sutmz@26ta4e5en2mq>
References: <20250317184427.7wkcr7jwu53r5jog@thinkpad>
 <20250317194539.GA969005@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317194539.GA969005@bhelgaas>

On Mon, Mar 17, 2025 at 02:45:39PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 18, 2025 at 12:14:27AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 17, 2025 at 12:30:08PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Mar 13, 2025 at 11:35:21AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Mar 05, 2025 at 11:20:21AM -0500, Frank Li wrote:
> > > > > This patches basic on
> > > > > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > > > > 
> > > > > I have not hardware to test.
> > > > > 
> > > > > Look for driver owner, who help test this and start move
> > > > > forward to remove cpu_addr_fixup() work.
> > > > 
> > > > If you remove cpu_addr_fixup() callback, it will break backwards
> > > > compatibility with old DTs.
> > > 
> > > Do you have any pointers to DTs that will be broken?  Or to
> > > commits where they were fixed?
> > 
> > Any patch that fixes issues in DT and then makes the required
> > changes in the driver without accounting for the old DTs will break
> > backwards compatibility.
> 
> Right, I guess the rule is that if we have patches that fix DT issues,
> we should apply them as soon as possible.
> 

Right, and those patches should not break old DTs.

> And later if we ever have confidence that unfixed DTs no longer exist
> (or if we can identify and work around them in the kernel), we can
> remove the .cpu_addr_fixup().
> 

Yeah. Unfortunately, we do not have a fixed deadline or process. Just like
supporting the legacy broken hw, we have to keep supporting the old DTs for some
time and then get rid of them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

