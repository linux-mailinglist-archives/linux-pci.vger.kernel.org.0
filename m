Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05E81DDA5F
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgEUWky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 18:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbgEUWky (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 18:40:54 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E687820756;
        Thu, 21 May 2020 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590100853;
        bh=wXPCs3DQUiiLF4FzwiF9VyVlxdw629OdFXViEzoU7iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EofTlymBFZDjx7IIhuTV/u+Ec931C00uLoNGHh10OY/Pbs+LzQLMgK5iqffwh0tSZ
         P6mCrTYMTVkt4DB8wR0CLja/YIuobfIu1nEcauOykjNFoDuf0rFsMhrMynXmNm+ExO
         xwEArwpOEPHNJroMy2xP6ZI+cpKtGYrisE72m9dQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] lspci: Use commas more consistently
Date:   Thu, 21 May 2020 17:40:30 -0500
Message-Id: <20200521224030.1193617-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521224030.1193617-1-helgaas@kernel.org>
References: <20200521224030.1193617-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

General practice has been to use a comma after a multi-word item, but omit
commas between single-bit flags.  Do this more consistently.

Sample output changes:

  - LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
  + LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+

  - DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR+
  + DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+

  -          10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
  +          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-

  -          FRS-, ARIFwd-
  +          FRS- ARIFwd-

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c  | 24 ++++++++++++------------
 ls-ecaps.c |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index c8a8bd6..a09b0cf 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -822,7 +822,7 @@ static void cap_express_link(struct device *d, int where, int type)
   printf("\t\tLnkCtl:\tASPM %s;", aspm_enabled(w & PCI_EXP_LNKCTL_ASPM));
   if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
       (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
-    printf(" RCB %d bytes", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
+    printf(" RCB %d bytes,", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
   printf(" Disabled%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
 	FLAG(w, PCI_EXP_LNKCTL_DISABLE),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCK),
@@ -1031,14 +1031,14 @@ static const char *cap_express_devcap2_tphcomp(int tph)
   switch (tph)
     {
       case 1:
-        return "TPHComp+, ExtTPHComp-";
+        return "TPHComp+ ExtTPHComp-";
       case 2:
         /* Reserved; intentionally left blank */
         return "";
       case 3:
-        return "TPHComp+, ExtTPHComp+";
+        return "TPHComp+ ExtTPHComp+";
       default:
-        return "TPHComp-, ExtTPHComp-";
+        return "TPHComp- ExtTPHComp-";
     }
 }
 
@@ -1084,12 +1084,12 @@ static void cap_express_dev2(struct device *d, int where, int type)
   int has_mem_bar = device_has_memory_space_bar(d);
 
   l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
-  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c, NROPrPrP%c, LTR%c",
+  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c NROPrPrP%c LTR%c",
         cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
         FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS),
 	FLAG(l, PCI_EXP_DEVCAP2_NROPRPRP),
         FLAG(l, PCI_EXP_DEVCAP2_LTR));
-  printf("\n\t\t\t 10BitTagComp%c, 10BitTagReq%c, OBFF %s, ExtFmt%c, EETLPPrefix%c",
+  printf("\n\t\t\t 10BitTagComp%c 10BitTagReq%c OBFF %s, ExtFmt%c EETLPPrefix%c",
         FLAG(l, PCI_EXP_DEVCAP2_10BIT_TAG_COMP),
         FLAG(l, PCI_EXP_DEVCAP2_10BIT_TAG_REQ),
         cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)),
@@ -1108,14 +1108,14 @@ static void cap_express_dev2(struct device *d, int where, int type)
   printf("\n\t\t\t FRS%c", FLAG(l, PCI_EXP_DEVCAP2_FRS));
 
   if (type == PCI_EXP_TYPE_ROOT_PORT)
-    printf(", LN System CLS %s",
+    printf(" LN System CLS %s,",
           cap_express_devcap2_lncls(PCI_EXP_DEVCAP2_LN_CLS(l)));
 
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT)
-    printf(", %s", cap_express_devcap2_tphcomp(PCI_EXP_DEVCAP2_TPH_COMP(l)));
+    printf(" %s", cap_express_devcap2_tphcomp(PCI_EXP_DEVCAP2_TPH_COMP(l)));
 
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(", ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
+    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
   else
     printf("\n");
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
@@ -1134,7 +1134,7 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
-  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
+  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
 	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
 	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
 	FLAG(w, PCI_EXP_DEV2_LTR),
@@ -1303,8 +1303,8 @@ static void cap_express_link2(struct device *d, int where, int type)
   }
 
   w = get_conf_word(d, where + PCI_EXP_LNKSTA2);
-  printf("\t\tLnkSta2: Current De-emphasis Level: %s, EqualizationComplete%c, EqualizationPhase1%c\n"
-	"\t\t\t EqualizationPhase2%c, EqualizationPhase3%c, LinkEqualizationRequest%c\n"
+  printf("\t\tLnkSta2: Current De-emphasis Level: %s, EqualizationComplete%c EqualizationPhase1%c\n"
+	"\t\t\t EqualizationPhase2%c EqualizationPhase3%c LinkEqualizationRequest%c\n"
 	"\t\t\t Retimer%c 2Retimers%c CrosslinkRes: %s",
 	cap_express_link2_deemphasis(PCI_EXP_LINKSTA2_DEEMPHASIS(w)),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_COMP),
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 0021734..49b6ec9 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -89,7 +89,7 @@ cap_sec(struct device *d, int where)
     return;
 
   ctrl3 = get_conf_word(d, where + PCI_SEC_LNKCTL3);
-  printf("\t\tLnkCtl3: LnkEquIntrruptEn%c, PerformEqu%c\n",
+  printf("\t\tLnkCtl3: LnkEquIntrruptEn%c PerformEqu%c\n",
 	FLAG(ctrl3, PCI_SEC_LNKCTL3_LNK_EQU_REQ_INTR_EN),
 	FLAG(ctrl3, PCI_SEC_LNKCTL3_PERFORM_LINK_EQU));
 
-- 
2.25.1

