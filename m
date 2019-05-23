Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1C28CBA
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfEWVz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 17:55:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36492 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWVzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:55:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so3824344pgb.3
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PurhQGxmOt5OgX95ziE8Uz5xXLYO1YnGDYcH4NyaAV8=;
        b=KmwMdbusxLFDrj22KnPcx5BKzA583dV/GrebLLNnmUsihWE/QMWs3lTIAouKLUwaop
         LwgmVJQGVUg2aA+8mx4KJjU7bAF7LtGSr8FiMglX9PLU180cgIynnL0/9TXMA3mSW1M+
         /UmO8YBNF1bNKg2+C2Nb60imYJGTKVl+XkH4yQ6Fxqbenfjbl/IPPANZqo6DAu95G16f
         3MfFyVw8gm66EwDQbIfgC6fEkCdxWH+Uwd6/EWrWkuO+20grvDS8y/Fis3sO7q93IPon
         ggEp6LFhzmrCxLh6InSejc0sfAGzRbxlvvT1/+7Z6b9W8sM4GU4RF8/D8lGBbGXY4321
         unfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PurhQGxmOt5OgX95ziE8Uz5xXLYO1YnGDYcH4NyaAV8=;
        b=E7x4moX63t+vINzxabx0XIT8hW1HuiJ3imDSYJnoHutwOaRbEboAN4LCPGf6AKqzCJ
         nUS++wQArW6Rz63/BFOCupA+q7GFwtVhp7zTuzFWe4rpuPtPp+qFu8y2to4h+smSf/+P
         f5ixO92L/AV5e2k28WjKG3GdkyBA6TjoKQItq+DaOvRpKnEVooO66JcYscWFgkdjMkVK
         VtSdZBYPB2rFhtEv6Bsc2b/jObcpmxkqbhHV+YXoMx03+RGJXmmuSVyxu7JGNKO7fHOf
         JklZStnwr3o/tAM+rhmCAsnoarjKuqbEDcRVCUTUL089ZlezbHuXwnG/2rg3o/XgAZ24
         P2QQ==
X-Gm-Message-State: APjAAAVGgfIF6XU71Ral4hvGzWvzInuNYr6mq1vwVgY7/XX1GeNZC4DX
        caxY5zPca4Y3zCa0vVUrVRJbZ+IZpBg=
X-Google-Smtp-Source: APXvYqxfZfJf2dgCCL/DsR8P6LzvbOxJ1paNuXirPE+CZvt+G3bi+/s0Wd3kQSCpvTmI4e02K3NZLg==
X-Received: by 2002:a63:903:: with SMTP id 3mr86725371pgj.400.1558648553134;
        Thu, 23 May 2019 14:55:53 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id q75sm422403pfa.175.2019.05.23.14.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:55:52 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
Date:   Thu, 23 May 2019 14:55:40 -0700
Message-Id: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Always skip odd bar when skipping 64bit BARs in pci_epf_test_set_bar()
and pci_epf_test_alloc_space().

Otherwise, pci_epf_test_set_bar() will call pci_epc_set_bar() on odd loop
index when skipping reserved 64bit BAR. Moreover, pci_epf_test_alloc_space()
will call pci_epf_alloc_space() on bind for odd loop index when BAR is 64bit
but leaks on subsequent unbind by not calling pci_epf_free_space().

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..96156a537922 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
-	int bar;
+	int bar, add;
 	int ret;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc = epf->epc;
@@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		/*
+		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
+		 * if the specific implementation required a 64-bit BAR,
+		 * even if we only requested a 32-bit BAR.
+		 */
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
@@ -413,13 +419,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 			if (bar == test_reg_bar)
 				return ret;
 		}
-		/*
-		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
-		 * if the specific implementation required a 64-bit BAR,
-		 * even if we only requested a 32-bit BAR.
-		 */
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
@@ -431,7 +430,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_bar *epf_bar;
 	void *base;
-	int bar;
+	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
 
@@ -445,8 +444,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+
 		if (bar == test_reg_bar)
 			continue;
 
@@ -459,8 +460,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
-- 
2.7.4

