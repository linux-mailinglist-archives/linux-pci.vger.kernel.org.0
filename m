Return-Path: <linux-pci+bounces-34870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46AB37A5E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DB8687FCB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 06:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F92EC562;
	Wed, 27 Aug 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDfDwhLv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B612E7F2F;
	Wed, 27 Aug 2025 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276233; cv=none; b=PmqdSI1AVeMG0VMRZ/w60Lq6vwg+61NSHc/keLjsCFAkbttrtX8rTnu6j8zfTn2EEg7GmjWlOCJLL1e986WZLlPw2lb4OHfVXA5wkx8FvyNE2Asl9tvZnKq/CIteOhWtygGnWjHLDoG9I3ITAj40UGAmhDdAg1wXsyq2o/iSmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276233; c=relaxed/simple;
	bh=2077pD+AStEyZosAgpSFcTatpLbwOPrlyNYg6MRFuLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlmOHoF9jZWj3uLV4dBH7SoShl+dZtmrLari5IWholxeqlVwXn6PP9TBHalrooGyGHbyZFCIjGKUD8td2i2MOmUMEO5/FXKjZOVTvdZG2dY23G+g9X34gZmSR+vOiy0w/thXfgyOhxCQFbtryTsks5idSPnsFqOqim13qhVDC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDfDwhLv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-771facea122so880781b3a.1;
        Tue, 26 Aug 2025 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756276230; x=1756881030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngDfTlsvSHsLEbTHqYir+BpbldbbX/3shbsCERNxjps=;
        b=GDfDwhLvcnT+wPhFilC6LDmRXeOz6BopaJxFtRWv40e3lvbWnrZLbstHTquQg2SQez
         jrcK0gG27bnxp82WM/u5GOJ+PAsaSszQRVHmbhmmc/4/tBM33RWcoUGJ2fOTSV6n34Y2
         TfChqANdFRMLqLjloxLeBlBE4Auz6FkMnZT95vjDQlDykF7fqqWOc9uPcreZLS2ufN0Y
         Dtls87r9z1x50ssB/oL/6BtYVqPk+kV95+4Pq6lPe4GIamhpidCDQtz7ORYEg2Go9c5r
         nBnIs26cN4cEgiFoIYQH386LjbSYE0Fi46THO0ElqUXlEVKWvhEX3gVu6GqTFsEy63d/
         UNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756276230; x=1756881030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngDfTlsvSHsLEbTHqYir+BpbldbbX/3shbsCERNxjps=;
        b=B+yyKu4Hj/IVtWDsFOO71F76iuwyuPvZuOPjlqsRCL/N9eol3HyuFl9kQooxZtiM0o
         1CYKwhQrXwqskYQ1A2kOurCcWHFLhwQIlmOhkYKzyizofJMA+h+pN80xqehTZEmDrp0J
         ff6jTCoHuZbAngRVmKxNCXEJ7RxtXt0sOul7QdDAXCvHl5kqE6/Ax7g8c3Miq2qo4yas
         k4tFzJofkH4JWAm5KMVgHXlpUQ/OtcNmSPKmu3/zPj9XNjij7NRU+9MX1Oia9xf6a1mR
         EiojEXA0nFjVc730Q5DLxXAdYQ+6MbCiwkBk9ql0vZeoVhhGfm2lco4C3r2NefkL/y9T
         cArg==
X-Forwarded-Encrypted: i=1; AJvYcCVa44eV0C+jYCVoxiNEOrQL5npg09OeKKr3we67GYdQsh/XtyRsQexKADpw5GtuZxmIKYL+HnKXNk/rXkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHlFXCjqJAxQcQ+qLoIAZDgfbOWhmNDsxhma6Ht/mTLvCXASK
	ysXnC9KVYJSe6quAR3UuAseWjcgnwLhJEXTVaYcl7NBCTlI7dCaNQ0vZ
X-Gm-Gg: ASbGncuXLbOoFzNgTn4be7HUekt+sahwcCKdKdsFZM5sTFm262q3Z/0t3oUh9/O2Nhn
	klsjyVC2X5j73x4o4zOuxwVuSBib8G5igc+sX4/ujsIRHUTW9IAcO+4b05yMLwSw7bp8vflt065
	p61Q1GAPPtTIDQqHa0J2gOo3u/KOsSI1XhT6JV7nH62Q02T2VRIAQD4RZTEWeBQhfM0zNYBslp2
	2OONt0WTSFMBR8mPSYBdNlAt126OkQ9bdI/fGVBSLEpvG+TfdP5gJ+5Ikok5HJWPxbX6Wp/LYJo
	p+7JFip3EZhuoKM734IX63gifO/qGjy7fHk2UfxFKlkP/4PODz+eHQA1tHsjhWKWaCyrMo+06Nv
	5O+fNp3YYzwqWDvekImUqqHToeDaXY00k
X-Google-Smtp-Source: AGHT+IFVjeC07T8TqfGe+a67TKlrMPd0XjccquCqoM7862trcuYZL9ib4faErub/AOy5k20NJY7Rsg==
X-Received: by 2002:a05:6a20:4e12:b0:243:6e5a:51ef with SMTP id adf61e73a8af0-2436e5a5496mr11711888637.43.1756276230261;
        Tue, 26 Aug 2025 23:30:30 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cbb7b375sm10751328a12.29.2025.08.26.23.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:30:29 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
Date: Wed, 27 Aug 2025 14:29:07 +0800
Message-ID: <20250827062911.203106-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
the newly added callback irq_startup() and irq_shutdown() for
pci_msi[x]_templete will not unmask/mask the interrupt when startup/
shutdown the interrupt. This will prevent the interrupt from being
enabled/disabled normally.

Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
cond_[startup|shutdown]_parent(). So the interrupt can be normally
unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.

Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pci/msi/irqdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e0a800f918e8..b11b7f63f0d6 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)

 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		irq_chip_shutdown_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
 }

 static unsigned int cond_startup_parent(struct irq_data *data)
@@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)

 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		return irq_chip_startup_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+
 	return 0;
 }

--
2.51.0


