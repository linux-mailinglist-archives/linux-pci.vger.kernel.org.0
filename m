Return-Path: <linux-pci+bounces-12666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9196A10F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953501F26547
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779B16F8EB;
	Tue,  3 Sep 2024 14:46:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20271714C8;
	Tue,  3 Sep 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374778; cv=none; b=cOsfbWHd947x9IOfWAD78FJ2HPIwuvppv3y9zzIWyalgf9GX+jT29o4aZeN5XnLZp77Vt4bBDS8Aa2lfCSGIsPD9Edk+cDxHFAQZt5QR7uVmG+aXaC6mdTTP9BvohnzxpS/ZdkYVUfW4cam8fGX8MMYXMW+6ViX+K4BZASxZkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374778; c=relaxed/simple;
	bh=nG5/DhExrK/sDFise/67XU/3qKkrRT9ySPcQhT8OeVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpPfPCvXaQHG+dETxGXml2eapp1ThY/qdvtAyM9L6GxlcsOBLYBtPnxGQWEKaeVfNmBxRo/NZkNTKPMyhT6050Ii+R0RaoZ6B9BkCvEaKevsOJRbr0J6gJkafzOjwAF6j3GLOsebTKV3gzMBABFewcp12VroSOB3SYKQUfkhSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202376301e6so41645095ad.0;
        Tue, 03 Sep 2024 07:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374776; x=1725979576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlIJN7/IDs/oFriU9uFSlQnyKILfhpKkIsYfTci7DZk=;
        b=qGuWNJwWWpwuiBr2mgZjIn+cKSkVu1zgPcIWDejxVVfIq4qg0j7ngToBXzHBFqENwH
         RP36ZGeOR72Sry4KNybTi5t/JJVtJBNGmkbGkSEOi6vUb0pdIXvNnLVtgGSmLfzn6jOr
         i911bOEneW5YRpSgqE0Q2E+LTAVkkLBsZCdRnmvmDr7i8IrsE5CasLE87af5ONVP2Hjn
         oXpwCWp9h1F4rwm8+oQPQ+NXltwT+Og+mdyO5cnaF/uKwqWtB2cR3WJkc0bmy7oXx5qZ
         jCWaDYYiWrrhJMvmUuOVpvVMIympcCqcqvnyVi0WBieUXbitfumgr/jdVLiHdULvEQeM
         wilg==
X-Forwarded-Encrypted: i=1; AJvYcCWA583O4mt99Y5Hm3uJnOrjPJZJPEMXDGCA8pyBInH2t+Azl3xrQ63Gm2b1OE4nrC2PXlgBMxttvUdYJ+Q=@vger.kernel.org, AJvYcCX9ZkqpbujnEed28G/8np+V05sVtStdnExJDQn31dg3Gjt0yuJNJCSpLV0jg/fleZWqBIaTU/vkHE+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2cqfNAFJZHlMXQqM+FR/llw8PVLG5zCeLbfNNQlrlflkHDh8
	ygVZMG+hlAOUwhGUCmVh41ld++/ghRlkWCUak8kqCb97QS2gqbKtBuZamFb/8ro=
X-Google-Smtp-Source: AGHT+IFSlOQLjDmJsranIyAkE43u5G/I7rh4zLlr3vtjaRV32TwPT40udJIiDMhrJWaWV48pppZZpg==
X-Received: by 2002:a17:902:7c94:b0:1fd:7097:af58 with SMTP id d9443c01a7336-2050c215b2amr134223105ad.11.1725374775992;
        Tue, 03 Sep 2024 07:46:15 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20552a5f4b8sm47398815ad.52.2024.09.03.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:46:15 -0700 (PDT)
Date: Tue, 3 Sep 2024 23:46:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
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
Message-ID: <20240903144613.GC1403301@rocinante>
References: <20240815225731.40276-6-james.quinlan@broadcom.com>
 <20240902191827.GA224376@bhelgaas>
 <CA+-6iNywkWq=H1WRTWaVbPwa9aBTZxyhwfsWqX5eYh22L7P1ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNywkWq=H1WRTWaVbPwa9aBTZxyhwfsWqX5eYh22L7P1ag@mail.gmail.com>

Hello,

[...]
> > >  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> > >  {
> > > -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > +     if (val)
> > > +             reset_control_assert(pcie->bridge_reset);
> > > +     else
> > > +             reset_control_deassert(pcie->bridge_reset);
> > >
> > > -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > -     tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > +     if (!pcie->bridge_reset) {
> > > +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > +
> > > +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > +             tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > +     }
> >
> > This pattern looks goofy:
> >
> >   reset_control_assert(pcie->bridge_reset);
> >   if (!pcie->bridge_reset) {
> >     ...
> >
> > If we're going to test pcie->bridge_reset at all, it should be first
> > so it's obvious what's going on and the reader doesn't have to go
> > verify that reset_control_assert() ignores and returns success for a
> > NULL pointer:
> >
> >   if (pcie->bridge_reset) {
> >     if (val)
> >       reset_control_assert(pcie->bridge_reset);
> >     else
> >       reset_control_deassert(pcie->bridge_reset);
> >
> >     return;
> >   }
> >
> >   u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> >   ...
> >
> Will do.
[...]

You will do what?  If you don't mind me asking.

	Krzysztof

