Return-Path: <linux-pci+bounces-4746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AF878F66
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3267F1C209EA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58669973;
	Tue, 12 Mar 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qa3lcXa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449D69974;
	Tue, 12 Mar 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230681; cv=none; b=KQIxnohF/T+lDo8RWgtajW41QczGGbUHS6MXDadNWtEPbY7R4FLEfVzugmfIh9ARUHQYK/uC/VnoSxnEqAG6r6dtwkfdMMz8l3kHJ28ZwYeSzxc3blp0sLk6zyFxYfuo/iOYqrOyWE5m7swvV7yVjkQE6jiY12aZ/Ic5AzCI/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230681; c=relaxed/simple;
	bh=bPSnlvhM/EbpGy25SiekuNdcEivAYfCgLjkCyRbM4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSu4ZTjD39yeGm4/AU/6kBpoWbFoLRagHSj354uP4GRkjqom0w/pzWfgCsDaQz6HV26/NTIOCnJwCcK2o3H0tGSZcDLdhh8+q3ZiKFsJBB0SpLGvDsc19Ul/O+DUrkQXjIdi5HSEC1C/HTrIJPAv3reT2hQ023qqKtxStxbP4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qa3lcXa7; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710230679; x=1741766679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPSnlvhM/EbpGy25SiekuNdcEivAYfCgLjkCyRbM4L0=;
  b=qa3lcXa7lp5bT+TZHRR+dxtynakVWx2zCUBF8vvupxUpCdec4a2ZoxpR
   EwI7xed2+A8DQbr17JvnVOJJ3pgiw73nL2hAwfjycdf0sInzCCN1iQbXa
   aEJ0DXDaD/5bf/3h6h7dna353sb6lsVB0B8RTeDu6ZM5g4bt0/HtYrbWN
   EBYeECwpIr6aiSnGz0NSeHSH4d1wtUXNAgZfqQskBNKV8ljf5im882Z/j
   JRYPg89Q8StubK/4/DIAdVdmUqUFx9hvhkr8XU3IcBYheNQFQKCPoj+N3
   se2LOqafbFyKSgdM0XGgzQRpAWHyGEJ+PwEFTADrq4EStfecjQFFiq+LY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="140453668"
X-IronPort-AV: E=Sophos;i="6.07,118,1708354800"; 
   d="scan'208";a="140453668"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:03:28 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3236EE6002;
	Tue, 12 Mar 2024 17:03:26 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 774B7CF7E8;
	Tue, 12 Mar 2024 17:03:25 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 53B1E20059BB;
	Tue, 12 Mar 2024 17:03:25 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v3 2/3] Remove conditional branch that is not suitable for cxl1.1 devices
Date: Tue, 12 Mar 2024 17:05:58 +0900
Message-ID: <20240312080559.14904-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
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


