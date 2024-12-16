Return-Path: <linux-pci+bounces-18530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE09F370F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B994188E66C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281381ACA;
	Mon, 16 Dec 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQxsM093"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35A1B412A
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369076; cv=none; b=jCv8fpZDMsfQN6M3KyaK8xsYRBBBMAgS9jpUxTpEO0N/InGNxJJSRXvIbrFIn3PkZEfIETx9rP+Y8DhYn93iKiZ2UIjshpTMrfTvC8G+RJBI1oXfvNdVjJA0Ntm7e6lzHoFXTjSmx/snZsFanw6Pe/DeYQr4DEDDIWm8TQg0qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369076; c=relaxed/simple;
	bh=u4yaTsv3e1tUVlJXkBgUd6T1wCq2SLfuwXSDZ5txg0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j90FuXumnJxn374lmPi05bMhqMXUxPNKUVI9+nNUV/N9lt0/bZXZ8XlxIZwFbIzaX9PSFx0DOiorHWK0oKWD+JPnei3Ro9SefkT04gy2rI8k/1euYZY1yQv3lwTxdtcEPW2u4UHoHNZyTYxgRpfYbz8fU1IyWxxREv3P5LQE4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mQxsM093; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso33870585ad.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734369074; x=1734973874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KESVQtKZqZa3Yfy4tilcv/lLnaFc43UVwOF5TEnaANw=;
        b=mQxsM0939hwxEXtVSijAMhoF7JxDPg1ZZGTkszwZiOp3y5oSsHL0eMsAVgod61sHhT
         olyq5CMAuhHB0v8X+6Rtk8va5cEbknrS5Soj4gNnsC6sRcCtuIkh6dTPKrnV3iUAiudz
         8y6FNq7iodquAtdYz+SBiYPsEg2i4X6arjulCIfbi59ni5HSXWGkhn4/a7obTfeh6oJD
         USl1oJZpjb4HehjIx7k4tD5jQTtRE/7IKshqvzGJyk/MVu+Iaq3ePINVnPmJeE0FE/qg
         BZYvDVhfgUW7dxfoCLNqVu+hkk5hcSwS/mcedsMvNLpztgMNvgopqax8IpMF9JupwsuH
         5z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369074; x=1734973874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KESVQtKZqZa3Yfy4tilcv/lLnaFc43UVwOF5TEnaANw=;
        b=plZxS4aa72zvHfQaJ3jQug9LvsQOt1Vs5nDDRMTAqy0pIbgdwOiLTx5G/qX0j/obyK
         EjrOCl062h6+9koIZ2pSjLYVIXGoi3FzI1typALOVHPafTHBWb4Cot31inK+FKGYOK3O
         rDkQyAQmZBeLe5hpbvdSCu65o21plGi+kP98X9CZbHMJmUGmjo4bY2WnV29b+50z1Wjy
         UTYDLS5/4A5Qkp1Ek7A0XxXWBOG8DjumvxnWsQ2z/EwcHT7Y0XAlSOkGeJ4qift4Xdsc
         NB4Luoswyr1GbQ19XCA7LDlZpKzBpCRIy2gIkHlTWd7I5EDjdCNOv2/k/6u9kckKtnQB
         B1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUWc8FNfLSBtSfEUYFcFRdInFt6oy8SR2MBCggrSsUwDTJNskjm9QaR02MJSLhpLvLB0EuHIuTVvvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlqj41qBigBzxMaHHXbI2KjBGk/+klmoZROOFo+GZ7PcmIMLAA
	PBH9cSnLmKUmJl6o7Aeo7j6gNEX4WKC/YZl6uV1pGKhBSrhi+mKMyIQ2GmXyPg==
X-Gm-Gg: ASbGnctX2kHmwJT1bcXdUdKxJTF56yOQcTgaiwQQjrqU+N35GyLtaMDLfgim4pi2uGJ
	pL6QqFVkVgt9eOPXZEXQPGSBWKWJ0MphHccKLFBNsALToKKS8NZWQ5NvmmUZLMTItvl33aOwUxA
	sYyvmkkafQU0WZKtPFTUtwYyLNVIEKoRp7Hg/uBMczwnnTtKrOogadvZsLhY3jdE+Id5USvv1Sa
	lLmh1+YWmPdugvVcV5opBLCjLdpt53WUu+zVeOxOPrTFZLpkRksoiWkv04xi6xGe9RH
X-Google-Smtp-Source: AGHT+IGuw2osrWwyy8PDxgoa5NFmZ8dgBrl4BEXKTy6du57U+4dL9QoOD0UuDYSbH38/mphybyPo2Q==
X-Received: by 2002:a17:903:32cf:b0:215:54a1:8584 with SMTP id d9443c01a7336-218929c3970mr177479665ad.17.1734369074480;
        Mon, 16 Dec 2024 09:11:14 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50aadsm45034765ad.156.2024.12.16.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:11:14 -0800 (PST)
Date: Mon, 16 Dec 2024 22:41:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20241216171108.6ssulem3276rkycb@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>

On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> On Sat, Dec 14, 2024 at 7:30 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 12, 2024 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > Right. This seems to somewhat work for ACPI types of systems, because
> > > > > ACPI is controlling the low power state for all the devices. Based on
> > > > > the requested system wide low power state, ACPI can then decide to
> > > > > call pm_set_suspend_via_firmware() or not.
> > > > >
> > > > > Still there is a problem with this for ACPI too.
> > > > >
> > > > > How does ACPI know whether it's actually a good idea to keep the NVMe
> > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > > > s2idle and that's what I will use when I close the lid. In this way,
> > > > > the NMVe storage will certainly contribute to draining the battery,
> > > > > especially when I won't be using my laptop for a couple of days.
> > > > >
> > > > > In my opinion, we need a better approach that is both flexible and
> > > > > that dynamically adjusts based upon the use case.
> > > >
> > > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > > but I don't really know enough about the PM core to drive it
> > > > (as the reply from Rafael to my mail makes pretty clear :))
> > >
> > > I'm here to help.
> > >
> > > Let me know what exactly you want to achieve and we'll see how to make it work.
> >
> > I'll try to summarize the requirement here since I started this thread:
> >
> > Problem statement
> > =================
> >
> > We need a PM core API that tells the device drivers when it is safe to powerdown
> > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > applicable to other devices as well.
> >
> > Drivers are relying on couple of options now:
> >
> > 1. If pm_suspend_via_firmware() returns true, then drivers will shutdown the
> > device assuming that the firmware is going to handle the suspend. But this API
> > is currently used only by ACPI. Even there, ACPI relies on S2R being supported
> > by the platform and it sets pm_set_suspend_via_firmware() only when the suspend
> > is S2R. But if the platform doesn't support S2R (current case of most of the
> > Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won't be
> > powered down draining the battery.
> 
> So my question here would be why is it not powered down always during
> system-wide suspend?
> 
> Why exactly is it necessary to distinguish one case from the other
> (assuming that we are talking about system-wide suspend only)?
> 

To support Android like usecase with firmware that only supports
suspend-to-idle (Qcom platforms). This usecase is not applicable right now, but
one can't just rule out the possibility in the near future.

And the problem is that we need to support both Android and non-Android systems
with same firmware :/

> There are drivers that use pm_suspend_via_firmware() to check whether
> or not something special needs to be done to the device because if
> "false" is returned, the platform firmware is not going to remove
> power from it.
> 
> However, you seem to be talking about the opposite, so doing something
> special to the device if "true" is returned.  I'm not sure why this is
> necessary.
> 

Because, since 'false' is returned, drivers like NVMe are assuming that the
platform won't remove power on all DT systems and they just keep the devices in
low power state (not powering them down). But why would I want my NVMe in DT
based laptop to be always powered in system suspend?

> > If the platform is using DT, then there is no entity setting
> > pm_set_suspend_via_firmware().
> 
> That's true and so the assumption is that in this case the handling of
> all devices will always be the same regardless of which flavor of
> system suspend is chosen by user space.
> 

Right and that's why the above concern is raised.

> > So NVMe will be kept in low power state all the
> > time (still draining the battery).
> 
> So what would be the problem with powering it down unconditionally?
> 

I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
will wear out the NVMe devices if used in Android tablets etc...

> > There were attempts to set this flag from
> > PSCI [1], but there were objections on setting this flag when PSCI_SUSPEND is
> > not supported by the platform (again, the case with Qcom SoCs). Even if this
> > approach succeeds, then there are concerns that if the platform is used in an
> > OS like Android where the S2Idle cycle is far more high, NVMe will wear out
> > very quickly.
> 
> I see.
> 
> > So this is where the forthcoming API need to "dynamically adjusts
> > based upon the use case" as quoted by Ulf in his previous reply. One way to
> > achieve would be by giving the flexibility to the userspace to choose the
> > suspend state (if platform has options to select). UFS does something similar
> > with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itself makes
> > use of.
> 
> Before we're talking about APIs, let's talk about the desired behavior.
> 
> It looks like there are cases in which you'd want to turn the device
> off completely (say put it into D3cold in the PCI terminology) and
> there are cases in which you'd want it to stay in a somewhat-powered
> low-power state.
> 
> It is unclear to me what they are at this point.
> 

I hope that my above explanation clarifies. Here is the short version of the
suspend requirement across platforms:

1. D3Cold (power down) - Laptops/Automotive
2. D3hot (low power) - Android Tablets

FWIW, I did receive feedback from people asking to just ignore the Android
usecase and always power down the devices for DT platforms. But I happen to
disagree with them. Let me know if I was wrong and I should not worry about
Android usecase as it is for the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

