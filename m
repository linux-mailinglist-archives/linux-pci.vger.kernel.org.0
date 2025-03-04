Return-Path: <linux-pci+bounces-22908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D5A4EEF9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0486B3ACBDF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92695276038;
	Tue,  4 Mar 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaKZp4pl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFE13B58B;
	Tue,  4 Mar 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122084; cv=none; b=r9UA1mQKrVvKwYvo6MZOL4LgvXJqImOUJICLrOKPxX6DJTpPsnryVUiqCdPXV8FkENRePDkJGx94fBZqCrqV31jdYyWF2mn4OgQ98NOmas38N88RcO632Nk9w1B1jMrtC5OTcv+HncRG0ScwBpZfFlyWONMVUpPJAN74QxrHN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122084; c=relaxed/simple;
	bh=wuSZUsJUBvvoVVqs5pexnapAelVoxNHgNy106DGrgsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nIE3cqDz26fmnc7fd6s+rJ4goR6f/mqTkDYV8cXb6LjsLcdtePBrdFR/70LoSDF8IAs0M1GcDVMNN4w/2y37kXFTMNtPiPSSa7awNygwAay9lWV2X3KYEO5UdR8ZLS1jp/NgGC47hpeas0JcvznwRH1cjD5go8Ya/KiFhtNgY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaKZp4pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0EC4CEE5;
	Tue,  4 Mar 2025 21:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741122083;
	bh=wuSZUsJUBvvoVVqs5pexnapAelVoxNHgNy106DGrgsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WaKZp4plvRf+flSK8OMx76i9ew3l3hxm7OcNuKEQKPgKzV6AMK0G09KFUQBqvyneA
	 cGYUMqkEO/tq2le0YNkFl1sAjc4UynkxUB82rY0ONgFkg6gcB5Qy36sqPDnqWRP0wR
	 tLSIWBHHzqCC2a+sNGSiDQ3pv0oGoCv8nBHuokOb4VjKTxeq6Vbh5xCuTEgMRStfg8
	 ERtbU4SW8SIbgLWsu/WpgYQHYvx7sh0h+7xBUsyVKvH/AFQFTgOTwsHzVIzHmBvXPe
	 qv/MhA0Wor99mduAYOxFNZsjvzuxr1EBLIvKy/7mMma2AULWWZzXrEhCnRGo+DQW+u
	 0xVHwBlo4MjIQ==
Date: Tue, 4 Mar 2025 15:01:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250304210122.GA257363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVVhdRjfVYZGg+0Yo6EV4P80No3kLxCL8+LyVjwywiWxYg@mail.gmail.com>

On Tue, Mar 04, 2025 at 10:19:07PM +0530, Naveen Kumar P wrote:
> On Tue, Mar 4, 2025 at 1:35 PM Naveen Kumar P
> <naveenkumar.parna@gmail.com> wrote:
> ...

> For this test run, I removed all three parameters (pcie_aspm=off,
> pci=nomsi, and pcie_ports=on) and booted with the following kernel
> command line arguments:
> 
> cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-6.13.0+ root=/dev/mapper/vg00-rootvol ro quiet
> "dyndbg=file drivers/pci/* +p; file drivers/acpi/bus.c +p; file
> drivers/acpi/osl.c +p"
> 
> This time, the issue occurred earlier, at 22998 seconds. Below is the
> relevant dmesg log during the ACPI_NOTIFY_BUS_CHECK event. The
> complete log is attached (dmesg_march4th_log.txt).
> 
> [22998.536705] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
> [22998.536753] ACPI: \_SB_.PCI0.RP01: ACPI: OSL: Scheduling hotplug
> event 0 for deferred handling
> [22998.536934] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired in
> hotplug_event()
> [22998.536972] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [22998.537002] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge in
> hotplug_event()
> [22998.537024] PCI READ: res=0, bus=01 dev=00 func=0 pos=0x00 len=4
> data=0x55551556
> [22998.537066] PCI READ: res=0, bus=01 dev=00 func=0 pos=0x00 len=4
> data=0x55551556

Fine again.

> [22998.537094] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in
> acpiphp_check_bridge()
> [22998.537155] ACPI: Device [PXSX] status [0000000f]
> [22998.537206] ACPI: Device [D015] status [0000000f]
> [22998.537276] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridge
> in hotplug_event()
> 
> sudo lspci -xxx -s 01:00.0 | grep 10:
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Obviously a problem.  Can you start including the whole
"lspci -x -s 01:00.0" output?  Obviously the Vendor ID reads above
worked fine.  I *assume* it's still fine here, and only the BARs are
zeroed out?

I assume you saw no new dmesg logs about config accesses to the device
before the lspci.  If you instrumented the user config accessors
(pci_user_read_config_*(), also in access.c), you should see those
accesses.

You could sprinkle some calls to early_dump_pci_device() through the
acpiphp path.  Turn off the kernel config access tracing when you do
this so it doesn't clutter things up.

What is this device?  Is it a shipping product?  Do you have good
confidence that the hardware is working correctly?  I guess you said
it works correctly on a different machine with an older kernel.  I
would swap the cards between machines in case one card is broken.

You could try bisecting between the working kernel and the broken one.
It's kind of painful since it takes so long to reproduce the problem.

Bjorn

