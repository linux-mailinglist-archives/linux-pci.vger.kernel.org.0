Return-Path: <linux-pci+bounces-36852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956DB99D82
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 14:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF341B2321D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D72303C88;
	Wed, 24 Sep 2025 12:30:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37E302CCA;
	Wed, 24 Sep 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717012; cv=none; b=gxNsKCP+svmrdyO1JNG/qH7RhLFddO8MgsqON14xNXtIaWlGiGoE0Vqz3ACCR5RIs+s3C91sU2SYO1DxwFw9PzpDtC+8T999DWD5gJRjfaU2796PayITTfPgWkLFGOWVXIClU1GsH5CEv8wRbNQhSqrDKDfoDrtBp/PouSNwVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717012; c=relaxed/simple;
	bh=ToVhFsgTaUkSAbbRQI5th+VEOqb/+MGFW5F4/tcHWWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qg0nBexg2+MFDh6HN2wNzZTV8sbTj5lPEZhynlaKCnDrkVTMxnTc64EycsLzhme55w06hQ0xX5EcIcNe6xp8f/UtW1x5XVcD3srRFQezJiPwIzrhBVf+ejf/+2BmzJhW5q0gGDQqYWpZcJWXLrGIkDE4M3ZAMK4j2XR2mw7c/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58OBSTgl074423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 19:28:29 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Sep 2025
 19:28:29 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v4 1/5] PCI: dwc: Skip failed outbound iATU and continue
Date: Wed, 24 Sep 2025 19:28:16 +0800
Message-ID: <20250924112820.2003675-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924112820.2003675-1-randolph@andestech.com>
References: <20250924112820.2003675-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58OBSTgl074423

Previously, outbound iATU programming included range checks based
on hardware limitations. If a configuration did not meet these
constraints, the loop would stop immediately.

This patch updates the behavior to enhance flexibility. Instead of
stopping at the first issue, it now logs a warning with details of
the affected window and proceeds to program the remaining iATU
entries.

This enables partial configuration to complete in cases where some
iATU windows may not meet requirements, improving overall
compatibility.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..91ee6b903934 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -756,7 +756,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows <= i)
 			break;
 
 		atu.index = i;
@@ -773,9 +773,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
-			dev_err(pci->dev, "Failed to set MEM range %pr\n",
-				entry->res);
-			return ret;
+			dev_warn(pci->dev, "Failed to set MEM range %pr\n",
+				 entry->res);
+		} else {
+			i++;
 		}
 	}
 
-- 
2.34.1


