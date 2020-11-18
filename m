Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA12B87F7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgKRW4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 17:56:40 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40216 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbgKRW4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:56:39 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD79FC00BF;
        Wed, 18 Nov 2020 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605740216; bh=zyE2JAoijmyCe1wMpCarInEbJk5DUejPfzYqcywkKpg=;
        h=From:To:Cc:Subject:Date:From;
        b=IXn94Dhvx81tE51DFonaFZsgdVJIFaBMyd3+oHTprj18AdBtbmQK+UyZXIe8SKTna
         o5JE52TNVa9iFWMwaLWyv/i61di0AkQ70D0H3vv/Yx1xstcPuONBwilaDJFeTbbwza
         0gxZ2GjQlFf/TO1WemnVSx+0xLrP6sUerYR2m6J/w6isGML1qWxBb5QE/fRkzeRXDR
         xuJuu5wXq5Wd5JjDTQawO3RkaqQJ0ADMPj6k1NvXxRWfI2o4LyrrOzDwLYx8Z5Awyz
         wlxYvOtlnQW9ORV0sRfh75jxjqLMW1nBwiQBy46W8bOiuaT4vkj8db3ONLwrm0lqNH
         EMBYq/YKi9Jwg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5AFAEA005D;
        Wed, 18 Nov 2020 22:56:54 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH] lspci: Add PCIe 6.0 data rate (64 GT/s) support
Date:   Wed, 18 Nov 2020 23:56:52 +0100
Message-Id: <ad286025549e42030bc75ef9f99af9c92071a205.1605740212.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables "lspci" to show PCIe 6.0 data rate (64 GT/s) properly
according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
and PCI_EXP_LNKCTL2.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 ls-caps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index a09b0cf..c4d27d5 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -751,6 +751,8 @@ static char *link_speed(int speed)
         return "16GT/s";
       case 5:
         return "32GT/s";
+      case 6:
+        return "64GT/s";
       default:
 	return "unknown";
     }
@@ -1196,6 +1198,8 @@ static const char *cap_express_link2_speed(int type)
         return "16GT/s";
       case 5:
         return "32GT/s";
+      case 6:
+        return "64GT/s";
       default:
 	return "Unknown";
     }
-- 
2.7.4

