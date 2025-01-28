Return-Path: <linux-pci+bounces-20484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DAA21016
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10FF1889EFF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1051F9413;
	Tue, 28 Jan 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtFSGymS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7B1F9411;
	Tue, 28 Jan 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086872; cv=none; b=Ukj+j+wJYHF66GhZGgDLLqmTBXy8Ko24SA7JBhiniv6x9HB4bKs8nc4H3ruQpHuTGXdGggMZx/eqXTHS2UnBnfw0I8/HY9R/YNI4ZKKq1hpipQdei4AFEmMu+1qIRffHDc/cBZxP6tJ3gbj12ABFcQnBQMyjuXja7diaE5jzxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086872; c=relaxed/simple;
	bh=u2NVFwfGLC8gkX3sOVNb+6pkQTSVqSHczjq55YHmgjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d497Sg7uwG5Nfu2psJ0Z3OkuYl7flkJeq7QJRFMBySIWdcnZ8dGyJMgdsWUIW7dIyF3kf7fzXLNVmANp8m0lS8S9QaeoJtVtEnhvj7V8pJAdZl20XNUduztBto5lApo/PDk5Mhv0J0LY5tG4AR9R69iQLmKdxN0XL3iGfNFEEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtFSGymS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3340CC4CEE1;
	Tue, 28 Jan 2025 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086872;
	bh=u2NVFwfGLC8gkX3sOVNb+6pkQTSVqSHczjq55YHmgjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtFSGymSZ4Mf+6EYXciqdhY4P/znY0r5vaQn31n8VxPjOqGByGuRCw7w5je5DSjco
	 URfEBl+qEH+am+cXCsxgrgxHcuTgBnLBOkzwNTeEYOhLq75C4bH54Nj9O2bpYHSIih
	 12zcelaUBOXWyCG7WM/fbK/7ujy1OTpYfi8uJ4Sr4kKn6aAeuJQaA4gNpOpEDUzeym
	 Ik6m2TUMT4UuC+ZQRRn8YpO6qCT1+fHZG0zORHxrQ5ISR7H8w6b7VJsZq2X5/865A3
	 jXP9k74YTTjH3x8VC1WGhvs25i5qQ1NINUPHZTsDw/jiiNt7wdocr6EcjCgXghJ9OV
	 af/RtGbJJ4w+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/12] PCI: Store number of supported End-End TLP Prefixes
Date: Tue, 28 Jan 2025 12:54:12 -0500
Message-Id: <20250128175414.1197295-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175414.1197295-1-sashal@kernel.org>
References: <20250128175414.1197295-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit e5321ae10e1323359a5067a26dfe98b5f44cc5e6 ]

eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
are supported by the path or not, and the value is only calculated if
CONFIG_PCI_PASID is set.

The Max End-End TLP Prefixes field in the Device Capabilities Register 2
also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6.2 sec
7.5.3.15). The number of supported End-End Prefixes is useful for reading
correct number of DWORDs from TLP Prefix Log register in AER capability
(PCIe r6.2 sec 7.8.4.12).

Replace eetlp_prefix_path with eetlp_prefix_max and determine the number of
supported End-End Prefixes regardless of CONFIG_PCI_PASID so that an
upcoming commit generalizing TLP Prefix Log register reading does not have
to read extra DWORDs for End-End Prefixes that never will be there.

The value stored into eetlp_prefix_max is directly derived from device's
Max End-End TLP Prefixes and does not consider limitations imposed by
bridges or the Root Port beyond supported/not supported flags. This is
intentional for two reasons:

  1) PCIe r6.2 spec sections 2.2.10.4 & 6.2.4.4 indicate that a TLP is
     malformed only if the number of prefixes exceed the number of Max
     End-End TLP Prefixes, which seems to be the case even if the device
     could never receive that many prefixes due to smaller maximum imposed
     by a bridge or the Root Port. If TLP parsing is later added, this
     distinction is significant in interpreting what is logged by the TLP
     Prefix Log registers and the value matching to the Malformed TLP
     threshold is going to be more useful.

  2) TLP Prefix handling happens autonomously on a low layer and the value
     in eetlp_prefix_max is not programmed anywhere by the kernel (i.e.,
     there is no limiter OS can control to prevent sending more than N TLP
     Prefixes).

Link: https://lore.kernel.org/r/20250114170840.1633-7-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/ats.c             |  2 +-
 drivers/pci/probe.c           | 14 +++++++++-----
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6afff1f1b1430..c6b266c772c81 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -410,7 +410,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ebb0c1d5cae25..665a0867f9e94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2246,8 +2246,8 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2259,15 +2259,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 		return;
 
 	pcie_type = pci_pcie_type(dev);
+
+	eetlp_max = FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
+	/* 00b means 4 */
+	eetlp_max = eetlp_max ?: 4;
+
 	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    pcie_type == PCI_EXP_TYPE_RC_END)
-		dev->eetlp_prefix_path = 1;
+		dev->eetlp_prefix_max = eetlp_max;
 	else {
 		bridge = pci_upstream_bridge(dev);
-		if (bridge && bridge->eetlp_prefix_path)
-			dev->eetlp_prefix_path = 1;
+		if (bridge && bridge->eetlp_prefix_max)
+			dev->eetlp_prefix_max = eetlp_max;
 	}
-#endif
 }
 
 static void pci_configure_serr(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4e77c4230c0a1..ac83b5f90d45c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -399,7 +399,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-End TLP Prefixes, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9c..9bc713fa99b84 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -663,6 +663,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.39.5


