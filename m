Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42BB280994
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 23:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgJAVos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 17:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 17:44:48 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8169C2074B;
        Thu,  1 Oct 2020 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588687;
        bh=IIB/IA95u/Gtiso3dxaVhQhYB//XBnPyo9g9xpzGZvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cE1MudhQUzcZsmcncF+9+Y7G/b+0et7Jyw1MxHnFicrErARYwWDhN5rcNbcX4fcZx
         Cz+pGfF7PcOD8jsceKsaPM7PvyFSmzp1XdUJaCCNJRdFsIdZ+ooYH28i9uOJRRcrHw
         AcfCwpiVnNJCcPWm1661ZO3HcCAk7ev2vWiYCJ9o=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 1/2] PCI/ASPM: Rename encode_l12_threshold(), convert arg to ns
Date:   Thu,  1 Oct 2020 16:44:35 -0500
Message-Id: <20201001214436.2735412-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001214436.2735412-1-helgaas@kernel.org>
References: <20201001214436.2735412-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename encode_l12_threshold() to pci_lat_encode() and convert its argument
from microseconds to nanoseconds so we can share it between
LTR_L1.2_THRESHOLD encoding and LTR Max Snoop/No-Snoop Latency encoding.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..beb6e2e4e5d2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -307,6 +307,17 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
 }
 
+static void pci_lat_encode(u64 lat, u32 *scale, u32 *val)
+{
+	/* See PCIe r5.0, sec 7.8.3.3 and sec 6.18 */
+	     if (lat < 32)	 { *scale = 0; *val = (lat >>  0) & 0x3ff; }
+	else if (lat < 1024)	 { *scale = 1; *val = (lat >>  5) & 0x3ff; }
+	else if (lat < 32768)	 { *scale = 2; *val = (lat >> 10) & 0x3ff; }
+	else if (lat < 1048576)	 { *scale = 3; *val = (lat >> 15) & 0x3ff; }
+	else if (lat < 33554432) { *scale = 4; *val = (lat >> 20) & 0x3ff; }
+	else			 { *scale = 5; *val = (lat >> 25) & 0x3ff; }
+}
+
 /* Convert L0s latency encoding to ns */
 static u32 calc_l0s_latency(u32 encoding)
 {
@@ -354,32 +365,6 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	return 0;
 }
 
-static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
-{
-	u32 threshold_ns = threshold_us * 1000;
-
-	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
-	if (threshold_ns < 32) {
-		*scale = 0;
-		*value = threshold_ns;
-	} else if (threshold_ns < 1024) {
-		*scale = 1;
-		*value = threshold_ns >> 5;
-	} else if (threshold_ns < 32768) {
-		*scale = 2;
-		*value = threshold_ns >> 10;
-	} else if (threshold_ns < 1048576) {
-		*scale = 3;
-		*value = threshold_ns >> 15;
-	} else if (threshold_ns < 33554432) {
-		*scale = 4;
-		*value = threshold_ns >> 20;
-	} else {
-		*scale = 5;
-		*value = threshold_ns >> 25;
-	}
-}
-
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
@@ -539,7 +524,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 * least 4us.
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
-	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	pci_lat_encode(l1_2_threshold * 1000, &scale, &value);
 	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
-- 
2.25.1

