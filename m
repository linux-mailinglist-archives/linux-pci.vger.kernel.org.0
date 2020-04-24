Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B61B7A15
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgDXPjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgDXPjR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:17 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C4720700;
        Fri, 24 Apr 2020 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742756;
        bh=8dGLFXDw65iFrKhsdpHxcbBE+qVbA+a6Y6GfXOjiBnM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hmimKy7el7OqecjO58yTwll14AJWEavRoB70uN/I/53OHTKl9qznAD2hSZjO4hPcm
         zC2bsVoWyFpkHXH80yWaJYRYVPnnVR/nFkOF3MZBGMn2gFLN5AQKBCvk8uPDLT6+Un
         F+KScTvVQDQOPROEFlEVv2k2gVfsxSZfIUx7V37Y=
Received: by pali.im (Postfix)
        id 841EDA19; Fri, 24 Apr 2020 17:39:14 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 03/12] PCI: of: Return -ENOENT if max-link-speed property is not found
Date:   Fri, 24 Apr 2020 17:38:49 +0200
Message-Id: <20200424153858.29744-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424153858.29744-1-pali@kernel.org>
References: <20200424153858.29744-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

OF API function of_property_read_u32() returns -EINVAL if property is
not found. Therefore this also happens with of_pci_get_max_link_speed(),
which also returns -EINVAL if the 'max-link-speed' property has invalid
value.

Change the behaviour of of_pci_get_max_link_speed() to return -ENOENT
in case when the property does not exist and -EINVAL if it has invalid
value.

Also interpret zero max-link-speed value of this property as invalid,
as the device tree bindings documentation specifies.

Update pcie-tegra194 code to handle errors from this function like other
drivers - they do not distinguish between no value and invalid value.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c |  6 +++---
 drivers/pci/of.c                           | 15 +++++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ae30a2fd3716..027bb41809f9 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -296,7 +296,7 @@ struct tegra_pcie_dw {
 	u8 init_link_width;
 	u32 msi_ctrl_int;
 	u32 num_lanes;
-	u32 max_speed;
+	int max_speed;
 	u32 cid;
 	u32 cfg_link_cap_l1sub;
 	u32 pcie_cap_base;
@@ -911,7 +911,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Configure Max Speed from DT */
-	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
+	if (pcie->max_speed > 0) {
 		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
 					PCI_EXP_LNKCAP);
 		val &= ~PCI_EXP_LNKCAP_SLS;
@@ -1830,7 +1830,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
 
 	/* Configure Max Speed from DT */
-	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
+	if (pcie->max_speed > 0) {
 		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
 					PCI_EXP_LNKCAP);
 		val &= ~PCI_EXP_LNKCAP_SLS;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..19bf652256d8 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -584,15 +584,22 @@ EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
  *
  * @node: device tree node with the max link speed information
  *
- * Returns the associated max link speed from DT, or a negative value if the
- * required property is not found or is invalid.
+ * Returns the associated max link speed from DT, -ENOENT if the required
+ * property is not found or -EINVAL if the required property is invalid.
  */
 int of_pci_get_max_link_speed(struct device_node *node)
 {
 	u32 max_link_speed;
+	int ret;
+
+	/* of_property_read_u32 returns -EINVAL if property does not exist */
+	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
+	if (ret == -EINVAL)
+		return -ENOENT;
+	else if (ret)
+		return -EINVAL;
 
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed > 4)
+	if (max_link_speed == 0 || max_link_speed > 4)
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.20.1

