Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61557266CB
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfEVPUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 11:20:55 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:38196 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729583AbfEVPUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 11:20:55 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BC752C00AD;
        Wed, 22 May 2019 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558538462; bh=/tdZAhM4UQ8Qlx+dzUKXx+mvyBD8nbOaqVlAQYpbOzw=;
        h=From:To:Cc:Subject:Date:From;
        b=G2Qn5EU2HFKZ7nI8UkWz3kHJxWRsi+vcLKWzYiYjJn00/V+cvDOBcXaWhj/OZDXM0
         +Zci1D+OTRJ+hQZE73d6SUyiqtoqDvbaQqf1sG8bZaZOXEwSW4exftHioY+llz7PeY
         q/HeFrve3kJbh57o2lkG7PH9su1gi6P70pLRGM8kbm2dX4dNweArA0ZDLE8r2dYuja
         xTdrNeZ8s1U4yjlT7fRAc4b3UI183xy7sa9r26cSaQB6z1RbDZ8Wjt7/ubfqiFzi86
         f2XLolE3NgBdMD26R27vpYloi5hNpT2F3pdJhKFcsHJ7O/1HSYXSBcPwuZ9Z+hAyCf
         LjBEzoN0zzXDA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 13882A0093;
        Wed, 22 May 2019 15:20:54 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 4C1253F246;
        Wed, 22 May 2019 17:20:53 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     mj@ucw.cz, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] lspci: Add PCIe 5.0 data rate (32GT/s) support
Date:   Wed, 22 May 2019 17:20:52 +0200
Message-Id: <0f4a952ee3625ffc64f9797a699479337adab1ae.1558538256.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables "lspci" to show PCIe 5.0 data rate (32GT/s) properly
according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
and PCI_EXP_LNKCTL2.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Cc: Joao Pinto <jpinto@synopsys.com
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
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

