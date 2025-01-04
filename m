Return-Path: <linux-pci+bounces-19273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6524A01234
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77491643E0
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1C26296;
	Sat,  4 Jan 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDW8Oob0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CC4A3E
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735963873; cv=none; b=HMzPj62aJrJooBG/wq9EFLLxP9hqkmt9GIS7pEEz3JTZhvFlaJWLtJO0iYODmoltNzswhw6G/Q/ZXjTkO/sIalVOFm9fWzzjZAxpJv0n+tRvFdd+NyX+pmsGbm+yUMga/3mrHKbCw1af2K9c9B7vtpn85CGgP08bRPO61yviFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735963873; c=relaxed/simple;
	bh=7Pi6kyEpBsdFPwA62C1rxeLGrWhzjfbfYFeVCWQya6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAmnaEp7s8O6OQPGZeoohVAfqPf1wA+3UDD1yJ3ZPtXo7b2X3r8M2fXhEz2tPDFe3sd7ImJqn9wi/3bgNkBxInrn4jdSBgP1c0oJSmfzJnFjmtYPlmGXM+u1UYUB4p3hhTRXIX8nAMSytJ3FxludMpr/itPx1v9dnUS1v7c9+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDW8Oob0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21654fdd5daso168264055ad.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 20:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735963871; x=1736568671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vvx4SxXgxFMB8uO4Tw27L5cbZ09IEbFwnRjThr2yhrI=;
        b=zDW8Oob0gosGID5l9IXJjh6bxdXU0dr9x6zTL2B8mewInwwHqiZgQyXc0quPhb+889
         ySwclOgqouqG7P4WiiJ2O9EYV2Jekba4kFJhAaS3kABMshWtV6GaIcfuJNFUR6hBucmZ
         +yJV5ZUicjBEajR7cofF95s59HWjtKnz87igjuXbslRarwFG6iXRffk/ZQZ3bx+tRuhl
         ZR603xFX4IAe1RNUnScNWOPrtfo+TZRyBebRbARD0p0vK3RPjG3lYBmoSDPiTzdFKGzw
         bbKLQc/fwvxVlrqFANnnZQbwDIagHqcMIkqcgloA7xGjzM5OiQEEXkneymS+wagSpOrJ
         yoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735963871; x=1736568671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvx4SxXgxFMB8uO4Tw27L5cbZ09IEbFwnRjThr2yhrI=;
        b=WTOQQnzxqUn2IYAc17a5C41RQENU3gRuBfaVewwSDzCC9vWkONyqWtldHI14ZYmFYI
         xENqdYTFEOTIwdergE82tAkN1x1Af0yAix0JJXFEIO5JjJuPWhZUG8ZmYluQrb+b9It1
         bsjMqzTUMMdc5GcszYy1NatLJi5nrPgN4hqyGozNoHdMkfzIq3y6qEeAjj+8ztKIT8yX
         AzQ2cl6uQcL1Ql8sWWjCbS8P0Gp14LCEuCBjMkuC3oyza9LaTDzHNpwwoKGsKeryOi0L
         XNX2G+3B9d+s6lv1QDabMbUGutigeo1K7Rzfc4Zk8g9PAbhXQ9XFMtR/mCERKy8Yojyk
         cTZA==
X-Forwarded-Encrypted: i=1; AJvYcCUzTglFOcnm8ne0O/L/EkUgzBl/CWozcZxucjBojP8hLEzO6Gl4WTiqIRe23ON5ZCosbzOCzG+f00g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwRCkfxt13daj+Sn8CKzQmi5djnjfChAEQpBB687/66jYwv/G
	qpSeQyM7ro3NxxCu2aTl9qb2R0W/cDgWczEUANnBSBTBRi9GnZLQTAmPU+LT4g==
X-Gm-Gg: ASbGncvRIbeAp8GMKk65JRYPTI+NDiyCpy80SBcWgrxIaW9oqmvKjzSHVU+7dijM6Zd
	U1i29qeWWED0UfiUFpM9ZhJCHbxK9dDWrsj6S/3oyd5sE/tKbdm5mE9F6ifAPVY0fkPenK3ne5m
	JTo1bH0pcDAMH+kmqD28dZq+/Mj41M4KG5UrVDr4bLx1+RsLajlzpdxriwPP/jI87oGbPpyUBwV
	zDDA5E3DTxD9iUwmiUWaQzDPJdpM4GB1d7vSenyDpMUwA5LCED9PkHTiR7HpJ3GjykfjQ==
X-Google-Smtp-Source: AGHT+IHEt65n1+21wZvjnx8L5t2LrPvaLI2+F5+eXO0JDyHzqDP5rmyivgZPT2Pa79tAdDuGO/WcGA==
X-Received: by 2002:a17:902:f64b:b0:216:779a:d5f3 with SMTP id d9443c01a7336-219e6ea1c00mr767651435ad.14.1735963871204;
        Fri, 03 Jan 2025 20:11:11 -0800 (PST)
Received: from thinkpad ([117.213.100.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-8e2478b59bcsm12993849a12.72.2025.01.03.20.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:11:10 -0800 (PST)
Date: Sat, 4 Jan 2025 09:41:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Fix W=1 build warning in
 dw_pcie_edma_irq_verify()
Message-ID: <20250104041104.vdk7asaxzlj35r7f@thinkpad>
References: <20250102111339.2233101-2-cassel@kernel.org>
 <20250103221056.GA9766@bhelgaas>
 <Z3h-pFXG4zHiOMBJ@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3h-pFXG4zHiOMBJ@ryzen>

On Sat, Jan 04, 2025 at 01:19:48AM +0100, Niklas Cassel wrote:
> On Fri, Jan 03, 2025 at 04:10:56PM -0600, Bjorn Helgaas wrote:
> > Can you make the subject say something about the fix instead of the
> > warning?  E.g., something about fixing a potential truncation?
> > 
> > On Thu, Jan 02, 2025 at 12:13:40PM +0100, Niklas Cassel wrote:
> > > Change dw_pcie_edma_irq_verify() to print the dma channel as %u.
> > > 
> > > While a DWC glue driver could theoretically initialize nr_irqs to a
> > > negative value, doing so would obviously be incorrect, and the later
> > > dw_edma_probe(struct dw_edma_chip *chip) call would fail, since while
> > > the dw_edma_probe() call expects the caller to initialize chip->nr_irqs,
> > > dw_edma_probe() verifies nr_irqs and returns failure if nr_irqs is < 1.
> > > 
> > > This fixes the following build warning when compiling with W=1:
> > > 
> > > drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> > > drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
> > >   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> > >       |                                                  ^~
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Changes since V1:
> > > -Do not reject negative nr_irqs value in dw_pcie_edma_irq_verify(),
> > >  as this will already be done by dw_edma_probe().
> > > 
> > >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 3c683b6119c3..0a13fb4336f4 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -986,7 +986,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> > >  	}
> > >  
> > >  	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
> > > -		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> > > +		snprintf(name, sizeof(name), "dma%u", pci->edma.nr_irqs);
> > 
> > I don't understand this fix.  I guess the warning is complaining that
> > sizeof(name) == 6, and "dma" takes up three bytes, so the %d has to
> > fit in the remaining region of size 3?
> 
> Yes.
> 
> 
> > 
> > But I don't see how printing nr_irqs as unsigned rather than signed is
> > a fix, since even an unsigned int can be longer than 3 digits.
> 
> You would need to ask GCC authors behind -Wformat-truncation why the
> warning only seems to care about %d.
> 
> 
> > 
> > And I don't like using "%u" for a signed value in order to "fix"
> > something.  That's asking for a future cleanup to revert the change.
> >
> 
> Well, neither do I. V1 was a nicer solution IMO:
> https://lore.kernel.org/linux-pci/20241220072328.351329-2-cassel@kernel.org/
> But that fix was rejected by another PCI maintainer.
> 

TBH, my concern with v1 was adding negative value check for a signed variable
which doesn't need to be signed. But even so, the fix doesn't fix the underlying
issue but just the GCC warning.

> 
> > What's wrong with just making the name[] buffer big enough?
> 
> Sure, I'll do that in v3.
> 

Yeah, this seems to be the right *fix*.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

