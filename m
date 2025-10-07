Return-Path: <linux-pci+bounces-37648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631BBC04B4
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 08:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E14C3BC12F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 06:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A761CAA65;
	Tue,  7 Oct 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB4ilBJq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAA84039
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816966; cv=none; b=GE1B8kLQoCyB8+o3a58ZVdVofAN+yvBbsjyZef/3B8hSztd/bSJqm6utE0q6bETU9MByyasbacri6oSozudeTk7z6FX25lHH9sMd3ukjQVVNnjMfKNRkBsPHSTTNtWGQMZR2rmgXTXLomTCD1CeVXDBwXwWEb9pTvfjY7uvYqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816966; c=relaxed/simple;
	bh=2fTetdKn0nPh7dzDPU8nU+KOLhpYY4jDYd7MC9MGC3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4mkVR61kPwB44T7ZAKJ9OvzOyK02sNE1xSpgbf2PFXG13Fj3zipVnN7h0UgkcnTBTXYfqBJ9CZ4MrXI5sy1yDMnn9HR/axetDbtOMjhWHG4XGXljnrDFtQmlpR3WWMwVCJq0k/BGjrnrf4pTz+EUjxYnvenjBRY9fRhM7NTwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB4ilBJq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782023ca359so5518545b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 23:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816964; x=1760421764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yKzRUrkWt1RJjs6HAQ43/3hjhF5/yWq1twj4ElmLSU=;
        b=EB4ilBJqcx7Mic3bRz2b2wG5KyFV4Hlg0McymaaKQwMjeEZYnMS75sZNTZDMr1X9PD
         8vr1DDh/ZPFLeTGhprJYT2iCndbJ0Jy6AqVZFZPHqU6hGEbmlHyk3hj6QMIhl7VQ+Mbu
         cdRud5JApMAQ7dcDVP/AHU8JIT992NuDf3R6iUicy8pbGUzvLXvMfZ6Oq2shv+LkWwKT
         RjVG+9BJPlBts9Qg2gnnXbznk77drzXgphDj2SxNoeBWU6XPVfWo/LqqRHWng4I/CSIQ
         oYtbDWMHMUmip907w89QeA2MRSGISN7lqLjvh9pvcKrM3r+vZikVshJxTyQ8qXb1MeWw
         U4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816964; x=1760421764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yKzRUrkWt1RJjs6HAQ43/3hjhF5/yWq1twj4ElmLSU=;
        b=gK+Ei3V1VFK8efrcqTRUpEdOFXi/7Lxk5eZ1VBjwMIddg5Nh9Jf+UPVsgIF3jTqO3a
         Z3qNzEMTZoQu/46BaKl9GFq6CsoH7KzMU9qqX7/p3KIMQDAzPVuCBE5FIRq/BIiiDGA+
         3fTYsRIleU7iWSYpJvMt37/1kIaiWekY0/LvBdG/CxF+SvqPEhbRiFsz6j6MOIDOc2X5
         jyERr3iWmbU2aOaF0sN/cjyjcAm6rg5xUP3Jo8dF0sy12MHKr0mT5U9Tj0Ic/U9/fTNW
         Q0ZlfK1OSVND4hBMDqVhL77V2kzf5pTyr+Lpdzy9/QGjlyUZbtUZ4IS+s1b4QoFCmVma
         38Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVpAsoIw+/PAjiyK/YyTPyyg8zzFhZDiZEoM+wlehpqxsL5sAexmC0IMuUtpGEPSjcK2B6ek12LXhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxRT2mmzIjFdYSiKdlNwPifi3DjhO+hCYH2pB8VmnxhQuwdSv
	ekOLkiSV2G6NDThHeBGGrWreGF3BkIXZh5TYCWIdRhdaBP2Spg7aZYlU
X-Gm-Gg: ASbGnctnxEtlOHfmYh0TadZVbxsMTUSHiaQLStSBYOr5MLPCGlZlTj/YDRg+Ii/St+Z
	MZglWlWMWEwBUJuCcOGzPPSQqCNb2q13eaw3CXmmaJmEtUaBi4ePlOiF1dw/umgGP9phUbyh2Ax
	nEQ15GKYp8O3TCZUagVN702iCqrRclxQF7MusiOLOiYFvRs54DM06y9DVDzwxjLNpB9IzpfqpEl
	bopjGm3C8BC7eRXW+eB1t6AdHSFvbYB7cKOOlP95N50+xagHr146JcI7WOYUTpbG0edu1esVAWA
	4HAtMzpjgbhIcVgA3RXdB35NWEzE/n/9r276PHr4zZ6CoqFgXL4In6xCPXnE0B6yrj4lOWjLS7Z
	Y5s+TBYGy+/Fd4R69SOhYGJrsfzEC9x2TLraK1gDb7wdIAc+KgzQ8xfyMdpDDQkJtIFjeF9+Nr2
	f2WnyoMErfZg==
X-Google-Smtp-Source: AGHT+IF8J9tF7b/K3RD1zRAX6bAoHqlivXF9t6dtYC164eWKz+tl6ArEU2/J6POtqqyUChCxzYvbTA==
X-Received: by 2002:a17:902:e849:b0:27d:69de:edd3 with SMTP id d9443c01a7336-28e9a5a5c94mr210953765ad.20.1759816963762;
        Mon, 06 Oct 2025 23:02:43 -0700 (PDT)
Received: from localhost.localdomain ([113.102.239.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e92c44f94sm140472215ad.43.2025.10.06.23.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:02:43 -0700 (PDT)
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
Cc: linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
Date: Tue,  7 Oct 2025 06:02:17 +0000
Message-ID: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
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
      -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc nokaslr" \
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
 drivers/pci/pcie/aer_inject.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..e4c9d08c1657 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -72,7 +72,7 @@ static LIST_HEAD(einjected);
 static LIST_HEAD(pci_bus_ops_list);
 
 /* Protect einjected and pci_bus_ops_list */
-static DEFINE_SPINLOCK(inject_lock);
+static DEFINE_RAW_SPINLOCK(inject_lock);
 
 static void aer_error_init(struct aer_error *err, u32 domain,
 			   unsigned int bus, unsigned int devfn,
@@ -123,15 +123,13 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 
 static struct pci_bus_ops *pci_bus_ops_pop(void)
 {
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
 					   struct pci_bus_ops, list);
 	if (bus_ops)
 		list_del(&bus_ops->list);
-	spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
 
@@ -219,11 +217,10 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 {
 	u32 *sim;
 	struct aer_error *err;
-	unsigned long flags;
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -236,12 +233,10 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	sim = find_pci_config_dword(err, where, NULL);
 	if (sim) {
 		*val = *sim;
-		spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_read(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -250,12 +245,11 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 {
 	u32 *sim;
 	struct aer_error *err;
-	unsigned long flags;
 	int rw1cs;
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -271,12 +265,10 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 			*sim ^= val;
 		else
 			*sim = val;
-		spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_write(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -304,14 +296,14 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
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
@@ -383,7 +375,7 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 
 	err = __find_aer_error_by_dev(dev);
 	if (!err) {
@@ -404,14 +396,14 @@ static int aer_inject(struct aer_error_inj *einj)
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
 
@@ -445,7 +437,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		rperr->source_id &= 0x0000ffff;
 		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 
 	if (aer_mask_override) {
 		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
@@ -523,7 +515,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +524,11 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


