Return-Path: <linux-pci+bounces-4086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A0B868AC6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E11C21B80
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843C6BB36;
	Tue, 27 Feb 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OWbolQ+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEE6A351;
	Tue, 27 Feb 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022655; cv=none; b=ItePaQrYqyuGP5vsA3G7zCgY01bf6EnBUYY2K8r7RjMCTcftwQBMd8NeZRToPjtgYfvlB05byqaTsMt7ZnIQhO0exTKkaMzC6R4tGhqO8f5KbmeIz7duVEIc9XnyEYOWM3DjOwDrDjBwNiI5REtw4lt9dfI+zRp58nnS9myn2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022655; c=relaxed/simple;
	bh=bPSnlvhM/EbpGy25SiekuNdcEivAYfCgLjkCyRbM4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc6wxDvks8oy/ag0Q13HXX709hl9bT9XayO8HlvVKsX5PEEtS6N+Xw4qPix5yfVlLGG8BNTFZQWAB8M+KIpEXW8tdeT6boBQrf+Rdl7rwjVdnAdUPNJ3p3QLxDzeKOgktiN7g0xFjJ381/LRJnrbw0o26ugTwQapxi4rP8WG2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OWbolQ+t; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709022654; x=1740558654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPSnlvhM/EbpGy25SiekuNdcEivAYfCgLjkCyRbM4L0=;
  b=OWbolQ+t7u+b26T4rACTD+0y6ISZMpvhNwCfcZq9+9hEEEPGOspB6Z/p
   dgPMSEWoF9XKVx7uDlwsNO1WDeEIQSPEzJkSW8YDCGBqIEMWuSASYSyKx
   TO0BRCfLRDWdiduehQhFinUTYyM+UmBuY6PJ/y6aBeKnGXQUiBjhQOXFE
   3s41Yrwg7sjiV1aCBYYTx7TnQN50S7TDZ3DTmqKsq5fRf2GVYJMQOY4Hh
   u2wdr/v1RAymvWrukmH/FSmYUJkgPoTUUeCtjXCbiBAkbmi77E+V/6Ebj
   ePODYawuO+w/2I6xK9rdlhv4yxG3l2R2nsHs5/baOOqy9fEDO9vGJMC15
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="150557150"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; 
   d="scan'208";a="150557150"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:30:49 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D1267E8CDE;
	Tue, 27 Feb 2024 17:30:46 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 180F0E6300;
	Tue, 27 Feb 2024 17:30:46 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id E76192020A50;
	Tue, 27 Feb 2024 17:30:45 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH v2 2/3] Remove conditional branch that is not suitable for cxl1.1 devices
Date: Tue, 27 Feb 2024 17:33:12 +0900
Message-ID: <20240227083313.87699-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
References: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This patch removes conditional branching that does not comply with the specifications.

In the existing code, there is a conditional branch that compares "chbs->length" 
with "CXL_RCRB_SIZE". However, according to the specifications, "chbs->length" 
indicates the length of the CHBS structure in the cedt, not the size of the 
configuration space. Therefore, since this condition does not comply with
the specifications(cxl3.0 specification 9.17.1), remove it.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/acpi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dcf2b39e1048..cf15c5130428 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -477,10 +477,6 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	if (!chbs->base)
 		return 0;
 
-	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
-	    chbs->length != CXL_RCRB_SIZE)
-		return 0;
-
 	ctx->base = chbs->base;
 
 	return 0;
-- 
2.43.0


