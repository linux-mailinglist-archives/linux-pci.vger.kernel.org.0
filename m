Return-Path: <linux-pci+bounces-1427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89AB81EDE4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E64F1F216F6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958D2C6AA;
	Wed, 27 Dec 2023 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="NwiDeCDI";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Uzpn3vrU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D7288B6
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com AE0F7C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670379; bh=d7HCpL3hF76xZ1LCs3g4aQfkoFICVTAarCn9H2xnV7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NwiDeCDId1jSv0+EN06nBhgalfI5H10CenpZmBFHI1i4DBQzvyq4PivrVo2om7LsU
	 hh0tV2cDOWilotBCKp96GN1zwcXujpoz+YuGTTXvgdH2MrikWLz5X0larmfG2gsm27
	 oxkThqS4VMSFXzsO4x9We5rNM1lrwr63Xjl76B1Y+vl7v77EMLDQnxgWfdIDnNSJ07
	 1RX/qUm6Sjl4OzGhPly4b90uEi0Ma3o2M1Klnqhvv+0depNkDNR4sBtpWnNxWgmIZK
	 ct2WXpPGt6NWhPsjw9e8lrv7kGbRrR7Yg2lnS6HKhpYuv1cZAW3dM3MhMxk3+gulTb
	 inkb4Lz9DcEhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670379; bh=d7HCpL3hF76xZ1LCs3g4aQfkoFICVTAarCn9H2xnV7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Uzpn3vrUEGJhZsgIHHGDb0JjTPhnT4s6wLNuH/Bc+/HmSDZiFBintACc5IcFRNxJT
	 M2e645S9BdMCuImVkgCtaT2zopOP5soGazCUprzMtyRb273spwzrYjNNunBrzTTpVm
	 0mutnWkDK8Mxq3LdQW2lwuSoKyx07MQyCiHl683exZsLmA7s6yrhRUIeMnw1knC73L
	 LgvkskDYj32VFLwz1OzX79fwIXosD6AZirKn9q4JT6lEgS1WyU4HlyIdsrKWi/zr09
	 hHRaKflLeqVI8LZdv55jywkGNcwpOBjYw7X4swFGgcOsyeQg/QaLbsJhyiT2mPDWJ6
	 d4MZEzetU5uZg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 12/15] pciutils-pcilmr: Add --scan mode to search for all LMR-capable Links
Date: Wed, 27 Dec 2023 14:45:01 +0500
Message-ID: <20231227094504.32257-13-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 pcilmr.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/pcilmr.c b/pcilmr.c
index 3c2f250..43e791d 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -17,17 +17,19 @@
 
 const char program_name[] = "pcilmr";
 
-enum mode { MARGIN, FULL };
+enum mode { MARGIN, FULL, SCAN };
 
 static const char usage_msg[]
   = "Usage:\n"
     "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
     "pcilmr --full [<margining options>]\n"
+    "pcilmr --scan\n\n"
     "Device Specifier:\n"
     "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
     "Modes:\n"
     "--margin\t\tMargin selected Links\n"
     "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
+    "--scan\t\t\tScan for Links available for margining\n\n"
     "Margining options:\n\n"
     "Margining Test settings:\n"
     "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
@@ -106,6 +108,36 @@ parse_csv_arg(char *arg, u8 *vals)
   return cnt;
 }
 
+static void
+scan_links(struct pci_access *pacc, bool only_ready)
+{
+  if (only_ready)
+    printf("Links ready for margining:\n");
+  else
+    printf("Links with Lane Margining at the Receiver capabilities:\n");
+  bool flag = true;
+  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+    {
+      if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+        {
+          struct pci_dev *down = find_down_port_for_up(pacc, up);
+
+          if (down && margin_verify_link(down, up))
+            {
+              margin_log_bdfs(down, up);
+              if (!only_ready && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
+                printf(" - Ready");
+              printf("\n");
+              flag = false;
+            }
+        }
+    }
+  if (flag)
+    printf("Links not found or you don't have enough privileges.\n");
+  pci_cleanup(pacc);
+  exit(0);
+}
+
 static u8
 find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, struct pci_dev **up_ports,
                  bool cnt_only)
@@ -185,7 +217,8 @@ main(int argc, char **argv)
 
   struct option long_options[]
     = { { .name = "margin", .has_arg = no_argument, .flag = NULL, .val = 0 },
-        { .name = "full", .has_arg = no_argument, .flag = NULL, .val = 1 },
+        { .name = "scan", .has_arg = no_argument, .flag = NULL, .val = 1 },
+        { .name = "full", .has_arg = no_argument, .flag = NULL, .val = 2 },
         { 0, 0, 0, 0 } };
 
   int c;
@@ -199,6 +232,12 @@ main(int argc, char **argv)
         mode = MARGIN;
         break;
       case 1:
+        mode = SCAN;
+        if (optind == argc)
+          scan_links(pacc, false);
+        optind--;
+        break;
+      case 2:
         mode = FULL;
         break;
       default: /* unknown option symbol */
-- 
2.34.1


