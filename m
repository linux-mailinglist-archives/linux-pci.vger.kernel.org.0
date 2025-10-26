Return-Path: <linux-pci+bounces-39334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0985C0A2A3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 05:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10563B3189
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8F258EEA;
	Sun, 26 Oct 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvTBLq4d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E16262FC7
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453855; cv=none; b=TYm9ABnMc/b2NYwCp5HfBjdtHc1hCgW1EnQs5gyBJXJHRb1bfl9aeEHy7cv8aYmL6y7bXHXeZJCGTkRDPTIhM4ajeB4EiYNkGW6WDBjrVgRBCevSYthAKpxNprBPMFFT53Y+CgqMv/JtYnpZuSul/hdYBUn7RB8fSmuDBOivu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453855; c=relaxed/simple;
	bh=w4Q+yHhJBasAdeSXBOcO67FD8hR5fmC9dO9uLZoDllg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxwgS+eNeJ0SxYR0SRP5/iEh3Nx5p8FYTG/3VF3gWCeZQlkPL1eEloVgB18EgRR95V2YbYYXX7dOaII/bYyE/9+eRTqXidgw268q38HeRUciWvf/viGNlMjxpgIv6NORUz8NK5KFhfSzX1BXos4aQaKpABASoEX+GE1olK0kO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvTBLq4d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78118e163e5so3961042b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453852; x=1762058652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=IvTBLq4djabjUfXBykrwlBeQWgEupiQzR/GgeVIx0y8nBaXI525RrJwN9f0/V4jIte
         jHHK56ACso13tnNQK17eQAM55c1KgIQdoQI2HrCx62j6AM3Yw0bn0QoNQCN/mtJpMOT0
         zUcHog+/5bJH/HM4XpvzUAqVFblMn6RpyevZ4sXKU1fYyOh5TM2D+WFwjGNVcGtoI7Tc
         +FW3uRxIZMPn/5ELL8GfUZzcQt3V3DH/X1uii1/PcXay4LmoOmjGtLFqhSPU5gDgs0KT
         mbn836jNDeT6vq4J3WbKimnAGxQGOPDNmDQvzrIYKKm+R5cEdfBYaKISNKT57NC4J1fF
         LDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453852; x=1762058652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=NE8bJ7EOEIwE/B9v4FcFDYZlPoe07+CNVlTRgten7DGvJKMEZ1FeMWkGWmwODQhh6v
         Ni5ri2ddZR1BYVFXUcixk4wUZglDh7NSCotKDRzgkaonY2jxupHLt3IuM2ba4DWaYGQs
         U5A4HEgLj6Z3ixCBE+Fc5qxeAsm8yFCj7tXi+dHUrm7OCnE+cxWFBe2LNCm5vrMIX5k2
         TR3DJMRWG4IpNGAT1ygkoemPSlZhVJYcvqfD7ExKxJ82Y4s/+T/b1AwoDDdiz3dqN5X1
         uHI87xZRUfPAC+5cjFbxUXvOEdFcCBeZBcVQGwNSf0dGAjIN0VdNPg95LGyrhjtXzGtn
         ibNg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ZbUmdob8vB/vZeIU3fkrWTIa4V9/80BrUJgBNi4mDwFvVRUsl1CMKUgb4ZGnGgb1ueJWP7iCtDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyna8x5+vvrAhabzNvcKBWDmyKK5vDRfYXTIFU89g7rysfpSU2Q
	tqLXjQdIToE6rhSoQykILXF3+vImKaJCfDJwa7+JYZifWj+4eKHcc7Sm
X-Gm-Gg: ASbGnctOiHB3R/+zFjZUH2aEo1xTQdvACaBNsTa+llgCdM3CZW2NxIQbNydVuVNfi12
	I0WR2OAMhOYgL09yCjJl8SWwW5+ss3mpn2f4B0aXGwHrG8rMK/N7miaTxHMVmWqFGh/s45G+Msp
	9fb2nBr9TP7LSkZVF4ouMs8+SdciK19vDxEhX1oc1bjNt9F2Kw/XeL7pPSBUytyL3i4MHmScWcs
	JhWQa4Ek/Upd/ncHPXmBOVlUK0NYOrmJXJPiaeP+uAaDcd8id5RgFNPYNUvaLf+UefT6x4kdNLa
	HzJN0fbzUuw/gSK97aMSR/RwMzDQq+5nQHQmnIfbuEy4rl4fnZ/V558+LdMFdvSEWvyJm3d2dnO
	gow3wfcq342/iag7zVXM5OJ3K+sWBZISBcbCmi5Or3f3NP0KGNw2Z013SdoHRSdzYnVm2YVuTgD
	1bKShV/13M/Q2DuMaGxTMQftaGaG7HBg0G3L3smrgpEdOEkk62tg==
X-Google-Smtp-Source: AGHT+IFUy9nDaJV51/d03ANfLAhw0sYIOgZYfK93VgsR+kv1D2t1kjboFjQQXoUpP81vgHZLi1rddQ==
X-Received: by 2002:a17:903:187:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-29489e050e4mr101688115ad.17.1761453852259;
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
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
Subject: [PATCH v3 2/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun, 26 Oct 2025 04:43:35 +0000
Message-ID: <20251026044335.19049-4-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After misc_deregister and restoring PCI bus ops, there can be no further
users accessing the einjected list. The list items are therefore safely
freed without taking the lock.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c8d65bfb10ff..a064fa2acb94 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -523,7 +523,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +532,10 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


