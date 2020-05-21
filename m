Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA51DD59E
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEUSG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 14:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgEUSG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:06:26 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E308720738;
        Thu, 21 May 2020 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084386;
        bh=UgTXW2cgj45DGwBaa7hLXyLjKuKJP5ELoSk0BJviyXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I14syJWz/xcE92gFzNEH/nL+YAwZaCvpw+z87oWDyCvWamhgcdPhu0bpe+nnrJNdP
         /V/XC9NpyRiQxMj7skPlCMNg70pRdTC+sCADsMA0p6GxJP7NNEWrKeo1Uc2t7Fjp4R
         8E0CLrwWsHDNiMcHlsyU7P2sdZKg2j8W2HMBVgI4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/6] misc: rtsx: Use ASPM_MASK_NEG instead of hard-coded value
Date:   Thu, 21 May 2020 13:05:42 -0500
Message-Id: <20200521180545.1159896-4-helgaas@kernel.org>
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

Use ASPM_MASK_NEG instead of hard-coded value, as other callers of
rtsx_pci_update_cfg_byte() do.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index ce3919e59719..afde5499bfb6 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -58,13 +58,13 @@ MODULE_DEVICE_TABLE(pci, rtsx_pci_ids);
 static inline void rtsx_pci_enable_aspm(struct rtsx_pcr *pcr)
 {
 	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-		0xFC, pcr->aspm_en);
+		ASPM_MASK_NEG, pcr->aspm_en);
 }
 
 static inline void rtsx_pci_disable_aspm(struct rtsx_pcr *pcr)
 {
 	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-		0xFC, 0);
+		ASPM_MASK_NEG, 0);
 }
 
 static int rtsx_comm_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
-- 
2.25.1

