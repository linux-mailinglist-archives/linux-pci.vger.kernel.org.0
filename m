Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE232C8F0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 02:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCDA7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 19:59:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49404 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1449866AbhCCXB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 18:01:57 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123MUlVM014392;
        Wed, 3 Mar 2021 14:42:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Ko3x1lKd00GVgvbYFruePoqPdr72yRFOTh/GoZwTddY=;
 b=LBNjJGXJvQoZqWnbNkkKetxqw8gjGFD/RAPaNbwGNtzaof8rxX8COl+QTdKp59c2CG8U
 4tCoj3NxD/6014jtkVeXsedwnQCQ2o2V0IdwE7LBP2KmwXfdLkpiY9n1Nu8CxzeEnFru
 Kc1YUP24u/osZmJkbaGSyRics0iuCTNI4hJmM6aEZ4nUAea+vaB+ZbdC/D5x9XEAxODz
 MqwFyWItx8VnS8QhMye7AgRKgWDXqfft73icu70ufgIh14F3gC7ZhHn+fxC1DxsK7K2k
 Bgzwov9shZpKedgX1NvWS76E1FkJaJudqHFB1lITM323BRCGl1iwAB3H7HvXvLfpmQ9i PA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36ymaueup7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 14:42:57 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 14:42:56 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 14:42:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 14:42:55 -0800
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 034053F7041;
        Wed,  3 Mar 2021 14:42:56 -0800 (PST)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id E216D22806D; Wed,  3 Mar 2021 14:42:55 -0800 (PST)
From:   Arun Easi <aeasi@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261
Date:   Wed, 3 Mar 2021 14:42:50 -0800
Message-ID: <20210303224250.12618-2-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303224250.12618-1-aeasi@marvell.com>
References: <20210303224250.12618-1-aeasi@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
"Vital Product Data" as "Not readable" today and thus preventing
customers from getting relevant HBA information. Fix it by removing
the blacklist quirk.

The VPD quirk was added by [0] to avoid a system NMI; this issue has
been long fixed in the HBA firmware. In addition, PCI also has changes
to check the VPD size [1], so this quirk can be reverted now regardless
of a firmware update.

Some more details can be found in the following thread:
    "VPD blacklist of Marvell QLogic 1077/2261" [2].

[0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
[1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
[2] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/

Signed-off-by: Arun Easi <aeasi@marvell.com>
CC: stable@vger.kernel.org      # v4.6+
---
 drivers/pci/vpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7915d10..bd54907 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -570,7 +570,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
 		quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
-- 
2.9.5

