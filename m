Return-Path: <linux-pci+bounces-14757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F99A1E6C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B16A1F2124A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04E1D8DE4;
	Thu, 17 Oct 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vutH6VnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEB1D4150
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157452; cv=none; b=DEI2eHA5l/0O5J8fRoqgUELiYp7dXlo732Uoz1YzSvrYiDhGSnUHkpq4WbJRwecp5GoIB2FJ3jMv+KV6dhffsonZV1L9LeN2tlPe84lBUnCVhjwTFhDzByeDGeQaGu6q8jEJuX+F4LtMmqGf89peeBOnin/qBz9WQEG9xbFd5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157452; c=relaxed/simple;
	bh=69DxRSFMtnhAHbJGK01FQjK4oD5LqNYEz7GlR3HUQRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiD2X1lu/ZPcwqPgiixgzTrKQJNbuaaQy6+tMMhNuSfwZnLb9mHDvyafw91ltDoCb6MZnbsyO94MHTq3whq2pYZCJGkgEzUxcJDMzqDDfgfCnAnS4bTRYRnMaZ+DxaYkZpMViBtmqDNpVwFQId9NWF27uyRz7mfJcapBxL90mPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vutH6VnP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e983487a1so167294b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729157449; x=1729762249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y53oSEtZ5CP67qr80ZJJlP6iB9wlZ84RYUcNqwkIoiQ=;
        b=vutH6VnP7z4Sgv8UvcCIuzpRNuCqpwe8pQkNKNO3+x5UHiuXBV84TWlQUUshpbhB++
         umkMhPTePcYSlNXFEL727u1mfEDMULQOwtaTr4u3Ylrlr3buQSNgS+61eSmQeLtW7YXA
         GywSIkStIax23XvUqxAUb6N/S4EI6qhHNctEprJX1ZU2hEDbqMCqTf7skmA4NM+ydn4H
         uMAtN9BxptOEJDOTWPCjXXDmucZBBAx4L7H5fkcj3iflRyZ49nXR4JRl+zJGzi3h4tnI
         7tJ6ZfqAE0WNmU9dn4C3qV9dWqd1MEwSwDUx/2RaXucAfqWl1AhN5p2bFa5bEZPGkY6Z
         EdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157449; x=1729762249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y53oSEtZ5CP67qr80ZJJlP6iB9wlZ84RYUcNqwkIoiQ=;
        b=VpBNUulIS6r3AGRnlOjRLlVY+s5d73mOH3jgS3O54HnjW66cKhZPCa4ATAu9quksa2
         Q9mTMsUalKlIGTSi6SvL+rNiW0DgODkZ/rsd37k4TqUHr742sLw5lIvY800LkJiI1Xeg
         lQpqxkTIcyOdlhdfB7LJ58OgdzArz8F9gk512wBuDdUCUvxFCr0o37RmMPKgOaRA2DOl
         cToZ000T6g6A3W/uveIcwOuIuq0+A1sYwu+furWhYfjNBlsAuCtoh5gew9IxeeMB3jPH
         YBsPq6aYDiUtkcSec0Kv0S3Q7Lf4ZlO0DC/5dfb+OQiZbXXfrq/sX38TiYfAy1zObtt5
         gcEw==
X-Forwarded-Encrypted: i=1; AJvYcCUl9SOwiVt/85x2BuUq7ZY0lOplINtalnBeZ/ivneIrQzSj97K2JhMWqCUjvOjldw9ZulXsVNp6Qzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWSBZI+Sy1EoPisgHL6LB7KKK0DgNBkDymFzs5foX79Wj/jsL
	ydnYkjbyRGCP+4UjBBRlfyhVcL67OT7cwpwfptl5BT6wqPN5DmeMlmfGaz9SLQ==
X-Google-Smtp-Source: AGHT+IHjYEW5R6ceiYfrud9FBTU6I/onVh/gP0jxBFsfsPn+lh7D+vWNN/B+bO+Cf4ax5LO+h/ijqg==
X-Received: by 2002:a05:6a00:2282:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-71e8023c9e2mr8069580b3a.8.1729157448827;
        Thu, 17 Oct 2024 02:30:48 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7729dde5sm4349554b3a.0.2024.10.17.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:30:48 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:00:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ley Foon Tan <ley.foon.tan@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20241017093040.k6pefhmfdmw4nicz@thinkpad>
References: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
 <20220727195716.GA220011@bhelgaas>
 <YuJ+PZIhg8mDrdlX@hovoldconsulting.com>
 <20241017052335.iue4jhvk5q4efigv@thinkpad>
 <86v7xr418s.wl-maz@kernel.org>
 <20241017082526.ppoz7ynxas5nlht5@thinkpad>
 <86r08f3yj1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86r08f3yj1.wl-maz@kernel.org>

On Thu, Oct 17, 2024 at 09:48:50AM +0100, Marc Zyngier wrote:
> On Thu, 17 Oct 2024 09:25:26 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Thu, Oct 17, 2024 at 08:50:11AM +0100, Marc Zyngier wrote:
> > > On Thu, 17 Oct 2024 06:23:35 +0100,
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > > 
> > > > So can we proceed with the series making Qcom driver modular?
> > > 
> > > Who is volunteering to fix the drivers that will invariably explode
> > > once we allow this?
> > > 
> > 
> > Why should anyone volunteer first up? If the issue gets reported for a driver
> > blowing up, then the driver has to be fixed by the maintainer or someone, just
> > like any other bug.
> 
> You are introducing a new behaviour, and decide that it is fair game
> to delegate the problems *you* introduced to someone else?
>

You are getting it completely wrong. I'm not delegating any issues. If the so
called *new* behavior in the controller driver uncovers the bug in a client
driver, then that is not called *delegating*.

> Maybe you should reconsider what it means to be a *responsible*
> maintainer.
> 

Sure, by not providing a development option useful to the users envisioning
issues that may not happen at all.

Even if any issue reported for the platform I'm maintaining, I am willing to put
in the efforts to fix them.

> > From reading the thread, the major concern was disposing the IRQs before
> > removing the domain and that is now taken care of. If you are worrying about a
> > specific issue, please say so.
> 
> That concern still exists, and I haven't seen a *consistent* approach
> encompassing all of the PCI controllers. What I've seen is a bunch of
> point hacks addressing a local issue on a particular implementation.
> 

Again, please be specific about your concern so that someone could try to
address them. Right now all I'm hearing is, "hey don't do this, else
something may blow up".

> I don't think that's the correct approach, but hey, what do I
> understand about interrupts and kernel maintenance?
> 

I'd like to quote the message in your signature here: "Without deviation from
the norm, progress is not possible".

> > 
> > As a Qcom PCIe driver maintainer, I'd like to provide users/developers the
> > flexibility to remove the driver for development purposes.
> 
> Sure, whatever.
>

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

