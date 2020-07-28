Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30E23127F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 21:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgG1TYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 15:24:41 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37916 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgG1TYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 15:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kVGNoG+MJI4rM6HTew7uFrFowsLOmfKHPl5e6Ri5JTE=; b=myYva4PKGKUvQk6qKd+dUMnhSE
        PmvXmKB2MXRTY0tN/vTtWsj8wpKCufXXCwCSg6aNU6aczeav8e479QtFx4ZgdYUHomcRY1YmquHe9
        2m2AG2EmdaZNZGI/LnEE/SucBtATmGadyTEnexTpl9JyZ+vqPTlmSZtr3C/dSJZ/X8JwKepEcCyRF
        YSJpBGzALtYDxH8agA28KBX44vzL+3QnJ2e4BGgtp69jb6WtptK/WPkPz2xQQHPZ5phe5h4t88h8e
        Xnw3s/mKympr3iNkqf/iu0DmXwWIPUsT33kA1JLXFH8yJMCBVHyx2dCppPwfYumDlvrfijLFnT2ox
        8Xs2DTdQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0VDK-00017E-K5; Tue, 28 Jul 2020 13:24:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0VDI-0004x7-UV; Tue, 28 Jul 2020 13:24:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 28 Jul 2020 13:24:34 -0600
Message-Id: <20200728192434.18993-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728192434.18993-1-logang@deltatee.com>
References: <20200728192434.18993-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 2/2] PCI/switechtec: Add missing __iomem tag to fix sparse warnings
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a missing __iomem tag in the init_pfn() function. This fixes a
sparse warning of the form:

   sparse: sparse: incorrect type assignment(different address spaces)

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 3d5da7f44378..ba52459928f7 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1484,7 +1484,7 @@ static void init_pff(struct switchtec_dev *stdev)
 {
 	int i;
 	u32 reg;
-	struct part_cfg_regs *pcfg = stdev->mmio_part_cfg;
+	struct part_cfg_regs __iomem *pcfg = stdev->mmio_part_cfg;
 
 	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
 		reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
-- 
2.20.1

