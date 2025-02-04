Return-Path: <linux-pci+bounces-20679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15DA26B8B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 06:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BEB188675B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4C158558;
	Tue,  4 Feb 2025 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H7GPRfKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AF139579;
	Tue,  4 Feb 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648435; cv=none; b=uVhhkq+LxaJPDR1jpUm/3pMVDHRUQRGajiHMHmWY7sOxABUnzKoAQrRjXNAyLGxWMxPBInA1HCvVMUfp2LbKunpvuGRejGk1h9RtWXpuXGxQMFVTEMK+az76VVzQvFR1Wv+Ch2O47i7pGNdwmng/+a73lwd3vk1xHeXpKBQ1pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648435; c=relaxed/simple;
	bh=iCct0DBbP2W1vpi6THSTibm+AfRcjlGe0lKnkdNC8X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzR3odS+cKJsts4/CtHPJt7VojZ1ZfPQoR5Cuv9TPDb1O+1XBsWrmocW9mveG+nbm9cjnohX7nCwiqWmpTkVGcgWsy+a8Q3HH0ULAZ2nKB6LNetZ+KNTNxS4WIhoLQUMigYmGy2QIm2cexe3/44DeBmV03fQ0MI73/xwP7biTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H7GPRfKI; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738648418; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=74IslISy4mrgKNiJWv1O1Q22rD/RFRZQPMLY7Tnw3a4=;
	b=H7GPRfKIQmgQGgLVsOEZSYmGv5JXh768BThMiv93ezFWbezU77TALKx7r+B26TL5WibStCBGnj8Z6ktMlh18VDkhq7mXYbHF4o0MzCqAaSjSgDXhhtyfFJ3Sy0nZV5DXUFDhSW12+otpKn9aA42dSG5TW0AIfKqaCbuh3kyPpzY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOjXThs_1738647479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Feb 2025 13:37:59 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi is disabled
Date: Tue,  4 Feb 2025 13:37:58 +0800
Message-Id: <20250204053758.6025-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a irq storm bug when testing "pci=nomsi" case, and the root
cause is: 'nomsi' will disable MSI and let devices and root ports use
legacy INTX inerrupt, and likely make several devices/ports share one
interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
interrupts, and  actually asserts the command-complete interrupt.
As MSI is disabled, ACPI initialization code will not enumerate root
port's PCIE hotplug capability, and pciehp service driver wont' be
enabled for the root port to handle that interrupt, later on when it is
shared and enabled by other device driver like NVME or NIC, the "nobody
care irq storm" happens.

So disable the pcie hotplug CCIE/HPIE interrupt in early boot phase when
MSI is not enbaled.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..10d72156da9a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1664,6 +1664,15 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
 		pdev->is_hotplug_bridge = 1;
+
+	/*
+	 * When MSI is disabled, root port will use legacy INTX, and likely
+	 * share INTX interrupt line with other devices like NIC/NVME. There
+	 * was real world issue that the CCIE IRQ is asserted afer boot, but
+	 * will not be handled well and cause IRQ storm. So disable it early.
+	 */
+	if (!pci_msi_enabled())
+		pcie_disable_hp_interrupts_early(pdev);
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
-- 
2.43.5


