Return-Path: <linux-pci+bounces-20158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB42A16F39
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6CC3A65BE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084F1E5729;
	Mon, 20 Jan 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/SFFPdp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9881E571F
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386920; cv=none; b=dX4HDN5SygX18wPtWO9eU1k++IKAaDIDDTakJP9wIwIX04Hg4lgjnjsI0pMCe/K5Zu4e568ZAD6c7EAxdmE3dPRoVHUMnOGU4AN2PgKSXjN/+6IBbQaGv86gwfvg22VGSYWdj3vTgc+MwQwPtVuk/36yp9b8krI5L0sPglgyxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386920; c=relaxed/simple;
	bh=VAWkKFMuuvGFwc4lV9U8KFWWhfAs+x3tBpzqXY33AtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2BcQFc4kLe2pBSiLAVzJxQQemrwo3jSQuS79SOUGFIGuH1dB4wjBcxCQbiR0lVQDWXkrp5p6ya+xDjGorEYodcnuqfdqrt5SO1XBvycKbmuOK5kHLQdmm0Slc3mGxLT6I+U5xbOgxh1o1Qi1cH66x2iTa0nVKtXbmURJE6GJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/SFFPdp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21bc1512a63so86736965ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737386918; x=1737991718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ge/AXIemwm1awQOTNlXpVZkK91To9JlcVieMAvqiKWA=;
        b=e/SFFPdpfCxKnQ9Uhigb5Oa7CjJ6r5xJjQaUJpKjJXzBhBRKQRwV2kHerHuoJGmXBq
         9fcWEIDZwaiM3KYLGKP5pqn2MygkXutilbNUQ6MEbpSlp5LolD4kNH4fwqcS1xLgWPIX
         8BR6Bn5/MWoqlb633frJ8QJLrdM40Cehh6qvgQHZLS+Gt3/G14rDQjDerVpcwoIFNByp
         2bplpGiz/L2BOKUgEWS2jPeKq9dp3MyHT4BAz02cq/oLLy6IVjJIBi8Q4zvsdY8Ohffx
         OfPyV4OIjUG/jZ1alp8WDm2fpxy3AwALDtF9uConNkF7ZZfxFym8JKuj8vul98gDtsrr
         8d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737386918; x=1737991718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/AXIemwm1awQOTNlXpVZkK91To9JlcVieMAvqiKWA=;
        b=VogzM49yYi0iafRFH/vvCjHu5yiJ0VRT9tVU7h9m5shV6GouVk1q6rQWkunVxJb/eL
         Zfq9/vsP6rzx7/SD3Yjv/JNzMN6EdC/ztpyixCGRc58Jveg44siO/GWLMjVawxMfPtsI
         uKQLkzGQYEhRiCcYYT6WuLis8mxqbYdX0AboDm4q6cNZLcekLE2B/D5Ojjos9NmuTSBJ
         hYM6S3dczIMvgPsWDCDFzmxKQrmbHIelu0cYHC1+kNSzGsJ2Uoc2ZHNB6Gh6vppHFiEc
         t0L4p5yBvw3nCLAi6F9LHkrBCSZs+HTgIYsuM28ztXPByGukoIq75b6YvRmBK+nRp0EE
         f60g==
X-Forwarded-Encrypted: i=1; AJvYcCWyZDh/5UVYkHY7iDpgZeVBu6szopt3sYOSR2c/G/jEymAI64toNZvWXqg4nlJ16hpZygZ0qri8Mtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaPh2b3L/RaRwm8dtUC1oD1zQDHgcwoWK4BNUgkMoxZQX0r4k
	PR9pWPp39iKSOBz7GSNJq50r422ZaSV6nxC0o5LPabLy+GwXtWdfh3l9VHNZi8xv8sNVIMzT1GY
	=
X-Gm-Gg: ASbGnctD8Fo6KDSjK3YtjmTkyufiVVg0itDTISwvt4Onqk9d3SnK/nE6w/AVAJqcdav
	fNHKDl4yC4ubpL+FjVKY+nlDDjissE3HOwV53SavjlXBYT7f3pr62osaHyZsntM18q+1aia3qZb
	DCXA7IKHGtsud7m44jxkH98VukO4LH6YTLcdLvp7qG7W5F6Jw4LM//mMq1jhJTGSe++jz4o/CDw
	E44h2tPTj5wnvXXbK1ATEQ2A784o/si8xH0jSRTScYfHGcDcLhRFlc7zw44s1Z6Ynf6X2/1sP7J
	s3J+q7g=
X-Google-Smtp-Source: AGHT+IFEYzzBuALfLBnZY/0Oioq2g+BcnanbnfQw4KIaV+WjpwymnqzEgNX6z1yArWAvcbtux5os8A==
X-Received: by 2002:a17:902:e546:b0:216:281f:820d with SMTP id d9443c01a7336-21c3553b6famr223740225ad.11.1737386917771;
        Mon, 20 Jan 2025 07:28:37 -0800 (PST)
Received: from thinkpad ([117.213.102.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea2caasm61864755ad.51.2025.01.20.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:28:37 -0800 (PST)
Date: Mon, 20 Jan 2025 20:58:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	rafael@kernel.org, ulf.hansson@linaro.org,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250120152829.7wrnwdji2bnfqrhw@thinkpad>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
 <Z44llTKsKfbEcnnI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z44llTKsKfbEcnnI@hovoldconsulting.com>

On Mon, Jan 20, 2025 at 11:29:41AM +0100, Johan Hovold wrote:
> On Sun, Jan 19, 2025 at 08:59:40PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 14, 2025 at 03:16:53PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Jan 13, 2025 at 09:55:49PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> 
> > > > > > > I just noticed that this change in 6.13-rc1 is causing the
> > > > > > > following warning on resume from suspend on machines like the
> > > > > > > Lenovo ThinkPad X13s:
> 
> > > > > > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> 
> > > > > > > which may have unpopulated ports (this laptop SKU does not
> > > > > > > have a modem).
> 
> > > What's the plan for this?  Does anybody have a proposal?
> > > 
> > 
> > TBH, I don't know how to fix this issue in a proper way. I need inputs from
> > Rafael/Ulf.
> > 
> > > IIUC there is no functional issue, but the new warning must be fixed,
> > > and it would sure be nice to do it before v6.13.  If there *is* a
> > > functional problem, we need to consider a revert ASAP.
> > > 
> > 
> > There is no functional problem that I'm aware of, so revert is not warranted.
> 
> I'd argue for reverting the offending commit as that is the only way to
> make sure that the new warning is ever addressed.
> 

How come reverting becomes the *only* way to address the issue? There seems to
be nothing wrong with the commit in question and the same pattern in being used
in other drivers as well. The issue looks to be in the PM core.

Moreover, the warning is not causing any functional issue as far as I know. So
just reverting the commit that took so much effort to get merged for the sake of
hiding a warning doesn't feel right to me.

> Vendors unfortunately do not a have a good track record of following up
> and fixing issues like this.
> 

I'm not relying on vendors here. I am looking into this issue and would like to
fix the warning/issue on my own. That's why I shared my observation with
Ulf/Rafael.

> Judging from a quick look at the code (and the commit message of the
> patch in question), no host controller driver depends on the commit in
> question as the ones that do enable runtime PM just resume
> unconditionally at probe() currently (i.e. effectively ignores the state
> of their children).
> 

Right. There are a couple of pieces that needs to be fixed to have the runtime
PM working from top to bottom in the PCIe hierarchy. This is also one more
reason why I believe that the commit wouldn't have caused any functional issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

