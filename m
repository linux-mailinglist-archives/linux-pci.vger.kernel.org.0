Return-Path: <linux-pci+bounces-2475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7571838B38
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6BE1C22212
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5979B5A0F0;
	Tue, 23 Jan 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbcJutb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95A5A0E6
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003969; cv=none; b=IyetQTvNMIKmSE5JQXXjdByeGQe6BKDUvek4zY5UHfroyzm2swfV6vG02xTeipxQ4GKwEmd08BgPXRyzTPa+B4gup4Af2N1IU+NGNbq0/GWPCARkQSHyxrvBRz8Vo7JO/GpyOCI2kDoMagQI36F4afgB9CncLkdFmd5ZIEkRvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003969; c=relaxed/simple;
	bh=mN0zErUWFj0Xm6KLXY8Qw/x8jK+5OaIfzWKv71AnNLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnOsQDqFwQuJKsjCd97GTCvBwQLIzgdhBE36fU9d7OBJkWGFpLLYp2LzMUysuvxjOwJEwjbLfHgl99QW5sV2glUeN/Z5Ul4te2i0IUqB1zVDpr9qqPOuFCOVXT5gzMtPuCnUvfNPtlj1BopZQV+tdqOyPoFFja6dwhTEaO/8MwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbcJutb0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6829510ebb9so27498686d6.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003966; x=1706608766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TbxGUoNOXajXgolNUqm0qQTadwVX9diReoE3WD3yyf4=;
        b=gbcJutb0KWP5onTO/ohkkTPW893I4gE6eZNOtSKsRyMi70TsRxT/6uO6CnTfgB0UhL
         tjBMUkPcaxkQLckyOoPUuEsh7Sz7n+RqOybNXS3VIq5DQrTkl2QY7glHyvdfnMKpy1EB
         5u/MbYqvzBxT9SagEpLKE7kLB3Gsv02CLi98oHL8QPrpsw7VQmMKeGxwEno321fHLPjN
         VV+6Lm7oXL2tFugvh59G+1WK8sOxCWRm2cua7FEO1nyuYQ2vM+RXNhr6ZY09rN2QCJSj
         y/b5iK9LmUgwMchHi+Imo8nJcfcFGSmzHNWxL2IhErkVtXhHryA3aAIXWC70kRXf71i4
         Ypvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003966; x=1706608766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbxGUoNOXajXgolNUqm0qQTadwVX9diReoE3WD3yyf4=;
        b=ouhqdoBXWacK/5qZwgqfbCCrfuAs4boK19xuqJx7I0KI4zCuNiycvTJ33kbfxTbYqp
         jRfKZOa59GQIj6KGyIEP0ZE389xnyVcGNcpqf4RB7gfCpmqtCiWhZL3DFDQaw1odeYjv
         arf8ReOdHIlKZa1Sn96VmRpYLctDxYJHZPpGuEnjcGLDSWl4Zy4KLU87tMb59n9RczzY
         qiF0jlKLgQ2NWnoLTykoYASuMSLiKTS4eYhnlUeuXBE8EAe9W6xmvPSVabsqZnIs/RML
         5/QDw3lbw7NaaNRVTBhXwOBMqkfejD7GZ5UZSWc/01ORztVc0Xm1X/GvqJzXZbFa405m
         X0GA==
X-Gm-Message-State: AOJu0YzSeS/rE2fVEZsMsz69gVHViH0/dA7p6O79J4RfCiPXvYzj3XZS
	5JGpVfFknMXwO53vxFt7oKlezDf1ufkUJmB/tlBUAkG/298C/VJhEHWZBUypbA==
X-Google-Smtp-Source: AGHT+IGpQoVEaKMg1jxBWJCNUnhas7j6O/w5o9uKxqIZWAt6y6JsDeeBqNLR9tQc17c//cAL+TTxaQ==
X-Received: by 2002:a05:6214:d0e:b0:681:8883:d03c with SMTP id 14-20020a0562140d0e00b006818883d03cmr654347qvh.76.1706003966494;
        Tue, 23 Jan 2024 01:59:26 -0800 (PST)
Received: from thinkpad ([120.56.197.174])
        by smtp.gmail.com with ESMTPSA id de32-20020a05620a372000b00783aa2c9a1bsm547585qkb.103.2024.01.23.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:59:26 -0800 (PST)
Date: Tue, 23 Jan 2024 15:29:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240123095920.GC19029@thinkpad>
References: <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad>
 <ZWhwdkpSNzIdi23t@x1-carbon>
 <20231130135757.GS3043@thinkpad>
 <ZYY9QHRE4Zz30LG8@x1-carbon>
 <20240106151238.GC2512@thinkpad>
 <Zalu//dNi5BhZlBU@x1-carbon>
 <20240119070116.GA2866@thinkpad>
 <Za+EZmGONuQn/OaS@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za+EZmGONuQn/OaS@x1-carbon>

On Tue, Jan 23, 2024 at 09:18:31AM +0000, Niklas Cassel wrote:
> On Fri, Jan 19, 2024 at 12:58:46PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jan 18, 2024 at 06:33:35PM +0000, Niklas Cassel wrote:
> 
> (snip)
> 
> > > A nicer solution would probably be to modify dw_pcie_ep_set_bar() to
> > > properly handle controllers with the Resizable BAR capability, and remove
> > > the RESBAR related code from dw_pcie_ep_init_complete().
> > > 
> > > However, that would still require changes in pci-epf-test.c to call
> > > set_bar() after a hot reset/link-down reset (and it is not possible
> > > to distinguish between them), which could be done by either:
> > > 1) Making sure that the glue drivers (that implement Resizable BAR capability)
> > >  call dw_pcie_ep_init_notify() when receiving a hot reset/link-down reset
> > >  IRQ (or maybe instead when getting the link up IRQ), as that will
> > >  trigger pci-epf-test.c to (once again) call set_bar().
> > > or
> > > 2) Modifying pci-epf-test.c:pci_epf_test_link_up() to call set_bar()
> > >  (If epc_features doesn't have a core_init_notifier, as in that case
> > >  set_bar() is called by pci_epf_test_core_init()).
> > >  (Since I assume that not all SoCs might have a PERST GPIO.)
> > > or
> > > 3) We could allow glue drivers that use an internal refclk to still make
> > >  use of the PERST GPIO IRQ, and only call dw_pcie_ep_init_notify(),
> > >  as that would also cause pci-epf-test.c to call set_bar().
> > >  (These glue drivers, which implement the Resizable BAR capability would
> > >  however not need to perform a full core reset, etc. in the PERST GPIO
> > >  IRQ handler, they only need to call dw_pcie_ep_init_notify().)
> > > 
> > > Right now, I think I prefer 1).
> > > 
> > > What do you think?
> > > 
> > 
> > [For this context, I'm not only focusing on REBAR but all of the non-sticky DWC
> > registers]
> > 
> > If the PCIe spec has mandated using PERST# for all endpoints, I would've
> > definitely went with option 3. But the spec has made PERST# as optional for the
> > endpoints, so we cannot force the glue drivers to make use of PERST# IRQ.
> > 
> > But the solution I'm thinking is, we should reconfigure all non-sticky DWC
> > registers during LINK_DOWN phase irrespective of whether core_init_notifier is
> > used or not. This should work for both cases because we can skip configuring the
> > DWC registers when the core_init platforms try to do it again during PERST#
> > deassert.
> > 
> > Wdyt?
> 
> I'm guessing you mean something like, create a dw_pcie_ep_linkdown() function,
> that:
> 1) calls a dwc_pcie_ep_reinit_non_sticky()

This could be "dwc_pcie_ep_init_non_sticky" since we can reuse this function
during init and reinit phase. We can have a separate flag to check whether is
performed or not.

> 2) calls pci_epc_linkdown()
> 
> If so, I like the suggestion.
> 

Yes, this is what I meant.

> 
> The only problem I can see is that not all DWC EP glue drivers might have
> an IRQ for link down. But I don't see any better way.
> (I guess the glue drivers that don't have an IRQ on link down could have a
> kthread that polls dw_pcie_link_up(), if they want to be able to handle the
> RC/host rebooting.)
> 

Yeah, if the EPC driver doesn't catch PERST# or LINK_DOWN then I would consider
it as doomed.

> One thing comes to mind though...
> Some EPF drivers might have a .link_down handler, which might e.g. dealloc the
> memory backing the BARs. But I guess that is fine, as long as we have called
> dwc_pcie_ep_reinit_non_sticky() before calling pci_epc_linkdown(), the
> non-sticky registers have been re-initialized, so even if a EPF driver performs
> a .link_down() + .link_up(), the non-sticky registers in DWC core should still
> have proper values set.
> 

Yeah, there is no fixed rule on what the EPF drivers need to do during these
callbacks. So as long as we init the registers, it shouldn't matter.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

