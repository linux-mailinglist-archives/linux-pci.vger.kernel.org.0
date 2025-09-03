Return-Path: <linux-pci+bounces-35378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF63B41F9A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4CE5E2B8E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C743009CE;
	Wed,  3 Sep 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i3ZQ8owQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD63019D1;
	Wed,  3 Sep 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903592; cv=none; b=mNJjLXyw22ffnWT7t0xQPeVBlZBkV07rH2SaCclRUGrKuzkxMESEz3AtHV4XoQqH29wyeSzVRTbL/Qe5zzKPo1NOdQ9eqUOKJAL362kYo6XQSp+nLZaPXa0Xd1IbO5Y0sPHzAFupxYqjHc9t5KGKOMBTkiw4d6Vm5d5+TzdHqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903592; c=relaxed/simple;
	bh=5iM5dpJQByr4jyThMJW1hOi75nuXBqtOM+72+KmSwoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol72LsuWVjUc3RkFjbvFsS8M2asr7gc6yrb5ghvDe3fwIjEtXGuVNAfomMyBZsa0W1u6Xf6I0dcrpd+Li6RZbZKjqtsIKwCCI28kk85w+osPim15oKPSqa5N5QWy+vGteHILaQsJ6f+X2EF80eNVcq066j4SabbyTdNwylZ53Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i3ZQ8owQ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CkDf63263877;
	Wed, 3 Sep 2025 07:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903573;
	bh=j9zumft/0d81Ai2iztJqI3RZIK9xCpoK82EwXCpDpfU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i3ZQ8owQYoj7YNjj5nuASTBgd7p+3ec4uRlCazkmLF1kdwlpBY++eOv2WxWOsme/q
	 k7OYKVlvwms/+MdgHTvvUZMvMMnV7T2QcfFFllMM8uW/vSAp6hXbJ2o9bHT+PEnfyx
	 FYU7ZeWzDcFufePY/tkdDP/WhsLC9Au6PKkGvlGc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CkDmM3602232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:46:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:46:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:46:13 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wa1576150;
	Wed, 3 Sep 2025 07:46:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 09/11] PCI: keystone: Switch to devm_request_irq() for "ks-pcie-error-irq" IRQ
Date: Wed, 3 Sep 2025 18:14:50 +0530
Message-ID: <20250903124505.365913-10-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In preparation for enabling loadable module support for the driver,
there is motivation to switch to devm_request_irq() to simplify the
cleanup on driver removal. Additionally, since the interrupt handler
associated with the "ks-pcie-error-irq" namely "ks_pcie_handle_error_irq()
is only printing the error and is clearing the interrupt, there is no
necessity to prefer devm_request_threaded_irq() over devm_request_irq().
Hence, switch from request_irq() to devm_request_irq().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index bb93559f6468..02f9a6d0e4a8 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1277,8 +1277,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
-			  "ks-pcie-error-irq", ks_pcie);
+	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			       "ks-pcie-error-irq", ks_pcie);
 	if (ret < 0) {
 		dev_err(dev, "failed to request error IRQ %d\n",
 			irq);
-- 
2.43.0


