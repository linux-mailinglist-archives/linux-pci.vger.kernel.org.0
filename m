Return-Path: <linux-pci+bounces-37767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87358BC9B27
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8B189958B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AF2EC097;
	Thu,  9 Oct 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThOjMvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479A2EC0A7
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022431; cv=none; b=bO2bHFK5kke90WqTP4d6WRodi0ro2loubdrGzVs1gTR2//1l5BXwov7Gc7ss4dCxO1QrOc7YoXpc6vHn5S7ENl2TudO9gHvarEVxE3ak6fYdGgV8+1KQO+4lgWT9UBhsval81N00z0wP3l3/O0Kjch3XvnlLbW7lkjup6bl/Tv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022431; c=relaxed/simple;
	bh=MCV/UPvicPJb69eUQgmnsoFbwCslV+n9NPE5LP4vs4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OnnHH7HKVXoil06iQlNHxgsIMmHcCXytft7BTvwasIh1TEwTtnoLbhz9oQhjIKKCemTcuVzVeTOZ4ZszslV2GXEZm91I7T9oI6pVzaAQLoHQvSsk88KcDXKo5XYYrW6f/YUvHQgEvxnvyqLX3ww6RtYolaBQqSHQFPCsq/SAt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThOjMvF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78af9ebe337so830032b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Oct 2025 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760022427; x=1760627227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMhg/akYhh9FLVNXWkmixFsJkM0F7NIHl3Wh7qHVX1c=;
        b=LThOjMvF7B93cWo8/qiqTGd7/dWqB+i+Z4vl7Cf3EGr8Y0r6vh0eY2J/r9M5tVqwnx
         HjnYycY+2wSgxoiAAxw/WXntH4Ti4NFExFRDW3/dm9Mjt+mAQGw5knbzC4W1VUGiG4Qh
         6H6RNJUkxs9/YpKp/jeTmarJv2Gn71H2dpQU8cBRQNkrxEqneTNC18399EqASwLXHjBz
         HXHJOpZ+8r9/Xxp1OaEM7Pq86eiv74Qe33iM18S+twyYh/k4CGfqTMM6qdxZsCF2cx/6
         55F7qsBQTJpxp7Kq9QRq0qDDHRAgDpQVlQVfiWydckHJ5bBdB+ZU0IUwp9TOI1XFLx4x
         2RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022427; x=1760627227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMhg/akYhh9FLVNXWkmixFsJkM0F7NIHl3Wh7qHVX1c=;
        b=P+vj5hi+8jNkK/kEC3j++B9f7jq+f482ERkn/XmfxEC/5vibb/b8og6YLYMRO2Aeiy
         wWOkC5fM1+PzqH1zQGysh2FZB3+kGlO5o1SBmI3JRKJfdQBQ+Z5bUIVzDrS78JFv8QDU
         Bykh227ay/FKPRYr58PK8luZu+9ftrgjoKJNFVYIBL2QodCcGL/WI7wQ7t0w4tAQB62g
         TD5s7oqV6gPDVdiI9+h/hrxDOOFtpkWwGSw17VaBssWctV2pMMs+b3N+Qrjd8sodZYNd
         LoQHwfaD1SArU8Nj3lWQJafb70GjP9omkzTaAMPrUUVlB38/EeTvV9kR8haKHGuhq6GM
         UIfA==
X-Forwarded-Encrypted: i=1; AJvYcCV9pYaqftKHyi8xQpksihXy1O3TY2PPKDEkTky7s+tl15ylis0JzLLviuty67iO8EBTEu9Jjq9ales=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHPOvztUwF+vGSMy62T0nT8FfJm1jrXCFYBFwNMIc4u6IY+1f
	x0b4wrHwA/6eKcGZkvTLTbEV5vEqwBbH9DSzOAGdRBxacFCC2NZF1ubeTPXvMFKU
X-Gm-Gg: ASbGncvIQrqRbn1PxIphcDnfrboz07ovDUtaIVObTyuUvmQztb3LFDHnm2ntELRRqs7
	7BLCkqhjkjDOcb8THkpuHjpYuFROcokcWQiUpPyafvVtYzXYF7T0wujVWZUKCYDuch4dwQ+paff
	zpbh99gD8XFOQmfRZnJAMjt5kRFeDa0A9K6dMKi2uFEnql60bO01PBK0OH9S324VKpzqOmCEQMf
	w7cBMSFIm607SAJz+iz3+hOf+O+Pmq7ls/LS+Gs/BlGz8/9MMA9dcpoZu0agSsA34rUtFyfUFKv
	/Em/UwjO2UzeLqhxk6wXZYOhCGs5B19KT8POhpLh8cHui8eRRzJ34zs6rya/iHzakG2Io7U44Ke
	8e/a3C7kmz51In1gcxjRWTqrpjWKKLuBww9RhnKFnJEbMQThcGXyqzCWG5LY4GuYYmDQi1embYW
	g+UwZXXbQN
X-Google-Smtp-Source: AGHT+IE8AaDi5/+pKe6FXYvrz6gOtwVnUjotnRHBWrfyDNasFLAlpbPt4G5A8FZhItpKwM89IDiRUw==
X-Received: by 2002:a05:6a00:178e:b0:782:ec0f:d271 with SMTP id d2e1a72fcca58-79385ce0c44mr9485358b3a.8.1760022426811;
        Thu, 09 Oct 2025 08:07:06 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33efc46sm3168825b3a.74.2025.10.09.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:07:06 -0700 (PDT)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
Date: Thu,  9 Oct 2025 15:06:50 +0000
Message-ID: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When injecting AER errors under PREEMPT_RT, the kernel may trigger a
lockdep warning about an invalid wait context:

```
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
```

This happens because the AER injection path (`aer_inj_read_config()`)
is called in the context of the PCIe PME interrupt thread, which runs
through `irq_forced_thread_fn()` under PREEMPT_RT. In this context,
`pci_lock` (a raw_spinlock_t) is held with interrupts disabled
(`spin_lock_irqsave()`), and then `aer_inj_read_config()` tries to
acquire `inject_lock`, which is a `rt_spin_lock`. (Thanks Waiman Long)

`rt_spin_lock` may sleep, so acquiring it while holding a raw spinlock
with IRQs disabled violates the lock ordering rules. This leads to
the “Invalid wait context” lockdep warning.

In other words, the lock order looks like this:

```
  raw_spin_lock_irqsave(&pci_lock);
      ↓
  rt_spin_lock(&inject_lock);   <-- not allowed
```

To fix this, convert `inject_lock` from an `rt_spin_lock` to a
`raw_spinlock_t`, a raw spinlock is safe and consistent with the
surrounding locking scheme.

This resolves the lockdep “Invalid wait context” warning observed when
injecting correctable AER errors through `/dev/aer_inject` on PREEMPT_RT.

This was discovered while testing PCIe AER error injection on an arm64
QEMU virtual machine:

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

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
Changes in v2:
- Pulling kfree() out from the lock critical section. (Thanks Waiman Long)
- Link to v1: https://lore.kernel.org/linux-pci/20251007060218.57222-1-jckeep.cuiguangbo@gmail.com/

 drivers/pci/pcie/aer_inject.c | 40 ++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..6dd231d9fccd 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -72,7 +72,7 @@ static LIST_HEAD(einjected);
 static LIST_HEAD(pci_bus_ops_list);
 
 /* Protect einjected and pci_bus_ops_list */
-static DEFINE_SPINLOCK(inject_lock);
+static DEFINE_RAW_SPINLOCK(inject_lock);
 
 static void aer_error_init(struct aer_error *err, u32 domain,
 			   unsigned int bus, unsigned int devfn,
@@ -126,12 +126,12 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
 					   struct pci_bus_ops, list);
 	if (bus_ops)
 		list_del(&bus_ops->list);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
 
@@ -223,7 +223,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -236,12 +236,12 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	sim = find_pci_config_dword(err, where, NULL);
 	if (sim) {
 		*val = *sim;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_read(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -255,7 +255,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -271,12 +271,12 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 			*sim ^= val;
 		else
 			*sim = val;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_write(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -304,14 +304,14 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	if (!bus_ops)
 		return -ENOMEM;
 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (ops == &aer_inj_pci_ops)
 		goto out;
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);
 	bus_ops = NULL;
 out:
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	kfree(bus_ops);
 	return 0;
 }
@@ -383,7 +383,7 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 
 	err = __find_aer_error_by_dev(dev);
 	if (!err) {
@@ -404,14 +404,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The correctable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 
@@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		rperr->source_id &= 0x0000ffff;
 		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 
 	if (aer_mask_override) {
 		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
@@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
+	LIST_HEAD(einjected_to_free);
 
 	misc_deregister(&aer_inject_device);
 
@@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
-	list_for_each_entry_safe(err, err_next, &einjected, list) {
+	scoped_guard(raw_spinlock_irqsave, &inject_lock) {
+		list_splice_init(&einjected, &einjected_to_free);
+	}
+
+	list_for_each_entry_safe(err, err_next, &einjected_to_free, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


