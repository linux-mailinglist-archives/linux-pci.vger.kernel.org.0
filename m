Return-Path: <linux-pci+bounces-18575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250D9F42BC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 06:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31F47A7BB0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 05:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A80184524;
	Tue, 17 Dec 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBmJULm1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1883CC7
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413203; cv=none; b=g6PCVjBVrOst8zQNZ6ipZxoYDO23ySTF7IWuPW9SAVEEZMH3B5LiwZcOKMi3EFK9r1vhAvQYNBwhIGnkULzu8r+KCYWTVCPweThWqNBK2Zfxb1AZ7cTVN2H9WnAyYweqDtMPFdwvnf+jmiWycL1mh5u0AklB/PB2E5bhEyk+/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413203; c=relaxed/simple;
	bh=UDl+fCY918vruRgK91wANvLDJqtjsROJTFfCQAaLERc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEJxj0p5qjLtsg9wldukTECyTIrCrh6vgrrWszHlynldwc9DHdjWq+O4CxZnmzENCPY9IauGfuCZpjrR1WPt0pQikx8BihEoTb4kEA2bgiaj92tdHL1rpidtDOzxYBcybtENi8RZy8WwBzIlP6KX8ud8Jbl6vru3U8/K/gxXi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBmJULm1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso42045315ad.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 21:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734413199; x=1735017999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=nBmJULm1tLzkG1uxbXbxutxajVbluRmU7iYIkFo/C5lg5BM+cvJR2no1IhNidiwMFy
         XKvXzQouEhclPuncns7+fuY+0s2PhXZ1R8Km7fBEAC3rUGi45XfdfOWk3V0dQGZEu/Uc
         9PPcBQxJqu45p6ipvFhW1TWXuXIKQOnnA6r6qTyMSuLFX1rgk5mlqlif7L/K+YcvcN7I
         Nn79gDl6PHAvNS/PCWC1HsulVEk3C7WKvMion3SEPBpGy187rimwF1itEhw5nSvklWNC
         X6XAhpML4AtEaQ4CTi1fTHyVZkvq1p8vN78kzDbnSqYvQJ761/DQ6LqzxXihOIsMde/k
         QYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734413199; x=1735017999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=bt/SZU4jMroZ9++ihSd9n0c5eYlqsBrPRxbtDsRJB95I2pTLOZcCgVMLNqeMQv7mkI
         OQb5FVcqMuPv+BLsMeDD5BWJ4apri1ipuNmRAozBO++4Cw9WrkVv93U1e5m+739/jzuN
         wc+VaVu4EXWBE+uffrpuH2wfyJmymGJCPn5ObLlRQRWo+YciRzsVKKpVsnQtvpgYxgES
         QyGugbr0+0ZERm5O37QSnm9NoQvDNtjQS4M9upyasL9aIiCi7NpFY9/XDzguLVceBCAu
         dUF08CcBFcZDUNBc6/nuJJa/2R+JjRw2tpko+m2HgZj5WWL+FXLyqVshGcWnTCN0z8yU
         o72A==
X-Forwarded-Encrypted: i=1; AJvYcCVD/zvIgXkcvfn8pHRB6ZRd8sFb6yH2r2FR0G+aDYnAgPCrwSsQGmI6eP0NUTG9qFYehw1hQ6RNsDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/s2C6F/xFuXNCYGmjRIZHvBlUrPPU2WBDgREDip5sa/noo97x
	0oWccLgy6quyJYFvDjKIrtmEqJ7DElOOOl1IoYdo9odvsR+4lwHCZn/hpjkRuA==
X-Gm-Gg: ASbGncvvNeawAqEZiibMfXT/4d3vMxi0ArVWVHyikPp5a3RFh9ui6/qf8/xnAP4mu3Q
	j2ou9ZTBsO69RayJ24bmAA+gir/P5ADG9VMmcm9d5hwWmyk+R42PoVFavtBT9YkOmFbl+T5Kts0
	FlHbChbkVGR0YF7kzrjmJFtv2JmIqDw6Qv4dDlSK0GjvywFR4Ko6QF8fCyMpG6QlYNYTHxMILZU
	Mk0ouGxVFQn5vjys9E3SEqGin2iW9JyljFkBTQKHDJqSdTQOQwiRfKv2O1Zakc0iyEr
X-Google-Smtp-Source: AGHT+IFsS3IZ2kuJoYYT9J6yaDIHOOQEb5x9/0WrwBJTXWku1ZLygnZo3QdYaoEU12xrzijDxxrz1Q==
X-Received: by 2002:a17:902:c952:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-21892a785b7mr178520425ad.51.1734413199463;
        Mon, 16 Dec 2024 21:26:39 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm9094176a91.52.2024.12.16.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:26:38 -0800 (PST)
From: manivannan.sadhasivam@linaro.org
X-Google-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, `@thinkpad
Date: Tue, 17 Dec 2024 10:56:32 +0530
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241217052632.lbncjto5xibdkc4c@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>

On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:

[...]

> > There is also a case where some devices like
> > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
> > powered down in order for the SoC to reach its low power state (CX power
> > collapse in Qcom terms). If not, the SoC would continue to draw more power
> > leading to battery draining quickly. This platform is supported in upstream and
> > we keep the PCIe interconnect voted during suspend as the NVMe driver is
> > expecting the device to retain its state during resume. Because of this
> > requirement, this platform is not reaching SoC level low power state with
> > upstream kernel.
> 
> OK, now all of this makes sense and that's why you really want NVMe
> devices to end up in some form of PCI D3 in suspend-to-idle.
> 
> Would D3hot be sufficient for this platform or does it need to be
> D3cold?  If the latter, what exactly is the method by which they are
> put into D3cold?
> 

D3Cold is what preferred. Earlier the controller driver used to transition the
device into D3Cold by sending PME_Turn_Off, turning off refclk, regulators
etc... Now we have a new framework called 'pwrctrl' that handles the
clock/regulators supplied to the device. So both controller and pwrctrl drivers
need to work in a tandem to put the device into D3Cold.

Once the PCIe client driver (NVMe in this case) powers down the device, then
controller/pwrctrl drivers will check the PCIe device state and transition the
device into D3Cold. This is a TODO btw.

But right now there is no generic D3Cold handling available for DT platforms. I
am hoping to fix that too once this NVMe issue is handled.

> > > > > > If the platform is using DT, then there is no entity setting
> > > > > > pm_set_suspend_via_firmware().
> > > > >
> > > > > That's true and so the assumption is that in this case the handling of
> > > > > all devices will always be the same regardless of which flavor of
> > > > > system suspend is chosen by user space.
> > > > >
> > > >
> > > > Right and that's why the above concern is raised.
> > >
> > > And it is still unclear to me what the problem with it is.
> > >
> > > What exactly can go wrong?
> > >
> > > > > > So NVMe will be kept in low power state all the
> > > > > > time (still draining the battery).
> > > > >
> > > > > So what would be the problem with powering it down unconditionally?
> > > > >
> > > >
> > > > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > > > will wear out the NVMe devices if used in Android tablets etc...
> > >
> > > I understand the wear-out concern.
> > >
> > > Is there anything else?
> > >
> >
> > No, that's the only concern.
> 
> OK
> 
> I think we're getting to the bottom of the issue.
> 
> First off, there really is no requirement to avoid putting PCI devices
> into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> platforms, PCIe devices are put into D3(hot or cold) during
> suspend-to-idle and I don't see why this should be any different on
> platforms from any other vendors.
> 
> The NVMe driver is an exception and it avoids D3(hot or cold) during
> suspend-to-idle because of problems with some hardware or platforms.
> It might in principle allow devices to go into D3(hot or cold) during
> suspend-to-idle, so long as it knows that this is going to work.
> 

Slight correction here.

NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
state on its own, not all the time. It has some checks [1] in the suspend path
and if the platform/device passes one of the checks, it will power down the
device.

DT platforms doesn't pass any of the checks, so the NVMe driver always manages
the power state on its own. Unfortunately, the resultant power saving is not
enough, so the vendors (Laptop/Automotive) using DT want NVMe to be powered down
all the time. This is the first problem we are trying to solve.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c#n3448

> However, there is an additional concern that putting an NVMe device
> into D3cold every time during system suspend on Android might cause it
> to wear out more quickly.
> 

Right, this is the second problem.

> Is there anything else?

We also need to consider the fact that the firmware in some platforms doesn't
support S2R. So we cannot take a decision based on S2I/S2R alone.

I think there are atleast a couple of ways to solve above mentioned problems:

1. Go extra mile, take account of all issues/limitations mentioned above and
come up with an API. This API will provide a sane default suspend behavior to
drivers (fixing first problem) and will also allow changing the behavior
dynamically (to fix the second problem where kernel cannot distinguish Android
vs other OS).

2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use of the
existing behavior in the NVMe driver. This would only solve the first problem
though. But would be a good start.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

