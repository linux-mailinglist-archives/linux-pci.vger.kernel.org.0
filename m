Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5490A405DB5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbhIITqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 15:46:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:23677 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245698AbhIITqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 15:46:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220567219"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="220567219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 12:45:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="539842375"
Received: from jmoawad-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.0.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 12:45:25 -0700
Subject: Re: Question about PCI: vmd: Disable MSI-X remapping when possible
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1631216432-7846-1-git-send-email-thomas.tai@oracle.com>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <3745daa2-93f3-2d02-f6b1-db58aa5c0c4a@intel.com>
Date:   Thu, 9 Sep 2021 14:45:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1631216432-7846-1-git-send-email-thomas.tai@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 9/9/21 2:40 PM, Thomas Tai wrote:
> Hi Jon,
> I have an Icelake server and seeing a problem with the VMD MSI-X
> remapping using the upstream kernel. I hope that you can give me
> some help.
> 
> My Icelake server failed to boot up with the following warning
> and continued printing out DMAR faults. After bisecting the kernel,
> I found the patch "PCI: vmd: Disable MSI-X remapping when possible"
> triggered the problem. If I remove the VMD_FEAT_CAN_BYPASS_MSI_REMAP
> flag from the pci_device_id vmd_ids[], the machine boots up fine.
> Do I need specific BIOS support for this msi bypassing to work?
> Or, would you have some idea how I can debug this issue?
> 
> Thank you very much,
> Thomas
> 
> Related commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ee81ee84f8739e584c9ccf113ba3c796187b7080
> 
> Console log:
> [   17.564368] ------------[ cut here ]------------
> [   17.569530] WARNING: CPU: 0 PID: 1546 at arch/x86/kernel/apic/apic.c:2541 __irq_msi_compose_msg+0x9f/0xb0
> [   17.580227] Modules linked in: fb_sys_fops(+) fjes(+) cec libahci mlxfw igb(+) pci_hyperv_intf uas tls drm libata usb_storage dca vmd(+) psample i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod fuse
> [   17.600629] CPU: 0 PID: 1546 Comm: kworker/0:3 Not tainted 5.14.0+ #4
> [   17.607825] Hardware name: Oracle Corporation ORACLE SERVER X9-2/ASMMBX9-2, BIOS 61040500 07/07/2021
> [   17.618026] Workqueue: events work_for_cpu_fn
> [   17.622899] RIP: 0010:__irq_msi_compose_msg+0x9f/0xb0
> [   17.628542] Code: 3d ff 7f 00 00 77 1f 0f b7 16 c1 e8 08 83 e0 7f c1 e0 05 66 81 e2 1f f0 09 d0 66 89 06 c3 3d ff 00 00 00 77 01 c3 55 48 89 e5 <0f> 0b 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00
> [   17.649506] RSP: 0000:ff3537369d78fb38 EFLAGS: 00010216
> [   17.655344] RAX: 0000000000010040 RBX: ff3537369d78fb70 RCX: 0000000000040000
> [   17.663312] RDX: 0000000000000000 RSI: ff3537369d78fb70 RDI: ff281411429b22c0
> [   17.671283] RBP: ff3537369d78fb38 R08: 0000000000000002 R09: 0000000000000002
> [   17.679251] R10: 0000000039030000 R11: 0000000000000001 R12: 0000000000000000
> [   17.687219] R13: ff28140c5129b980 R14: 0000000000000000 R15: ff28140d85df1800
> [   17.695190] FS:  0000000000000000(0000) GS:ff2814c8af600000(0000) knlGS:0000000000000000
> [   17.704226] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   17.710645] CR2: 00007f6b4ef749b0 CR3: 000001638320a005 CR4: 0000000000771ef0
> [   17.718616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   17.726584] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   17.734554] PKRU: 55555554
> [   17.737577] Call Trace:
> [   17.740312]  x86_vector_msi_compose_msg+0x24/0x30
> [   17.745569]  irq_chip_compose_msi_msg+0x34/0x50
> [   17.750631]  msi_domain_activate+0x4c/0xa0
> [   17.755209]  __irq_domain_activate_irq+0x55/0x90
> [   17.760366]  irq_domain_activate_irq+0x29/0x40
> [   17.761677] scsi 0:0:0:0: CD-ROM            SUN      Remote ISO CDROM 1.01 PQ: 0 ANSI: 0
> [   17.765332]  __msi_domain_alloc_irqs+0x1c6/0x380
> [   17.765334]  msi_domain_alloc_irqs+0x17/0x20
> [   17.784293]  pci_msi_setup_msi_irqs.isra.25+0x2c/0x40
> [   17.789937]  __pci_enable_msi_range+0x228/0x3f0
> [   17.794998]  pci_alloc_irq_vectors_affinity+0xc6/0x110
> [   17.800740]  pcie_port_device_register+0x115/0x580
> [   17.806092]  ? update_load_avg+0x82/0x5c0
> [   17.810573]  pcie_portdrv_probe+0x4a/0xe0
> [   17.815052]  local_pci_probe+0x47/0x90
> [   17.819242]  work_for_cpu_fn+0x17/0x30
> [   17.823430]  process_one_work+0x1d8/0x390
> [   17.827910]  worker_thread+0x1e6/0x3b0
> [   17.832100]  ? process_one_work+0x390/0x390
> [   17.836775]  kthread+0x12d/0x150
> [   17.840383]  ? set_kthread_struct+0x40/0x40
> [   17.845056]  ret_from_fork+0x1f/0x30
> [   17.849055] ---[ end trace fd241a14b21e3efa ]---
> 
> The kernel keep printing the following fault status:
> 
> [   58.435452] DMAR: DRHD: handling fault status reg 2
> [   58.440907] DMAR: [INTR-REMAP] Request device [0x64:0x00.5] fault index 0x8800 [fault reason 0x25] Blocked a compatibility format interrupt request
> [   58.460519] DMAR: DRHD: handling fault status reg 2
> [   58.465974] DMAR: [INTR-REMAP] Request device [0x64:0x00.5] fault index 0x8800 [fault reason 0x25] Blocked a compatibility format interrupt request
> 

Something on the subdomain is being programmed with a compatibility format
interrupt request, which afaik, should not be happening.

Here's a related patch which disables the remapping when IOMMU interrupt
remapping is enabled:
https://lore.kernel.org/linux-pci/5120b110-693a-79d3-2793-ac53c036897f@intel.com/

The VMD feature was tested with IOMMU interrupt remapping enabled and should
have support. Can you provide an lspci of the VMD subdomain?
