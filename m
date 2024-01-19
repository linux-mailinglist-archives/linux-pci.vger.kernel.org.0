Return-Path: <linux-pci+bounces-2333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2F832501
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC18285F97
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996A3C0A;
	Fri, 19 Jan 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy6dS/VR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40567944F
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649333; cv=none; b=rX+PQEPm7VonPeP/iP/wbk6L34tVBu1vTYr4FF/pIeIw8daCbIUfst2yV1NmcvgZVbROtgp8bh/kDdZxbyOY6a1tl94d9GKGWpMb/MN/CM8lLo+5dbBty8fVPuMnba68Sv/7wNVnDCjysKnjln/3AxzMeEBiWYYFk2evLEUVaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649333; c=relaxed/simple;
	bh=69/RqV/A9lodeZFJ33s4o7jKp84bmhN8cSxnNImvxjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC0PLP6qOFhRHIDiCAHdFkoH0om9qdFBAcgF2zxF9kzyGGlDb/9Uk6YiD1xNsvM9OHVTDXsv5eOTIqjbMm8jSo5ZR27aEVCnaoIrL7/LUmSqfp46LZGTc+8uJIVMnpFONkuRAwYsIm/V2bTj4rhHom8jtCKqlKh5pYGLi8GmurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yy6dS/VR; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5989d8decbfso281375eaf.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 23:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705649331; x=1706254131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jAiFI/yvaL8Qq4R2H+lz7RghStZviQ8Vc/0mAOlq10=;
        b=Yy6dS/VRYBeOZI65JXWlGe1Ah84Co7IbQXLvXJCtaUsLjVjLFU1jE6rxM68vZ6+ND+
         X1VVjJQGsCa1JbU47XNqy3JNyeszfcq7ldQvqion/wdMlNQhkEWg/Ytt+kTMsUkIkUQp
         OgQ4n+hJd/c8AMMxVLxQhrXArUYz8tA3BQe2f2pfX79UQDPgiXAaNkTmgrqFY55ikAGx
         CDtFXlCeC13kS6OfGPell2GXi9pfoa6Y3p6KsLdc6OmTlZodCsBg+SvkzNVtJ8QGxyQj
         o/H+Py6G6/ueAECSBZ7+YJauA2byIIjC4bVIs1a6mrhwRH+xoWigWwuiCKNrbZxB+E1p
         fUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705649331; x=1706254131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jAiFI/yvaL8Qq4R2H+lz7RghStZviQ8Vc/0mAOlq10=;
        b=VTXh2sEPNzLVxleuvt3ev5JfQLu8cpKL/QdhW2+CsBzX6I723xE+A/VrGe08FGxttt
         ReoOZJ7uNmbkiMw40Wg3dm4SCjhJSTiENTJ8eqyfOu0+PvG7OkYp6WdComyAI7/Oa8aM
         ixCsGNzQaOtoBi8bbRgyu2wytqtO3gUEv+PyLJdHfhbfqgrDHPqtxL5OCAdTNdW6WMJ0
         azsGq9NDlBLUHFeGj+X89ZiH4qyy9ILvq1vZ8Nx8aKontnnN0kKxwOBGxemilYz9qGlT
         1d5/fdUuPFvOn6XpvtnfilauWEazkX6EoygorkYaFSlDzFUJS+Mk41kUN8KBQXamcJk+
         8Z7g==
X-Gm-Message-State: AOJu0Yz+2zsVq9MQGkrzp7inpfFfJbObyuUzlsc+Fno+DfWs0uooJ2oi
	hN/5GuBRzYRSngdlz13sR4poDTy5uj3rK+gKMfblDCDw3aA68oAvqspUvyOX9Q==
X-Google-Smtp-Source: AGHT+IFtESwXBzDIx6X05cuoaycVAwHJT1YpO5zrXOdBalBmMS1AXy1MxIWoy3U8FOBs+zefArabcw==
X-Received: by 2002:a05:6359:a11:b0:175:9fdb:8345 with SMTP id el17-20020a0563590a1100b001759fdb8345mr2101692rwb.10.1705649331225;
        Thu, 18 Jan 2024 23:28:51 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78517000000b006d9b8572e77sm4421823pfn.120.2024.01.18.23.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 23:28:50 -0800 (PST)
Date: Fri, 19 Jan 2024 12:58:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240119070116.GA2866@thinkpad>
References: <ZWYmX8Y/7Q9WMxES@x1-carbon>
 <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad>
 <ZWhwdkpSNzIdi23t@x1-carbon>
 <20231130135757.GS3043@thinkpad>
 <ZYY9QHRE4Zz30LG8@x1-carbon>
 <20240106151238.GC2512@thinkpad>
 <Zalu//dNi5BhZlBU@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zalu//dNi5BhZlBU@x1-carbon>

On Thu, Jan 18, 2024 at 06:33:35PM +0000, Niklas Cassel wrote:
> Hello Mani,
> 
> On Sat, Jan 06, 2024 at 08:42:38PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > So to give you a clear example:
> > > If you:
> > > 1) start the EP, start the pci-epf-test
> > > 2) start the RC
> > > 3) run pci-epf-test
> > > 4) reboot the RC
> > > 
> > > this will trigger a link-down reset IRQ on the EP side (link_req_rst_not).
> > > 
> > 
> > Right. This is the sane RC reboot scenario. Although, there is no guarantee
> > that the EP will get LINK_DOWN event before perst_assert (I've seen this with
> > some RC platforms).
> > 
> > But can you confirm whether your EP is receiving PERST assert/deassert when RC
> > reboots?
> 
> Yes, it does:
> 
> ## RC side:
> # reboot
> 
> ## EP side
> [  845.606810] pci: PERST asserted by host!
> [  845.657058] pci: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
> [  845.657759] pci: hot reset or link-down reset (LTSSM_STATUS: 0x0)
> [  852.483985] pci: PERST de-asserted by host!
> [  852.503041] pci: PERST asserted by host!
> [  852.521616] pci: PCIE_CLIENT_INTR_STATUS_MISC: 0x2003
> [  852.522375] pci: link up! (LTSSM_STATUS: 0x230011)
> [  852.610318] pci: PERST de-asserted by host!
> 
> The time between 845 and 852 is the time it takes for the RC to
> boot and probe the RC PCIe driver.
> 
> Note that I currently don't do anything in the perst gpio handler,
> I only print when receiving the PERST GPIO IRQ, as I wanted to be
> able to answer your question.
> 
> /
> Currently, what I do instead, in order to handle a link down
> (which clears all the RESBAR registers) followed by a link up,
> is to re-write the RESBAR registers when receiving the link down IRQ.
> (This is only to handle the case of the RC rebooting.)
> 
> A nicer solution would probably be to modify dw_pcie_ep_set_bar() to
> properly handle controllers with the Resizable BAR capability, and remove
> the RESBAR related code from dw_pcie_ep_init_complete().
> 
> However, that would still require changes in pci-epf-test.c to call
> set_bar() after a hot reset/link-down reset (and it is not possible
> to distinguish between them), which could be done by either:
> 1) Making sure that the glue drivers (that implement Resizable BAR capability)
>  call dw_pcie_ep_init_notify() when receiving a hot reset/link-down reset
>  IRQ (or maybe instead when getting the link up IRQ), as that will
>  trigger pci-epf-test.c to (once again) call set_bar().
> or
> 2) Modifying pci-epf-test.c:pci_epf_test_link_up() to call set_bar()
>  (If epc_features doesn't have a core_init_notifier, as in that case
>  set_bar() is called by pci_epf_test_core_init()).
>  (Since I assume that not all SoCs might have a PERST GPIO.)
> or
> 3) We could allow glue drivers that use an internal refclk to still make
>  use of the PERST GPIO IRQ, and only call dw_pcie_ep_init_notify(),
>  as that would also cause pci-epf-test.c to call set_bar().
>  (These glue drivers, which implement the Resizable BAR capability would
>  however not need to perform a full core reset, etc. in the PERST GPIO
>  IRQ handler, they only need to call dw_pcie_ep_init_notify().)
> 
> Right now, I think I prefer 1).
> 
> What do you think?
> 

[For this context, I'm not only focusing on REBAR but all of the non-sticky DWC
registers]

If the PCIe spec has mandated using PERST# for all endpoints, I would've
definitely went with option 3. But the spec has made PERST# as optional for the
endpoints, so we cannot force the glue drivers to make use of PERST# IRQ.

But the solution I'm thinking is, we should reconfigure all non-sticky DWC
registers during LINK_DOWN phase irrespective of whether core_init_notifier is
used or not. This should work for both cases because we can skip configuring the
DWC registers when the core_init platforms try to do it again during PERST#
deassert.

Wdyt?

- Mani

> Since it seems that not many SoCs that use a DWC core, have Resizable
> BAR capability implemented, I will try to see what I can come up with.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

