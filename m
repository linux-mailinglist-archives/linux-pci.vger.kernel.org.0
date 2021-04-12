Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26F935C9F2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhDLPcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:32:15 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51308 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242922AbhDLPcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:32:06 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFVLuf004634;
        Mon, 12 Apr 2021 08:31:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=+PPQ0jPh/9sOaCsxsOMINjzr4p98Q80wtAyKsrfihdg=;
 b=QT0Rq0AfzzjdHzptiCyVprRbVLpd0ykuA5BX3hxmLcRHLkJ1VumAvz/8d0nW8p4PQ2gN
 D8Nwiybkfa5PiU3A8j8wz0IyHXlyDcnNkWhBzVmS5c5Exev90o/Zq0HhtsyOHIC9nDRt
 TEiPfNb8uawLYZUod1f8RMA68GZNya4hWvuGfDcxkyCLrKdKSVSqYhHZjV8IvqzdGR1/
 1sjiv0lJB05pZZGfasMU6LUzurp0wWi7LTt2hSmg1ii+K5iyMQVn+FG7+obCQE04FOPY
 PA3qSZg5UxUnjBL/fwweJZhIJZfuw6uuNi4hn6nOZ6tzCeVUwnVZ3xrXroygmNpTqPR5 PQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 37vcu99xrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:28 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:27 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id F3DE73F7043;
        Mon, 12 Apr 2021 08:31:22 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>, <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=205/5=5D=20PCI=3A=20armada8k=3A=20add=20device=20reset=20to=20link-down=20handle?=
Date:   Mon, 12 Apr 2021 18:30:56 +0300
Message-ID: <1618241456-27200-6-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YDRy_dGnY5Gad4s8J5DMr13f1F-C1kzp
X-Proofpoint-ORIG-GUID: YDRy_dGnY5Gad4s8J5DMr13f1F-C1kzp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

Added pcie reset via gpio support as described in the
designware-pcie.txt DT binding document.
In cases link down cause still exist in device.
The device need to be reset to reestablish the link.
If reset-gpio pin provided in the device tree, then the linkdown
handle resets the device before reestablishing link.

Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 4eb8607..83ac91e 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -24,6 +24,7 @@
 #include <linux/of_irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/of_gpio.h>
 
 #include "pcie-designware.h"
 
@@ -38,6 +39,7 @@ struct armada8k_pcie {
 	struct regmap *sysctrl_base;
 	u32 mac_rest_bitmask;
 	struct work_struct recover_link_work;
+	enum of_gpio_flags flags;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
-- 
2.7.4

