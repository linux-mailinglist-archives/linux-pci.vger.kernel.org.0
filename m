Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB541744A4
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 04:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB2DHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 22:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2DHZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 22:07:25 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E041246B0;
        Sat, 29 Feb 2020 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582945644;
        bh=ht+AF5qf3Uyvn/yEkYtoveV/7ql/B7B8EolV0HqnPHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3Qc6SAbzBmAN4Z1IqJCkZTxIuD3zMkItxcfOB7zmC0o2CDmGHtETZBsNTZlbx3e1
         jG1EoGpBkiF6SSxygFOCJr/7HhPcyJF+IdWldVkOmpBLvVDwSVB40lttsEC3V3sinC
         xmFb1woFlDbJbHJasBerlqzFiLNx0lw5QxODUNFs=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 1/4] PCI: Add 32 GT/s decoding in some macros
Date:   Fri, 28 Feb 2020 21:07:03 -0600
Message-Id: <20200229030706.17835-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200229030706.17835-1-helgaas@kernel.org>
References: <20200229030706.17835-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Link speed 32.0 GT/s is supported in PCIe r5.0. Add this speed to
PCIE_SPEED2STR() and PCIE_SPEED2MBS_ENC() to correctly decode it.

This is complementary to de76cda215d5 ("PCI: Decode PCIe 32 GT/s link
speed").

Link: https://lore.kernel.org/r/1581937984-40353-2-git-send-email-yangyicong@hisilicon.com
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e7746fb5..f65912e0f30d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -294,7 +294,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
+	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
+	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
 	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
 	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
 	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
@@ -302,7 +303,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
+	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
+	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
 	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
-- 
2.25.0.265.gbab2e86ba0-goog

