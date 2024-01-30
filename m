Return-Path: <linux-pci+bounces-2779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C236841E8E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCC01F21050
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D057883;
	Tue, 30 Jan 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcIkLs5p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33059148
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605238; cv=none; b=SN3Gpeh61ZUrJOIxHsQKlZ4KeLXZsmpl2QdVFk+mbXq/m2K41LQCNyn7bz7wcgl/VKreDUSwW4ssOWdf6ItxnHu8Bvf1R1Pw0i58OoeqV5lU4zwdVqgGfoyQjB1RmJTHHzBGOBbaV6E4hdGejk5aeYgb3VZDZpLTve46y+3Th8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605238; c=relaxed/simple;
	bh=uH11yzy7CA3zujlRNp6Ufsc8DN2/z8IMEkRMNKGYI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoXZQv4iGcEVm4qmAmdAPvx4titjAQKYB99fe30s0vWt8l8Yjh7M0i0XhWiBjBLGdTs00wTlhYe23P6/T62HA2xsfwekRfjWpqv3XzLmFBfhUBwJAZn6lTnF9b4k1ArNP5HPnbYcRoh/Y/wt9Z/tbOU/H6u8sDuWh3QfBfdmxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RcIkLs5p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so1761112b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 01:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706605236; x=1707210036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBrRJ7k5wtXW0qmgbLXWZQDyZ/cZ9eUE2tQ4DRJTrJs=;
        b=RcIkLs5pYIpwJgVbVllfOSzrRxI3jcER7hxaM8C6PqG+fJFPw5yAuV5dwLzy8bG59T
         QVgm8Op2syGuslZ5H1HpzWwJljpysNNjAAUnEVZku4avnrbPPBm0DCWcH+UHQCy5Y6St
         R1qp0YPc5PXzH1ETolVxOJ+AVHDJA0AzTsz50mgeGVMQlHyBYUcu9fSJFdfru9ay9Zia
         SoNe9JkVmeZQR+G+9S/mqiSRCc2q+RejURNU/Rd13KXsufWVZH0/wARoahMPg9rKpbPp
         DtLuL3BUHnly42J+iqyGMZpKr1XLLQfwusx7gFqOU9/w7EtV3JXYzGpdE2xwMehmPcWm
         JcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605236; x=1707210036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBrRJ7k5wtXW0qmgbLXWZQDyZ/cZ9eUE2tQ4DRJTrJs=;
        b=ers/2deSq1L8Ce4xXP6Qwyt4jwN1d/diVCn+pDNAOzdEF4g86eWn3Gk0cDsA9WYPwp
         HX0/ixmwgKU5hd003EvaDYNqRNCIg34HmINqMcAipIW6GmVjqQqop0JkWJr0ok4uoP7T
         mOWETnnUqoEjNZbvi/Zld4LIN4coejK8Jfw+cHOm7ssWiIK6UB5PLDZyP49WVsOh8SPZ
         aqpf/+J7fsBwf/TTPfWbPFFWaed1JZwHbKWk1E9C3wk0I3cQtxenxWbaoMHFkbyGppXi
         GR1JfY09fitbK2YgQgQMNGZWMw8TPjt+ICzhAd9idTOfke6Swe+YFT33f+a0ZLGU4vI7
         0w+Q==
X-Gm-Message-State: AOJu0YxkkWctZuhH5WLe50/A1IMhYgEdiQ7skeB5PZDYmtLRKw42nTqd
	Xb3/MX4k9b3MCSn7Ha86KW3TydBmKiRtJqZbC+cN93EAKiwNSXw/gYUNvpKFKw==
X-Google-Smtp-Source: AGHT+IEGzqAy4J84RCHUoiQAKPHOZhEvVZZDYk69el0pjdL8rL04fGs7IWCZPd192jdeuWRwhiwwVQ==
X-Received: by 2002:a17:903:24e:b0:1d4:47d4:82b4 with SMTP id j14-20020a170903024e00b001d447d482b4mr5963806plh.15.1706605235884;
        Tue, 30 Jan 2024 01:00:35 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090311c200b001d919be90fdsm24484plh.42.2024.01.30.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:00:35 -0800 (PST)
Date: Tue, 30 Jan 2024 14:30:27 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Zbi6q1aigV35yy9b@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130064555.GC32821@thinkpad>

On Tue, Jan 30, 2024 at 12:15:55PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 29, 2024 at 06:56:24PM +0530, Ajay Agarwal wrote:
> > On Mon, Jan 29, 2024 at 01:42:54PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jan 29, 2024 at 01:34:52PM +0530, Ajay Agarwal wrote:
> > > > On Mon, Jan 29, 2024 at 12:40:25PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> > > > > > On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > > > > > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > > > > > gets called during probe, this one second loop for each pcie
> > > > > > > > > > interface instance ends up extending the boot time.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > > > > > > specific platform where you are observing the issue.
> > > > > > > > >
> > > > > > > > This is for the Pixel phone platform. The platform driver for the same
> > > > > > > > is not upstreamed yet. It is in the process.
> > > > > > > > 
> > > > > > > 
> > > > > > > Then you should submit this patch at the time of the driver submission. Right
> > > > > > > now, you are trying to fix a problem which is not present in upstream. One can
> > > > > > > argue that it is a problem for designware-plat driver, but honestly I do not
> > > > > > > know how it works.
> > > > > > > 
> > > > > > > - Mani
> > > > > > >
> > > > > > Yes Mani, this can be a problem for the designware-plat driver. To me,
> > > > > > the problem of a second being wasted in the probe path seems pretty
> > > > > > obvious. We will wait for the link to be up even though we are not
> > > > > > starting the link training. Can this patch be accepted considering the
> > > > > > problem in the dw-plat driver then?
> > > > > > 
> > > > > 
> > > > > If that's the case with your driver, when are you starting the link training?
> > > > > 
> > > > The link training starts later based on a userspace/debugfs trigger.
> > > > 
> > > 
> > > Why does it happen as such? What's the problem in starting the link during
> > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > get reused in other platform (non-android), the it won't be a seamless user
> > > experience.
> > > 
> > > If there are any other usecases, please state them.
> > > 
> > > - Mani
> > >
> > This SoC is targeted for an android phone usecase and the endpoints
> > being enumerated need to go through an appropriate and device specific
> > power sequence which gets triggered only when the userspace is up. The
> > PCIe probe cannot assume that the EPs have been powered up already and
> > hence the link-up is not attempted.
> 
> Still, I do not see the necessity to not call start_link() during probe. If you
I am not adding any logic/condition around calling the start_link()
itself. I am only avoiding the wait for the link to be up if the
controller driver has not defined start_link().

> add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> negligible. The reason why I'm against not calling start_link() is due to below
> reasons:
> 
> 1. If the same SoC gets reused for other platforms, even other android phones
> that powers up the endpoints during boot, then it creates a dependency with
> userspace to always start the link even though the devices were available.
> That's why we should never fix the behavior of the controller drivers based on a
> single platform.
I wonder how the behavior is changing with this patch. Do you have an
example of a platform which does not have start_link() defined but would
like to still wait for a second for the link to come up?

For example, consider the intel-gw driver. The 1 sec wait time in its
probe path is also a waste because it explicitly starts link training
later in time.

> 
> 2. This will create fragmentation among the DWC glue drivers w.r.t the behavior
> and will become a maintenance nightmare (there are enough already).
> 
> So, I'd suggest you to use the asynchronous probe mentioned above so that other
> drivers may probe in parallel thus avoiding the delay that you are worried about.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

