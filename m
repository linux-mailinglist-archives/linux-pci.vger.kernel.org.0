Return-Path: <linux-pci+bounces-17893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2409E851E
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180711640BD
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9C148316;
	Sun,  8 Dec 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnoM76V2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF45146D53
	for <linux-pci@vger.kernel.org>; Sun,  8 Dec 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662747; cv=none; b=ox94Ny5p31lOY6WGrNZ81+7/R493495vCzK6VXUPeNdKKPhBCDHlMd7uvJKb/tHLBm0E+F9oc9JJZz7C5M8+XsWUYMpF1ns+8cfhwR5caI+GSYPTv8GcI8G4BazeoFkz6pCFNZMDxVmaEXQtKCti3XQDNK6iVgOVSbyx5lFht3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662747; c=relaxed/simple;
	bh=qfboI2JEzglBgUiX6GwJaX8ACsXX93fcly9pP3dAhjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppILa6wJxHdDHdIkUKGfLSNa/PdZhlWIKL22LBb/zgMfPmR6/DrW10viiRFqUA+xvP9NpkajWHKMM/pLLqDiYUF1Avx4O/4QiGGuKZcun7oQM57eD8iuhEakOo2rltioC8gX5Xo+zBTkByhCDV1ksiU9XfLEnv6xx2WY8AqZv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnoM76V2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso2575415a91.2
        for <linux-pci@vger.kernel.org>; Sun, 08 Dec 2024 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733662745; x=1734267545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PkDi47df4w40KWTcb5cXC5QjvFJDjRmn08x5U23uXOc=;
        b=SnoM76V297rGqFd1H//F+GV9PlMDBcPdA+4+h3CgiOgdhR7TlFYEH3oBv/DsAkAWOr
         wD08WGlJ+9cT7wjXQqNZD8xyNZrljWagavHtjQEqL2a5bpwmEqJ10WuBqfIQ2RBHaYDI
         dgw3/lHCDWXNZv5n8rboU8ULYjTpd5kqLiwUlZIMxsghRd54ADd9bxTg/0o2KyhzVTvQ
         BfMdwRMsK9zqGp1mFrGQfXbNch29asL8Xlx/FXUvOsdqe6OLH7vQgpI9A+QdtLxpZtu3
         fHX4A5vRrNtxmTsSCSTahFHKgi0an27npXfe6qdOJ7cvELxrR+3TKQv2WTVu+YQ/TM19
         Qqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733662745; x=1734267545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkDi47df4w40KWTcb5cXC5QjvFJDjRmn08x5U23uXOc=;
        b=ix0de3N4veD9tpQDwzAKs+XEGmvZYrkSTrglbRDfPrr3bz3HVngZPsh8Z5X+ATMIux
         qF0GlBi1DihevUiKOhvrxv6G7BYOoIK5wSJ583jK2MbkjK1SfEDlMzKDntp0sMW18BSr
         SMnA3UDqiDvlXd4gVFD07yrhMUBDiky6iXVrFztcUkyDqZoQ8YAr02tkuS9uvFj3fm/D
         fcCy6OLiUqAQCexwkcmXgI5dUZWwJcaue6pfaybnU80p17qFxGeWPUuX2uPbok6Cp++C
         VLRJCQkf0MAgwEsWFHPvObzJtqO2p8G801LGA4cRK4P5Wu//cYeC4SRShGQZn7krPCS9
         E4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCvzp+8bdQuUmnVwtyUL5Pd6oLrMvWtbvUYc2IZjF2lBBH3J67id9WCtfPkPQs1bJX9anu7bA9H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAB/xmy+eFN1PFIaZhdJE5KnUTR1cS7A/4KmdU4fPH7Ljs1v6
	g77FpqSdxXtFE+1ArKj8Ib6OYOJXCRDV55cyA/x0djQHK7eYKR5LA0zzlE1L+w==
X-Gm-Gg: ASbGncs/4Kdw4CF/5IPiKlbOV5CtAQz8gpGHtLaYyDKcQb2jGRN/LXtoR4Vyy9S7Y8J
	PgT5KYo5lPHJeJwLhyDVSx3TIDr9n5812ZTFD2AuUnC3Y4KeWxyWxI28FJWV9EGrRYeBya3n03i
	8iXmxVB0bHvtfNl2xllyqe0bV+4yxQbdR2iD4S7A5o2Pcp8j3MZX2zySXNlz0SN3ipAoQDOu/LY
	PCoySuXo6aUxqQph+Z3YWomA9MdUZfwXdgV+/bm7FA1QBGQVpAkhoG9Ahw=
X-Google-Smtp-Source: AGHT+IHnhUVK9JHD0Nbg157D2tYLCZPvpbGaZMt6ugQdpbPZ+L62KfObJPkXd8gqt06CrhFVbhdPKA==
X-Received: by 2002:a17:90b:2548:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2ef69f0b061mr15208744a91.16.1733662745572;
        Sun, 08 Dec 2024 04:59:05 -0800 (PST)
Received: from thinkpad ([36.255.19.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm6228921a91.45.2024.12.08.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:59:04 -0800 (PST)
Date: Sun, 8 Dec 2024 18:28:58 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20241208125858.u2f3tk63bxmww3l6@thinkpad>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
 <20241129202202.GA2771092@bhelgaas>
 <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>

On Mon, Dec 02, 2024 at 08:21:36AM +0000, Havalige, Thippeswamy wrote:

[...]

> > > +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > > +	if (intr_cause[d->hwirq].str)
> > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > > +	else
> > > +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> > > +
> > > +	return IRQ_HANDLED;
> > 
> > I see that some of these messages are "Correctable/Non-Fatal/Fatal error
> > message"; I assume this Root Port doesn't have an AER Capability, and this
> > interrupt is the "System Error" controlled by the Root Control Error Enable bits in the
> > PCIe Capability?  (See PCIe r6.0, sec 6.2.6)
> > 
> > Is there any way to hook this into the AER handling so we can do something about
> > it, since the devices *below* the Root Port may support AER and may have useful
> > information logged?
> > 
> > Since this is DWC-based, I suppose these are general questions that apply to all
> > the similar drivers.
> 
> 
> Thanks for review, We have this in our plan to hook platform specific error interrupts 
> to AER in future will add this support.
> 

So on your platform, AER (also PME) interrupts are reported over SPI interrupt
only and not through MSI/MSI-X? Most of the DWC controllers have this weird
behavior of reporting AER/PME only through SPI, but that should be legacy
controllers. Newer ones does support MSI.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

