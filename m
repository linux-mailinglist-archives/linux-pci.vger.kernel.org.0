Return-Path: <linux-pci+bounces-7756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1248CC4BD
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6004F1C21851
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F78757F5;
	Wed, 22 May 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="GEEPRggY";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="HRsuarvn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CA3716D
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394478; cv=none; b=NlYOiABjFGEyLRkcpoKtIwz2FNu6Zjt/KCSKrpxDC6HNeyYhA2ozWRfaECG6xu/DRS208yKEewWnY4DxKwzGdpwcmf8/FF7OPAPVbFbV6x7rqydrlmCKt/p/XAQhKkEeeH0cjW3yFB29ClWstWvEQKQlMsry76XD6lLv1jkd1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394478; c=relaxed/simple;
	bh=WArgKRqIZJHfBQWJC/Txb5NijV0EbdIZY4dLVULGMWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laTDjpJmQRqx0MrWWM7Jouh4Sf0R5Xx/6EdhIhveJgtiCNjEO6DXXQj7cVV1umond614o2YJaHwKX7kchRD6JEIsW1dC42JT+AUnQF8igF/TkzU9iJevRLyIXX1sPogfET0m6+PdvJYkLV+l76Topr7PLtJ+SOiUlRYjk82pUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=GEEPRggY; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=HRsuarvn; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D5401C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394046; bh=6LnXonmUDYG/FVfq6GHJUUzs67aSqZMtmH3nQ3nxI0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GEEPRggYgPprUjCUDxnc3+0wcnXPLO8HzTrbm+/++Zwh+sVCixcPsO9R15pk91+PW
	 c09r1K1+eHWlOzNZ9p5X1ycwxp2IOneBd4GLxww/VM9DC3BFBn8jukMhDZBuZGgB/O
	 qx70pXTHLrYgsbSZa0xXwp2TlHEvXNkdhLKlZ0LQFb65fzaqNWRZ9giLcN+f+VWHTM
	 8kWmwO4QnzOZlxgRm1BC3YM36PSzS9Wg/jNmpsuo1SXLeG9R4kpznnUr2INK9g/uto
	 d+4I/TM4QGePGtL3NVr8QFWbdPjd9/7cxbp5Nx73z6NshKb2i0rG9mA5OC3ti5cjiO
	 3NvXoP/AdR0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394046; bh=6LnXonmUDYG/FVfq6GHJUUzs67aSqZMtmH3nQ3nxI0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HRsuarvnYlrqxI6Uw9Z934Nt1hqZSAG30ZPMDz/E89HEoMnmbF7TdOfRBdtTX74DQ
	 ss9+PXzQT8k7KPqMNHo1MrHEQmHBUtZ12P6BZS9o80iTi7UUnnaNOcWT3Oe+vk2X1Q
	 gKg3l71AiR46ujOULc0YEqCQHV9dbXPyjkQtjYD3Bk0MrHFpS+0XYGpOpXxiEtmDv+
	 t52kzm6N23FZPYjkAuajJZxdVcSLLlL11geXElpF4Y7jJp0lQiWowDlORDzEf0R6eX
	 6QacvKQHA9fQh8ghYkA8nfwXCAIhnXHtHAAD92F8bxRLkUog0XRWinChLxhoGg3dzE
	 TkEg5umd8BBhg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 1/6] pcilmr: Ensure that utility can accept either Downstream or Upstream link port
Date: Wed, 22 May 2024 19:06:29 +0300
Message-ID: <20240522160634.29831-2-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522160634.29831-1-n.proshkin@yadro.com>
References: <20240522160634.29831-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Previously, the utility expected only the Upstream Port to be input and,
in fact, passing the Downstream Port led to strange and buggy error
messages. Improve arguments parsing logic to accept any side of the link.

It seems that the only use case that will not be available now is margining
the internal links of the switch, but this scenario looks as strange as
possible.

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h       | 14 +++++++++----
 lmr/margin.c    | 27 ++-----------------------
 lmr/margin_hw.c | 54 ++++++++++++++++++++++++++++++++++++++++++-------
 pcilmr.c        | 40 +++++++++++++-----------------------
 4 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index 7375c33..6cac3d4 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Margining utility main header
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -95,7 +95,7 @@ enum margin_test_status {
 
 /* All lanes Receiver results */
 struct margin_results {
-  u8 recvn; // Receiver Number
+  u8 recvn; // Receiver Number; from 1 to 6
   struct margin_params params;
   bool lane_reversal;
   u8 link_speed;
@@ -104,7 +104,7 @@ struct margin_results {
 
   /* Used to convert steps to physical quantity.
      Calculated from MaxOffset and NumSteps     */
-  double tim_coef;
+  double tim_coef; // from steps to % UI
   double volt_coef;
 
   bool tim_off_reported;
@@ -134,7 +134,7 @@ struct margin_args {
 /* Receiver structure */
 struct margin_recv {
   struct margin_dev *dev;
-  u8 recvn; // Receiver Number
+  u8 recvn; // Receiver Number; from 1 to 6
   bool lane_reversal;
   struct margin_params *params;
 
@@ -161,6 +161,12 @@ struct margin_lanes_data {
 
 /* margin_hw */
 
+bool margin_port_is_down(struct pci_dev *dev);
+
+/* Results through down/up ports */
+bool margin_find_pair(struct pci_access *pacc, struct pci_dev *dev, struct pci_dev **down_port,
+                      struct pci_dev **up_port);
+
 /* Verify that devices form the link with 16 GT/s or 32 GT/s data rate */
 bool margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port);
 
diff --git a/lmr/margin.c b/lmr/margin.c
index a8c6571..e3758df 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -426,13 +426,8 @@ margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
   struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
   if (!cap)
     return false;
-  u8 dev_dir = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE);
 
-  bool dev_down;
-  if (dev_dir == PCI_EXP_TYPE_ROOT_PORT || dev_dir == PCI_EXP_TYPE_DOWNSTREAM)
-    dev_down = true;
-  else
-    dev_down = false;
+  bool dev_down = margin_port_is_down(dev);
 
   if (recvn == 0)
     {
@@ -453,25 +448,7 @@ margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
   struct pci_dev *up = NULL;
   struct margin_link link;
 
-  for (struct pci_dev *p = pacc->devices; p; p = p->next)
-    {
-      if (dev_down && pci_read_byte(dev, PCI_SECONDARY_BUS) == p->bus && dev->domain == p->domain
-          && p->func == 0)
-        {
-          down = dev;
-          up = p;
-          break;
-        }
-      else if (!dev_down && pci_read_byte(p, PCI_SECONDARY_BUS) == dev->bus
-               && dev->domain == p->domain)
-        {
-          down = p;
-          up = dev;
-          break;
-        }
-    }
-
-  if (!down)
+  if (!margin_find_pair(pacc, dev, &down, &up))
     return false;
 
   if (!margin_fill_link(down, up, &link))
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
index fc427c8..43fa1bd 100644
--- a/lmr/margin_hw.c
+++ b/lmr/margin_hw.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Verify and prepare devices before margining
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -31,6 +31,51 @@ detect_unique_hw(struct pci_dev *dev)
   return MARGIN_HW_DEFAULT;
 }
 
+bool
+margin_port_is_down(struct pci_dev *dev)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!cap)
+    return false;
+  u8 type = pci_read_byte(dev, PCI_HEADER_TYPE) & 0x7F;
+  u8 dir = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE);
+
+  if (type == PCI_HEADER_TYPE_BRIDGE
+      && (dir == PCI_EXP_TYPE_ROOT_PORT || dir == PCI_EXP_TYPE_DOWNSTREAM))
+    return true;
+  else
+    return false;
+}
+
+bool
+margin_find_pair(struct pci_access *pacc, struct pci_dev *dev, struct pci_dev **down_port,
+                 struct pci_dev **up_port)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!cap)
+    return false;
+  bool given_down = margin_port_is_down(dev);
+
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+    {
+      if (given_down && pci_read_byte(dev, PCI_SECONDARY_BUS) == p->bus && dev->domain == p->domain
+          && p->func == 0)
+        {
+          *down_port = dev;
+          *up_port = p;
+          return true;
+        }
+      else if (!given_down && pci_read_byte(p, PCI_SECONDARY_BUS) == dev->bus
+               && dev->domain == p->domain)
+        {
+          *down_port = p;
+          *up_port = dev;
+          return true;
+        }
+    }
+  return false;
+}
+
 bool
 margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
 {
@@ -42,16 +87,11 @@ margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
   if ((pci_read_word(down_port, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) > 5)
     return false;
 
-  u8 down_type = pci_read_byte(down_port, PCI_HEADER_TYPE) & 0x7F;
   u8 down_sec = pci_read_byte(down_port, PCI_SECONDARY_BUS);
-  u8 down_dir
-    = GET_REG_MASK(pci_read_word(down_port, cap->addr + PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE);
 
   // Verify that devices are linked, down_port is Root Port or Downstream Port of Switch,
   // up_port is Function 0 of a Device
-  if (!(down_sec == up_port->bus && down_type == PCI_HEADER_TYPE_BRIDGE
-        && (down_dir == PCI_EXP_TYPE_ROOT_PORT || down_dir == PCI_EXP_TYPE_DOWNSTREAM)
-        && up_port->func == 0))
+  if (!(down_sec == up_port->bus && margin_port_is_down(down_port) && up_port->func == 0))
     return false;
 
   struct pci_cap *pm = pci_find_cap(up_port, PCI_CAP_ID_PM, PCI_CAP_NORMAL);
diff --git a/pcilmr.c b/pcilmr.c
index cb8bd77..345ce7a 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Margining utility main function
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -83,21 +83,6 @@ dev_for_filter(struct pci_access *pacc, char *filter)
   die("No such PCI device: %s or you don't have enough privileges.\n", filter);
 }
 
-static struct pci_dev *
-find_down_port_for_up(struct pci_access *pacc, struct pci_dev *up)
-{
-  struct pci_dev *down = NULL;
-  for (struct pci_dev *p = pacc->devices; p; p = p->next)
-    {
-      if (pci_read_byte(p, PCI_SECONDARY_BUS) == up->bus && up->domain == p->domain)
-        {
-          down = p;
-          break;
-        }
-    }
-  return down;
-}
-
 static u8
 parse_csv_arg(char *arg, u8 *vals)
 {
@@ -120,11 +105,13 @@ scan_links(struct pci_access *pacc, bool only_ready)
   else
     printf("Links with Lane Margining at the Receiver capabilities:\n");
   bool flag = true;
-  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
     {
-      if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+      if (pci_find_cap(p, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED) && margin_port_is_down(p))
         {
-          struct pci_dev *down = find_down_port_for_up(pacc, up);
+          struct pci_dev *down = NULL;
+          struct pci_dev *up = NULL;
+          margin_find_pair(pacc, p, &down, &up);
 
           if (down && margin_verify_link(down, up))
             {
@@ -147,11 +134,13 @@ find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, struct pc
                  bool cnt_only)
 {
   u8 cnt = 0;
-  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
     {
-      if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+      if (pci_find_cap(p, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED) && margin_port_is_down(p))
         {
-          struct pci_dev *down = find_down_port_for_up(pacc, up);
+          struct pci_dev *down = NULL;
+          struct pci_dev *up = NULL;
+          margin_find_pair(pacc, p, &down, &up);
 
           if (down && margin_verify_link(down, up)
               && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
@@ -328,10 +317,9 @@ main(int argc, char **argv)
       u8 cnt = 0;
       while (optind != argc)
         {
-          up_ports[cnt] = dev_for_filter(pacc, argv[optind]);
-          down_ports[cnt] = find_down_port_for_up(pacc, up_ports[cnt]);
-          if (!down_ports[cnt])
-            die("Cannot find Upstream Component for the specified device: %s\n", argv[optind]);
+          struct pci_dev *dev = dev_for_filter(pacc, argv[optind]);
+          if (!margin_find_pair(pacc, dev, &(down_ports[cnt]), &(up_ports[cnt])))
+            die("Cannot find pair for the specified device: %s\n", argv[optind]);
           cnt++;
           optind++;
         }
-- 
2.34.1


