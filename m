Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E52C4835
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgKYTYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 14:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgKYTYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 14:24:45 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B5C0613D4
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 11:24:45 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 5so1588093plj.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hy9qnphhNd5Gj5JK+vPiqARct4Ild2RtOwm3YO/2AE8=;
        b=MdROwL/DSQu5uBBW6JpICVfXKnuUikjx1kzgsbLTSqsE1U1uYDI3itzAspgUvXy9vt
         c3k9+jR99RJ3YSohZKPiGKekgrBvyBOuhoAUtC/mzD0xWLPc6f0jQ+omJww/Pjbj3uIY
         ZsvYKDYocutoFjeMxBkCY9Icu6LadEw88DHCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hy9qnphhNd5Gj5JK+vPiqARct4Ild2RtOwm3YO/2AE8=;
        b=WOiK/8eLbJl03erjn2hbPFgmD1tBohOWyLUrL+8VctNcLf5yOOZcgkSLJ6ozkIv6gT
         rKKQm2Qa/MgFKbCLalP836y5W4Tu+RUwH0M32LECdmQMtZc+FULt3ZxDP2xAqqeX3/7z
         FfEnNj7N/2XZ0yDnhki8Y47SLHs8oyeJcf/BUJdIYqb1gsvWYu1r3MiMrqMCc2Zyc1r0
         HT0nTH7TbNznYG05RoSsZf5cwqkSfgRcyRbeijvz51THdlDJbtAiLAeRtUgAYtudrjiM
         yc9ndZjYHR+1n0l6yZOtVUeb/f/oIBo1KAQwLVmicPJDRoh6H124N6Qa0clZg6ONYOuk
         Csfw==
X-Gm-Message-State: AOAM533isZEm1DLdYH+jzS0cJMK6qLucnrVjeun5NLFr2ArrDFCw3Lnv
        NlqZi0rpp1SiMJka9XOMwzDN6vw52DOWQC0vRk4wdK/1PTuQXlbjfIyKfD6c618efY1uSHVfNJ+
        d8aB8IRfDOnfhhOIOp6dvNoTAnwe0eNF5W7vJywxyKGt6TyOUzUkPD+6hVlzGLCmeWaYujJsAF/
        D9NIJo
X-Google-Smtp-Source: ABdhPJxo9K/qx7msVFV7THlgW/gfEmTUZfmFLkXYNI+TXH80W8eWDhvgMFuDqSLdJvL7nvnkVOSqFA==
X-Received: by 2002:a17:902:a70a:b029:da:1911:4285 with SMTP id w10-20020a170902a70ab02900da19114285mr1006429plq.44.1606332284586;
        Wed, 25 Nov 2020 11:24:44 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j69sm2574885pfd.37.2020.11.25.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:24:43 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 5/6] PCI: brcmstb: Add panic/die handler to RC driver
Date:   Wed, 25 Nov 2020 14:24:22 -0500
Message-Id: <20201125192424.14440-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125192424.14440-1-james.quinlan@broadcom.com>
References: <20201125192424.14440-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003e26a005b4f3615b"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000003e26a005b4f3615b

Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
by default Broadcom's STB PCIe controller effects an abort.  This simple
handler determines if the PCIe controller was the cause of the abort and if
so, prints out diagnostic info.

Example output:
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 124 ++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e39bd93790d0..469bbb0ebdd9 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -12,11 +12,13 @@
 #include <linux/ioport.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/kdebug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -187,6 +189,39 @@
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
 
+/* Error report regiseters */
+#define PCIE_OUTB_ERR_TREAT				0x6000
+#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
+#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
+#define PCIE_OUTB_ERR_VALID				0x6004
+#define PCIE_OUTB_ERR_CLEAR				0x6008
+#define PCIE_OUTB_ERR_ACC_INFO				0x600c
+#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
+#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
+#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
+#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10
+#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
+#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
+#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
+#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
+#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
+#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
+#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
+#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
+#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1
+#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
+#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
+#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
+#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
+#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
+#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1
+
 /* Forward declarations */
 struct brcm_pcie;
 static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
@@ -229,6 +264,7 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	const bool has_err_report;
 };
 
 static const int pcie_offsets[] = {
@@ -269,6 +305,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.type		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_err_report = true,
 };
 
 struct brcm_msi {
@@ -311,8 +348,89 @@ struct brcm_pcie {
 	struct regulator	*regulators[PCIE_REGULATORS_MAX];
 	int			num_regulators;
 	bool			ep_wakeup_capable;
+	bool			has_err_report;
+	struct notifier_block	die_notifier;
 };
 
+/*
+ * Dump out pcie errors on die or panic.
+ */
+static int dump_pcie_error(struct notifier_block *self, unsigned long v, void *p)
+{
+	const struct brcm_pcie *pcie = container_of(self, struct brcm_pcie, die_notifier);
+	void __iomem *base = pcie->base;
+	int i, is_cfg_err, is_mem_err, lanes;
+	char *width_str, *direction_str, lanes_str[9];
+	u32 info;
+
+	if (readl(base + PCIE_OUTB_ERR_VALID) == 0)
+		return NOTIFY_DONE;
+	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
+
+
+	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
+	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
+	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
+	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
+	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
+	for (i = 0, lanes_str[8] = 0; i < 8; i++)
+		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
+
+	if (is_cfg_err) {
+		u32 cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
+		u32 cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
+		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
+		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
+		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
+		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
+
+		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
+			width_str, direction_str, bus, dev, func, reg, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
+	}
+
+	if (is_mem_err) {
+		u32 cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
+		u32 lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
+		u32 hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
+		u64 addr = ((u64)hi << 32) | (u64)lo;
+
+		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
+			width_str, direction_str, addr, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
+	}
+
+	/* Clear the error */
+	writel(1, base + PCIE_OUTB_ERR_CLEAR);
+
+	return NOTIFY_DONE;
+}
+
+static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
+{
+	pcie->die_notifier.notifier_call = dump_pcie_error;
+	register_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list, &pcie->die_notifier);
+}
+
+static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
+{
+	unregister_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list, &pcie->die_notifier);
+	pcie->die_notifier.notifier_call = NULL;
+}
+
 static int brcm_parse_regulators(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1309,6 +1427,8 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
 	pci_stop_root_bus(bridge->bus);
+	if (pcie->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
 	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
 
@@ -1347,6 +1467,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
 	pcie->type = data->type;
+	pcie->has_err_report = data->has_err_report;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 
@@ -1410,6 +1531,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	if (pcie->has_err_report)
+		brcm_register_die_notifiers(pcie);
+
 	return pci_host_probe(bridge);
 fail:
 	__brcm_pcie_remove(pcie);
-- 
2.17.1


--0000000000003e26a005b4f3615b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKsjD1yiceMU
QfBF/v6JPm9c+XkALl+EtmHNMPxfTOFXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyNTE5MjQ0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCQrgQ1AYPIyIkA/yPU022Ax9trTk45
0qM0vd1E0u313UiJ0QxPy9OPmLugsKi6mp8k2t07shNoi1g6qxTUyoC+Pkbn0YKrXEdxHlRvTNyA
I4pAvs2PPggrx8sCVsXVECEUlJQ9eji0YyMqJ2b8vA60hJAB8XX+2t10jPdAcIoXdp2aTARXQd9M
m4h6oja85903NK3e1JVE6hWPZruYmTZjjcj4m2SFpUHsQXMlMlg/4oO1Xpuh3559xX/OA7q/3nC7
d0ZMUjf1bW2d2V2tYV/ZnuCozBzEKhTB3qLm9iVmcQi2tkpbmpBJBFBuUB4fq2xI4pYk6zRKBr2r
hgbxs6ar
--0000000000003e26a005b4f3615b--
