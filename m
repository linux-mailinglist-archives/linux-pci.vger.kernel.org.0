Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC730286013
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJGN2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGN2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 09:28:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8CC061755
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 06:28:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a23so1186557ljp.5
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mq2vXogLrE4mrcxtzJAiV6BR/XBBtnAndUYq1j5CMTQ=;
        b=GpCzORY6FCZ9lOByDZu2xbXmEplNJvEfaafmUeUbL9NRXZN8YvsEwqVmDJpNfneb8M
         P/9bN4KtiHY/LYzD4qvCMxrMpCgqwSvax2R5G8O/uC0aw6EYSkZ5fis58PBijPNvzXpk
         NeV9Ma2SPRrxVM9X2GWInpJ/8b9OGbIC3a/UkgZkdHjIFIn90bIziMO3T5U9A2sPrlUw
         Zd2K9i1CTYeGjjpFUKwWugp/kyJgP43/1lkNH1Z6Ux5wz7/gbu3QzmrGdhwKvv5VIcdg
         t02PIVQ0XTXo/3kBqJcH3LhUPxdPy5gyPZY8l2XblyZMH0XNLBhGRazMnFAHBguRUXpr
         +W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mq2vXogLrE4mrcxtzJAiV6BR/XBBtnAndUYq1j5CMTQ=;
        b=hCgbw2PkXj2LiNsZvHE7SsOu/cSREOhmbvRo6wSzPTaDKeS2kgbtyLMhissgIgmDlu
         I5UHrP2h4/wtBgQUtrFJTLmnrJFouOm94IW067VcXiJCumb+6wej6PG1j/6Cwy/t4CFs
         DzLGI8tbncrAQjW3NdShqsEkQ5erz5JDBrB8kewX3rUGrgq9mvGzcmXECPX/3zo7RN0W
         TMfHEhAP5kFG4/gf7vo8dI9nOvFb2dy0DIESs3XraFsbuL+iIoVAtZvm4KQKts4xRUiu
         eFHWldFROORAVrZ0VsdjZ7bsN8GzpXTFpeRV7//a33bLiZke+7Y/eFmgr8G2LHY5zlG7
         mebw==
X-Gm-Message-State: AOAM5307fJDiQwRJVoY2rPdB4DViVSlOoywxg3jQyC8Y7VOggJY5yW0V
        vl+JQ0sgqRlgdfqEU8JuM2g=
X-Google-Smtp-Source: ABdhPJy7grSE80xKPlk8M9kbB9ITdxA91p6krxiYZ9WjC68v6JlMtLvop+FEYO+cxTuR+b7BQI0+Aw==
X-Received: by 2002:a2e:9ed5:: with SMTP id h21mr1102600ljk.178.1602077297330;
        Wed, 07 Oct 2020 06:28:17 -0700 (PDT)
Received: from octa.pomac.com (c-f0d2225c.013-195-6c756e10.bbcust.telenor.se. [92.34.210.240])
        by smtp.gmail.com with ESMTPSA id 21sm330263lfk.206.2020.10.07.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:28:16 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com, kai.heng.feng@canonical.com
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH] Use maximum latency when determining L1 ASPM
Date:   Wed,  7 Oct 2020 15:28:08 +0200
Message-Id: <20201007132808.647589-1-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
"5.4.1.2.2. Exit from the L1 State"

Which makes it clear that each switch is required to initiate a
transition within 1μs from receiving it, accumulating this latency and
then we have to wait for the slowest link along the path before
entering L0 state from L1.

The current code doesn't take the maximum latency into account.

From the example:
   +----------------+
   |                |
   |  Root complex  |
   |                |
   |    +-----+     |
   |    |32 μs|     |
   +----------------+
           |
           |  Link 1
           |
   +----------------+
   |     |8 μs|     |
   |     +----+     |
   |    Switch A    |
   |     +----+     |
   |     |8 μs|     |
   +----------------+
           |
           |  Link 2
           |
   +----------------+
   |    |32 μs|     |
   |    +-----+     |
   |    Switch B    |
   |    +-----+     |
   |    |32 μs|     |
   +----------------+
           |
           |  Link 3
           |
   +----------------+
   |     |8μs|      |
   |     +---+      |
   |   Endpoint C   |
   |                |
   |                |
   +----------------+

Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
transition to L0 at time T. Since switch B takes 32 μs to exit L1 on
it's ports, Link 3 will transition to L0 at T+32 (longest time
considering T+8 for endpoint C and T+32 for switch B).

Switch B is required to initiate a transition from the L1 state on it's
upstream port after no more than 1 μs from the beginning of the
transition from L1 state on the downstream port. Therefore, transition from
L1 to L0 will begin on link 2 at T+1, this will cascade up the path.

The path will exit L1 at T+34.

On my specific system:
lspci -PP -s 04:00.0
00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)

lspci -vvv -s 04:00.0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
...
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
...

Which means that it can't be followed by any switch that is in L1 state.

This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.

                                                    LnkCtl    LnkCtl
           ------DevCap-------  ----LnkCap-------  -Before-  -After--
  00:01.2                                L1 <32us       L1+       L1-
  01:00.0                                L1 <32us       L1+       L1-
  02:04.0                                L1 <32us       L1+       L1-
  04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
---
 drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..893b37669087 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, l1_switch_latency = 0;
+	u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
 		    (link->latency_dw.l0s > acceptable->l0s))
 			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+
 		/*
 		 * Check L1 latency.
-		 * Every switch on the path to root complex need 1
-		 * more microsecond for L1. Spec doesn't mention L0s.
+		 *
+		 * PCIe r5.0, sec 5.4.1.2.2 states:
+		 * A Switch is required to initiate an L1 exit transition on its
+		 * Upstream Port Link after no more than 1 μs from the beginning of an
+		 * L1 exit transition on any of its Downstream Port Links.
 		 *
 		 * The exit latencies for L1 substates are not advertised
 		 * by a device.  Since the spec also doesn't mention a way
@@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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

