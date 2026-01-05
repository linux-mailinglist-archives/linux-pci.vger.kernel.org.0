Return-Path: <linux-pci+bounces-44036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A950CF44F6
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50EAE30B7374
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7B7E110;
	Mon,  5 Jan 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W2kEYN4L"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CC3A1E96;
	Mon,  5 Jan 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625300; cv=none; b=LwJZJ9aGuU0FrlYRQppiAEiYzUKX2UcZmxakfqI41zJF3FBwo/QtP9xHNFtzSo4xI1KPsqn8Q2g5Z3xDkPDBUYNEi4kCen2sVQgUN1ddOFpv5BPZXEDJ8LnnID1Wy8cdSDialUMruEiZsQBlIiTsjpvOZUklYE06nBPV3YkbszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625300; c=relaxed/simple;
	bh=ahAgD0Fs7SzussxHCSmv8Dl6KtgI+0MaddlvsYlBKR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUCg9nCzw+8v3qiVR/wyeafcdSNrfQS1Vc3RLHGuc6Tfmgb9wfsgPnWkeDbYrMqF7waGBcgoKEIMEdw48hJLFiSGYp3HPzgzMMyewqGSKTo23ea5SSsGVkP04dXrvdyD7wzhPuiusVyYnVpbPKGRPuZp2F51TvQJy2iQAhw4NHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2kEYN4L; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8269249f-48a9-4136-a326-23f5076be487@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767625286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOxQLFGEW0RANVkVfAKLLDgXb3+7inse/Fs/vs8oviw=;
	b=W2kEYN4LQUJDBeZ+ZAdPcAe/LDR9TS8MijYUcz83M03A4wybZiEd9P3eDX64FZ5lkLiJiO
	rtiKXW4fp59dcKjLS7kdQ4zqrsPZwvKv9vprNY8ytZO/r//2q/LW71RJcLEnKnkuUkqJ93
	0lUn3aVzgScqCY7OlRrvfRYWmsr0ic4=
Date: Mon, 5 Jan 2026 10:01:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
 <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>
 <n2vboqjh45bwhs3czpey3alxwi7msohir7m3lk45mecouddwew@byi2emazszqq>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <n2vboqjh45bwhs3czpey3alxwi7msohir7m3lk45mecouddwew@byi2emazszqq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/23/25 09:05, Manivannan Sadhasivam wrote:
> On Fri, Dec 19, 2025 at 12:19:36PM -0500, Sean Anderson wrote:
>> Hi,
>> 
>> I have a few comments on the overall architecture. I did some work to
>> add PERST as well (sent as replies to this message).
>> 
>> On 12/16/25 07:51, Manivannan Sadhasivam wrote:
>> > Hi,
>> > 
>> > This series provides a major rework for the PCI power control (pwrctrl)
>> > framework to enable the pwrctrl devices to be controlled by the PCI controller
>> > drivers.
>> > 
>> > Problem Statement
>> > =================
>> > 
>> > Currently, the pwrctrl framework faces two major issues:
>> > 
>> > 1. Missing PERST# integration
>> > 2. Inability to properly handle bus extenders such as PCIe switch devices
>> > 
>> > First issue arises from the disconnect between the PCI controller drivers and
>> > pwrctrl framework. At present, the pwrctrl framework just operates on its own
>> > with the help of the PCI core. The pwrctrl devices are created by the PCI core
>> > during initial bus scan and the pwrctrl drivers once bind, just power on the
>> > PCI devices during their probe(). This design conflicts with the PCI Express
>> > Card Electromechanical Specification requirements for PERST# timing. The reason
>> > is, PERST# signals are mostly handled by the controller drivers and often
>> > deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
>> > should be deasserted only after power and reference clock to the device are
>> > stable, within predefined timing parameters.
>> > 
>> > The second issue stems from the PCI bus scan completing before pwrctrl drivers
>> > probe. This poses a significant problem for PCI bus extenders like switches
>> > because the PCI core allocates upstream bridge resources during the initial
>> > scan. If the upstream bridge is not hotplug capable, resources are allocated
>> > only for the number of downstream buses detected at scan time, which might be
>> > just one if the switch was not powered and enumerated at that time. Later, when
>> > the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
>> > insufficient upstream bridge resources.
>> >
>> >
>> > Proposal
>> > ========
>> > 
>> > This series addresses both issues by introducing new individual APIs for pwrctrl
>> > device creation, destruction, power on, and power off operations.
>> 
>> I wrote my own PCI power sequencing subsystem last year but didn't get
>> around to upstreaming it before the current subsystem was merged. This
>> approach (individual APIs for each power sequence) was how I did it. But
>> I think the approach to do everything in probe is rather elegant, since
>> it integrates with the existing device model and we don't need to modify
>> existing drivers.
>> 
>> To contrast, in U-Boot the second issue doesn't apply because driver
>> probing happens synchronously and config space accesses are done after
>> devices get probed. So you have something like
>> 
>> host bridge probe()
>> pci_scan_child_bus()
>>    discover root port
>>    root port probe()
>>       initialize slot resources (power supplies, clocks, etc.)
>>    allocate root port BARs
>>    discover root port children
>> 
>> I guess your approach is the only way to do it in Linux given the
>> asynchronous nature of driver binding. What is the overhead for hotplug
>> switches like? Maybe it makes sense to just treat all switches as
>> hotplug capable when PCI power sequencing is enabled?
>> 
> 
> Pwrctrl doesn't care if the underlying bridge is hotplug capable or not. It just
> handles the power control for the device if it happens to have resource
> dependency in DT. For example, if the PCIe switch requires pwrctrl and the
> corresponding DT node has the resources described, pwrctrl framework will just
> turn ON the switch. Then during PCI bus scan, PCI core will enumerate the switch
> and check whether the downstream ports are hotplug capable or not and handles
> the bus resource accordingly.
> 

I'm saying that we allocate enough address space for each bridge as if
it was hotplug capable, to ensure we don't run out of space later on.

>> > Controller
>> > drivers are expected to invoke these APIs during their probe(), remove(),
>> > suspend(), and resume() operations. This integration allows better coordination
>> > between controller drivers and the pwrctrl framework, enabling enhanced features
>> > such as D3Cold support.
>> 
>> How does PERST work? The only reference I can find to GPIOs in this
>> series is in the first patch. Is every driver supposed to add support
>> for PERST and then call these new functions?
> 
> Yes. We can come up with some generic controller specific APIs later to reduce
> duplication, especially if GPIO is used for PERST#. But that's currently not in
> scope for this series.
> 
>> Shouldn't this be handled
>> by the power sequencing driver, especially as there are timing
>> requirements for the other resources referenced to PERST? IMO if we are
>> going to touch each driver, it would be much better to consolidate
>> things by removing the ad-hoc PERST support.
>> 
> 
> It is not that straightforward. Initially, my goal was to abstract pwrctrl away
> from controller drivers, but then that didn't scale. Because, each controller
> drivers have different requirement, some may use GPIO for PERST# and some use
> MMIO.

Can't you resolve that by exposing a GPIO controller for the signal?

Of course for compatibility we will want to support old devicetrees, so
maybe we should just add a method on the host bridge to control PERST.
And then pwrctrl could try to use it as a fallback.

> Also, some drivers do more work during the PERST# deassert, like checking
> for Link up as in drivers/pci/controller/pci-tegra.c.

Yeah, but is this actually necessary? We should just be able to toggle
the reset and then try to read a config register after 100 ms. If the
link is up the access will succeed. If it's down at that point then the
device doesn't follow the PCIe spec and we can't really be sure the link
will ever come up. The relevant code even has a comment

 * FIXME: If there are no PCIe cards attached, then calling this function
 * can result in the increase of the bootup time as there are big timeout
 * loops.

Which would be avoided by delaying asynchronously in the pwrseq driver.

> For sure, it would be doable to rework those drivers for pwrctrl, but that is
> not practically possible and requires platform maintainer support. So to make
> the pwrctrl adoption easier, I went with the explicit APIs that the drivers can
> call from relevant places.
> 
>> > The original design aimed to avoid modifying controller drivers for pwrctrl
>> > integration. However, this approach lacked scalability because different
>> > controllers have varying requirements for when devices should be powered on. For
>> > example, controller drivers require devices to be powered on early for
>> > successful PHY initialization.
>> 
>> Is this the case for qcom? The device I tested (nwl) was perfectly
>> happy to have the PCI device show up some time after the host bridge
>> got probed.
>> 
> 
> Not for Qcom, but some platforms do LTSSM during phy_init(), so they will fail
> if the device is not powered ON at that time.

Do you have a specific driver in mind?

> The challenge with the pwrctrl framework is that, it has to work across all
> platforms and with the existing drivers without major rework. The initial design
> worked for Qcom (somewhat), but I couldn't get it to scale across other
> platforms.

--Sean

