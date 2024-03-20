Return-Path: <linux-pci+bounces-4922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7888097F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA4D2840CB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67007489;
	Wed, 20 Mar 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzGrT1WT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE227464
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900984; cv=none; b=NbCG8rl7+et/hwB0aP51OzhhVnRh3WeQwD21Q1w/kCZNvaz99ZccQEKw7wu6eGf9gr85mH72az44jkRIPRCX1uZfjhTnvhs5zxSRJquEQd0nD40NZd5nykr8hlVo4nAwZHx9hWMepS/DyOuITFe85j7GoWZ+P3cX4nZxKIL6ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900984; c=relaxed/simple;
	bh=J/HgCo1GXOMhMBO+IebEvbqBtuAYydlUTSqCR86mw2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL3lrXIGCovMmVFxwn9i9fn6XgcmsQWqp/XouK78necEJ4I+PqO93nzYoy3tV4D4RIjwSAeN49ZafcYP5AJQ9hbi5ohI/r8h8cC4J85jPtrfrBmfHOjxCMmV0JF5l5UNPzqSq/oyapxQML36EttW7YIHMdYMjT23fEZQu3Vj7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzGrT1WT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710900981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ3icNeNMqbC5L1RWUVbQ3w9VE37WySgiynVw6IXJQA=;
	b=MzGrT1WTu1VYNKVV3bWNdzBvTmT+Mt3ZJs1xoWi74gURj2znkRDNB/a/55ksUU0WCUs6OJ
	vMVNW1+CVVDL/TUIbFFK0DQXUvVLvl3yHk+hUSz0F7oM82LvVpLxT78j8OdAcGP0b7CS0q
	IncerUf8bt+AITs0OgSV++SuzLatkXw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-2olE8NOIMTWGUK292jBjig-1; Tue, 19 Mar 2024 22:16:19 -0400
X-MC-Unique: 2olE8NOIMTWGUK292jBjig-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29fbe1089b8so1743383a91.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 19:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710900978; x=1711505778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ3icNeNMqbC5L1RWUVbQ3w9VE37WySgiynVw6IXJQA=;
        b=GYrMU34ZZxiOTlU6ndvsfTRwtJHTDCKr2/VYqA8Q4+oCSUI1oYh9KONt92wGtRjpDp
         UhRlpX/J6fg7hZaCQ3jtsXvMQdWMnC9mlnGIp6DAOvuD+Ne1GEDlfQy4PMbSQNw5WIT0
         M5ILXshoyolJWosjhhaGqW6XsY/389U7N1hHKjFvg/YOYibjYf8Jn6B5axBK0Sh08aYw
         QHqtSpdMxLFXnFKBKLnWFtqkwRwL89/eIP3kGCcPTT6XzjxGyKur4MoCByuH1t20vzCO
         L6oQCtMQU4evqeHLgKyhpL84Hj9hfQ6aFBnIoqW2R6WKLA+2y2vJ1BLbscjw2s0Xtkd0
         AV+A==
X-Gm-Message-State: AOJu0Yw4g6VlotDMMJi7Z03/dIwxpcaXTz8hgNK2Gy3REj1pjvVxNVuy
	nO2Q66SiBcjAb7ETEPzbvASZ0vptjw7LQPVvaYGPMslyCsSPz6JVDkaons/Nx6vy4TSfDMl6I43
	+IhXZJvVOWolZJXgghtuWL9ZiBLnofwhntWFrT477/3hvxE0bXhCSl1U0MOyq2xyYR2QYaGhoUn
	8OmkUZ2+quF2ABn3iERtN68TOVYLSNfL3jk/mOBduca+fcuxm5
X-Received: by 2002:a17:90a:68cd:b0:29c:6ff8:fa32 with SMTP id q13-20020a17090a68cd00b0029c6ff8fa32mr11341155pjj.3.1710900978581;
        Tue, 19 Mar 2024 19:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdY89CDYOSSiDCNbLZ0pfAlipuDWF00tgGNuJSHmgG0kEHIIWBOlZBNzltMvg0l/GspyaJC6/COFP4EC9vrEk=
X-Received: by 2002:a17:90a:68cd:b0:29c:6ff8:fa32 with SMTP id
 q13-20020a17090a68cd00b0029c6ff8fa32mr11341145pjj.3.1710900978135; Tue, 19
 Mar 2024 19:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WyM-ce=c1L4p2EZfvLyxYZSHFkxKLad1TXXyNdVn1KYg@mail.gmail.com>
 <20240319162334.GA1230451@bhelgaas>
In-Reply-To: <20240319162334.GA1230451@bhelgaas>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 20 Mar 2024 10:16:06 +0800
Message-ID: <CAGVVp+WDQXvFB2xEs=8pU02qseVHCWJvEVv5RRZFQnHbJFa=cw@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236 pci_disable_device+0xf4/0x100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8CBjorn

On Wed, Mar 20, 2024 at 12:30=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Tue, Mar 19, 2024 at 03:34:56PM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
> > branch: master
> > commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80
>
> Where's the rest of this?  I don't see "WARNING: CPU: 0 PID: 226 at
> drivers/pci/pci.c:2236" in the snippet below.  Please include or post
> the complete dmesg log.
>
> Is this reproducible?  If so, how?  And is it a regression?
>

it reproduceible=EF=BC=8CI can trigger it every time on my server=EF=BC=8Cb=
ut I'm not
sure if it is a regression=EF=BC=8C

dmesg log on my other server=EF=BC=9A
```
System Reboot
.
[  248.433904] watchdog: watchdog0: watchdog did not stop!
[  258.459553] systemd-shutdown[1]: Waiting for process: 4506 (sleep),
4491 (rhts-reboot)
[  338.521745] watchdog: watchdog0: watchdog did not stop!
[  338.556096] dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
[  338.589595] dracut Warning: Unmounted /oldroot.
dracut Warning: Unmounted /oldroot.
Rebooting.
[  339.651690] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 5
[  339.659948] {1}[Hardware Error]: event severity: recoverable
[  339.665606] {1}[Hardware Error]:  Error 0, type: fatal
[  339.670743] {1}[Hardware Error]:   section_type: PCIe error
[  339.676310] {1}[Hardware Error]:   port_type: 0, PCIe end point
[  339.682228] {1}[Hardware Error]:   version: 3.0
[  339.686761] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
[  339.692939] {1}[Hardware Error]:   device_id: 0000:04:00.0
[  339.698427] {1}[Hardware Error]:   slot: 0
[  339.702525] {1}[Hardware Error]:   secondary_bus: 0x00
[  339.707664] {1}[Hardware Error]:   vendor_id: 0x14e4, device_id: 0x165f
[  339.714278] {1}[Hardware Error]:   class_code: 020000
[  339.719331] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
[  339.727678] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
[  339.733769] {1}[Hardware Error]:   TLP Header: 40000001 0000020f
90028090 00000000
[  339.741353] tg3 0000:04:00.0: AER: aer_status: 0x00100000,
aer_mask: 0x00010000
[  339.748662] tg3 0000:04:00.0:    [20] UnsupReq               (First)
[  339.755014] tg3 0000:04:00.0: AER: aer_layer=3DTransaction Layer,
aer_agent=3DRequester ID
[  339.762924] tg3 0000:04:00.0: AER: aer_uncor_severity: 0x000ef030
[  339.769018] tg3 0000:04:00.0: AER:   TLP Header: 40000001 0000020f
90028090 00000000
[  339.776761] ------------[ cut here ]------------
[  339.781378] tg3 0000:04:00.0: disabling already-disabled device
[  339.781386] WARNING: CPU: 0 PID: 358 at drivers/pci/pci.c:2236
pci_disable_device+0xf4/0x100
[  339.795737] Modules linked in: raid1 rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc ipmi_ssif
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac nfit libnvdimm
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm vfat fat
mgag200 rapl dax_hmem iTCO_wdt i2c_algo_bit cxl_acpi
iTCO_vendor_support drm_shmem_helper intel_cstate acpi_ipmi ipmi_si
mei_me cxl_core i2c_i801 dell_smbios isst_if_mmio isst_if_mbox_pci
drm_kms_helper ipmi_devintf intel_uncore dcdbas mei einj
intel_pch_thermal intel_vsec isst_if_common wmi_bmof
dell_wmi_descriptor pcspkr i2c_smbus ipmi_msghandler acpi_power_meter
drm fuse xfs libcrc32c sd_mod t10_pi sg crct10dif_pclmul ahci
crc32_pclmul libahci crc32c_intel libata tg3 ghash_clmulni_intel wmi
dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
[  339.872243] CPU: 0 PID: 358 Comm: kworker/0:3 Not tainted 6.8.0+ #1
[  339.878505] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
1.4.4 10/07/2021
[  339.886157] Workqueue: events aer_recover_work_func
[  339.891037] RIP: 0010:pci_disable_device+0xf4/0x100
[  339.895917] Code: 4d 85 e4 75 07 4c 8b a3 c8 00 00 00 48 8d bb c8
00 00 00 e8 9e c7 17 00 4c 89 e2 48 c7 c7 50 92 21 91 48 89 c6 e8 ac
94 a1 ff <0f> 0b e9 3b ff ff ff e8 80 36 60 00 90 90 90 90 90 90 90 90
90 90
[  339.914664] RSP: 0018:ff56179a82883d10 EFLAGS: 00010286
[  339.919888] RAX: 0000000000000000 RBX: ff2f7c9b44e58000 RCX: ffffffff917=
1e4a8
[  339.927022] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: 00000000000=
00001
[  339.934154] RBP: ff2f7c9b65860000 R08: 0000000000000000 R09: ff56179a828=
83bc0
[  339.941289] R10: ff56179a82883bb8 R11: ffffffff917de4e8 R12: ff2f7c9b445=
fa4e0
[  339.948421] R13: 0000000000000002 R14: ff2f7c9b44e58148 R15: ff2f7c9b44e=
5d000
[  339.955552] FS:  0000000000000000(0000) GS:ff2f7c9eaf600000(0000)
knlGS:0000000000000000
[  339.963640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  339.969385] CR2: 00007f7577713838 CR3: 0000000300a20003 CR4: 00000000007=
71ef0
[  339.976519] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  339.983651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  339.990782] PKRU: 55555554
[  339.993494] Call Trace:
[  339.995949]  <TASK>
[  339.998054]  ? __warn+0x7f/0x130
[  340.001286]  ? pci_disable_device+0xf4/0x100
[  340.005560]  ? report_bug+0x18a/0x1a0
[  340.009227]  ? handle_bug+0x3c/0x70
[  340.012719]  ? exc_invalid_op+0x14/0x70
[  340.016559]  ? asm_exc_invalid_op+0x16/0x20
[  340.020745]  ? pci_disable_device+0xf4/0x100
[  340.025017]  ? __pfx_report_frozen_detected+0x10/0x10
[  340.030069]  tg3_io_error_detected+0x1f5/0x2b0 [tg3]
[  340.035044]  ? __pfx_report_frozen_detected+0x10/0x10
[  340.040098]  report_error_detected+0xc7/0x1c0
[  340.044456]  ? __pfx_report_frozen_detected+0x10/0x10
[  340.049509]  __pci_walk_bus+0x6b/0xb0
[  340.053176]  ? __pfx_aer_root_reset+0x10/0x10
[  340.057535]  pcie_do_recovery+0x2b4/0x3c0
[  340.061548]  aer_recover_work_func+0x106/0x110
[  340.065992]  process_one_work+0x193/0x3d0
[  340.070005]  worker_thread+0x2fc/0x410
[  340.073758]  ? __pfx_worker_thread+0x10/0x10
[  340.078032]  kthread+0xdc/0x110
[  340.081179]  ? __pfx_kthread+0x10/0x10
[  340.084930]  ret_from_fork+0x2d/0x50
[  340.088510]  ? __pfx_kthread+0x10/0x10
[  340.092263]  ret_from_fork_asm+0x1a/0x30
[  340.096190]  </TASK>
[  340.098380] ---[ end trace 0000000000000000 ]---
[  340.103083] reboot: Restarting system
[-- MARK -- Tue Mar 19 14:05:00 2024]
```


