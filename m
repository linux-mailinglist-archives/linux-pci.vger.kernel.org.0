Return-Path: <linux-pci+bounces-15005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778EC9AA2AB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C52283654
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DF19ABBD;
	Tue, 22 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDJfnbUG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDB19D063;
	Tue, 22 Oct 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602169; cv=none; b=NnaSz6FN+gJtAcnYeqFIeYlnCSZ9RzeOSKMiHivt5dfmhZIXiPDdXA8r+/8yeZgKxo5W8sLoxK0tKxZrCcJ0TAjb6Qr3KUa7rU7ucsEg1xQyz5OCkjUgr5k1kSNWSQZJ9I79Fs21YnZbZGcVT4i5M54rj+Hj9s6e7liHdYrUEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602169; c=relaxed/simple;
	bh=ZSse1Eg98+LMzutfh1nuHu9lTL5IQL+O8CsCAOf6TnQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o3iJqe7sJlNOO9sOMR7alfF3RJbOVizpTxy2wUWUp69pVcfHSqnOaXyaz6Y3LxExLF9YHtYElUfr+Xnr+yhl4Qcfh8AykeLHXZMb7CMz3zD0nEnuYrsT5oMcYy9BqLnVGXPmUzbEW+TUWXYTWSaebvkweo57Z8B/JeNA6lNokuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDJfnbUG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e6981ca77so39683325ad.2;
        Tue, 22 Oct 2024 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729602166; x=1730206966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q90p0I1RamExvHkraCkhdLHfJUzwCzfvv1jVPeRZmCQ=;
        b=dDJfnbUGCtLam88FBwi4u0n3635kXshDNqSmbwjbwrU0G5zXFUldW69/+uVQ9YdeZL
         boVBuB34SVFPUMJc8UgGmOenpZH1HqJ2VjPawTtHumPB90CzXYI12DlQ1TwxYiW6SH7d
         tKcf4oJHObOdKT1fhMAJ/k23baxqd52Vza6qnE/SYt5UErz9OCCwB9f7xIyJdFCBK1t7
         GsFRKpajcuWSDsBTXFIkAtcYtXS19ESIY7jiYp5ABAPBRgn+8X299DMZH3hEX7pXdnO3
         KXuCXobG5GUwQ2puZ/Sxm1OSxvfnVbThCDq2aEKsvC7gRVNljmjp7TaTo2Iuh3YtMiWl
         yhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602166; x=1730206966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q90p0I1RamExvHkraCkhdLHfJUzwCzfvv1jVPeRZmCQ=;
        b=VJt6yikLqZZwWWyZzvRq/lSslaC41vZYC05BCwvdJx9VadONSkv00OaYO4CfyL/0+J
         nIKzwUmE9PLQRI6UGtWIwQIXnq1ji/nS8ZbwP/qtsE8YB3C0PaBgHGCQ8UFjiOcJBfQY
         RGsZP0OUgfIIGGfCi8qoo1zoUtWDsebwLu20TF1d4qS5+/6IsmI/oXcrPfxUmMsWXhVH
         hUlFqZKFUT3oT1kEKMOm4CIYRXnNUDnTWFsYwzeP3OQVEJeYMr60vbIh9HiBObfGFCIg
         LbcNL6KcYdVr46/BTbrhqle9H/ZTAlkVEupVd5r0yPI9gBl0HYszvw9mbcoSE7jmQW/0
         Lpew==
X-Forwarded-Encrypted: i=1; AJvYcCUE5zj5p0qnEko1BsE8B48nzyZh7cvUIkmBgI9vG9z4MmuLda1evHifzb/YuWmsMPMsFingvuMqpY8N@vger.kernel.org, AJvYcCX9IJ5EPDrgEaLsagAGTr+WCBUj8pceQbFITauwvXSVJAYtGoyzDhmCtgiOFR5CmkGfjg2mLrqtscsuuA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7xD3dYxilRmDL22Os0IBbA+cpgPST5eliO2ptQLjelrQ8Gnu
	X2hPSXmFok9cMnFGMCKKVoVCnY+z7VpF4ltN5cYssGieutNN4cDY
X-Google-Smtp-Source: AGHT+IFCcz86yrNVz77sdnjYCsihCqlHFylImqt1Dq571tcbh5Glp/tYRtgDnA6h/bGZmqK8QLdFbQ==
X-Received: by 2002:a17:902:d2cd:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20e985dbd00mr25114295ad.61.1729602165948;
        Tue, 22 Oct 2024 06:02:45 -0700 (PDT)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0dba22sm42542085ad.220.2024.10.22.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:02:45 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: pciehp: Fix system hang during resume with daisy-chained hotplug controllers
Date: Tue, 22 Oct 2024 21:02:43 +0800
Message-ID: <20241022130243.263737-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A system hang occurs when multiple PCIe hotplug controllers in a daisy-chained
setup (like a Thunderbolt dock with NVMe storage) resume from system sleep.
This happens when both the dock and its downstream devices try to process PDC
events at the same time through pciehp_request().

This patch changes pciehp_request() to atomic_or(), which adds the PDC event to
ctrl->pending_events atomically. This change prevents the race condition by
making the event handling atomic across multiple hotplug controllers during
resume.

The bug was found with an Intel Thunderbolt 4 Bridge (8086:0b26) dock and a
Phison NVMe controller (1987:5012), where the system would hang if both devices
tried to handle presence detect changes during resume.

Changes:
  v2:
    * Replace pciehp_request() with atomic_or() to fix race condition

  v1:
    * https://lore.kernel.org/lkml/Zvf7xYEA32VgLRJ6@wunner.de/T/
    * Remove pci_walk_bus() call
    * Fix appeared to work due to lower reproduction rate

Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/pci/hotplug/pciehp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..56bf23d55c41 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -332,7 +332,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 			ctrl_dbg(ctrl, "device replaced during system sleep\n");
 			pci_walk_bus(ctrl->pcie->port->subordinate,
 				     pci_dev_set_disconnected, NULL);
-			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+			atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events);
 		}
 	}
 
-- 
2.43.0


