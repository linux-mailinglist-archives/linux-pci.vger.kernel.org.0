Return-Path: <linux-pci+bounces-20487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26377A21048
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D83A9A47
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E11FBCA2;
	Tue, 28 Jan 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmNHuV++"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED471FBC9B;
	Tue, 28 Jan 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086891; cv=none; b=YEVi/M8sZeK+XgBD6Pcs1C/QGrB84ITt5NnM+G0A/SoyNC+kOfWyUkQ0/xghALOvwu/qvkQbqqPyUCJMOXoD8ttKHG7WVAtScEJZT7EPmlhrGkrex0h4PpEaf0Ioy8QkHfk5xyFhKiskyXl9EGTCT+5YYBh8G3u4M02aikJ7xYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086891; c=relaxed/simple;
	bh=h3o2nNA4oarR842CCOSrzDIpgqnXMzEehCS4f/0qdQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGT7sdGLBI3eJy6L9O/cHwlHD/3I84Z6AQ7ZMelWWs0MkcJU1y/unay77U8+3rtRZyZlzPyXCbyMJ4OMZo2LBZ2gQRjgAm/ujIN+Arv3YNfHieNitbFY8Miyvw9mXQxdpSX2V3obix95xDjMX3DGDO/55hha9U0lcswwCITbVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmNHuV++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D9C4CED3;
	Tue, 28 Jan 2025 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086891;
	bh=h3o2nNA4oarR842CCOSrzDIpgqnXMzEehCS4f/0qdQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmNHuV++SvLKpB51PTFBhLNla1BNtn3uzXqeUICTK40Ef+a+nkUDnS5SitaedFUvv
	 hOvMozOGJWvMVXGEwervoa9+LOeieYMJPY1S23+Uso5nPdQfon8bOzUG0Nu6w5bPMm
	 Ao+tme+y/0y7C8caOUiTia5lImjVv5yYDzf8WRI64MFZRvNvR/M0ybSpFDzGMo8Dam
	 657P6FpKvwn2jjqkDuSmqhvEiO/hTxT8h4Wh9tiSbnllLib8g9980AQNnw8eEMA+w1
	 D0f37InLi2aahLN1lf0fY4Y1Gt749gVzwHscY8O94kYge9Yu/Y3YpUTBuxh+muoc/S
	 y+5ig/2hAXgmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/11] PCI: Store number of supported End-End TLP Prefixes
Date: Tue, 28 Jan 2025 12:54:33 -0500
Message-Id: <20250128175435.1197457-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175435.1197457-1-sashal@kernel.org>
References: <20250128175435.1197457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index f9cc2e10b676a..4a24741fe2f0e 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -376,7 +376,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03b519a228403..e812835146a0d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2238,8 +2238,8 @@ static void pci_configure_ltr(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2251,15 +2251,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
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
index 2d1fb935a8c86..153e0abd3a8cd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -397,7 +397,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-End TLP Prefixes, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ade8dabf62108..b10c75ed6a035 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -659,6 +659,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.39.5


