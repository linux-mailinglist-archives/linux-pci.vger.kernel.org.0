Return-Path: <linux-pci+bounces-4923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F38809EC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 03:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE85F287DFB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50143224C9;
	Wed, 20 Mar 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H63+pJAd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C493219E8
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902810; cv=none; b=OrQYg5rxGPHGBLVlmUdRBXQu43lJuaCGvivY6plT3wWRn/KMNrH2EXWRfM78bTSn3nXN8EVoF/apYD5CbMHjQS9yjrquoTIlYUSnVSwiqBAmcjhYSz5qYYvuXTjzVLC+K3jC6msrRjgA/s4T2X0jGCoKUugIPsgGkxVVJg+5SDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902810; c=relaxed/simple;
	bh=L66GwVok0J/RkCLE/PBj3+ntBUCik2UyckZBSCMLNng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SeUwExkuhJJpb6XJ0JB3YCYsILXXu65/YLAR41j78H2L95kcYp4xCDnZtA2jqeMahOzyC28XrbES8fWLbCzszCQGHmyZ6lCz3m6tFZHnnxnWoxcFrqym8IeQ4bD1xMQJiepR76MRA+WQreX6cP6mFWe5AFG1fNAcu4tu63NY/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H63+pJAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CEC433F1;
	Wed, 20 Mar 2024 02:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710902809;
	bh=L66GwVok0J/RkCLE/PBj3+ntBUCik2UyckZBSCMLNng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H63+pJAdve05LninXqqVOqhbX2Ue8gFXxqultJp4nUsUkbTBUML8u4Co9wnwRQQVd
	 6ncxe2fDUkYDS5WJiCltCftSxQVibDSzOLikEIHUh/Ua7vYdr8i8MmbarVioA0nPaJ
	 xvcAcIcUlvbjtsZ0qVRKmgel93BnOYGfoJ/lDHcb7xSYBrl80d5w03h6RPRMBS2U2e
	 o2C1+49OoHFfu9FGWJi0+1g1bs2OUNyvHsfzw9q0OQg5wcnq2UZJMj90amuFRi4ync
	 r/7wdwBeGkuS2E8AGyY4XtmoPcHsYcjuwLTLyoSEWBQFYbxQPb5ZfMp7yMZnSsIuIX
	 XAy0rm3n18xHQ==
Date: Tue, 19 Mar 2024 21:46:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Changhui Zhong <czhong@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236
 pci_disable_device+0xf4/0x100
Message-ID: <20240320024647.GA1254126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGVVp+WDQXvFB2xEs=8pU02qseVHCWJvEVv5RRZFQnHbJFa=cw@mail.gmail.com>

On Wed, Mar 20, 2024 at 10:16:06AM +0800, Changhui Zhong wrote:
> On Wed, Mar 20, 2024 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Mar 19, 2024 at 03:34:56PM +0800, Changhui Zhong wrote:
> > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > branch: master
> > > commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80
> >
> > Where's the rest of this?  I don't see "WARNING: CPU: 0 PID: 226 at
> > drivers/pci/pci.c:2236" in the snippet below.  Please include or post
> > the complete dmesg log.
> >
> > Is this reproducible?  If so, how?  And is it a regression?
> 
> it reproduceible，I can trigger it every time on my server，but I'm not
> sure if it is a regression，

Great, it's always easier if it's easily reproducible.  Can you please
try an older kernel, e.g., v6.8?

> dmesg log on my other server：

Please include or post the *complete* dmesg log all the way from the
very beginning of boot, not just the snippet you included below.  The
complete log contains useful information that we need to investigate
this problem.

> ```
> System Reboot
> .
> [  248.433904] watchdog: watchdog0: watchdog did not stop!
> [  258.459553] systemd-shutdown[1]: Waiting for process: 4506 (sleep),
> 4491 (rhts-reboot)
> [  338.521745] watchdog: watchdog0: watchdog did not stop!
> [  338.556096] dracut Warning: Killing all remaining processes
> dracut Warning: Killing all remaining processes
> [  338.589595] dracut Warning: Unmounted /oldroot.
> dracut Warning: Unmounted /oldroot.
> Rebooting.
> [  339.651690] {1}[Hardware Error]: Hardware error from APEI Generic
> Hardware Error Source: 5
> [  339.659948] {1}[Hardware Error]: event severity: recoverable
> [  339.665606] {1}[Hardware Error]:  Error 0, type: fatal
> [  339.670743] {1}[Hardware Error]:   section_type: PCIe error
> [  339.676310] {1}[Hardware Error]:   port_type: 0, PCIe end point
> [  339.682228] {1}[Hardware Error]:   version: 3.0
> [  339.686761] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
> [  339.692939] {1}[Hardware Error]:   device_id: 0000:04:00.0
> [  339.698427] {1}[Hardware Error]:   slot: 0
> [  339.702525] {1}[Hardware Error]:   secondary_bus: 0x00
> [  339.707664] {1}[Hardware Error]:   vendor_id: 0x14e4, device_id: 0x165f
> [  339.714278] {1}[Hardware Error]:   class_code: 020000
> [  339.719331] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
> aer_uncor_mask: 0x00010000
> [  339.727678] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
> [  339.733769] {1}[Hardware Error]:   TLP Header: 40000001 0000020f
> 90028090 00000000
> [  339.741353] tg3 0000:04:00.0: AER: aer_status: 0x00100000,
> aer_mask: 0x00010000
> [  339.748662] tg3 0000:04:00.0:    [20] UnsupReq               (First)
> [  339.755014] tg3 0000:04:00.0: AER: aer_layer=Transaction Layer,
> aer_agent=Requester ID
> [  339.762924] tg3 0000:04:00.0: AER: aer_uncor_severity: 0x000ef030
> [  339.769018] tg3 0000:04:00.0: AER:   TLP Header: 40000001 0000020f
> 90028090 00000000
> [  339.776761] ------------[ cut here ]------------
> [  339.781378] tg3 0000:04:00.0: disabling already-disabled device
> [  339.781386] WARNING: CPU: 0 PID: 358 at drivers/pci/pci.c:2236
> pci_disable_device+0xf4/0x100
> [  339.795737] Modules linked in: raid1 rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc ipmi_ssif
> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common i10nm_edac nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm vfat fat
> mgag200 rapl dax_hmem iTCO_wdt i2c_algo_bit cxl_acpi
> iTCO_vendor_support drm_shmem_helper intel_cstate acpi_ipmi ipmi_si
> mei_me cxl_core i2c_i801 dell_smbios isst_if_mmio isst_if_mbox_pci
> drm_kms_helper ipmi_devintf intel_uncore dcdbas mei einj
> intel_pch_thermal intel_vsec isst_if_common wmi_bmof
> dell_wmi_descriptor pcspkr i2c_smbus ipmi_msghandler acpi_power_meter
> drm fuse xfs libcrc32c sd_mod t10_pi sg crct10dif_pclmul ahci
> crc32_pclmul libahci crc32c_intel libata tg3 ghash_clmulni_intel wmi
> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> [  339.872243] CPU: 0 PID: 358 Comm: kworker/0:3 Not tainted 6.8.0+ #1
> [  339.878505] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
> 1.4.4 10/07/2021
> [  339.886157] Workqueue: events aer_recover_work_func
> [  339.891037] RIP: 0010:pci_disable_device+0xf4/0x100
> [  339.895917] Code: 4d 85 e4 75 07 4c 8b a3 c8 00 00 00 48 8d bb c8
> 00 00 00 e8 9e c7 17 00 4c 89 e2 48 c7 c7 50 92 21 91 48 89 c6 e8 ac
> 94 a1 ff <0f> 0b e9 3b ff ff ff e8 80 36 60 00 90 90 90 90 90 90 90 90
> 90 90
> [  339.914664] RSP: 0018:ff56179a82883d10 EFLAGS: 00010286
> [  339.919888] RAX: 0000000000000000 RBX: ff2f7c9b44e58000 RCX: ffffffff9171e4a8
> [  339.927022] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: 0000000000000001
> [  339.934154] RBP: ff2f7c9b65860000 R08: 0000000000000000 R09: ff56179a82883bc0
> [  339.941289] R10: ff56179a82883bb8 R11: ffffffff917de4e8 R12: ff2f7c9b445fa4e0
> [  339.948421] R13: 0000000000000002 R14: ff2f7c9b44e58148 R15: ff2f7c9b44e5d000
> [  339.955552] FS:  0000000000000000(0000) GS:ff2f7c9eaf600000(0000)
> knlGS:0000000000000000
> [  339.963640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  339.969385] CR2: 00007f7577713838 CR3: 0000000300a20003 CR4: 0000000000771ef0
> [  339.976519] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  339.983651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  339.990782] PKRU: 55555554
> [  339.993494] Call Trace:
> [  339.995949]  <TASK>
> [  339.998054]  ? __warn+0x7f/0x130
> [  340.001286]  ? pci_disable_device+0xf4/0x100
> [  340.005560]  ? report_bug+0x18a/0x1a0
> [  340.009227]  ? handle_bug+0x3c/0x70
> [  340.012719]  ? exc_invalid_op+0x14/0x70
> [  340.016559]  ? asm_exc_invalid_op+0x16/0x20
> [  340.020745]  ? pci_disable_device+0xf4/0x100
> [  340.025017]  ? __pfx_report_frozen_detected+0x10/0x10
> [  340.030069]  tg3_io_error_detected+0x1f5/0x2b0 [tg3]
> [  340.035044]  ? __pfx_report_frozen_detected+0x10/0x10
> [  340.040098]  report_error_detected+0xc7/0x1c0
> [  340.044456]  ? __pfx_report_frozen_detected+0x10/0x10
> [  340.049509]  __pci_walk_bus+0x6b/0xb0
> [  340.053176]  ? __pfx_aer_root_reset+0x10/0x10
> [  340.057535]  pcie_do_recovery+0x2b4/0x3c0
> [  340.061548]  aer_recover_work_func+0x106/0x110
> [  340.065992]  process_one_work+0x193/0x3d0
> [  340.070005]  worker_thread+0x2fc/0x410
> [  340.073758]  ? __pfx_worker_thread+0x10/0x10
> [  340.078032]  kthread+0xdc/0x110
> [  340.081179]  ? __pfx_kthread+0x10/0x10
> [  340.084930]  ret_from_fork+0x2d/0x50
> [  340.088510]  ? __pfx_kthread+0x10/0x10
> [  340.092263]  ret_from_fork_asm+0x1a/0x30
> [  340.096190]  </TASK>
> [  340.098380] ---[ end trace 0000000000000000 ]---
> [  340.103083] reboot: Restarting system
> [-- MARK -- Tue Mar 19 14:05:00 2024]
> ```
> 

