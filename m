Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0851586743
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiHAKQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHAKP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 06:15:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E835E02;
        Mon,  1 Aug 2022 03:15:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2717YJEx028922;
        Mon, 1 Aug 2022 10:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=IJ04+4LvGVtuAsuJ6imEBnusX+BZM/ZejEhNUxgSE58=;
 b=ZLmB5C5/nuZ1YN9gkhU8IknsBhGQCAq2U5C/zHdb+ZVrhssQNA3kbiQ2M0rc/MtF1QyD
 ot/vnKn8V8do6R7soSkqelLqglBZLO0/LqkKAL0CIJQkTpd47ozFLj/2EkCC5zJnIqOv
 1r98Nl0N3hBdBt/7P8ea7U/suXediN8ZCNPtcVrLWnCRoTY9yLS/9evTJVIIyRJkdL3l
 hfH5aCfKyDFSvMte696larPzdUQtHqquMDf5JoIxdej8uqMoUy70cB2SDjAj/3ZxTAj4
 Uoc8nNlr0M+/NV9HRc9nMzM38ixytF0jYMYDc8fNRQeMYFYH0b8m+4ZRywQQrmext8VO WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9k5p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:15:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2718nDMV002952;
        Mon, 1 Aug 2022 10:15:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu314dft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8woSQ8aTYRr33GesElgCtj3ToDm0kqtZ9g9a6fz9W7bSNADmXdZ6+i2mwdIpCihC7Hl7/M5kI2TTMNZmL+xm7d4nmRCLgD+ub9TONXAKMkCw4medZLAoc0+xqOgMxMy+QpgE9bCP82YTXzAXdfcQWb7Zp8U8EYyyqS5OPf+GhBoBTK4VKgU/AuuKttc5uXAuMvoSEFqCNAtdg5tRZdWurwCO7nhcvz7eFPaKU5Zn2Ha+s6IDC39U1K1lJN+R6FJr3MXo5Psa7JFVnUxJq9hoBgyb8fhrrhO7RK0tso1g6QqC/vgrhCNUjwrNBbvKUSgj3LAFGdubdDl5hAGf+kL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ04+4LvGVtuAsuJ6imEBnusX+BZM/ZejEhNUxgSE58=;
 b=lYZrgDFbPvPjXlcak4o0Koetixu8rly+KXxPrnsDMPui4HEpfdVJaX65BnIvX6uYvbUeKmSo0EGHOWne3tY4Y/54jm438a4YW7K/7Swm70+co2EPyinypBmj5y1k26jm+xullKizyA8s4IIIp1tw6nUbrAqcpzV21haa7WdmZJQw8kJrbbo5NxaExu5gIff4NtmZgTeTffhPFZg4AklGMSOdsKsyPJ98RwOYVg6XoAc6fK5HWzFwgzMvtrTv+tUFYQPMTlAoMbt0mg+0XWXk07BvFgK1vapvNUvM5Kw3ACr7Ih26MCzLj6lJSCiQrMdT6T8NBZkMweeL27DPUt8YuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ04+4LvGVtuAsuJ6imEBnusX+BZM/ZejEhNUxgSE58=;
 b=Y7xkkrsn4zHzvIWjRj1fKUP1rpiDbYl57WvAA0KaSgIEyiwYIcBWPiptbu1CbWQvN3Xh7oTL5As9O+sKh3ybw0IWXjR7na0y3Q5GCfk3RPDfxwVfGMcXU/8iytozBPeJ5L8iG3+bvmNBSCmNoG/6ksMoWzwsq5SY1wE1yRp0+u8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4253.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:15:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:15:37 +0000
Date:   Mon, 1 Aug 2022 13:15:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>, Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] NTB: EPF: Fix error code in epf_ntb_bind()
Message-ID: <YuenvTPwQj022P13@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c6556a-476f-4009-d66c-08da73a6c71b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltZLDInXndXPyeGsSdl7icPMyt0z4dnvY+oDPdhUN6gAVtY6Bq1z/fmf/wu5TH7IRt7z3yfsbGK7jO6rrE2aX0YW2XF3olIjAJZmBQr6Wrj8Do9JPujFsPMluJA5KtYUHcmUWK9eeKnxgwm3n1VfWyZ5cJ5J97z8ODU5kJbE8cvkL7wL/suJRRhDR19YK0bG6QWOZ9hoAu3LmpKBrq/BW1V6omZkpm5nDl5XgcRqcEirc03nR4KRs9QDUS/PkJYjVSlKv7BCE/6RivbluKOySnCU97Dw8EodmjG1K2cA5L0QJPItigTBnN2AGZ63q2WpDLwe3ifMXFup/gILPuhjyqldVVoPVuJxTGBe+6IEtKM74dNj1bPCill4F17q+eIwvDKmy+t3hk8br6Kg09v/FzitGxMW1NSQU0BxfpIoeztrvOZrXNWda/T1wG1OxgZBuynrs0zBtClVkKCFE6yr4Qn3qwCpZvDtmyA41wZmDZsb0vj3hcIEy2ypI3H0Virjd3JarerUOyGNi9oNnKG27qFSmEHfoj5s12jwLwDyZVZoBEKlqndlEJW39CF02moT49HRQ11g1SW5DTKX/tfhnft3kuWoFVO+3gz8Etqth8/iKyIx/LFvCeFIoKPoUTip7CQWu9PwT8XXXyYv8ww3Nrrl8M4jjTno/gdRV37/XJJAPsHgDCJK+l0f8m4uVjTO6nykF99llGA98yCq7sSZE6lj1cRv8GaO4sn+UCdGP/sxFla9TRDUryFPzc9Qq9DkBmx7kF1Px+fYFgShJ6MappcNbF+eBavmEyd/y2iCRW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(396003)(39860400002)(376002)(6506007)(6666004)(2906002)(6512007)(9686003)(186003)(41300700001)(26005)(52116002)(86362001)(38350700002)(83380400001)(33716001)(66556008)(66946007)(110136005)(4326008)(8676002)(38100700002)(66476007)(478600001)(316002)(8936002)(54906003)(6486002)(5660300002)(44832011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LoltuVM7MIVK3kTUgg7AKu3cPAGhhc3ZICCbZR2oPNE7Hrtr2yS89tVSsWOh?=
 =?us-ascii?Q?hWcpQo9/Drj+osUj8pbeluvG91JGiyiJdy1V3PzImzvCdA3l3v3JjszEVcZJ?=
 =?us-ascii?Q?QXp3Er5/OHUs4pDJoMvpTZmqjj5Wuk8bCGELmGcdHpYUde65XMHh4o00Z37k?=
 =?us-ascii?Q?joBnsLYr9Jas5cy8A8/sX+NIZi0dHe0zjanVOHexOpPR9YRlykz9EUN+P143?=
 =?us-ascii?Q?Rps5ZCtRiGXYJkBzrQD0rq/Drjy6uGXAQCQnYlXrBnH3Edz1n8vRks9RlPA2?=
 =?us-ascii?Q?uCDoFguBTUuDlUuOkamddpraI4wbH5YVhp4e0LKfKSmp/5529eEKDAuEZ/Nw?=
 =?us-ascii?Q?QzVwHndputx0qUNp0dAg+kMUIC+ID2G/aVh/o5gODf2ZmnJhMfPvwk8ufdye?=
 =?us-ascii?Q?8tztvT+oXD6Xx8bf/o8Pki/ny0rcuoYmdoVVStSw+MKvrX+lNn4tnzMKsewb?=
 =?us-ascii?Q?swFbdsDYnjkey8t+68eMJRmQJGMZbyYVHbyccxsIDoEWUOix4iZI26NKOQFK?=
 =?us-ascii?Q?XShhr7GS2uTOAJEZ7UZh79BmbX+LImhGvXli2wzzcUUe42+i8jtPtmp9LK8K?=
 =?us-ascii?Q?RxbqOZsn46TUoQw10Z+c3VawJsM7z1KHhyIDEMhzv4W8vhO8ATQl6XRgPa0s?=
 =?us-ascii?Q?nHEw7Hnp3nF+lMHM0Gu4Ry/ncmBUqnhiRgSBAlTBbQUEGB2YtFjt1b2PxDcQ?=
 =?us-ascii?Q?AfymHBmjRAjD+cga+aG5FJGQA3krYBqU3dTC1reRfu4cNugvjUdbI+sJL7ts?=
 =?us-ascii?Q?LyOo8EewgJkUm01Cw9NrUj1ABUwdbsBWnjk5sSMYIqHRIVygVT29DpfsNFDU?=
 =?us-ascii?Q?7eAZKrPaIynYiLJrkmtUQmtj3iInITB1Ch0Acb2BWRoZpPCGiesJ37fgWl3B?=
 =?us-ascii?Q?V2pY6OEb2MPzZmWMsA+Y8lE4uoE8NgyqO82LkEqNYi57tTzAb/dgRho2bAwB?=
 =?us-ascii?Q?9bp3ObsQcEqUW8ZP8D937Qfkx86b1htrEf9USm6EVVngH9oaNuZtFs8UUxX8?=
 =?us-ascii?Q?sXhyGaE6THGhpJrZg0TznrHrrLk0lPtSOnKPUNpdPZE5+EAfrFGW/tbG/Fbf?=
 =?us-ascii?Q?PYYQsHA8ipV9Z+/q40VevntpC6tySi2de3FJxwdXCDzsM7ll6RC+XSivzTX0?=
 =?us-ascii?Q?+Q09155m1qrvhVqY0WEFemvJxSb4J+kA1nE0jmHCJbQJyx5jB5+sViWsfLKA?=
 =?us-ascii?Q?4Qn2ezCI49ly4qirDMg4ZhOXcAG2gn2ZnmBevRDzUejjWBLzreo/LcjiXmFo?=
 =?us-ascii?Q?DLt4sPl4oVexFt8qsvKz8I56zqZh877XofOr36ejdlOGVlp+j3Vq09aXD4Xy?=
 =?us-ascii?Q?BYKGULgmLIsegUsJnoX7IvEdAddmtmVKEZC5wTMfXQgQyroybWWKdHP/2bum?=
 =?us-ascii?Q?daBej83JfkCjHJ8c3O0oAqd4Lf4a9+FkkaLTdxv2JoCoL7ZeRFNmHgCZiy3C?=
 =?us-ascii?Q?StUOgymkiOCoKz+Qmpum18GB+W65TCSBeUeEtKke88H04qDdS3HrrGF4Bzc5?=
 =?us-ascii?Q?KtNZvJrRwr/o9+Iual6tfIBZiEs0u0w/Ep1TQ8ABHGZY7BESkaBLUAjKbYSq?=
 =?us-ascii?Q?TssuKD+dFr2pkN4qIPS29PKoV0i3iSNMFCwydeJ9vBeJJJ6cFFoVdHabSQPO?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c6556a-476f-4009-d66c-08da73a6c71b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:15:36.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJ7bE9hgjZlqhRO66DKl9OnDdF9AAlWCBdzwZyb7Bp6zYto44qN1V7z2z6H7PBMLfBMZ7Baw+Zc7J+ObWR3JQrVeThQHAY2cx7GhR83aU5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010049
X-Proofpoint-ORIG-GUID: uX5-dD4IReW0s-EukeOFyaGOB7MOlfw1
X-Proofpoint-GUID: uX5-dD4IReW0s-EukeOFyaGOB7MOlfw1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return an error code if pci_register_driver() fails.  Don't return
success.

Fixes: da51fd247424 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 111568089d45..cf338f3cf348 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1312,7 +1312,8 @@ static int epf_ntb_bind(struct pci_epf *epf)
 
 	epf_set_drvdata(epf, ntb);
 
-	if (pci_register_driver(&vntb_pci_driver)) {
+	ret = pci_register_driver(&vntb_pci_driver);
+	if (ret) {
 		dev_err(dev, "failure register vntb pci driver\n");
 		goto err_bar_alloc;
 	}
-- 
2.35.1

