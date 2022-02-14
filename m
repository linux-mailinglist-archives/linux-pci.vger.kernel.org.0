Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD774B5003
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiBNMZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 07:25:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbiBNMZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 07:25:29 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA33496A9
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 04:25:21 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EBK8EU006574;
        Mon, 14 Feb 2022 04:25:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=72xBvPZCFqK5caJDXrKeyUODS4150vncMxG8X5S3F/c=;
 b=iNQRNErVRDA6RkWbqFPFd/16P1hx/9r5SJAIJ44Ax1QaH4PGXLZjcxIORjf197/zDKWQ
 IbMUYzfZUTiR32wiJEBIcYCcVBJeSJGMBy5IkCZi5KGJA+jUtHRdp4aUcY5qXJ1aLl+m
 Kqjx4uC/mRaoKqCkN236UQtF5QxktBVaIW/cXuEor6zSow9ADjBk1i0rIjYoVVNVMksf
 nXLrfpg4oM/e2ad8saoJFF3CXj7MH0JTd94GRZjQzKpkRDWA1AAD9IOB01sDXH6UpEZ1
 xwgm0CPOlpbgACCUQPm7+sJ66Nv6jzh1GypvFFpIOxuDATRmm59eKjZT2fHCMeHmp0XP JA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e7dbc2055-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 04:25:17 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 04:25:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 14 Feb 2022 04:25:16 -0800
Received: from machine421.marvell.com (unknown [10.29.37.2])
        by maili.marvell.com (Postfix) with ESMTP id A1C243F709B;
        Mon, 14 Feb 2022 04:25:14 -0800 (PST)
From:   Sunil Goutham <sgoutham@marvell.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <sunil.goutham@gmail.com>, Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH] PCI: Add Marvell Octeon devices to PCI IDs
Date:   Mon, 14 Feb 2022 17:55:10 +0530
Message-ID: <1644841510-14512-1-git-send-email-sgoutham@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: uD0qtvavXNqSC95C3JRSeArf9dV5e8eB
X-Proofpoint-ORIG-GUID: uD0qtvavXNqSC95C3JRSeArf9dV5e8eB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_04,2022-02-14_03,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Marvell (Cavium) OcteonTx2 and CN10K devices
to PCI ID database.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 include/linux/pci_ids.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c6..5fd187b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2357,6 +2357,21 @@
 #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
 
 #define PCI_VENDOR_ID_CAVIUM		0x177d
+#define PCI_DEVICE_ID_OCTEONTX2_PTP	0xA00C
+#define PCI_DEVICE_ID_CN10K_PTP		0xA09E
+#define PCI_DEVICE_ID_OCTEONTX2_CGX	0xA059
+#define PCI_DEVICE_ID_CN10K_RPM		0xA060
+#define PCI_DEVICE_ID_OCTEONTX2_CPTPF	0xA0FD
+#define PCI_DEVICE_ID_OCTEONTX2_CPTVF	0xA0FE
+#define PCI_DEVICE_ID_CN10K_CPTPF	0xA0F2
+#define PCI_DEVICE_ID_CN10K_CPTVF	0xA0F3
+#define PCI_DEVICE_ID_OCTEONTX2_RVUAF	0xA065
+#define PCI_DEVICE_ID_OCTEONTX2_RVUPF	0xA063
+#define PCI_DEVICE_ID_OCTEONTX2_RVUVF	0xA064
+#define PCI_DEVICE_ID_OCTEONTX2_LBK	0xA061
+#define PCI_DEVICE_ID_OCTEONTX2_LBKVF	0xA0F8
+#define PCI_DEVICE_ID_OCTEONTX2_SDPPF	0xA0F6
+#define PCI_DEVICE_ID_OCTEONTX2_SDPVF	0xA0F7
 
 #define PCI_VENDOR_ID_TECHWELL		0x1797
 #define PCI_DEVICE_ID_TECHWELL_6800	0x6800
-- 
2.7.4

