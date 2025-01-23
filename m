Return-Path: <linux-pci+bounces-20268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98472A19EC0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40B3162E02
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E21C3C1D;
	Thu, 23 Jan 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wuf6SAYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AA1BD01F;
	Thu, 23 Jan 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737616580; cv=none; b=A324v7TC9ucbNslHOj+1LFwaqWtjWvZawV0U+fkDgpJwzdThne8tC//V2WBBH3H5mgUsosY9BPfeujvzbhINb58oHrVRPyrMqphR/yXNBXZ6M1KIjAL4+4gn50gJVI/7o4qwT+MIWdYvgAAYTbZiE9Jtkk41yNeiVcuG4JFNBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737616580; c=relaxed/simple;
	bh=YtJV3JGnjFb5QIlgEqoMYfV6UHSGKBpftvmyVMGqMqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOe4p3F5u0Bao0URl9TkYHb5jezx/dbLMbMflO/N4271+xyZ3RR5Sk1NCCdl/thTyehVk1pXtDiZ4Zf63xaJMI0yzIHZtF7LQBUI/NxbjzCJ4Qg6+jWtYDG7AEgf1VGnqmslvbpYdXo67hxo0xtKwDkceMDPmUBq2lFfcDfKvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wuf6SAYH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HbblH
	HHHSglcAJQmJvuSUi3YXVREskEfV9xRht++azc=; b=Wuf6SAYHZlopwCXgMgLAT
	fHgM+PwkGZBM9zXKumfM0NTRTwq8auO4Bo10R1SLLdUSgdOXQBWcm2LoMjQACl9Q
	7VXZhR1d8m3A9xX12hH6QGRadLwMWMx9/noIIuf0D6rvQzfesqZg6oEWoU3gRCuC
	en68ZTLKDF/fJro4rzqRAc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAXK_8Y7JFnbLfOHg--.3910S2;
	Thu, 23 Jan 2025 15:13:30 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: jingoohan1@gmail.com
Cc: manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM status of the PCIe link
Date: Thu, 23 Jan 2025 15:13:26 +0800
Message-Id: <20250123071326.1810751-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXK_8Y7JFnbLfOHg--.3910S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1UtF1fAr4rtFW5trW5Jrb_yoWxKF1Upa
	y8AFWFyF42vw1qy3W5J3WkZa13tFnayFyq9r47J3yxJ3WIy3WDGr45Jw1UKrWkJr47Gr13
	J3W3AF1kGr48G3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE5EfUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwLdo2eR6iQVmwABsE

Add the sysfs property to provide a view of the current link's LTSSM
status from the root port device.

  /sys/bus/pci/devices/<dev>/ltssm_status

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 86 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 32 +++++++
 drivers/pci/pci-sysfs.c                       |  3 +
 drivers/pci/pci.h                             |  4 +
 4 files changed, 125 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8b..8ec0e35cca8f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,92 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
+{
+	char *str;
+
+	switch (ltssm) {
+#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
+	default:
+		str = "DW_PCIE_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str;
+}
+
+static ssize_t ltssm_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	struct dw_pcie_rp *pp = bridge->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return sysfs_emit(buf, "%s\n",
+			  dw_ltssm_sts_string(dw_pcie_get_ltssm(pci)));
+}
+static DEVICE_ATTR_RO(ltssm_status);
+
+static struct attribute *ltssm_status_attrs[] __ro_after_init = {
+	&dev_attr_ltssm_status.attr, NULL
+};
+
+static umode_t ltssm_status_attrs_are_visible(struct kobject *kobj,
+					      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if ((a == &dev_attr_ltssm_status.attr) &&
+	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group dw_ltssm_status_attr_group = {
+	.attrs = ltssm_status_attrs,
+	.is_visible = ltssm_status_attrs_are_visible,
+};
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..fb7e3c14e523 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,8 +330,40 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
+	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
+	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
+	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
+	DW_PCIE_LTSSM_CFG_LINKWD_START = 0x7,
+	DW_PCIE_LTSSM_CFG_LINKWD_ACEPT = 0x8,
+	DW_PCIE_LTSSM_CFG_LANENUM_WAI = 0x9,
+	DW_PCIE_LTSSM_CFG_LANENUM_ACEPT = 0xa,
+	DW_PCIE_LTSSM_CFG_COMPLETE = 0xb,
+	DW_PCIE_LTSSM_CFG_IDLE = 0xc,
+	DW_PCIE_LTSSM_RCVRY_LOCK = 0xd,
+	DW_PCIE_LTSSM_RCVRY_SPEED = 0xe,
+	DW_PCIE_LTSSM_RCVRY_RCVRCFG = 0xf,
+	DW_PCIE_LTSSM_RCVRY_IDLE = 0x10,
 	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L0S = 0x12,
+	DW_PCIE_LTSSM_L123_SEND_EIDLE = 0x13,
+	DW_PCIE_LTSSM_L1_IDLE = 0x14,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
+	DW_PCIE_LTSSM_L2_WAKE = 0x16,
+	DW_PCIE_LTSSM_DISABLED_ENTRY = 0x17,
+	DW_PCIE_LTSSM_DISABLED_IDLE = 0x18,
+	DW_PCIE_LTSSM_DISABLED = 0x19,
+	DW_PCIE_LTSSM_LPBK_ENTRY = 0x1a,
+	DW_PCIE_LTSSM_LPBK_ACTIVE = 0x1b,
+	DW_PCIE_LTSSM_LPBK_EXIT = 0x1c,
+	DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT = 0x1d,
+	DW_PCIE_LTSSM_HOT_RESET_ENTRY = 0x1e,
+	DW_PCIE_LTSSM_HOT_RESET = 0x1f,
+	DW_PCIE_LTSSM_RCVRY_EQ0 = 0x20,
+	DW_PCIE_LTSSM_RCVRY_EQ1 = 0x21,
+	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
+	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
 
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7679d75d71e5..c23d188323f4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1696,6 +1696,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCIE_DW_HOST
+	&dw_ltssm_status_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..3775841b5714 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -960,6 +960,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 extern const struct attribute_group aspm_ctrl_attr_group;
 #endif
 
+#ifdef CONFIG_PCIE_DW_HOST
+extern const struct attribute_group dw_ltssm_status_attr_group;
+#endif
+
 extern const struct attribute_group pci_dev_reset_method_attr_group;
 
 #ifdef CONFIG_X86_INTEL_MID

base-commit: 7004a2e46d1693848370809aa3d9c340a209edbb
-- 
2.25.1


