Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160FC26AA37
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgIORBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 13:01:43 -0400
Received: from mx0a-00273201.pphosted.com ([208.84.65.16]:28004 "EHLO
        mx0a-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgIOQsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 12:48:46 -0400
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
        by mx0a-00273201.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FF7lhG012243;
        Tue, 15 Sep 2020 08:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=PPS1017; bh=EQ1PUCd468s9N5hDytrz+WwPO90IdG6swHnW6o2/CzM=;
 b=ewYhLz+Y8GTILmZ2TDg2vuQQSFRM5XV6C483UL/YgTCK1n0iob59kGxG52ce6iLEvGFP
 GjEqP34X0yx4zQBtZvf9bZn2P4fY6enhsItz5L+BQih0kbYEVdaG3qWedXZfEu4u7HV6
 deaBO+myb9LNGuzg+p2TdySIhECNEFeWtHwgIt43SG4aa3qcDzAzDIZ3X6231HtONKVU
 8AT9+4Mgo4et6iOR0X1Ogg+2MGNVLNANrFTt8N9YABl693/GR95n+MmOqcyXb7PcVPsI
 Z258wxAqw4JrC1KVhWLBm6agxgsIH4GJWU8tOhcWNjrM6ebTXDDcZoSrimgsOLul2p0l 0Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00273201.pphosted.com with ESMTP id 33gv9wvvkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRoUJL1vou2CB++uAa+YmhaSv0FwzqmzjQ6xnef6gXioeGx/jDm3XHkrdtT61kj7U6T4HS+2WSPjsuxudW4cnOVerdKBq8SYKJHrGQJGgLWbaJvJnHAy3+1bEqga2D2S3/2W62Fq2n+BNiCnJWh1nAvd/Edd+yP65biWKRUlxYNnq/BQ5V6WT2NzPToo1EfFd3Hm49G5QYA4fVoP+Cb+VH0gUHEmpAloDmXfsemJAVhSBhdYSaazsZN2OvI1RR/2+wJR6iPqInzqhhJdkLUL6Dytd9plLDzmoLXrHcXUhl008/HAF6sErT/wVtNucX0O5LVYYMU0Pb6/+3nwLGpVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ1PUCd468s9N5hDytrz+WwPO90IdG6swHnW6o2/CzM=;
 b=fnH9/x9AiIkeTOQk279goMGKxCdAApJu4H0EWGP/TdbEVwDynELBU0xSqPJmwLDwbwPLuF8LMVaKj55NaVJAKm+LcAwGnRS8OwiWRV6dLowmwEBUnUyhn3byGEh4iHSF/IPNnvyz9kg9gZGB4CCOV0wLLrT0f3QU0PWZNZYkaBuRLIJPQBk9rVvG4ds9/jIP+NlAhL41ON1BaShIjpiXTiNPbqdQLk2jNAt9fau7Lcqx309YRswj1Hor2SIKIWl51EimOwKp9B1n3PoUcScqIibLGP/bqMe8BhwoAfda7Vz8ywFRbv/fsmAZLgXjh9RVaJPRMSSEItEWBkw1wQ7iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ1PUCd468s9N5hDytrz+WwPO90IdG6swHnW6o2/CzM=;
 b=UusYriY9pwHwJF2AVeLbQpgRm52WZ1h2lu05TMPiXg1n/cOu1iTg7nw9kJaZ+4TnnI7piCpAtOgitLiILm35+t6z4mLmxBh9xcVFVEN9q194z86dzEyUqsFfKtuOiST18C2oc9t5Os2C4PduBs9k17ZdCHBXp4XiM2+m/i0QbYo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=juniper.net;
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (2603:10b6:a03:19::16)
 by BYAPR05MB4678.namprd05.prod.outlook.com (2603:10b6:a03:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.9; Tue, 15 Sep
 2020 15:11:32 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 15:11:32 +0000
From:   Ming Qiao <mqiao@juniper.net>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ming Qiao <mqiao@juniper.net>, Debjit Ghosh <dghosh@juniper.net>,
        Santhanakrishnan Balraj <sbalraj@juniper.net>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH 1/3] PCI: Add quirks for Juniper FPGAs to set class code
Date:   Tue, 15 Sep 2020 08:11:01 -0700
Message-Id: <20200915151103.7086-1-mqiao@juniper.net>
X-Mailer: git-send-email 2.10.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To BYAPR05MB5592.namprd05.prod.outlook.com
 (2603:10b6:a03:19::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from qnc-ubm16-mqiao.juniper.net (66.129.224.68) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 15:11:30 +0000
X-Mailer: git-send-email 2.10.0
X-Originating-IP: [66.129.224.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a408994d-85a9-4da4-bc81-08d85989a121
X-MS-TrafficTypeDiagnostic: BYAPR05MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB467890932C4FD3B5E6CD3734AF200@BYAPR05MB4678.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLb2LY6aEJzx0YkyxcilSjVL9OdgWDkS9cGHOTFzjsf/sQ3yr3Cmc8hHbecautdIzs4Sb8HL9+CYMN22epblygF6KUWRFe7UOS60z9Z99XUVRJBR21Ozh59ueMSf5GKBD4LxAptjy9MDL5Tm1ijiWEg58gZpvzhCX8vRwz/frXtZFSdKAAq4vaDoFzde2w2FO8v7rCV+gCI5wlLspUE0GPt5djMVQqbbDmlzwEaO4aE5Aryjm8G9BiHDEQDEVQNW5vBmoEVzUzLOacZWyEfgQZPE5z6lb6N1SReE/E/PiC+/slp81/VJ0xkwdpSY8PGKVO8DO4NT3uCJDnzh7TykC9XcN/SwkbL7ASsZw9tGT7U2Ar1Vv5726IR1SxOeRYBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5592.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(316002)(6666004)(66556008)(86362001)(5660300002)(1076003)(66476007)(66946007)(16526019)(36756003)(186003)(6486002)(54906003)(4326008)(956004)(2616005)(8936002)(26005)(8676002)(52116002)(478600001)(83380400001)(2906002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: neuMjaOUHH682qg+Mj7Nrhri4vKE7guUOZGdwq6osra2ds0Wg+daRrtGkhcWgE2ErJgWDmej7mVdmEBK2pbmCBgE/E4Qw60Il7Q474mQs480eIA3RjArnOvYM5aj9Q7cDVGarBMA0+e5hpEJ/cr2yy86+QUWvXoPqx5YrWVxgdMR4VT897aRUvR/6u35xxQEo7wMI8m8Wfv2kX4RIHoRT6sQgZ3fisoi0joejdrzb07moaDlgwV1ji7LqJLTvh0YQz0/E4Utxc0OHYY86G69Y82HAX/aWYiN4d5EjGH7X3SWALPaKEMDLQnNhv80FJjdxbK9HV6LwfvgEeZuB28EGbpl8M94Fm/I6qMmfLjx8WWh4063/WGgoGUohGA4+D5iApdo9z3V+P9wTUxEV2p0MCsNZttnjHyf0Qnco1djd4J7CYhh5+cvP2w/E3UYhZt2vs1RyHsgqGChF/e6hBmx5xa5GGUmQeNK6/mM9bcjz25S/xxGAqpl6ANhIK+5vRW2XC2Lx5p+FBE9q8z1m2TsgSa3XAR41h7Itz2P0VS1bQOc3ovvxr/DDYIoZVFGPpLUG3fnS00RZgQOBM0+XtfYisNoq/qOq7Myj4O2ZqTFIP2YK6AbHNPO64FYw/w8Xqi649Xutxr3uKr033aHNugSAw==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a408994d-85a9-4da4-bc81-08d85989a121
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5592.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 15:11:32.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcbLGrM/4Jn8bKm+YouVFb5lz8A5dn6eCV7vTbaI5sRua0Fy1j2hoLHlQH4qKFa3XglGGyHHrUAtxW4pDrDdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4678
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011 mlxlogscore=928
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the Juniper FPGAs do not report correct PCI class ID, which
would confuse kernel APIs accessing the specific class of devices.
Change them to PCI_CLASS_SYSTEM_OTHER << 8.

Also introduce Juniper vendor ID to be used in the quirks.
    
Signed-off-by: Debjit Ghosh <dghosh@juniper.net>
Signed-off-by: Santhanakrishnan Balraj <sbalraj@juniper.net>
Signed-off-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Ming Qiao <mqiao@juniper.net>
---
 drivers/pci/quirks.c    | 25 +++++++++++++++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2a589b6..61344d2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5632,3 +5632,28 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * PCI class reported by some Juniper FPGAs is not correct.
+ * Change it to SYSTEM.
+ */
+static void quirk_jnx_fpga(struct pci_dev *dev)
+{
+	if (!dmi_match(DMI_BOARD_VENDOR, "Juniper Networks Inc."))
+		return;
+
+	dev->class = PCI_CLASS_SYSTEM_OTHER << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0004, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006A, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006B, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006C, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006E, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0079, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0083, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0071, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A7, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A8, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A9, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00AA, quirk_jnx_fpga);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x0505, quirk_jnx_fpga);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ab1e24..bfbf8f1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1859,6 +1859,8 @@
 #define PCI_VENDOR_ID_ESDGMBH		0x12fe
 #define PCI_DEVICE_ID_ESDGMBH_CPCIASIO4 0x0111
 
+#define PCI_VENDOR_ID_JUNIPER		0X1304
+
 #define PCI_VENDOR_ID_CB		0x1307	/* Measurement Computing */
 
 #define PCI_VENDOR_ID_SIIG		0x131f
-- 
2.10.0

