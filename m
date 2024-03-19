Return-Path: <linux-pci+bounces-4914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AFF8802B5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4A285C27
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7493207;
	Tue, 19 Mar 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzpzDHAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11C10A0E
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866914; cv=none; b=JmNG5YesX2BAVVbGXDI57e3zo3797pPoR5NqmcW3N/dr4Y6xIE9+h4rcuV8Zz2mPMKG2P6eKqrrqUikA+UX8JAITHwUs9txgsK94PPWua9LDdR0+Oz/1qyrQD4tUyhpuJ9cxAxXHB3lJoWZPLTxuxNaUBAQ4CJLITh7GHfLr/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866914; c=relaxed/simple;
	bh=+WhtHbCytSUQJBT2dERyPAT2yCB1oKqNL/ikkXFzg30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6Hmq2av1ppiRb6fsRWQWs2/xwFVvkhl4HSPns6VJ7Itq1BcJS6VV4Cq8cx4LvUgicU24CBHI2B7VXS0TmR2Ks1y7DFPhvuMqV2WGPBO8E+KQM7yd07EC0PJkYbwtL5xtO+EJs0g/6YyQNtDDdHGP8LhC30igK9EWM93KyZAQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzpzDHAp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e709e0c123so2683529b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710866913; x=1711471713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xf8hQbbqMlqKig7IQQ/6vixir7KRflP+tyTruiNA+vU=;
        b=AzpzDHApFZZ3qXJcRtWEdJeuLGktLYfTr7oO81cPB9uzE+k4BvTNM/Rib9iv/UhzKK
         bFlnCoCuA0KgmDoCcyHqmpzNPwhaKvgRoBTcdZe2f4yTxqpY1vxDXvOwHPF3TB1xivBw
         fUkYKddi+UR1hPlVAWwBAXBzsCmD6sJBUVdyk+47Lx8H/ESNXISEzvARkWbfyPsq1fcx
         RJ7IkvFGSUss1Jbf3v2AihBFOWxMG4lZ0GTJJX5ftLTmsSrFzv28GgRYuKAXYAzeqrF2
         RNwrvf/34/GzgoGGEG2X1a/GPQSZJvHdXzyOQolwUoBsi7PmdM8iSEvZnR7NjPwRILHS
         +QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866913; x=1711471713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf8hQbbqMlqKig7IQQ/6vixir7KRflP+tyTruiNA+vU=;
        b=m+De2waTuKtzxGhu16RhGbgDMGk4kh9wEBMm0tPyZ/dqNO+8KH+4aPy4FKUqt35p/i
         ej8lfBpB11AHqfR1LsVPZvuCLLnR1n7Frvz7WnMtEeOPi5jA+MaLoVvpm5GfgwwrXeyv
         55d2CbYxEc+RNeB5oMhiuaxoxEro3ztAJRiI6L2bjq3GWTzcJq5FSWNJbRuGmHRsXW4k
         sTqL6G/zyj4XW+aryi+Quankkfs7C0Mn1Ihpyf1kFvBEy/3EiHuC/qRqW2/M67Hb27Bv
         Byd2j91K3bwgEYWe8RNpOfiyUTo1gOY/JvVVvbn3R4o4jB6MtmUX2QWUPtEviaFxYqT8
         uVlw==
X-Forwarded-Encrypted: i=1; AJvYcCXaUr6awtC1ICq+r3DrM31Ndh228+rQWlCyFbBo/lxhDllQd7FosyOTkqCzShYFr60zziQ4VomeDEKSNrntP+N1amYfnmmhNEYS
X-Gm-Message-State: AOJu0YyQnefxTYb7urjM0JpiGjcOYfJHBfoZ7ufZGGYWeAGq4JBuIQT/
	APV9cM8raxkgK3mWGXSKnUK+foSxaZebFYNKvgG2JFJb/qRvcJiNjCGWIoBlPw==
X-Google-Smtp-Source: AGHT+IE+oPyMyKtaFky3WpAhZZRaLc3NOO5Q9HsGE/6Z6e2AJkiCEUh1W3eQJ6jpjrmv8Q49ZasuRg==
X-Received: by 2002:a05:6a21:9985:b0:1a3:5c83:31c0 with SMTP id ve5-20020a056a21998500b001a35c8331c0mr3412871pzb.38.1710866912667;
        Tue, 19 Mar 2024 09:48:32 -0700 (PDT)
Received: from thinkpad ([120.56.201.52])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b001dedfba4c69sm10955861plk.134.2024.03.19.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:48:32 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:18:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240319164826.GF3297@thinkpad>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
 <ZfnAATqpYlssxrT3@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnAATqpYlssxrT3@ryzen>

On Tue, Mar 19, 2024 at 05:40:33PM +0100, Niklas Cassel wrote:
> Hello Arnd,
> 
> On Mon, Mar 18, 2024 at 09:02:21PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 18, 2024, at 20:30, Niklas Cassel wrote:
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index 705029ad8eb5..cb6c9ccf3a5f 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
> > >  	0xA5A5A5A5,
> > >  };
> > > 
> > > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > > +					enum pci_barno barno, int offset,
> > > +					void *write_buf, void *read_buf,
> > > +					int size)
> > > +{
> > > +	memset(write_buf, bar_test_pattern[barno], size);
> > > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > > +
> > > +	/* Make sure that reads are performed after writes. */
> > > +	mb();
> > > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> > 
> > Did you see actual bugs without the barrier? On normal PCI
> > semantics, a read will always force a write to be flushed first.
> 
> I'm aware that a Read Request must not pass a Posted Request under
> normal PCI transaction ordering rules.
> (As defined in PCIe 6.0, Table 2-42 Ordering Rules Summary)
> 
> I was more worried about the compiler or CPU reordering things:
> https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L1876-L1878
> 
> I did try the patch without the barrier, and did not see any issues.
> 

There shouldn't be an issue without the barrier.

> 
> I did also see this comment:
> https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L2785-L2790
> 
> Do you think that we need to perform any flushing after the memset(),
> to ensure that the data written using memcpy_toio() is actually what
> we expect it to me?
> 

The documentation recommends cache flushing only if the normal memory write and
MMIO access are dependent. But here you are just accessing the MMIO. So no
explicit ordering or cache flushing is required.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

