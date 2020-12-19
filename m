Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC082DEC96
	for <lists+linux-pci@lfdr.de>; Sat, 19 Dec 2020 02:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgLSBFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 20:05:46 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43432 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgLSBFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 20:05:46 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BJ0irKG021893;
        Fri, 18 Dec 2020 17:05:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ftCOwekMWV/XW64tvTm4P4o8WJpUy32AGhczywqAcDw=;
 b=dJ6Ph2cjuRvFvEu2YPv10uqAssAoyP3v5yBDuVo00bWQ4GFa7GKLkzkKSgGSOHxNr+42
 preMnJRIDanmPsFGcMICxxTP2NK/2f+swohu18VuUtddlELE84wdSebv7Hw/zRCpnvMK
 gRKDsH40P3C/iLL/bGe0TJjD2uiH4eAQFI8H4O1KF5jd+FT/+fSaNeVCmCdC72QSS/XE
 eJPwAX4bbq7XAkxIXQCUiE1bBYNE14fvrNQ2+nyjPCJdE+9/jDgPLdEEjZc/57/a/ysW
 HrvzYoplOdw9WO0nwPnYEizma+GBYzVJsF3f0QxYWWIYRiwxOLYPpXXIUrBy2FvGZc3/ nQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35gq80jcka-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 17:05:04 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 17:05:02 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 17:05:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 17:05:01 -0800
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 6D2223F7041;
        Fri, 18 Dec 2020 17:05:01 -0800 (PST)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 47E2A21F2CC; Fri, 18 Dec 2020 17:05:01 -0800 (PST)
From:   Arun Easi <aeasi@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: [PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261
Date:   Fri, 18 Dec 2020 17:04:43 -0800
Message-ID: <20201219010443.6966-1-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_14:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VPD quirk was added by [0] to avoid a system NMI; this issue
has been long fixed in the HBA firmware. In addition, PCI also has
the logic to check the VPD size [1], so this quirk can be reverted
now. More details in the thread:
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

