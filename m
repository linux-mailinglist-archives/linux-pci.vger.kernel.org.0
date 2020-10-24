Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2D297E8D
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764537AbgJXUz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Oct 2020 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764536AbgJXUz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Oct 2020 16:55:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA7C0613CE
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:55:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h20so5480046lji.9
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2020 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hyL9oNr8H/MDAXfwjeewU2xEG5E9TY5x+M8oCEvG88=;
        b=mUSZaQybR6UIq1VitNgzkASF++k0yN3aMCELYEDG+w45aggzWT+woJS3NjR+bk0+bl
         E9bXnbbUieWNBL7lVNNYxjmDpQ+JQUXcXOJYzbOh+O6GoYpx+VgDjv8eC/Jr2B2bdwTI
         vJt3XLS4Uw4XL3uxZsp6X/iDvoETYWEyK6uDfFaCWdujf4LD2Dwspmr1UXNH4jDyvETs
         ljI5OWerrGdlL1/8HAj7JZxESchMHafIrdBiVRnv5L15S5oJFOYxao09Orz3GmJ+OV1T
         wUqNuadCtjGRtun27AVDG9AAjJ88mhy/+cilpJUwOVf0QaaPZFjK1w5SBAqzyIWVXOfD
         e9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hyL9oNr8H/MDAXfwjeewU2xEG5E9TY5x+M8oCEvG88=;
        b=NfDYuQ46UWPpvfJ7h10C8I1hxDNbAxcz6a/L6NFiV/WqTFvQMfKz4tb07RbIAVSRPg
         8TD0/p+JjiPeN4tXYXC6joP4aRNpSUlGV0pC5Z4EHJeUMtfWsL1ADPD/hkJbYKXgtSuH
         dbajQho6qVGnA6t7bd76LQOk2jzCYn4kbXKA4bHP6BNQcML6RqWAXf2wNDld6wAjMU0R
         N+PJkDtlHXLixkfvxROppsU5hSuqzITW1wbTkc6oSxByLZ3smHYRKncH0C0OblhEnawi
         7U4lAlYdtntuBIsDx02DJj/nJcsXBr6YWvsHvvUQh8f/mAPShsl+dQuoFJOiHm0kzkbj
         Zecg==
X-Gm-Message-State: AOAM530YFHwYIqdvYNhQIWW53fH/A8gJaa/ENaM+TOPPXwZ3YEgLiSiW
        F+Wu/h2Vwn0PGhYAzAJma3g=
X-Google-Smtp-Source: ABdhPJzmtA7uXURgTxQlKNKVHborymXpt50XD4X7vRXsetRjIMPeiZcCZ+c+czDztfgPlirB4pgLeQ==
X-Received: by 2002:a2e:8184:: with SMTP id e4mr3234602ljg.383.1603572954207;
        Sat, 24 Oct 2020 13:55:54 -0700 (PDT)
Received: from octa.pomac.com (c-f9c8225c.013-195-6c756e10.bbcust.telenor.se. [92.34.200.249])
        by smtp.gmail.com with ESMTPSA id f26sm246815lfc.302.2020.10.24.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 13:55:53 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
        alexander.duyck@gmail.com, refactormyself@gmail.com,
        puranjay12@gmail.com
Cc:     Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
Date:   Sat, 24 Oct 2020 22:55:46 +0200
Message-Id: <20201024205548.1837770-1-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201022183030.GA513862@bjorn-Precision-5520>
References: <20201022183030.GA513862@bjorn-Precision-5520>
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
03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)

            Exit latency       Acceptable latency
Tree:       L1       L0s       L1       L0s
----------  -------  -----     -------  ------
00:01.2     <32 us   -
| 01:00.0   <32 us   -
|- 02:03.0  <32 us   -
| \03:00.0  <16 us   <2us      <64 us   <512ns
|
\- 02:04.0  <32 us   -
  \04:00.0  <64 us   unlimited <64 us   <512ns

04:00.0's latency is the same as the maximum it allows so as we walk the path
the first switchs startup latency will pass the acceptable latency limit
for the link, and as a side-effect it fixes my issues with 03:00.0.

Without this patch, 03:00.0 misbehaves and only gives me ~40 mbit/s over
links with 6 or more hops. With this patch I'm back to a maximum of ~933
mbit/s.

The original code path did:
04:00:0-02:04.0 max latency 64    -> ok
02:04.0-01:00.0 max latency 32 +1 -> ok
01:00.0-00:01.2 max latency 32 +2 -> ok

And thus didn't see any L1 ASPM latency issues.

The new code does:
04:00:0-02:04.0 max latency 64    -> ok
02:04.0-01:00.0 max latency 64 +1 -> latency exceeded
01:00.0-00:01.2 max latency 64 +2 -> latency exceeded

It correctly identifies the issue.

For reference, pcie information:
https://bugzilla.kernel.org/show_bug.cgi?id=209725

Kai-Heng Feng has a machine that will not boot with ASPM without this patch,
information is documented here:
https://bugzilla.kernel.org/show_bug.cgi?id=209671

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..c03ead0f1013 100644
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
@@ -469,11 +473,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
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
+			l1_switch_latency += 1000;
+		}
 
 		link = link->parent;
 	}
-- 
2.29.1

