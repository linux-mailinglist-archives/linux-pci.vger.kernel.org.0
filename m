Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0C21BFA8
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGJWUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgGJWUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:20:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABDC08C5DC;
        Fri, 10 Jul 2020 15:20:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so7582455wme.5;
        Fri, 10 Jul 2020 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9beKaVLBUAv2GkNWPso7Jo1sgUnYoNc43mKbz9aG4JE=;
        b=V+ktR0g5nmWzPHnEburi8Ox+p9ZismGnFac6ev3M/D6f9aFDUBsfwCp1T1QDWpmHlP
         Z/Xl0iU1MpoZ2rUgQMQSqUezYo+oZZqpTyOHWDtnXrkj8Ydsx38jxAYBT0duw/uH3Qva
         CPO0KpUoBO0D+7tdrIddSZJdVKXRB8YIivOZBQGQzCvob9bIkUKRAAuOjAXkhMcIeByo
         PC/U01RPp5qsWR45L7R2rAxAMR5ogxmOqtdtNYWfTSgUaaPmI/Lu+qv7gkI8El2iyJtD
         9+e2RL6i59GRhaX7EOB/5Upli1fbFv6+NNfPI9nqeXWEXr1IrBw17Eiro7dOYwanqMy8
         4hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9beKaVLBUAv2GkNWPso7Jo1sgUnYoNc43mKbz9aG4JE=;
        b=ewMu4SwomG4XvUeKCoKUSKryVhpiAYk+2oGBKcryLvWi6OCwwXHrb0g+aUsjLm5iHS
         ymheAe/oMJprhwmtqmaky0xOZdXKN3/zbmku1PlyZJCbohUvulyAQ+lh0+mtK0/NV44s
         4QoFGL8m0LD+5/XME6ePpcjyqONvG397lO6Q2ofEWjoSm8yTdbZWnw+tBTwVhKLZOmJk
         MI81tAwG0993jQwMq4CbEJXwhrF+1+D2fg56ypUeSl/x6D49Qzjkqv7PA3DjSt66QEFO
         njBLybDWTKJ1C7/Azszk7g34Ut0ZbRdvYSwmUcI+ETvr7NRmrLJ13TC1lATRFBkE3aMN
         KVfQ==
X-Gm-Message-State: AOAM530hAfASELBbsCZ2zHrJ3pCfqHac4qLP2GBzB1AVDHEFvQBbNkYp
        I49mtuuBRggEBkKcuysiNBHqcKvTsnippA==
X-Google-Smtp-Source: ABdhPJya776BQ7eTEUkYXuIJxLe0w2DKQXM0/eH13WiSIo6NquF35aXbWVwW1ITUhwemsH0Nd+vv4A==
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr7611314wmh.49.1594419620087;
        Fri, 10 Jul 2020 15:20:20 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:19 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14 v3] PCI: Check return value of pcie_capability_read_*()
Date:   Fri, 10 Jul 2020 23:20:22 +0200
Message-Id: <20200710212026.27136-11-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/probe.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea25..3c87a8a1d4b5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1121,10 +1121,11 @@ EXPORT_SYMBOL(pci_add_new_bus);
 static void pci_enable_crs(struct pci_dev *pdev)
 {
 	u16 root_cap = 0;
+	int ret;
 
 	/* Enable CRS Software Visibility if supported */
-	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
+	ret = pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
+	if (!ret && (root_cap & PCI_EXP_RTCAP_CRSVIS))
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_CRSSVE);
 }
@@ -1519,9 +1520,10 @@ void set_pcie_port_type(struct pci_dev *pdev)
 void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 {
 	u32 reg32;
+	int ret;
 
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
-	if (reg32 & PCI_EXP_SLTCAP_HPC)
+	ret = pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
+	if (!ret && (reg32 & PCI_EXP_SLTCAP_HPC))
 		pdev->is_hotplug_bridge = 1;
 }
 
@@ -2057,10 +2059,11 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 bool pcie_relaxed_ordering_enabled(struct pci_dev *dev)
 {
 	u16 v;
+	int ret;
 
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
 
-	return !!(v & PCI_EXP_DEVCTL_RELAX_EN);
+	return (!ret && !!(v & PCI_EXP_DEVCTL_RELAX_EN));
 }
 EXPORT_SYMBOL(pcie_relaxed_ordering_enabled);
 
@@ -2096,16 +2099,17 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct pci_dev *bridge;
 	u32 cap, ctl;
+	int ret;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret || !(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
-	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
+	if (!ret && (ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
 			dev->ltr_path = 1;
 			return;
@@ -2142,12 +2146,13 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int pcie_type;
 	u32 cap;
+	int ret;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret || !(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
 		return;
 
 	pcie_type = pci_pcie_type(dev);
-- 
2.18.2

