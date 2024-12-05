Return-Path: <linux-pci+bounces-17812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8B9E6149
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A37C16A35F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02871CDA1A;
	Thu,  5 Dec 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deFtp5ye"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639C1CDA15;
	Thu,  5 Dec 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441343; cv=none; b=EuqJFU+d4AOA51KdVcBLMW4a5WmUD0q7dc80/7DAKMyEyoVIfO7KwtjoNF/Zdw1XPS/QgQytlSbDdk2mHZr5UYzkD3CDlr7siAWhRNrKy6NmoLQEmpb48qzEPkbMv8NSRBlZdojcvZXDYObJDcXt66wp5X2aAcAbCV+x3XGYUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441343; c=relaxed/simple;
	bh=+bqKJcKuzym60bZGjQJ4GJHjOSqCprR+fLaTkzPT5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FqUHBHza5gOinLnTEM/I4ppUfSUIK6KT6dqiQgAE5zJxsMastOYYVMnlNtZ2pGcmKSkWZxqy34BsQ8mDRc+7kuEpVJrP47Qf8rc//caspnM3DW/FrDzafHG81MVSbjRftABvhzpmXe9Rw4O0ffouVlYLbdw26bzTkxfV5zU6DdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deFtp5ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D2C4CED1;
	Thu,  5 Dec 2024 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733441343;
	bh=+bqKJcKuzym60bZGjQJ4GJHjOSqCprR+fLaTkzPT5Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=deFtp5yecINLqt7hqACqQZa9xtYMkfvZ3pYK9207V2ZF5/fe01hdz8xJoILkxKsmg
	 ot4TK+2A2p464xs/eMmyVle+Yq3PlX9Cup71VwZdzSFJ16+SDADdexq2dCK1tJckbc
	 tI+alEjKL9qFJmwOBaa1TtSeF8CTgxLAe1gZvo9vJ5ULyDqI9TAjlicQJlU1tWfJ+m
	 1Uoj5QSBDEzWRnwZmnoM0oGbRN/owKjCrlVJjahrRUDtprmIlTY1bzjGykqyTaKbIl
	 hKjtEBnOve0/h+w05KpIWRq/cEr0p0jdTLpG2bVuU3hUv52rYnrByxGAosDpoFPWfT
	 LYDR4dPqTqMxg==
Date: Thu, 5 Dec 2024 17:29:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241205232900.GA3072557@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123090113.semecglxaqjvlmzp@thinkpad>

On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > PCI core allows users to configure the D3Cold state for each PCI
> > > device through the sysfs attribute
> > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > allow/disallow the PCI devices to enter D3Cold during system
> > > suspend.
> > >
> > > So make use of this flag in the NVMe driver to shutdown the NVMe
> > > device during system suspend if the user has allowed D3Cold for
> > > the device.  Existing checks in the NVMe driver decide whether
> > > to shut down the device (based on platform/device limitations),
> > > so use this flag as the last resort to keep the existing
> > > behavior.
> > > 
> > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to
> > > allow D3Cold and the users can disallow it through sysfs if they
> > > want.
> > 
> > What problem does this solve?  I guess there must be a case where
> > suspend leaves NVMe in a higher power state than you want?
> 
> Yeah, this is the case for all systems that doesn't fit into the
> existing checks in the NVMe suspend path:
> 
> 1. ACPI based platforms
> 2. Controller doesn't support NPSS (hardware issue/limitation)
> 3. ASPM not enabled
> 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> 
> In my case, all the Qualcomm SoCs using Devicetree doesn't fall into
> the above checks. Hence, they were not fully powered down during
> system suspend and always in low power state. This means, I cannot
> achieve 'CX power collapse', a Qualcomm specific SoC powered down
> state that consumes just enough power to wake up the SoC. Since the
> controller driver keeps the PCI resource vote because of NVMe, the
> firmware in the Qualcomm SoCs cannot put the SoC into above
> mentioned low power state.

IIUC nvme_suspend() has two paths:

  - Do nvme_disable_prepare_reset() without calling pci_save_state(),
    so the PCI core chooses and sets the low-power state.

  - Put the device in an NVMe-specific low-power state and call
    pci_save_state(), which prevents the PCI core from putting the
    device in a low-power state.

    (The PCI core part is in pci_pm_suspend_noirq(),
    pci_pm_poweroff_noirq(), pci_pm_runtime_suspend())

And I guess you want the first path for basically all systems?  The
only systems that would use the NVMe-specific path are those where:

  - !pm_suspend_via_firmware() (not an ACPI system), AND

  - ctrl->npss (device supports NVMe power states), AND

  - pcie_aspm_enabled(), AND

  - !NVME_QUIRK_SIMPLE_SUSPEND (it's not something with a weird
    quirk), AND

  - !pdev->d3cold_allowed (user has cleared it via sysfs)

This frankly seems almost unintelligible to me, so I'm glad I'm not
responsible for nvme :)

> > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > your underlying intent.  It suggests that you're really hoping for
> > D3cold, but that's only a possibility if firmware supports it, and
> > we have no visibility into that here.
> 
> I'm not relying on firmware to do anything here. If firmware has to
> decide the suspend state, it should already satisfy the
> pm_suspend_via_firmware() check in nvme_suspend(). ...

I'm confused about this because we want to use PCI core power
management, which chooses the new state with pci_target_state(),
which looks like it will choose D3hot unless we're on an ACPI system
and acpi_pci_choose_state() returns D3cold.

But your system is not an ACPI system, so we should get D3hot, but yet
you decide based on D3*cold* being allowed?

> Here, the controller driver takes care of putting the device into
> D3Cold.  Currently, the controller drivers cannot do it (on DT
> platforms) because of NVMe driver's behavior.

I'm missing the connection to the controller driver (I assume you mean
qcom-pcie?).  Maybe it's that having the NVMe device in a PCI
low-power state allows qcom_pcie_suspend_noirq() to reduce the ICC
bandwidth vote and do other power-saving things?  And it can't do
those things if we're using the NVMe low-power state because that
state is not visible to qcom-pcie?

> We did attempt to solve this problem in multiple ways, but the
> lesson learned was, kernel cannot decide the power mode without help
> from userspace. That's the reason I wanted to make use of this
> 'd3cold_allowed' sysfs attribute to allow userspace to override the
> D3Cold if it wants based on platform requirement.

It seems sub-optimal that this only works how you want if the user
intervenes.

Bjorn

