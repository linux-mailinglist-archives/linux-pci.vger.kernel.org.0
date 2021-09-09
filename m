Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78952405D64
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbhIITjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 15:39:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233984AbhIITjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 15:39:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189HhlWv013629;
        Thu, 9 Sep 2021 19:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=/ON0LGsKaBljdTWKQoRmkvu8UbwgkwjmMRYtIhxh/Lo=;
 b=CDfohUNo0z8/bV71QDSgW3kiTo5ROFVKn0IFhSiKVg8PyvsQ2d6+xwC+97M2YJfrL077
 1Nb4oyVvFzurihWKGl/gBqKQA1++E6ZKdtTZltkxOsKgKvrfNwAtXRwiXo2lG71NtuVf
 J1fdtg3p8OWj6lflV3m1V3s0Kpwlb6qkGkqpLOoReDWE5ffsy80ki3tYhCpsW264tcjp
 e56jeRp0fYedPOpxQzE8DUnOG+9lUlf3IyjcLFpsvjjcfz+bNzGaHkN4o9NGOke+EX/t
 Zz8I5DK08FXchSzZOmGJN73F60UUShOcufIjfVMAWCE8VGG8IzDQBPahV9ummxa8YGfx 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=/ON0LGsKaBljdTWKQoRmkvu8UbwgkwjmMRYtIhxh/Lo=;
 b=GqArg+yNf1BpaZxDk1ZOXbekKWAVXKCbIoRo/r4UCVWRvLCkXpQUcAUzPzl8thYZGCd3
 vP7qlCtw5BiVBdXneI+XWML8qGBMwr/CoKp/tzubBgH4lcyGi3GejpD2Aj2VRjcTF7nE
 LcY2EJkM3eUZ25IIbcQ8EZhSa0PtM/2JXRPwOXIB6POXiU6drVmxCMp2IiWois2AgjeF
 q7ldd2mLXPx1aT1XEAXGbRFtooQ+jmz5gY2CBBYLilWwQeJ4gQT5T43pBmbHhqkcmzyU
 /lP3zSULscC/EoaBf7fAET6uZf+zoMWH7ONS+CTzVkX3wCb/IBTOnLtEeensxtHb/+ny oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayf8a9urf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 19:38:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189JYs2Z169312;
        Thu, 9 Sep 2021 19:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3axst5x2as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 19:38:08 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 189Jc7dM181118;
        Thu, 9 Sep 2021 19:38:07 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by userp3020.oracle.com with ESMTP id 3axst5x2ag-1;
        Thu, 09 Sep 2021 19:38:07 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     thomas.tai@oracle.com, jonathan.derrick@intel.com
Cc:     linux-pci@vger.kernel.org
Subject: Question about PCI: vmd: Disable MSI-X remapping when possible
Date:   Thu,  9 Sep 2021 15:40:32 -0400
Message-Id: <1631216432-7846-1-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: iD7Mhzzlz0QZg8YwRpe3Nv5nRVAtJCys
X-Proofpoint-GUID: iD7Mhzzlz0QZg8YwRpe3Nv5nRVAtJCys
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,
I have an Icelake server and seeing a problem with the VMD MSI-X
remapping using the upstream kernel. I hope that you can give me
some help.

My Icelake server failed to boot up with the following warning
and continued printing out DMAR faults. After bisecting the kernel,
I found the patch "PCI: vmd: Disable MSI-X remapping when possible"
triggered the problem. If I remove the VMD_FEAT_CAN_BYPASS_MSI_REMAP
flag from the pci_device_id vmd_ids[], the machine boots up fine.
Do I need specific BIOS support for this msi bypassing to work?
Or, would you have some idea how I can debug this issue?

Thank you very much,
Thomas

Related commit:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ee81ee84f8739e584c9ccf113ba3c796187b7080

Console log:
[   17.564368] ------------[ cut here ]------------
[   17.569530] WARNING: CPU: 0 PID: 1546 at arch/x86/kernel/apic/apic.c:2541 __irq_msi_compose_msg+0x9f/0xb0
[   17.580227] Modules linked in: fb_sys_fops(+) fjes(+) cec libahci mlxfw igb(+) pci_hyperv_intf uas tls drm libata usb_storage dca vmd(+) psample i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod fuse
[   17.600629] CPU: 0 PID: 1546 Comm: kworker/0:3 Not tainted 5.14.0+ #4
[   17.607825] Hardware name: Oracle Corporation ORACLE SERVER X9-2/ASMMBX9-2, BIOS 61040500 07/07/2021
[   17.618026] Workqueue: events work_for_cpu_fn
[   17.622899] RIP: 0010:__irq_msi_compose_msg+0x9f/0xb0
[   17.628542] Code: 3d ff 7f 00 00 77 1f 0f b7 16 c1 e8 08 83 e0 7f c1 e0 05 66 81 e2 1f f0 09 d0 66 89 06 c3 3d ff 00 00 00 77 01 c3 55 48 89 e5 <0f> 0b 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00
[   17.649506] RSP: 0000:ff3537369d78fb38 EFLAGS: 00010216
[   17.655344] RAX: 0000000000010040 RBX: ff3537369d78fb70 RCX: 0000000000040000
[   17.663312] RDX: 0000000000000000 RSI: ff3537369d78fb70 RDI: ff281411429b22c0
[   17.671283] RBP: ff3537369d78fb38 R08: 0000000000000002 R09: 0000000000000002
[   17.679251] R10: 0000000039030000 R11: 0000000000000001 R12: 0000000000000000
[   17.687219] R13: ff28140c5129b980 R14: 0000000000000000 R15: ff28140d85df1800
[   17.695190] FS:  0000000000000000(0000) GS:ff2814c8af600000(0000) knlGS:0000000000000000
[   17.704226] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.710645] CR2: 00007f6b4ef749b0 CR3: 000001638320a005 CR4: 0000000000771ef0
[   17.718616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.726584] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   17.734554] PKRU: 55555554
[   17.737577] Call Trace:
[   17.740312]  x86_vector_msi_compose_msg+0x24/0x30
[   17.745569]  irq_chip_compose_msi_msg+0x34/0x50
[   17.750631]  msi_domain_activate+0x4c/0xa0
[   17.755209]  __irq_domain_activate_irq+0x55/0x90
[   17.760366]  irq_domain_activate_irq+0x29/0x40
[   17.761677] scsi 0:0:0:0: CD-ROM            SUN      Remote ISO CDROM 1.01 PQ: 0 ANSI: 0
[   17.765332]  __msi_domain_alloc_irqs+0x1c6/0x380
[   17.765334]  msi_domain_alloc_irqs+0x17/0x20
[   17.784293]  pci_msi_setup_msi_irqs.isra.25+0x2c/0x40
[   17.789937]  __pci_enable_msi_range+0x228/0x3f0
[   17.794998]  pci_alloc_irq_vectors_affinity+0xc6/0x110
[   17.800740]  pcie_port_device_register+0x115/0x580
[   17.806092]  ? update_load_avg+0x82/0x5c0
[   17.810573]  pcie_portdrv_probe+0x4a/0xe0
[   17.815052]  local_pci_probe+0x47/0x90
[   17.819242]  work_for_cpu_fn+0x17/0x30
[   17.823430]  process_one_work+0x1d8/0x390
[   17.827910]  worker_thread+0x1e6/0x3b0
[   17.832100]  ? process_one_work+0x390/0x390
[   17.836775]  kthread+0x12d/0x150
[   17.840383]  ? set_kthread_struct+0x40/0x40
[   17.845056]  ret_from_fork+0x1f/0x30
[   17.849055] ---[ end trace fd241a14b21e3efa ]---

The kernel keep printing the following fault status:

[   58.435452] DMAR: DRHD: handling fault status reg 2
[   58.440907] DMAR: [INTR-REMAP] Request device [0x64:0x00.5] fault index 0x8800 [fault reason 0x25] Blocked a compatibility format interrupt request
[   58.460519] DMAR: DRHD: handling fault status reg 2
[   58.465974] DMAR: [INTR-REMAP] Request device [0x64:0x00.5] fault index 0x8800 [fault reason 0x25] Blocked a compatibility format interrupt request

