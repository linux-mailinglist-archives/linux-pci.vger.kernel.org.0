Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39B923A903
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHCO6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCO6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 10:58:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E54C06174A
        for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2020 07:58:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so19956418lfp.7
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2020 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhuLmZgbXF6UviT0thYxz63WeieI6lZvebd1OppgB0g=;
        b=VAe48WBcJeOeHJaSh1IikTGaw3+Zo2qrBZdn/Fk+xQFZe8OPdN7PcdC8KKzwRr9Lnw
         r5PnOgVGpEmhBKe67mSgffF6ZXWr17Q6VhPQUuKub78ExjPKSMumeXCjDEJMIcXuw1z7
         Fd2M1LGBAKHIw2q6cJVLAVzAZUY1rEf286NwtAKilVpHeuX4tSBFOKmeKcIDvr4S5qWH
         YFZRMewKBjNq7oD6OK6mzQr8/HcC3gy8xfK++gMBFs4ogtXCtYyi17U0oW6h0J08jshK
         t275HSkZTfRYN+BoHuRBAWa/+cSV2HU/tNeZrB8FIhDmIlniYVBdyevmtbKbbcbnx24J
         ZBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhuLmZgbXF6UviT0thYxz63WeieI6lZvebd1OppgB0g=;
        b=cLl6+bwxZoMUo2XRxivaMc7UtrwYFZyAFHwA94vqi9EdiUgRDCteLuKnniX73UBrRD
         Svkz+C0e8UnvKYLw2BWjCG84IXay9K+Fnr3Gwm7UDWLN6APaxhkcejkX6D/O4uLpr/HI
         PJzZwcTbxEtN1uOdxnZ5WdlgKyXBUZrgfNWPscGGgwiMNTT6grB42NsS7ZRjHxtsTuie
         p8awalF1eTQzr18MkAkNG7Z3MQ6J1FJvHPQAuiBwMNUCwoej2kiUv4NGcV24U5R7oyFD
         fXzwn5RskIVbTuVYAxf8gD8q42IcESLxtALM19eEQQnHkSwpjq/9h+ASPA1MokBkHFW3
         qL+Q==
X-Gm-Message-State: AOAM531Ag8zdFnBCZ7sZMBayqfUATvLhBN/wztOGttclcQT6x4QhczPI
        SP/xpA8FnskpmMCAu22Qii5V8nG0w5CKVw==
X-Google-Smtp-Source: ABdhPJyTfNYVjU4rs9LmlDJofsNSc4bMSR0JpLsqjth3U2gAS7IZuHZBxxmTh4VhNmBc17X/lP09MQ==
X-Received: by 2002:a19:8015:: with SMTP id b21mr8469561lfd.206.1596466724032;
        Mon, 03 Aug 2020 07:58:44 -0700 (PDT)
Received: from octa.pomac.com (c-f0d2225c.013-195-6c756e10.bbcust.telenor.se. [92.34.210.240])
        by smtp.gmail.com with ESMTPSA id y16sm4313133ljg.21.2020.08.03.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:58:43 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     linux-pci@vger.kernel.org, helgaas@kernel.org
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Date:   Mon,  3 Aug 2020 16:58:32 +0200
Message-Id: <20200803145832.11234-1-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200729222758.GA1963264@bjorn-Precision-5520>
References: <20200729222758.GA1963264@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
* Handle L0s correclty as well, making it per direction
* Moved the switch cost in to the if statement since a non L1 switch has
  no additional cost.

For L0s:
We sumarize the entire latency per direction to see if it's acceptable
for the PCIe endpoint.

If it's not, we clear the link for the path that had too large latency.

For L1:
Currently we check the maximum latency of upstream and downstream
per link, not the maximum for the path

This would work if all links have the same latency, but:
endpoint -> c -> b -> a -> root  (in the order we walk the path)

If c or b has the higest latency, it will not register

Fix this by maintaining the maximum latency value for the path

This change fixes a regression introduced (but not caused) by:
66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
---
 drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..bc512e217258 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
+		l0s_latency_up = 0, l0s_latency_dw = 0;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
 
 	while (link) {
-		/* Check upstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-		    (link->latency_up.l0s > acceptable->l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
-
-		/* Check downstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-		    (link->latency_dw.l0s > acceptable->l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+		if (link->aspm_capable & ASPM_STATE_L0S) {
+			/* Check upstream direction L0s latency */
+			if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+				l0s_latency_up += link->latency_up.l0s;
+				if (l0s_latency_up > acceptable->l0s)
+					link->aspm_capable &= ~ASPM_STATE_L0S_UP;
+			}
+
+			/* Check downstream direction L0s latency */
+			if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+				l0s_latency_dw += link->latency_dw.l0s;
+				if (l0s_latency_dw > acceptable->l0s)
+					link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+			}
+		}
+
 		/*
 		 * Check L1 latency.
 		 * Every switch on the path to root complex need 1
@@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * L1 exit latencies advertised by a device include L1
 		 * substate latencies (and hence do not do any check).
 		 */
-		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
-		if ((link->aspm_capable & ASPM_STATE_L1) &&
-		    (latency + l1_switch_latency > acceptable->l1))
-			link->aspm_capable &= ~ASPM_STATE_L1;
-		l1_switch_latency += 1000;
+		if (link->aspm_capable & ASPM_STATE_L1) {
+			latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+			l1_max_latency = max_t(u32, latency, l1_max_latency);
+			if (l1_max_latency + l1_switch_latency > acceptable->l1)
+				link->aspm_capable &= ~ASPM_STATE_L1;
+
+			l1_switch_latency += 1000;
+		}
 
 		link = link->parent;
 	}
-- 
2.28.0

