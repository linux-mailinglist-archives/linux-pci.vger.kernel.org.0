Return-Path: <linux-pci+bounces-3987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D717862DDB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF541B2113F
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB761B964;
	Sun, 25 Feb 2024 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq/fAVTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE1F4E2;
	Sun, 25 Feb 2024 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708903879; cv=none; b=U4p8wATYDpOJzqNYQXY1nChZVTFEJ6CkhbDiz1CLYdkdsWOdriQG+Sr8bs8ZDLKp4KIZZdPA2oL9LnVxouVJXYUNsaOLpqNJkFwZIzhUSUtgi6pKKNSqi0lnf5QbCCdGBhe//U8VRqEjEpX7C8oNSkWRZ2Xn7DwCiI8J5cWryjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708903879; c=relaxed/simple;
	bh=TbxzeZ8sr0SCHJTwO50V30gxXl71Vbx2+YRNa0UVFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hcXMS++gUhReCJFGneBe/KwuJ7Et3RRbDJSnFh7/0mbMfY/wVvBcSj7Bjp+zW+DrzEM6fdbaTYirh0cw4FXULG8fIz8B6iHMHYng/CHiDCwsDtcCHQckpHI8f8nJm0iAId6rd3l0IwMYfZOlGO6gv05B5shFnRgNCJlCe1bd+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq/fAVTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B83FC433F1;
	Sun, 25 Feb 2024 23:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708903879;
	bh=TbxzeZ8sr0SCHJTwO50V30gxXl71Vbx2+YRNa0UVFOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dq/fAVTZ6iAgKtBJo3P6myJRosH7aR37MtMvD7EdxvP9F/9To51YWYAKnh6dWBexP
	 Flm5lk21GANBtOY4mUkBjayhWBEewHBiVvnZmomW6y1eoamA8bPypHQqyuXKNmD6CI
	 X5UgiISXVYYiaEs1F9MrBClXcBikwNvPOPeq/kWZ/9clJT8orAh7utURfRbOTJ+/t+
	 V19uD0xclhnVTBwkPDPqDFgdWyKuNOuGQXlkBjGA+cGGr9a72ca0kqR96ijdiQq0T3
	 qvdfAAfq9/mb8lb9oUxKOA17xNBSDeIuj6AfLcLQ7dRJZgrN+W4cTRuUJY7BjnF7hc
	 FVFND2HqY6G8Q==
Date: Sun, 25 Feb 2024 17:31:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mathias De Weerdt <mathias.de.weerdt@gmail.com>
Cc: ben.chuang@genesyslogic.com.tw, johnsonm@danlj.org,
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Bug Report: Delayed Wake from Suspend with Genesys Logic GL9755
 SD Host Controller
Message-ID: <20240225233117.GA182018@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfmkPKW=cD88D-cYJUaoN0A6i91C5ukiy6AYYWpNbW8VBQaGA@mail.gmail.com>

On Sun, Feb 25, 2024 at 11:38:35PM +0100, Mathias De Weerdt wrote:
> Hi
> 
> I am writing to report a potential bug in the Linux kernel related to
> waking from suspend on a system(Laptop) with a Genesys Logic GL9755 SD
> Host Controller. Below are the details of the issue:

Hi Mathias, thanks very much for this report.  A few questions below.

> Issue Description:
> After suspending the system, waking it up takes an extended amount of
> time, typically 1 to 2 minutes. The delay occurs consistently and is
> observed in the dmesg logs.
> 
> 
> System Information:
> - OS: Arch Linux x86_64
> - Kernel: 6.7.5-arch1-1 and 6.7.6-arch1-1
> - SD Host Controller: Genesys Logic GL9755 SD Host Controller (PCI ID:
> 17a0:9755)
>
> Observed Logs (dmesg):
> [ 642.483972] sdhci-pci 0000:2f:00.0: not ready 1023ms after resume; waiting
> [ 643.537370] sdhci-pci 0000:2f:00.0: not ready 2047ms after resume; waiting
> [ 645.724028] sdhci-pci 0000:2f:00.0: not ready 4095ms after resume; waiting
> [ 649.990655] sdhci-pci 0000:2f:00.0: not ready 8191ms after resume; waiting
> [ 658.310658] sdhci-pci 0000:2f:00.0: not ready 16383ms after resume; waiting
> [ 675.590673] sdhci-pci 0000:2f:00.0: not ready 32767ms after resume; waiting
> [ 709.723965] sdhci-pci 0000:2f:00.0: not ready 65535ms after resume; giving up
> [ 709.724183] sdhci-pci 0000:2f:00.0: Unable to change power state
> from D3cold to D0, device inaccessible
>
> [ 709.931501] mmc0: enable PCI MSI failed, error=-22
> [ 710.031516] mmc0: Reset 0x1 never completed.
> [ 710.031519] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 710.031522] mmc0: sdhci: Sys addr: 0xffffffff | Version: 0x0000ffff
> [ 710.031525] mmc0: sdhci: Blk size: 0x0000ffff | Blk cnt: 0x0000ffff
> [ 710.031527] mmc0: sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> [ 710.031529] mmc0: sdhci: Present: 0xffffffff | Host ctl: 0x000000ff
> [ 710.031532] mmc0: sdhci: Power: 0x000000ff | Blk gap: 0x000000ff
> [ 710.031534] mmc0: sdhci: Wake-up: 0x000000ff | Clock: 0x0000ffff
> [ 710.031536] mmc0: sdhci: Timeout: 0x000000ff | Int stat: 0xffffffff
> [ 710.031539] mmc0: sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> [ 710.031541] mmc0: sdhci: ACmd stat: 0x0000ffff | Slot int: 0x0000ffff
> [ 710.031543] mmc0: sdhci: Caps: 0xffffffff | Caps_1: 0xffffffff
> [ 710.031545] mmc0: sdhci: Cmd: 0x0000ffff | Max curr: 0xffffffff
> [ 710.031547] mmc0: sdhci: Resp[0]: 0xffffffff | Resp[1]: 0xffffffff
> [ 710.031549] mmc0: sdhci: Resp[2]: 0xffffffff | Resp[3]: 0xffffffff
> [ 710.031551] mmc0: sdhci: Host ctl2: 0x0000ffff
> [ 710.031554] mmc0: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffffffffffff
> [ 710.031555] mmc0: sdhci: ============================================

Reads to a device in D3cold (powered off) cause PCI errors, which
typically result in ~0 return values like this.

> [ 710.031558] sdhci-pci 0000:2f:00.0: PM: dpm_run_callback():
> pci_pm_resume+0x0/0xf0 returns -22
> [ 710.031567] sdhci-pci 0000:2f:00.0: PM: failed to resume async: error -22
> ...
> [ 710.823719] random: crng reseeded on system resumption
> [ 710.829332] mmc0: 3.3V regulator output did not become stable
> [ 710.860354] PM: suspend exit
> [ 710.974677] mmc0: Controller never released inhibit bit(s).
> [ 710.974690] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 710.974698] mmc0: sdhci: Sys addr: 0xffffffff | Version: 0x0000ffff
> [ 710.974709] mmc0: sdhci: Blk size: 0x0000ffff | Blk cnt: 0x0000ffff
> [ 710.974712] mmc0: sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> [ 710.974715] mmc0: sdhci: Present: 0xffffffff | Host ctl: 0x000000ff
> [ 710.974717] mmc0: sdhci: Power: 0x000000ff | Blk gap: 0x000000ff
> [ 710.974720] mmc0: sdhci: Wake-up: 0x000000ff | Clock: 0x0000ffff
> [ 710.974723] mmc0: sdhci: Timeout: 0x000000ff | Int stat: 0xffffffff
> [ 710.974725] mmc0: sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> [ 710.974728] mmc0: sdhci: ACmd stat: 0x0000ffff | Slot int: 0x0000ffff
> [ 710.974731] mmc0: sdhci: Caps: 0xffffffff | Caps_1: 0xffffffff
> [ 710.974733] mmc0: sdhci: Cmd: 0x0000ffff | Max curr: 0xffffffff
> [ 710.974736] mmc0: sdhci: Resp[0]: 0xffffffff | Resp[1]: 0xffffffff
> [ 710.974738] mmc0: sdhci: Resp[2]: 0xffffffff | Resp[3]: 0xffffffff
> [ 710.974740] mmc0: sdhci: Host ctl2: 0x0000ffff
> [ 710.974743] mmc0: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffffffffffff
> [ 710.974744] mmc0: sdhci: ============================================
> [ 711.074847] mmc0: Reset 0x2 never completed.
> ...
> 
> 
> Additional Information:
> - The delay persists even after attempting to blacklist the driver
> (sdhci_pci). Using modprobe or kernel parameters.
> - Secure boot and fast boot are disabled.
> - There are no additional sleep state or configuration options in the BIOS.
> - Output of `cat /sys/power/mem_sleep`: [s2idle] deep
> 
> 
> Hardware Details:
> 2f:00.0 SD Host controller [0805]: Genesys Logic, Inc GL9755 SD Host
> Controller [17a0:9755] (rev 01)
> Subsystem: ASUSTeK Computer Inc. GL9755 SD Host Controller [1043:202f]
> Kernel driver in use: sdhci-pci
> Kernel modules: sdhci_pci
> 
> 
> Please let me know if there is any additional information needed from
> my side to diagnose or resolve this issue. I am willing to provide any
> log files or assist in testing patches.

I assume this has never worked well, right?  If it *has* worked better
on an older kernel, this would be a regression, and it would be very
helpful to know the newest kernel that works better, and we could
bisect between that and the broken kernel.

Can you please collect the complete dmesg log and the output of "sudo
lspci -vvxxxx" after waking the system?  These will have some details
about the firmware that is probably involved in changing the power
state from D3cold to D0, and also any errors logged when we try to
read from the device.

You can open a report at https://bugzilla.kernel.org and attach the
logs there if they're too large for the mailing lists
(http://vger.kernel.org/majordomo-info.html).

Bjorn

