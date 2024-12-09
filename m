Return-Path: <linux-pci+bounces-17949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3309E99CB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D83A1642C6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C361F2C51;
	Mon,  9 Dec 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkzVR89R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4C1F2C5B
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756254; cv=none; b=sOMVw381N2mcHcrl/1M2oOHsllkaDdb/Mz7U5LwY83IxacV7Amn2Vb9JpA8ROCixAV1L57PAbAQdgRXHen8aDr9eWKbLxh5sXO8sGSOXOpab2mFHSzB9wlRoqzvTRBwW9h1AcH/Ubtun4w/V2xEiijvX/LjoHus0dRYJzaNcjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756254; c=relaxed/simple;
	bh=csqSrK7Gyw9lFWobOcIi6vXc8FRxXPhTqgm7eX6sw6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGFYgzqU4lB1IyczphXSbf7fziSCqjczpxNHDuz6HbsToN4Pmk8dwIaBG99Zs8N4zesOcw+uEJoFZWCu56ncXE0XOF0AhIrQQQe5dIbU5KtDNpNU6IYBUhnKz1rqVVlWkdVJ+QklY1fnWTCi1/+i9sFY6+L7t6HmsJ1U/wvnJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkzVR89R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so3495524a91.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733756252; x=1734361052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KljjciUYKRtZe6TTkB3fwVscfzXvlqDm8f0xGw53hKc=;
        b=tkzVR89RWQ4Ya+9U0WW8pi3vkXCRz7YobJfmJSi/hb5BOKwOKyRxtkgfo7KK0Zx+WG
         RheyCMwoK/KTzzc167qJMg6IwhlC/lM/uye/fR5RNPKVPIjx1JlmKF66jUV1PwsJq4ae
         67vrAU4Vs10/roPkFoT5M9QXRWR+kWBqZVksX5crT1E+hhGiKV24uXfD5AGPBGClzTb/
         DmOS6QEk5Nzb2H25dbNFFLhoiSHgU1dACPEw0nX3aFUqzN8L/gVBoZsZg3oDeZPRgNd5
         NtSS7tnwrUya4cHbVa1W0jbtDtxGByyJMMzVmI7QLfTtHhsI7Il8nNeS+zd9TDxC0VL+
         PSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756252; x=1734361052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KljjciUYKRtZe6TTkB3fwVscfzXvlqDm8f0xGw53hKc=;
        b=VJMl+tH6kGWAgWiF+Kna7q9HCgIQp1bGZyvqIdZkd7ejoE46VsLSKaa3oSvCz7RDry
         k4UkdMfBj7hVvfOA9CVjIhqBs/MzECbJ9RFZ47k/aAQwSZbLLwzGBOZ6g6VvjrN/iHZB
         B3cTl5LbnI/Qv3i+dTD+BWBWb1vCmXNlD1WuQytmKpYQeKhqLGoqp6w5/e1TeA/V3Jil
         oc7rNcWu2ENcMX/iJNlcl7+Hl5wSi15jGTBqQs8S7blnr6rklv6zThBiwjZ6+5TBIq9U
         smK4Id7t0e8sa7iRlTS1TMSH1GwocbrL8oC32TJX40w8qYaGDPXh6+OilkHIz7eIIOdj
         qdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPfKBd2RslCMqYBx0vzHlwS2LkesLEde77xbuyjV3U0Q25WRtocA4KIPcKtr2PeOC/lFbn3+L4eZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tLFr0+96poFLvdotQe2Awqp+jjpWXUNeeMPPmjhYF1DzX8ig
	8f5vgedlSRrLyn2cZo1OCFHr9M5OsOqaU149tRHWpMZlioMSlm8u5nwuzW89cg==
X-Gm-Gg: ASbGncusqZZOg24ugZiyZC+ijUxFtTOS9Ic7zzHrCURdf+PTI0XTzwLPLJf1J5OW8SB
	2j2vn6fNsj5WqfoM4Bt2KM3dUEJSGOsHUeudWOrhSWtkhfBMZu3F6uYdvWrsd3NGD09i3cSMymv
	2lTHcvyVIFA7gPGZBfNm4AwsoOMDv8iuMpUioK8QWgzTB7lOOm+2VJ77IPitBHwXigJYM/Whcux
	bi+b0uUZNF3DmL827Ygp77IkPEG5SIwIcCaZwv+Dzo1TCclt/btONgGuG4R
X-Google-Smtp-Source: AGHT+IGGIf0rHxIHQpm9+Q2TsNvz9dCMkcSWu+SbDwmZXMCAJqjPZpdwwKQe51sDJmLUG3RC2vpb1w==
X-Received: by 2002:a17:90b:4f4c:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2ef696546efmr17506292a91.4.1733756251914;
        Mon, 09 Dec 2024 06:57:31 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157d79e5sm7545519a12.75.2024.12.09.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:57:31 -0800 (PST)
Date: Mon, 9 Dec 2024 20:27:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209145724.5ibst4frsiap4s4r@thinkpad>
References: <20241123090113.semecglxaqjvlmzp@thinkpad>
 <20241205232900.GA3072557@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205232900.GA3072557@bhelgaas>

On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > device through the sysfs attribute
> > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > suspend.
> > > >
> > > > So make use of this flag in the NVMe driver to shutdown the NVMe
> > > > device during system suspend if the user has allowed D3Cold for
> > > > the device.  Existing checks in the NVMe driver decide whether
> > > > to shut down the device (based on platform/device limitations),
> > > > so use this flag as the last resort to keep the existing
> > > > behavior.
> > > > 
> > > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to
> > > > allow D3Cold and the users can disallow it through sysfs if they
> > > > want.
> > > 
> > > What problem does this solve?  I guess there must be a case where
> > > suspend leaves NVMe in a higher power state than you want?
> > 
> > Yeah, this is the case for all systems that doesn't fit into the
> > existing checks in the NVMe suspend path:
> > 
> > 1. ACPI based platforms
> > 2. Controller doesn't support NPSS (hardware issue/limitation)
> > 3. ASPM not enabled
> > 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> > 
> > In my case, all the Qualcomm SoCs using Devicetree doesn't fall into
> > the above checks. Hence, they were not fully powered down during
> > system suspend and always in low power state. This means, I cannot
> > achieve 'CX power collapse', a Qualcomm specific SoC powered down
> > state that consumes just enough power to wake up the SoC. Since the
> > controller driver keeps the PCI resource vote because of NVMe, the
> > firmware in the Qualcomm SoCs cannot put the SoC into above
> > mentioned low power state.
> 
> IIUC nvme_suspend() has two paths:
> 
>   - Do nvme_disable_prepare_reset() without calling pci_save_state(),
>     so the PCI core chooses and sets the low-power state.
> 
>   - Put the device in an NVMe-specific low-power state and call
>     pci_save_state(), which prevents the PCI core from putting the
>     device in a low-power state.
> 
>     (The PCI core part is in pci_pm_suspend_noirq(),
>     pci_pm_poweroff_noirq(), pci_pm_runtime_suspend())
> 
> And I guess you want the first path for basically all systems?  The
> only systems that would use the NVMe-specific path are those where:
> 
>   - !pm_suspend_via_firmware() (not an ACPI system), AND
> 
>   - ctrl->npss (device supports NVMe power states), AND
> 
>   - pcie_aspm_enabled(), AND
> 
>   - !NVME_QUIRK_SIMPLE_SUSPEND (it's not something with a weird
>     quirk), AND
> 
>   - !pdev->d3cold_allowed (user has cleared it via sysfs)
> 
> This frankly seems almost unintelligible to me, so I'm glad I'm not
> responsible for nvme :)
> 

I agree that using the attribute is not a great idea in the NVMe driver where
there are already a handful of quirks/checks, but that seems unavoidable.

> > > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > > your underlying intent.  It suggests that you're really hoping for
> > > D3cold, but that's only a possibility if firmware supports it, and
> > > we have no visibility into that here.
> > 
> > I'm not relying on firmware to do anything here. If firmware has to
> > decide the suspend state, it should already satisfy the
> > pm_suspend_via_firmware() check in nvme_suspend(). ...
> 
> I'm confused about this because we want to use PCI core power
> management, which chooses the new state with pci_target_state(),
> which looks like it will choose D3hot unless we're on an ACPI system
> and acpi_pci_choose_state() returns D3cold.
> 
> But your system is not an ACPI system, so we should get D3hot, but yet
> you decide based on D3*cold* being allowed?
> 

This is an existing ungliness of DT platforms. D3Cold is not tied to the PCI
core, but the controller drivers decide on their own.

> > Here, the controller driver takes care of putting the device into
> > D3Cold.  Currently, the controller drivers cannot do it (on DT
> > platforms) because of NVMe driver's behavior.
> 
> I'm missing the connection to the controller driver (I assume you mean
> qcom-pcie?).  Maybe it's that having the NVMe device in a PCI
> low-power state allows qcom_pcie_suspend_noirq() to reduce the ICC
> bandwidth vote and do other power-saving things?  And it can't do
> those things if we're using the NVMe low-power state because that
> state is not visible to qcom-pcie?
> 

Yes. In DT platforms, peripheral power state is not controlled by the firmware
to some extent. For PCIe, the controller driver is responsible for handling the
endpoint devices power state. As you referred qcom-pcie driver, it currently has
the 1 Kbps ICC vote in qcom_pcie_suspend_noirq() just because we cannot fully
remove the ICC vote due to NVMe. Because of this, even if NVMe is in its optimal
low power state, the SoC cannot enter its own low power state. Plus it doesn't
make a lot of sense to keep NVMe in low power mode even if you suspend your DT
based laptop for hours.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

