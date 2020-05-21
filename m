Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A41DD5A7
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEUSG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 14:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUSG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:06:58 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 467D5207D3;
        Thu, 21 May 2020 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084418;
        bh=AnBGg+FrOPMBJkV9ekbF/F9tEQhhzRnJmbCqlgaEerA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2sp1qzuCNRZfpbBkYKevGN6oNNrNcs854yK/ulHovo6QAu3v+/61i+n912SxRAi0
         ZWbhEJMScpLX/vAGlURI177vaGMbnwpixIMAORqdUWtn1WRGMcayAtyiYbn4fRh1Yy
         nlGnoTRAVALQqR362CVTI1IpcRuB7zTlpxeczku4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/6] misc: rtsx: Simplify rtsx_comm_set_aspm()
Date:   Thu, 21 May 2020 13:05:44 -0500
Message-Id: <20200521180545.1159896-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521180545.1159896-1-helgaas@kernel.org>
References: <20200521180545.1159896-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify rtsx_comm_set_aspm() and remove the now-unused
rtsx_pci_enable_aspm().

rtsx_pci_disable_aspm() is still used by rtsx_pci_init_hw().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a8ce9c3744be..aea4b5d85e9c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -55,12 +55,6 @@ static const struct pci_device_id rtsx_pci_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, rtsx_pci_ids);
 
-static inline void rtsx_pci_enable_aspm(struct rtsx_pcr *pcr)
-{
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
-}
-
 static inline void rtsx_pci_disable_aspm(struct rtsx_pcr *pcr)
 {
 	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
@@ -93,10 +87,9 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (enable)
-		rtsx_pci_enable_aspm(pcr);
-	else
-		rtsx_pci_disable_aspm(pcr);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   enable ? pcr->aspm_en : 0);
 
 	pcr->aspm_enabled = enable;
 }
-- 
2.25.1

