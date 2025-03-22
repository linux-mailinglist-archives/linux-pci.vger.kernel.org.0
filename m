Return-Path: <linux-pci+bounces-24426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEDA6C71B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00903B5101
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0623335BA;
	Sat, 22 Mar 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHaW/SLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08F2AEF1
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742610297; cv=none; b=N1Adb9usxvdzGmuOtdR2DYl3i5DkdX7jq77ZBjeZtDnfKleiwRptSp0hJ3GHBKOplSjxHe6SojDiKeezIEy49O6XLAkbxG7c6YxYKyUxVjPf1fqLsrpxwYBqeP0xoUux+pk9ZznimaKlvGBT63X/vea6qtWE2+mGfujEAnrDnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742610297; c=relaxed/simple;
	bh=WCt7NPjjx6XrvILIaixa98CCaX/gJCjvKDFlJiuKnSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSlYdw81iUWq0FNf+uEi5nsZh77+JHeGz1sbBC0wEs86yUL/GqZ4XIwTXJdn8AxeyvYUli4TqCXElioxm2ZaXH6Kjh6/kT4bgHx5C+NC0Y4r1crOo73YlOMysborgJBAylAwvWhGebmuw0PtIHPYuFZq2iYVh/XpptE1ZscGyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHaW/SLV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so5507438a91.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742610295; x=1743215095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5PBb5zkL/xaQaxCKgqKg+pATZNrd178eF4JymYazK4=;
        b=uHaW/SLVVYrNn/2ymrtQmbRMbX1H9eosN84WTJajmvQMK01YdpbEuNBfjBAtRq2FMV
         nGiZHsg7MfwCt4FzbhiEE5pGAmMjOzAxFM96LzIUTt/cQEdzHKm50W71j9ryiOz9rWjf
         WtOKhvSfRUZ5UB4dtMCa79yYURi+8vxCpvwts++BfSKGUa28Hy2Gz60ErBmIrcEiR/J3
         maN9+J2lFuAhoirDsZXLNFIkisfQPhaSDOIJeRZPSH0AqTqOBPWXndMp5pchMa+eKwvp
         sscCkt3gn4F9spn69Y6q7MsrxcCL3zilUxdh/GaltRmlbbnPMDHa2xBQQZ/QOLO2XGRR
         ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742610295; x=1743215095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5PBb5zkL/xaQaxCKgqKg+pATZNrd178eF4JymYazK4=;
        b=oksZMTOd77DZ0sMZW+zvPHtBKxXKFnM+w4MTz3HbFpwYxy6fb2bsp7cbxXJnaSznSq
         6wvKDN2F1hGgNdCwVohcTrnwKJVFddq1SjLas0zgUoWm0OfPKqLUQuvWv+Kz30dPZEO7
         AyIzBV5xeACHZimMckYJGXHYx1Au3nj6P0mMVItAQTrgkwGGf7gW8Ve10EwiuG+DpIRA
         0rMW+TnuTgq1T9aYN151XLyanTTWZbfffbPD0XKrya08OnXfD0Ri9IYEN8mMOzqZEoVv
         hE1O1B+cW8HBaGo2T1nI2VPWt90u4zhVc/hDSlS/G+SuWwWTKh3UuVO4GIJr1/TX5oxc
         5fKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKeRTcA2PvnTwvhuvtHZg/GBvuJtSEN6Y8pueyrM4CE2CuMCxibQywDjcjdFamsUpQPVWEePzzSt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmmT5aF45J88TvSFuPXEkIDiW6xNr//Ig4wllHDX8j7T0xUbs
	f0Afuz1+J9Zdcnm9Bx1upal1E1dML5s6TzH9gPtlfINE9ITPqH9R2os1DnL+fA==
X-Gm-Gg: ASbGnctwsFTvmikPl7YZ2ut78sOVCbOw2KzzLHXHyEcz8B4D6cj2W/uDC/pxTPwAM/l
	IEOGnefcoD/3tA8P2atOG2q466ZVpHz2PZvUpX1MVvomEDdZnBZSogbk12i+omMGw2oy3IxKQ+A
	cmAf6ewIrbmwjJ29KTXRFPIjcfOKKE87b3NKVfWshQyNfIeGK1bsYQYTvzrT3L5Mtvs1MTirreY
	8PZcAFWw54j80LIKsX8+xvQgckOsbt8Kklk7L7Uz1ia6JDp0Nqo/qV3zzgg4BgWG/vi3v8ok83N
	uWovKgZTG/zMnayQfN+auIrKL12mCMW96We59jTt87gRkzviJzxmym4WN+YQmpBhPZI=
X-Google-Smtp-Source: AGHT+IHuprRpIjVZ/rqN28ZgvXhcuQ7ArFkypOA76I4molytaxX71ff5yrtrxv4jR//9bQ7327uj3w==
X-Received: by 2002:a17:90b:2704:b0:2ff:64a0:4a58 with SMTP id 98e67ed59e1d1-3030ff08eb1mr8017545a91.22.1742610295014;
        Fri, 21 Mar 2025 19:24:55 -0700 (PDT)
Received: from thinkpad ([220.158.156.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a68dsm7020499a91.39.2025.03.21.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 19:24:54 -0700 (PDT)
Date: Sat, 22 Mar 2025 07:54:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <20250322022450.jn2ea4dastonv36v@thinkpad>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z91pRhf50ErRt5jD@x1-carbon>

On Fri, Mar 21, 2025 at 02:27:34PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Thu, Mar 20, 2025 at 08:57:32PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Mar 18, 2025 at 11:33:34AM +0100, Niklas Cassel wrote:
> > > The test cases for read/write/copy currently do:
> > > 1) ioctl(PCITEST_SET_IRQTYPE, MSI)
> > > 2) ioctl(PCITEST_{READ,WRITE,COPY})
> > > 
> > > This design is quite bad for a few reasons:
> > > -It assumes that all PCI EPCs support MSI.
> > > -One ioctl should be sufficient for these test cases.
> > > 
> > > Modify the PCITEST_{READ,WRITE,COPY} ioctls to set IRQ type automatically,
> > > overwriting the currently configured IRQ type. It there are no IRQ types
> > > supported in the CAPS register, fall back to MSI IRQs. This way the
> > > implementation is no worse than before this commit.
> > > 
> > > Any test case that requires a specific IRQ type, e.g. MSIX_TEST, will do
> > > an explicit PCITEST_SET_IRQTYPE ioctl at the start of the test case, thus
> > > it is safe to always overwrite the configured IRQ type.
> > > 
> > 
> > I don't quite understand this sentence.
> 
> What I was trying to say is that it is okay if PCITEST_{READ,WRITE,COPY}
> ioctls always overwrite the configured IRQ type, because all test cases
> in tools/testing/selftests/pci_endpoint/pci_endpoint_test.c that require
> a specific IRQ type, e.g.:
> 
> - TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
>   will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_INTX);
>   before calling pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);
> 
> - TEST_F(pci_ep_basic, MSI_TEST)
>   will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
>   before calling pci_ep_ioctl(PCITEST_MSI, i);
> 
> - TEST_F(pci_ep_basic, MSIX_TEST)
>   will call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSIX);
>   before calling pci_ep_ioctl(PCITEST_MSIX, i);
> 
> Thus, all test cases will still work, even if PCITEST_{READ,WRITE,COPY}
> overwrites the configured IRQ type.
> 

Right, but those test cases are IRQ_TYPE specific. So setting the IRQ_TYPE
before executing the test is paramount.

> 
> > What if users wants to use a specific
> > IRQ type like MSI-X if the platform supports both MSI/MSI-X? That's why I wanted
> > to honor 'test->irq_type' if already set before READ,WRITE,COPY testcases.
> 
> As I said, I don't think you can have the cake and eat it too ;)
> 
> Let me explain:
> If you simply run pcitest, it will execute the test cases in the following
> order:
> 1) pci_ep_bar.BARx.BAR_TEST
> 2) pci_ep_basic.CONSECUTIVE_BAR_TEST
> 3) pci_ep_basic.LEGACY_IRQ_TEST
> 4) pci_ep_basic.MSI_TEST
> 5) pci_ep_basic.MSIX_TEST
> 6) pci_ep_data_transfer.memcpy.READ_TEST
> 7) pci_ep_data_transfer.memcpy.WRITE_TEST
> 8) pci_ep_data_transfer.memcpy.COPY_TEST
> 
> Thus, when you reach 6) (READ_TEST), irq_type will already be set, and
> READ_TEST will use whatever IRQ type that happened to be the last one that was
> executed successfully. That unpredictability doesn't sound like very good
> design to me.
> 

Not 'unpredictable'. As you correctly said, the test will end up using the 'IRQ
type that happened to be the last one that was executed successfully'. To me,
this is equivalent to having the IRQ_TYPE_AUTO set as the test will use the
IRQ_TYPE that is supported by the platform.

But having said that, I now tend to agree that there is value in keeping
IRQ_TYPE_AUTO also. More below.

> 
> To me, it sounds like what you want is actually what is already queued up on
> pci/next.
> 
> Because with that, READ_TEST / WRITE_TEST / COPY_TEST test cases will always
> call pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
> (If you want the behavior that the READ_TEST / WRITE_TEST / COPY_TEST case
> should automatically figure out which IRQ type to use.)
> 
> If you want to use a specific IRQ type for READ_TEST / WRITE_TEST / COPY_TEST,
> it should be trivial to write a new test case variant (or new test case), that
> does SET_IRQ(WHICH_EVER_IRQ_TYPE_YOU_WANT); (depending on the test case variant)
> followed by the ioctl() for the test itself.
> 

I think this new testcase could be simplified if we keep the IRQ_TYPE_AUTO.

> This determinism is not possible if you move the "automatic IRQ selection"
> logic to be within the PCITEST_{READ,WRITE,COPY} ioctls. (As this series does.)
> 
> 
> I'm travelling to a conference this weekend, and will be busy all next week.
> 
> I've sent two proposals, what is currently queued up on pci/next, and this
> series.
> 
> As you might guess, I think that IRQ_TYPE_AUTO is the most elegant solution
> with regard to the existing design.
> 

Now, I tend to agree.

> But, if you want to make changes before the merge window opens, feel free to:
> -Take over this series; or
> -Write your own series on top of what is on pci/next; or
> -Keep pci/next as it is.
> 
> 
> I'm really (honestly) happy with whatever solution, as long as we, once again,
> handle EPCs that only support INTx, or only support MSI-X.
> 

We will keep your old series as it is.

> (Because ever since your patch series that migrated pcitest to selftests,
> READ_TEST / WRITE_TEST / COPY_TEST test cases unconditionally use MSI, which
> is a regression for EPCs that only support INTx, or only support MSI-X,
> which is the whole reason why I wrote this series.)
> 

IMO, the regression could be simply fixed if you have removed the ASSERT_EQ from
READ/WRITE/COPY testcases.

But anyway, all good now. Thanks a lot for your patience in educating me :)
Really appreciated.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

