Return-Path: <linux-pci+bounces-22141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C342CA41454
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278713B16D7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274415696E;
	Mon, 24 Feb 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dlStPqtj"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B21A0739;
	Mon, 24 Feb 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740369030; cv=none; b=fqrBBSxQkpkAmv7KiQ0K4nbNwIf5DxYK6Q9U+Q1FOmKlTYNnKJ1bqtp2dzxji+uXKBpHe8X748vVEUIhmM16OlHKy5D5853gshEc+v0UUiqHJwI1knhzitA7JTGr84UdLRxIxFrIo7SD3p2ptZY343EOBRFMaRq2HtqW6Ee27/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740369030; c=relaxed/simple;
	bh=LgkDryLjvEZr6bXpKPqMRGIdv3/PyW9iQTas3G5G60M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3TBIEf7oRmNCAD1lOjzyQPHOoUdo5WTA59nPyIQg+ct9R6nAWcmXMlu6TDu31/hvio4WlLlIx2hacVKv4cqLczPku/JnF9sf3jYYlPTBBlerJrUnNDMSzN5uT6AXjQkCcIZK5kGdoy9Vbiw+5SwVrq20mkqiwjigLJWCFeTF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dlStPqtj; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740369024; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JWdHXTM9C/dfJCHXa70ZhO8Ss2I8+1cp0VWtCNbkVn0=;
	b=dlStPqtjlvWvD9ScvLHz6ay6b/s4XS90EovacqcAvpu/+dHmC+m0lerTOKm9Bo1bTUtJKGXrdrTipBkrh/QUQHLi2OGRobtU/h+FULfU1YtyfaSKC3CiaYAKay7iRN80ns6Lptmy2AYrUhFYq7fy0s6SZ5zc+6v5RT09/6Qe6mI=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQ1rZgc_1740368704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:45:05 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v3 4/4] PCI: Disable PCIe hotplug interrupts early when msi is disabled
Date: Mon, 24 Feb 2025 11:45:00 +0800
Message-Id: <20250224034500.23024-5-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an irq storm bug when testing "pci=nomsi" case, and the root
cause is: 'nomsi' will disable MSI and let devices and root ports use
legacy INTX interrupt, and likely make several devices/ports share one
interrupt. In the failure case, BIOS doesn't disable the PCIe hotplug
interrupts, and the command-complete interrupt was actually asserted.

So the timeline is:
1. pciehp's CCIE/HPIE enabled and command-complete interrupts asserted
2. the interrupt is shared by PCIe root port and nvme/nic device
3. nvme/nic driver's probe function enables the interrupt line
4. pciehp driver is loaded later or never loaded

And the "nobody cared irq storm" happens between 3 and 4. This is not
an issue for normal MSI case, as each interrupt is controlled by its own
driver. When the driver is not loaded, the interrupt won't get fired
to kernel even if it is physically asserted.

So disable the PCIe hotplug CCIE/HPIE interrupt in early boot phase when
MSI is not enabled.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..ffea7851366a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1665,6 +1665,15 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
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


