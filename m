Return-Path: <linux-pci+bounces-11287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A325947837
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3133A285717
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9EE14E2FD;
	Mon,  5 Aug 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kZSf0aeB"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FE150990;
	Mon,  5 Aug 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849645; cv=none; b=VQfIMpG4vAbJFrRmJK/g5XjlETsjGW0XtS1fORRCos8+3TEwJY/Qj1zYYo4rYJt2KA9vCNbjkn3IqdjkoVpbPhInAeEt/EyKTztEqOfps4DCbCOckBA4A5sbh/R2cbpZ1/CGKZkQFfO+VIpmVw49N1g8jfDpceUbKgUueMxCXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849645; c=relaxed/simple;
	bh=b5heeRdhZJFZMg01gdpFCW5JlPhDbxMw3iu/c81JK5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drpn+OpPKfoKEeqsBqQfsk6I3osWDnmblZp/9eTZcYZ9MEaqwtNG8sneIi0WK1U5M7ZwZoVN3QZ8HwkfrcVTeiF+xTMu5KwxYIivBPNdz/IUBSR6zRNr3Trkj5px8uWXFFN3375HF6+bNX+ZzB9gbRhbnrf2GYM2pi3T/o0kSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kZSf0aeB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VXcyq
	M1GX+hSvyd+zy7tPfBS8sV00w4G3p2K/7gHXN4=; b=kZSf0aeB5rhEAmvuPBs0f
	v0ieI7hVJHrNxp8lraLtgj8j5w+l4jQ6lnQSvXeGG45sIOWj1NpquhybqTDdDV/d
	oXGrvUubAGT4ToP3K3e+HgBx2oB2XAr8zP4OXbRP3kjwLk8xzOqb9E4OwybAHYKF
	8XNrz1nvTUcrT8QzXs/fQw=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDn77lNmbBmQWuuAQ--.226S2;
	Mon, 05 Aug 2024 17:20:13 +0800 (CST)
From: 412574090@163.com
To: corbet@lwn.net,
	bhelgaas@google.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] PCI: limit pci bridge and subsystem speed to 2.5GT/s
Date: Mon,  5 Aug 2024 17:20:10 +0800
Message-Id: <20240805092010.82986-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn77lNmbBmQWuuAQ--.226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1fAryUtF1DAF48JFW7CFg_yoW7tw4kpF
	WDAa4ayry8GF1UWr4DAa1DuFy3Z392v3ySkrW0k34S9FsIyas5tF4Sgr1avFnrWrWkuF13
	Jr4aqry8CF4UtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI9a9UUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBFQ8tAGXAmqDH+wACsW

From: weiyufeng <weiyufeng@kylinos.cn>

Add a kernel command-line option 'speed2_5g' to limit pci bridge
and subsystem devices speed to 2.5GT/s. As a debug method, this
provide for developer to temporarily slow down PCIe devices for
verification.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 drivers/pci/pci.c                             |  6 ++-
 drivers/pci/pci.h                             |  1 +
 drivers/pci/probe.c                           | 41 +++++++++++++++++++
 include/linux/pci.h                           |  3 ++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e86a098e06a8..e9b62e259128 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4632,6 +4632,14 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		speed2_5g=
+				Format:
+				[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
+				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+				Specify one or more PCI bridge devices (in the
+				format specified above) separated by semicolons.
+				Each bridge device specified will limit the bridge
+				and subsystem devices speed to 2.5GT/s.
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffaaca0978cb..0bda7321167c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -159,6 +159,7 @@ static bool pcie_ats_disabled;
 
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
+const char *pci_speed_2_5g;
 
 bool pci_ats_disabled(void)
 {
@@ -374,7 +375,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * Returns 1 if the string matches the device, 0 if it does not and
  * a negative error code if the string cannot be parsed.
  */
-static int pci_dev_str_match(struct pci_dev *dev, const char *p,
+int pci_dev_str_match(struct pci_dev *dev, const char *p,
 			     const char **endptr)
 {
 	int ret;
@@ -423,6 +424,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	*endptr = p;
 	return 1;
 }
+EXPORT_SYMBOL_GPL(pci_dev_str_match);
 
 static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				  u8 pos, int cap, int *ttl)
@@ -6905,6 +6907,8 @@ static int __init pci_setup(char *str)
 				disable_acs_redir_param = str + 18;
 			} else if (!strncmp(str, "config_acs=", 11)) {
 				config_acs_param = str + 11;
+			} else if (!strncmp(str, "speed2_5g=", 10)) {
+				pci_speed_2_5g = str + 10;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2fe6055a334d..615fa054e6b1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -67,6 +67,7 @@
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
+extern const char *pci_speed_2_5g;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..d64f328987a0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1846,6 +1846,45 @@ static void early_dump_pci_device(struct pci_dev *pdev)
 		       value, 256, false);
 }
 
+static void pcie_retrain_downstream_2_5g(struct pci_dev *pdev)
+{
+	u16 lnkctl2;
+	const char *p;
+	int ret;
+
+	p = pci_speed_2_5g;
+	while (*p) {
+		ret = pci_dev_str_match(pdev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse pci_speed_2_5g parameter: %s\n",
+				pci_speed_2_5g);
+			break;
+		} else if (ret == 1) {
+			/* Found a match */
+			break;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	if (ret != 1)
+		return;
+
+	pci_info(pdev, "set downstream link at 2.5GT/s\n");
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &lnkctl2);
+	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+	lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL2, lnkctl2);
+
+	if (pcie_retrain_link(pdev, true)) {
+		pci_info(pdev, "retraining failed\n");
+	}
+}
+
 static const char *pci_type_str(struct pci_dev *dev)
 {
 	static const char * const str[] = {
@@ -2041,6 +2080,8 @@ int pci_setup_device(struct pci_dev *dev)
 			pci_read_config_word(dev, pos + PCI_SSVID_VENDOR_ID, &dev->subsystem_vendor);
 			pci_read_config_word(dev, pos + PCI_SSVID_DEVICE_ID, &dev->subsystem_device);
 		}
+		if (pci_speed_2_5g)
+			pcie_retrain_downstream_2_5g(dev);
 		break;
 
 	case PCI_HEADER_TYPE_CARDBUS:		    /* CardBus bridge header */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4246cb790c7b..18198af09142 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1184,6 +1184,7 @@ void pci_sort_breadthfirst(void);
 
 u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 u8 pci_find_capability(struct pci_dev *dev, int cap);
+int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr);
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
@@ -1984,6 +1985,8 @@ static inline int pci_register_driver(struct pci_driver *drv)
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
 { return 0; }
+static inline int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr)
+{ return 0; }
 static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
 { return 0; }
 static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
-- 
2.25.1


