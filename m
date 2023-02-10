Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0E6923F8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjBJRGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjBJRF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:05:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80A70720;
        Fri, 10 Feb 2023 09:05:57 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFNAju026460;
        Fri, 10 Feb 2023 17:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=SfF/+JvXJIe7TrW5O5CGwkn5lgBdh2A7oaweIHS6nP4=;
 b=N9ZDsNZL2jv2tOuGhcoPilYWmI9QQfeGuoPZqKT+ZorUP1Jts4GeX+uwxLdm+Gkainfn
 X1RUIVxwW8mcY4DPwdiP23Hls6z5w5c3iYLeGmSwSSUdU6RZbJgCntsqyKf4vWkOOrCQ
 D9F7lL/a769eyg/By56CHqF4AQz5t/hUauvjyuqnuEWwb0KOLIRXBqv81XVUa/qZSh/B
 w/C9EWJWw0/oJ74oovm+SsynUgrnMoW9S7BkNQNdkCSnAXgqFXqIjnEKNPtXjc8DaH+m
 SaZtKRav9EE8RGsBrk9ZrCNDVqro4zpdzPE5mBLtbyMeDN0IKeOLcKyi7mdgJg3DIXt6 Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nnrfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:05:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AG6tQF013782;
        Fri, 10 Feb 2023 17:05:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtagat8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJFbcqvVYpQ19fXeWT0wSYgRmPSMGvosr4U0497v/OSzXVc4dYDVwgdviJzRd3JdqOI85bPHcbNW94C7IB62MISz35QLv2xJ7l1dgTJPEOc8LFyRcfAnvf7pdOml3Y4vXVTfXMMCumFpAwwqTDrOzFwZ2W51OoM3Mxl+sduyCo+F3qelEiVWDTLDfnskSjIGra/IhVL3be0jDqraJWVOhIhyZC+rhwhJLyJwOrq+7SiPKVBtTEqYzfoERbaUEQ1Mn589/z8PypBgbdJ2/leFP0AeBI9rr1eRoO3daloEmu4LqkHIjeL4wYQeyFgwWV5NDat5ErA5yYXJjzqLasPR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfF/+JvXJIe7TrW5O5CGwkn5lgBdh2A7oaweIHS6nP4=;
 b=g4uAuc9/A28caLg59Y+bJZr2+Qi04/vtCiNhQS1Qfw4a9R+Hbd5mYGRoSSNPcq+MuNuIyGCOKwfcbRvxBXT0ROAyPMadKYp7Rj2QMCNHgIYylP0atr3Xv4SRpH+bm1MgNjODDJcVEWKj0BbrXtJUPEKQi+eOeCrMNRVXWKZaeToJT8oLjFHuI9Z7c/CpJnWU3/NCQn/ftGxsI/PTQrIlb1+4ZwYHd1D+rrwPw1Tpt2IXUr58UHF3JB3qWg0n+XOYY/zI0OMDAbzHrZyRsZfEOtyOJ5PRL8oQPFOjJhwyZF57QZtKeA2CeDtrdKqB6/N+AhYoMm7tO/pry/6rrBJ+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfF/+JvXJIe7TrW5O5CGwkn5lgBdh2A7oaweIHS6nP4=;
 b=k6c0j+fYixWKDgWpo/FuuoGMxMGQiYoaOpxnXUnO5h5ChyQdeuvIX7/InHG/xnxsqDiH1+xn8bGduz3112/OsEi280fcX+yfVlzvhpcquQO4qLdVOf/xlbLIVjo47DmDtyIK/QL+Ph/OpSubihOnCCHTgtkF8ytaKwPaCf+nKQQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 17:05:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:05:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:42 +0000
Message-Id: <20230210164749.368998-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4225081b-b210-425b-6daf-08db0b890ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLVbS+8+6YmlihDX+IuYDUUikbeeAMfHjkeOrLLaSD/QNBHW9kBJLFOVeCEu7wTSqjOhr8b+GrLxiRs8ZGRh5/aVCD2B+/IMmDh8/hs92nvC2jVJRiZL0Gq/Snf2G4Jb2jwluUaLhAzW4V8oLaxyxg9YnjJoEbscR2viXJ0QxYU3y6D0WveKjLbaMpDtaxQUqVMJx5LS4N6dGijSQm6d4BWC1AB2Htw7SASA7V9TycIs7rJaFIlhmy/KyWyomfamBo3fqlucOct8mYU62l6vx/ZR99UsBmITRl+hY1drhqYGRKd1L2853ZyNG/wVU30qvU1C2o16oSdbq3Ggtv+h7srSg7CvX0P2B4EqLw8leolRouRShB0E4iWcQrccs5ZjcpbvF5jxbXFlRr+VmePhpBE4QtPCjdNoZea+J6pCmDWC+OUDZ0MjQNSciezIOvsN4CQmBaxiA8hKaNcv/aWpc10uAgaU8ux3MhGj2O8d3oYNWE25ypJwwZ9oPmJbEEvkqZn+L8BHs+PF5eZ5klfoSRVet8lmWU11/Fgf9d4a8e5CBPzrFWA8KazmokBcVOpV7P1YUwJKyZpDjuKu/8mH5WSnIYG/X/1k+UQAQRMqXMUK9SfuaUM42bgYkuBLCFPHa0Sn6j75sNhBqaV/9dnML+RWsV9BGzGRxnebOV15tsl8Iz49YcHxRE5n6lkgUxHR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(86362001)(36756003)(38100700002)(6666004)(41300700001)(8676002)(6916009)(6506007)(1076003)(66556008)(66946007)(66476007)(4326008)(478600001)(6486002)(316002)(2616005)(2906002)(83380400001)(186003)(6512007)(8936002)(26005)(5660300002)(44832011)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlUj1oanRp59eOP28B3e66iBZ/eijIZGyrpuktkszYTy2K2ro1K8W58B1g2d?=
 =?us-ascii?Q?CTWNAPkX6S+epNkbgTrMSYvzM8ha57Bo/AYhtO3bSB6qjWiHHGaPbz3OLavq?=
 =?us-ascii?Q?OsfoAHVVl407PNNl0JvK6xlPQhn5CqWNZGDZ0o7aNGc4D+WzmG3Sb28cBzOL?=
 =?us-ascii?Q?t86N4fiCbNzxWUB1/2cfLbUzMtBw0+NxmLnDwy3YfE3IKXftrlN7NknYh9vt?=
 =?us-ascii?Q?3kmwUUzFO9jZbry3arkybC2RwbXCxtMIIdixok20E3dJVnhLUqRuNH3E2vKT?=
 =?us-ascii?Q?xMOlfBBLSUWrgf1U4YTl+o7w8SLj3S1VhOHXgSQNBCN1u9gbN6wXboZGm7Kr?=
 =?us-ascii?Q?ruHB7t1s2MDxxLOiKMOJDGqvF3q04LGuZgFvVw5fez2jeOPVEliKaf4w/FVv?=
 =?us-ascii?Q?CPD0nq/EWpYTHXKqzBIAPYBQsHSFb6jhZk1RJiOLQ6qYy0B7hwP9QGlZYLSE?=
 =?us-ascii?Q?GeQlm/v2Ls5MtIwH0x+UEtaqf2srYeSO/7AchUcWoD8avTMMHJ52veSBfxm8?=
 =?us-ascii?Q?Zro2nskY8fZnDQBj5cQ+TlufQjKsyOxBGHNaCWcdjqYSdQQB1LKP7F0EeTia?=
 =?us-ascii?Q?qbQSNPBjMGnFs86ROOMFjbdXX6scMmQ1s4oT6caxZhwPvD0+3U0w1wv5nl/7?=
 =?us-ascii?Q?e0JYK0sEPN8uugtHQ/utE5lhcj5+EMaWZviu05jhH2QmnFA62yS6/EeF9sw4?=
 =?us-ascii?Q?DWV9VfYGe5NKYXhyJ1cAR3cluP0zl9D/hsQxVcaT9Pe70OejYFfwWz3wR68T?=
 =?us-ascii?Q?Spf+5KESzHGubYlyJvTn0fzsyatrTKdaFm+MZLLFx4biitINUgaZIhu7Vz8x?=
 =?us-ascii?Q?QItLIASvJmpeocKycQfCBEWsLASA1sUvYig9REQQtvDxFJ5pQNXg2nAjNPf7?=
 =?us-ascii?Q?tGaAbOBO7zR2Y+73bPDK4m6LmTaH0TngyHflbqI5mIj92nBc6IHBJi05c0jv?=
 =?us-ascii?Q?scr94zcQtXEbsMHFC/GC6RjZDf54PJi6/RCbJqMij7URxnOOYsI2ndJTFz7A?=
 =?us-ascii?Q?TIpe5u/wJQwpack18ezeU2/ra8GGPVnuRJLn9QNeF1AElAZXp6MAHVuM1OaJ?=
 =?us-ascii?Q?NK+NhO/7bBnXdNFeav2284ycgGSaF2+1dxSE1iDIN2ZwSqzaPhtbg7ZxKTnj?=
 =?us-ascii?Q?E+oHFyVye2V6VT8y2GK3eUMCMGQ94YnoAwMX7Ks87RHneBd3PetOWe2nwW6G?=
 =?us-ascii?Q?aiWvBXzqYMhJo5+Xl7GkrxCLnZ5l/EXy9wQoi+d5S9q9SI7ypdlM0FREGnHB?=
 =?us-ascii?Q?Kg5SDKGrMyfcUlnxiwXvRGcBEOl7uhZOQHrkAdbUc3IJVACtCoduz/OxV4Lg?=
 =?us-ascii?Q?ipxqWtpxM4Ts4azUE938zvdkBAaFcFbiiBqH+07n6KPFKkouJcVD808lKSGA?=
 =?us-ascii?Q?lHwUi4OSV01XIdLXO2LANBb0wYo7iaU2pQvtXigTBydpPhdG1CczeHF3BBHE?=
 =?us-ascii?Q?nuITyVFcWdyAyP6x+OEGPoj6gARUQ3bA945kYLqf2vWXYZcvpT3U8vWcWc0F?=
 =?us-ascii?Q?gWdo0xymjXwscYR2MHeNVSlA7fYw/yXwykPZ2glp7u/zVyNlNX5IcWzyvBbP?=
 =?us-ascii?Q?ME2RcEaXuLG+wGC3MHtByFXt/oY+8CN5JMt3v7Vyda6MMN+QvXbvQ8xVxWS4?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uad9oFacz7f5HTECuMpzHW2CUnjUBKJiVbbydAN14DiFQaQ+KcbDPwxAVGjz2bdXoy+Y69i3bhKEyjuI/AQcOXUwgaFv/5wH/Oynd68+npMCepLVDP4m8J0hozoh7/Um6Dcz9XX0dtuZMng3OuEbA9ar24u0asYXAJ4YRf7wqVLJ+2W9KD2oXyKrxxU+onXNDy664n6EVHJp0H/0JJnuF/Fr3QfCxYiQA3qvuiZujLUOFLDxX3djj63WmkRDym662T3pfjrWYGyUslLg2hCm8jFvcrLT3XXqxQhGPtTMMohEMYAdViD5EqU8QNd0uByvl9quXJoOrUP2xfkPfIe95TpWg3umJYkbuZo2x9v/MVQjsciEROOMieMMOd1toLSJQ2x1/NHX2kEXA6VzzmIc/jKjnVseSZ16RR5dDLOwgbYckByYYOXJaJkgYl5FnPh0uBj616Yf5dYm05hmO5FC8u1Is3oi8Jrq3WWEp7dQdtH1Q5XUBDU1kUm4P3uu26VYLtjEKrD3xAomGrkzyux4MCZ/lcm8pg8ReAbPSySBSFY1soYLTdUti5nmdelEamXI75kKWPI7+n7Y8Lq6UomYkQhF3KKR+XadtFD8Vpx/4O+kxfIcWOVFvwfzta5Ux3s3dMeTA9KEuXCtLKl6QOMuvz40DF53ZBogKPoQ1dFJNYMT+kpBdRvdGbfHenehL3TKFp+0vJQyM6uVHnOj5YJs9vr7VJOUDfRVEeBE9kzGa3gLPpXo6q1ghtqzkUS0Zspu/j1+5XjMGWeTuHqcDpmL2Qxn5saaGcS9PWwKtL/Kpi4yXpWKNqYMw4c0luRwrLyGrUZ0PsOSZIuIxovhMxG/bQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4225081b-b210-425b-6daf-08db0b890ddb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:05:47.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a10FpE/rQTp2qIIyfJYY6bSDrYseUXX1LkMHpffjHo6i43A6bnoRoliwnFepPqR8cCfrLcu+dwlFvmW7ayrACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100142
X-Proofpoint-ORIG-GUID: MiyQZ0wZSyFJHU08gkJKnBlxvv9rEQJx
X-Proofpoint-GUID: MiyQZ0wZSyFJHU08gkJKnBlxvv9rEQJx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So comment out all uses of MODULE_LICENSE that are not in real modules
(the license declaration is left in as documentation).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pci-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 7991d334e0f1..afa9d4694501 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -169,4 +169,4 @@ static struct platform_driver versatile_pci_driver = {
 module_platform_driver(versatile_pci_driver);
 
 MODULE_DESCRIPTION("Versatile PCI driver");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
-- 
2.39.1.268.g9de2f9a303

