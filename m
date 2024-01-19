Return-Path: <linux-pci+bounces-2365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF6832C2A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CA71C2133F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F654729;
	Fri, 19 Jan 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MchuSsS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AC5467F;
	Fri, 19 Jan 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677189; cv=none; b=cB/nQQR2Iob7w3r78IdAoxjPEpRbP8gv8yryyhL4UrYzd6FO1flbYMkcCJNraeKNPH8ADFs0013bpBgcUVarNcQ8v2AHQ6j/UNc3MIJfGRMv5Z+dtCibEVV2xR5Pb+Ru1kWPmr0EDbTOjgXywguPychG1DCZ609jSLzeEo3yXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677189; c=relaxed/simple;
	bh=3Qse2z0ZQniKsPfRSELAkjSkIbwmbKfeUdpJO4Djp+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CYuppzpN84ppUk+rtUGe4tHbgD8SN1IeYIWWI/UvwnzK8XNLSamk4qY/aw3vAIbAMPOsa4AQ57KLhm51KMDFamyLhZ/lXAkiKhiGEwHqU4xzWUYxZ536BACHfz2QZ2ijYi2pX2//CfGjaczCZCw1Qj2LNq9nMtAEVhINRNN2ldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MchuSsS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE610C433C7;
	Fri, 19 Jan 2024 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705677189;
	bh=3Qse2z0ZQniKsPfRSELAkjSkIbwmbKfeUdpJO4Djp+o=;
	h=Date:From:To:Cc:Subject:From;
	b=MchuSsS3PyGvBjy2JQJute6sT3sISHl/DJ973FDD+uVpNB4SIiqMHexHZGxq3lKpP
	 Wz8XnindyIr4yzcLZasNqvhUxMDN9iKIEpzimW/FxNiIUfi6ZxglXsQNJ/kJwF5/8q
	 1Zb2AInIy2LLFeyARGwkZDUSq1StLVWyJeF6K8CULPsW5E9Xydb17jfQqaaeLTx4vn
	 i5dk/zlsdM2ImpMyUbAVw0lNd3VdlwBHEruwWnZ3E63JCAZGlUYl3v2atR2GMbWE+U
	 DSIi/CkF3ggSs864f5BnOV7QUuT6bc/ZWcl4yi8h8HM+G3snWSeQKzUYkLjXt00cuh
	 klqpa8ddVSOng==
Date: Fri, 19 Jan 2024 09:13:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [bugzilla-daemon@kernel.org: [Bug 218394] New: Enabled VMD on ASUS
 B1400CEAE blocks going to deeper CPU Package C-state when s2idle]
Message-ID: <20240119151307.GA178604@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[Thanks very much for the report.  Forwarding to some VMD and power
management folks and the mailing lists because most people don't
monitor bugzilla.  More info in bugzilla attachments.]

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Fri, 19 Jan 2024 04:04:59 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 218394] New: Enabled VMD on ASUS B1400CEAE blocks going to deeper
	CPU Package C-state when s2idle
Message-ID: <bug-218394-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=218394

           Summary: Enabled VMD on ASUS B1400CEAE blocks going to deeper
                    CPU Package C-state when s2idle
          Hardware: Intel

Created attachment 305728
  --> https://bugzilla.kernel.org/attachment.cgi?id=305728&action=edit
The kernel log with enabled VMD and s2idle

We have an ASUS B1400CEAE laptop equipped with Intel i3-1115G4 CPU and Sandisk
Corp WD Blue SN550 NVMe SSD.

Tested with kernel 6.7 and we found the system consumes DC battery's power
quickly when s2idle, if the Intel® RST VMD is enabled.  The battery only
survives few hours.  After that, system cannot wake up because the battery is
drained out.

However, if the VMD is disabled, the battery has 90% energy left after s2idle
24 hours.

The BIOS has already been updated to latest version 314 from ASUS website.

I also checked with S0ixSelftestTool.
* If VMD is disabled, it shows "Congratulations! Your system achieved the
deepest S0ix substate!"
* If VMD is enabled, here is the test output:


---Check S2idle path S0ix Residency---:

The system OS Kernel version is:
Linux endless 6.7.0+ #97 SMP PREEMPT_DYNAMIC Thu Jan 18 16:52:17 CST 2024
x86_64 GNU/Linux

---Check whether your system supports S0ix or not---:

Low Power S0 Idle is:1
Your system supports low power S0 idle capability.



---Check whether intel_pmc_core sysfs files exit---:

The pmc_core debug sysfs files are OK on your system.



---Judge PC10, S0ix residency available status---:

Test system supports S0ix.y substate

S0ix substate before S2idle:
  S0i2.0

S0ix substate residency before S2idle:
  0

Turbostat output: 
15.791949 sec
CPU%c1  CPU%c6  CPU%c7  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9
Pk%pc10 SYS%LPI
2.81    0.00    94.93   659.86  91.61   0.00    0.00    0.00    0.00    0.00   
0.00    0.00
3.84    0.00    93.93   659.92  91.62   0.00    0.00    0.00    0.00    0.00   
0.00    0.00
2.62
3.26    0.00    95.93
1.51

CPU Core C7 residency after S2idle is: 94.93
GFX RC6 residency after S2idle is: 659.86
CPU Package C-state 2 residency after S2idle is: 91.61
CPU Package C-state 3 residency after S2idle is: 0.00
CPU Package C-state 8 residency after S2idle is: 0.00
CPU Package C-state 9 residency after S2idle is: 0.00
CPU Package C-state 10 residency after S2idle is: 0.00
S0ix residency after S2idle is: 0.00

Your system achieved PC2 residency: 91.61, but no PC8 residency during S2idle:
0.00

---Debug no PC8 residency scenario---:
modprobe cpufreq_stats failedLoaded 0 prior measurements
Cannot load from file /var/cache/powertop/saved_parameters.powertop
File will be loaded after taking minimum number of measurement(s) with battery
only 
RAPL device for cpu 0
RAPL Using PowerCap Sysfs : Domain Mask d
RAPL device for cpu 0
RAPL Using PowerCap Sysfs : Domain Mask d
Devfreq not enabled
glob returned GLOB_ABORTED
Cannot load from file /var/cache/powertop/saved_parameters.powertop
File will be loaded after taking minimum number of measurement(s) with battery
only 
Leaving PowerTOP

Turbostat output: 

16.186215 sec
CPU%c1  CPU%c6  CPU%c7  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9
Pk%pc10 SYS%LPI
2.52    0.00    95.42   783.82  91.97   0.35    0.00    0.00    0.00    0.00   
0.00    0.00
0.88    0.00    95.37   783.93  91.98   0.35    0.00    0.00    0.00    0.00   
0.00    0.00
4.05
1.22    0.00    95.47
3.92

Your CPU Core C7 residency is available: 95.42

Your system Intel graphics RC6 residency is available:783.82

Checking PCIe Device D state and Bridge Link state:

Available bridge device: 0000:00:07.0

0000:00:07.0 Link is in Detect

The link power management state of PCIe bridge: 0000:00:07.0 is OK.

Your system default pcie_aspm policy setting is OK.

Here is D3 log:
 [  151.977362] nvme 10000:e1:00.0: PCI PM: Suspend power state: D0
[  151.977365] nvme 10000:e1:00.0: PCI PM: Skipped
[  151.977426] pcieport 10000:e0:06.0: PCI PM: Suspend power state: D0
[  151.977429] pcieport 10000:e0:06.0: PCI PM: Skipped
[  151.989417] ahci 10000:e0:17.0: PCI PM: Suspend power state: D3hot
[  151.989577] sof-audio-pci-intel-tgl 0000:00:1f.3: PCI PM: Suspend power
state: D3hot
[  151.989583] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
[  152.000784] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
[  152.000785] i801_smbus 0000:00:1f.4: PCI PM: Skipped
[  152.013242] e1000e 0000:00:1f.6: PCI PM: Suspend power state: D3hot
[  152.014780] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
[  152.014784] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
[  152.014790] iwlwifi 0000:00:14.3: PCI PM: Suspend power state: D3hot
[  152.014795] proc_thermal 0000:00:04.0: PCI PM: Suspend power state: D3hot
[  152.014959] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
[  152.015075] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
[  152.018464] xhci_hcd 0000:00:0d.0: PCI PM: Suspend power state: D3cold
[  152.023926] pcieport 0000:00:07.0: PCI PM: Suspend power state: D3cold
[  152.055546] thunderbolt 0000:00:0d.2: PCI PM: Suspend power state: D3cold

Checking PCI Devices D3 States:
[  151.977362] nvme 10000:e1:00.0: PCI PM: Suspend power state: D0
[  151.977365] nvme 10000:e1:00.0: PCI PM: Skipped
[  151.977426] pcieport 10000:e0:06.0: PCI PM: Suspend power state: D0
[  151.977429] pcieport 10000:e0:06.0: PCI PM: Skipped
[  151.989417] ahci 10000:e0:17.0: PCI PM: Suspend power state: D3hot
[  151.989577] sof-audio-pci-intel-tgl 0000:00:1f.3: PCI PM: Suspend power
state: D3hot
[  151.989583] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
[  152.000784] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
[  152.000785] i801_smbus 0000:00:1f.4: PCI PM: Skipped
[  152.013242] e1000e 0000:00:1f.6: PCI PM: Suspend power state: D3hot
[  152.014780] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
[  152.014784] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
[  152.014790] iwlwifi 0000:00:14.3: PCI PM: Suspend power state: D3hot
[  152.014795] proc_thermal 0000:00:04.0: PCI PM: Suspend power state: D3hot
[  152.014959] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
[  152.015075] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
[  152.018464] xhci_hcd 0000:00:0d.0: PCI PM: Suspend power state: D3cold
[  152.023926] pcieport 0000:00:07.0: PCI PM: Suspend power state: D3cold
[  152.055546] thunderbolt 0000:00:0d.2: PCI PM: Suspend power state: D3cold


Checking PCI Devices tree diagram:
-+-[0000:00]-+-00.0  Intel Corporation Device 9a04
 |           +-02.0  Intel Corporation Tiger Lake-LP GT2 [UHD Graphics G4]
 |           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning Processor
Participant
 |           +-06.0  Intel Corporation RST VMD Managed Controller
 |           +-07.0-[01-2b]--
 |           +-08.0  Intel Corporation GNA Scoring Accelerator module
 |           +-0a.0  Intel Corporation Tigerlake Telemetry Aggregator Driver
 |           +-0d.0  Intel Corporation Tiger Lake-LP Thunderbolt 4 USB
Controller
 |           +-0d.2  Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #0
 |           +-0e.0  Intel Corporation Volume Management Device NVMe RAID
Controller
 |           +-14.0  Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1 xHCI Host
Controller
 |           +-14.2  Intel Corporation Tiger Lake-LP Shared SRAM
 |           +-14.3  Intel Corporation Wi-Fi 6 AX201
 |           +-15.0  Intel Corporation Tiger Lake-LP Serial IO I2C Controller
#0
 |           +-15.1  Intel Corporation Tiger Lake-LP Serial IO I2C Controller
#1
 |           +-16.0  Intel Corporation Tiger Lake-LP Management Engine
Interface
 |           +-17.0  Intel Corporation RST VMD Managed Controller
 |           +-1f.0  Intel Corporation Tiger Lake-LP LPC Controller
 |           +-1f.3  Intel Corporation Tiger Lake-LP Smart Sound Technology
Audio Controller
 |           +-1f.4  Intel Corporation Tiger Lake-LP SMBus Controller
 |           +-1f.5  Intel Corporation Tiger Lake-LP SPI Controller
 |           \-1f.6  Intel Corporation Ethernet Connection (13) I219-V
 \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
              \-17.0  Intel Corporation Tiger Lake-LP SATA Controller

pcieport 10000:e0:06.0: PCI PM: Suspend power state: D0 pcieport 10000:e0:06.0:
PCI PM: Skipped pcieport 0000:00:07.0: PCI PM: Suspend power state: D3cold
The pcieport 10000:e0:06.0 ASPM enable status:
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+

Pcieport is not in D3cold：          
10000:e0:06.0

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

