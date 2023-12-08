Return-Path: <linux-pci+bounces-657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823B809F3E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F0A28167E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377A125CE;
	Fri,  8 Dec 2023 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="LrY2qu+K";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ULQtqslq"
X-Original-To: linux-pci@vger.kernel.org
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 01:26:45 PST
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758E171C
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A6E09C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027155; bh=G+eLzLYQvX1MyD56fctAQ6GgHhdCBoIEONmqJ6/bA6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LrY2qu+KFT/QHkfyUeCfajG6APLGPXtp1CXSxZL7VnnfPB1sXsARcH5Se7BgnRzXe
	 TwKY84/ArqWrjSZBl7WGTNV3fKz1okXI4NYwJ+W0V7bMN+/9T2Nfn8byHZiOD3WwLa
	 ui7u7vGki8JnxXWA0f9F6vxvjJdDm7LX2PVVDw1YYTBF5COfbfTaelqxVS0mLA79wd
	 ta40NDtctfnTR5dpc7uMwWr6YqtVojzA3Kjag3kGUDYGOQcxhWeLCQ6SeYb4ALNx54
	 qaPufSEpx1241iv9RstCXSTjsMShFhyY5E5yaHR2g9mQWcKRam7DoO+u5Wf7cJL+O5
	 JTGDRbyYDOfxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027155; bh=G+eLzLYQvX1MyD56fctAQ6GgHhdCBoIEONmqJ6/bA6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ULQtqslqeI2FcmWQL8R6mmHWz1P75Nsh70OA4GJ5cyZSgQk428gLkEboi6+ToB6oQ
	 3ZRvn9oG8qN/xds3CfzBjN0vZIBI4qY0O8wNY6ooPT0wlN078yujsMGFdRf8iuCNU2
	 d+kli/vJkGEye72Y75qLQppl8+btBJu0R7aMQqrO3mkatA4RjffMQ8LM2X5WD7t10b
	 +mxZ9UNZQ0kZxGdC8iWbkXX5EnE5Auk+I69A6ZJTBw0jJTa2WOEiFoxpen8KDBS5+u
	 PcqkBz5V1B+sc5amk6eWfiLV14aIZd1lBHVXFgRByGEjl6S5vaiATGfzP7pkv9JGvc
	 2FeLfZK3rc9dg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 12/15] pciutils-pcilmr: Add --scan mode to search for all LMR-capable Links
Date: Fri, 8 Dec 2023 12:17:31 +0300
Message-ID: <20231208091734.12225-13-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 pcilmr.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/pcilmr.c b/pcilmr.c
index ed37a05..46b9f24 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -9,19 +9,22 @@
 
 enum mode {
   MARGIN,
-  FULL
+  FULL,
+  SCAN
 };
 
 static void usage(void)
 {
   printf("Usage:\n"
          "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
-         "pcilmr --full [<margining options>]\n\n"
+         "pcilmr --full [<margining options>]\n"
+         "pcilmr --scan\n\n"
          "Device Specifier:\n"
          "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
          "Modes:\n"
          "--margin\t\tMargin selected Links\n"
          "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
+         "--scan\t\t\tScan for Links available for margining\n\n"
          "Margining options:\n\n"
          "Margining Test settings:\n"
          "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
@@ -106,7 +109,38 @@ static uint8_t parse_csv_arg(char *arg, uint8_t *lanes)
   return cnt;
 }
 
-static uint8_t find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, 
+static void scan_links(struct pci_access *pacc, bool only_ready)
+{
+  if (only_ready)
+    printf("Links ready for margining:\n");
+  else
+    printf("Links with Lane Margining at the Receiver capabilities:\n");
+  bool flag = true;
+  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+  {
+    if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+    {
+      struct pci_dev *down = find_down_port_for_up(pacc, up);
+
+      if (down && margin_verify_link(down, up))
+      {
+        margin_log_bdfs(down, up);
+        if (!only_ready && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
+        {
+          printf(" - Ready");
+        }
+        printf("\n");
+        flag = false;
+      }
+    }
+  }
+  if (flag)
+    printf("Links not found or you don't have enough privileges.\n");
+  pci_cleanup(pacc);
+  exit(0);
+}
+
+static uint8_t find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports,
                                 struct pci_dev **up_ports, bool cnt_only)
 {
   uint8_t cnt = 0;
@@ -184,7 +218,8 @@ int main(int argc, char **argv)
 
   struct option long_options[] = {
       {.name = "margin", .has_arg = no_argument, .flag = NULL, .val = 0},
-      {.name = "full", .has_arg = no_argument, .flag = NULL, .val = 1},
+      {.name = "scan", .has_arg = no_argument, .flag = NULL, .val = 1},
+      {.name = "full", .has_arg = no_argument, .flag = NULL, .val = 2},
       {0, 0, 0, 0}};
 
   int c;
@@ -198,6 +233,12 @@ int main(int argc, char **argv)
     mode = MARGIN;
     break;
   case 1:
+    mode = SCAN;
+    if (optind == argc)
+      scan_links(pacc, false);
+    optind--;
+    break;
+  case 2:
     mode = FULL;
     break;
   default: /*unknown option symbol*/
@@ -378,7 +419,7 @@ int main(int argc, char **argv)
         for (uint8_t j = 0; j < args[i].recvs_n; j++)
         {
           if (margin_read_params_standalone(pacc,
-                                            args[i].recvs[j] == 6 ? up_ports[i] : down_ports[i], 
+                                            args[i].recvs[j] == 6 ? up_ports[i] : down_ports[i],
                                             args[i].recvs[j], &caps))
           {
             uint8_t steps_t = steps_t_arg == -1 ? caps.timing_steps : steps_t_arg;
-- 
2.34.1


