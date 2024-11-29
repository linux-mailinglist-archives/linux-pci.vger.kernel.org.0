Return-Path: <linux-pci+bounces-17469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173A9DEC19
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AFB2827FB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082561A08A8;
	Fri, 29 Nov 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRII9fe2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5351A01B8
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904780; cv=none; b=Hy7hJNDN9eteYR60Pw18x8eGW3kqCnoXGrtJzLC8zEqEvPHMJP4u/fq938ZuABC+AgjXNnLtc/tOmBoxWqhlHyVz2lgI9cvvW6h4IYhjvvnuANY4dvdR1pOJMQxbWGc8o3xNfSE77MJNQATqYt4I9nteXeVCtX79dbwS0ysbFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904780; c=relaxed/simple;
	bh=tjspvHACBeuFnwaCynG30mtPY9dmtEdqTx0lBS6qvmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjvdWk0YN+cZxs6o9phZeGsKTgLYSIDR1PLwjbI7CHOa49flbRL0/fIl76TQKsDZmjaSx1CyNX6HZaj99sIJ9XdjkJcGdyADAPA2wL9FhRjsGqy+iW2+N6J4h/35GfZQ4WKoV8VhlDwHVdFjC3UDeSwNEkMkUUPiAvftMgT6di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRII9fe2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21285c1b196so21139725ad.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732904778; x=1733509578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUqDieEaHq8j2cJhiW+HET9bXqMPuEtWZyclYt+rp+A=;
        b=mRII9fe23Tr8+PGSXMMFh268bzplYwnqCGrap78IqKyfWo8aKIkxqmZRUEq74DRRDJ
         swLEa6WskZyajXU0Kk6rDB1CDrfn+xniBcSg+i73ty0EpPDjpXtcoFbU56CKpy4fAOC1
         2bETIinDI6aSxx+TNslFRI6FanNvOCuxMw3eTYtMBqfxPH7nIUitgkQMxO/nvg2haMSA
         T1s/tJgb+vjKwnjrIQ2IYdKOXQ4diWwv6Tn8cxbLXATn6stLGLFDHc6cSpG+r0KRHEJS
         Lv/BUEZftIDqBghb9vaQUmoC9+eae3upnhP6LFUyo2JrImSpZeh05mtfAA+LTtoTYAM0
         uQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732904778; x=1733509578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUqDieEaHq8j2cJhiW+HET9bXqMPuEtWZyclYt+rp+A=;
        b=Piaczc3w8FFAw5p+5q98MwriJZlD+1j9D/VINOR42JfQjNTXnVvUHvANqF/IMk+l6/
         rtTCw80CNbN3Ap5nByuMt0GAqIzWBUBpIfCAPqLAt9GoRA3xhsk7//RyWAa3zdeVsmdf
         JS3ZGSzeJ9floczChywt06ZJbL7lPc2hoGhXqbws2Nj0CMedKS2N2gu6CU/gBkcTdgvI
         wjS+2OR0xOiiYwXv0YQi9k67XXVT6ohTOVzc7uKLk5bbBC8ksRZTDRsQQeBpRpHdofWX
         lEqQkLRgnUTsaesUW08MxEPVURzLj4BsYy1t6AGwFECInIKKhPbYUg/75f8/+fNM6+t3
         FYKg==
X-Forwarded-Encrypted: i=1; AJvYcCX9pTpdkPl+K40cIIUm+oK9ejuQcolGHy/MMFBH6RvYE40YQ/Gyk/Q2JbHGmD+HaDdoA8wtmaZ/kKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXp/5AHc+H8xuDzdS8M4fHC8ZPqTZWrq9BnoTQbO+SmaWjaB4
	oLBGUW6QCT+VyGqdfCs59SYsQITKbzGkAIAqRavqQ5NQ4/MeZFE/rmXqHmMBQg==
X-Gm-Gg: ASbGncvDyzUBbnLK7SyRs6/da6EQG6xSn+/k5K2BP/CD506I4jfJuU47tbFxjw+16iD
	z+VThBouXQPir8HSDwnDJ2+r41cuZhepUxZ7Jo4V1LTvZI8E6CMPazBX9t58l5f/JAcJqxRsfDU
	Ehcx2CGfYqU6hg3enhNPCD5p1EjIgjZ4+Lg6TLSE11UtfocDsj2c2xqNpmHsM4To+3XldQZJ4KU
	Gr2mhklCkt9+6sVlhfh8TwCfRUIrwQbBfq9FBEJiTkOw2fOyVJvYKpPUKRn
X-Google-Smtp-Source: AGHT+IH+zvrZZgMzaNl9B8zJJgiJwZioPP7Ew1oxT4/eC4rURgyODQYi5m7tRLX855mTtPxVC5cR1Q==
X-Received: by 2002:a17:903:283:b0:214:f87b:c154 with SMTP id d9443c01a7336-21501087636mr171418375ad.5.1732904778593;
        Fri, 29 Nov 2024 10:26:18 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f511asm33707695ad.1.2024.11.29.10.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:26:18 -0800 (PST)
Date: Fri, 29 Nov 2024 23:55:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <20241129182547.prc4bsmqjvylfymk@thinkpad>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
 <Z0nG3oAx66plv4qI@ryzen>
 <20241129163555.apf35xa6x5joscha@thinkpad>
 <Z0nu8n5GEuZ0zaBD@ryzen>
 <20241129165256.dkzcbfdvmf2n4rxx@thinkpad>
 <Z0n2KIUVk2XqrH1p@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0n2KIUVk2XqrH1p@ryzen>

On Fri, Nov 29, 2024 at 06:13:12PM +0100, Niklas Cassel wrote:
> On Fri, Nov 29, 2024 at 10:22:56PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 29, 2024 at 05:42:26PM +0100, Niklas Cassel wrote:
> > > On Fri, Nov 29, 2024 at 10:05:55PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Nov 29, 2024 at 02:51:26PM +0100, Niklas Cassel wrote:
> > > > > Hello Mani,
> > > > > 
> > > > > On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Migrate the PCI endpoint test to Kselftest framework. All the tests that
> > > > > > were part of the previous pcitest.sh file were migrated.
> > > > > > 
> > > > > > Below is the exclusive list of tests:
> > > > > > 
> > > > > > 1. BAR Tests (BAR0 to BAR5)
> > > > > > 2. Legacy IRQ Tests
> > > > > > 3. MSI Interrupt Tests (MSI1 to MSI32)
> > > > > > 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> > > > > > 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > > 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > > 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > > 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > > 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > > 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 
> > > > > I'm not sure if it is a great idea to add test case number 10.
> > > > > 
> > > > > While it will work if you use the "dummy memcpy" DMA channel which uses
> > > > > MMIO under the hood, if you actually enable a real DMA controller (which
> > > > > often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
> > > > > are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
> > > > > pci_epf_test_copy() will fail with:
> > > > > [   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA
> > > > > 
> > > > 
> > > > So the idea is to exercise all the options provided by the epf-test driver. In
> > > > that sense, we need to have the DMA COPY test. However, I do agree that the
> > > > common DMA controllers will fail this case. So how about just simulating the DMA
> > > > COPY for controllers implementing DMA_PRIVATE cap? I don't think it hurts to
> > > > have this feature in test driver.
> > > 
> > > I guess you could modify pci-epf-test to simply do MMIO in test_copy(),
> > > if USE_DMA && DMA_PRIVATE is set, as you suggest.
> > > 
> > 
> > No not memcpy, but using the DMA to copy from src to local buf and then local
> > buf to dst. This way, we do not need to fallback and at the same time simulate
> > DMA COPY.
> 
> Sounds very slow :)
> 
> What would be the value to add such code to pci-epf-test?
> 

Well, the test case is to test COPY functionality using DMA. Either we use
MEM_TO_MEM if supported, or just do DMA from source to dst. Even if the
performance is going to be half of what read/write would achieve separately, it
would give users a real benchmark. Otherwise, we have to skip the test case
altogether. Like,

./pci_endpoint_test -f pci_ep_basic -v memcpy -T COPY_TEST -v dma

Perhaps we should document this limitation and show above command to skip the
COPY_TEST for DMA?

> Sounds like we would just add a lot of extra code in pci-epf-test.c that
> would not test anything new. (It would basically just be the DMA read test
> followed by the DMA write test. If those tests pass, this new simulated
> test should be guaranteed to pass.)
> 
> Wouldn't it make more sense to simply do something like:
> 
> if (use_dma && dma_prive) {
> 	dev_warn(dev, "DEV_TO_DEV not supported with USE_DMA, falling back to MMIO\n");
> 	use_dma = 0;
> }
> 

Maybe yes, but memcpy is also doing the same. The problem with falling back is
that, it provides a fake benchmark to the users which I want to avoid doing so.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

