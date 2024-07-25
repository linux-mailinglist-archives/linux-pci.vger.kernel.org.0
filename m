Return-Path: <linux-pci+bounces-10796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3655E93C739
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80BB28237C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154E19D082;
	Thu, 25 Jul 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRg3ZDxD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CF19D8AF
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925421; cv=none; b=iGle5PTRmS9Lmezr3ttkW5TrvY+fy5kNWy7hqGfOa+V/x7Q+3MWG1gLWTJRFX24eIgaAMEeedSpiLfpsu0qjDSbWsVZS7CYf7Oy8v6arECtV4fgDMaNteAF6MkdENEJLOlYTp8l/sgm0K2x8nS0n+qgyzOH04J8JSCvVfnNoz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925421; c=relaxed/simple;
	bh=GwE5e5fOHu8b8BxszgA/TUe7/xBsKYj3T4zN+si4+NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM+QLg4F6VL1u1Alz8lVxd5dQprwIO1GgD+PkMJpAF8r6uIYb6UBMtnh9refXSU7oOhBCeGrojnJo1WSR+ylaRxzvSrLhHzU9K4bNEUkyDmStSeFvBNYgdfK1aY2888KYN1GWbP5vZMXc5J44Jvq4Fg9IKWK/kP2HU5yuQyg0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hRg3ZDxD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70ea93aa9bdso64852b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721925420; x=1722530220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJ+XTGjLJRBa3KHQGyhh/jsjpm3Poa2VfnAbLwWAvEA=;
        b=hRg3ZDxD9JahA8M1dJuUZSAWVodkOnx7qeFQ5Vh8+pNnWAOc0xasHJuNdUGZcrKW09
         I9vxcGnFTq507dpOFgVh7PAP6vwbwtZRVbd4qaSAJ3IwPEdBWdNTua1xHbeGej0Mryjm
         1FTGvieHO+qIqw94XrH4sD962/bGhZlxSRIMPFeYnJ2Ot9C6jcdUaNMpIbhoL7Y9e4Dw
         kDcGEZP0ZbvcI+BeddxLv2EfbHKARLYM2zI0mKoSv7T0XjU46LW1BzJX4wio9byQBJHM
         QMLpefukPRe4xkEYIdqIyVMzXMQ+XnhWZ0/gV5ay2oDaZBZMbNh8fpLCgfVOSJFvZIIp
         2tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925420; x=1722530220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ+XTGjLJRBa3KHQGyhh/jsjpm3Poa2VfnAbLwWAvEA=;
        b=eXOWoToMDBbm0qe3oqhywNf2iY4Fa0WE0RXa9Fh9Do+seQeNCeUxEYGhp0wAAy4Q2u
         IF1KFVM4QPGZs/MGDl3+XKHXDEvp9bVPH4jd3oYZgU8rFgOFyc162SlEYFJT3cEGQcel
         kN0eAsuf8XMjrdObT9xt76ACeQIVSGp/XrzSrZJVryXwC7kHbyvHXC/K0sa75+9jJl+W
         NQBkwqnRpgAqaOWnh9B97CG+lsAyYy7H8Qg7hw7rVcm5v5pN9f1YOe98S6Et7isDpYE5
         2VtW9hn8YA5uoH/PpgldP5XU+dFlI7H18wb80UyN8qH+cV1dYp2i2L4j006MFR5lB/kj
         LSDA==
X-Forwarded-Encrypted: i=1; AJvYcCUdff6BAU5eDwATcxznVwwulu+1pPwxdWz6GaBGt6GbV1FpS9kquKX8oKVP9ImQfEDMebobowz6HPJRgMPIe/5EKXyeOLRmm+To
X-Gm-Message-State: AOJu0Yx0PmRCPQzu+fusNt9rxPlQL8/YxKgDGjfdUi9E2cfEuGZv0qdf
	B6fG48SRXeMSAjs7jnG6W8reKJ54tWVdwKwl9iDPVITDzW1p1AiGuqlsAxHzQg==
X-Google-Smtp-Source: AGHT+IHnDHZ4FE5BwkV+FrBiD204vw243eE4aD3TRokyDFJD6nu0i1kqJ4i2CTDDIzN12n7a7PZLzw==
X-Received: by 2002:a05:6a21:3396:b0:1c0:f26e:2296 with SMTP id adf61e73a8af0-1c472c55c7emr4474790637.48.1721925419633;
        Thu, 25 Jul 2024 09:36:59 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73eb887sm3787926a91.27.2024.07.25.09.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:36:59 -0700 (PDT)
Date: Thu, 25 Jul 2024 22:06:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725163652.GD2274@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqJeX9D0ra2g9ifP@ryzen.lan>

On Thu, Jul 25, 2024 at 04:17:03PM +0200, Niklas Cassel wrote:
> On Thu, Jul 25, 2024 at 10:06:38AM +0200, Rick Wertenbroek wrote:
> > 
> > I don't know if the EPF node in the DT is the right place for the
> > following reasons. First, it describes the requirements of the EPF and
> > not the restrictions imposed by the EPC (so for example one function
> > requires the BAR to use a given physical address and this is described
> > in the DT EPF node, but the controller could use any address, it just
> > configures the controller to use the address the EPF wants, but in the
> > other case (e.g., on FPGA), the EPC can only handle a BAR at a given
> > physical address and no other address so this should be in the EPC
> > node). Second, it is very static, so the EPC relation EPF would be
> > bound in the DT, I prefer being able to bind-unbind from configfs so
> > that I can make changes without reboot (e.g., alternate between two or
> > more endpoint functions, which may have different BAR requirements and
> > configurations).
> 
> I agree that the MHI case (EPF requires a specific host address for the BAR)
> and the FPGA case (EPC requires a specific host address for the BAR),
> is different.
> 
> Right now, for EPC requirements, we have epc_features in the driver that
> describes hardware for this EPC (e.g. fixed size BARs). Right now, I don't
> see a reason to move this to DT (or let a DT alternative co-exist).
> 
> 
> For EPF requirements, the MHI EPF driver exposes several different
> versions (pci_epf_mhi_sa8775p, pci_epf_mhi_sdx55, pci_epf_mhi_sm8450)
> in configfs, and each have their own specific driver data.
> 
> The only negative I can see with this is that it might clutter the
> /sys/kernel/config/pci_ep/functions/ directory. Perhaps it is possible
> to create a /sys/kernel/config/pci_ep/functions/pci_epf_mhi/ directory
> where all the different versions reside?
> 
> Keeping this per-platform data in the MHI EPF driver is fine IMO.
> 
> If you would prefer to create a "pci_epf_mhi" generic version, that instead
> takes this information from configfs, that would be fine too. I would also
> be fine if you created a "pci_epf_mhi" generic version that tries to take
> this information from device tree (as long as it is also possible to supply
> the same information via configfs).
> 
> Good luck getting it accepted by the DT maintainers though. The configfs
> interface was chosen because some developers (including Arnd Bergmann, IIRC)
> didn't like the idea of having EPF specific information in DT.
> 

I know the story and they were right (Arnd/Rob) as the initial version tried to
use DT for everything. But MHI is different as it is a hardware entity, which
not only uses a fixed address, it uses a fixed region that has MHI registers in
hw.

Anyway, I don't have a *strong* motivation to upstream the DT support for it as
the current approach is serving good for now, unless new usecases show up.

> 
> > For combining pci_epf_alloc_space and pci_epc_set_bar into a single
> > function, everyone seems to agree on this one.
> 
> Indeed, but as usual, good naming is one of the hardest problems :)
> 

Respectively agree with you :)

> Instead of pci_epf_alloc_set_bar(), perhaps pci_epf_setup_bar() ?
> If the EPC has a fixed address requirement, it will use that instead of
> allocating memory.
> 
> If the EPF has a fixed address requirement, the API call will only succeed
> if EPC does not have a fixed address requirement.
> 
> Perhaps EPF drivers that have a fixed address requirement could supply
> that as a parameter to the API (and the EPC driver will fail the request
> if it itself has fixed address requirement).
> 

I vary with you here. IMO EPF drivers have no business in knowing the BAR
location as they are independent of controller (mostly except drivers like MHI).
So an EPF driver should call a single API that just allocates/configures the
BAR. For fixed address BAR, EPC core should be able to figure it out using the
EPC features.

For naming, we have 3 proposals as of now:

1. pci_epf_setup_bar() - This looks good, but somewhat collides with the
existing pci_epc_set_bar() API.

2. pci_epc_alloc_set_bar() - Looks ugly, but aligns with the existing APIs.

3. pci_epc_get_bar() - Also looks good, but the usage of 'get' gives the
impression that the BAR is fetched from somewhere, which is true for fixed
address BAR, but not for dynamic BAR.

After looking at these APIs multiple times (confusing at its best), I tend to
feel that pci_epc_get_bar() is the better of the 3.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

