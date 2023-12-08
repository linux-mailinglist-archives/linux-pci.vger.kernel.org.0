Return-Path: <linux-pci+bounces-665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56D809F46
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C2BB20C0E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F26B12B9E;
	Fri,  8 Dec 2023 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="nrwTNer1";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="zxsfnGN3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B5172B
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 607FCC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027153; bh=JFhqlJUqHzBtdvUw320D2RCRRLPeUWbR8MkqxMqVrhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nrwTNer1GpwsuHaFKVy9Bqy4eNp8Yj6ncLF2k6Ca/f2S0ZXuozs+STvTvucYJ+ktm
	 BvLDlwoiJ8Z9Gai7Da9Te9aYy8Ngpl0uS/Py8Xd3NJOqos9ZBwhLLRYyJ78gAhGlm/
	 zyAKcTKd/cffLkkq7QE5UKNXqSilAVwVsVLtKqwbihZlCRkWBI5qAFEIonjs+a+LZT
	 TMTTX0HVybLQ/hrKuizDcdWomUXdGAlGyx27MrDSoS+acQ/b2XiyB3tB4F6X6n0Hlz
	 TaY0SgeB+sq8RUNB493m6BCmoS/QA9rPHFbCKlkee1VZmc1fwzM2EKtaG4hoK2rDVA
	 gX9bTM/4P0QRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027153; bh=JFhqlJUqHzBtdvUw320D2RCRRLPeUWbR8MkqxMqVrhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=zxsfnGN3lTfD7i6zj0TRjxbCnP1TnoRtQsWzT4560PRoDhthqVQrUQYm4i3MCe9jE
	 RBv8SsMez1GRy09LNAxTEHTTd+/nNBScUO21dFo8Jm9k0RDjpbDkEbyTci4xLf2HKJ
	 meoS+yU+0q+bwOxIJgAFjE3oSF/ZQa8XHLCQdSGK03bw+TPIKB1P3a0n79SaVKQEBm
	 RZOjIltFmMNpAXqPIoPEWbRmFOQD2mjKYeywKO4cd7cVGLA+xihANGXECxz8vgEFWm
	 2PLnMpMB36hI1Eih6FkBpQ9bEOj3M5y2YuZ6VjHAYpt5W7zlLUYK+cjHSBn2NlJcbt
	 qmeBwDVKhAZPw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 10/15] pciutils-pcilmr: Add support for unique hardware quirks
Date: Fri, 8 Dec 2023 12:17:29 +0300
Message-ID: <20231208091734.12225-11-n.proshkin@yadro.com>
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

Make it possible to change receiver margining parameters depending on
current hardware specificity.

In our tests Intel Ice Lake CPUs receivers reported
MaxVoltageOffset = 50 (RxA), which led to results several times bigger
than the results of the hardware debugger.
Looks like in Intel Sapphire Rapids this was fixed, these CPUs report
MaxVoltageOffset = 12 (RxA). To solve the problem it was decided to hardcode
Volt Offset to 12 (120 mV) if the test is running on the Ice Lake.

Use /proc/cpuinfo as a convenient and generic way for different CPU
architectures on Unix-like systems. For other operating systems, a
different solution will be needed.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr_lib/margin.c     | 22 ++++++++++++
 lmr_lib/margin.h     |  2 ++
 lmr_lib/margin_hw.c  | 80 +++++++++++++++++++++++++++++++++++++++++++-
 lmr_lib/margin_hw.h  |  7 ++++
 lmr_lib/margin_log.c | 15 +++++++++
 lmr_lib/margin_log.h |  2 ++
 6 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/lmr_lib/margin.c b/lmr_lib/margin.c
index 41c8fbf..ac20e82 100644
--- a/lmr_lib/margin.c
+++ b/lmr_lib/margin.c
@@ -57,6 +57,26 @@ union margin_cmd margin_make_cmd(uint8_t payload, uint8_t type, uint8_t recvn)
                                       .type = type, .reserved = 0}};
 }
 
+void margin_apply_hw_quirks(struct margin_recv *recv)
+{
+  switch (recv->dev->hw)
+  {
+  case MARGIN_ICE_LAKE:
+  {
+    struct pci_cap *cap = pci_find_cap(recv->dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+    uint8_t dev_type = (pci_read_word(recv->dev->dev, cap->addr + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_TYPE) >> 4;
+    /* Downstream Port - Root Port */
+    if (recv->recvn == 1 && dev_type == 4)
+    {
+      recv->volt_offset = 12;
+    }
+    break;
+  }
+  default:
+    break;
+  }
+}
+
 bool margin_read_params(struct margin_recv *recv)
 {
   union margin_payload resp;
@@ -249,6 +269,7 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
   {
     if (recv->parallel_lanes > recv->max_lanes + 1)
       recv->parallel_lanes = recv->max_lanes + 1;
+    margin_apply_hw_quirks(recv);
 
     results->tim_coef = (double)recv->timing_offset / (double)recv->timing_steps;
     results->volt_coef = (double)recv->volt_offset / (double)recv->volt_steps * 10.0;
@@ -378,6 +399,7 @@ struct margin_results *margin_link(struct margin_dev *down_port, struct margin_d
   uint8_t *receivers = args->recvs;
 
   margin_log_link(down_port, up_port);
+  margin_log_hw_quirks(down_port);
 
   struct margin_results *results = malloc(sizeof(*results) * receivers_n);
   struct margin_recv receiver;
diff --git a/lmr_lib/margin.h b/lmr_lib/margin.h
index 13cfa73..8f3506b 100644
--- a/lmr_lib/margin.h
+++ b/lmr_lib/margin.h
@@ -168,6 +168,8 @@ struct margin_lanes_data {
 
 union margin_cmd margin_make_cmd(uint8_t payload, uint8_t type, uint8_t recvn);
 
+void margin_apply_hw_quirks(struct margin_recv *recv);
+
 /*Read Receiver Lane Margining capabilities.
 dev, recvn and lane_reversal fields must be initialized*/
 bool margin_read_params(struct margin_recv *recv);
diff --git a/lmr_lib/margin_hw.c b/lmr_lib/margin_hw.c
index dcc6593..664f9ed 100644
--- a/lmr_lib/margin_hw.c
+++ b/lmr_lib/margin_hw.c
@@ -4,6 +4,83 @@
 
 #include "margin_hw.h"
 
+union cpuinfo {
+  uint8_t buf[2];
+
+  struct cpu_fields {
+    uint8_t x86_family;
+    uint8_t x86_model;
+  } fields;
+};
+
+enum cpuinfo_field {
+  x86_FAMILY = 0,
+  x86_MODEL = 1
+};
+
+static char *const cpu_field_names[2] = {"cpu family", "model"};
+
+static bool read_cpuinfo(union cpuinfo *cpuinfo)
+{
+  FILE *cpu_file = fopen("/proc/cpuinfo", "r");
+  if (!cpu_file)
+    return false;
+
+  size_t n = 0;
+  char *line = NULL;
+  uint32_t read_fields = 0;
+  uint32_t req_fields = 0;
+  char *line_colon;
+
+  while (getline(&line, &n, cpu_file) > 0 && req_fields == 0)
+  {
+    if (strstr(line, "vendor_id") && strstr(line, "GenuineIntel"))
+    {
+      req_fields = 1 << x86_FAMILY | 1 << x86_MODEL;
+    }
+  }
+
+  rewind(cpu_file);
+  while (getline(&line, &n, cpu_file) > 0 && req_fields != read_fields)
+  {
+    for (uint8_t i = 0; i < sizeof(cpu_field_names) / sizeof(cpu_field_names[0]); i++)
+    {
+      if ((req_fields & (1 << i)) && !(read_fields & (1 << i)) && strstr(line, cpu_field_names[i]))
+      {
+        read_fields |= 1 << i;
+        line_colon = strchr(line, ':');
+        cpuinfo->buf[i] = atoi(line_colon + 1);
+      }
+    }
+  }
+
+  free(line);
+  fclose(cpu_file);
+  if (!req_fields)
+    return false;
+  return req_fields == read_fields;
+}
+
+static enum margin_hw detect_unique_hw(void)
+{
+  union cpuinfo cpuinfo;
+  memset(cpuinfo.buf, 0, sizeof(cpuinfo.buf));
+  if (!read_cpuinfo(&cpuinfo))
+    return MARGIN_HW_DEFAULT;
+
+  uint8_t x86_family = cpuinfo.fields.x86_family;
+  uint8_t x86_model = cpuinfo.fields.x86_model;
+
+  /* Intel Ice Lake */
+  if (x86_family == 6 &&
+      (x86_model == 126 || x86_model == 108 || x86_model == 106))
+  {
+    return MARGIN_ICE_LAKE;
+  }
+
+  return MARGIN_HW_DEFAULT;
+}
+
 bool margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
 {
   struct pci_cap *cap = pci_find_cap(down_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
@@ -43,7 +120,8 @@ struct margin_dev margin_fill_wrapper(struct pci_dev *dev)
       .width = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_WIDTH) >> 4,
       .retimers_n = ((pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER) > 0) +
                     ((pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS) > 0),
-      .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED)};
+      .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED),
+      .hw = detect_unique_hw()};
   return res;
 }
 
diff --git a/lmr_lib/margin_hw.h b/lmr_lib/margin_hw.h
index a436d4b..273cf8e 100644
--- a/lmr_lib/margin_hw.h
+++ b/lmr_lib/margin_hw.h
@@ -6,6 +6,11 @@
 
 #include "../lib/pci.h"
 
+enum margin_hw {
+  MARGIN_HW_DEFAULT,
+  MARGIN_ICE_LAKE
+};
+
 /*PCI Device wrapper for margining functions*/
 struct margin_dev
 {
@@ -15,6 +20,8 @@ struct margin_dev
   uint8_t retimers_n;
   uint8_t link_speed;
 
+  enum margin_hw hw;
+
   /*Saved Device settings to restore after margining*/
   uint16_t aspm;
   uint16_t hasd; /*Hardware Autonomous Speed Disable*/
diff --git a/lmr_lib/margin_log.c b/lmr_lib/margin_log.c
index d32136a..e57bd79 100644
--- a/lmr_lib/margin_log.c
+++ b/lmr_lib/margin_log.c
@@ -113,3 +113,18 @@ void margin_log_margining(struct margin_lanes_data arg)
     fflush(stdout);
   }
 }
+
+void margin_log_hw_quirks(struct margin_dev *dev)
+{
+  switch (dev->hw)
+  {
+  case MARGIN_ICE_LAKE:
+    margin_log("\nRunning on Intel Ice Lake CPU.\n"
+               "Applying next quirks for margining process:\n"
+               "  - Set MaxVoltageOffset of Rx(A) to 12 (120 mV).\n");
+    break;
+
+  default:
+    break;
+  }
+}
diff --git a/lmr_lib/margin_log.h b/lmr_lib/margin_log.h
index c1f89e1..5ad0ade 100644
--- a/lmr_lib/margin_log.h
+++ b/lmr_lib/margin_log.h
@@ -18,4 +18,6 @@ void margin_log_receiver(struct margin_recv *recv);
 
 void margin_log_margining(struct margin_lanes_data arg);
 
+void margin_log_hw_quirks(struct margin_dev *dev);
+
 #endif
-- 
2.34.1


