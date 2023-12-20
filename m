Return-Path: <linux-pci+bounces-1206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D837681982C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680C3B23619
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92FFC06;
	Wed, 20 Dec 2023 05:32:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35871118C;
	Wed, 20 Dec 2023 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="144011468"
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="144011468"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:32:29 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 90510D9DA8;
	Wed, 20 Dec 2023 14:32:26 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E0A6CD296A;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.237.107])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id C9F562005994;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com,
	KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH 2/3] Implement a function to get cxl1.1 device uid
Date: Wed, 20 Dec 2023 14:07:37 +0900
Message-ID: <20231220050738.178481-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This patch adds a function to obtain the uid of the host bridge containing 
the device.

In this function, the host bridge is found by exploring the tree structure
of pci, and the uid is obtained. The uid obtained here is used to identify
the CHBS structure of the device.

Signed-off-by: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
---
 ls-caps.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index be81bb9..077e8ea 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1386,6 +1386,54 @@ static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
 
 #define OBJNAMELEN 1024
 static int get_device_uid(struct device *d){
+  char link_path[OBJNAMELEN];
+  char path[OBJNAMELEN];
+  ssize_t bytes_read;
+  int n = snprintf(path, OBJNAMELEN, "%s/devices/%04x:%02x:%02x.%d",
+      pci_get_param(d->dev->access, "sysfs.path"), d->dev->domain, d->dev->bus, d->dev->dev, d->dev->func);
+  if (n < 0 || n >= OBJNAMELEN){
+    d->dev->access->error("sysfs file name error");
+    return -1;
+  }
+
+  /* get absolute path pointed by the sym link */
+  bytes_read = readlink(path, link_path, sizeof(link_path));
+  if (bytes_read == -1)
+    return -1;
+  
+  link_path[bytes_read] = '\0'; 
+  
+  char *path_copy = strdup(link_path);
+  char *token = strtok(path_copy, "/");
+  int device_uid;
+  while (token)
+  {
+    if (strncmp(token, "pci", 3) == 0)
+    {
+      char buffer[OBJNAMELEN];
+      sprintf(buffer, "/sys/devices/%s/firmware_node/uid", token);
+      FILE *file = fopen(buffer, "r");
+      if (file == NULL)
+      {
+        free(path_copy);
+        return -1;
+      }
+
+      char line[OBJNAMELEN];
+      while (fgets(line, sizeof(line), file) != NULL)
+      {
+        if (sscanf(line, "%d", &device_uid) == 1)
+        {
+          fclose(file);
+          free(path_copy);
+          return device_uid;
+        }
+      }
+      fclose(file);
+    }
+    token = strtok(NULL, "/");
+  }
+  free(path_copy);
   return -1;
 }
 
-- 
2.43.0


