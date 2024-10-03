Return-Path: <linux-pci+bounces-13744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA298E877
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589861C22227
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E76E17579;
	Thu,  3 Oct 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CmQRBUwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0C17C9B
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922865; cv=pass; b=c1blDhaHgOQ8FysgQ6sDhEon3J8xdUoKTUV1OI03klB8vHf4PDdHM1hgXcdPmPloM0rLDIJ5MDvjejuRSng3C5f1HE9USAe6kJ9GmnntzV+bt8KlxWVGzzSsvi1nz8m6ac7CqQ655vrCzc0vu5cXDbR+GLRLdTOBupCTqt7ew5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922865; c=relaxed/simple;
	bh=bs5umPPmxQSnLAeS/dOFPLjUfrWrJW35OZ0NX3D+Jyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb/FezhxU6mL5D8iTZsP5gel1OCuFAEaXXE4hUr+Yi6AlsaQjs5s097OACCFhDbVJ7MWew8eYe8jfmHB1afm0TgPzcxINrOYqQofdfJ8FFrIZfx8AcftM8dHLSThlqrRqEiEizWz6qnYFwA2Mf+shV0SFc+mtlk9J8QRJeIOWg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=CmQRBUwq; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9F441C3BFA;
	Thu,  3 Oct 2024 02:34:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a224.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.99.101.170])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2728BC3B1B;
	Thu,  3 Oct 2024 02:34:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727922857; a=rsa-sha256;
	cv=none;
	b=rqvHN4XHXpLZTG1E8BVmvaSmlBpdKlfMosNWkph7CTrpFRmxSzU/xKU8nJ0LGF3f/zblnU
	nTwCn3UWuwYSYE27IKKEH7k7lNAzfmtq67xKPKstg/cT2vf0e2ttJ5MlJAsBO5bBIrjXnF
	ioNmD0CnGVMJNQyzcpaMz4pOWvQ4d4Cpe//dmopB2lQgmDC0DcBqJDm399SdBYj/Frwb5P
	4caXGHSswbjKjrS+eyLgVZT4YjiHnrL6QJpjjJlgsV8mXgtZ9NTN3nNKP440TVWGRdXaBh
	bGE+0MyVGUipkgbC+BRZTXehygosPxYQG4kDlc727kLdNGOf/ohL8bc+r0P1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727922857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=59jJHotz01TSRpwOe9j5G6MKJnybc5O1Vtx6V+1440s=;
	b=TH32PLpCWhw7FCLS6samjMUSDMNPHrCFtykTulWdnpQdP7L4iua8WHX4AqixKTYiJNtBg5
	FLGca1ZbpmlbIbAyKYdxABTrks5BFHp83RDh1Ab0PWOoBz5PfZhqn4rMkYnohBc97CWcmo
	lh3/gTHZmm9iv/al0Q+rpCwsjM5B4Ybw+2nWK/Tf053E9Rp87l/XRn8g05IhIno3eyEw91
	OiNFb5wBXve4k/I0heakPWRaDPtXn3QaJBVhcHREhS+9DA/cPh7KWMet0QPm183lSPX2lK
	utC/oug4b2BJAytlcB1KckXrMXQWv6IoIs8/Q+ydq/eoIbwBhWWZXfSIyScLCw==
ARC-Authentication-Results: i=1;
	rspamd-784544597-fxbbs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Spicy: 7c21fed66de5fec7_1727922857413_8736894
X-MC-Loop-Signature: 1727922857413:1614150829
X-MC-Ingress-Time: 1727922857413
Received: from pdx1-sub0-mail-a224.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.101.170 (trex/7.0.2);
	Thu, 03 Oct 2024 02:34:17 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a224.dreamhost.com (Postfix) with ESMTPSA id 4XJwjh51G7zFH;
	Wed,  2 Oct 2024 19:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727922857;
	bh=59jJHotz01TSRpwOe9j5G6MKJnybc5O1Vtx6V+1440s=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CmQRBUwqsRMW7ieZFXmBxVqFfugmB09+tWZG4TmesSPT9TpkHObKn+xbtgRdj/7ge
	 w9K/aRDQxbhoouHR3aPX16VclMs9zdrYoO1XhTCZuP098UW8zz1ArDo1253M6J4urw
	 /FlZT5frFpcF0slXPTdDiN7gIo+9lKmg24rBYMksm6r/u1FLQrj/wrOiWA7fYNf6vc
	 6FlNlyDTKv+/bPYJIi+/jGBD3lC9DCLzK+ptW3iuFxQsoAMmWL8ueocEhEL+N47Mpo
	 sZx1srMNGiENWtAa8J2O4aemNvs8qa6GRGG09TVGr2McHrSQST86CkMt6ReH33+WgQ
	 WtGb30bSfxsYA==
Date: Wed, 2 Oct 2024 19:34:13 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <20241003023354.txfw7w4ud247h5va@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827192826.710031-3-kbusch@meta.com>
User-Agent: NeoMutt/20220429

On Tue, 27 Aug 2024, Keith Busch wrote:

>+static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>+{
>+	return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
>+}

Same ordering/dependency description observations as mentioned in
patch 1 (both these cases are fully ordered).

>+
> #ifdef CONFIG_PCIEAER
> #include <linux/aer.h>
>
>diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>index ec3064a115bf8..8284ab20949c9 100644
>--- a/drivers/pci/remove.c
>+++ b/drivers/pci/remove.c
>@@ -29,7 +29,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>
> static void pci_destroy_dev(struct pci_dev *dev)
> {
>-	if (!dev->dev.kobj.parent)
>+	if (pci_dev_test_and_set_removed(dev))

Doesn't this want to be if (!pci_dev_test_and_set_removed()) ?

This also fixes a splat when triggering a removal when you add
subordinate refcounting is added:

https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?h=pci-bus-locking-2024-09-09&id=3883c485d5e45b5e17f685f77ff4020bec162336

fyi:

[   22.739614] BUG: kernel NULL pointer dereference, address: 0000000000000028
[   22.739910] #PF: supervisor read access in kernel mode
[   22.740132] #PF: error_code(0x0000) - not-present page
[   22.740351] PGD 0 P4D 0
[   22.740468] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[   22.740695] CPU: 0 UID: 0 PID: 266 Comm: bash Tainted: G    B              6.11.0-rc1-g3883c485d5e4-dirty #13
[   22.741111] Tainted: [B]=BAD_PAGE
[   22.741258] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   22.741727] RIP: 0010:pcie_aspm_check_latency.isra.0+0x192/0x4d0
[   22.741990] Code: 18 e8 e2 6f 6f ff 48 89 df e8 aa ad 92 ff 4c 8b 2b 49 8d 7d 18 e8 9e ad 92 ff 49 8b 6d 18 4c 8d 65 28 4c f
[   22.743438] RSP: 0018:ffff88800554f970 EFLAGS: 00010282
[   22.743673] RAX: 0000000000000001 RBX: ffff888001cc0c80 RCX: 0000000000000001
[   22.743976] RDX: ffff88804c63ce00 RSI: 0000000000000000 RDI: 0000000000000007
[   22.744285] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff7b7275c
[   22.744596] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000028
[   22.744906] R13: ffff888001f62000 R14: 0000000000000040 R15: 00000000000003e8
[   22.745216] FS:  00007f14a687f740(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
[   22.745565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.745823] CR2: 0000000000000028 CR3: 000000004dc06000 CR4: 00000000000006f0
[   22.746132] Call Trace:
[   22.746246]  <TASK>
[   22.746346]  ? show_regs+0x8c/0xa0
[   22.746507]  ? __die+0x2c/0x80
[   22.746652]  ? page_fault_oops+0x31a/0x830
[   22.746839]  ? __pfx_page_fault_oops+0x10/0x10
[   22.747042]  ? is_prefetch.constprop.0+0x9b/0x450
[   22.747253]  ? pcie_aspm_check_latency.isra.0+0x192/0x4d0
[   22.747495]  ? __pfx_is_prefetch.constprop.0+0x10/0x10
[   22.747725]  ? pcie_aspm_check_latency.isra.0+0x192/0x4d0
[   22.747966]  ? search_module_extables+0x93/0xc0
[   22.748173]  ? fixup_exception+0xd7/0x560
[   22.748358]  ? kernelmode_fixup_or_oops.constprop.0+0x9c/0xc0
[   22.748613]  ? __bad_area_nosemaphore+0x2f8/0x420
[   22.748826]  ? lock_mm_and_find_vma+0x90/0x4f0
[   22.749028]  ? do_user_addr_fault+0x58a/0xc80
[   22.749226]  ? rcu_is_watching+0x20/0x50
[   22.749407]  ? exc_page_fault+0x5c/0xd0
[   22.749586]  ? asm_exc_page_fault+0x26/0x30
[   22.749776]  ? pcie_aspm_check_latency.isra.0+0x192/0x4d0
[   22.750020]  ? __pfx_pcie_aspm_check_latency.isra.0+0x10/0x10
[   22.750278]  ? mark_held_locks+0x65/0x90
[   22.750457]  ? kobject_get+0x95/0x110
[   22.750629]  pcie_update_aspm_capable+0x128/0x1c0
[   22.750843]  pcie_aspm_exit_link_state+0x137/0x1e0
[   22.751059]  pci_remove_bus_device+0x15b/0x200
[   22.751260]  pci_remove_bus+0x4a/0x130
[   22.751432]  pci_remove_bus_device+0x88/0x200
[   22.751631]  pci_remove_bus+0x4a/0x130
[   22.751802]  pci_remove_bus_device+0x88/0x200
[   22.752000]  pci_remove_bus+0x4a/0x130
[   22.752172]  pci_remove_bus_device+0x88/0x200
[   22.752370]  pci_stop_and_remove_bus_device_locked+0x22/0x30
[   22.752622]  remove_store+0x125/0x140
[   22.752791]  ? __pfx_remove_store+0x10/0x10
[   22.752981]  ? __pfx___mutex_lock+0x10/0x10
[   22.753170]  ? __pfx__copy_from_iter+0x10/0x10
[   22.753372]  ? __pfx_remove_store+0x10/0x10
[   22.753562]  dev_attr_store+0x46/0x70
[   22.753752]  ? __pfx_dev_attr_store+0x10/0x10
[   22.753965]  sysfs_kf_write+0xa0/0xc0
[   22.754142]  kernfs_fop_write_iter+0x23d/0x300
[   22.754346]  ? __pfx_sysfs_kf_write+0x10/0x10
[   22.754549]  vfs_write+0x508/0xa90
[   22.754709]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   22.754935]  ? __pfx_vfs_write+0x10/0x10
[   22.755118]  ? __fget_light+0xcd/0x120
[   22.755295]  ksys_write+0x108/0x200
[   22.755458]  ? __pfx_ksys_write+0x10/0x10
[   22.755644]  ? mark_held_locks+0x24/0x90
[   22.755826]  do_syscall_64+0xc1/0x1d0
[   22.755998]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   22.756229] RIP: 0033:0x7f14a697a240
[   22.756394] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 9
[   22.757184] RSP: 002b:00007ffdc41b64e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   22.757508] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f14a697a240
[   22.757813] RDX: 0000000000000002 RSI: 0000558b25aeda50 RDI: 0000000000000001
[   22.758117] RBP: 0000558b25aeda50 R08: 00007f14a6a54d90 R09: 00007f14a6a54d90
[   22.758422] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[   22.758726] R13: 00007f14a6a55760 R14: 0000000000000002 R15: 00007f14a6a509e0
[   22.759039]  </TASK>

>		return;
>
>	device_del(&dev->dev);
>--
>2.43.5
>

