Return-Path: <linux-pci+bounces-12590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA7967E27
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 05:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09B1B209C7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 03:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46212D057;
	Mon,  2 Sep 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjz9mK2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950C2C80
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247937; cv=none; b=j1rgGLVODr32UgGAvy5d4cyAKMlM8H+cAdWCJfD1lTWiV0UHpH0npz/eINPYXx3qu1cx1t4is06VK6Eqk6MfB5E3UEX1fqmhE6lgVmtj3CFsvlqNwEM4JJt50BE3RDZ8jIgO13sMv1amWI6KGm+kqDzitzW2RrBilEQwdZVHQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247937; c=relaxed/simple;
	bh=hCdT1PhQKvaCewMkgMIDiGXD8sW5Qw+SS+iu7Ba9D/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BUMhJTKjM+mZrlO8IBn4UCrgX0wl7mRt0d8x5ARnlSoAfobAKw63CxVshAnWmZqHCbnUpxwjBMC+bDvxbypdjTyTmOwPvMeS06Fsml+5a6l+R5jA5icXsVlxBDGtLGWuZlu+wlKU50ouFbsiQZasf/FoG7jYxyUKzOj9GluWCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xjz9mK2/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725247934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=obu9w3qS3edU0OUEg+fxyJR4inviPotuVfPdF8CnfUg=;
	b=Xjz9mK2/9kHb+beO66pyBJ3mc0Y59NbGr7mZoD84o5CFnDrfEVPsGPKnt01onbCMZgOBg3
	mitUF6nfuV5hu4g7ilkgn2dXWP+j7U0uBQlO4iplurN88s7Vc/pRIQURMO8AnnmqtzkKQP
	Gk/uO2ndiF7PK4SLVd76amYFR/Yb3NA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-o-8cgHjEPrqiXPTxOAj6JA-1; Sun, 01 Sep 2024 23:32:13 -0400
X-MC-Unique: o-8cgHjEPrqiXPTxOAj6JA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5dfa08a4424so3088830eaf.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Sep 2024 20:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725247932; x=1725852732;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obu9w3qS3edU0OUEg+fxyJR4inviPotuVfPdF8CnfUg=;
        b=nV7+xVBF+8v/kRFBTbwJMtMOoR/U7cnDt3ckWClyGSWYVrKO2fyHZXEEKqSQdtHqcT
         6lZkNkiRF3Y2phv+Br1dOSZwT1zAfGN+Dga6bNWpLgeoMPipjIPyfKVY1oHF0hI8Yntg
         dJUsuA+N/34s/4t3upcpkg9OZt5GOmct211sdGVRNZsQonmu7qXkj9NBk7dJgC7cz3lj
         /7fOIPX7K/xIz1PnpEUtNhbNtVHl/Zs9SykQuPKWW26TwRG4y2doLFdneTx2cT8OIf+I
         XcdVlFvkdHl6klPgvTc7aWNhNcQ39qpehacOhygMXIHiVoi0eAZYlo95P7B+BpHPWUxZ
         arRA==
X-Gm-Message-State: AOJu0YxkZSJ+XOLvkJep/O7dlRyfZhPjdzdBcHa1iySpZcjJthPiNsyt
	i2ZNHo/hMywSMftWgJ6SOqUnCFzXIFkQ5NowIlKlmEpfs690rENlfi6mvq9UAwpzRe2UBkmWcJg
	biwuJeLbFLsqo2v86TC4oEW/09MRbEnvZkMi+2YvAOe0GjG/1qiuVgNGqN5OW0HRisdix4qvQzu
	VJBO+zApP7EA76Sl2t9oHiGnGjsEhFTUohbdDThwOe6kv3kg==
X-Received: by 2002:a05:6358:52cb:b0:1b5:fba4:548a with SMTP id e5c5f4694b2df-1b603c36932mr1015980455d.8.1725247931984;
        Sun, 01 Sep 2024 20:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEExHqgM0X4UPVqvSg2DDRFyLMAdoMxM2e6EWVRo95Bdwj8I6Mwcw23k5w8SDKeSuNcDvUpZCQB9Ma6n9LBeVo=
X-Received: by 2002:a05:6358:52cb:b0:1b5:fba4:548a with SMTP id
 e5c5f4694b2df-1b603c36932mr1015979355d.8.1725247931516; Sun, 01 Sep 2024
 20:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 2 Sep 2024 11:31:59 +0800
Message-ID: <CAGVVp+XdmMf=kX2ZSWXUcvynyhyZ5=L=qrYJ0X9fdt5Fm0H7pA@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 0 PID: 10 at drivers/pci/pci.c:2250 pci_disable_device+0xe5/0x100
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

hit a warning issue when reboot system, if you need additional
information or need testing a patch, please let me know

repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch: for-next
commit HEAD: 81c0619ef256eb3b0aef6a5365f0b2c37e82327e

dmesg log:
System Reboot
.
[
  OK
] Reached target
System Reboot
.
[  241.277952] watchdog: watchdog0: watchdog did not stop!
[  251.298630] systemd-shutdown[1]: Waiting for process: 2093
(rhts-reboot), 2106 (sleep)
[-- MARK -- Fri Aug 30 20:05:00 2024]
[  331.337465] watchdog: watchdog0: watchdog did not stop!
[  331.373580] dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
[  331.409208] dracut Warning: Unmounted /oldroot.
dracut Warning: Unmounted /oldroot.
Rebooting.
[  332.648001] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 5
[  332.656256] {1}[Hardware Error]: event severity: recoverable
[  332.661917] {1}[Hardware Error]:  Error 0, type: fatal
[  332.667055] {1}[Hardware Error]:   section_type: PCIe error
[  332.672621] {1}[Hardware Error]:   port_type: 0, PCIe end point
[  332.678539] {1}[Hardware Error]:   version: 3.0
[  332.683072] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
[  332.689252] {1}[Hardware Error]:   device_id: 0000:04:00.0
[  332.694737] {1}[Hardware Error]:   slot: 0
[  332.698838] {1}[Hardware Error]:   secondary_bus: 0x00
[  332.703977] {1}[Hardware Error]:   vendor_id: 0x14e4, device_id: 0x165f
[  332.710588] {1}[Hardware Error]:   class_code: 020000
[  332.715632] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
[  332.723980] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
[  332.730072] {1}[Hardware Error]:   TLP Header: 40000001 0000030f
90028090 00000000
[  332.737655] tg3 0000:04:00.0: AER: aer_status: 0x00100000,
aer_mask: 0x00010000
[  332.744964] tg3 0000:04:00.0:    [20] UnsupReq               (First)
[  332.751316] tg3 0000:04:00.0: AER: aer_layer=Transaction Layer,
aer_agent=Requester ID
[  332.759230] tg3 0000:04:00.0: AER: aer_uncor_severity: 0x000ef030
[  332.765322] tg3 0000:04:00.0: AER:   TLP Header: 40000001 0000030f
90028090 00000000
[  332.773065] ------------[ cut here ]------------
[  332.777680] tg3 0000:04:00.0: disabling already-disabled device
[  332.777689] WARNING: CPU: 0 PID: 10 at drivers/pci/pci.c:2250
pci_disable_device+0xe5/0x100
[  332.791953] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs rfkill sunrpc vfat fat dm_multipath
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac skx_edac_common nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
mgag200 iTCO_wdt dell_pc dax_hmem i2c_algo_bit ipmi_ssif
platform_profile iTCO_vendor_support cxl_acpi drm_shmem_helper rapl
cxl_core drm_kms_helper mei_me intel_th_gth isst_if_mmio intel_cstate
dell_smbios isst_if_mbox_pci i2c_i801 dcdbas acpi_power_meter
intel_th_pci mei intel_uncore dell_wmi_descriptor isst_if_common
wmi_bmof intel_vsec ipmi_si intel_pch_thermal intel_th einj acpi_ipmi
i2c_smbus pcspkr ipmi_devintf ipmi_msghandler drm fuse xfs libcrc32c
sd_mod sg ahci crct10dif_pclmul libahci crc32_pclmul crc32c_intel
libata tg3 ghash_clmulni_intel wmi dm_mirror dm_region_hash dm_log
dm_mod
[  332.872617] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Kdump: loaded
Not tainted 6.11.0-rc5+ #1
[  332.881047] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
1.4.4 10/07/2021
[  332.888702] Workqueue: events aer_recover_work_func
[  332.893582] RIP: 0010:pci_disable_device+0xe5/0x100
[  332.898461] Code: 4d 85 e4 75 07 4c 8b a7 c8 00 00 00 48 8d bb c8
00 00 00 e8 2d 6e 18 00 4c 89 e2 48 c7 c7 d0 98 23 84 48 89 c6 e8 3b
6c 9f ff <0f> 0b e9 3b ff ff ff e8 2f 2f 62 00 66 66 2e 0f 1f 84 00 00
00 00
[  332.917206] RSP: 0018:ff4cd3648011fd28 EFLAGS: 00010282
[  332.922431] RAX: 0000000000000000 RBX: ff36815a45adc000 RCX: ffffffff84721408
[  332.929565] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: 0000000000000001
[  332.936698] RBP: ff36815a5c736000 R08: 0000000000000000 R09: ff4cd3648011fbd8
[  332.943829] R10: ff4cd3648011fbd0 R11: ffffffff847e1448 R12: ff36815a452b39d0
[  332.950963] R13: ff36815a5c7369c0 R14: ff36815a45adc148 R15: ff36815a45ade000
[  332.958097] FS:  0000000000000000(0000) GS:ff36815daf600000(0000)
knlGS:0000000000000000
[  332.966182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  332.971928] CR2: 00007f9fcad73420 CR3: 000000000ce22004 CR4: 0000000000771ef0
[  332.979061] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  332.986194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  332.993327] PKRU: 55555554
[  332.996038] Call Trace:
[  332.998493]  <TASK>
[  333.000597]  ? __warn+0x7f/0x120
[  333.003831]  ? pci_disable_device+0xe5/0x100
[  333.008103]  ? report_bug+0x18a/0x1a0
[  333.011769]  ? handle_bug+0x3c/0x70
[  333.015261]  ? exc_invalid_op+0x14/0x70
[  333.019101]  ? asm_exc_invalid_op+0x16/0x20
[  333.023287]  ? pci_disable_device+0xe5/0x100
[  333.027559]  ? pci_disable_device+0xe5/0x100
[  333.031834]  ? __pfx_report_frozen_detected+0x10/0x10
[  333.036887]  tg3_io_error_detected+0x200/0x2b0 [tg3]
[  333.041852]  ? __pfx_report_frozen_detected+0x10/0x10
[  333.046904]  report_error_detected+0xc9/0x1c0
[  333.051265]  ? __pfx_report_frozen_detected+0x10/0x10
[  333.056315]  __pci_walk_bus+0x6b/0xb0
[  333.059982]  ? __pfx_aer_root_reset+0x10/0x10
[  333.064342]  pcie_do_recovery+0x2b4/0x3c0
[  333.068354]  aer_recover_work_func+0x106/0x110
[  333.072801]  process_one_work+0x179/0x390
[  333.076812]  worker_thread+0x231/0x340
[  333.080564]  ? __pfx_worker_thread+0x10/0x10
[  333.084839]  kthread+0xcc/0x100
[  333.087983]  ? __pfx_kthread+0x10/0x10
[  333.091737]  ret_from_fork+0x2d/0x50
[  333.095317]  ? __pfx_kthread+0x10/0x10
[  333.099069]  ret_from_fork_asm+0x1a/0x30
[  333.102996]  </TASK>
[  333.105189] ---[ end trace 0000000000000000 ]---
[  333.109901] reboot: Restarting system

Thanks,
Changhui


