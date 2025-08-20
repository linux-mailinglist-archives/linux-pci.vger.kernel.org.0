Return-Path: <linux-pci+bounces-34382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55018B2DBA4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8627221CD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F61E51F1;
	Wed, 20 Aug 2025 11:48:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BD2E5434
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690506; cv=none; b=inT+QqLy3BNhFHXAogKnvnLRE+DVGPlv369n2B7WtwrwV/qpPkD7cFjzo2ZQmGUlJOdlX8CAOoQ8x5l3p+TydC1qhnWcFDVmYmMOm+uyZo9itwlRrhKYJAf31dczJCPYD08Hbwr0IBGMVZbkw2zA34Yb7QgaPams6loTPlCSbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690506; c=relaxed/simple;
	bh=9MPhuKbP6izLj9aOsqnAzd97m3P9x+1TVI9BSxplPkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJqj4ri6OqAnCX/4+Q+anepFF9Tszf6puvfyOx7V2cZBZkoBNUguir1fmMBs5SHyYiGp6DdGmbNqNdauoyCwc/4u97eoDlfcdTgaReyP20w5B5nH2jxUboQTU8XPupHv82C5cdGbA1uA9Lsry27ffoveppcbDeKyDPcUhlNo2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJXYg019296
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:33 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIsc3018823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:54 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:54 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 6/6] MAINTAINERS: Add maintainers for Andes QiLai PCIe driver
Date: Wed, 20 Aug 2025 19:18:43 +0800
Message-ID: <20250820111843.811481-7-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 57KBJXYg019296

Here add maintainer information for Andes QiLai PCIe driver.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..7caede190f73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19221,6 +19221,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
+PCI DRIVER FOR ANDES QILAI PCIE
+M:	Randolph Lin <randolph@andestech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-andes-qilai.c
+
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-- 
2.34.1


