Return-Path: <linux-pci+bounces-18756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415A9F7695
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36815188A335
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38822163B8;
	Thu, 19 Dec 2024 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxrvqhlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD378F4A
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595347; cv=none; b=SkK0mUtmMeb83qIbq+iiSu49WpIuRRXMt8uqmNT960suiWl/l//C/una7vbEp+N/hRz2JMrrPEFqhHxG/JAyI9hUv9hd11htHx+KFIPPNhS5Ub5UlnuNmFnebs4x4OTBY0FOCs0r+e36aWG+eN3RFnMfYgJbu8qaIViHIOYc5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595347; c=relaxed/simple;
	bh=PIQaEH7XnDeoE5i9LsmS5jNHg0gLKNYNvQ6Q+DwhM2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh059M32kZVnyDu/wlafw+MZhDmx5CLcaHOqhzFDVGRPrv3JgjgrT4V2zr+pDzmuEk+qrVzXckb29SgF311uakCQklnHxpdElbiBXr+TZr1mP58Yo1Gk00Tt4sdwKgjfP2JstsojipytuEf0+TR1zIwNkygkgTjTHlsPpcsgyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxrvqhlG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so418209b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 00:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734595345; x=1735200145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FiIXhUgGXRHUKYompmzT3WtYs6AwRDjwCP4avnbaXXs=;
        b=uxrvqhlG0IG7sDcA8tyqkf5W26tRgyJaGwe5n/H9HgtbAv8U3xQXlH6vyJhVuopf7z
         i/vMMYizhIDY4kKMpIBEVxqFd0tfOiijnWYMoH+pXc7OuaHb0nAlWruHBbMhljsfesrC
         3lrmfxJfI6SUt4uhNAlrR32MO8UEMp9QuGj9jBqxG4XXZnSOD3onEAvCkpIQyMaXj8mH
         TBQh/1ph6BaHGOn0jh4l2tAjHFrVl0VXVZW+FMVENIL4h9S508n1j9chYGZBa6k/uFB2
         dGtc/Fj+I53cPfyFkF0q43yMrB21K36OaAaHJ85zoN/Nt1BxXap1H6CQ+GdO2gI4G3V7
         AwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595345; x=1735200145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiIXhUgGXRHUKYompmzT3WtYs6AwRDjwCP4avnbaXXs=;
        b=KCNbajWmPD8fxQ4ts9Mh9K1OgZSuury/ie0HOZVg03ACUS3yKe02ZEjTAdKiJ8DQwe
         Mgzdl08eDPRWalkNycTce+lx/5ikE5BfaF3J9TjzTr0ktXmoKPBZCffNznrU8JZO5Ru8
         lNSDe2MwvTsQQFxaJIPyk2EngnZBDsfOz88SUIFVThRSf6W3tkXO5Rq+MSGqQ/lkDcMA
         b/DSdxrTXFuJ0F5EzU76AohC+DBB26InKSEal6TJecrzZHS833mbBUMe6DZiEjTI0WKD
         j/Wvj7pqZJdiZwiWPsc/JtRxskHw4rDZA0D1dOG6Ir1l2KbkQee6S/dAr0KxEiDC8sp8
         N8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVIEL0g8EzE7sjd+cD/nEWEPHxchI+omJmWRr2hARPTXGUHVzPGIoBqsI6t6brGWcfHHFnElOWmmIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCK7WFAKDeeU4etdFs0MLlCOrbGY/DsNZufvJ05czeUQb49yn
	PeXnRiV24wM+H49tMeZ40G64HYyxtGoCV+vzSOW/GFBh5/a3g9ZmrHt+j5QeCw==
X-Gm-Gg: ASbGncvGENoOSVRkn5TfCDyEda/F2XB3S1/V9FDQlu+cOZkd/yM0V4ftbwHcPVCDOj0
	sj9OQHrRZuqY7cR93CFMpTnq0hqWsAjnaGWhZe5eE+LhJNCEbZqIqPSKycWdo3RvohNpmxt3gHk
	GZCNB9dN57vVZWN+umMAnOkOtgt+wtQx5wDwn+r4Ji9363UtrekPv0SS5FqvzVm+A6osiiDrktY
	jEuQLxqEFTsUhXq+yT5KuPHPMf47gSNhWVY2gTMjDHc6xIrSMaVJqCY8nE4v97/ueWc
X-Google-Smtp-Source: AGHT+IFll0irdbwM+RUdhMNn+L6WxoWJUa0AF8tiMBuXb8vjLzgtKTa5XtyI18qRm8PKkIbtuUs9zg==
X-Received: by 2002:a05:6a20:6a25:b0:1e1:afa9:d38a with SMTP id adf61e73a8af0-1e5c74f2fafmr4032467637.1.1734595345080;
        Thu, 19 Dec 2024 00:02:25 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm627161a12.23.2024.12.19.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:02:24 -0800 (PST)
Date: Thu, 19 Dec 2024 13:32:17 +0530
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
Message-ID: <20241219080217.fr2ukr7sk4a7hfmo@thinkpad>
References: <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad>
 <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>

On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 17, 2024 at 6:26 AM <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> > > > There is also a case where some devices like
> > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
> > > > powered down in order for the SoC to reach its low power state (CX power
> > > > collapse in Qcom terms). If not, the SoC would continue to draw more power
> > > > leading to battery draining quickly. This platform is supported in upstream and
> > > > we keep the PCIe interconnect voted during suspend as the NVMe driver is
> > > > expecting the device to retain its state during resume. Because of this
> > > > requirement, this platform is not reaching SoC level low power state with
> > > > upstream kernel.
> > >
> > > OK, now all of this makes sense and that's why you really want NVMe
> > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > >
> > > Would D3hot be sufficient for this platform or does it need to be
> > > D3cold?  If the latter, what exactly is the method by which they are
> > > put into D3cold?
> > >
> >
> > D3Cold is what preferred. Earlier the controller driver used to transition the
> > device into D3Cold by sending PME_Turn_Off, turning off refclk, regulators
> > etc... Now we have a new framework called 'pwrctrl' that handles the
> > clock/regulators supplied to the device. So both controller and pwrctrl drivers
> > need to work in a tandem to put the device into D3Cold.
> >
> > Once the PCIe client driver (NVMe in this case) powers down the device, then
> > controller/pwrctrl drivers will check the PCIe device state and transition the
> > device into D3Cold. This is a TODO btw.
> >
> > But right now there is no generic D3Cold handling available for DT platforms. I
> > am hoping to fix that too once this NVMe issue is handled.
> 
> There's no generic D3cold handling for PCIe devices at all AFAICS.  At
> least, I'm not aware of any standard way to do it.  Yes, there are
> vendor-specific conventions that may even be followed by multiple
> vendors, but not much beyond that.
> 

Yeah, right. Atleast ACPI has its own way of handling D3Cold and that's what I
meant. There is no such option available for DT right now. I was shoping that
once this NVMe issue is resolved, then I could look into D3Cold for DT
platforms.

> > > > > > > > If the platform is using DT, then there is no entity setting
> > > > > > > > pm_set_suspend_via_firmware().
> > > > > > >
> > > > > > > That's true and so the assumption is that in this case the handling of
> > > > > > > all devices will always be the same regardless of which flavor of
> > > > > > > system suspend is chosen by user space.
> > > > > > >
> > > > > >
> > > > > > Right and that's why the above concern is raised.
> > > > >
> > > > > And it is still unclear to me what the problem with it is.
> > > > >
> > > > > What exactly can go wrong?
> > > > >
> > > > > > > > So NVMe will be kept in low power state all the
> > > > > > > > time (still draining the battery).
> > > > > > >
> > > > > > > So what would be the problem with powering it down unconditionally?
> > > > > > >
> > > > > >
> > > > > > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > > > > > will wear out the NVMe devices if used in Android tablets etc...
> > > > >
> > > > > I understand the wear-out concern.
> > > > >
> > > > > Is there anything else?
> > > > >
> > > >
> > > > No, that's the only concern.
> > >
> > > OK
> > >
> > > I think we're getting to the bottom of the issue.
> > >
> > > First off, there really is no requirement to avoid putting PCI devices
> > > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > > platforms, PCIe devices are put into D3(hot or cold) during
> > > suspend-to-idle and I don't see why this should be any different on
> > > platforms from any other vendors.
> > >
> > > The NVMe driver is an exception and it avoids D3(hot or cold) during
> > > suspend-to-idle because of problems with some hardware or platforms.
> > > It might in principle allow devices to go into D3(hot or cold) during
> > > suspend-to-idle, so long as it knows that this is going to work.
> > >
> >
> > Slight correction here.
> >
> > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
> > state on its own, not all the time. It has some checks [1] in the suspend path
> > and if the platform/device passes one of the checks, it will power down the
> > device.
> 
> Yes, there is a comment in that code explaining what's going on and
> that is basically "if key ingredients are missing or the firmware is
> going to do its thing anyway, don't bother".
> 
> > DT platforms doesn't pass any of the checks, so the NVMe driver always manages
> > the power state on its own. Unfortunately, the resultant power saving is not
> > enough, so the vendors (Laptop/Automotive) using DT want NVMe to be powered down
> > all the time. This is the first problem we are trying to solve.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c#n3448
> 
> I see.
> 
> This cannot be done by the driver itself, though, at least not in
> general.  The PCI layer needs to be involved and, if we are talking
> about D3cold, the platform firmware needs to be involved either.
> 

Right, but the device driver needs to have some idea about what state PCI core
is going to choose for the device. I believe that's the purpose of
pci_choose_state() API. More below...

> As a rule, the PCI layer reaches out to the platform firmware for help
> as needed and drivers don't take part in this directly.
> 
> The NVMe driver would need to let the PCI layer take over and set the
> PCI power state of the device if it wanted to get any deeper than NVMe
> protocol specific power states.
> 
> In principle, this can be addressed with some kind of a driver opt-in.
> That is, the NVMe driver would continue to work the way it does, but
> instead of completely preventing the PCI layer from taking over, it
> would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) the
> platform firmware provides a mechanism to do so and (b) the DT
> indicates that this mechanism should be used for the given device.
> 

Ok, IIUC you are talking about something like this?

	static int nvme_suspend(struct device *dev)
	{
		...

		if (pm_suspend_via_firmware() || !ctrl->npss || ... ||
		    pci_choose_state(pdev, PMSG_SUSPEND) == PCI_D3cold)
			return nvme_disable_prepare_reset(ndev, true);

		/* continue using protocol specific low power state */

		...
	}

Here, pci_choose_state() should tell the driver if the device should enter
D3Cold. ACPI already supports this API, now I need to add DT support (which is
not straightforward, but doable). Since this API is already exported, I think it
makes perfect sense to use it here (and other drivers for similar usecase).

> > > However, there is an additional concern that putting an NVMe device
> > > into D3cold every time during system suspend on Android might cause it
> > > to wear out more quickly.
> > >
> >
> > Right, this is the second problem.
> 
> Let's set this one somewhat aside for now.  We'll get back to it when
> we have clarity in the above.
> 

Ok. I believe this could be addressed in pci_choose_state() itself if required.

> > > Is there anything else?
> >
> > We also need to consider the fact that the firmware in some platforms doesn't
> > support S2R. So we cannot take a decision based on S2I/S2R alone.
> 
> Right, the S2I/S2R thing is ACPI-specific.
> 
> On platforms using ACPI, pm_suspend_via_firmware() means that the
> firmware is at least likely to power down the whole platform, so the
> PCI layer may as well be allowed to do what it wants with the device.
> 
> > I think there are atleast a couple of ways to solve above mentioned problems:
> >
> > 1. Go extra mile, take account of all issues/limitations mentioned above and
> > come up with an API. This API will provide a sane default suspend behavior to
> > drivers (fixing first problem) and will also allow changing the behavior
> > dynamically (to fix the second problem where kernel cannot distinguish Android
> > vs other OS).
> 
> I don't quite follow TBH.
> 
> A "default suspend behavior" is there already and it is to allow the
> PCI layer to set the device's power state (in collaboration with the
> platform firmware).  Thing is, the NVMe driver doesn't always want to
> rely on it.
> 
> > 2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use of the
> > existing behavior in the NVMe driver. This would only solve the first problem
> > though. But would be a good start.
> 
> That would mean just letting the PCI layer always take over on the
> platforms that would call pm_set_suspend_via_firmware().
> 
> There is a potential issue with doing it, which is that everybody
> calling pm_suspend_via_firmware() would then assume that the platform
> would be powered down by the firmware.  I'm not sure how much of an
> issue that would be in practice, though.

Yeah, that would be a concern.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

