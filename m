Return-Path: <linux-pci+bounces-10977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1593FBAD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 18:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D491C22198
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACA548E0;
	Mon, 29 Jul 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgnoradW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567615A4B5
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271372; cv=none; b=PFLcTeb26cjAg/lDDCcqQ6S+3CZOzsvcDuUf8Idc0gTtnLATylbhLo1ic9busLcE61xhCnGlKj40wRncH7Fx+idbLFpLBvEEOxUSnBOgEhi9+1SMt5IM/FkuuUFiRaQ6pDqZil/oRhFU1njFoU4tI+IzYuP5vWz1QDRmFiVdLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271372; c=relaxed/simple;
	bh=URifZBNF5+f9QmvDVSkPJYTv6EOBMaqh7NjaNftDuXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6KxAwMbqrzshz+DOUvXZFH7oVjCEp0AaEt+EThb021gBwZWpGCvyFhlpcgfMTh8giCsAMvYqRgNoQ+b8gRXmhji5TWxFvXwheL9MktGg1PrRf5XXHXUjU6rVSZekXWI3woZF4RD1Uq2DFosJc6FqtH3uB5gcWCMej+i+izFSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgnoradW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc6a017abdso19256915ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722271370; x=1722876170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jlVHyvOscYj6z/T92QaKGLmEv1GuNN0J32WV5QG8ZQ=;
        b=AgnoradWtGMpp54LTeQwS6JpEBt5lTu/aHOUEDX7behQSuFn0aZpgP6mbKs81n83RC
         GBCa81ECFJIJNrpq6ecD49n9U7pv8sbAkgoiDBVQrFRhlx2PA96D4C8wyjML/5Adiy5O
         kjZAeDSg75WVv5tGwJVr0M815miXUqNLDffI6JIJfU8Cw4gXSZHHyB17GO1ofcHl3RBP
         c1DYIKBlOuG7wk5CBWrF6uwsyqlwGWw3cNyDdklt8jBpdGTVjUfNXvyX7wRaXmzBGKU6
         KerTl0+bPVPwpsSQ6/s2bDV1LD+YOdyK/xC4KXE1EnUG1A/+wsfMGd4jgl0k+R9BBnAu
         CtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271370; x=1722876170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jlVHyvOscYj6z/T92QaKGLmEv1GuNN0J32WV5QG8ZQ=;
        b=v499DQ7snjPc7UozMjA5stoK3SPzwl9l5N4GknZ4o+M7Ofai8l3PNwoM2m98pe8gv7
         crhg1YF5bwjTSkg+YY5QtU+SMNZGYT4V/eS5L4ZlvrglVj8SMpVYmXVZow/ECFk79tQT
         xFaNCqt6jSkYSehrZcJXovs8hVArgMYh+MOzem1JanZ/K9tM3m3L2bnzGWF8mvC77GAj
         900W2/7xZIPYOLNUNyF0GB5khotDjRYddA8mcJBajny8QUZlwdQRYeSdO7+cjC/lhv7W
         GKdeR5S+uJWCFaIPdyJ4U10UbItPZdca07OvqvcAuiJukocFTkgY07YPP7cehYLP2bYd
         E9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbHrkyTRhknlfr6X0zfn3BIeio8zSB0WgVPeTFemk6FkiLwvQXvyeSJWISKmZ/NU1wEVapNSDFXPUxdIWtL3M/ouGuSgRHKsVE
X-Gm-Message-State: AOJu0YwMKrX6+SQmYu96JEj0cEoXZX0sWEMhW1zIe4QHAS/JUooNUIe2
	tYFXyDRnTu1JTyyNdGLIS84baCj0uSrOBl13hHHkRtvkaw9Y4kFLWjvm6goZlA==
X-Google-Smtp-Source: AGHT+IFodpOMYkksFiy8ftMEF4hsZPsJb7yC4/7LDH4c7jq9OTDrib4noVyYHuIEYfXFb4+nvzRBgQ==
X-Received: by 2002:a17:902:ecc2:b0:1fb:8f72:d5e9 with SMTP id d9443c01a7336-1ff0489f5cbmr66337995ad.48.1722271370132;
        Mon, 29 Jul 2024 09:42:50 -0700 (PDT)
Received: from thinkpad ([120.60.74.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f67528sm84953125ad.227.2024.07.29.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:42:49 -0700 (PDT)
Date: Mon, 29 Jul 2024 22:12:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, rick.wertenbroek@heig-vd.ch,
	alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240729164240.GC35559@thinkpad>
References: <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan>
 <20240725163652.GD2274@thinkpad>
 <ZqLJIDz1P7H9tIu9@ryzen.lan>
 <9c76b9b4-9983-4389-bacb-ef4a5a8e7043@kernel.org>
 <CAAEEuhp+ZtjrU1986CJE5nmFy97YPdnfd1Myoufr+6TgjRODeA@mail.gmail.com>
 <ZqOnkTidYLc0EboJ@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqOnkTidYLc0EboJ@ryzen.lan>

On Fri, Jul 26, 2024 at 03:41:37PM +0200, Niklas Cassel wrote:
> On Fri, Jul 26, 2024 at 01:21:32PM +0200, Rick Wertenbroek wrote:
> > 
> > One thing to keep in mind is that 'struct pci_epf_bar 'conf' would be
> > an 'inout' parameter, where 'conf' gets changed in case of a fixed
> > address BAR or fixed 64-bit etc. This means the EPF code needs to
> > check 'conf' after the call. Also, if the caller sets flags and the
> > controller only handles different flags, do we return an error, or
> > configure the BAR with the only possible flags and let the caller
> > check if those flags are ok for the endpoint function ?
> > 
> > This is a bit unclear for me for the moment.
> 

+1 for the new API name: pci_epc_configure_bar()

> Indeed, it is quite messy at the moment, which is why we should try
> to do better, and clearly document the cases where the API should
> fail, and when it is okay for the API to set things automatically.
> 
> 
> How the current pci_epf_alloc_space() (which is used to allocate space
> for a BAR) works:
> - Takes a enum pci_barno bar.
> 
> - Will modify the epf_bar[bar] array of structs. (For either primary
>   interface array of BARs or secondary interface array of BARs.)
>   Perhaps it would be better if this was an array of pointers instead,
>   so that an EPF driver cannot modify a BAR that has not been allocated,
>   and that the new API allocates a 'struct pci_epf_bar', and sets the
>   pointer. (But perhaps better to leave it like it is to start with.)
> 

I like this idea. But yeah, there is no pressing need to implement this for
the new API.

> - Uses |= to set flags, which means that if an EPF has modified
>   epf_bar[bar].flags before calling pci_epf_alloc_space(), these
>   flags would still be set. (I wouldn't recommend any EPF driver to do so.)
>   It would be much better if we provided 'flags' to the new API, so that
>   the new API can set the flags using = instead of |=.
> 

Well, with the new API I'd like to allow EPF drivers to set the flags to be able
to request 32/64 bit BAR of their preference. Because, the EPF driver may know
its own limitation.

> - Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
>   can only be a 64-bit BAR according to epc_features.
>   This is a bit debatable. For some EPF drivers, getting a 64-bit BAR even
>   if you only requested a 32-bit BAR, might be fine. But for some EPF
>   drivers, I can imagine that it is not okay. (Perhaps we need a
>   "bool strict" that gives errors more often instead of implicitly setting
>   flags not that was not requested.
> 

EPF drivers cannot explicitly request 32/64 bit BAR using alloc_space(). Perhaps
you are mixing set_bar() implementation?

But only if the EPF driver has explicitly set the flags, then returning error
makes sense if the EPC core cannot satisfy the requirements.

> - Will set PCI_BASE_ADDRESS_MEM_TYPE_64 if the requested size is larger
>   than 2 GB. The new API should simply give an error if flag
>   PCI_BASE_ADDRESS_MEM_TYPE_64 is not set when size is larger than 2 GB.
> 

I would prefer to return error _only_ if EPC core cannot satisfy the requirement
from the EPF driver.

> - If the bar is a fixed size BAR according to epc_features, it will set a
>   size larger than the requested size. It will however give an error if the
>   requested size is larger than the fixed size BAR. (Should a possible
>   "bool strict" give an error if you cannot set the exact requested size,
>   or is it usually okay to have a BAR size that is larger than requested?)
> 

I think it is fine. Most of the EPF drivers expose a register region and that
size is usually less than the standard BAR size.

- Mani

> 
> How the current pci_epc_set_bar() works:
> - Takes 'struct pci_epf_bar *epf_bar'
> 
> - This function will give an error if PCI_BASE_ADDRESS_MEM_TYPE_64 is not set
>   when size is larger than 2 GB, or if you try to set BAR5 as a 64-bit BAR.
> 
> - Calls epc->ops->set_bar() will should return errors if it cannot satisfy
>   the 'struct pci_epf_bar *epf_bar'.
> 
> 
> How the epc->ops->set_bar() works:
> - A EPC might have additional restrictions that are controller specific,
>   which isn't/couldn't be described in epc_features. E.g. pcie-designware-ep.c
>   requires a 64-bit BAR to start at a even BAR number. (The PCIe spec allows
>   a 64-bit BAR to start both at an odd or even BAR number.)
> 
> 
> So it seems right now, alloc_space() might result in a 'struct pci_epf_bar'
> that wasn't exactly what was requested, but set_bar() should always fail if
> an EPC driver cannot fullfil exactly what was requested in the
> 'struct pci_epf_bar' (that was returned by alloc_space()).
> 
> 
> We all agree that this is a good idea, but does anyone actually intend to
> take on the effort of trying to create a new API that is basically
> pci_epf_alloc_space() + pci_epc_set_bar() combined?
> 
> Personally, my plan is to respin/improve Damien's "improved PCI endpoint
> memory mapping API" series:
> https://lore.kernel.org/linux-pci/20240330041928.1555578-1-dlemoal@kernel.org/
> 
> But I'm also going away on two weeks vacation starting today, so it will
> take a while before I send something out...
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

