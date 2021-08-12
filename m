Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E364D3E9F20
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhHLHBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:01:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30854 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhHLHBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 03:01:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C6pbFR024201;
        Thu, 12 Aug 2021 07:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=m1VDkqfaAPC4gHEnFj3L7sx5zUeBPmzE+4dTofAYWjY=;
 b=g4C1h+2fB/8J+J1mt2Lvv8TlNcUOYGVhA3FDQZAHg0qrRjlYpMd4lt874Ian13OxCqxW
 s3xB9f5Br8c/EHeAzk0LZAf0Nui18dpsBq0CgdFUMSdNzSB9NpkhmJ/OAhCHYs7wTkbL
 LWYYXa6NHQtIZQm5gAbxwVkHZqsNoByGhayWJBOBkZ2Pcqs76MZPCRLSVuJv7PZdKlyP
 i/B76yxy/cjtduGZBYMs84L2baYG+ikx+6jSVHPeRpWNby4sqz5gTGCGXv4dwej3oXqv
 LhRpFKIE6Gi278pRo635duXaI5Dn2sJGPBlekIa8QaadmTijdGMMXf1TNUGIE+LsM7Kk MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=m1VDkqfaAPC4gHEnFj3L7sx5zUeBPmzE+4dTofAYWjY=;
 b=LH22x99cfMjek/JXu31A15S6sbp6AuoqxQ28bdXE7fuJCMVXhjVxT8sOAi+jqhe0HPCN
 EFL7b5WnEoAd82eJS+i6wEZPXztUfJ0XkjSnKUW696xxAuqTjLDT+7vOdzLjJpXTKOUY
 BVWVKe0zEH4lK7kn69o8Nd0F00/rM91u2jJB8ormg0nZ0pY2F4snu6m5aI4gbsimWmKr
 F9EBS/woOP13pj3sTaDP5VX4+0mIoxgBgfLWMS1AdCzXNTJ18FqoqL1UMF10024+bEoF
 6Y5P0PoPUhMG3hRN9JGMC8xFWsE3CTg8HXitZIx+8eg9/zWbrPrnSkBIOOBjFDJCNjVg Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aceudt12v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 07:00:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C70W0c001415;
        Thu, 12 Aug 2021 07:00:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3accrbkym6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 07:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZHxIf1E3aY5D7ZG5iyyY2RYX6hCSvbn+zMjFCDt5+As8LdlsuF+3bJRBOzMdrrnztGmix8bPjMnF9UOnLJhnw5jde53x92yx4qM+w4+jL28tUlwlrJ/EkSUkYBC7yj/PB3SxT8UXD6jzzxBoC4sdPWX4BCuVRB1tZBcO/GpHWCiP66kXm90t2wKFp4HX3aAuSjL7aaOdjo140zH+a63BUkfxVaTSjqWZlC/oc4luYCGxZ6CMRwfWgLTIuNSjMG8uUlPZCdgmufWdk+ThBAy9PQwTUBnYvwSLzG1gI6cqvQWDYd68jIuqmMXmFWYfQjgTDcx8NViTDwhT9z7Uy2SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1VDkqfaAPC4gHEnFj3L7sx5zUeBPmzE+4dTofAYWjY=;
 b=hckVLDfliQyQPgaHAHspg1GJO8u7H+KcCvNjPSj+RB01FA3qIBFSFnf7R01h3XR0Vax38hdTTqHWsBPUdmAnmaqo5YWFEq5qj/1a9NJq+dgIdtdfwGAsttdwx7sOtQpoQdGU+cvXaMRmYSi+ZG4uXXkBnE6tx9OqPy4+kjfs0YUd89w2z2i1mOuhc9F2tUB0f/siiLucsClEpCv2a8xrbAtCJdj7IWNZ4F4fJ5vQxrf/Ggv+o9lQGmjypzW3y/QiC5jcl8BVpSK1ccUPshRbBDf6UX88S1EJXpXJtCvFBiQfw8BHZXTNMYCWhkAqTxbxM8aMdoHVxpUleoq0L6SoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1VDkqfaAPC4gHEnFj3L7sx5zUeBPmzE+4dTofAYWjY=;
 b=UBfeRkfLrDkdoUdzjZWQUvMo84Pxs4O7/ZjkIcXG3RjNkSEsgaiOiDHqoAk8afGLhuE0GIK7FbhqX+t4TMxu2Yq+j8HTwwL4pk1PlW6PsOs857zea80Fj/I6MI7vztd5k6Z9z5TO2VIsqG8cbADCaEAg1FfIUmSYJ2y8uSiPrj0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2093.namprd10.prod.outlook.com
 (2603:10b6:301:36::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 07:00:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 07:00:15 +0000
Date:   Thu, 12 Aug 2021 10:00:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: fix a scheduling in atomic bug
Message-ID: <20210812070004.GC31863@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 07:00:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b180ef70-4a11-4bdf-de17-08d95d5ed650
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20934D5D6C4F0FB107C708AB8EF99@MWHPR1001MB2093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvRBVzGgwVSXskwmTNYlIJHKTlATVxXMH7XVtfVmVwkdls70AFYYNo7Rbjk9NSIpOpo3/Po9FiOSAVZ+10RUU819RVhX6GODjwgpA26d6BHsjWSgVTzdfB1KqsADBVPXf4h45EOz61LG/scib2zoX1tjf9Qx4/BXcijUnVHQeOvI/A/aQfu9YPKI/OIgPsNvg6niciffl9D+Xmy9RZ1Sdsku8GJ/6oLBr5hEbRI30k/rebnBnB7jVfzTA6vltlVVZdLWw5EpRhNfeNCjxeQhNJJd79cYYC3mmX3JDEPQ2AsZjF8HwYq5WaVzneZwqysuNN6QsgYpLOnbzQZ6JbPg3/dCm1F8l74KTvtt57cbmDu0v9p+mclpPTuZ9ye7LG/m47d23JqvSyiK5ejgC+IQJg9tZwelMz90UBLENT6Psmt/EQkIDd+/NRH6yvXeOHRx+oxl4Zw/d09GD15ybSlO4mWIvvQp6bWvXoC3/F2Vh45BjsY21CM3+dVh/X2dfAG3jpapGY9xiLkp6DIY2fFZ4VM/bd/0/7qSh7cbxd1UZXwhhy0P1nrcKRatzq+mmW9VEOtsoQS0KMmWGvXmX8fQp+xIW30UINYpV7Sc7HRfywcbD1NcZxkbX11rdMspxyQiA8/GUY2mfZXtxxg9J0etUaW3ppULrxJuesHowHoeYjHKsG/+bRxVn3hE38y/bwpxtTKN80u7TP/WWIL+BGeX/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(44832011)(478600001)(1076003)(8936002)(38100700002)(5660300002)(86362001)(110136005)(26005)(38350700002)(54906003)(83380400001)(186003)(956004)(4326008)(33656002)(33716001)(66556008)(2906002)(8676002)(66946007)(316002)(6496006)(9576002)(66476007)(52116002)(4744005)(6666004)(9686003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dB2rHcIswTSDKhhDfys5TZf8Eb04sK3tC241xYf7yGOYJEvvxH+shoJSOQEc?=
 =?us-ascii?Q?ctLGX424HUCfS1meCEznfPhVr7wVm1qlRgUbuhUlv78K3BrQOgac7eCcNRXS?=
 =?us-ascii?Q?W9K+rny/cLPGgcR/XDnSEF38PiQdaycn/nQ4Yt1YKCdF7MqRlGwZeofaYLN0?=
 =?us-ascii?Q?8zIm8teiy5EzsW/S3AI2G/jvaHPH1sW2Osn07Gw133aslSFaVT0GUrx9fkRm?=
 =?us-ascii?Q?6YW+65YOgqPr5nt0FEJym4u0Ja6FAcMSDocdh7i0jo4u5tV+zvFCTlJ/Lavy?=
 =?us-ascii?Q?KaA0NFvVG+7iVj4c7/ptecM5MJn1dd9Fa/TEIc8/QvKf2lG8g3LOvRl+lAv8?=
 =?us-ascii?Q?2YPUrC0ogvk56NK/Axv9xV+24ieqFumD+JLVz9M/+WvjX5c8LAVodNPgYGSf?=
 =?us-ascii?Q?qJm7JG+m54V8vgfspArTjNLytAupQvgaDOKn3FIQx5mvJo4VYXJrwsanDVIp?=
 =?us-ascii?Q?y7UU3JP7kOYmrP21BcHUDX2cQraTJlFx439kqtycuRLaZ9gu6iB+teWFq2V9?=
 =?us-ascii?Q?P1JqviZCJVLb4pognBM8R0t6A/ZfEvqzq9/qWNMYuEglQHrKxjg13b3cj7fW?=
 =?us-ascii?Q?YWlhZJse6XKQAFeitc0LTD808ExNHG2ZJeNwiFBHeChx+jzo2QHpVYrmAY6T?=
 =?us-ascii?Q?V52TlNlcTowLc0rY5IfZk//w8N1hypzj2t8h6MqrN76jyTSSAa3rXidQ1vOc?=
 =?us-ascii?Q?y6VVFhZHNHgFH68Bj1iiga443JOnFDmTgPAijTo4JS1CZCFCyETRPS5Qm/mw?=
 =?us-ascii?Q?ivlLWsbvFcDNVbBX9hOgJVM+1QtWwlaVw03d4OSNy2hg9RgZ4oqBsYUWqjWQ?=
 =?us-ascii?Q?A36lxKrOrDPEzBw4QIlHJFDFwYInbmPh5k0BqLMF7Cnnp3uhwre1mFHUNP4T?=
 =?us-ascii?Q?lQ98HpFkHME5Glb5/yFEX8tsNyUe3F+OsqGoDvo/8/LPoKD22VphfHBNaqPB?=
 =?us-ascii?Q?9+iEgiIATzSK1NurfoHZL8j6WFUdSHQ/fOAllSdBCqLkZ8AQcD+0DbiGJIBy?=
 =?us-ascii?Q?kuWdMMhwa1g1Nsb50apnrAz5GqbdBTI8qNruE7s+LPfZKUhsKF/7N8dJW2zp?=
 =?us-ascii?Q?7IFdMvURneTu3RgWz7ZQIm3Mg48mnNUb1ssyvx4NKWAWPXsqRWo6reZZT7zQ?=
 =?us-ascii?Q?cj468qe+QXjnS61pgZTnIX/lAeM3OW2wFnN891f66t9Y24Vw5JFg5xiz0Jwy?=
 =?us-ascii?Q?ytz7fExby1L5jUNNEcqCJAPXx+/mvGevoJO4zp7S/JqDhEsbuHS1+zzOOWeD?=
 =?us-ascii?Q?cSyqq1612sQa1ppzoZIm4/Q2FQRIqyrokbhn3Z1e/Xbz9HbFkYmKMUWb1Fyt?=
 =?us-ascii?Q?vU+DI1fIIffQjyzcaHZedbbx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180ef70-4a11-4bdf-de17-08d95d5ed650
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 07:00:15.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i328CzvW9auntRCTX6ek9r0ASsBfr8yCTSElJzR4LZnDJaoK/vIAazGomFPjl6hE/52RTb8MYzVsBcuaN1WlquqX4L1LdyUz6y7fG28R3JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120045
X-Proofpoint-ORIG-GUID: bRWWGu1ifkIlLQyNZKe8aITPqBITm0TL
X-Proofpoint-GUID: bRWWGu1ifkIlLQyNZKe8aITPqBITm0TL
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function is often called with a spinlock held so the allocation has
to be atomic.  The call tree is:

pci_specified_resource_alignment() <-- takes spin_lock();
 -> pci_dev_str_match()
    -> pci_dev_str_match_path()

Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6714c58ce321..71baf5ff48fc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -269,7 +269,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
 
 	*endptr = strchrnul(path, ';');
 
-	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
+	wpath = kmemdup_nul(path, *endptr - path, GFP_ATOMIC);
 	if (!wpath)
 		return -ENOMEM;
 
-- 
2.20.1

