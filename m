Return-Path: <linux-pci+bounces-12971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99F972CE2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CBAB20A1A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B012B143;
	Tue, 10 Sep 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fgoPHN+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89946444
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959253; cv=none; b=EhtaqVJ94t5o7QBdDZ3yJxXpQnbSqdgpb16fMJrsktZieRG9rEZkLOGPu/7R7Z82Dv7ba0maeX4eJeQ2hvB3TWQHlMOhUfjuYytmKBFsBNK2U4Lb+gpMbNNAwpF1WHSageUQbtvr2uHC/lv9Qn3rGgTUwLbHQS8dL3U+n3ieuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959253; c=relaxed/simple;
	bh=eo9ZYQA8i939gDHRBPtRHRTfs76k/mocxehqnFFswyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLUQW8ADk3l/8ktFJPOkaVnK2HiW4VsaMyJtPWn0BclXsaMJaylHCZnuU+iWYY8TKWAUzZU5frG+RpBboyT4eCyBG0Za9HpUm6qJyMQUydINIBCiBtqL8zQpxkBcpZb3lZSfbpZ1sUFs5MIR+cTV9HCWd34A7jlihetcRrH7Gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fgoPHN+a; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725959250; x=1757495250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eo9ZYQA8i939gDHRBPtRHRTfs76k/mocxehqnFFswyY=;
  b=fgoPHN+aKbAbou2KmdSvRX+QJRkIzrsB4tfxK8YX5mjxCCQHPM+ahMBf
   018CLMo53xMRKAx5RhdlvRs+og99X8K+A3RiHmZs874X3Q8xq4H+2Dep6
   BBmS9ieicgknwhZoHnXLSz94WwM0IP/QgLqYMvC4/Vk9fsvdOAjchHDcS
   RgspWSUmXq+adW1lWbqh8+QRRtqyQQSOD2iBlI9Cw6suovsL+qwQ1JcJj
   YVszzh9ubC4LV94GajziP8yI1XAzpe7iZUOB9sY1X6+5vZKiuW44KOE8K
   4bHE/UnbqAItQT0XtUfrGizqzZaiYBm7Pp/ZWse49kxzMWwWKLgr9fsrT
   A==;
X-CSE-ConnectionGUID: EnswLONXQtCISyukUP+aRQ==
X-CSE-MsgGUID: D/rhf908SJaol0XIVjwzuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="161245117"
X-IronPort-AV: E=Sophos;i="6.10,216,1719846000"; 
   d="scan'208";a="161245117"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:07:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D874BD6473
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 18:07:18 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 29164D73A6
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 18:07:18 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id F1BE12020A4F;
	Tue, 10 Sep 2024 18:07:17 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org,
	kw@linux.com
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v3] Export PBEC Data register into sysfs
Date: Tue, 10 Sep 2024 18:09:51 +0900
Message-ID: <20240910090951.332773-1-kobayashi.da-06@fujitsu.com>
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
index 2321fdfefd7d..468c929a9347 100644
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
+	&dev_attr_pbec.attr,
 	NULL,
 };
 
-- 
2.45.0


