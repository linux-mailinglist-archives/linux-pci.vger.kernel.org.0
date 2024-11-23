Return-Path: <linux-pci+bounces-17230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393BC9D6844
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB6E281D7A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BA16EB42;
	Sat, 23 Nov 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOoXWf9s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3738DD3
	for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352484; cv=none; b=WjiBZ5keCu3xjzzK8GIQiH+rA6nE0yC7B3r8+smbAC6CwdDBOz1mGBt9Z650MQHhq3D2Bi4cKgtBrfPEQx2J9T0oqmeWk0S8aphmbp2mdmrJxyPvIEN2cYC23QmLwJ3z93coiW5gjVwPbib+ksMw3y7NnUHK4n0Fkp8p1a2a7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352484; c=relaxed/simple;
	bh=YrxCZr/zol9fbcvDQahSobhoJ5+oSaDlVLvBp197B2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ9Ox3IWcWa58BDV8iwoQt9c9b6XBSEnItSao0zwqBHTLiZvcRAHYpuUjHhrbge3jvftJEhl4Ei1/KMAR4kQ2+wI2X8lj6EGA5knuU8HLN6Gxml6p2KNZI30hVutz7xmerSZ4U54FWaidm9bMOoJu0OCVgCaE97CNQC3ISx22fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOoXWf9s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1379881b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732352481; x=1732957281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBiKB3fBf+Bk4u52dSdkKE7lx9s1dAcTEPhof51kEoU=;
        b=vOoXWf9sRH5ykOuEUMIWpCblSZ16I9TottUtP4tD3sFciGCUwD0ArJhMjszC7BeKam
         fx/cZm4jOQcxQL0c23w4GBMjWa81MS7DHszaCwvQ7VKrVlm3e8ESW0kgeS6Kjk73090M
         PTkdRHvbPosBN4SlsJN5OQXUdyLCz0WMT11d7PUqF+PiEe2OxwUmg3tnke+icU9Bu+FB
         CCu5dqx5lTGQavSAOZAH7mbck8LIvGMtrUV/rpIaMWMomn1Gg2eoIo1XsaO/mMUySutc
         Rf/Q6I3A3PwXhGr/rk3TK2+ISlSkAtFoEHqqGJwIHzct14g3tHRhJ+qrZss8CYE9VO+D
         xmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352481; x=1732957281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBiKB3fBf+Bk4u52dSdkKE7lx9s1dAcTEPhof51kEoU=;
        b=jMq5yuC1O4OrZflR1L6Gwpa6wZxBQO/ETFN9U3SLR0ZI5zy7MbBfU6k5XgoI7ZaBeA
         WEIQ92O1m9QV3tHm3ijiWvBkOd4Y395XWWnozaAFmR7zDqWK1X+fnbU4yWV0OllTuofv
         KbvF7tzkMDMSB2wO9ZIBkOGHiznf8B1+OkTo9SEIzr/Bpsk6EMuRrOmkRo+FeDxdeyNY
         6KXtZtHzTOfzt6fE+kxYhl7qrswCMgtFqwQuD5NS70HJ04nPI06jn2aqy4UXVvdcAbC3
         BuGYRzJiWPTliCCm65zGB5+oB/0Ayp5FwnVfwb5Jjr9K4ov0KJC8HfZDnJI1uDACC6cl
         kIqw==
X-Forwarded-Encrypted: i=1; AJvYcCUBKGwWJI/r45A0KPBR4t17BMIE0wrHO4evDNY0gn21uLhhn50TuMA4XzHEg8iHHb7xna0Ur9/bJ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqF03ZoIGiLQhC/p+QXfkVznGoUKXQ77yKrB2Yh3AJBmKm/1f
	gpmOFT6JVxi42LCROurC2H+Hu+MGCRucQDcUy8RjxsRt9nh1rWOGrxUYXKasYA==
X-Gm-Gg: ASbGncuv4qZ3y3fXoliyNRRKKlfSCOoY0Unk9+Hm+VQS6z1CLgwQPnQ6GFbAIGBHWQv
	cj0Q8GEdmE4nMuzPFqOcwazvUPm/nib6LfuSy730zK/80ypmziDNYwrCNPhLxWouNfmMcKMJqfl
	ULEsjO5oVjR7i9umHZJsRkceHK4sum8J8ffuq6ThZNM5GWL4ifeOF+gkhMz0K5EX/gvz5KP+QPD
	+umLBPs77Kk/rU9AhR5Vl+MpcR6rXuXZ+C9Gr7q0hQnWfOYNUAEXi11ZrVGI/Besw==
X-Google-Smtp-Source: AGHT+IEXRKK5p3elatN9Cx1SAW9h5XDRG6j63BDSg8WgjcTkcpjwRut8X2gGXXHIdFCTSsoB7yX7Yg==
X-Received: by 2002:a17:902:d2c5:b0:212:4751:ad7e with SMTP id d9443c01a7336-2129f7315dfmr69743785ad.8.1732352481266;
        Sat, 23 Nov 2024 01:01:21 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbff380sm28769635ad.114.2024.11.23.01.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:01:20 -0800 (PST)
Date: Sat, 23 Nov 2024 14:31:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241123090113.semecglxaqjvlmzp@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241122222050.GA2444028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122222050.GA2444028@bhelgaas>

+ Ulf (also interested in this topic)

On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > PCI core allows users to configure the D3Cold state for each PCI device
> > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> >
> > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > during system suspend if the user has allowed D3Cold for the device.
> > Existing checks in the NVMe driver decide whether to shut down the device
> > (based on platform/device limitations), so use this flag as the last resort
> > to keep the existing behavior.
> > 
> > The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> > D3Cold and the users can disallow it through sysfs if they want.
> 
> What problem does this solve?  I guess there must be a case where
> suspend leaves NVMe in a higher power state than you want?
> 

Yeah, this is the case for all systems that doesn't fit into the existing checks
in the NVMe suspend path:

1. ACPI based platforms
2. Controller doesn't support NPSS (hardware issue/limitation)
3. ASPM not enabled
4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag

In my case, all the Qualcomm SoCs using Devicetree doesn't fall into the above
checks. Hence, they were not fully powered down during system suspend and always
in low power state. This means, I cannot achieve 'CX power collapse', a Qualcomm
specific SoC powered down state that consumes just enough power to wake up the
SoC. Since the controller driver keeps the PCI resource vote because of NVMe,
the firmware in the Qualcomm SoCs cannot put the SoC into above mentioned low
power state.

> What does it mean that this is the "last resort to keep the existing
> behavior"?  All the checks are OR'd together and none have side
> effects, so the order doesn't really matter.  It changes the existing
> behavior *unless* the user has explicitly cleared d3cold_allowed via
> sysfs.
> 

Since the checks are ORed, this new check is not going to change the existing
behavior for systems satisfying above checks i.e., even if the user changes the
flag to forbid D3Cold, it won't affect them and it *shoudn't*.

> pdev->d3cold_allowed is set by default, so I guess this change means
> that unless the user clears d3cold_allowed, we let the PCI core decide
> the suspend state instead of managing it directly in nvme_suspend()?
> 

If 'pdev->d3cold_allowed' is set, then NVMe driver will shutdown the device and
the PCI controller driver can turn off all bus specific resources. Otherwise,
NVMe driver will put the device into low power mode and the controller driver
has to do something similar to retain the device power.

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/nvme/host/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 4b9fda0b1d9a..a4d4687854bf 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
> >  	 */
> >  	if (pm_suspend_via_firmware() || !ctrl->npss ||
> >  	    !pcie_aspm_enabled(pdev) ||
> > -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> > +	    pdev->d3cold_allowed)
> >  		return nvme_disable_prepare_reset(ndev, true);
> 
> I guess your intent is that if users prevent use of D3cold via sysfs,
> we'll use the NVMe-specific power states, and otherwise, the PCI core
> will decide?
> 

Not PCI core, but the controller drivers actually which takes care of powering
down the PCI bus resources.

> I think returning 0 here means the PCI core decides what state to use
> in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
> could be any state from D0 to D3cold depending on platform support and
> wakeup considerations (see pci_target_state()).
> 
> I'm not sure the use of pdev->d3cold_allowed here really expresses
> your underlying intent.  It suggests that you're really hoping for
> D3cold, but that's only a possibility if firmware supports it, and we
> have no visibility into that here.
> 

I'm not relying on firmware to do anything here. If firmware has to decide the
suspend state, it should already satisfy the pm_suspend_via_firmware() check in
nvme_suspend(). Here, the controller driver takes care of putting the device
into D3Cold. Currently, the controller drivers cannot do it (on DT platforms)
because of NVMe driver's behavior.

> It also seems contrary to the earlier comment that suggests we prefer
> host managed nvme power settings:
> 
>   * The platform does not remove power for a kernel managed suspend so
>   * use host managed nvme power settings for lowest idle power if
>   * possible. This should have quicker resume latency than a full device
>   * shutdown.  But if the firmware is involved after the suspend or the
>   * device does not support any non-default power states, shut down the
>   * device fully.

This above comment satisfies the ACPI platforms as the firmware controls the
suspend state. On DT platforms, even though the firmware takes care of suspend
state, it still relies on the controller driver to relinquish the votes for PCI
resources. Only then, the firmware will put the whole SoC in power down mode
a.k.a CX power collapse mode in Qcom SoCs.

We did attempt so solve this problem in multiple ways, but the lesson learned
was, kernel cannot decide the power mode without help from userspace. That's the
reason I wanted to make use of this 'd3cold_allowed' sysfs attribute to allow
userspace to override the D3Cold if it wants based on platform requirement.

This is similar to how UFS allows users to configure power states of both the
device and controller:

/sys/bus/platform/drivers/ufshcd/*/spm_lvl
/sys/bus/platform/devices/*.ufs/spm_lvl

If the 'd3cold_allowed' attribute is not a good fit for this usecase, then I'd
like to introduce a new attribute similar to UFS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

