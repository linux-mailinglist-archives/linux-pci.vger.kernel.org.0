Return-Path: <linux-pci+bounces-7750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B98CC4A1
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1706B1F229B8
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987639AF9;
	Wed, 22 May 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="MdiQlWrr";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="NRqA7QEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0224B2A
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394065; cv=none; b=ewzHc6CuuKItdoTq9buA3bI19Kj7ZcLIC2yCx0tmNDEyiVSqy7FoHoIHb65//v0cml0N9/JaDQ2K7+sYS0RRamGRzRuhHvCGkKaRIqdLSjuq3T02pR0DFkBT77qn9vlxTw8iS1FgRWeumXGb2f9UM8ossziKPJS8p6aQQHeargw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394065; c=relaxed/simple;
	bh=ySpoV1MLUxmI+QYzS6cHiRWO4CpfEvSrKjdbjsqxSn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDMZKF2W/sjERnjQhxIUCyet4at30vsjoea75IKUS5U0tkxbP+JB/wVQRTzVS1sdWtXuZFJqwlWyOMADuMX7jjO0r7XOWCKXKCbcdMfJiG6Yr7gx5O+Xqi+c5Uh/c8rWdz4gh1hNlDr0z5yDrLO2urua3JIDRZQ0ZEPOIntj8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=MdiQlWrr; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=NRqA7QEn; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 076A3C000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394060; bh=cQPL5uc2qmIz+bTbHSCmVXNVrh3as7mPmfeYqjnjq+Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MdiQlWrrg+lU36v12/okt6XcjCr3GKi4+hqXoyxUK4vJDoowV+QUM85yDCJpgqmO7
	 Wu9Y7wd7V+B+n9SRCtd8euhR5JfupKjAV36UK613iMI95gu9FZCIFLvA3WRsZum6Ab
	 b8ZWXryasV0I6tic5xToFWn5JsfIGnrwFeoVCwe9820D3OymH1gAziMXQ9GHjsHon0
	 MgkGyMUI/dJSWy8rXAAV6/Nz6XPhmuUAlZE+C9lEoYKjuAUk8OndWp7vsUnkM6lton
	 Ne3XbYNoAaQ7ZC7H4+CEdvPhbXmCCz1juYpYjjhQqquD6+TDd8UenoLODC3t+8ZOqW
	 f1LkLyaEw0V5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394060; bh=cQPL5uc2qmIz+bTbHSCmVXNVrh3as7mPmfeYqjnjq+Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NRqA7QEnlCotnx9TjhAFuQNNA7srhObMFaamYtjq8XaYSDUgBOo8EzofLyTFeU8Kb
	 UwpCplBStvOudGYZ+5oHXDbumsVfHwwAfZhTZ1buAeyascZ+HbR9GqRfFAd/L2ccPj
	 bs1kHJmkBwp0BgUt1nz7KyrOoT3m8hsvG9M26tCCL9JWQQmyqeJ8l4eJHa4fHwv1lM
	 LrpbcqJDw+8DrjmO07K90C6xUR/yXpIWJsvzLy4qIde6Yo7el7c5kh9h109xuMeOk7
	 QFbr+W1gFx33m6OxWAciFkudxUicL5uZPWU1NIj6DRDf71VLmvZKFNgymRvCCNp1DN
	 HzN5PfzpiO6fg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 4/6] pcilmr: Add option to configure margining dwell time
Date: Wed, 22 May 2024 19:06:32 +0300
Message-ID: <20240522160634.29831-5-n.proshkin@yadro.com>
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

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h         | 4 ++--
 lmr/margin.c      | 5 +++--
 lmr/margin_args.c | 6 +++++-
 lmr/margin_log.c  | 7 ++++---
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index da40bfe..f070309 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -15,8 +15,6 @@
 
 #include "pciutils.h"
 
-#define MARGIN_STEP_MS 1000
-
 enum margin_hw { MARGIN_HW_DEFAULT, MARGIN_ICE_LAKE_RC };
 
 // in ps
@@ -119,6 +117,7 @@ struct margin_com_args {
   u64 steps_utility; // For ETA logging
   bool save_csv;
   char *dir_for_csv;
+  u8 dwell_time;
 };
 
 struct margin_recv_args {
@@ -157,6 +156,7 @@ struct margin_recv {
 
   u8 parallel_lanes;
   u8 error_limit;
+  u8 dwell_time;
 };
 
 struct margin_lanes_data {
diff --git a/lmr/margin.c b/lmr/margin.c
index e2ea300..6ce4fe6 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -260,7 +260,7 @@ margin_test_lanes(struct margin_lanes_data arg)
               pci_write_word(arg.recv->dev->dev, ctrl_addr, step_cmd);
             }
         }
-      msleep(MARGIN_STEP_MS);
+      msleep(arg.recv->dwell_time * 1000);
 
       for (int i = 0; i < arg.lanes_n; i++)
         {
@@ -312,7 +312,8 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_link_args *
                               .lane_reversal = false,
                               .params = &params,
                               .parallel_lanes = args->parallel_lanes ? args->parallel_lanes : 1,
-                              .error_limit = args->common->error_limit };
+                              .error_limit = args->common->error_limit,
+                              .dwell_time = args->common->dwell_time };
 
   results->recvn = recvn;
   results->lanes_n = lanes_n;
diff --git a/lmr/margin_args.c b/lmr/margin_args.c
index 484c58f..8a6345f 100644
--- a/lmr/margin_args.c
+++ b/lmr/margin_args.c
@@ -229,9 +229,10 @@ margin_parse_util_args(struct pci_access *pacc, int argc, char **argv, enum marg
   com_args->steps_utility = 0;
   com_args->dir_for_csv = NULL;
   com_args->save_csv = false;
+  com_args->dwell_time = 1;
 
   int c;
-  while ((c = getopt(argc, argv, "+e:co:")) != -1)
+  while ((c = getopt(argc, argv, "+e:co:d:")) != -1)
     {
       switch (c)
         {
@@ -245,6 +246,9 @@ margin_parse_util_args(struct pci_access *pacc, int argc, char **argv, enum marg
             com_args->dir_for_csv = optarg;
             com_args->save_csv = true;
             break;
+          case 'd':
+            com_args->dwell_time = atoi(optarg);
+            break;
           default:
             die("Invalid arguments\n\n%s", usage);
         }
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index 6fa4f09..88e3594 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -88,7 +88,8 @@ void
 margin_log_receiver(struct margin_recv *recv)
 {
   margin_log("\nError Count Limit = %d\n", recv->error_limit);
-  margin_log("Parallel Lanes: %d\n\n", recv->parallel_lanes);
+  margin_log("Parallel Lanes: %d\n", recv->parallel_lanes);
+  margin_log("Margining dwell time: %d s\n\n", recv->dwell_time);
 
   margin_log_params(recv->params);
 
@@ -143,8 +144,8 @@ margin_log_margining(struct margin_lanes_data arg)
         }
       margin_log("]");
 
-      u64 lane_eta_s = (arg.steps_lane_total - arg.steps_lane_done) * MARGIN_STEP_MS / 1000;
-      u64 total_eta_s = *arg.steps_utility * MARGIN_STEP_MS / 1000 + lane_eta_s;
+      u64 lane_eta_s = (arg.steps_lane_total - arg.steps_lane_done) * arg.recv->dwell_time;
+      u64 total_eta_s = *arg.steps_utility * arg.recv->dwell_time + lane_eta_s;
       margin_log(" - ETA: %3ds Steps: %3d Total ETA: %3dm %2ds", lane_eta_s, arg.steps_lane_done,
                  total_eta_s / 60, total_eta_s % 60);
 
-- 
2.34.1


