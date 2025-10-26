Return-Path: <linux-pci+bounces-39333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD5C0A29D
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 05:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C18474E446A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 04:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C2248868;
	Sun, 26 Oct 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ53fAxG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809D1990A7
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453849; cv=none; b=ubhnqiTjwTxP50fB8q1ZMm5Az7e02JgPbu10y4BNDc6Hayf7Q0yL4KFMNJPbQIthL+IEQv6o9KmH9EE/wJVGLy1X3UVT7sw0wKWqp6kSDXdouiZnXFC3/t+MWrh2hzCXnl7uf6HAqO0TqEasOGROOghOTBgTem35rr3RERWcg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453849; c=relaxed/simple;
	bh=sAHI5iIZM5NABgTl/sQiPfhdR+xFRe//xBPBZe5FW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO31ZwfsGRU76Qvcr0GMZ0kcRgh3arOnRDJ0cXLlVQkNISqbIVZEoP7bdiWWI4nESsATcbiocvxU+q6uqT9z/6q/oHAeM/9JYlZUfzr1PgvVFz4rOHpVVkGt+61HoqSGD/O9MeBOmxfMtGOvrp+RP8WmU/WhsBtN/9BiEMP6EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ53fAxG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290d14e5c9aso48065775ad.3
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453847; x=1762058647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=CJ53fAxGg3cCsgFYtnnxWHIy4D2wgBb8mcunh16Cv7IXJ88mMamdCC9m02eP9Va4e5
         vR0Yo5aSPzcOEMgAN+NWRzyf57NzwBGIicGtXDaBZAinvf6is4kNa6RFQsHiAwdRji8f
         68fuIj6ZmyUFZjsIwsETT98b580LRZ82D2bFswJd94ZjCQAVM1MdSf02uNd+Z2gXRmnS
         G3GhG0GTwkTnkNXgjGqYMG5tKySBdl8dKg+kPA9Ifua9g7pmYGJ6Om3TqCuH82noAPKb
         iElDqpGaFR5HrYPvY7tF70avJSEkUuZdnDcgoArn9NclDzgU8u48herM6M7ZYmzIvx5G
         mfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453847; x=1762058647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=xIhgQx2c9P+DKyaNwTgQeEoHSxAMhbdE+87llqpfgPYXfKwUWS/vIuFAY8sX+51To5
         iq4N9bYmfe83xU5LiQ7BP5pWBuxjd2DpebTzxgeT8JOWhnFwREjPEFtH8jsZgdh2yRdM
         FcRWB2gHV8oNefmMqADwWsGKzc3wtAf6ZIse188qF/PgO0lL7OxLMttLvqDFjlYF6q1+
         NLZ91FkoVsFbph5OL1TDAFAiSlPy6MhqDKYqbAS6Egka4jAMwsZHLdaG78uVGFVtRBcM
         mqJYEIw6jS+eEC5lp44/mhvhoEwAs3Aa7IGO/uWdTyQO21MESsqN+2/2jS8+Z55k4+L3
         nSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzZIQdamILwZvgwQ2Lbvfii/FhMIUkiVsH7J8rbVj5kMRlRE9+pV8TeOi6xPz2Z081lZMeI55v4qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf77P5BxvFOhw/2odEDC3iFsuhKc+8V9TNQ+JQqL0/yccmFmB
	7bFEkecC8PWEn3A/jU5J8SuEephJJaWWd1PE/xl9bfwwmA4RCwVdYOZE
X-Gm-Gg: ASbGnctFRVj1S7oFve9BC+AQYpDHBeGEkmsEnnYBpi5gfxhO3wm+AkMnXZoh5q78qLM
	IKzwbJmsVCXHh1Taof7JghazVBl7Q3pMBcreR4ewgQU63XBplaOehjoC2WRLFgzfW94xgNCAqUG
	LhbdC8l0qFgTLq6D2njIkCmxuWOnbStYTlgQBgdK+mCBHpvp3BgYO/ipMrV3SZmcJ+A31ZO22xW
	ZTfw9PQr9iVA05SqgbQG799rXvq399osLQZF3XwEvvqUFgi5gDNZw+L2bSTVWsMYChmwseYprh8
	7JTvc87GbL7iC0DRFq13I634oxrwH/mhoXjE7Py7ntvflXrqyoB63lcGvnlrOFZiHFKB78mxf/E
	romxqH7jR2JCduhNYoInjgPykJl99lnXgSMFkdnAI1H2eP8jBTIFTBARp4zMl9wWrYY96nMLphr
	Bga7Fmq9KD4fPjojUtKbXvMKhVtTlRgPkvIcs3Ry+8xmqa0O5PKA==
X-Google-Smtp-Source: AGHT+IHc8dm0fiYDLt8rU8qfupJlNJN9BRtqR20SQ0bZw140gD/aS1oyiyBfrB9MNCNRXcTWNyoazg==
X-Received: by 2002:a17:902:f68c:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-290c9c89ce1mr445488005ad.12.1761453846681;
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
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
Subject: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun, 26 Oct 2025 04:43:34 +0000
Message-ID: <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in forced-threaded interrupt context
under PREEMPT_RT while holding the lock with IRQs disabled.

On RT kernels, spinlocks are converted into rt_spinlocks, which may
sleep. Sleeping is not permitted in IRQ-off sections, so this may
trigger lockdep warnings such as "Invalid wait context" in [1].

  raw_spin_lock_irqsave(&pci_lock);
      ↓
  rt_spin_lock(&inject_lock);  <-- not allowed

Switching inject_lock to raw_spinlock_t preserves non-sleeping locking
semantics and avoids the warning when running with PREEMPT_RT enabled.

The list protected by this lock is bounded and only used for debugging
purposes, so using a raw spinlock will not cause unbounded latencies.

[1] https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..c8d65bfb10ff 100644
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
-- 
2.43.0


