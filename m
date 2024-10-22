Return-Path: <linux-pci+bounces-15018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EA9AB227
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0C21C226FF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088E1B5823;
	Tue, 22 Oct 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fob+AvI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CC1B5338
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611044; cv=none; b=qjosmK6n0f/fCk56KvuU3hNXLg1FqyNt2butbg5lF3zXKn/6niyDYSIaEgI4flQjkut4kz3EAJdSBetwF1SlGW+VyHDs3nFlMYjzZjyeLrD1NrGtnkMiUWhtz66h90kVLYnqaVlh0BEEz2qGIEn1vwoyx6Hs/CEMY5MD4+thFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611044; c=relaxed/simple;
	bh=ZOSl0DCTzyKmg5E2o09Loly44K+r8tmFpPRUATDOHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVW0vvNhf3TSHJr/YypZGxXjJMS7Npszb6a8B4K91CRnzpFA4BALuWm6ErLCPGydO9TNJdq2cfTn8ngVaxgFRpLcts2e/diJSypFcIQvdNFHKL2c876s8ztwv3f8g+HDtS9bWU2YiLsv7nBkyVsQBXkUDQfIDOM7kI6asmlqfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fob+AvI7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso4491182b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729611042; x=1730215842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L0s6ofxM4XlAn3B2YqwdNM/EtzgzHY+V5Ejv5L6vTd4=;
        b=Fob+AvI7TyFpjsemkPgfw036+qFe63RgEJcc/mVDBd5iowOSAx9PaC2aU0npsA4kAq
         vWx11HU9Bq58yhpSKJpZARPl0dCPzXpifBccR4iaNnQO63R+XoM1dfH/nrVTeJhZgstf
         HEZaZ3OhqSdadhK2ITS06k+fULby/EGNiUL6m1RHh6tYKIKDBzRTrWmMIXBGSTwoYc+J
         ZyfXWmH4TieEkzC4E7Gme8WEAtoS5Gg2oA41ZP3cYhJ0e+CRIGSYdJsF7/A2hmyvMRqT
         AGBTPaQIpgPp1rwyOKAi2y4+pUGv1KbPKusdTEuxYG1GGZow10obBm9GGtb3JcmZXStd
         bndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611042; x=1730215842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0s6ofxM4XlAn3B2YqwdNM/EtzgzHY+V5Ejv5L6vTd4=;
        b=R/xqAS/oXdfeceGzlq32a4byk4AbTO67Ln6bTgeqrIhodjmMhxUwQ5yCdl5YdHHvbX
         TvE2Nncm4M4KKKt52t+Fap7lHMIIq7nXu77llUko0+KfPZmR1xHXhE/TPGEyzVeUEzNq
         +MmvyPfy3sthx11wR4PuSRx3lREe+bSedylCCB4LtGSwXsFetplH17nnR0sxg6I6SoE+
         sso5WMape/pxMLN+w//8C1m1Wa4Hl7H9U2fJaQM0d0O8xDyEZaUJq7+HUtguTFHGLhi3
         Y/sz4/IS9CXBqGeDImkYc0OCVRIHaWAmfo2Ad9ZAgAfOR0+IDdXQNgu9STVOD5quqkU8
         jZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/TvdOmPFqbFCneNIJ3fVAb8hWVy7QVvfoFYpKeRsRh5z+bcSZHBE7uEDsUDmY0O2A6OPj+Ylj2so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroAdhG8L9dbiPge6b4qy8etD6Js01uWhOLl1NaBKsJZOasajZ
	KHhZfYcA/jgJSANGmhMWYuVocSDvZPzLPEtFFBYr6b2EQF41/Rozawq6nybqng==
X-Google-Smtp-Source: AGHT+IFmiQ/rJIXtc+MHGm/uX4dOnI2LymwG5xxawpQP3Y+5Ets+8VW+BLkU5HL/+1HnykmYTbqAdw==
X-Received: by 2002:a05:6a00:3c91:b0:71d:feb7:37f4 with SMTP id d2e1a72fcca58-71edbbc166bmr4902674b3a.6.1729611042454;
        Tue, 22 Oct 2024 08:30:42 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312ce3sm4892480b3a.39.2024.10.22.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:30:41 -0700 (PDT)
Date: Tue, 22 Oct 2024 21:00:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241022153033.uizmuvqzamfninlr@thinkpad>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
 <20241022135631.a6ux4jzb47v7jvqr@thinkpad>
 <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>

On Tue, Oct 22, 2024 at 04:16:24PM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 07:26:31PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 22, 2024 at 10:38:58AM +0200, Niklas Cassel wrote:
> > > On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> > > > On 10/22/24 07:19, Bjorn Helgaas wrote:
> > > > > On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> > 
> > > However, if you think about a generic DMA controller, e.g. an ARM primecell
> > > pl330, I don't see how it that DMA controller will be able to perform
> > > transfers correctly if there is not an iATU mapping for the region that it
> > > is reading/writing to.
> > > 
> > 
> > I don't think the generic DMA controller can be used to read/write to remote
> > memory. It needs to be integrated with the PCIe IP so that it can issue PCIe
> > transactions.
> 
> I'm not an expert, so I might of course be misunderstanding how things work.
> 

Neither am I :) I'm just sharing my understanding based on reading the DWC spec
and open to get corrected if I'm wrong.

> When the CPU performs an AXI read/write to a MMIO address within the PCIe
> controller (specifically the PCIe controller's outbound memory window),
> the PCIe controller translates that incoming read/write to a read/write on the
> PCIe bus.
> 

I don't think the *PCIe controller* translates the read/writes, but the iATU. If
we use iATU, then the remote address needs to be mapped to the endpoint DDR and
if CPU performs AXI read/write to that address, then iATU will translate the DDR
address to remote address and then issue PCIe transactions (together with the
PCIe controller).

And if DMA is used, then DMA controller can issue PCIe transactions to the
remote memory itself (again, together with the PCIe controller). So no mapping
is required here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

