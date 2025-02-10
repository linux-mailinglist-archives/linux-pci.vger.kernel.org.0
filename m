Return-Path: <linux-pci+bounces-21070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49559A2E7AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77005165B7B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6121BBBEA;
	Mon, 10 Feb 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKXs6sGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C1B6D15;
	Mon, 10 Feb 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179871; cv=none; b=Cc+goNSeu56UP0rF8u1kqmQQPHj2rvx+WL8ctWnhUCf0ftwpugJ3Qd7HwIkzkevER22RN0CvRQiQlHtaEwNo0h4X5B8YzTdnubz/9H2PIGzXOSMGRegmjZtX4dau580UkyIMFQN2Nm5vnKg5VeogZwKy52EuXQJWJddpqeQ+X4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179871; c=relaxed/simple;
	bh=O/Apf2r3Dy0nYmcAbhSbZKz87qTC9QnkOtulYjPqpjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad2z+qqatV7yR7XuukZri0/6ajzVkGDvlsMzCfk09O+WGipJNHUFM3f+kkJmT8L+xPNxktfXZkk/LLz36K6xPFzoTuUBNoZd9HdmNGfEez70cq5azbK6KsV15YyZLKVRQti57O7X3Y+VUnxr1GFbix4LI4pxyhHk5ty9F3xDcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKXs6sGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF28AC4CED1;
	Mon, 10 Feb 2025 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739179869;
	bh=O/Apf2r3Dy0nYmcAbhSbZKz87qTC9QnkOtulYjPqpjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKXs6sGUHrULwmqHoUwS4vYo/Os0O0RVFK58K1VJeDelwkSI+RhNo89tkGDdNVPr7
	 il1Shjfv2n2KhaGGDpmpZJovb2fXTy9sa1wnkYNygwkCXW773jke42l50BBFePQv2j
	 /Uaf1pCDWmd/Rpu7oOztstkjDLxvQ9iHIBWt91y3yWJ7/YwMROpdU5iv3l62mPRhWi
	 Gc/Xn0F+PQi8zxhAYfHDum8gN6CpdbiV8E6NdkGGlg+X63GjSJZXN5AuYFcbhRzMb3
	 WA7z0kFnKBXz3g0bEYUYc+VJDVHTM1wOx5NWgrj/IAX45Zf4wiWn4WQb26+f4hk8uz
	 oRT4kOCLbL7kw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1thQ8I-000000002H4-3Riw;
	Mon, 10 Feb 2025 10:31:15 +0100
Date: Mon, 10 Feb 2025 10:31:14 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1] PM: sleep: core: Restrict power.set_active propagation
Message-ID: <Z6nHYtn5TEJlTQZs@hovoldconsulting.com>
References: <6137505.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6137505.lOV4Wx5bFT@rjwysocki.net>

On Sat, Feb 08, 2025 at 06:54:28PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of
> parents and children") exposed an issue related to simple_pm_bus_pm_ops
> that uses pm_runtime_force_suspend() and pm_runtime_force_resume() as
> bus type PM callbacks for the noirq phases of system-wide suspend and

Despite the name of the driver these are plain device driver PM
callbacks (not bus PM ops).

> resume.
> 
> The problem is that pm_runtime_force_suspend() does not distinguish
> runtime-suspended devices from devices for which runtime PM has never
> been enabled, so if it sees a device with runtime PM status set to
> RPM_ACTIVE, it will assume that runtime PM is enabled for that device
> and so it will attempt to suspend it with the help of its runtime PM
> callbacks which may not be ready for that.  As it turns out, this 
> causes simple_pm_bus_runtime_suspend() to crash due to a NULL pointer
> dereference.
> 
> Another problem related to the above commit and simple_pm_bus_pm_ops is
> that setting runtime PM status of a device handled by the latter to
> RPM_ACTIVE will actually prevent it from being resumed because
> pm_runtime_force_resume() only resumes devices with runtime PM status
> set to RPM_SUSPENDED.
> 
> To mitigate these issues, do not allow power.set_active to propagate
> beyond the parent of the device with DPM_FLAG_SMART_SUSPEND set that
> will need to be resumed, which should be a sufficient stop-gap for the
> time being, but they will need to be properly addressed in the future
> because in general during system-wide resume it is necessary to resume
> all devices in a dependency chain in which at least one device is going
> to be resumed.

So this works as long as no parent of a device with
DPM_FLAG_SMART_SUSPEND set is using pm_runtime_force_resume().

This is the case in the systems I work on, but have you
verified that this is currently generally true? Not many drivers use
this flag, but it all depends on what their devices' parents' drivers
do:

	drivers/acpi/acpi_tad.c
	drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
	drivers/i2c/busses/i2c-designware-platdrv.c
	drivers/mfd/intel-lpss.c
	drivers/pci/pcie/portdrv.c
	drivers/pwm/pwm-lpss-platform.c
	drivers/soundwire/intel_auxdevice.c

Most of these look like ACPI drivers so nothing that would sit directly
on a simple-pm-bus at least.

> Fixes: 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of parents and children")
> Closes: https://lore.kernel.org/linux-pm/1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com/
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Johan

