Return-Path: <linux-pci+bounces-27353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED4AAD819
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25AE1C217E4
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A825210F49;
	Wed,  7 May 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhpvkesZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2221AAA1E;
	Wed,  7 May 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603046; cv=none; b=ewfZSJPAo4hOJPnOYMIgIaiXHKOxLKm8uox8EbhJm3T2CKTy8NBaD11DPZ9HYVZPZfmgZY5xt0TXi6kgDJ7BZguXt571wCbAWs6NQ2UWhVDjQ9XHuk2kW0tFFFe4KBUA/e5nTTSpHVcpydVMujRffHHwsatFhD0my2VaqXnCCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603046; c=relaxed/simple;
	bh=g0KwV/pWy+pAGLq2jYuL29tXeU4ihkdHCDpSSq7p5pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqzuQQXnuBGYaNtQnKFjhbFFANSAbN+JgUw7a0sNycuv7wKEed+Qs/E6zhm+dyY5iix/kobk6iTzxzkm3/J8LMG95oLjnuOEZ1UAq0zKK03IkkPEi2ds3H7hM+ynNFHRuUPBdFcde1xm8cEdqVDY1gHlve37U1iminuGsqdMhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhpvkesZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so8497583a91.3;
        Wed, 07 May 2025 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746603045; x=1747207845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45YXqoIzi1w++Q2O5y79Hf5M5Kio30STB3Cii8vACyk=;
        b=GhpvkesZSkzVcEfa2ZdoivWgVoAAXEZcGFPtFBIBxzFygHG261quK9rlYF3X5HJq8O
         fND11TmBHwltChuL3tnMGNr9CkyaMqYGPJfV96GYkHKkkGGhaUWV1OnVP7v4LMtC99yQ
         mDeg9ljfOj+HxlFvSw33bIAHkHeG9/LVQ08WwcYPW5m52JyEeXwt2CFM/aT4foD2KoeZ
         emNUL6rP7RPwRGWRRXoAlUqaHkl1H1FCmcjDXMAcgG3oc0K1KPHqhTzix74VMuPxrvVl
         MpaaQ8Sr10vyZ84fRM+EtMibX3MS4rWAlZae8f4l8gZ++zteu17tvq6xa8roxhDEvqgw
         klHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603045; x=1747207845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45YXqoIzi1w++Q2O5y79Hf5M5Kio30STB3Cii8vACyk=;
        b=fK6bKAfqTgjZUJLFG82ZatFJn2526yG65zgLLjJMMAH0p+gYX/UZ1my9hkJtjkyNV/
         pfXX16Q05NW9TZc/MSy8ISB/sYXsJaweQ2G6sYe5WNKJSBoOPvp5kANn4nRf095ZC2m+
         5lKWGr+989EUw/nmpc3tmk7dUCuI4iT4FTYLyyHs1QNRyb08GdUFnfgR1O8mwMxl+U6r
         Ftt1hp6utdNdtA0lcCN5QFFY76QeU0HIrgXPGfdJzqLQ9f0WuKCNpDCM6S4FAMBvr9QZ
         zZb3PGh3B+BA7eisGtZ1Uic3TMPGV51YM05ZhDysxbu7kcy42EMv41hAVsAQ8VKrjqJj
         83RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxC8dQEnGSNS5jBksuyFAfodIcYEZrDLwCYz8Xl4lqw139J83wGRfM7UbN1714ibJZJPfNpZu1QL0RyVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktU64pVmG4gFRO6jPooE0AnZ48DN/cZQxCWRubBQUGd4s+LpF
	vXSX2dFGWVIG7wfyC5geUDcVF/VciYm70T5My5aNfWTFKownKEMt
X-Gm-Gg: ASbGncsNU5jIe6NzJvPX1+o0RWdOAGooENhtg60/+Ya4iKQzgDYqTSnZTJnp/cqu/YJ
	dg+QRYn0yPMKZw3e0WpiV/lLzdCROn6lo+NQv0nrEVUp73zLWEQLz2DM1zwGnww/n10BLtpHCvo
	l+azqZOf56UfjvXgu4SJtouslgq+kvnYCx2g66SQc/9wG47ACVUF7lwvu8yHbt2n5FsfigsV0Iu
	0+5r5pZayj4kIhmTyf35AiwuSBaeLShgtV2A2ChUgOeiSRbrnAYcyycqU+wVr66RLZr7QOK6poR
	WYp/0Xmq9egEhFmWynir6PRZ/vrkhlRA9HVUHZRqGRYICKwRlZH8Qk1ucjmSeLmlBtoqflyy+/e
	VnyQ=
X-Google-Smtp-Source: AGHT+IGkOZRg1k8cBRnNPvzy5uu4SPdIidCH8UZWqP/FUl/UlE/rzSQlMDHEU0AyDAORwI2+wmY+xg==
X-Received: by 2002:a17:90b:394f:b0:2ff:6ac2:c5a5 with SMTP id 98e67ed59e1d1-30aac2291aemr3563760a91.26.1746603044604;
        Wed, 07 May 2025 00:30:44 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e4534d712sm25748555ad.193.2025.05.07.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:30:44 -0700 (PDT)
From: Zijiang Huang <huangzjsmile@gmail.com>
X-Google-Original-From: Zijiang Huang <kerayhuang@tencent.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijiang Huang <kerayhuang@tencent.com>,
	Hao Peng <flyingpeng@tencent.com>
Subject: [PATCH] PCI: Using lockless config space accessors based on Kconfig option
Date: Wed,  7 May 2025 15:30:28 +0800
Message-ID: <20250507073028.2071852-1-kerayhuang@tencent.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic PCI configuration space accessors are globally serialized via
pci_lock. On larger systems this causes massive lock contention when the
configuration space has to be accessed frequently. One such access pattern
is the Intel Uncore performance counter unit.

All x86 PCI configuration space accessors have either their own
serialization or can operate completely lockless, So Disable the global
lock in the generic PCI configuration space accessors

Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
---
 drivers/pci/access.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 3c230ca3d..5200f7bbc 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -216,20 +216,21 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 }
 
 /* Returns 0 on success, negative values indicate error. */
-#define PCI_USER_READ_CONFIG(size, type)					\
+#define PCI_USER_READ_CONFIG(size, type)				\
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	u32 data = -1;							\
+	unsigned long flags;						\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+	pci_lock_config(flags);						\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	pci_unlock_config(flags);					\
 	if (ret)							\
 		PCI_SET_ERROR_RESPONSE(val);				\
 	else								\
@@ -244,14 +245,15 @@ int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
+	unsigned long flags;						\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+	pci_lock_config(flags);						\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
 					pos, sizeof(type), val);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	pci_unlock_config(flags);					\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
-- 
2.43.5


