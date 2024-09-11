Return-Path: <linux-pci+bounces-13022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA39747B5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 03:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727C5283C55
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE511CA9;
	Wed, 11 Sep 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tiR2Gmfl"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131210F1
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017572; cv=none; b=Dd+8cLhjhcihN3AomwZeefEFStFiW3LJYhNf7uvXjGB379mZEntwCmwjyARUAh61BJLqJy1ESqHgTRWuM386FT8H+79ZvjhwwOCsvlPl8MrP/TNL6mUT3tbwMBqp3W0ZZq/Na3AfzSTur12PuhqnO4MNQAlWdGFyPvSVK7NouZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017572; c=relaxed/simple;
	bh=DOXPEf5qJ/MBBZedmZibiYfsTTlP/Nz+/u2l1yuNpdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVM9uCaBUvdIrQuRfaRSd4Fnl8UbQ5UlXivNosnQOCGXnvVZXY5+/T0OC0M59oGdkIpYuqB6uxYZwO8sjaGnydlSCAUdFpRZaC26uUmM+oTIE1pohL9RVsP3cGKUgERL/bGwYIe048USpivX0tTcfkjeLMRWazDNONQGiW8U+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tiR2Gmfl; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1726017569; x=1757553569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DOXPEf5qJ/MBBZedmZibiYfsTTlP/Nz+/u2l1yuNpdk=;
  b=tiR2GmflLQs41G9cdqvldOpsfuXEl35PIEdHHx8DsuhvcCSZMQ4ARayg
   kiq2R2ZGWN+idsSC+cEyY3tgq6YRiRqOIAsPT3F83uN95qklFQ6U55sz9
   AEdqxEe8UqQB+vNMVKqMhfe70DsgLIYKUcP/wMg5FDo6mLxsmGwfdhOC1
   ArQDPtDL5e7S5iz+YvUTZmqNEXgcEwhU4tcgLrDyYzReL7M8CcnSWmuRK
   vPjM/lnr1tKMqTMccTdMgvZhLcBjVHpD3eM8ISOUEz8Aik+Jma4iBJ0Ay
   748L2jXdpdLSJDtyc6OMteYJQrpRYUEVqkgxn7ymt+LZxeACi+/ejC/DJ
   A==;
X-CSE-ConnectionGUID: JIn2Ntn0RGKk/SGOESUufQ==
X-CSE-MsgGUID: qMFDzIPFSGGKXhxe8iMY+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="173354449"
X-IronPort-AV: E=Sophos;i="6.10,218,1719846000"; 
   d="scan'208";a="173354449"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 10:18:17 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B4BAC68E1
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 10:18:15 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A97AD96A0
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 10:18:14 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 5E6FA20521CC;
	Wed, 11 Sep 2024 10:18:14 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org,
	kw@linux.com
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v4] Export PBEC Data register into sysfs
Date: Wed, 11 Sep 2024 10:20:53 +0900
Message-ID: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This proposal aims to add a feature that outputs PCIe device power 
consumption information to sysfs.

Add support for PBEC (Power Budgeting Extended Capability) output 
to the PCIe driver. PBEC is defined in the 
PCIe specification(PCIe r6.0, sec 7.8.1) and is
a standard method for obtaining device power consumption information.

PCIe devices can significantly impact the overall power consumption of
a system. However, obtaining PCIe device power consumption information 
has traditionally been difficult. 

The PBEC Data register changes depending on the value of the PBEC Data 
Select register. To obtain all PBEC Data register values defined in the 
device, obtain the value of the PBEC Data register while changing the 
value of the PBEC Data Select register.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++
 drivers/pci/pci-sysfs.c                 | 28 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..be1911d948ef 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,20 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../power_budget
+Date:		September 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file provides information about the PCIe power budget
+		for the device. It is a read-only file that outputs the values
+		of the Power Budgeting Data Register for each power state as a
+		series of 32-bit hexadecimal values. Each line represents a
+		single Power Budgeting Data register entry, containing the
+		power budget for a specific power state.
+
+		The specific interpretation of these values depends on the
+		device and the PCIe specification. Refer to the PCIe
+		specification for detailed information about the Power
+		Budgeting Data register, including the encoding	of power
+		states and the interpretation of Base Power and Data Scale.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..c52814a33597 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t power_budget_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	size_t len = 0;
+	int i, pos;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	for (i = 0; i < 0xff; i++) {
+		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
+		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+		if (!data) {
+			if (len == 0)
+				return -EINVAL;
+			break;
+		}
+		len += sysfs_emit_at(buf, len, "%04x\n", data);
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(power_budget);
+
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_power_budget.attr,
 	NULL,
 };
 
-- 
2.45.0


