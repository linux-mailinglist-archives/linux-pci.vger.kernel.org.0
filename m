Return-Path: <linux-pci+bounces-42221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7CC8F9BF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52ED44E3E67
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA62DF146;
	Thu, 27 Nov 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HPevv09x"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FD2DF132;
	Thu, 27 Nov 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263454; cv=none; b=PJ3DDC9sfHIL9meZNwe6jULyufZoTjH06Nas3zD+3rcRuLAxAuZayP8Op9xk9SAfBxegzsuYvBQLhj5w8Lag4Fse42VChrigMda2/4Lq+solM6vk2sqzGe4DQJglzMQJlJ/wMWi0jIrweGtDaA3mcoX4N09wCpOhR+KbkcltxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263454; c=relaxed/simple;
	bh=ShWsDxbS9rMHO4Rz2R/xGxd1y8sow72GpKgcMYmFCGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vvvt+QH4b5Gd94nVZlMDDL3b+kg6A2v8HyqIsed3ANU4NQ9ayA0I4u2vASYhgOswPQHu1auE0Ey6lJcCAmWxdiPVl1fr7/0EHTZg1Ai5y53cnf3AuPVLwGv191v3mfZya3wZeYRB/nWtK7z7kqlwoLo7nwAxsrHFee/OrSsZtZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HPevv09x; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p4
	BEwT/W3XQBlce+4mMjg1k8Az7t6B/IA1oEwR7bxT4=; b=HPevv09xcNHbDY2eOg
	1Rf/8YCvaecuIRMb7ZFfrihMYAcMaBYOXZftMvF+9CZRbAH9rQ5e69LQa2iM0ESw
	EMCAV0+/TjKJ343vJmy2vI5MCqzrahW3Of4mWqy3amrcEl/DBj/TpCzVfLA8WzPH
	m3t96BHgcbyp1bpBnUsaA/xj4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX71K2hShpkFjfDA--.43603S3;
	Fri, 28 Nov 2025 01:09:13 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 1/2] PCI: Configure Root Port MPS during host probing
Date: Fri, 28 Nov 2025 01:09:07 +0800
Message-Id: <20251127170908.14850-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127170908.14850-1-18255117159@163.com>
References: <20251127170908.14850-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX71K2hShpkFjfDA--.43603S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DCr43Xr1rAr4DKFy7Awb_yoW8KFyDpa
	yUWanYyFn7GF43ZanrA3W0vFyYqF93ArW3GrZYv34qvan8AryDJrW7ta95Jwn7GrWI9Fya
	vFn8try7CasFvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh4To2kohTEP5AAAsK

Current PCIe initialization logic may leave Root Ports operating with
non-optimal Maximum Payload Size (MPS) settings. The existing code in
pci_configure_mps() returns early for devices without an upstream bridge
which includes Root Ports, so their MPS values remain at firmware
defaults. This fails to utilize the controller's full capabilities,
leading to suboptimal data transfer efficiency across the PCIe hierarchy.

With this patch, during the host controller probing phase:
- When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF) and not
  PCIE_BUS_PEER2PEER (which requires the default 128 bytes for optimal
  peer-to-peer operation), and
- The device is a Root Port, the Root Port's MPS is set to its maximum
  supported value.

Note that this initial maximum MPS setting may be reduced later, during
downstream device enumeration, if any downstream device does not support
the Root Port's maximum MPS.

This change ensures Root Ports are initialized to their maximum MPS before
downstream devices negotiate MPS, while maintaining backward compatibility
via the PCIE_BUS_TUNE_OFF check and not interfering with the
PCIE_BUS_PEER2PEER strategy.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hans Zhang <18255117159@163.com>
Tested-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9cd032dff31e..3970d964d868 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2203,6 +2203,18 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 	}
 
+	/*
+	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all) or
+	 * PCIE_BUS_PEER2PEER (use minimum MPS for peer-to-peer), set Root Ports'
+	 * MPS to their maximum supported value. Depending on the MPS strategy
+	 * and MPSS of downstream devices, a Root Port's MPS may be reduced
+	 * later during device enumeration.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_bus_config != PCIE_BUS_TUNE_OFF &&
+	    pcie_bus_config != PCIE_BUS_PEER2PEER)
+		pcie_set_mps(dev, 128 << dev->pcie_mpss);
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
-- 
2.34.1


