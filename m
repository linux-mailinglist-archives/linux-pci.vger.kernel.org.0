Return-Path: <linux-pci+bounces-34947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC7B38EE6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52B1462825
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765042E62C0;
	Wed, 27 Aug 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPdiftpu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E727FD75;
	Wed, 27 Aug 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335904; cv=none; b=DNUT4biyVb1Vpn4CqNjlpkBk2y2Wg4GIEXYH5h+CEdTwu7fCBzqJz/5q0gzNZtssg/1BuoLbxWYkxJmkFPazasGIeQlpHSBZ+EZdf0mHovsfJ5bO0blhJhJOiqNOLK9n60vpsOpxIGRRHBAxpH/49rr/NAJOeTnHnpH+Gj40gDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335904; c=relaxed/simple;
	bh=LogCXl3watvZA3fiVXIRZ72Maf8iEXPq4pu/PupwAYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMTmNO/TSOAete7I44zsp8H9KY80t5JEeViZtr13lf6D4CNQ76vMeJGpQ9QVwxfsejJIvAnxw/TEATGpMEdNkfDnpD8wU0QWsagqj2/hPXqJWle2rbECU1dmERjq/j6sqkyG4Iwhhf1yaqKcm57qbDNY2pT5bFYMsK+kMkapv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPdiftpu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c645aaa58so140707a12.2;
        Wed, 27 Aug 2025 16:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335902; x=1756940702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSXByq5txnBnf759ZVGs7Pku+wALFVhu3VagaeWlWvk=;
        b=lPdiftpuAICe+8lxv1qZN7K+C6duVDgV2a5bxaXrt0d/NPjM86eJTeCHLKXk9+XRsb
         S8s65uvyYtxZFKwSAhR8+7Hlk5prYuEWrwLxQi4b7agyuJXmbupPZIHqX1TqqlWW5+Ui
         +34/3MXOHpzrneE7Yff3loHCLdfodK1gs4/Oltr13iMvF2FglXuE40J3b/vBQKmR5hZk
         AypFRg0pqNb8Pc+Q5n0RBJdUcSqdYdBAhQ1ga+bK/GDcFB+IRWLd+DqWa6YcVPlftT/d
         D/zXxFaArOp3KIVODElTgvL0s2r5HgcY/+HEFn+xcDb3g2fYB5FmHF6g0536aOJT0vO5
         oFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335902; x=1756940702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSXByq5txnBnf759ZVGs7Pku+wALFVhu3VagaeWlWvk=;
        b=tMvT2AeL8wyAezflQmbPgx+HJDPBkCGA5mGf9EDyQt3DjFG2csp3vOEqLPV6XYUSyg
         dxWvRKWNVifvHOiZUK2akPaob677aCrBJYKCOAoe0WsDmSQ/PG3FH4Q2qf3CCLUlKxsH
         txdSskKzHy/1GsECQkl65n62XhFj3ttmQs9EfbcjSR+vFQeEfh35MBbtPVJO/EEjf0cq
         Thg4G0PWdQwHY568XHnfdJk0eXUb0TfeT81EOL3DBDCUTDqp3nBRc2nf61K6cX+5Om1I
         CHl8MflhS+o/4F1oBZUVuyId5qUvClyRxMsv7XmB+PqmfftcqAVNd6eBAaZ05ixrKaTH
         4c0g==
X-Forwarded-Encrypted: i=1; AJvYcCUNmnZGCTmrpwRHGkGZo9Txisf8DQriyGAls3xK4AF1sONMMFJ5CFB80VVUReFpaSpdPeffLxmdFTbW02o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXr1y7SfnGOEAg55cDtLem9iXvB2JCpjxw/WP9IaSu8JxwRkNu
	hlxl/1S4kLhAzZeluCY/s/hWH0syEo1oz2XeMe9z0B4Qi+MR0zIzCcH7
X-Gm-Gg: ASbGncs6AjWte2jtAByN0nAC8TTsbc00Yx1GCP7Uhr0uZv759nC+5V23ze7EPRKX9qa
	1809nc5NAUcNLyOWUJ/zld+oy7jut+9pdFbHrMy9kQ0O57KDyobA720k/NE8MI1PSasCI8Gs7n1
	MegPTIcGyjC5Trlk5vT3cIKyUIU+0nFHbuKEObTEmXJ96bEYkWbF58TFIWt5ekyROvbD7vKkM3M
	+RM88VMy0to6xhip8Dy3E7AfZDryqMw6iSH2O9sk7YHZFhW40QJUsJMXtLiv5inQvtLrTOokstv
	utqCcY6HKKtjIacHsmuHDzrJlVpo5N1BHh9pSaVygmdqogE0EqNFtTyJGUH5q7qs6GpA5W5Q8Vl
	Zo/vnKVXE4tFtPGvRye0rAg==
X-Google-Smtp-Source: AGHT+IGyHppl9WSpNkvjccnN2b/Pu5ICYTcHqyYlYPw8OC+BmhMbpS2gWZamnYmtJJzPEH9nHIIWGg==
X-Received: by 2002:a17:902:cccd:b0:248:db40:daed with SMTP id d9443c01a7336-248db40e394mr1725845ad.1.1756335902206;
        Wed, 27 Aug 2025 16:05:02 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889ddbbsm131578545ad.152.2025.08.27.16.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 16:05:01 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
Date: Thu, 28 Aug 2025 07:03:53 +0800
Message-ID: <20250827230354.16249-1-inochiama@gmail.com>
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
pci_msi[x]_tamplete will not unmask/mask the interrupt when startup/
shutdown the interrupt. This will prevent the interrupt from being
enabled/disabled normally.

Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
cond_[startup|shutdown]_parent(). So the interrupt can be normally
unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.

Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
Reported-by: Wei Fang <wei.fang@nxp.com>
Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Change from v1:
- https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/
1. Apply Tested-by, Reported-by and Tested-by from original post [1].
2. update mistake in the comments.

[1] https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
---
 drivers/pci/msi/irqdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 50ccac32f4cf..cbdc83c064d4 100644
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


