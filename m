Return-Path: <linux-pci+bounces-22140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D3A41430
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE2F1893DF1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAD1C6FF7;
	Mon, 24 Feb 2025 03:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nBl6tJVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130731B21BF;
	Mon, 24 Feb 2025 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368716; cv=none; b=n6jQQQs7Xw2m3TN27z9ErT64COc8Qqqq6lEhpg7SL6lff+2p4k7L5VqCd53nGRHsuvCPv2v91F4XoEd58bOuzdH10lUQZGVAHaEBt/Ek7ZKdXeFoj3P4tKhVDuwfzLcDevUPDWlHie0kOpypC+WqamHrijhsgKxJdpT5yxG+DkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368716; c=relaxed/simple;
	bh=PjVIVURsiTWXN7S/uHQMS2YiaBnO/xXEB3uw33ifyKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iekrsflH80Eil6N+/sYm2jJ0MLN+b9mUnnDddwzPQIKBpOoahmszdhOqFOQeryujIwAikuxeyIYZRtYytqopXKeXj5Kd5AuZrqeiLia/WEYX7MHdI6IDqodfgOMYNulAd8e5vt5yS2wIDI5GicJiLDNiJNjccxW2GTu0C0B/O/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nBl6tJVf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740368706; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MtQeeh/3PwVb5Y4qvoWpaZCTj/9V1FHfpbzFSWYE6SE=;
	b=nBl6tJVfK+Qm/zcxnYKXmbzcYjU8Wtu3rYj85gPTMkUbUo2b/umDf4Y/cHBHHq2NcOB0y8ax/kYKy6h+gq6nKXHwjFYUPele31V5oucM9E+w1wcl11iRmDHr5IqIy0pbsVs3SKD6s1z8bPBCDBOg9argdpd93y4Yfg5YzoH3v/g=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQ1rZgH_1740368704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:45:04 +0800
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
Subject: [PATCH v3 3/4] PCI/portdrv: Loose the condition check for disabling hotplug interrupts
Date: Mon, 24 Feb 2025 11:44:59 +0800
Message-Id: <20250224034500.23024-4-feng.tang@linux.alibaba.com>
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

Currently when 'pcie_ports_native' and host's 'native_pcie_hotplug' are
both false, kernel will not disable PCIe hotplug interrupts. But as
those could be affected by software setup like kernel cmdline parameter,
remove the depency over them.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/pcie/portdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index ca4f21dff486..619d06b1b3e8 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -263,9 +263,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 	if (dev->is_hotplug_bridge &&
 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
-		services |= PCIE_PORT_SERVICE_HP;
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		if  (pcie_ports_native || host->native_pcie_hotplug)
+			services |= PCIE_PORT_SERVICE_HP;
 
 		/*
 		 * Disable hot-plug interrupts in case they have been enabled
-- 
2.43.5


