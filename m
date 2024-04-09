Return-Path: <linux-pci+bounces-5917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B753689D33C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 09:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87CC1C20BF4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328017C0A6;
	Tue,  9 Apr 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hd9g7OVz"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57A7BB11;
	Tue,  9 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648011; cv=none; b=bLCp9y6gcqKY57h9cLxakeRG+MW5PlbdMqH9+cIkgrGtmAvb4ihAqSkKZtelXT8E8hXTnljULNsrY5EfFDkSSTZ2smqY+obYEKqyqb5Qy89hauTH/zxPlFmBZIt66JEX4La5YkeMvfBjMrzJQYaI+BqnNLCgBfXpILMRbfFXh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648011; c=relaxed/simple;
	bh=qp+YgUH3bz+WFmudL3wOvXuBwp14NHmw9plnq6kfLYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy+SRaaOLqWxwhz1zVHefyca+q7RxIdA+Mr+ezSYPzPZrSmW6iRAKjDrJAl/3bYF1dDkC4zWzjVqv0vlmYuJnCWnrrDFsiAuxM67AMV3Ks9CETBiftyEQ0JutbaB4s64I7Fl/D6wAR1ZlyejF3Yl2j5g9+KWRugQBCNZwgAHLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hd9g7OVz; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712648009; x=1744184009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qp+YgUH3bz+WFmudL3wOvXuBwp14NHmw9plnq6kfLYg=;
  b=hd9g7OVzCa7LT2r5GU5zz16SIRlW5GgKDjll/DxyC0Jlvi7KWPHjHLSb
   3Rj8Lr8CWH8S1CiqANzQWoxCDXosnKeNGYIq95UA7xuAF/ydvCdT1jVbQ
   UejGMkTUFXAudEMob8+DEQ2JWDX7/WPGnlByMeJqeoRc99iAe7JFENABP
   aavB3Clmab1GUtpD4NsURco2LmCWE70pnphqgxkXCdLe1HKrsWMh14r6q
   gVJCYECk4ZVNyozUk3AonSWJUTp8K9I1+3w0lsn+/SS7e4oI12pHxqLG+
   +Zi8/Tev0tkULlh3cIsrZWX34PDRoAaH4FdTuysgkmSc1ZoCXa2CU2mPY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="154907598"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="154907598"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:33:22 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D7EA8CA142;
	Tue,  9 Apr 2024 16:33:19 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A1B6D595C;
	Tue,  9 Apr 2024 16:33:19 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id E77DE204E19D;
	Tue,  9 Apr 2024 16:33:18 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v4 1/3] cxl: Add rcd_regs to cxl_rcrb_info
Date: Tue,  9 Apr 2024 16:35:26 +0900
Message-ID: <20240409073528.13214-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add rcd regs to cxl_rcrb_info to cache the RCD register values.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/cxl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..2dc827c301a1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -647,6 +647,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 struct cxl_rcrb_info {
 	resource_size_t base;
 	u16 aer_cap;
+	u16 rcd_lnkctrl;
+	u16 rcd_lnkstatus;
+	u32 rcd_lnkcap;
 };
 
 /**
-- 
2.44.0


