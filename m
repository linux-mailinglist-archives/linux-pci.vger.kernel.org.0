Return-Path: <linux-pci+bounces-42904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D5CB3944
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2BD3064E75
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3C3271E6;
	Wed, 10 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSYCeALF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D930F541
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387031; cv=none; b=fD+sTWGCBUkq05SPUttpuccjGIGRGJ3t4sG4gCHS6Jk8jpbKAuDBX3LAiIuF3pjYq1AX84mPdHc44psSQ99V4AZBGiThZ6pxQyWOf5F3ovCRXA1o16G3CSmAcRdz+7iRHQR8QoAiF0JATq6ijUiGwnz7mNWYsNItdEriongfcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387031; c=relaxed/simple;
	bh=8fve6gmVdjKxtT7KpwkSfLuyzw4Ekfqcp/fLflsSjHY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNoSQCMcjQISthvjs+9p0GLdJCzOQWhgOLCj+R/9Z3WeZAozDkjJS+rSbSWT1DoHuAe/sHwLhCg0d8IsNTf/zbumVNuOfE/ViTD8rLgYvmv/317RKpjlels723aqOe9jaxgmc+IWxkoFKxlCkrU5FNDoVmr/nbvpqIG2V0XGQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSYCeALF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47790b080e4so139275e9.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765387027; x=1765991827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6hFo41XcPPply/FI538h06+gGYf20ouIY7Y9ZDaKEeQ=;
        b=WSYCeALFSIrg3vFmpmQ2lPJEZp5A4KYpy4GJ2DJYb1OHJptURhnsmUdSxBkgc/PPqL
         QZGbahf59zoUPy/alo8Y9E6fVGxm2apRrn+4KLGILFNv+79jz3K7+2Vtxn48/czbKUlN
         YqDaClqkHJP6YOriIvpEKkkmVouVq4eK1TQE2JhrCwmDZgHHSQ4iOiymE3IM19EcTjzn
         joyaCSnpGghkpibH0vMhXs0fOipmE+t3kZR/KkdjYrOtIyPrJfLnxKOtUOrV9qlmr/I9
         tiXlP7+9bCiXK/TypHQowrOk3l6ikT+l8+dYWjIUrWTSuy31JkgbMZMMmQWAVsVc6uFD
         OB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765387027; x=1765991827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hFo41XcPPply/FI538h06+gGYf20ouIY7Y9ZDaKEeQ=;
        b=aCuZQpPoX/EU1dhqO0PiTUg+Mw3JtOMn/wMIloqEjuIzk4NJR1cW9mOMC9SCj8f2+f
         dbtGcerJwhy2qaBS03spMi/6JvWV+NR33eTSG59fydUst8fw/r38PIgsay+OX3LsLMgT
         ZBOdUS6ScEVOwnSsMboLSuOIwmo9OFw8eyh8UyMk9RdQXU7Q47+tyWGj470uwR3V6SJ3
         5xSddSIJjmHh/T1uayMbQ1CY+LGgdq5lNNZD/+S1zZ4+Cw2/bnTpKDCDVtGkpnORwpmU
         efn6q6dpJe/xund6IrzBU5mpkQHjQSugIJFWj49AIrQKnypDs+GRf9UY33HyyXg7ZMRH
         FMRg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OrQl8xREASuYKRHknNeRo2JMh3TgymGdoqQuHPRRa/WqQmMUb7eSFPrYjJM47biW2wFy/3CboDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8V1Q7A0nx0VQ5XmiPtEdVQIFpbGfh0m/5Wqd5yJoU3otkTID
	bLAf5FWsce2stB4XIJH6Rc8vDxC8IixPW8tmyQE9uy1GVltesB6xfyLkAHAxgA==
X-Gm-Gg: ASbGncvD9NVgkwjcjXhOL4T7e4lvokvd3vg9OwKZAFvSKNK7CSc7dJeOtpIoCodQHh9
	4EJmupmrGl5Vih9LPyklS9y0tUSCqDaRVkIHhz8bb6nek1XC9GArsiT4MV+DmnlnjpjTt/DYboj
	5oS7qTg/H0ZDKwz8Dk9oVZnBrdSP8m/pj4fVyl7O/61qh7bc15cH9KrFvnX0DRxk7jD3Pt9dT8A
	uHIWTX7hxrYViEVeoAjmeK7WRVQYoV6qh0qLmsG59uuVVwhbhC+OLfp+O7uZnP71c8iP0qakIoW
	sTyNkIaHH5EcByno3nyKnd+5iIr1uVsFdRieG/THLWQe23bnRO8LnaIr5s0SrsDv6EZQ1uYtTiW
	07pcqEbsrcUCBoxNJ//JT01j2trg49w3I9XJ4IJ3dv565yun/397TuQSc14Wvra0bnPp0/3evXF
	8BKn9bfT3q+pPHnDdK1UTiBOPWXerSH+slg3y6H2c=
X-Google-Smtp-Source: AGHT+IGAFUaoxDl1XO7WFPjWhj1fe2N2/CH3UpEX9fZkmDbnaCR/5zfcwYt/zvtVtsDrqaQ4Ad/MHw==
X-Received: by 2002:a05:600c:1e24:b0:479:3a88:de5e with SMTP id 5b1f17b1804b1-47a8385368dmr22664605e9.37.1765387026744;
        Wed, 10 Dec 2025 09:17:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a88923ce6sm397615e9.18.2025.12.10.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:17:06 -0800 (PST)
Message-ID: <6939ab12.050a0220.29891a.9a37@mx.google.com>
X-Google-Original-Message-ID: <aTmrDS-RCPT1OKmw@Ansuel-XPS.>
Date: Wed, 10 Dec 2025 18:17:01 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets
 ->end
References: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>
 <20251210171319.GA3530931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210171319.GA3530931@bhelgaas>

On Wed, Dec 10, 2025 at 11:13:19AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 08, 2025 at 04:56:54PM +0200, Ilpo Järvinen wrote:
> > __pci_read_base() sets resource start and end addresses when resource
> > is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
> > of representing 64-bit PCI addresses. This creates a problematic
> > resource that has non-zero flags but the start and end addresses do not
> > yield to resource size of 0 but 1.
> > 
> > Replace custom resource addresses setup with resource_set_range()
> > that correctly sets end address as -1 which results in resource_size()
> > returning 0.
> > 
> > For consistency, also use resource_set_range() in the other branch that
> > does size based resource setup.
> 
> IIUC this fixes an ath11k regression (and probably others).  And
> typically when booting a 32-bit kernel with a device with a BAR larger
> than 4GB?
> 
> Christian, is there any dmesg snippet we could include here to help
> users diagnose the problem?  I guess the "can't handle BAR larger than
> 4GB" message is probably one clue.
> 
> Are you able to test this and verify that it fixes the regression you
> saw?
>

No my regression was on a different section and for AHB cards, no PCI.
(I sent a fix for my regression on the net mailing list)

Could be hard to find a device with 4+ gb of ram that is not x86 or on
an ipq SoC.

> > Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> > Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/probe.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 124d2d309c58..b8294a2f11f9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
> >  		    && sz64 > 0x100000000ULL) {
> >  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> > -			res->start = 0;
> > -			res->end = 0;
> > +			resource_set_range(res, 0, 0);
> >  			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
> >  				res_name, (unsigned long long)sz64);
> >  			goto out;
> > @@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  		if ((sizeof(pci_bus_addr_t) < 8) && l) {
> >  			/* Above 32-bit boundary; try to reallocate */
> >  			res->flags |= IORESOURCE_UNSET;
> > -			res->start = 0;
> > -			res->end = sz64 - 1;
> > +			resource_set_range(res, 0, sz64);
> >  			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
> >  				 res_name, (unsigned long long)l64);
> >  			goto out;
> > 
> > base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
> > -- 
> > 2.39.5
> > 

-- 
	Ansuel

