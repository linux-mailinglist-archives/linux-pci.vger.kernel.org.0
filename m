Return-Path: <linux-pci+bounces-3571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B739857658
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 07:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BD3282184
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDE14292;
	Fri, 16 Feb 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vy7uMHxn"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C2FC01;
	Fri, 16 Feb 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066781; cv=none; b=UHMOPmp3+rxx20C+aRxK9DI8wfwIKLD/ynhHhmdMEO9pPZPl2LPWTm+tkQF1Kq1T19UDyhgVs11MBOUAHAcwW3Aq2i9oQ6U6CyhHQM6wGQAllyqw86tAtXn+e7YlIxj8nD1pkbPrUzEmpTnwoSoU0bIwRJ0eoEquzTojGWnCNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066781; c=relaxed/simple;
	bh=9Bdp+1r/OqcKTlUqSz41twCITHzsqK6lYijcbC3Zeig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QE5qJnddVBi3Y8teQgtpPRTcS8Td2j9JS3i1ZCgGNLfbr1aGcWuQ9oktA/Wy2VCWL1/Z8apcyhtgq5fRqit44DkG5K+hxCQYDcev4ohFSqiPP0W7lUVGR0ARiaS8OUzI8eWOgGOmTy6Bz0Bt6CjCUWrxunKpOJCY9jlwE0hTLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vy7uMHxn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6xVFr009824;
	Fri, 16 Feb 2024 00:59:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708066771;
	bh=9488Fqw/4A/CrgJLyaVNYxs+5hfqdJMVXU+J6xLUSfY=;
	h=From:To:CC:Subject:Date;
	b=vy7uMHxnyE3PRcLr3P3yrvzrrg8myTVq+/L0JxNBcxUrcqLDY3pS4qPCBhZ6W4Iq6
	 +N1IxCepbTUfPGdj0jJEDvQ+at24PILdZv3YT0oswc9QUmHX9qWJp4UmzBr2IdunJV
	 XTAclO1DcsuyriLbYEB9vWstocGCJ8JcevR3nOBg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6xVaf113613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:59:31 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:59:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:59:30 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6xR4f016551;
	Fri, 16 Feb 2024 00:59:27 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <kishon@kernel.org>, <vigneshr@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] MAINTAINERS: PCI: TI DRA7XX/J721E: Add Siddharth Vadapalli as a reviewer
Date: Fri, 16 Feb 2024 12:29:26 +0530
Message-ID: <20240216065926.473805-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since I have been contributing to the driver for a while and wish to help
with the review process, add myself as a reviewer.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7980e5b1ad..7d6a60002fc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16976,6 +16976,7 @@ F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
 M:	Vignesh Raghavendra <vigneshr@ti.com>
+R:	Siddharth Vadapalli <s-vadapalli@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.34.1


