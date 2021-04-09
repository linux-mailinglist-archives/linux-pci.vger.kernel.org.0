Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9D35A87C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 23:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhDIVwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 17:52:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35608 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234505AbhDIVwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 17:52:15 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139LpHZh030172;
        Fri, 9 Apr 2021 14:51:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=2xkm0JDdHhn4qJaQ0nN/q1OBCXI2FYflSwlVxXCd5dQ=;
 b=L2OmDhoC77Wkq0FjEoKrS/HY3hjHn2jdJUMMWdpenRWr0lCkukzH6NepNZ9clzRD41oR
 M8XGcF4/shAg6+XXC0lSQGDotYLZqMHLCphcNJW/KVZFb9FCMHC1JU2G+bDdFOu4i/HW
 OQ5E3Mc4gKKkFGkEYcjpErClWkuq6HXLec8lx5TelIAdsnpoPH2QW+M2PkSPh6nDBJrM
 Mefu+g3e+sECwLDOB/1nUlv85K4PUFZxLjaoZvDGqhE2eiIS4LbyENPkp6XFRRHm2v7+
 sDGfPo83nGnghhPdLIIItBCwSHlbFrDXQAFPkKyIlw3oi8HpraNKuO6x7PDhjL1+aIi/ 0Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37tftpakp0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:51:58 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 14:51:58 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 14:51:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 14:51:57 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 70FD33F7040;
        Fri,  9 Apr 2021 14:51:57 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 54B4F22806E; Fri,  9 Apr 2021 14:51:57 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: [PATCH v2 1/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261
Date:   Fri, 9 Apr 2021 14:51:53 -0700
Message-ID: <20210409215153.16569-2-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210409215153.16569-1-aeasi@marvell.com>
References: <20210409215153.16569-1-aeasi@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: duh2IlrEyEUIgcsgdFXAf6AUKOKWGD_G
X-Proofpoint-ORIG-GUID: duh2IlrEyEUIgcsgdFXAf6AUKOKWGD_G
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
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
    "VPD blacklist of Marvell QLogic 1077/2261" [2]

[0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
[1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
[2] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/
[3] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2104071535110.13940@irv1user01.caveonetworks.com/

Clarification on why [0], which appeared in v4.11, would be an issue
given that [1] appeared in v4.6:

    Firstly, we do not have information on which exact kernel the
    tester was using that resulted in [0]. That said, the call
    trace for the issue had pci_vpd_pci22_* calls, which appeared
    only in pre-4.6 kernels. Those functions were renamed v4.6 and
    above, so tester was indeed testing using an older kernel.
    See [3] for further details.

Signed-off-by: Arun Easi <aeasi@marvell.com>
CC: stable@vger.kernel.org      # v4.6+
---
 drivers/pci/vpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 6909253..a41818a 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -474,7 +474,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
 		quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
-- 
2.9.5

