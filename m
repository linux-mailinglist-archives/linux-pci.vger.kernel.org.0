Return-Path: <linux-pci+bounces-1207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F781982D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F3A288835
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AD1118C;
	Wed, 20 Dec 2023 05:32:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88451170D;
	Wed, 20 Dec 2023 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="143487949"
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="143487949"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:32:29 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E6E6ED2A02;
	Wed, 20 Dec 2023 14:32:26 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D9C0D88CE;
	Wed, 20 Dec 2023 14:32:26 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.237.107])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id E96E12005352;
	Wed, 20 Dec 2023 14:32:25 +0900 (JST)
From: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com,
	KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH 3/3] Implement a function to get a RCRB Base address
Date: Wed, 20 Dec 2023 14:07:38 +0900
Message-ID: <20231220050738.178481-4-kobayashi.da-06@fujitsu.com>
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

This patch adds a function to obtain the RCRB base address corresponding to
the uid. 

In the case of a CXL1.1 device, the RCRB base address is included in the CHBS
in the CEDT (cxl3.0 specification 9.17.1). In this function, the ACPI's CEDT 
is explored, and the RCRB base address is obtained from the CHBS corresponding
to the uid.


Signed-off-by: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
---
 ls-caps.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index 077e8ea..cccd775 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1438,6 +1438,51 @@ static int get_device_uid(struct device *d){
 }
 
 static off_t get_rcrb_base(int device_uid){
+  FILE *cedt_file = fopen("/sys/firmware/acpi/tables/CEDT", "rb");
+  if (cedt_file == NULL)
+    return -1;
+
+  struct CEDT_Header header;
+  fread(&header, sizeof(header), 1, cedt_file);
+  
+  struct CHBS_Structure chbs;
+  chbs.base = 0;
+  size_t total_bytes_read = 0;
+  while (total_bytes_read < header.length)
+  {
+    struct CEDT_Structure cedt;
+    size_t bytes_read = fread(&cedt, sizeof(cedt), 1, cedt_file);
+    if (bytes_read != 1)
+    {
+      fclose(cedt_file);
+      return -1;
+    }
+    total_bytes_read += sizeof(cedt);
+    if (cedt.type == CHBS_TYPE)
+    {
+      bytes_read = fread(&chbs, sizeof(chbs), 1, cedt_file);
+      if(bytes_read != 1){
+        fclose(cedt_file);
+        return -1;
+      }
+      total_bytes_read += sizeof(chbs);
+      if ((int)chbs.uid == device_uid){
+        if(chbs.cxl_version == 0){
+          fclose(cedt_file);
+          return chbs.base;
+        }else{
+          fclose(cedt_file);
+          return -1;
+        }
+      } 
+    }
+    else
+    {
+      fseek(cedt_file, cedt.record_length - sizeof(cedt), SEEK_SET);
+      total_bytes_read += cedt.record_length;
+    }
+  }
+  fclose(cedt_file);
   return -1;
 }
 
-- 
2.43.0


