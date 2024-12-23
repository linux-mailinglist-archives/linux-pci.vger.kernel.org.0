Return-Path: <linux-pci+bounces-18948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE83C9FA9C7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 04:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DFC18860C4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9F28F1;
	Mon, 23 Dec 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dik6DGWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B4179BC
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734925179; cv=none; b=g1/A2u2edibAY+9vX5OvCD2XzZiby2iXgncxfoEC/y0HCBQCSI6ILnQm2uWazGlKDazHOC+TXi4fpd080zfRmsnEIIH85thVmP4CCHXBk9XPoepouJP2p49iZj0ZyalTyRyCJwo1f74lCQG5A473p2yKqFl1GVRLKamgF1zPaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734925179; c=relaxed/simple;
	bh=jBaSmkEDSMRh/bJu1zZxgjWmBllrGMjn+9rsFaeRqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xsb9IMJ+Y9dkVqX0xWxAfjgarBzzjdfkcR29iDaMiDz1YJaO4A1Gm5KwRqZ//E+OVgx7SLE4DGEs4S+xw7KN4jWLqa1MLu8g5yCuVp/r6OlYVNRO8SFpV4EOc2a0nxUMhTKEPYy6ygwshrMqvY4ppoyBW6c7JGtPtJAH1q5+5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dik6DGWJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso31443685ad.3
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 19:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1734925177; x=1735529977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh1F/n81FGcKrm8w489tsF1X17mb5O1clFq3h62SE+8=;
        b=dik6DGWJD0USMQ45pYMfpWjROtTqJ6W7KA8pbw9sm1QGf3rRRfNeAiWZoiuJqf1D/o
         rEfiyGSQNO+sUZq5ZhXPtUIr4b5HwBu1o7SDBSWpkiKbpSLOQQaUxJcjBFc5w+H9XRIg
         Zy0ZhuCYWJ4cJGPGYbEvaHrSGsct7tb42b8h4NmdaHwHvN6cgMrKvYAjrsVapNC4p4kJ
         Evh98UEmnhYLzv9O9ZCEBJHOUzLXllr1ljtO7ZgxVmNYeK/w1bMP71tv6p3djXrQXny4
         s0Yy0Uoyt5gkmI8I/TvEteI44xJp/aMX/MX06tdcpz6z5vrfqbjO2+225Tcae5RjSuQ8
         52QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734925177; x=1735529977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh1F/n81FGcKrm8w489tsF1X17mb5O1clFq3h62SE+8=;
        b=xSsLBt37lVasx4bkStBRWV7CjjKSQ3jgGpLXKiqCW9B8bgq4DUbBt64AqkAPelY7AE
         pYTEc2QDd1MQiKnLHgoZHBknJhYRAl2+Dv22hVzs1hkMnfnC71nGJJaJle6XBU1AsExD
         yBB1XAgnKCBKE3vS/FI83K0J1cEdroZ68ISJVjDuPe4Ho18eq0E6dwslAuPvNpKu7Sy7
         ON1gnV8vIseDOhiQtnYrFcykWLh6lPpoadGr1TdOoB1Odb9PHFrkSf/SRZVN07SZPbJ6
         4yyivz8KyU2sgZkF18wAomCENgnudbSua2cOwl3oDgVboJ1/W14EW5jGYIltnBOyITXN
         A/1A==
X-Forwarded-Encrypted: i=1; AJvYcCXxocSkGxJblmbJHBUgdAvc2DzDs9WAzqX3zIaCQuaFhbaMJW9PY92iCUDyJTX3uU9CLVarpXLOKmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01xTapJOqTxY5oFWhf2N5A0dmkWjZCR70inlBtgXs9AMOKe3s
	dcyEO/+rJq3CeLLD7vu7PDvYHFGfF5xDTqdPsGUsIX1bfWuYCeyASeFNi6Tx2Q==
X-Gm-Gg: ASbGncsa8hhNhEMD8eA1nNPGElhdx8B+KYXMAzYyojr3eGmdNq/gQloijeHbZdDu4ZE
	JO0mR4C69heHT2WWRrehaMFEFZs/dHi/hIeRkXoeY6F1JrjFqIRMYc6cPbkr0D1JesVEVQ1kNPM
	sKI8D2kPYGHhdivP2jwksRW4CvaAOE4w4GZsRyYUSxHjF0gY4VmUfprztY2+PvTESAmh9IZ5WEs
	WDMilwwJhBVeCqcoX99YL3xvPdWYUSU0iYW6PIVAp8+Md6ve2O8CIr2qJLqs8OEa/FZhl3ewuRo
	cv87RQMa
X-Google-Smtp-Source: AGHT+IGweHI7vysTBGD+M9mrgr7p/F7E9+Rnih9FJFsKFOJg+4mpc2T7wvLwrtasWeK21gUO2E6R2g==
X-Received: by 2002:a17:902:db0f:b0:215:9379:4650 with SMTP id d9443c01a7336-219e6f10958mr171532675ad.42.1734925176826;
        Sun, 22 Dec 2024 19:39:36 -0800 (PST)
Received: from dns-eos-trunk-123.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e91sm63616025ad.274.2024.12.22.19.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 19:39:36 -0800 (PST)
From: Daniel Stodden <dns@arista.com>
To: dinghui@sangfor.com.cn
Cc: Daniel Stodden <dns@arista.com>,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	kai.heng.feng@canonical.com,
	linux-pci@vger.kernel.org,
	michael.a.bottini@linux.intel.com,
	qinzongquan@sangfor.com.cn,
	rajatja@google.com,
	refactormyself@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	vidyas@nvidia.com
Subject: [PATCH 0/1] Re: PCI/ASPM: Fix UAF by disabling ASPM for link when child function is removed
Date: Sun, 22 Dec 2024 19:39:07 -0800
Message-ID: <cover.1734924854.git.dns@arista.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20230507034057.20970-1-dinghui@sangfor.com.cn>
References: <20230507034057.20970-1-dinghui@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

About change 456d8aa37d0f "PCI/ASPM: Disable ASPM on MFD function
removal to avoid use-after-free")

Let's say root port 00:03.0 was connected to a PCIe switch.
      
[00]-+..
     |
     +--03.0-[01-03]--+-00.0-[02-03]--+-02.0-[02]--x
     |                |               \-0d.0-[03]----00.0  Endpoint
     .                +-00.1  Upstream Port Sibling

And that switch had not only an upstream port at 01:00.0, but also a
sibling function at 01:00.1.

Let's break the link under 00:03.0, which makes pciehp remove the [01]
bus. Surprise effect: traversal during bus [01] device removal happens
in reverse order (for SR-IOV-ish reasons, see pciehp_pci.c
commentary). Fair enough, ASPM should probably not rely on any
specific order anyway.

Recursing through pci_remove_bus_device() underneath, the order in
which we pci_destroy_dev() will be:

   [ 01:00.1 [ 02:02.0 [ 03:00.0 ] 02:0d.0 ] 01:00.0 ]

Trivially, the above is also the order in which
pcie_aspm_exit_link_state() will be called.

Then note how, since above change removed the list_empty() exit
condition, we are now going to remove the pcie_link_state for bus [01]
(parent=<00:03.0>) during the first invocation, i.e. right at
pcie_aspm_exit_link_state(<01:00.1>).

Iow: with bus [03] removal only to come, we removed the
pcie_link_state upstream first, and only then will remove the
downstream pcie_link_state at parent=<02:0d.0>.

Eventually reaching that second link, it carries a ref "parent_link =
link->parent" which now points to free'd memory again. One can observe
a rather high probability of finishing with a random GPF or nullptr
dereference condition.

Above switches, with MFD upstream portions, exist. Case at hand is a
PEX8717 with 4 DMA engines:

  +-08.0-[51-5b]--+-00.0-[52-5b]--+-02.0-[53]--
                  |               \-0d.0-[54-5b]----00.0  Broadcom Inc. …
                  +-00.1  PLX Technology, Inc. PEX PCI Express Switch DMA interface
                  +-00.2  PLX Technology, Inc. PEX PCI Express Switch DMA interface
                  +-00.3  PLX Technology, Inc. PEX PCI Express Switch DMA interface
                  \-00.4  PLX Technology, Inc. PEX PCI Express Switch DMA interface

Backtrace:

[  790.817077] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  790.900514] #PF: supervisor read access in kernel mode
[  790.962081] #PF: error_code(0x0000) - not-present page
[  791.023641] PGD 8000000104648067 P4D 8000000104648067 PUD 1404bc067 PMD 0
[  791.106041] Oops: 0000 [#1] PREEMPT SMP PTI
[  791.156151] CPU: 8 PID: 145 Comm: irq/43-pciehp Tainted: G           OE      6.1.0-22-2-amd64 #5  Debian 6.1.94-1
[  791.279173] Hardware name: Intel Camelback Mountain CRB/Camelback Mountain CRB, BIOS Aboot-norcal7-7.1.6-generic-22971530 06/30/2021
[  791.421982] RIP: 0010:pcie_config_aspm_link+0x48/0x330
[  791.483548] Code: 48 8b 04 25 28 00 00 00 48 89 44 24 30 31 c0 8b 47 30 4c 8b 47 08 83 e3 7f c1 e8 0e f7 d3 89 c2 83 e0 7f 21 c3 83 e2 7f 21 f3 <41> 8b b6 a0 00 00 00 89 d8 83 e0 87 f6 c3 04 0f 44 d8 0f b7 47 30
[  791.708646] RSP: 0018:ffffa8cf8062bcb8 EFLAGS: 00010246
[  791.771254] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  791.856772] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94bac3d56a80
[  791.942291] RBP: ffff94bac3d56a80 R08: 0000000000000000 R09: ffffa8cf8062bc6c
[  792.027808] R10: 0000000000000000 R11: 0000000000000004 R12: ffff94b9c0f61fc0
[  792.113326] R13: ffff94bbc0ae9828 R14: 0000000000000000 R15: ffff94b9c0ea6f20
[  792.198845] FS:  0000000000000000(0000) GS:ffff94c8ffc00000(0000) …
[  792.295827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  792.364680] CR2: 00000000000000a0 CR3: 00000001062fe003 CR4: 00000000003706e0
[  792.450198] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  792.535717] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  792.621235] Call Trace:
[  792.650506]  <TASK>
[  792.675616]  ? __die_body.cold+0x1a/0x1f
[  792.722600]  ? page_fault_oops+0xd2/0x2b0
[  792.770625]  ? sysvec_apic_timer_interrupt+0xa/0x90
[  792.829068]  ? exc_page_fault+0x70/0x170
[  792.876051]  ? asm_exc_page_fault+0x22/0x30
[  792.926161]  ? pcie_config_aspm_link+0x48/0x330
[  792.980437]  pcie_aspm_exit_link_state+0xb9/0x120
[  793.036796]  pci_remove_bus_device+0xc8/0x110
[  793.088988]  pci_remove_bus_device+0x2e/0x110
[  793.141180]  pci_remove_bus_device+0x3e/0x110
[  793.193373]  pciehp_unconfigure_device+0x94/0x160
[  793.249733]  pciehp_disable_slot+0x69/0x100
[  793.299840]  pciehp_handle_presence_or_link_change+0x241/0x350
[  793.369742]  pciehp_ist+0x164/0x170
[  793.411524]  ? disable_irq_nosync+0x10/0x10
[  793.461632]  irq_thread_fn+0x1f/0x60
[  793.504449]  irq_thread+0xfa/0x1c0
[  793.545185]  ? irq_thread_fn+0x60/0x60
[  793.590085]  ? irq_thread_check_affinity+0xf0/0xf0
[  793.647485]  kthread+0xda/0x100
[  793.685096]  ? kthread_complete_and_exit+0x20/0x20
[  793.742495]  ret_from_fork+0x22/0x30
[  793.785314]  </TASK>

Daniel Stodden (1):
  PCI/ASPM: fix link state exit during switch upstream function removal.

 drivers/pci/pcie/aspm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.47.0


