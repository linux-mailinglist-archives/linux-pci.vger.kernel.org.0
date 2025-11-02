Return-Path: <linux-pci+bounces-40062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38640C28DB1
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EB343962
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60426CE2C;
	Sun,  2 Nov 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFsnJ36y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D755268688
	for <linux-pci@vger.kernel.org>; Sun,  2 Nov 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081091; cv=none; b=iDTLVPqWrHFZTNrg/o8TWoueeBvLzMfZ5Ecg8EfteVd7n4sKzMj6jzfFdH/2/sjSMW4k5wWoAajHiMzhnpUeuVmiHzMBloPRb0X0/NXQZ9Ir5xXet8Z1MaWRiALSgeO07HTPEejezaay6QPJ36ZaKlHpSrF12bMjBOZ71I0XhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081091; c=relaxed/simple;
	bh=iU945rxIytYge2u36qpKv+Z6kWAP0ds/jXgSSHdC0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD4jci7R83uAkQVkRkJBI2ixD15WM2tajMZrvoZoecp2r3dzxiBlwDuQXHsJPNHTMclJzm2vC6cMeCo28jV8Z2sC3fUhOoerV/sFVKWQrjUYsMokBiuIG/VKCIo62A5pPVNc7vcOuOXzQ7g/SLqM3Xa4s4MiP0EqXkGDCcPHIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFsnJ36y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3453251b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081087; x=1762685887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=GFsnJ36yJ4RJrMV6Xp3CNxuLHnKM97WPtlQOb5bus+rBtWQI79ZeiWdRP4ZazhnUAn
         XKCT2Rg943XdlgDhHnBakcniBb3VK+0muZphSzTmjP1TcSTeLJb5Vab8Y4JfPBHhS2gk
         EqTN7fUlAxzWIU23nfeRxNmCPx8eza6U8wED0lVqWHOUtsuefg4XJhn61JzEDaxWD6h8
         ZE2WEYDT5jiBb21evvK7H0JJlawNX02mZgeB5rAX9NYfBMtb0Pukz4gaT7ISkxpeZ4ca
         ypkHL5deyu3xjZkzIRb1sqmFqAy0x+rdkCew74ehvTzlVG9EK1kEBXDE+29ambGX85c1
         pATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081087; x=1762685887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=B5qhMnfSzolQN7bKK3whU5xQ1IPyBD2863Qh0DQlPHbcaH5QjkaQ3CwC0qTFwgaH4+
         KmejfOgv0yJ3NY3aqSmecLaf05IETf9tIONwGflfQAAnmyOy5F5/V6jpF0krf8U3EHo7
         y+n7qqqOEDf8biteRU6PHWJYoUGnY4GAbRzVzpMpKeNuY5bShglcmEzDBAGWRMwYVMNu
         QObL7diHUCYKYnPPVZ4dz1AcSUUEb0IAjoB4Aiu6wMv82fMYklhRaGMrtHQwmZRPxTkD
         ko76SI/66jC2XiJyOakTgiSjgw/BCFT2hCLVuZBc/G+vVc7nOYR0x1YQj8UOaWslCM+E
         m/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXDHR80A8+WLf4NXxO+X4R7VkA+26uLakZvGIk4kLQE8EL137QqRZ8xYQDZORcSHRSDO01Rtjrmgu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKLFyJyenQJtdul9Puar80UXcjc4wOn4+0Yq/j2WGveMVrk6z
	keFhBaoznaN6/wq9b8euDAJiJCCfh2Y8iPk98G2GlQKJa/3tiuVAfoBy
X-Gm-Gg: ASbGncuSzTZdXRubWoK1qoAC3IDJHk04b13qMOwAEATS06jUqT9jxi9TolorarAIGy1
	uwKCySQiXSxWu+OPTNdn6ydJgjZNK+fLGPUO7gpbIuXR16IxaOMYJfz71t8guiBv15R7N6PaZ5O
	Dxh9J1qHrYBcgUnjkmYxZdYtpzw2U5cAUdqzmtO5UglM5fatzFN3QmeRSc7aWDnunTaXIdsEKOv
	DYUFhUWYv5bM0+SNa4BNHhuaByz2XQs7z0oj43r4zhobIGb+We4qBr92ro1wCVRZrW4oflAEHaB
	S41y9y1aXZ/KqcWSaLviiLRhnPfrw4XmMioSTB75reulW4xJQLFG2cniNXeyMjG9khPefHN+Dcq
	dfay8QOu8z0dkkedwlmOfuNgKiwpV0x4E7PKNS5KXTmZkKX+QBRjLsLL7bTYg4UTBDqiJeEbTxh
	PhSbgrK2NTs2+WZJ+wS388f+/grMdzjHIkPeGs5PGa3v9qP7VmNg==
X-Google-Smtp-Source: AGHT+IFw7LQmxvnT7Z6/GWYHHWlCaXIwYo97IH5BaRo8+IRI9C+4EfgykCBDqZa3hOGXe79E1lknOQ==
X-Received: by 2002:a05:6a21:99a1:b0:340:a205:681a with SMTP id adf61e73a8af0-348ca75c051mr11435936637.4.1762081087211;
        Sun, 02 Nov 2025 02:58:07 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:58:06 -0800 (PST)
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
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun,  2 Nov 2025 10:57:06 +0000
Message-ID: <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in interrupt-disabled context while
holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
sleeping lock, so it must not be taken while a raw_spinlock_t is held.
Doing so violates lock ordering rules and trigger lockdep reports
such as “Invalid wait context”.

Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
semantics. The protected list is bounded and used only for debugging,
so raw locking will not cause latency issues.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index d0cabfc04d48..a064fa2acb94 100644
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


