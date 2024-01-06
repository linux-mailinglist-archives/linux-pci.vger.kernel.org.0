Return-Path: <linux-pci+bounces-1735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B282600B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 16:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F083284896
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AD622;
	Sat,  6 Jan 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFUKhu+r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3708C11
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so442752b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704553962; x=1705158762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3wGS/O4cfjMdErZ0qWDUJWWI8SqaxDuDl7tX9Ojczk=;
        b=GFUKhu+rqTWQv3OeGIE9+R9ZmoUH6CqDUgSEYF/P6lgBXsbaaOix5d+YX8kPUFa2hv
         a9/7tPbWYLbw8kYiqr1ieL0jYi5pxpRqhjeZ30i3Uabr7CKmFUYq9++O+tP98YTaOhu6
         AuvlQb+Txhudn0yjcQBmXobEAcX+XVlclM182gcMbi+V2K+8EiYaRonAGPYHId13mUzy
         EI0EeHO+AnSBW487pXWfu+WezKZY+oaUxqt5hph9a7lBZ8o9gBv+TOyOqd0DliPFqQ7p
         ucyH9Epy07QfN3vw2DDaW/Qg0M829cTZTs/TN8PIbQOLwknA6FW4FXZS6R426KhvxLpC
         FSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704553962; x=1705158762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3wGS/O4cfjMdErZ0qWDUJWWI8SqaxDuDl7tX9Ojczk=;
        b=JkLRjRxYui4DhXv5Whaj6fmh9/M5qKMH6+lilDJdxeO5w+77HGx1kIVnG+X71H7dFP
         liOa/ZAkzojexVz3625e8jlkeFVljnI2KhsaaXGIOwdT5J3fjKgYUfjr6Q2/1SWRFZam
         eiUyuFQreIs3ZsYXACFDdRILdkm3BdPd9F4oQKZ6xvX3LLuaNBbNZZohEkvtOixDL0WL
         8yC5BzqX6NUdAgGgxjR32BZFxaIr4cR5DMn2lkcI4Rv1WWPcqeZcDe5Wi//XpBad5TTh
         ur5jAlr1iIi6/s0v2sE2yx9YIfsOdwUVVw9GdfiW2v6lNWPVEpAVtdA95893RNNesNnu
         d4vQ==
X-Gm-Message-State: AOJu0YyWySJHtLyuZ1WSVfUk7+IdpyffebxxgM+Nv9olUyloPQ23/HQy
	zfL0STzi5Hl3OFvqTyYlccwEwF8JSPvo
X-Google-Smtp-Source: AGHT+IEJiKxQw12K8x7ZzVfYYhTFbUMkrL956WDrabN1R7UkIj073AVE8DV46gNzwbAZntOgEK68/Q==
X-Received: by 2002:a05:6a21:a596:b0:199:3f2d:a3d0 with SMTP id gd22-20020a056a21a59600b001993f2da3d0mr1397091pzc.26.1704553962616;
        Sat, 06 Jan 2024 07:12:42 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id m2-20020a632602000000b005cd86cd9055sm3250503pgm.1.2024.01.06.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:12:41 -0800 (PST)
Date: Sat, 6 Jan 2024 20:42:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240106151238.GC2512@thinkpad>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
 <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad>
 <ZWhwdkpSNzIdi23t@x1-carbon>
 <20231130135757.GS3043@thinkpad>
 <ZYY9QHRE4Zz30LG8@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYY9QHRE4Zz30LG8@x1-carbon>

On Sat, Dec 23, 2023 at 01:52:01AM +0000, Niklas Cassel wrote:
> On Thu, Nov 30, 2023 at 07:27:57PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 30, 2023 at 11:22:30AM +0000, Niklas Cassel wrote:
> > > On Thu, Nov 30, 2023 at 12:08:00PM +0530, Manivannan Sadhasivam wrote:
> > > > 
> > > > Looking at this issue again, I think your statement may not be correct. In the
> > > > stop_link() callback, non-core_init_notifier platforms are just disabling the
> > > > LTSSM and enabling it again in start_link(). So all the rest of the
> > > > configurations (DBI etc...) should not be affected during EPF bind/unbind.
> > > 
> > > Sorry for confusing you.
> > > 
> > > When toggling PERST on a driver with a core_init_notifier, you will call
> > > dw_pcie_ep_init_complete() - which will initialize DBI settings, and then
> > > stop/start the link by deasserting/asserting LTSSM.
> > > (perst_assert()/perst_deassert() is functionally the equivalent to start_link()/
> > > stop_link() on non-core_init_notifier platforms.)
> > > 
> > > 
> > > For drivers without a core_init_notifier, they currently don't listen to PERST
> > > input GPIO.
> > > Stopping and starting the link will not call dw_pcie_ep_init_complete(),
> > > so it will not (re-)initialize DBI settings.
> > > 
> > > 
> > > My problem is that a bunch of hardware registers gets reset when receiving
> > > a link-down reset or hot reset. It would be nice to write all DBI settings
> > > when starting the link. That way the link going down for a millisecond, and
> > > gettting immediately reestablished, will not be so bad. A stop + start link
> > > will rewrite the settings. (Just like toggling PERST rewrites the settings.)
> > > 
> > 
> > I got slightly confused by this part. So you are saying that when a user stops
> > the controller through configfs, EP receives the LINK_DOWN event and that causes
> > the EP specific registers (like DBI) to be reset?
> 
> Sorry for taking time to reply.
> (I wanted to make sure that I was 100% understanding what was going on.)
> 
> So to give you a clear example:
> If you:
> 1) start the EP, start the pci-epf-test
> 2) start the RC
> 3) run pci-epf-test
> 4) reboot the RC
> 
> this will trigger a link-down reset IRQ on the EP side (link_req_rst_not).
> 

Right. This is the sane RC reboot scenario. Although, there is no guarantee
that the EP will get LINK_DOWN event before perst_assert (I've seen this with
some RC platforms).

But can you confirm whether your EP is receiving PERST assert/deassert when RC
reboots?

- Mani

> 
> > 
> > I thought the LINK_DOWN event can only change LTSSM and some status registers.
> 
> link_req_rst_not will assert link_down_rst_n, which will assert
> non_sticky_rst_n. So all non-sticky registers will be reset.
> 
> Some thing that has been biting me is that:
> While advertized Resizable BAR sizes are sticky,
> the currently used resizable BAR size is non-sticky.
> 
> So a reboot of the RC will reset the BAR sizes to reset values
> (which on the SoC I'm using is 1 GB...)
> 
> So, there is an advantage of having a .core_init_notifier,
> as this will allow you to reboot the RC without any problems.
> 
> I guess one solution, for DWC glue drivers that don't strictly
> need a refclock is to just call dw_pcie_ep_init_complete() when
> receiving the link-down IRQ (since when you get that, the core
> has already reset non-sticky registers to reset values), and
> then when you get a link-up again, you have already re-inited
> the registers that got reset.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

