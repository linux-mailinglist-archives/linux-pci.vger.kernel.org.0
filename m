Return-Path: <linux-pci+bounces-654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1778809F3B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEFC1C20966
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8B7474;
	Fri,  8 Dec 2023 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="VTEx/Ynt";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="qc9WhcaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353B1720
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E14BDC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027141; bh=G83yQX6XDL/UxCmMwPy6hpG7udQNytBFozw3aiCB4lo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VTEx/YntuezGkn/33+GEoZT5sQppBo+2fKOVMkKfjwWXHmEM0L7gWwJScrRF7qeip
	 URcF3Gla1FBHSOOIjRDAg2lK1RVbsbH8Mk8a87FFZ6h0W7yQD1Q7gp6Wny+8QR4Ahh
	 +lnBMOGVHekDKH2Qthv9uJFlc36QZda/wKcJLXhoSihNHNJg/ctJ07DON86uBI4aJV
	 LF2cV59r3/aS7V0f8S49bOpbm6FJR8hqu+V99wHIiM1fdbF66YUFmvu4R5+V0I2DST
	 sUVVQsf3VkxFE1JNsEnwTMSfJdE1Oe6n1Iz3ffiSoWlV+gIE5fYwwtbOo+Pj6QZeha
	 SLnVCt2kZChug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027141; bh=G83yQX6XDL/UxCmMwPy6hpG7udQNytBFozw3aiCB4lo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=qc9WhcaW25Rj0LPm9ug5Eo6EfNX67qiFUYnAgA7GaUvE9vFtPrHT12XhrRbEHLH3/
	 P+ue/mL/L/0y6OHsjS0kLoQycGtq90JpcukMQuhIVIA29CI2NRjbZQPa608+gmuTVc
	 qsbXX6f1bUIzNfK+dP/r5Bso+xBswNLESKlLj6mqvgySzGZk8M6v/HVbKzHpRqHD+8
	 fpJjnESUQ/cDvEcWnr9iaASvLMw4geYeodxTgWYsXlX8bIKWEh8ffjFpLoZthxRT/W
	 qcvqdGkFrEW/RygNTHHC0GEPJwmXlUo2HU608sARvErOooq/lQnSknFEqf1XrwQJ6x
	 onpjE0+hoIAgw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 02/15] pciutils: Add constants for Lane Margining at the Receiver Extended Capability
Date: Fri, 8 Dec 2023 12:17:21 +0300
Message-ID: <20231208091734.12225-3-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lib/header.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 63fbb92..b0fc2be 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1400,6 +1400,13 @@
 #define  PCI_DOE_STS_ERROR		0x4	/* DOE Error */
 #define  PCI_DOE_STS_OBJECT_READY	0x80000000 /* Data Object Ready */
 
+/* Lane Margining at the Receiver Extended Capability */
+#define PCI_LMR_CAPS			0x4 /* Margining Port Capabilities Register */
+#define PCI_LMR_CAPS_DRVR		0x1 /* Margining uses Driver Software */
+#define PCI_LMR_PORT_STS		0x6 /* Margining Port Status Register */
+#define PCI_LMR_PORT_STS_READY		0x1 /* Margining Ready */
+#define PCI_LMR_PORT_STS_SOFT_READY	0x2 /* Margining Software Ready */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
-- 
2.34.1


