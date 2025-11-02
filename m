Return-Path: <linux-pci+bounces-40061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C005C28DC4
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06393A3D54
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C072288F7;
	Sun,  2 Nov 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIkoY9QV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA321D5AD4
	for <linux-pci@vger.kernel.org>; Sun,  2 Nov 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081081; cv=none; b=W65N1kN6+zmmXNUOwzhHf5SbM1skQ+em0BaZ1KliopOTtsJ25dsgZyBaycAWbUlDKDMqVNpO9nlSFZUHb8fAMYTxWeOwrMjiroo7dZl1fVaXTJGke91g4snuH4pe+sowbLAoQCGJnYpP6+ZF4IYH5+Y3QqCyCCfFHFkDcnEqlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081081; c=relaxed/simple;
	bh=YYUim/jEHT/moxRP+um8D0ezgl9zrVelNIUP/7RdRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMAYmmA8+kbYm9msGT28GYLs0cvFq5g0tWDw9635Jmb2N9hB1g1R6Ed7thXYR3dwIjcfaTf5cX7JCFXQM5dJSs0g7r1GOyo3rdCP8QcdN53dtYyr4ojGqJSNfSG4TzxwgITWd8OoOVlQ7mRw2oL/I5xvnK4pPwHq/x6tzCxLbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIkoY9QV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2870783b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081079; x=1762685879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=TIkoY9QVtJXFfmLWo2vCOHPIyr2VafzPQAx6pqMfLd+rhBNu89+zsgSsTyRhseSFLD
         ErYV4AX9e6PKlWr//C1lh7fOdkH+XPSjwmcIlaE/qcp/ENWe7a6yUQ9tHpdUk287yPJS
         xZO7fDEF7Gdcwuf6wyg6xKrVXgfPeD2tVM73MBrlyi/+dWP80sbEvihdkzvuhR9zMyQF
         N5Ntq22TwHk8sP9WeljJRDXKTIzdGKhXnGtWq/aOabRl/25gsPV90J0Tgq+SXsOphNkc
         TrU7scSJQtnnnqtcI5K4gEmI7ItW3XQtHP2gWihAKGlFADyN36kjacdyv4c5q1UmkZVx
         2M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081079; x=1762685879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=lqwUOMlefLwPFHvz0zulfHT0kMKPbKp/oLUP37R97IrO+9YkxMUg4MZwU3k2mA84q5
         dV69OH9ZM4ykIkNAmDKjDH9UitvX/oSJQvNLx/KYrFiKPqwrHx0dpIFMvf0TFv9iZF7p
         ifZ4nS4o/pIAKHJKTVGy2VsnrChtsVsj09IMqhw1qUroyp++PF5dT1+w95n/WbknG8sY
         HTQ6SDu1bAqT4P/qBbAZgIOZi6VPyKbPnpti7iz2Xze/LhMzpFUa8G2ZBFgJ6RXFX0u0
         tBDfCrBxmZB0dyERdc1ECBmxTzJdGN6Uip2OGrz49VRe2jjqk9CMTX/xMHSntVNoyoj7
         Lxwg==
X-Forwarded-Encrypted: i=1; AJvYcCXFFNyXMbx246t04fweCodENcSHqf0Q7uXpbkugJldqOVZnEwH59nxKJJXvq5zZIenqFr0E6oGqAzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjh5MFsVG+w8AODCwxLT9LXX/vapbfnWwxL7t8k0esLWq2dnnR
	gYGAgzS+5LWI/YJy++ZcvKGoLq/04T8z6K0Pu+dgpu01PC0HERNzH+q1
X-Gm-Gg: ASbGnctflfP/a9GeFPTgIjvXN5yOYZcQ1/AA6nRmVA/EyegUmlCCa2r199ckgx+JYKg
	sQqUMKII/Z+nWmanZ23IoCBIYwjchaub0e2qjMkM2BCXeuPMJQEV8P4LoFJii43zwQqn5AVSC5X
	bzQGy1gYua45rTUr0CgoLLPjB+CyoexkrBPXdKTpi0GgSmE3zlINcn6vfr8u+y8MWV4+FGZ0LZc
	taKL+TrmHwPJrP5RjyatJYeq4YLqJYV9YLHvZbRFpnGLS7D4KPaGJ3IExMJonORDlaPe/iPCd4H
	jENbDu1uz94ArvOXR86x9GvNz9Fpu56clzZnhaIKiAuHI8/yYvtY4kxdT4R/3rW3h14b8i7JWKY
	01KeHVaEYG04xwribLvVbxQ3XyWcQeG1K8fHMCXkJEoYWS5NgTJJIAxKXT2gcRjLYYl2Uoeqn8Z
	JHMgJ7Rm3sJf87G2H3kYly1Q0AXraF1s5sV404gs0=
X-Google-Smtp-Source: AGHT+IGOHUTKi0otXLZWZO3UtF87Lmbiwrz+oxQ9CxZzdYea045bCS6cyr2JFlyOfDjazcyhJ+6i0Q==
X-Received: by 2002:a05:6a21:999f:b0:342:77fa:4aa0 with SMTP id adf61e73a8af0-348cc8e41b3mr12903852637.31.1762081079412;
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
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
Subject: [PATCH v4 1/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun,  2 Nov 2025 10:57:05 +0000
Message-ID: <20251102105706.7259-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
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

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..d0cabfc04d48 100644
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


