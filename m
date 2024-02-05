Return-Path: <linux-pci+bounces-3083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7D849847
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60A21F22590
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18018175B9;
	Mon,  5 Feb 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0iOFnji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9B1862F
	for <linux-pci@vger.kernel.org>; Mon,  5 Feb 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130834; cv=none; b=r23jI3Br3V+6w95QWnLCJYeZxAhP0ir+lWgMxApE4KCF9KtrOsZDqZPQnxSXi+wvsJcYv9ON2Upvei7tZLyf4ziAiz75Mj39GiA1ivQYQCcAb2jG5tYh2TXZcEUSH8Jd4WPAnLE2gNYlFulAzjbz+lCH/+ExZ2mDNqyO4RNurcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130834; c=relaxed/simple;
	bh=cpLwfsjvJi+7X9Wg3KdnXpxpI85QZkl+MLklWOexmkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+tkJTizhLGEi5QSbsi/MSXOEfSXbfrOWUytWaZX++ElAURJk6qHh4VOYintErYyZXKsYI4HXHZni5JDAFx4XwtzMA+YrYfMZ9qw/yHMnrKeZlW0QNnBiDdylKQE9r5E6RCo5TUarC6bTTWUC5m/RqneIrv80m0uObrdJfrgp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0iOFnji; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d93edfa76dso35976155ad.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2024 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707130831; x=1707735631; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AD1WSOT7nFzCnTxz+ZovIdcp/GdyiI8ZJ1u+IvgfxM0=;
        b=i0iOFnjipvP2y87IlB8sI69wSaTqA+ld6HU8GDUpYnqpeR3zgVA7LcctGE+w97tVdl
         LaNJaepLYO+Dyb/LIf+4nEe3h6JsW2YlMVPiPXNi2LoFaP2KWfqGAs3AE7jfxO7oWwmU
         281qPPPh/XUQa8T8viT6IgEkvt08ttDgzVnijUsjeQz3zwF3dW7zQ2tIp6XUNn/N7uRw
         wnoKtld1ll8PTO3Nx9T3N8/A379ZlblNJsivRnyt5QAO59Lbhqwnz/ahz4aU0177oNWZ
         MnujwdFHh0aKj02eHkdFL0/pLYia0Qsb6nq3Naa0TD01XXF16bO1Wb/nX/6ntvqimy2F
         vo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707130831; x=1707735631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1WSOT7nFzCnTxz+ZovIdcp/GdyiI8ZJ1u+IvgfxM0=;
        b=Wkrdsp40FiPc/ynWSmQagb+qyAJaTdWIDe32CtB/czQF7ceRwM83WRjNCX4eiuzMKi
         K3bUQVzyF74pybtKAb0m30bs8W7uprUmk0ZMmcs1/rDlmfPr5wYVEFZXbSk+TcWGhiOU
         gTPhapxYUiJJ0J721S4DTmeGG2edTdI/tM5EnSJ8cNlMs+FCLVRyQb1kXjZHR7W37TPl
         IwiUl8Ozu7WkqddBK8Q3NbytANaV+Z8yyF4XW3SXUQQSUxN64GCV7Iy1KeSoCqgssByz
         cDTg279zQAX+/g6Z8idVluqZa1gHujGcd8rxf4Wc0UfbJfvMWYfDKAOeN6uExjky4Q59
         iT5g==
X-Gm-Message-State: AOJu0YzdzdiZ/gxGMK80adBCbJU6DwM8WETGr9yMoL/p0V5/x4A26Zav
	u6s7IdLN8y7AMBuTCTP8rRuJVKsS1GBT6gJ2H8VBgBdXU63nbQU244mkJSwggQ==
X-Google-Smtp-Source: AGHT+IF3W7K6Z6dZN3pTHKbNRpBMCcWkcDGgbiu0Zxx0l1G/piZ4CfuaGjbPYFDXL/a97idieb8S/w==
X-Received: by 2002:a17:903:4289:b0:1d8:d6f2:5ee0 with SMTP id ju9-20020a170903428900b001d8d6f25ee0mr14455654plb.8.1707130829548;
        Mon, 05 Feb 2024 03:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUKVQPA9vIGTjeEPfrvkiA/Xuzc9s35lUBPIWaumq5jsudjrHCrCRwCZ9OeWksU7tOlDhuajUj+Suj7ecwALsm5ZRisMoC+JrgqBG6t4BjKJQ5eLhXOxh9rYCwMXcxrPgQ8Gy2dISrBaEWV5YNX0YklUw7Z6WkPmo7AjqV321n7jWp4RLNrWgdbwi3QR5sxcvoBqIGmiH/iM6tzIDw3z/u3TpKUdZ8woFcTw0Tdkmd5mAzfs+WrMe4K8l1gGCeL+eIacegAzsdC2zDGAfmOltEvPD6kxICa6EBMxDzZJ/HXeVMxuseZcXuhqhaXJyuozZd9LGZ4aSTdiLG9hQ99qlgddb1sxswImiONt6YNdOSIWNG/LeuZfGWuyBYYuRuMGdsmNKePmhzgzBcrDgcAYRfkgdg
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090328cf00b001d706912d1esm6041302plb.225.2024.02.05.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:00:28 -0800 (PST)
Date: Mon, 5 Feb 2024 16:30:20 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZcC_xMhKdpK2G_AS@google.com>
References: <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130183626.GE4218@thinkpad>

On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > 
> > > [...]
> > > 
> > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > 
> > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > 
> > > > > > > 
> > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > experience.
> > > > > > > 
> > > > > > > If there are any other usecases, please state them.
> > > > > > > 
> > > > > > > - Mani
> > > > > > >
> > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > hence the link-up is not attempted.
> > > > > 
> > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > I am not adding any logic/condition around calling the start_link()
> > > > itself. I am only avoiding the wait for the link to be up if the
> > > > controller driver has not defined start_link().
> > > > 
> > > 
> > > I'm saying that not defining the start_link() callback itself is wrong.
> > > 
> > Whether the start_link() should be defined or not, is a different
> > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > dw-plat) which do not have start_link() defined. Waiting for the link to
> > come up for the platforms using those drivers is not a good idea. And
> > that is what we are trying to avoid.
> > 
> 
> NO. The sole intention of this patch is to fix the delay observed with _your_
> out-of-tree controller driver as you explicitly said before. Impact for the
> existing 2 drivers are just a side effect.
>
Hi Mani,
What is the expectation from the pcie-designware-host driver? If the
.start_link() has to be defined by the vendor driver, then shouldn't the
probe be failed if the vendor has not defined it? Thereby failing the
probe for intel-gw and pcie-dw-plat drivers?

Additionally, if the link fails to come up even after 1 sec of wait
time, shouldn't the probe be failed in that case too?

My understanding of these drivers is that the .start_link() is an
OPTIONAL callback and that the dw_pcie_host_init should help setup the
SW structures regardless of whether the .start_link() has been defined
or not, and whether the link is up or not. The vendor should be allowed
to train the link at a later point of time as well.

Please let me know your thoughts.
> > > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > > reasons:
> > > > > 
> > > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > > userspace to always start the link even though the devices were available.
> > > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > > single platform.
> > > > I wonder how the behavior is changing with this patch. Do you have an
> > > > example of a platform which does not have start_link() defined but would
> > > > like to still wait for a second for the link to come up?
> > > > 
> > > 
> > > Did you went through my reply completely? I mentioned that the 1s delay would be
> > > gone if you add the async flag to your driver and you are ignoring that.
> > > 
The async probe might not help in all the cases. Consider a situation
where the PCIe is probed after the boot is already completed. The user
will face the delay then. Do you agree?

> > Yes, I did go through your suggestion of async probe and that might
> > solve my problem of the 1 sec delay. But I would like to fix the problem
> > at the core.
> > 
> 
> There is no problem at the core. The problem is with some controller drivers.
> Please do not try to fix a problem which is not there. There are no _special_
> reasons for those 2 drivers to not define start_link() callback. I'm trying to
> point you in the right path, but you are always chosing the other one.
> 
> > > But again, I'm saying that not defining start_link() itself is wrong and I've
> > > already mentioned the reasons.
> > > 
> > > > For example, consider the intel-gw driver. The 1 sec wait time in its
> > > > probe path is also a waste because it explicitly starts link training
> > > > later in time.
> > > > 
> > > 
> > > I previously mentioned that the intel-gw needs fixing since there is no point in
> > > starting the link and waiting for it to come up in its probe() if the DWC core
> > > is already doing that.
> > > 
> > > - Mani
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> > I think we are at a dead-end in terms of agreeing to a policy. I would
> > like the maintainers to pitch in here with their views.
> 
> I'm the maintainer of the DWC drivers that you are proposing the patch for. If
> you happen to spin future revision of this series, please carry:
> 
> Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

