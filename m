Return-Path: <linux-pci+bounces-18134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82B9ECDA5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528051881CFF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45DE1A840C;
	Wed, 11 Dec 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPzGmq6l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30E381AA
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924938; cv=none; b=WQpgJNiJyqSpyIjHJrhuuqx2sIktbrRxZhCXiLohJa5cUlbk2IsjtluibaatFPuebhu1A7DlHJ8kr75hjO4y8MOdZIWmYygGzzRNuuil0R+gqusstMIeHS7DhmTGEzhGyAaOAmW8QkbRUheTJDoJzpv+2mqltSXdKmRrRgKcAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924938; c=relaxed/simple;
	bh=zDs6TjWjw4EtHsbV7QwjLLxhEGSYic/1Nh5K9SUKfyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnUr5gYI0rpOG2pSi4mMFKcx5POlyYlFhCKIr32il+L9C99XtlI30VHr3jAu9eCDnohR0NcwD88OCl3iqczEBvhG9x+22o8+bDiXCQPGSv1oTZHArpZL4rYkgnWsvnERByje+dBoHnNORw7oAEFWCwHRKgL6rDq98FEWrW8zh28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPzGmq6l; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733924937; x=1765460937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDs6TjWjw4EtHsbV7QwjLLxhEGSYic/1Nh5K9SUKfyE=;
  b=gPzGmq6lti63AOk/Qcnim6Szmhu/I+ibnGhUv67Pv87XkcX0eY5LTQOA
   QlPyf2Ija5ilpeFqB8wYjwwwFbnUc13Q2Yu37QNh11ajm5b6W2SmjarZN
   dhJlKQx4/dkF08Dfyo4XDUPZeA6el9LQy3CMVP5dsmP5Q63U2+L7gGagu
   jxJFYRAmFqs6NqiYcnGJ40zO3DTtUwSx4C3f0/OFA4MelLzTylzewisfH
   AJpRqb+x58/3M1THzPJ6kNrywLH0h9EJGhl1nmBZVPrlJXuWLJrO6AJLn
   h8hW5GKMkzEfvEYuBNiVz/PguIcnmCjH7KskBazaJWdzVUpQtqa01fFZN
   A==;
X-CSE-ConnectionGUID: Z8kVX3xcR2SZ+RRMLF+qqQ==
X-CSE-MsgGUID: +xQ4bF34RLiibFaQ1c5w6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37139061"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37139061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:48:56 -0800
X-CSE-ConnectionGUID: rFlGeZd6Qi6vLHC4qVnLSg==
X-CSE-MsgGUID: oo6GxJYORUmytWMhVj8Umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95514123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:48:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] lspci: Add Flit Mode information
Date: Wed, 11 Dec 2024 15:48:39 +0200
Message-Id: <20241211134840.3375-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211134840.3375-1-ilpo.jarvinen@linux.intel.com>
References: <20241211134840.3375-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Flit Mode related information:

- Flit Mode Supported to Express Capabilities line (PCIe r6.1 sec
7.5.3.2).
- Flit Mode Disable to LnkCtl register (PCIe r6.1 sec 7.5.3.7).
- Flit Mode Status to LnkSta2 register (PCIe r6.1 sec 7.5.3.20).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 lib/header.h |  3 +++
 ls-caps.c    | 14 ++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 0827ac0d4b73..b188313ea033 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -763,6 +763,7 @@
 #define  PCI_EXP_TYPE_ROOT_INT_EP 0x9	/* Root Complex Integrated Endpoint */
 #define  PCI_EXP_TYPE_ROOT_EC 0xa	/* Root Complex Event Collector */
 #define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
+#define PCI_EXP_FLAGS_FLIT	0x8000	/* Flit Mode Supported */
 #define PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
 #define PCI_EXP_DEVCAP		0x4	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x07	/* Max_Payload_Size */
@@ -822,6 +823,7 @@
 #define  PCI_EXP_LNKCTL_HWAUTWD	0x0200	/* Hardware Autonomous Width Disable */
 #define  PCI_EXP_LNKCTL_BWMIE	0x0400	/* Bandwidth Mgmt Interrupt Enable */
 #define  PCI_EXP_LNKCTL_AUTBWIE	0x0800	/* Autonomous Bandwidth Mgmt Interrupt Enable */
+#define  PCI_EXP_LNKCTL_FLIT_DIS	0x2000	/* Flit Mode Disable */
 #define PCI_EXP_LNKSTA		0x12	/* Link Status */
 #define  PCI_EXP_LNKSTA_SPEED	0x000f	/* Negotiated Link Speed */
 #define  PCI_EXP_LNKSTA_WIDTH	0x03f0	/* Negotiated Link Width */
@@ -938,6 +940,7 @@
 #define  PCI_EXP_LINKSTA2_RETIMER	0x0040	/* Retimer Detected */
 #define  PCI_EXP_LINKSTA2_2RETIMERS	0x0080	/* 2 Retimers Detected */
 #define  PCI_EXP_LINKSTA2_CROSSLINK(x)	(((x) >> 8) & 0x3) /* Crosslink Res */
+#define  PCI_EXP_LINKSTA2_FLIT		0x0400	/* Flit Mode Status */
 #define  PCI_EXP_LINKSTA2_COMPONENT(x)	(((x) >> 12) & 0x7) /* Presence */
 #define  PCI_EXP_LINKSTA2_DRS_RCVD	0x8000	/* DRS Msg Received */
 #define PCI_EXP_SLTCAP2			0x34	/* Slot Capabilities */
diff --git a/ls-caps.c b/ls-caps.c
index c2aaea573234..38a171a5fe4d 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -843,14 +843,15 @@ static void cap_express_link(struct device *d, int where, int type)
   if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
       (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
     printf(" RCB %d bytes,", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
-  printf(" LnkDisable%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
+  printf(" LnkDisable%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n\t\t\tFlitModeDis%c\n",
 	FLAG(w, PCI_EXP_LNKCTL_DISABLE),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCK),
 	FLAG(w, PCI_EXP_LNKCTL_XSYNCH),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCKPM),
 	FLAG(w, PCI_EXP_LNKCTL_HWAUTWD),
 	FLAG(w, PCI_EXP_LNKCTL_BWMIE),
-	FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));
+	FLAG(w, PCI_EXP_LNKCTL_AUTBWIE),
+	FLAG(w, PCI_EXP_LNKCTL_FLIT_DIS));
 
   w = get_conf_word(d, where + PCI_EXP_LNKSTA);
   sta_speed = w & PCI_EXP_LNKSTA_SPEED;
@@ -1366,7 +1367,7 @@ static void cap_express_link2(struct device *d, int where, int type)
   w = get_conf_word(d, where + PCI_EXP_LNKSTA2);
   printf("\t\tLnkSta2: Current De-emphasis Level: %s, EqualizationComplete%c EqualizationPhase1%c\n"
 	"\t\t\t EqualizationPhase2%c EqualizationPhase3%c LinkEqualizationRequest%c\n"
-	"\t\t\t Retimer%c 2Retimers%c CrosslinkRes: %s",
+	"\t\t\t Retimer%c 2Retimers%c FlitMode%c CrosslinkRes: %s",
 	cap_express_link2_deemphasis(PCI_EXP_LINKSTA2_DEEMPHASIS(w)),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_COMP),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE1),
@@ -1375,11 +1376,11 @@ static void cap_express_link2(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_REQ),
 	FLAG(w, PCI_EXP_LINKSTA2_RETIMER),
 	FLAG(w, PCI_EXP_LINKSTA2_2RETIMERS),
+	FLAG(w, PCI_EXP_LINKSTA2_FLIT),
 	cap_express_link2_crosslink_res(PCI_EXP_LINKSTA2_CROSSLINK(w)));
 
   if (exp_downstream_port(type) && (l & PCI_EXP_LNKCAP2_DRS)) {
-    printf(", DRS%c\n"
-	"\t\t\t DownstreamComp: %s\n",
+    printf("\t\t\t DRS%c DownstreamComp: %s\n",
 	FLAG(w, PCI_EXP_LINKSTA2_DRS_RCVD),
 	cap_express_link2_component(PCI_EXP_LINKSTA2_COMPONENT(w)));
   } else
@@ -1502,7 +1503,8 @@ cap_express(struct device *d, int where, int cap)
     default:
       printf("Unknown type %d", type);
   }
-  printf(", IntMsgNum %d\n", (cap & PCI_EXP_FLAGS_IRQ) >> 9);
+  printf(", IntMsgNum %d, FlitMode%c\n", (cap & PCI_EXP_FLAGS_IRQ) >> 9,
+	 FLAG(cap, PCI_EXP_FLAGS_FLIT));
   if (verbose < 2)
     return type;
 
-- 
2.39.5


