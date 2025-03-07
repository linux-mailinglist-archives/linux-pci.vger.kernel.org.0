Return-Path: <linux-pci+bounces-23087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C358BA5601A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 06:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038A0173E6B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 05:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8104778E;
	Fri,  7 Mar 2025 05:36:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B137FD;
	Fri,  7 Mar 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325775; cv=none; b=cz7FV6OtjMZpf6Tmroi2JisTQHjwSWYqaDZtk6UG1zKy9OPgQC/j3T2zTYZAxSJvGm97zQFoSofsqeLLVlma7iL/PmxCxQt8fplhUl0YE3D9w2tBv320Otp0Pv0ZEwxVf8IS/zNn9Ezy/qKzz8Y/1Xse/EuvmJsUtFHoe4PlOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325775; c=relaxed/simple;
	bh=s2Dx4Vu71yHd+sm6B6lF32xIUed696vD1bvGK1vrMew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyganqzVH0jYsN/k+5bmy6Hj3woMSo87vIefwq272o7eNLUPzzIJaEkhpB4m1O/xpk+uIt5HT4MGQJGg9a+/tqI2yjS8be+wS5WQXEV2StktPRvRkEYNKY5VgEYCtJohO+qyYlFzqQN5kLxVWpTB62vykXZT3CK8+XZKgBDP2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDXsXm+hcpnK+JmBw--.14747S2;
	Fri, 07 Mar 2025 13:35:58 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwB3eYW7hcpnId49AA--.2693S2;
	Fri, 07 Mar 2025 13:35:56 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com,
	cassel@kernel.org,
	christian.koenig@amd.com,
	daizhiyuan@phytium.com.cn,
	helgaas@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4] PCI: Update Resizable BAR Capability Register fields
Date: Fri,  7 Mar 2025 13:35:29 +0800
Message-ID: <20250307053535.44918-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a6952a9-c80b-bbff-fb38-18c61722bdda@linux.intel.com>
References: <3a6952a9-c80b-bbff-fb38-18c61722bdda@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3eYW7hcpnId49AA--.2693S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFWDXFWxGF1DXF13GFyfJFb_yoW5CFWDpF
	WDCa97GrWrGFW7uw4kZ3W8CF4Yg39ruFyYkrWxG3s3u3Z0k3Z2qa4DKFW5ta4DJr4DZF4a
	yrnFy34UuF98JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
but supporting anything bigger than 128TB requires changes to
pci_rebar_get_possible_sizes() to read the additional Capability bits
from the Control register.

If 8EB support is required, callers will need to be updated to handle u64
instead of u32. For now, support is limited to 128TB, and support for
sizes greater than 128TB can be deferred to a later time.

Expand the alignment array of `pbus_size_mem` to support up to 128TB.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/pci.c             | 4 ++--
 drivers/pci/setup-bus.c       | 2 +-
 include/uapi/linux/pci_regs.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 661f98c6c63a..77b9ceefb4e1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  * @bar: BAR to query
  *
  * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
+ * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
  */
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
@@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
  * pci_rebar_set_size - set a new size for a BAR
  * @pdev: PCI device
  * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 19=512GB)
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
  *
  * Set the new size of a BAR as defined in the spec.
  * Returns zero if resizing was successful, error code otherwise.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5e00cecf1f1a..edb64a6b5585 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1059,7 +1059,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1;
-	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
+	resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
 	int order, max_order;
 	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..ce99d4f34ce5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1013,7 +1013,7 @@
 
 /* Resizable BARs */
 #define PCI_REBAR_CAP		4	/* capability register */
-#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
+#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-- 
2.43.0


