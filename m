Return-Path: <linux-pci+bounces-25071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA7A77E3E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DBB3AF46B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC3205509;
	Tue,  1 Apr 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qOWBCaZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0BC204F6B;
	Tue,  1 Apr 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519067; cv=none; b=J4S/FIgBBozO7spwoAMnlu2EBvsyADLDXWsM8vHzx8ezeERD56+skM3VclhPGKZ1Kfv15Dbs8cJlgH/BXb3hFKx+7U918R3ZIrUIRboEFPAm8lL1sq230yHtZwh+VgEr4QefNofo6OTkEQNdcq7ODVBdGkQvLCKCGLx3b17NNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519067; c=relaxed/simple;
	bh=suJSG+QJcLpuIJ4fevNFwzmnVj8kwGI0errW/O1Vzig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeKQ2GEJkyoxDqFeCQDTMin2GAdufqSoYfeYnFq1w7Bzsy7r5ZJnUX0jXaCcIcC0F7bdZyAlOWhsgDnG8KECzRyUnk0NS384S3HTDMQrqNeEQ9NbQ4A0ulBXQYnfJW4EuyZfydcOjVyBPFLrMKScSejoT1tWI778h2OzXKT5gBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qOWBCaZv; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sU5Ue
	CWs7UJOXee6/VYbtWdXx35uZipM4B2dNWtsI98=; b=qOWBCaZvy8X6fUQcUV1sZ
	yTmkdFJvhfhsHtU67tD/lp9e6K/TiloTrgchLgskIrdqANRH1XmDAnQEJobTcOIy
	QSKOIqbK/PU7Cm6U7nayHhPLNvfxbGyPDl3h2n6ft3dMR7rzapkCWK8FM60sorMb
	RHQYlSVjZ62HTDVsHfVtcY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3Ly0w_etnWRUeDg--.28258S2;
	Tue, 01 Apr 2025 22:50:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: cadence: Remove duplicate message code definitions
Date: Tue,  1 Apr 2025 22:50:23 +0800
Message-Id: <20250401145023.22948-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Ly0w_etnWRUeDg--.28258S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry3tFW8JF13WFyUZw1UKFg_yoW5Jw45pa
	y8G34xCF1xJ398u3WF9a15GFy3X3ZayFyIgrsI9w1xWF1xuFy7GF9xtF4rJFy7GrZFqry7
	uws8trZrJF4rArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE_MaUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwEio2fr+cklvAABsr

The Cadence PCIe controller driver defines message codes in enum
cdns_pcie_msg_code that duplicate existing PCIE_MSG_CODE_* macros
from drivers/pci/pci.h. The driver only uses ASSERT_INTA and
DEASSERT_INTA codes from this enum.

Remove the redundant enum definition and use the standard PCIe message
code macros from pci.h to:
  1. Avoid code duplication.
  2. Maintain consistency with PCI specifications.
  3. Simplify future maintenance.
  4. Prevent potential divergence between duplicate definitions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  5 +++--
 drivers/pci/controller/cadence/pcie-cadence.h    | 11 -----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..9ce36113e9f2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -12,6 +12,7 @@
 #include <linux/sizes.h>
 
 #include "pcie-cadence.h"
+#include "../../pci.h"
 
 #define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
@@ -337,10 +338,10 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 
 	if (is_asserted) {
 		ep->irq_pending |= BIT(intx);
-		msg_code = MSG_CODE_ASSERT_INTA + intx;
+		msg_code = PCIE_MSG_CODE_ASSERT_INTA + intx;
 	} else {
 		ep->irq_pending &= ~BIT(intx);
-		msg_code = MSG_CODE_DEASSERT_INTA + intx;
+		msg_code = PCIE_MSG_CODE_DEASSERT_INTA + intx;
 	}
 
 	spin_lock_irqsave(&ep->lock, flags);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..9a05940ff949 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -250,17 +250,6 @@ struct cdns_pcie_rp_ib_bar {
 
 struct cdns_pcie;
 
-enum cdns_pcie_msg_code {
-	MSG_CODE_ASSERT_INTA	= 0x20,
-	MSG_CODE_ASSERT_INTB	= 0x21,
-	MSG_CODE_ASSERT_INTC	= 0x22,
-	MSG_CODE_ASSERT_INTD	= 0x23,
-	MSG_CODE_DEASSERT_INTA	= 0x24,
-	MSG_CODE_DEASSERT_INTB	= 0x25,
-	MSG_CODE_DEASSERT_INTC	= 0x26,
-	MSG_CODE_DEASSERT_INTD	= 0x27,
-};
-
 enum cdns_pcie_msg_routing {
 	/* Route to Root Complex */
 	MSG_ROUTING_TO_RC,

base-commit: acb4f33713b9f6cadb6143f211714c343465411c
-- 
2.25.1


