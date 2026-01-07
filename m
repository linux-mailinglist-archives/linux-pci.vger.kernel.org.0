Return-Path: <linux-pci+bounces-44141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5CCFC8F8
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1FB301B2CB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64826ED5C;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaOXDMXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023CF27AC41;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=SLbTzvRYEenDYiYiUqmTtrPFdaLWcfsFomgg/GBRpRNvVCdsqwq11BcpBEQtAX2kZC/xXr4fjiDl+x7F0iCRxwEDwwHlD/4iA+ajvlRzAVOsHH+ppOQGy/njJzr92ATFebTNY83RngDdjnXRc9XasDnp5iGlE1J/x6mFPP78ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=yzF46xfIi50il38mClEBJMWTp3oIYulpE5xmq/3J6PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAM2HYIzhSU/BGnHJ9KsHviSMCyjURco6/1mzE8qgtwwC3yUhiAqDKWV0f8GUdtcLfZtMYsBdfJZVoc0w1TM+9KJihWTDD40ciJyedbIdRwX013Q3EJlwzryRnIt35tRxLToOk7Wad0NLR6hUNt+dK5onX88qbRSIPTtkKVAps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaOXDMXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A857C2BC86;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=yzF46xfIi50il38mClEBJMWTp3oIYulpE5xmq/3J6PE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PaOXDMXCV/qYR6b58Pyg2puY5Bbk3LZnNsMrUJg7l2Fj+aItkpEK8rfY4WHl4RePh
	 4ZBQB/JwHi7Tzs3oUy24BOh7//b8LlIRXNwzfTnpLh3KEppi/XY6U25twpINFZIXKp
	 t+HJ2FrH4Q4Z7OikM9k/uowUa+kTeRNTJe8/Cy8h85sOsE/GbWEIKGuyw6bj3enD6e
	 W/RvdU00yejwW/LfjZmJnHsUXRBevf9da22aHtmhcRfO5bsu0pjwBCi2kyGaNlQQvO
	 IXXopvc8LYOXdstHZYWZUtqHChnJ3QP2KWqvwf+R3DMxgZzjIFtf9svOVbg7YfGjmk
	 IOytGSNwXWhYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88723CF6BFB;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 13:41:55 +0530
Subject: [PATCH v4 2/6] PCI: dwc: Rename and move ltssm_status_string() to
 pcie-designware.c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-dwc-suspend-rework-v4-2-9b5f3c72df0a@oss.qualcomm.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6823;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yepoYjCczgLvEC/o4OBX9Hvs3juUiwx1csBdzMDaZpY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVNyuhytwytAlpTjDIfNS/zmIOMaKCsnlbA2
 1e33zSwQ/OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTQAKCRBVnxHm/pHO
 9elLB/9f+K0KfUvkBy/rJIE123WazNmHVHtkRe3lxM4cPV7HTmtiWBs2VKGI+CFey/ygDKM2lPQ
 c7kLcyDNXLsy/f0ZBIac2yXj8D5dCCvQFnMJg+K/3DQ23swhwSEBwWbNDJM2kmXcn5tB9d4H90g
 jTlj2akarpikbY2pKNUEDQf7873Eql+3McqWVT9WnB4Aj0EAIgi/Ff9/vZCwf2ZocRX67Vd7KDj
 CPzpf2BJK2YMcVuHVbCnyO9suylqySPL9GGQ+CfhUcBupWCWhZ5RLgH7tl2U4p6w/Yl9026x2W8
 HGwGnSRSTrsWKaUgXZF2fQLuU/Iga4hUdgQRO651qRHlp5HD
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Rename ltssm_status_string() to dw_pcie_ltssm_status_string() and move it
to the common file pcie-designware.c so that this function could be used
outside of pcie-designware-debugfs.c file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------------
 drivers/pci/controller/dwc/pcie-designware.c       | 52 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h       |  2 +
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index df98fee69892..0d1340c9b364 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -443,65 +443,13 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
 }
 
-static const char *ltssm_status_string(enum dw_pcie_ltssm ltssm)
-{
-	const char *str;
-
-	switch (ltssm) {
-#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
-	default:
-		str = "DW_PCIE_LTSSM_UNKNOWN";
-		break;
-	}
-
-	return str + strlen("DW_PCIE_LTSSM_");
-}
-
 static int ltssm_status_show(struct seq_file *s, void *v)
 {
 	struct dw_pcie *pci = s->private;
 	enum dw_pcie_ltssm val;
 
 	val = dw_pcie_get_ltssm(pci);
-	seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
+	seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 55c1c60f7f8f..87f2ebc134d6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,6 +692,58 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
+const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
+{
+	const char *str;
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
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
+	default:
+		str = "DW_PCIE_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("DW_PCIE_LTSSM_");
+}
+
 /**
  * dw_pcie_wait_for_link - Wait for the PCIe link to be up
  * @pci: DWC instance
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..c1def4d9cf62 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -828,6 +828,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
 }
 
+const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
+
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);

-- 
2.48.1



