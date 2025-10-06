Return-Path: <linux-pci+bounces-37625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39630BBF036
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003C118911DF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0962376EB;
	Mon,  6 Oct 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i3ClO5jk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753A1F7098;
	Mon,  6 Oct 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776368; cv=none; b=YGkDrpxr/XJACpQD0GHJOBnSpa7zuxxvyHFsBn2ONxj7/aozHc4pKVnEHHVh/p0/JME3GjzTYe003GaIHLYvg+TcNTlaC1DalLpwLvdXOtrzOgChZPRqSsXmL1YE+nkis2Iso6YXq4xmjmMNHgaOxJARQE8oL7jTNebhFnds1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776368; c=relaxed/simple;
	bh=ji018SfjwN2M+GQX18OazxVjUwdrp8zoeY53TXXqyco=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RDFRGJVqIHPH1a1VHfLPqJ25vqwLNoEM6wxi3h0S6MVHVFTSE4CDFmd2TtdQzMv0N+crYGW5S7p9gMVZQSD7F+D169frhJB1Imuwnk3uN7al6VApzvOASDF1rQB9qlsikJaSCF6/GNONJ7hpPehe/9+nQf/QbGFyye6stsD9UKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i3ClO5jk; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759776054; bh=bZ3DcGJ+3f3q61fb0vjsoxJFDfw3N9Ux8Yh2qfDnDUM=;
	h=From:To:Cc:Subject:Date;
	b=i3ClO5jkLjKeKrWTOIK63M40+zh6HnN7+UQ3tk00lljO6uniGsF20fnP78Hir2QhA
	 cTvwD76kMVtjQZ2c/QraJBgZ5S6yOwTLv/mv+mls/Cl16funYAAhZxLtRffAF0aapM
	 DTl2HZxjx528pcdgrLS8rM6rJmirzvgGmy4+0h5A=
Received: from localhost.localdomain ([113.102.239.212])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 8AAA6AD2; Tue, 07 Oct 2025 02:34:42 +0800
X-QQ-mid: xmsmtpt1759775682tu8rjbowu
Message-ID: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
X-QQ-XMAILINFO: Nr4sKL92GIu+xw0M0OARNyF+E4+Q6kKkdYlgvVFn21lPEPwycQ8X9mZKdqBnWg
	 CjGz+Aeyqmvsafo24cOfWru0TwE1wW0BO74CxxmKfnfZ0EaBOuJR7OnZnkgE1J0fI4FtqzZKKXP4
	 bpwvGshsTHCeuC00dAqjSODOZJM0GoQ/nPoq7/dKndSVgMU9Rklptcan0h0uULL3IgOb4MxL+Bx0
	 SxbiAxqlE1nU8zdBYPIMCXU7tjM+kHTC7BPrQRuTBqLOvwrh9Cg2OnhvImxkMPFsBNx36X5FILeE
	 IP3oVBn1+UNC22xC+Qdld27GW9qovPLAb3lPsIOh9g7Zq5lUVF9Djpthb4q2bZcbPWyHYQifU8BE
	 6nNf3DGpdrRbwM/vOlYD24afYN8s+iVRrJcF8qKuCL6MhDfyefJzaiTKuWz/C5AsWNn7iaGKxMIT
	 OBd0630UgAED9xYoLg+nOpI7OvdR7MbrQylRHk2dCpYKADjRQKui4bg1AGy70iWmbXdCnrqt8MHI
	 Ls7c97g3fq+0Qsygi7oBCNFmCRvBGj1c4lnHbZ0EOV+aepdVCMAvxnU2xdUw4Y3ySHYuCe34HQ6X
	 Mmq9aRkUzr1R0YFy5a2EdWNhwLLNBuqq3laAOBGWYMJVH3vcjWAYctDGKiPxq3kzuvj4v1tsLWnC
	 TKrA4BKsOkszwRoE5MVscrVlFqs0nL+vqV9dnORSxRt9tDuDl2p2FxfEVwKqIeta0wEppdRQn6/+
	 9TFylGuaNusZ7CicdQqDnp6x9pSrf0ljSfSp4Ejz3/R5YP0XkRcddh4lAQTFpAmslikHIX0Q/Lby
	 ESGc60m4T38R5ILqzrIhNOqs6q+NeaILUGTlrgjE10AkFsqDhYK/3KmmpY+xWDJasNGeGlTajcNX
	 Q2uMKYNdxQJ0lxKhn4ecZJWO5b288c9TatzlTFkp5ZeC9zmva27fusX8tsMOxa/b7OQTnn/D5uXG
	 CCMQp3QwmmXZVNALrdOE0jzGz9mQ+6HVzJHvKSM0dEAaZc5Eb4AUYwbqq7BzaPxN4kEMP43NZ6wh
	 buizhcin5P7YEN/lo8GsBzocO5cZ4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Guangbo Cui <2407018371@qq.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <2407018371@qq.com>
Subject: [PATCH] lockdep: Account for lockdep hardirq context in irq_forced_thread_fn under PREEMPT_RT
Date: Mon,  6 Oct 2025 18:34:09 +0000
X-OQ-MSGID: <20251006183408.41851-2-2407018371@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In PREEMPT_RT, IRQs are forced to run in threaded. However, lockdep did not correctly
account for this case, causing false-positive warnings about hardirq context violations
when analyzing lock acquisition in such threaded IRQs (see function `task_wait_context`).

This patch updates `irq_forced_thread_fn` to explicitly call `lockdep_hardirq_enter()`
and `lockdep_hardirq_exit()` when PREEMPT_RT is enabled, ensuring lockdep correctly
tracks the hardirq context even when the IRQ is executed in a forced thread.

This was discovered while testing PCIe AER error injection on an arm64 QEMU virtual machine:

```
  qemu-system-aarch64 \
      -nographic \
      -machine virt,highmem=off,gic-version=3 \
      -cpu cortex-a72 \
      -kernel arch/arm64/boot/Image \
      -initrd initramfs.cpio.gz \
      -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc earlyprintk nokaslr" \
      -m 2G \
      -smp 1 \
      -netdev user,id=net0,hostfwd=tcp::2223-:22 \
      -device virtio-net-pci,netdev=net0 \
      -device pcie-root-port,id=rp0,chassis=1,slot=0x0 \
      -device pci-testdev -s -S
```

Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
report with "Invalid wait context" in the irq/PCIe thread.

```
~ # export HEX="00020000000000000100000000000000000000000000000000000000"
~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
[ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
[ 1850.949951]
[ 1850.950479] =============================
[ 1850.950780] [ BUG: Invalid wait context ]
[ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
[ 1850.951457] -----------------------------
[ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
[ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
[ 1850.952731] other info that might help us debug this:
[ 1850.952997] context-{5:5}
[ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
[ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
[ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
[ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
[ 1850.955932] stack backtrace:
[ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
[ 1850.957039] Hardware name: linux,dummy-virt (DT)
[ 1850.957409] Call trace:
[ 1850.957727]  show_stack+0x18/0x24 (C)
[ 1850.958089]  dump_stack_lvl+0x40/0xbc
[ 1850.958339]  dump_stack+0x18/0x24
[ 1850.958586]  __lock_acquire+0xa84/0x3008
[ 1850.958907]  lock_acquire+0x128/0x2a8
[ 1850.959171]  rt_spin_lock+0x50/0x1b8
[ 1850.959476]  aer_inj_read_config+0x38/0x1dc
[ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
[ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
[ 1850.960454]  pcie_pme_irq+0x44/0xc4
[ 1850.960728]  irq_forced_thread_fn+0x30/0x94
[ 1850.960984]  irq_thread+0x1ac/0x3a4
[ 1850.961308]  kthread+0x1b4/0x208
[ 1850.961557]  ret_from_fork+0x10/0x20
[ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
[ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
[ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
```

Signed-off-by: Guangbo Cui <2407018371@qq.com>
---
 kernel/irq/manage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037..80007bce5625 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1150,9 +1150,13 @@ static irqreturn_t irq_forced_thread_fn(struct irq_desc *desc, struct irqaction
 	local_bh_disable();
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
+	else
+		lockdep_hardirq_enter();
 	ret = irq_thread_fn(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
+	else
+		lockdep_hardirq_exit();
 	local_bh_enable();
 	return ret;
 }
-- 
2.43.0


