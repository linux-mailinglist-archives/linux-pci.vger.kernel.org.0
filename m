Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78473E59D7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHJMZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 08:25:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28510 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229764AbhHJMZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Aug 2021 08:25:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AC6Z9N023924;
        Tue, 10 Aug 2021 05:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2OwKwlT4M0KGaXC2/f5VCihT6aa2tg7mp2yF9377/4U=;
 b=NVrYoOCtHTR4LwVahcXcR1duLrO4TJjWZnTUE6BhmhXAmA1w8TGtqKpd43pqmUbxdKoR
 N+B3OEoz5LKyrmH4oaPtCgIC6xzOr5SaUAVUNLNF91YCKQMy89LTlu6EE57Vji9nn/Qc
 c0vcH8ZYOrj7AE7WczQYaUWpAXgGe74pKrkdmraEJyDfkoIYdEpOxnRojCQn+bd1cJBd
 1dXKSyFNa16LKt0/UnHfXT9u3ZDcK/Q30E9DuETNNiUWv5SaR/ITgpw3OCUPeZER6SeE
 rwJnBAkeT0qR6CDEyzHTOlk1FhxT5+2iaO2IguPqUy3uHUDv4V7Vxzsh3SEc178/WSHv XQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3abfu2hwhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 05:24:37 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 10 Aug
 2021 05:24:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 10 Aug 2021 05:24:35 -0700
Received: from hyd1584.marvell.com (unknown [10.29.37.82])
        by maili.marvell.com (Postfix) with ESMTP id 6976E5E687E;
        Tue, 10 Aug 2021 05:24:34 -0700 (PDT)
From:   George Cherian <george.cherian@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, George Cherian <george.cherian@marvell.com>
Subject: [PATCH] PCI: Add ACS quirk for Cavium multi-function devices
Date:   Tue, 10 Aug 2021 17:54:25 +0530
Message-ID: <20210810122425.1115156-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HIYwT2w7tNtda6uSNIWHB5eO3zC1CKQF
X-Proofpoint-GUID: HIYwT2w7tNtda6uSNIWHB5eO3zC1CKQF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some Cavium endpoints are implemented as multi-function devices
without ACS capability, but they actually don't support peer-to-peer
transactions.

Add ACS quirks to declare DMA isolation.

Apply te quirk for following devices
1. BGX device found on Octeon-TX (8xxx)
2. CGX device found on Octeon-TX2 (9xxx)
3. RPM device found on Octeon-TX3 (10xxx)

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386eadc2..076932018494 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4840,6 +4840,10 @@ static const struct pci_dev_acs_enabled {
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
 	/* Cavium ThunderX */
 	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
+	/* Cavium multi-function devices */
+	{ PCI_VENDOR_ID_CAVIUM, 0xA026, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_CAVIUM, 0xA059, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_CAVIUM, 0xA060, pci_quirk_mf_endpoint_acs },
 	/* APM X-Gene */
 	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
 	/* Ampere Computing */
-- 
2.25.1

