Return-Path: <linux-pci+bounces-7751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02D8CC4A2
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AEB1F231DA
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2924B2A;
	Wed, 22 May 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="kwkx4hGY";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="u4PZGmy6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CD1E517
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394067; cv=none; b=Dq2vIUIGNC0tMpdf/DoQ0D0faihCokx4HWgGg4FX9tz5gyn4IpnLKg+Bv0kI6zQhN5ebRLJgNCibme9pRSGuXntv9kuBHoVy2pD7w+xOPoLmKtauWyCFTXkWypsSyLbpAiaQQXlgGuF+9sXg9cOrmRx1EQwIFKWVXqOLvnXbON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394067; c=relaxed/simple;
	bh=YKM5C3gQHacK5KXI471ZcUgV2JuZ+1yMk7r9o+nX24A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4ByfTB3wPIA3JG4T14gy3uOCv1/lABdgbQifoXHzPnCsgqJdOBJ+uy95b9iUuBKGe/be+R3f1+xgFkc8VJ3bx8hoIsrYwa0P31T0ZoMphpK41pg1t7ujN4T2vj4myp9AOi9Ug9egZKNeiDyi4CcJH8Y7Z3Nafal9DYmO93qnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=kwkx4hGY; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=u4PZGmy6; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com C953EC000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394061; bh=PGIQ99wEjMkqv0RbbNWPTiVylEm/fL5ZQZ+EfhP209c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kwkx4hGYWT1fbb009cTAqf9g1v6OPWLxhiL+QWAqbcaZssnf+CcMNxvUTubBSTS4d
	 gg0eOYNWbTIVMaP5frLbBc/bENvOsc987+/Pk4VEgsWmiCluTeRPHMkaU0nJtSIDKs
	 v+fvWqDXmswJlHW27wA1NHK2VFOxllueV0OsSr9sEgLPmtv1yGMtd+m4CL/MLGXYdN
	 NKjKCg068WpuhaGRvrRxJmBEfLpoFajS9/r7gjkmA2GJFFnWipky2tXRBGlw3+59Ig
	 symL1Mw1mVJX7TtXEMa5DIusW1EpvvtFri1gm74SBv+wNMh6SR8o6q3qum3U1rB0xY
	 6RRYJ1n5Y9Ghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394061; bh=PGIQ99wEjMkqv0RbbNWPTiVylEm/fL5ZQZ+EfhP209c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u4PZGmy6ulmJN71Zspsa3kjmLbaJi18VqqEHZltV9hNlicBaxytYRjWNZE70InnTY
	 J5XaKHyYFlbmO0UCU4CjyLk9OWKsHnvh8Vjr/lIide7Vo5oYZDgtsGITxmIile/jhk
	 GABNc4I3oF7SiDH/OIH3aLJY3mw7r/z96r5wX3zqiowps/4YDUKYUk8R3dEPgTARjZ
	 wDgbMD6WFHIVaBzDHfYhvDN/4kuQoNyWbw0S5ln41h71PZYyHScCeSROBxj/E6hS7d
	 f2cUBgjg/UIw90CTSKuMJjjA8hTT2OrE44tfch8f5RmmNEM9RF+Fk3eFs9FF3mVb56
	 breWohyVAZg/A==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 5/6] pcilmr: Apply grading quirk for Ice Lake RC ports
Date: Wed, 22 May 2024 19:06:33 +0300
Message-ID: <20240522160634.29831-6-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522160634.29831-1-n.proshkin@yadro.com>
References: <20240522160634.29831-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Ice Lake RC ports don't support two side independent timing margining,
however the entire margin across the eye is what is reported by one side
margining. Utility already has quirks for Ice Lake RC, so expand them
based on this grading information.

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/margin.c     | 10 +++++++---
 lmr/margin_log.c |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lmr/margin.c b/lmr/margin.c
index 6ce4fe6..d05bb59 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -143,13 +143,17 @@ margin_report_cmd(struct margin_dev *dev, u8 lane, margin_cmd cmd, margin_cmd *r
 }
 
 static void
-margin_apply_hw_quirks(struct margin_recv *recv)
+margin_apply_hw_quirks(struct margin_recv *recv, struct margin_link_args *args)
 {
   switch (recv->dev->hw)
     {
       case MARGIN_ICE_LAKE_RC:
         if (recv->recvn == 1)
-          recv->params->volt_offset = 12;
+          {
+            recv->params->volt_offset = 12;
+            args->recv_args[recv->recvn - 1].t.one_side_is_whole = true;
+            args->recv_args[recv->recvn - 1].t.valid = true;
+          }
         break;
       default:
         break;
@@ -341,7 +345,7 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_link_args *
 
   if (recv.parallel_lanes > params.max_lanes + 1)
     recv.parallel_lanes = params.max_lanes + 1;
-  margin_apply_hw_quirks(&recv);
+  margin_apply_hw_quirks(&recv, args);
   margin_log_hw_quirks(&recv);
 
   results->tim_off_reported = params.timing_offset != 0;
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index 88e3594..60c135d 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -162,7 +162,8 @@ margin_log_hw_quirks(struct margin_recv *recv)
         if (recv->recvn == 1)
           margin_log("\nRx(A) is Intel Ice Lake RC port.\n"
                      "Applying next quirks for margining process:\n"
-                     "  - Set MaxVoltageOffset to 12 (120 mV).\n");
+                     "  - Set MaxVoltageOffset to 12 (120 mV);\n"
+                     "  - Force the use of 'one side is the whole' grading mode.\n");
         break;
       default:
         break;
-- 
2.34.1


