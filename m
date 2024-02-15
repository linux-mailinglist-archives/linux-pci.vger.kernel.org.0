Return-Path: <linux-pci+bounces-3488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74817856211
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F00B2ABB5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB5112B171;
	Thu, 15 Feb 2024 11:47:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77269DFE;
	Thu, 15 Feb 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997634; cv=none; b=qIY+uOhc9wZEA7NKjxf+0JxcLSUPFuVxL0Fi5A+avrqRLWL6AV4w10E4cGDhHcQOYeJAt0Vaxav5ZbQpcR/QwMGt+LYo36btc613uUPPi53n3TXOCmCuRtaoosjM+OLp3B9eRUk3CtHfze/5iRuopYCFdQG9FufA57dATqyLiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997634; c=relaxed/simple;
	bh=qmEIDhh+bnqXC1NcVizQoxS1/hB36pLfas5EtEagmNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDQzR42smnVrwt7yfzzx0UICiH0RGYah0+Ty3zvSXj/YgU+q9d1e8P6q+MTRORgO4OKg0ykJ9/SjqTh2YvT0WY2eAxoGJlZyQIA8Eks4HsGq+dkWdrR523L2oGm0WIX3KYIUiinn9JMgTgzyi+ZdoRnr7wl1u7NZJK4hHWBi2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCrF6tczz6K7F5;
	Thu, 15 Feb 2024 19:43:41 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B17D140D26;
	Thu, 15 Feb 2024 19:47:09 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:47:08 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <mchehab@kernel.org>
CC: <qingshun.wang@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 2/2] rasdaemon: ras-mc-ctl: Add support for new fields in aer_event for  advisory non-fatal and other errors
Date: Thu, 15 Feb 2024 19:46:59 +0800
Message-ID: <20240215114659.1513-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215114659.1513-1-shiju.jose@huawei.com>
References: <20240215114659.1513-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for following new fields added in trace aer_event
for advisory non-fatal and other errors.

  - cor_status		(Correctable Error Status)
  - cor_mask		(Correctable Error Mask)
  - uncor_status	(Uncorrectable Error Status)
  - uncor_severity	(Uncorrectable Error Severity)
  - uncor_mask		(Uncorrectable Error Mask)
  - aer_cap_ctrl	(AER Capabilities and Control)
  - link_status		(Link Status)
  - device_status	(Device Status)
  - device_control_2	(Device Control 2)

https://lore.kernel.org/lkml/20240125062802.50819-5-qingshun.wang@linux.intel.com/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index a7ece13..e5ee040 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1750,12 +1750,13 @@ sub errors
     my ($dev, $sector, $nr_sector, $error, $rwbs, $cmd);
     my ($error_count, $affinity, $mpidr, $r_state, $psci_state);
     my ($pfn, $page_type, $action_result);
+    my ($cor_status, $cor_mask, $uncor_status, $uncor_mask, $uncor_severity, $cap_control, $first_err_pointer, $link_status, $device_status, $device_control_2);
     my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
     my ($log_type, $first_ts, $last_ts);
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
     my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
-    my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
+    my ($nibble_mask, $bank_group, $row, $column);
     my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
@@ -1782,13 +1783,23 @@ sub errors
 
     # PCIe AER aer_event errors
     if ($has_aer == 1) {
-        $query = "select id, timestamp, dev_name, err_type, err_msg from aer_event$conf{opt}{since} order by id";
+        $query = "select id, timestamp, dev_name, err_type, err_msg, cor_status, cor_mask, uncor_status, uncor_mask, uncor_severity, cap_control, first_err_pointer, link_status, device_status, device_control_2 from aer_event$conf{opt}{since} order by id";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
-        $query_handle->bind_columns(\($id, $time, $devname, $type, $msg));
+        $query_handle->bind_columns(\($id, $time, $devname, $type, $msg, $cor_status, $cor_mask, $uncor_status, $uncor_mask, $uncor_severity, $cap_control, $first_err_pointer, $link_status, $device_status, $device_control_2));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id $time $devname $type error: $msg\n";
+            $out .= "$id $time $devname $type error: $msg ";
+            $out .= sprintf "cor_status=0x%08x ", $cor_status if (defined $cor_status && length $cor_status);
+            $out .= sprintf "cor_mask=0x%08x ", $cor_mask if (defined $cor_mask && length $cor_mask);
+            $out .= sprintf "uncor_status=0x%08x ", $uncor_status if (defined $uncor_status && length $uncor_status);
+            $out .= sprintf "uncor_mask=0x%08x ", $uncor_mask if (defined $uncor_mask && length $uncor_mask);
+            $out .= sprintf "uncor_severity=0x%08x ", $uncor_severity if (defined $uncor_severity && length $uncor_severity);
+            $out .= sprintf "cap_control=0x%08x ", $cap_control if (defined $cap_control && length $cap_control);
+            $out .= sprintf "first_error_pointer=0x%x ", $first_err_pointer if (defined $first_err_pointer && length $first_err_pointer);
+            $out .= sprintf "link_status=0x%04x ", $link_status if (defined $link_status && length $link_status);
+            $out .= sprintf "device_status=0x%04x ", $device_status if (defined $device_status && length $device_status);
+            $out .= sprintf "device_control_2=0x%04x", $device_control_2 if (defined $device_control_2 && length $device_control_2);
         }
         if ($out ne "") {
             print "PCIe AER events:\n$out\n";
-- 
2.34.1


