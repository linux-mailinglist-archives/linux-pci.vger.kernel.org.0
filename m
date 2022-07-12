Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28FF571CD6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiGLOfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiGLOfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 10:35:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95BF2F38E;
        Tue, 12 Jul 2022 07:34:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtapX016696;
        Tue, 12 Jul 2022 14:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=7ik+6uwlA2XRg7FmFlkEdl+wAbo8urSN/dk82PWz6Ts=;
 b=WZ1b+pskuIwFLdUSAGlqvFylR09C2CN62pykvrmQxwypOguIfftSuxQ0ALGbrk0GZ6oS
 2XJw3KswUpxDCkQXCFUoD1X/3a3I1lB7x1sM4bmMyB2vF9Tvs41oGrHy8BPNx3clOJqV
 8SBjhT/gc7Yu2c2Y81sfYRmgXTaz4mdI9uB49PwgM7JMmIk/xPICmDYf2gkLM7V6JV+q
 QTGWZPMEmPQabfshVFsTA+5zxJvRzE336QA73WcWSuVzL0Tjvq/9U/G8Sz29dlR/9K5Z
 swdINXz2wPi0vMdzG5cIeAd3DXIFPRsI8Xtr0H1Q8rdHUeVdHk74+xQuQXPRjWupyoh2 Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgpp3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:34:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEFk4B009035;
        Tue, 12 Jul 2022 14:33:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043s1cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjrdLiWX7qKR0wXBrZOZcYCBms30IEYTBQz+BJNlRPeYUusGXzdu1VZl+phar/bgNe8TX2FPWxJgzMckdeKfV+SNt7l43Tv3hMDmb/Bjjn0hl8pioS+/mFvhI+W/L2bJmvN+HeaL3BWr+Zg32JMZbBqul2aCQ743x8VF5+4SeOI4dxC6OCxpuipuCbhI1Xj+DjVF+XJ08VrkRDWAcOtNxjha2BF3FQvrKHlkxCW0ekB0wunbT03ZIRbx/wxJkBVAzY9w4juh5o/X962YXNTHrijIO3bIHw8dvCpWuw+2MX7HceOhSh+v22o49Lsgd0uLaaihr0qaVZQKvAyYZ9+wQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ik+6uwlA2XRg7FmFlkEdl+wAbo8urSN/dk82PWz6Ts=;
 b=PZBh5RNH1RccOl6WgxIaHB1Xv1Tjv5e/5gdN1Ae00WsmevUI62mPyrLyiwQrvKy6fHmaKOUPeaEJErO2Zk80a95CXDgvozEvrP9ldiifhTskjBshO8+o01wAqt1K6pqvPamCG9zhZW2DKLBfjUYoJAFkMvkdUSokLqG4/KfMdJeB+zxUzFxJ4YhbhZjrblDdHJcizRvDd7CHJ7Pe2d8CvF31aP+lJIavb+Fgb74JIF3Gx7G6KDVKXEVp5e1+7la5/4eV1hoToC7Lt+J61F5mcU/Unm/vyhiJVy09JpECDOYgTttHU2uA3HaiD8Om4Lp/6V4hhJ+bgUAVdE8xdYvvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ik+6uwlA2XRg7FmFlkEdl+wAbo8urSN/dk82PWz6Ts=;
 b=MlxjUDl340sov4ljgaxv7q9SOwwh2XdCOoJhBxDZJUe+y6D2xstKMVtPoWZtzXKLW4FlKMrQDPp6Y5nOhgS2w2NvZgRy3Quur85uaEWVxSEnA/TudZAjLEJbd2Sw7BLiimNiTGwIo4DDb9Sdd5wMy34TmcP2+vGfHmLQsVIFf7I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5568.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.24; Tue, 12 Jul
 2022 14:33:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:33:56 +0000
Date:   Tue, 12 Jul 2022 17:33:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Shunsuke Mie <mie@igel.co.jp>, Li Chen <lchen@ambarella.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: IS_ERR() vs NULL bug in
 pci_epf_test_init_dma_chan()
Message-ID: <Ys2GSTnZhuLzzQG5@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a73ad22-7920-4b30-72b4-08da64138d73
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5568:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfFS7qPRjso833fBPRmpycIirJdaXVk14vLwpSjUBUgf3qNQNt6rk/g3HVnKZoipkUSf1gyxGqbKhkzRsZmYuC1sgO4tzCKc9Nr+xJ0R+IJIm5WKzxrNYQXuvsT3xS0DB22ALCHEf6P+90qcK189v8GD+jLHwHtYaPyIqCXZPQzuCfol9/4AqPPANhG5DVA51C5KGeLl3angkP0gcne8H3XUyrRXuLmJiSVGsySsT3ouQd8ynjgqDIZ6oyFt/3gv/sJspmIs1cDJ3VWC4NFwOOf0VPbE/rP/fexkD2pHRI0djHGd/5aj509t3vEZNeMNwWZXNkj5f0SbazpGcw01FcfY6DBy2QyJrEZY27S0rPjxUT4/fAfW1bM3hVZfkjrf1u5P0zS/6z5kIBRS9RaOvJomua3OLjB9aUxaWqmnUQ8cPDTi0FWmcRoagh8N4pYNND1mPe4IvuNZ4klnQglI6ZCO5hpyxHf74e2qKEOOnxVhMeqXZdadWshbOvDZIW86GgdQWNRpXdKl14nSa1U6afxM7xfcxM+f3B1wMKdRdPvZfewV+zNYcZkRfbFEEZPoT+Yb/pQ4H6shJa0VJoCZf6CAlI2m8ty2eaJn/U0fSojXE6EIpwxwOctYD3o1v02F93uZGjIYGN/OViROpl/okUf6tqpMrjsD3ZeQVWUyD41JKbw7Pe5LRpxrWrey5YnTmJ9zEoJ7XuI93cfElGPXks8BdtB/xWRt3naS9oocCT8scTyje8yQoBaxCK/GNzXdd+VjHJmjgvWd4ajeepiP24jfneCI1rRBH+j54yULwELHarsUX0qh1Enw5xk4OqU1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(39860400002)(366004)(136003)(83380400001)(7416002)(86362001)(5660300002)(38350700002)(8936002)(33716001)(6486002)(38100700002)(6916009)(44832011)(26005)(6506007)(2906002)(8676002)(54906003)(66946007)(66476007)(41300700001)(4326008)(6666004)(52116002)(316002)(9686003)(66556008)(478600001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzDpIv83cdxDVC3TvkIdNMdZHo8GVNHTgHUjMbO9xBxd8INtt2doArmc6hjO?=
 =?us-ascii?Q?IP7tm9l+XxXcXKvq9sdIh2qR37koG32uVtSWgCBsKT7+qrYT+Rh3rhSoiO/N?=
 =?us-ascii?Q?JtW5Y6M72h+SBDWY3leAFhe03K661f+X+x0StiXFJbmZaqhNxmUHSZiyyNcN?=
 =?us-ascii?Q?ppHjcqbflVB3LEvQGaZgPvK2NgzNaLaI+nVl1j2PxJ0GSaGHZABUKk3pFWQ3?=
 =?us-ascii?Q?IF5MC2nEeHTso8HJgWydrXDL8eJDyB4LU8MzCwn1TBJMCbT5mI2wTY/N87Op?=
 =?us-ascii?Q?nsE/Z1eA83RHfUwLkJ90zx5jXmk+zwyxf2fPHsiNaIL2wKdzjqd5/tCIxkhm?=
 =?us-ascii?Q?VNHcnLKwGltrVM7KWr2o+0UDif9chFY67MXP0VRTWQm+rmArCuPshb/g4kyG?=
 =?us-ascii?Q?pqOCtarFhRkexop/EhUKnG8DaXRVj9CDZNPFEEDC+CvdTCAGeLbrpQivxXBK?=
 =?us-ascii?Q?QlEWDG1X1p30HFtYxVEQtdyIfsuEYuhLA3N0lU/w2iAGNxOha22P+mchKk9O?=
 =?us-ascii?Q?YbfxCuZQaLC4quUrtuUjL+eis55CEE1gyTJfSsYucLKvDmnYFZ/xAw8z68Z9?=
 =?us-ascii?Q?E+7Q3YyGNcT5bb704tyczhSIB2lkVyLJfYTiARwItE7/OMN80upHWaNfxlx6?=
 =?us-ascii?Q?yrB0OGr30wXLcM1fPWJD0Emaqe3Tr5IKo1Y1MdEI4MQ3Mv+qBq7yNtmQEiQR?=
 =?us-ascii?Q?7QAx0maxBRya0v/+rLhLWwTogcZX5H/T7ZRIfXBA30oiHp8xvM4vL+BF6GIN?=
 =?us-ascii?Q?CqyAL1exg9YAMjazDddOe8wOONDH4y5xbSq9V+xlhMAyQpMUqQ36s2HSu375?=
 =?us-ascii?Q?5cEI5SVUDyJw0WJ1pcMRFyAnIlKCRk31p3kZLds3DqvnAU5X5vQLsGotyhHB?=
 =?us-ascii?Q?tAwlq9qHlTz1379hQwcKsKNDwH6bYFwdFP7ss9dYs4hcv4r+aB3XqZuWxvYO?=
 =?us-ascii?Q?JFKFwsW6CRpATX2zSOTHguk3h1LsnZLOv5x4fdnjgRXhce5Hw5v56P7fhOsJ?=
 =?us-ascii?Q?a3g80V8M60J5WRtKz7xqyHfkX0Lz0Ms2q/X1hhyGj2POwoyvfRFsTYXbADBe?=
 =?us-ascii?Q?b/8nGFbwxsl1UdI4EnDmKpQKagSAMCBn6zbhKAYcUO4Ac04V/E7J2AVPdpaP?=
 =?us-ascii?Q?BuiAMISLD2BAO0vuck5bXods+68xbJmGx2fukRKv2G43V8M9gduykCmEENmf?=
 =?us-ascii?Q?S2sV9f866zfcNbYZYJls8YT+rhzf+kTxYl4mxYO+jxXcWryhD91YpKs57DKb?=
 =?us-ascii?Q?YzME1tcwp1PJcnG15UloRWXPDnm2VggrH0K+R5VwnL98gm/biyCkA4FSk9pE?=
 =?us-ascii?Q?3djX6p7DlOCX9ewIhBdul8AT/eBtBoEehannsrQJ961ddDoaMaGI5d55WYZ/?=
 =?us-ascii?Q?k3NVPjkzNiFLVWnGbojNhT3hyJHOt0HWCnl4/KxJml/EymkpRpSchnafqhIi?=
 =?us-ascii?Q?ePbLDSqrOkBKIiqRRajJJ/ps670494lRNnAw78VFg+W5fbDITe6jBDkarwWl?=
 =?us-ascii?Q?j3VJc1FKrH/ADxDdmfn1RbiVwljbteZOM5pr6f5M2WhuYxu4CKJwY6Dk6Gxv?=
 =?us-ascii?Q?DqSzXh+W9i6AYmOTzuNbxJhxU9F7+t8Q9r2LqvDRNZTnoPV/OutrHtvPucKE?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a73ad22-7920-4b30-72b4-08da64138d73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:33:56.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVqnDvHSXiD8wGxCVkDVoUkwktnUupPVUC2GLX7sIoLkzKoYAa3g4OHUjRWaKb/4kg2gOVBOApkpJBSDHesfPxxT80QdRKnqGWVvYwXxpV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120056
X-Proofpoint-GUID: hkb1Ar-pwIb6IVj9knXL3KlEoU0zfXjk
X-Proofpoint-ORIG-GUID: hkb1Ar-pwIb6IVj9knXL3KlEoU0zfXjk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dma_request_channel() function doesn't return error pointers, it
returns NULL.

Fixes: fff86dfbbf82 ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Clean up the first IS_ERR_OR_NULL() check as well

 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 34aac220dd4c..36b1801a061b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -211,7 +211,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
-	if (IS_ERR_OR_NULL(dma_chan)) {
+	if (!dma_chan) {
 		dev_info(dev, "Failed to get private DMA rx channel. Falling back to generic one\n");
 		goto fail_back_tx;
 	}
@@ -221,7 +221,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
 	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
 
-	if (IS_ERR(dma_chan)) {
+	if (!dma_chan) {
 		dev_info(dev, "Failed to get private DMA tx channel. Falling back to generic one\n");
 		goto fail_back_rx;
 	}
-- 
2.35.1

