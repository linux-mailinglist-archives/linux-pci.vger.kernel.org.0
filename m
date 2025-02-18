Return-Path: <linux-pci+bounces-21684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135FA39172
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 04:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F216B548
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 03:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1B74040;
	Tue, 18 Feb 2025 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vQx3JXi8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D91A08DB;
	Tue, 18 Feb 2025 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850553; cv=none; b=cbjmwSmkcF3KY3YaXSnnC0U1E6B/jmOj++5GIDAVKaUMN/SWbCTrsaRTRwgZYIFTYnaOeF3BD3gFKQJKENuoG+c/Y4fF52ZU9JaSN6+6sg0MQO9HZWTdEHoDibwLuGqtRCIdM+mVtBrL9RTNL5Fwsud9Ry1ywSq+Pub7O5hKwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850553; c=relaxed/simple;
	bh=gZDwF2MK3WnQqkLHRxze35VFVWxiEl3ROncmqxTo7qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6cJTUwZTsfu6pznoXUL2OaJmKkaI5BIYF8dZI+aYjHH+64dT3YfGPl1ffhFsW+KZX2YutEUfISwJRNtIEAEc+XdhBmAWOTMDO9jbe4Hs9kIw/E+a236sM2k2c5RwyOmlsrxA6xlAbMrFO1Sam5yVkdoAC0JGbVRI+i1vHl3rT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vQx3JXi8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739850541; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RoTkR/BoWRWXPU8Qu+KO1xpOJocUTVSiHDA/GEB6aOg=;
	b=vQx3JXi8+76mez0C0X/qcA02ZbsxwJdNUWZr1FSjziJk+7YfhrfD/t8ayZ3ilo2Dl30NK1S4GWqyHv+vaWQiwkDdRc7k7rxHrjn1sLHwws87wS06w0oVquHoAov1FfdXxYDTLNZgdyDZCcR4OOO8l+UCYwUXlrO+vTRA8n7kLbY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPkGLoe_1739850540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 11:49:00 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 2/2] PCI: Disable PCIE hotplug interrupts early when msi is disabled
Date: Tue, 18 Feb 2025 11:48:59 +0800
Message-Id: <20250218034859.40397-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
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
interrupt. In the failure case, BIOS doesn't disable the pcie hotplug
interrupts, and actually asserts the command-complete interrupt.

So the timeline is:
1. pciehp's CCIE/HPIE enabled and command-complete interrupts asserted
2. the interrupt is shared by pcie root port and nvme/nic device
3. nvme/nic driver's probe function enables the interrupt line
4. pciehp driver is loaded later or not loaded

And the "nobody cared irq storm" happens between 3 and 4. This is not
an issue for normal MSI case, as each interrupt is controlled by its own
driver. When the driver is not loaded, the interrupt won't get fired
to kernel even if it is physically asserted.

So disable the pcie hotplug CCIE/HPIE interrupt in early boot phase when
MSI is not enabled.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changlog:
 
  Since v1:
    * Modify the commit log

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


