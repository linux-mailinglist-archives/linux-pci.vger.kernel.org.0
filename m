Return-Path: <linux-pci+bounces-19081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B59FD8FB
	for <lists+linux-pci@lfdr.de>; Sat, 28 Dec 2024 06:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168D01624FC
	for <lists+linux-pci@lfdr.de>; Sat, 28 Dec 2024 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FCF22092;
	Sat, 28 Dec 2024 05:04:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m4920.qiye.163.com (mail-m4920.qiye.163.com [45.254.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC2635
	for <linux-pci@vger.kernel.org>; Sat, 28 Dec 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735362298; cv=none; b=dzz97XsA3CaEbCwTz3MI+35xfdMLxOzxIXxTLA6A9j4buxobcZWMyVsgiT5+IRPDe4/OsX0PwkwuwmHaz1AEbashb84JIKYvEKbDhNn3JMYuYUlnV1VrPKagDahroMdJVbtxIJDtW25AF4sKw0IpOxehPhhZvMottyNOgjjDRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735362298; c=relaxed/simple;
	bh=pAdxJDwrLq84+UGKXvTkciGZHYNpX6Li0lqP+01DRXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAQuJN1VSIgK1R7jPtNRBbG64yPzHoVLWoiENV79osAkoiBCCbuLM5IdI/sAE39lT7UWxx5CrdBfcsQxRm5lzrmkcI3bG84hW8rXsnOvbjtVlkSsWsqY8eJIdjbrk9BdyJf2TcCwcT17btzvm1aREdrE6rd8m5XfYZgnkQkbZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [IPV6:240e:3b7:3275:4ea0:39d2:a551:6fcc:9e65] (unknown [IPV6:240e:3b7:3275:4ea0:39d2:a551:6fcc:9e65])
	by smtp.qiye.163.com (Hmail) with ESMTP id 70e74bca;
	Sat, 28 Dec 2024 12:59:35 +0800 (GMT+08:00)
Message-ID: <ddd7bf5e-9580-4ea1-a2fe-bd4fb689f6fb@sangfor.com.cn>
Date: Sat, 28 Dec 2024 13:00:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Re: PCI/ASPM: Fix UAF by disabling ASPM for link when
 child function is removed
To: Daniel Stodden <dns@arista.com>, bhelgaas@google.com
Cc: david.e.box@linux.intel.com, kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org, michael.a.bottini@linux.intel.com,
 qinzongquan@sangfor.com.cn, rajatja@google.com, refactormyself@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com
References: <20230507034057.20970-1-dinghui@sangfor.com.cn>
 <cover.1734924854.git.dns@arista.com>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <cover.1734924854.git.dns@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUJMVhoZTh4dQ0wYT0lISlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0seQUgZTEFISUxOQU8eGktBSEIfSUEaTk5KQU0dGBhBQh5NTllXWR
	YaDxIVHRRZQVlPQkxVSElKTExVS1VJS0tNWQY+
X-HM-Tid: 0a940ba256c309d9kunm70e74bca
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Egw4MDIWEz4pKEMjOBQv
	LAIwCUlVSlVKTEhOSE1KQkxMS0lCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxOQU8eGktBSEIfSUEaTk5KQU0dGBhBQh5NTllXWQgBWUFNTkNNNwY+

Sorry for late reply.

Thanks for pointing out the release order issue that I indeed overlooked.

I'm not an expert in PCI, so I'm not sure if there's a similar PCI topology like this:

[00]-+..
      |
      +--03.0-[01-03]--+-00.0  Endpoint
                       +-00.1-[02-03]--+-02.0-[02]--x
                                       \-0d.0-[03]----00.0  Endpoint

If this is possible, I think that even after applying your patch, removing 01:00.0
individually by
   echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
maybe still lead to a Use-After-Free when pcie_aspm_exit_link_state(<02:02.0>).

Additionally, Bjorn Helgaas also expects compliance with the PCIe specification r6.0,
section 7.5.3.7, which recommends that software programs the same ASPM Control value
across all functions of multi-function devices.

Therefore, should we recursively release the link_state of child devices before
the current device in pcie_aspm_exit_link_state()?

-- 
Thanks,
-dinghui

On 2024/12/23 11:39, Daniel Stodden wrote:
> About change 456d8aa37d0f "PCI/ASPM: Disable ASPM on MFD function
> removal to avoid use-after-free")
> 
> Let's say root port 00:03.0 was connected to a PCIe switch.
>        
> [00]-+..
>       |
>       +--03.0-[01-03]--+-00.0-[02-03]--+-02.0-[02]--x
>       |                |               \-0d.0-[03]----00.0  Endpoint
>       .                +-00.1  Upstream Port Sibling
> 
> And that switch had not only an upstream port at 01:00.0, but also a
> sibling function at 01:00.1.
> 
> Let's break the link under 00:03.0, which makes pciehp remove the [01]
> bus. Surprise effect: traversal during bus [01] device removal happens
> in reverse order (for SR-IOV-ish reasons, see pciehp_pci.c
> commentary). Fair enough, ASPM should probably not rely on any
> specific order anyway.
> 
> Recursing through pci_remove_bus_device() underneath, the order in
> which we pci_destroy_dev() will be:
> 
>     [ 01:00.1 [ 02:02.0 [ 03:00.0 ] 02:0d.0 ] 01:00.0 ]
> 
> Trivially, the above is also the order in which
> pcie_aspm_exit_link_state() will be called.
> 
> Then note how, since above change removed the list_empty() exit
> condition, we are now going to remove the pcie_link_state for bus [01]
> (parent=<00:03.0>) during the first invocation, i.e. right at
> pcie_aspm_exit_link_state(<01:00.1>).
> 
> Iow: with bus [03] removal only to come, we removed the
> pcie_link_state upstream first, and only then will remove the
> downstream pcie_link_state at parent=<02:0d.0>.
> 
> Eventually reaching that second link, it carries a ref "parent_link =
> link->parent" which now points to free'd memory again. One can observe
> a rather high probability of finishing with a random GPF or nullptr
> dereference condition.
> > Above switches, with MFD upstream portions, exist. Case at hand is a
> PEX8717 with 4 DMA engines:
> 
>    +-08.0-[51-5b]--+-00.0-[52-5b]--+-02.0-[53]--
>                    |               \-0d.0-[54-5b]----00.0  Broadcom Inc. …
>                    +-00.1  PLX Technology, Inc. PEX PCI Express Switch DMA interface
>                    +-00.2  PLX Technology, Inc. PEX PCI Express Switch DMA interface
>                    +-00.3  PLX Technology, Inc. PEX PCI Express Switch DMA interface
>                    \-00.4  PLX Technology, Inc. PEX PCI Express Switch DMA interface
> 
> Backtrace:
> 
> [  790.817077] BUG: kernel NULL pointer dereference, address: 00000000000000a0
> [  790.900514] #PF: supervisor read access in kernel mode
> [  790.962081] #PF: error_code(0x0000) - not-present page
> [  791.023641] PGD 8000000104648067 P4D 8000000104648067 PUD 1404bc067 PMD 0
> [  791.106041] Oops: 0000 [#1] PREEMPT SMP PTI
> [  791.156151] CPU: 8 PID: 145 Comm: irq/43-pciehp Tainted: G           OE      6.1.0-22-2-amd64 #5  Debian 6.1.94-1
> [  791.279173] Hardware name: Intel Camelback Mountain CRB/Camelback Mountain CRB, BIOS Aboot-norcal7-7.1.6-generic-22971530 06/30/2021
> [  791.421982] RIP: 0010:pcie_config_aspm_link+0x48/0x330
> [  791.483548] Code: 48 8b 04 25 28 00 00 00 48 89 44 24 30 31 c0 8b 47 30 4c 8b 47 08 83 e3 7f c1 e8 0e f7 d3 89 c2 83 e0 7f 21 c3 83 e2 7f 21 f3 <41> 8b b6 a0 00 00 00 89 d8 83 e0 87 f6 c3 04 0f 44 d8 0f b7 47 30
> [  791.708646] RSP: 0018:ffffa8cf8062bcb8 EFLAGS: 00010246
> [  791.771254] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  791.856772] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94bac3d56a80
> [  791.942291] RBP: ffff94bac3d56a80 R08: 0000000000000000 R09: ffffa8cf8062bc6c
> [  792.027808] R10: 0000000000000000 R11: 0000000000000004 R12: ffff94b9c0f61fc0
> [  792.113326] R13: ffff94bbc0ae9828 R14: 0000000000000000 R15: ffff94b9c0ea6f20
> [  792.198845] FS:  0000000000000000(0000) GS:ffff94c8ffc00000(0000) …
> [  792.295827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  792.364680] CR2: 00000000000000a0 CR3: 00000001062fe003 CR4: 00000000003706e0
> [  792.450198] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  792.535717] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  792.621235] Call Trace:
> [  792.650506]  <TASK>
> [  792.675616]  ? __die_body.cold+0x1a/0x1f
> [  792.722600]  ? page_fault_oops+0xd2/0x2b0
> [  792.770625]  ? sysvec_apic_timer_interrupt+0xa/0x90
> [  792.829068]  ? exc_page_fault+0x70/0x170
> [  792.876051]  ? asm_exc_page_fault+0x22/0x30
> [  792.926161]  ? pcie_config_aspm_link+0x48/0x330
> [  792.980437]  pcie_aspm_exit_link_state+0xb9/0x120
> [  793.036796]  pci_remove_bus_device+0xc8/0x110
> [  793.088988]  pci_remove_bus_device+0x2e/0x110
> [  793.141180]  pci_remove_bus_device+0x3e/0x110
> [  793.193373]  pciehp_unconfigure_device+0x94/0x160
> [  793.249733]  pciehp_disable_slot+0x69/0x100
> [  793.299840]  pciehp_handle_presence_or_link_change+0x241/0x350
> [  793.369742]  pciehp_ist+0x164/0x170
> [  793.411524]  ? disable_irq_nosync+0x10/0x10
> [  793.461632]  irq_thread_fn+0x1f/0x60
> [  793.504449]  irq_thread+0xfa/0x1c0
> [  793.545185]  ? irq_thread_fn+0x60/0x60
> [  793.590085]  ? irq_thread_check_affinity+0xf0/0xf0
> [  793.647485]  kthread+0xda/0x100
> [  793.685096]  ? kthread_complete_and_exit+0x20/0x20
> [  793.742495]  ret_from_fork+0x22/0x30
> [  793.785314]  </TASK>
> 
> Daniel Stodden (1):
>    PCI/ASPM: fix link state exit during switch upstream function removal.
> 
>   drivers/pci/pcie/aspm.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 




