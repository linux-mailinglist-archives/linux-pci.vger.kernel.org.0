Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1436834D2C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfFDQYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 12:24:50 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:60084 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbfFDQYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 12:24:50 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB019C2133;
        Tue,  4 Jun 2019 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559665500; bh=czCMv4VDHjb9NxzJ/Sl1krDNAgnoR08uZa33ipOrNaY=;
        h=From:To:Cc:Subject:Date:From;
        b=gt8bb6LqTv1Ehqop+cwayEyWYzix3mZcRgmn4noPcaa+b7AehHvj8EQomrbMQVO/M
         vl+CLpgNTq4+t7OOj7kbBvpc/0U4wUtvhOnUtpkb1A2Wvrh+izeOcMn1ZDMfiUTp5L
         RugiCN4/JOzwARxzs+2q2Z6+iz748Y1963tvxzSSZ/IOmScdkCuORzNoe43SIag0Lt
         51cD0MJJyDSQQThaQ9VM5RJ8+sn5/uftJMIvQH9OvZmn9ZFTpCusVeF1vFML6EoiYf
         DdT5/PGozmyCvNjXtugfPPbAQ8rMLKl+SxWDClawG7tP12lkUISCP6Sj2D9J/sd0Fs
         SvbKTTn+MSbRA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 19719A022F;
        Tue,  4 Jun 2019 16:24:48 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 07D113D06B;
        Tue,  4 Jun 2019 18:24:48 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2] lspci: Add PCIe 5.0 data rate (32 GT/s) support
Date:   Tue,  4 Jun 2019 18:24:46 +0200
Message-Id: <ed2a31df07262f5776c92c538da3079bb22aa9bf.1559665071.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables "lspci" to show PCIe 5.0 data rate (32 GT/s) properly
according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
and PCI_EXP_LNKCTL2.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes:
v1 -> v2
 - Rebase patch

ls-caps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index 88964ce..8a00aa4 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -742,6 +742,8 @@ static char *link_speed(int speed)
 	return "8GT/s";
       case 4:
         return "16GT/s";
+      case 5:
+        return "32GT/s";
       default:
 	return "unknown";
     }
@@ -1160,6 +1162,8 @@ static const char *cap_express_link2_speed(int type)
 	return "8GT/s";
       case 4:
         return "16GT/s";
+      case 5:
+        return "32GT/s";
       default:
 	return "Unknown";
     }
-- 
2.7.4

