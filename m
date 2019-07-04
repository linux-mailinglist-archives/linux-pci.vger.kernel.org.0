Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF05EFF5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGDAL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 20:11:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44966 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGDAL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 20:11:27 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so9089436iob.11
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sij55SlYIuDhKB/TiTSybOBWighuYR+rkjRsCnJ25AY=;
        b=hNliobQysDq0wrg7d0sN3M/ZC3Cq/7UzUcZw6NWaHKFnJPy/PMPX/ylUVo3fUwam1F
         nd4B5vPIMxN+TaAH0v3LItfyKRSlsSvERRR6mFqnTKyD30Ig1rxZwX2hW0rhGifpyinE
         2CO1Hx1aopeM+yXUDB0JsAP3FprIryeF6pXS5yjqhKD03CdZVVubRSYGcKYqZy/0JgvC
         omeYFybgibcEa8hPCzoRqyYaY2nWan2HcF8JkJgqknwZUgQK6fQ6wLGRtxjjILeBehVY
         GpKcFQabiZlCa9v0Ce+KwFIvv9vk55MpLrOlLqKIHViVszt29xYzAtqpgRdMWY8yIe1U
         cdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sij55SlYIuDhKB/TiTSybOBWighuYR+rkjRsCnJ25AY=;
        b=EL6J+xsb3gaBfrQgbJC6MTSkPPu0KM3NOUm9Whq8BpzK6PSwK9YeeGtQvZXy+ccVot
         Qk1vbK03SXQqRTK02TK/tRMtameuk4qoOYlwSFG8D23CjJDnMc3xU4aTpBoNnfmgGLcD
         yi7quIP8NLphZfgZCNxna6G2lAza2IAhC4L8atlbS+27CQIjXKSbiJxRGX4+Zeae2a1W
         AraS6dfSdtHAep3Oe4boS8cT3MdTdVZkpfbxyDeihDVpWKls9qlUDYT9ZAYM0KxlTT/E
         prQA8u5xiur4AAthRKNP5idMVmh+UGzUxZQgrQMeU1jJ1o+8qV7jr3DyZQ67KmuuPmnz
         IJfg==
X-Gm-Message-State: APjAAAUIz/Uzmi+hXIcekaidHLu7hMGXZxLHinWRXhoX8GGKRXBUuoJ1
        ITNYNmkJDH4xW0FnEMgCItj9tJHzOIQkfA==
X-Google-Smtp-Source: APXvYqyOwRrgnztE2d9qRTkvgBJL9QTSeXkqxD5OaG6zhdoXxHdLpzIQXx5bLtHYOgBeviPlKreRzQ==
X-Received: by 2002:a02:1441:: with SMTP id 62mr2987071jag.21.1562199078814;
        Wed, 03 Jul 2019 17:11:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c81sm6152370iof.28.2019.07.03.17.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 17:11:17 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] lspci: Add lspci support to decode an AIDA64 log file
Date:   Wed,  3 Jul 2019 18:08:18 -0600
Message-Id: <20190704000819.25050-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704000819.25050-1-skunberg.kelsey@gmail.com>
References: <20190704000819.25050-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

AIDA64 (free trial versions available at http://www.aida64.com/) can
extract lots of system information on Windows systems, including PCI
configuration space dumps.

Add lspci support to decode the hexdump format from an AIDA64 log file
using the following command:

  $ lspci -F <file-name>

tests/aida64-dump is a sample output file from AIDA64 on a Windows 10
system from: https://bugzilla.kernel.org/show_bug.cgi?id=202425

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 lib/dump.c        |  37 +-
 tests/aida64-dump | 954 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 983 insertions(+), 8 deletions(-)
 create mode 100644 tests/aida64-dump

diff --git a/lib/dump.c b/lib/dump.c
index 59cf7ed..d22bb3c 100644
--- a/lib/dump.c
+++ b/lib/dump.c
@@ -41,6 +41,18 @@ dump_alloc_data(struct pci_dev *dev, int len)
   dev->aux = dd;
 }
 
+static char *
+dump_skip_optional(char *s, char *fmt)
+{
+  while (*fmt)
+    {
+      if (*fmt != *s)
+	return s;
+      fmt++, s++;
+    }
+  return s;
+}
+
 static int
 dump_validate(char *s, char *fmt)
 {
@@ -79,8 +91,15 @@ dump_init(struct pci_access *a)
 	*z-- = 0;
       len = z - buf + 1;
       mn = 0;
-      if (dump_validate(buf, "##:##.# ") && sscanf(buf, "%x:%x.%d", &bn, &dn, &fn) == 3 ||
-	  dump_validate(buf, "####:##:##.# ") && sscanf(buf, "%x:%x:%x.%d", &mn, &bn, &dn, &fn) == 4)
+
+      /* skip leading whitespace */
+      z = buf;
+      while (isblank(*z))
+	z++;
+
+      if (dump_validate(z, "##:##.# ") && sscanf(z, "%x:%x.%d", &bn, &dn, &fn) == 3 ||
+	  dump_validate(z, "####:##:##.# ") && sscanf(z, "%x:%x:%x.%d", &mn, &bn, &dn, &fn) == 4 ||
+          dump_validate(z, "B## D## F##: ") && sscanf(z, "B%x D%x F%d", &bn, &dn, &fn) == 3)
 	{
 	  dev = pci_get_dev(a, mn, bn, dn, fn);
 	  dump_alloc_data(dev, 256);
@@ -88,12 +107,14 @@ dump_init(struct pci_access *a)
 	}
       else if (!len)
 	dev = NULL;
-      else if (dev &&
-	       (dump_validate(buf, "##: ") || dump_validate(buf, "###: ")) &&
-	       sscanf(buf, "%x: ", &i) == 1)
+      else if (dev && (z = dump_skip_optional(z, "Offset ")) &&
+	       (dump_validate(z, "##: ") || dump_validate(z, "###: ")) &&
+	       sscanf(z, "%x: ", &i) == 1)
 	{
 	  struct dump_data *dd = dev->aux;
-	  z = strchr(buf, ' ') + 1;
+	  z = strchr(z, ':') + 1;
+	  while (isblank(*z))
+	    z++;
 	  while (isxdigit(z[0]) && isxdigit(z[1]) && (!z[2] || z[2] == ' ') &&
 		 sscanf(z, "%x", &j) == 1 && j < 256)
 	    {
@@ -113,8 +134,8 @@ dump_init(struct pci_access *a)
 	      if (i > dd->len)
 		dd->len = i;
 	      z += 2;
-	      if (*z)
-		z++;
+	      while (isblank(*z))
+	        z++;
 	    }
 	  if (*z)
 	    {
diff --git a/tests/aida64-dump b/tests/aida64-dump
new file mode 100644
index 0000000..8f0e234
--- /dev/null
+++ b/tests/aida64-dump
@@ -0,0 +1,954 @@
+--------[ Debug - PCI ]-------------------------------------------------------------------------------------------------
+
+    B00 D00 F00:  AMD K17 - Root Complex
+                  
+      Offset 000:  22 10 50 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  80 00 00 00  10 00 80 00 
+      Offset 050:  43 10 47 87  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  1D 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  08 01 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 E0  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 30 14  04 02 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  FF FF FF FF  00 00 00 00 
+      Offset 0D0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0E0:  46 00 30 01  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 80 80 00  00 00 00 00  FF FF FF FF 
+
+    B00 D00 F02:  AMD K17 - IOMMU
+                  
+      Offset 000:  22 10 51 14  00 00 10 00  00 00 06 08  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  40 00 00 00  00 00 00 00  FF 00 00 00 
+      Offset 040:  0F 64 0B 19  01 00 B8 FE  00 00 00 00  00 00 00 00 
+      Offset 050:  40 30 20 00  80 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  05 74 85 00  00 00 E0 FE  00 00 00 00 
+      Offset 070:  CE 40 00 00  08 00 03 A8  43 10 47 87  00 2B 00 00 
+      Offset 080:  DA 1A 20 62  CF CF 03 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  02 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  BF 07 00 2C  10 9C 73 0E  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  75 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  FF FF FF FF  00 00 00 00  FF FF FF FF 
+
+    B00 D01 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D01 F03:  AMD K17 - PCIe GPP Bridge [7:0]
+                  
+      Offset 000:  22 10 53 14  07 04 10 00  00 00 04 06  10 00 81 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 01 09 00  C1 D1 00 20 
+      Offset 020:  20 F7 50 F7  01 F4 F1 F5  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  FF 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  01 58 03 C8  00 00 00 00  10 A0 42 01  22 80 00 00 
+      Offset 060:  50 28 00 00  43 F8 72 01  40 00 43 70  00 00 04 00 
+      Offset 070:  00 00 40 01  00 00 01 00  00 00 00 00  BF 01 70 00 
+      Offset 080:  06 00 00 00  0E 00 00 00  03 00 1F 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D C8 00 00  43 10 47 87  08 00 03 A8  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D02 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D03 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D03 F01:  AMD K17 - PCIe GPP Bridge [7:0]
+                  
+      Offset 000:  22 10 53 14  07 04 10 00  00 00 04 06  10 00 81 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 0A 0A 00  E1 E1 00 20 
+      Offset 020:  00 F6 00 F7  01 E0 F1 F1  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  FF 00 18 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  01 58 03 C8  00 00 00 00  10 A0 42 01  22 80 00 00 
+      Offset 060:  30 29 00 00  03 79 73 00  40 00 01 F1  00 00 04 00 
+      Offset 070:  00 00 40 01  00 00 01 00  00 00 00 00  BF 01 70 00 
+      Offset 080:  06 00 00 00  0E 00 00 00  03 00 1F 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D C8 00 00  43 10 47 87  08 00 03 A8  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D04 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D07 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D07 F01:  AMD K17 - Internal PCIe GPP Bridge 0 to Bus B/C
+                  
+      Offset 000:  22 10 54 14  06 04 10 00  00 00 04 06  10 00 81 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 0B 0B 00  F1 01 00 00 
+      Offset 020:  60 F7 80 F7  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  FF 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  01 58 03 C8  00 00 00 00  10 A0 42 00  22 80 00 00 
+      Offset 060:  30 28 00 00  03 0D 70 00  40 00 03 71  00 00 00 00 
+      Offset 070:  00 00 40 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  0E 00 00 00  43 00 1F 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D C8 00 00  22 10 54 14  08 00 03 A8  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D08 F00:  AMD K17 - PCIe Dummy Host Bridge
+                  
+      Offset 000:  22 10 52 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D08 F01:  AMD K17 - Internal PCIe GPP Bridge 0 to Bus B/C
+                  
+      Offset 000:  22 10 54 14  06 04 10 00  00 00 04 06  10 00 81 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 0C 0C 00  F1 01 00 00 
+      Offset 020:  90 F7 90 F7  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  FF 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  01 58 03 C8  00 00 00 00  10 A0 42 00  22 80 00 00 
+      Offset 060:  30 28 00 00  03 0D 70 00  40 00 03 71  00 00 00 00 
+      Offset 070:  00 00 40 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  0E 00 00 00  43 00 1F 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D C8 00 00  22 10 54 14  08 00 03 A8  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D14 F00:  AMD K17 SCH - SMBus and ACPI Controller
+                  
+      Offset 000:  22 10 0B 79  03 04 20 02  59 00 05 0C  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D14 F03:  AMD K17 SCH - LPC Bridge
+                  
+      Offset 000:  22 10 0E 79  0F 00 20 02  51 00 01 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  04 00 00 00  D5 FF 03 FF  07 FF 30 03  00 00 00 FD 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  30 02 20 FF  00 00 0F 00  00 FF FF FF 
+      Offset 070:  67 45 23 00  0C 00 00 00  90 02 00 00  07 0A 00 00 
+      Offset 080:  08 00 03 A8  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  68 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  02 00 C1 FE  2F 01 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  04 00 E9 3F  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 80  00 00 F7 FF 
+      Offset 0D0:  86 FF FD 08  42 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D18 F00:  AMD K17 - Data Fabric: Device 18h; Function 0
+                  
+      Offset 000:  22 10 60 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  13 00 00 00  2F 12 97 00  1F 1F 1F 0F  11 00 00 00 
+      Offset 050:  1F 07 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  41 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  01 00 00 00  00 00 00 00  05 04 04 04  04 04 04 04 
+      Offset 0A0:  43 00 00 0C  40 00 00 00  40 00 00 00  40 00 00 00 
+      Offset 0B0:  40 00 00 00  40 00 00 00  40 00 00 00  40 00 00 00 
+      Offset 0C0:  13 C0 00 00  04 E0 00 00  00 00 00 00  04 00 00 00 
+      Offset 0D0:  00 00 00 00  04 00 00 00  00 00 00 00  04 00 00 00 
+      Offset 0E0:  00 00 00 00  04 00 00 00  00 00 00 00  04 00 00 00 
+      Offset 0F0:  00 00 00 00  04 00 00 00  00 00 00 00  04 00 00 00 
+
+    B00 D18 F01:  AMD K17 - Data Fabric: Device 18h; Function 1
+                  
+      Offset 000:  22 10 61 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  05 05 04 04  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 42 42 42  FF 01 FF 01  E0 00 00 00  00 00 00 00 
+      Offset 0B0:  01 00 00 00  00 00 00 00  08 00 00 00  00 00 00 00 
+      Offset 0C0:  01 00 00 00  81 FC 06 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  1F BF 1F 0B 
+      Offset 0F0:  0F 5D 1D 05  1F 7F BF 05  1F BF FF 03  0F 57 F7 01 
+
+    B00 D18 F02:  AMD K17 - Data Fabric: Device 18h; Function 2
+                  
+      Offset 000:  22 10 62 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  80 10 1F 00  08 09 40 09  80 00 00 00  11 00 00 00 
+      Offset 050:  04 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  19 50 06 00  11 06 04 10 
+      Offset 070:  00 01 00 02  00 04 00 08  00 10 00 20  00 40 00 80 
+      Offset 080:  0F DE 00 00  FF DF 00 00  07 00 00 06  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D18 F03:  AMD K17 - Data Fabric: Device 18h; Function 3
+                  
+      Offset 000:  22 10 63 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  04 00 00 00  00 00 00 00  01 00 00 00  27 01 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D18 F04:  AMD K17 - Data Fabric: Device 18h; Function 4
+                  
+      Offset 000:  22 10 64 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  51 10 01 00  41 18 03 00  00 00 00 00  89 01 04 00 
+      Offset 060:  08 02 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  04 00 00 00  04 00 00 00  04 00 00 00  04 00 00 00 
+      Offset 090:  22 10 60 14  22 10 60 14  00 00 00 00  00 00 00 00 
+      Offset 0A0:  43 00 00 00  43 00 00 00  22 10 60 14  22 10 60 14 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  01 00 00 00  01 00 02 00  00 00 02 01  03 0B 0E 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D18 F05:  AMD K17 - Data Fabric: Device 18h; Function 5
+                  
+      Offset 000:  22 10 65 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 D7 01  01 00 00 00  01 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  80 00 00 00 
+
+    B00 D18 F06:  AMD K17 - Data Fabric: Device 18h; Function 6
+                  
+      Offset 000:  22 10 66 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 0F 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B00 D18 F07:  AMD K17 - Data Fabric: Device 18h; Function 7
+                  
+      Offset 000:  22 10 67 14  00 00 00 00  00 00 00 06  00 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B01 D00 F00:  AMD Low-Power Promontory A Chipset - USB 3.1 xHCI Controller
+                  
+      Offset 000:  22 10 D0 43  06 04 10 00  01 30 03 0C  10 00 80 00 
+      Offset 010:  04 00 5A F7  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  21 1B 42 11 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  00 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 68 86 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  31 40 00 00  00 00 00 00  11 78 07 80  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 00 12 00  22 8C 00 00  50 28 19 00  43 DC 42 00 
+      Offset 090:  40 00 43 10  00 00 00 00  00 00 40 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  0E 00 00 00 
+      Offset 0B0:  03 00 06 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  21 1B 01 02  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 01 60  00 00 00 00  00 00 00 00 
+      Offset 0F0:  AA 55 AA 55  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B01 D00 F01:  AMD Low-Power Promontory Chipset - SATA AHCI Controller
+                  
+      Offset 000:  22 10 C8 43  06 04 10 00  01 01 06 01  10 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 58 F7  00 00 00 00  21 1B 62 10 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  00 02 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 81 00  0C F0 E3 FE  00 00 00 00  70 49 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 00 12 00  22 8C 00 00  50 28 19 00  43 DC 42 00 
+      Offset 090:  40 00 43 10  00 00 00 00  00 00 40 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  0E 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  21 1B 01 02  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  CC 0D 00 00  01 01 01 01  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B01 D00 F02:  AMD Low-Power Promontory Chipset - Switch Upstream Port
+                  
+      Offset 000:  22 10 C6 43  07 04 10 00  01 00 04 06  10 00 81 00 
+      Offset 010:  00 00 00 00  00 00 00 00  01 02 09 00  C1 D1 00 00 
+      Offset 020:  20 F7 40 F7  01 F4 F1 F5  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0F 03 00 00 
+      Offset 040:  04 00 C3 FE  00 00 00 00  01 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 52 00  22 80 00 00  50 28 19 00  43 DC 42 00 
+      Offset 090:  40 00 43 10  00 00 00 00  00 00 40 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  0E 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 01 02  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  7E 71 2C 2A  83 EC A1 38  EA 2E 39 9C  40 E7 62 07 
+      Offset 0F0:  C2 C9 17 D3  A6 86 BF FA  2A 57 DE 1D  E2 EB D1 F4 
+
+    B02 D00 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  04 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 03 03 00  F1 01 00 00 
+      Offset 020:  F0 FF 00 00  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0B 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  22 7C 73 00 
+      Offset 090:  00 00 01 10  00 0D 08 00  00 00 08 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D02 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  04 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 04 04 00  F1 01 00 00 
+      Offset 020:  F0 FF 00 00  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0F 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  12 7C 73 02 
+      Offset 090:  00 00 11 10  00 0D 08 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D03 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  07 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 05 05 00  D1 D1 00 00 
+      Offset 020:  40 F7 40 F7  01 F4 F1 F5  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  05 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  12 7C 73 03 
+      Offset 090:  00 00 11 30  00 0D 08 00  00 00 48 01  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D04 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  06 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 06 06 00  F1 01 00 00 
+      Offset 020:  30 F7 30 F7  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0B 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  22 7C 73 04 
+      Offset 090:  40 00 22 70  00 0D 08 00  00 00 48 01  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D06 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  04 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 07 07 00  F1 01 00 00 
+      Offset 020:  F0 FF 00 00  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0F 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  12 7C 73 06 
+      Offset 090:  00 00 11 10  00 0D 08 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D07 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  07 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 08 08 00  C1 C1 00 00 
+      Offset 020:  20 F7 20 F7  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  05 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  12 7C 73 07 
+      Offset 090:  40 00 11 70  00 0D 08 00  00 00 48 01  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  02 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B02 D09 F00:  AMD Low-Power Promontory Chipset - GPP-Switch Downstream Port / SATA Express Controller
+                  
+      Offset 000:  22 10 C7 43  04 04 10 00  01 00 04 06  10 00 01 00 
+      Offset 010:  00 00 00 00  00 00 00 00  02 09 09 00  F1 01 00 00 
+      Offset 020:  F0 FF 00 00  F1 FF 01 00  00 00 00 00  00 00 00 00 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  0A 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 78 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  11 78 07 00  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 C0 62 01  22 80 00 00  50 28 10 00  23 78 73 09 
+      Offset 090:  00 00 01 10  00 0D 08 00  00 00 08 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  0E 00 00 00 
+      Offset 0B0:  03 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  0D 00 00 00  21 1B 06 33  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B05 D00 F00:  AMCC 3ware 9650SE SATA-II RAID Controller
+                  
+      Offset 000:  C1 13 04 10  07 00 10 00  01 00 04 01  10 00 00 00 
+      Offset 010:  0C 00 00 F4  00 00 00 00  04 00 42 F7  00 00 00 00 
+      Offset 020:  01 D0 00 00  00 00 00 00  00 00 00 00  C1 13 04 10 
+      Offset 030:  00 00 00 00  40 00 00 00  00 00 00 00  23 01 00 00 
+      Offset 040:  01 50 02 06  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 70 8A 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  10 00 11 00  42 82 68 00  50 28 00 00  81 3C 13 00 
+      Offset 080:  08 00 11 20  00 00 00 00  C0 03 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  04 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B06 D00 F00:  ASMedia ASM1142 USB 3.1 xHCI Controller
+                  
+      Offset 000:  21 1B 42 12  06 04 10 00  00 30 03 0C  10 00 00 00 
+      Offset 010:  04 00 30 F7  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 75 86 
+      Offset 030:  00 00 00 00  50 00 00 00  00 00 00 00  00 01 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 68 86 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  30 20 00 00  00 00 00 00  11 78 07 80  00 20 00 00 
+      Offset 070:  80 20 00 00  00 00 00 00  01 80 43 C0  08 00 00 00 
+      Offset 080:  10 00 02 00  22 82 68 00  50 28 10 00  22 DC 43 01 
+      Offset 090:  40 00 22 10  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 08 00 00  00 00 00 00  06 00 00 00 
+      Offset 0B0:  03 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  21 1B 42 12  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  C9 4F 01 32  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B08 D00 F00:  Intel I211 Gigabit Network Connection
+                  
+      Offset 000:  86 80 39 15  06 04 10 00  03 00 00 02  10 00 00 00 
+      Offset 010:  00 00 20 F7  00 00 00 00  01 00 00 00  00 00 22 F7 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 F0 85 
+      Offset 030:  00 00 00 00  40 00 00 00  00 00 00 00  00 01 00 00 
+      Offset 040:  01 50 23 C8  08 21 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  05 70 80 01  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 070:  11 A0 04 80  03 00 00 00  03 20 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  FF FF FF FF 
+      Offset 0A0:  10 00 02 00  C2 8C 00 10  50 28 10 00  11 5C 42 07 
+      Offset 0B0:  40 00 11 10  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  1F 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  01 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0A D00 F00:  nVIDIA GeForce GTX 1070 Ti (PG411) Video Adapter
+                  
+      Offset 000:  DE 10 82 1B  07 00 10 00  A1 00 00 03  10 00 80 00 
+      Offset 010:  00 00 00 F6  0C 00 00 E0  00 00 00 00  0C 00 00 F0 
+      Offset 020:  00 00 00 00  01 E0 00 00  00 00 00 00  DE 10 9D 11 
+      Offset 030:  00 00 00 00  60 00 00 00  00 00 00 00  36 01 00 00 
+      Offset 040:  DE 10 9D 11  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  01 00 00 00  01 00 00 00  CE D6 23 00  00 00 00 00 
+      Offset 060:  01 68 03 00  08 00 00 00  05 78 80 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  10 00 12 00  E1 8D 00 00 
+      Offset 080:  30 29 00 00  03 3D 46 00  40 01 01 11  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  13 08 04 00 
+      Offset 0A0:  00 00 00 00  0E 00 00 00  03 00 1F 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  09 00 14 01  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0A D00 F01:  nVIDIA GP104 - High Definition Audio Controller
+                  
+      Offset 000:  DE 10 F0 10  06 00 10 00  A1 00 03 04  10 00 80 00 
+      Offset 010:  00 00 08 F7  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  DE 10 9D 11 
+      Offset 030:  00 00 00 00  60 00 00 00  00 00 00 00  37 02 00 00 
+      Offset 040:  DE 10 9D 11  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 050:  00 00 00 00  00 00 00 00  CE D6 23 00  00 00 00 00 
+      Offset 060:  01 68 03 00  08 00 00 00  05 78 80 00  00 00 00 00 
+      Offset 070:  00 00 00 00  00 00 00 00  10 00 02 00  E1 8D 00 00 
+      Offset 080:  30 29 09 00  03 3D 45 00  43 01 01 11  00 00 00 00 
+      Offset 090:  00 00 00 00  00 00 00 00  00 00 00 00  13 08 04 00 
+      Offset 0A0:  00 00 00 00  0E 00 00 00  00 00 01 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0B D00 F00:  AMD K17 - PCIe Dummy Function
+                  
+      Offset 000:  22 10 5A 14  04 04 10 00  00 00 00 13  10 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  22 10 5A 14 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  FF 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  22 10 5A 14 
+      Offset 050:  01 64 03 00  08 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  10 00 02 00  A1 8F 00 00  30 28 09 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  03 00 1F 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0B D00 F02:  AMD K17 - Cryptographic Coprocessor PSPCPP
+                  
+      Offset 000:  22 10 56 14  00 04 10 00  00 00 80 10  10 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 80 F7  00 00 00 00 
+      Offset 020:  00 00 00 00  00 E0 7F F7  00 00 00 00  22 10 56 14 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  00 02 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  22 10 56 14 
+      Offset 050:  01 64 03 00  0B 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  10 A0 02 00  A1 8F 00 00  30 28 09 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 82 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  11 00 01 00  05 00 00 00  05 10 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0B D00 F03:  AMD K17 - Reserved
+                  
+      Offset 000:  22 10 5F 14  06 04 10 00  00 30 03 0C  10 00 80 00 
+      Offset 010:  04 00 60 F7  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  00 03 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  43 10 47 87 
+      Offset 050:  01 64 03 C8  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  30 20 00 00  10 A0 02 00  A1 8F 00 00  30 28 19 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 C0 86 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  11 00 07 80  00 E0 0F 00  00 F0 0F 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0C D00 F00:  AMD K17 - PCIe Dummy Function
+                  
+      Offset 000:  22 10 55 14  04 04 10 00  00 00 00 13  10 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  22 10 55 14 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  FF 00 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  22 10 55 14 
+      Offset 050:  01 64 03 00  08 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  10 00 02 00  A1 8F 00 00  30 28 09 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  03 00 1F 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0C D00 F02:  AMD K17 SCH - SATA AHCI Controller
+                  
+      Offset 000:  22 10 01 79  00 04 10 00  51 01 06 01  10 00 80 00 
+      Offset 010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 80 90 F7  00 00 00 00  43 10 47 87 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  00 02 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  43 10 47 87 
+      Offset 050:  01 64 23 C0  0B 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  10 A0 02 00  A1 8F 00 00  30 28 09 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 D0 B8 00  0C F0 E3 FE  00 00 00 00  60 49 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  12 00 10 00  0F 00 00 00  00 00 00 00  00 FF 37 F7 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    B0C D00 F03:  AMD K17 - High Definition Audio Controller
+                  
+      Offset 000:  22 10 57 14  06 00 10 00  00 00 03 04  10 00 80 00 
+      Offset 010:  00 80 9F F7  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 020:  00 00 00 00  00 00 00 00  00 00 00 00  43 10 23 87 
+      Offset 030:  00 00 00 00  48 00 00 00  00 00 00 00  2B 03 00 00 
+      Offset 040:  00 00 00 00  00 00 00 00  09 50 08 00  43 10 23 87 
+      Offset 050:  01 64 03 C8  08 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 060:  00 00 00 00  10 A0 02 00  A1 8F 00 00  30 28 09 00 
+      Offset 070:  03 0D 40 00  40 00 03 11  00 00 00 00  00 00 00 00 
+      Offset 080:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 090:  0E 00 00 00  00 00 01 00  00 00 00 00  00 00 00 00 
+      Offset 0A0:  05 00 80 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0B0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0E0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 0F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 SMUTHM NBSMNIND
+                  
+      Offset 00059800:  EF 0F 48 68  01 10 FF 00  21 29 00 00  00 00 00 00 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 SMUSVI NBSMNIND
+                  
+      Offset 0005A000:  06 00 00 00  26 00 00 00  02 00 00 00  14 00 0C 01 
+      Offset 0005A010:  21 00 4A 01  00 00 00 00  0E 00 00 00  00 00 00 00 
+      Offset 0005A020:  00 00 00 00  00 00 80 DB  00 00 00 00  00 00 0A 00 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 CH0 NBSMNIND
+                  
+      Offset 00050000:  00 00 00 00  00 00 00 00  01 00 00 00  01 02 00 00 
+      Offset 00050010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050020:  00 00 00 00  FE FD FF 03  00 00 00 00  00 00 00 00 
+      Offset 00050030:  08 05 15 00  08 06 15 00  00 00 00 00  00 00 00 00 
+      Offset 00050040:  98 BA 0C 07  BA 98 0C 06  00 00 00 00  00 00 00 00 
+      Offset 00050050:  21 43 65 87  43 65 87 A9  21 43 65 87  43 65 87 A9 
+      Offset 00050060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050080:  00 00 00 00  01 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000500A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000500B0:  15 2B 00 00  0B 2B 0C 36  36 15 2B 0C  2C 16 2B 0C 
+      Offset 000500C0:  00 00 00 00  00 00 00 00  01 40 44 04  01 80 88 08 
+      Offset 000500D0:  F1 07 11 11  01 00 22 22  00 00 00 00  00 00 00 00 
+      Offset 000500E0:  00 00 00 00  00 00 00 00  01 FC FF 03  00 FC FF 03 
+      Offset 000500F0:  04 08 00 00  00 00 04 08  00 00 00 00  00 00 00 00 
+      Offset 00050100:  00 02 00 80  82 80 40 B0  91 00 40 48  90 00 00 00 
+      Offset 00050110:  30 B0 B0 00  28 30 20 20  47 00 00 00  00 00 00 00 
+      Offset 00050120:  00 00 00 00  0A 48 00 31  00 00 00 00  68 04 10 21 
+      Offset 00050130:  00 00 00 10  00 00 00 00  C0 C0 40 07  00 00 00 00 
+      Offset 00050140:  00 00 00 00  01 01 FF FF  11 5C 7A DA  00 00 00 00 
+      Offset 00050150:  00 0F 00 00  81 00 00 00  00 82 10 60  00 00 00 00 
+      Offset 00050160:  00 00 0A C0  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050170:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050180:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050190:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000501A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000501B0:  00 00 00 00  00 00 00 00  00 02 00 00  00 08 00 00 
+      Offset 000501C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000501D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000501E0:  1B 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 000501F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050200:  30 19 00 00  10 35 16 16  4B 00 16 00  06 09 00 0C 
+      Offset 00050210:  22 00 00 00  10 04 0C 00  18 00 00 00  00 00 00 00 
+      Offset 00050220:  05 05 01 46  07 07 01 46  04 07 00 00  80 00 42 0C 
+      Offset 00050230:  C0 30 00 00  08 18 10 18  40 02 00 04  24 20 00 00 
+      Offset 00050240:  00 00 00 00  08 00 FF 3F  00 00 00 00  00 00 00 00 
+      Offset 00050250:  00 00 09 00  0A 00 04 08  0B 0B 18 02  2A 2A 00 22 
+      Offset 00050260:  38 01 06 21  30 02 0D 40  00 00 00 00  00 00 00 00 
+      Offset 00050270:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050280:  72 72 00 00  10 01 00 00  02 00 00 00  80 29 00 18 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 CH1 NBSMNIND
+                  
+      Offset 00150000:  00 00 00 00  00 00 00 00  01 00 00 00  01 02 00 00 
+      Offset 00150010:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150020:  00 00 00 00  FE FD FF 03  00 00 00 00  00 00 00 00 
+      Offset 00150030:  08 05 15 00  08 06 15 00  00 00 00 00  00 00 00 00 
+      Offset 00150040:  98 BA 0C 07  BA 98 0C 06  00 00 00 00  00 00 00 00 
+      Offset 00150050:  21 43 65 87  43 65 87 A9  21 43 65 87  43 65 87 A9 
+      Offset 00150060:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150070:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150080:  00 00 00 00  01 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150090:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001500A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001500B0:  15 2B 00 00  0B 2B 0C 36  36 15 2B 0C  2C 16 2B 0C 
+      Offset 001500C0:  00 00 00 00  00 00 00 00  01 40 44 04  01 80 88 08 
+      Offset 001500D0:  F1 07 11 11  01 00 22 22  00 00 00 00  00 00 00 00 
+      Offset 001500E0:  00 00 00 00  00 00 00 00  01 FC FF 03  00 FC FF 03 
+      Offset 001500F0:  04 08 00 00  00 00 04 08  00 00 00 00  00 00 00 00 
+      Offset 00150100:  00 02 00 80  82 80 40 B0  91 00 40 48  90 00 00 00 
+      Offset 00150110:  30 B0 B0 00  28 30 20 20  47 00 00 00  00 00 00 00 
+      Offset 00150120:  00 00 00 00  0A 48 00 31  00 00 00 00  68 04 10 21 
+      Offset 00150130:  00 00 00 10  00 00 00 00  C0 C0 40 07  00 00 00 00 
+      Offset 00150140:  00 00 00 00  01 01 FF FF  11 5C 7A DA  00 00 00 00 
+      Offset 00150150:  00 0F 00 00  81 00 00 00  00 82 10 60  00 00 00 00 
+      Offset 00150160:  00 00 0A C0  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150170:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150180:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150190:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001501A0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001501B0:  00 00 00 00  00 00 00 00  00 02 00 00  00 08 00 00 
+      Offset 001501C0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001501D0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001501E0:  1B 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 001501F0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150200:  30 19 00 00  10 35 16 16  4B 00 16 00  06 09 00 0C 
+      Offset 00150210:  22 00 00 00  10 04 0C 00  18 00 00 00  00 00 00 00 
+      Offset 00150220:  05 05 01 46  07 07 01 46  03 08 00 00  80 00 42 0C 
+      Offset 00150230:  C0 30 00 00  08 18 10 18  40 02 00 04  24 20 00 00 
+      Offset 00150240:  00 00 00 00  08 00 FF 3F  00 00 00 00  00 00 00 00 
+      Offset 00150250:  00 00 09 00  0A 00 04 08  0B 0B 1A 02  2A 2A 00 22 
+      Offset 00150260:  38 01 06 21  30 02 0D 40  00 00 00 00  00 00 00 00 
+      Offset 00150270:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150280:  72 72 00 00  10 01 00 00  02 00 00 00  80 29 00 18 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 CH0 NBSMNIND
+                  
+      Offset 00050D00:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D10:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D20:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D30:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D40:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D50:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D60:  00 00 00 00  00 00 00 00  00 00 00 00  F8 00 00 00 
+      Offset 00050D70:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050D80:  00 00 00 00  00 00 00 00  FF FF FF FF  00 00 00 00 
+      Offset 00050D90:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050DA0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050DB0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050DC0:  FF FF FF FF  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 00050DD0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050DE0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00050DF0:  2C FE 01 00  00 00 00 00  00 00 00 00  00 00 00 00 
+
+    PCI-1022-1450:  AMD K17/K17.1/K17.3/K17.7 CH1 NBSMNIND
+                  
+      Offset 00150D00:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D10:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D20:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D30:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D40:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D50:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D60:  00 00 00 00  00 00 00 00  00 00 00 00  F8 00 00 00 
+      Offset 00150D70:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150D80:  00 00 00 00  00 00 00 00  FF FF FF FF  00 00 00 00 
+      Offset 00150D90:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150DA0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150DB0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150DC0:  FF FF FF FF  FF FF FF FF  00 00 00 00  00 00 00 00 
+      Offset 00150DD0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150DE0:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 
+      Offset 00150DF0:  2C FE 01 00  00 00 00 00  00 00 00 00  00 00 00 00 
-- 
2.20.1

