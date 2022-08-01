Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E558674A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiHAKSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiHAKR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 06:17:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9861209D;
        Mon,  1 Aug 2022 03:17:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2717YBGu022920;
        Mon, 1 Aug 2022 10:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=vLBAs0GUIskuVaMpmnmXrMmRxLQXW4oFTewZrqJ9Toc=;
 b=B4/AV8HGQuaRPKaF6WjaDDQfRfPDGFMxKqhI7iNIcP+uTKNq1uTmM58dUl7+ilk6usMc
 Y+IVT4xBXD45LlWMnidHbx+EoodAoizx8lWaPyavdksJshzcJ/mOTnasS2/UQ3Nk5nVN
 ffJySO8w0Aj7fN2Tj6sWWQ3x5W/floLsf29SXlAMyem9WJiEVtfudnkRbkfd7kBNa+l/
 NZV86Am/AwNaQyT8ENeLa8dgHfQDPmlKzpoP0NRXC2MmImzbLbfDSE/9wR5yif7gqQnR
 Tm/0irs2Ad/Dvk7eBWNzV+7sT2NZdjP7sVNwMocN9P2hfX0/9pWni11dEAoSQCx0Scb2 jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c37ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:17:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2718lpxA007532;
        Mon, 1 Aug 2022 10:17:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30vyvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4xzFuaf7R0Fs2mQNQSyV6KpcnKMQUB/3w3xi07UBSii/Z6DMu7ZqvgM7a6qBZJU3XJI5YkXsJNrdRmh7XY79blSY1G1VOQpBo35hBcT/imYK+0G2bdYMTOXm2mxIY7d1q4YAjiIS4EcOVeq17wc19E3uDBMZNFp3m7x8+n23HoeuFnQymCQh2g+lM0iUm57sWfiyLi7lPMWD9EYer6Wum8u0qTrCHH0XCWXtASI1Hcax8WYzLZ6kiahFGzTBxgGyq6vEziZrc1A2f/wvL30ipqude1XixowIluI5NjGlpIMbfhQSytL4fcfJw8CKoSq7NBDGhQG7asVuTcyACiU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLBAs0GUIskuVaMpmnmXrMmRxLQXW4oFTewZrqJ9Toc=;
 b=FcJs+dgqK+Oj/Hxwl2j/XCrbdNM5vgf1qVVNbkIRvl44ct1uqEhMBjEgh8j8php4J+zyVgOQSTqYrLESmwNd7aUMRJofJBvcY5lRwdGjICH3u06kyk0IkNC1LTA5IpU9gPn+C7UagBYzSCBOa+TjqJidyxJJZbvIKZGw9kbpULPgNIuLZAXyYQsYUkpGBs/upNnefvDZPMNOe1BpdgISVo2Sk9VVrcZZs1CH9Q/5CO05dVFp3gszoG1U8rirPV300fcmIca/D8KNh5KIO9153JNWkIn5sFlb+MXVKKLSorELp7WvK/CnbBqUjKpVW1A94k1umLq6HLPXta1i7iRS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLBAs0GUIskuVaMpmnmXrMmRxLQXW4oFTewZrqJ9Toc=;
 b=vzyDUCltBzjidTa5q0BCNKwcJom8Opg6439BDMRVbQWZLwhIzftfWoKCQ8iuVT+rsHOOKq2Z3v25G4JSDT5SmM5jlniPEZ6q7w2b9zCy9D47J8eMN2jPPW+OQf7Py5rIXX2F6WyfteW2LJwEwgzcES00uUojytNLalB7cEtKqz4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1314.namprd10.prod.outlook.com
 (2603:10b6:404:45::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:17:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:17:43 +0000
Date:   Mon, 1 Aug 2022 13:17:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] NTB: EPF: Tidy up some bounds checks
Message-ID: <YueoPDOseM1BGiXD@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuenvTPwQj022P13@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e40f76-3fba-4fbd-9c14-08da73a7124e
X-MS-TrafficTypeDiagnostic: BN6PR10MB1314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCWa/ArvRTW2MKYWiyAzdwr4VjtCZ5mm6kZdcdYCOAPI/xWgjnJS291AfQE+CyJZTB/ABXe2K3tyH7EGgKtNLmdz617udXvAP7JM1EhhLNWTQMTC+YTtgItMepKUrGCSn0lANJGGE5FmcDvjCmMkLLy1Lz38K2JFR2OSKjVwx1CKvirPZL5Sz1BimAzzAIxu4IiwoTnsoFh3wQOvmHDFhPFNx22QD+FN1k9uww2Ngf0QZjfAMCTUf43B8YCp8uNJ0adRMf0mfzp6DRpnvTe3lWVfMIKUorVO+vvzcuIHXGzco0zDnDVXH9szDBa5OzLtP+D+6XqCZhCsHLSp0gzaqhzkSQVTFvIYMd8FhOOKWow1yxnzq0XgENjPlkakpiQ4scjsv8E2b3fhRm5Sw3+LqF9IQ2LKZj8/kR404MaZgPNaeW5/jY69v4Z5FUPjkXrILeODy1M9a7UzMsCtCZG2l8AtB+3SMaUpu4xkx19hKAmAA3Y0K4y3L//lqfrNNr8spVqYMzd7KMCEiq5V0/LeXTkpm+mGaA/PfCeSV2zlCw4Ls/4esKT/B1+Iv1tYBWFsdaqGiZQmaXkLz8G1OEtG4q0YJ0UyQBoMTkjIduVX7cOmC3Ky6bmZKqbvWvf11N/1Xeq4OJBMjjalgMKbYhn1wSwXbUQ5QgZ7sewYx66gx1UTY4Ds8PAN0HxVsv2i3I/J6OvHY7N1jeHvFFI7QfmQxrt4tpTdy1EdEp2+4Pi0HLyELrlvnD3tCCO3FRLDmPiQ5VyJWJ2hOW2fJs0a2Bh8KFLj5dBGtsyG/SDsIMgig4lB9KXxtD5NrvHcqg8+qs+5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(5660300002)(54906003)(44832011)(6916009)(316002)(6486002)(66946007)(8936002)(478600001)(66476007)(66556008)(4326008)(8676002)(6506007)(9686003)(2906002)(6666004)(6512007)(86362001)(186003)(83380400001)(38350700002)(52116002)(26005)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uoXmZIXac7RDvG/cYxh18toO8EAuNZNhcc6Ft1PlD79A1dz03okteuwJ7ShK?=
 =?us-ascii?Q?p2pv3EMN1V9eXs/knDJYj5CVZjsKBjMQIYC/d2ky4wplZLaUaAdsFuvdFDLc?=
 =?us-ascii?Q?YZ7lgx/LXoT9uOavvENav2fN71p44EigqcA7Yp3wseT1259EDJFi4WeuPtRp?=
 =?us-ascii?Q?FLtnLTKOJO2xe5UFhpJz+vE/vxAn6SxWnSDV3ZaRFzO458rHPnPKwgM9zHDt?=
 =?us-ascii?Q?bvBsutFB+ilU55nLwG2KieKavMKIocrcL5Z7eRLnsuR32PToLRIdSk4vXhMc?=
 =?us-ascii?Q?4EZyf1On/qCLDg3WXmk6jPqu2+9payYMNxv0SZ9JKm0CD+pKWFI4e2o5VrMZ?=
 =?us-ascii?Q?HpdYPAO2uWJt+0HISQ6xBfZ8emv9vlmC5c/Fv2Yb3hPz2B2/mXsWtWUp9XQv?=
 =?us-ascii?Q?AbiAtq7DMj76JuQ0hNVCxgrVS5VprCKQhWZyKh2fXCvmgG2OKVmDulqE4HLR?=
 =?us-ascii?Q?xtDzp/SbHwbFi9Ry3GlzJYbRuDQ5aEoPru+FniB1/4dXhhAY7qQ01PM/OJYs?=
 =?us-ascii?Q?wOwiRR0mm+luhBdVfnB6EBF3G30HeOG7yaynZY62T8NR/8lA/MSCSvx9BWRk?=
 =?us-ascii?Q?tt2avYqE2Wa2JfqDlejgN1Jpfh32AkCxIoAgL9EZ3pxZEsY6JYBVey5Go5iq?=
 =?us-ascii?Q?3AESXdo6iGj7jPR65FDCDAiDXuwDjjH9WqRzMoeSyHcu5WjGwvpXMEJmHSW7?=
 =?us-ascii?Q?RP88WGzSbLqk6mzHlKxFXYSMqziea8jCZdxhosGZrekPZwJB7HD9RNkJQJJ7?=
 =?us-ascii?Q?iFRY+hjnVDQDjNyIQR9cSceE9oaydqCztZDlfZ+O9mddapHI0R+D3rGUWyuR?=
 =?us-ascii?Q?NGOPmD3KBVY9Yd8GzakfQv0UeWHOSZIwy2dpzOCl+9mxE9bMNihf7lGk2Wmu?=
 =?us-ascii?Q?0Lk7KmMsSeSpG+O+8IMu3pUYr2t3b/+NQF/d1uCaK6sBOW+mfBRazvzOaNlq?=
 =?us-ascii?Q?KsgbUIfELU6tb10EhY7fR+FJ8tQwNBZjz4LjUev8ltuMIQqZc2KIrMpa9LS8?=
 =?us-ascii?Q?kDChQdUe2GmOSZ2Z0vWZACRgk7UIo/cwg67CeLL+4loW/ba1NhgIa2koLLYW?=
 =?us-ascii?Q?60v2iKV+eHdj+pXVz16BjF6CKGwyrQNW9IwlBLuhsDBd48q2nVAbz4DKIEEq?=
 =?us-ascii?Q?h8fspsCSjy0M8V4++oUmfvEFBUJkphHYixM3yz7HDQV1zny1PqiEaDfh/dlC?=
 =?us-ascii?Q?QZ2u8fw7NEcS9n+m6yd7Bi8joMhY2Gi2Ka0isQIe2P1eX2Ed6zCbcxv7hL6m?=
 =?us-ascii?Q?/C8DgXo8aa4bxkzlUUBbsFrNrAhAUNxZmb9GeZLqTQXgI40rFfosEmqddFTZ?=
 =?us-ascii?Q?gSCig/lr5VXL3SPFAw3SZks65CHXZnFbNJuAyOt9LDs5f/41bXPdNSoMFmh4?=
 =?us-ascii?Q?OjlxUrTkgbDMeN5m3mrOmnqvEVbTvjCJ4FHNnjVClsYi5zxjTjOFwRra5SiL?=
 =?us-ascii?Q?JXOeSlwjsdbOf2TLoIGt44vfQrZ6RiM4J/WONmg1mkcKQYwPGqYlI0rNRowB?=
 =?us-ascii?Q?iYDEOj6nNWHlK6A5zixqWgXJzXr+tvPCipQURG+b/oM9N5G6l+gwPONp8SWm?=
 =?us-ascii?Q?bMssQyQq0i6IV9mG4e337LxtviH3EelfYcb8qrEJng6tvxLcFkXaf1je01jN?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e40f76-3fba-4fbd-9c14-08da73a7124e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:17:43.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfNIF1xZ1S0x17Ynv28JOeu4OARBrS9m6dvnmGGwQE59xkdQ/KvSuPDm2Oba+NOj5X7cWUeSFAj8X5VqyIAqn3Wcne3XG46e0qRwnYNruMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010049
X-Proofpoint-GUID: RiaMKeXYsPo-ocpM9jMFi75l-P1F30zp
X-Proofpoint-ORIG-GUID: RiaMKeXYsPo-ocpM9jMFi75l-P1F30zp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This sscanf() is reading from the filename which was set by the kernel
so it should be trust worthy.  Although the data is likely trust worthy
there is some bounds checking but unfortunately, it is not complete or
consistent.  Additionally, the Smatch static checker marks everything
that comes from sscanf() as tainted and so Smatch complains that this
code can lead to an out of bounds issue.  Let's clean things up and make
Smatch happy.

The first problem is that there is no bounds checking in the _show()
functions.  The _store() and _show() functions are very similar so make
the bounds checking the same in both.

The second issue is that if "win_no" is zero it leads to an array
underflow so add an if (win_no <= 0) check for that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index cf338f3cf348..a7fe86f43739 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -831,9 +831,16 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 {									\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
 	int win_no;							\
 									\
-	sscanf(#_name, "mw%d", &win_no);				\
+	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
+		return -EINVAL;						\
+									\
+	if (win_no <= 0 || win_no > ntb->num_mws) {			\
+		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		return -EINVAL;						\
+	}								\
 									\
 	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
 }
@@ -856,7 +863,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (ntb->num_mws < win_no) {					\
+	if (win_no <= 0 || win_no > ntb->num_mws) {			\
 		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
 		return -EINVAL;						\
 	}								\
-- 
2.35.1

