Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD269243B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjBJROz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjBJROw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:14:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC24C26;
        Fri, 10 Feb 2023 09:14:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMYGh001218;
        Fri, 10 Feb 2023 17:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xJ8L40c/FaRuOjzAq9CYq1gcU5TUfxhuJ9anU5XKi+Y=;
 b=uBJLgVAMISqIx/8Y74Po+SSlI7/Y4RwaHmYO05yfMO+p06x4Ew8tPsRtilzZr5NlpKHO
 ITMEFSf1SK0PrjUcq3W5zO2wNVRPAZLA8EgehFk3kxjpQ80AqBcCfaQ5C3IV4hhmbTbe
 coWSpAqX9clkkGvnxIEPq3guC6SrmSDRCGURRk1jB9MeYH5j1zHavBkqOJjBp4PCsmvR
 7hOAdbxB2sisxVk/K6MOpOvE12mxXsJWnanwQPpoBrQn4ZU/xeB4xcFxIrLnhJvDDjNJ
 kJ1wGNUs/zEkshxoxa3rhoph056m7cWoSZbrbYxwOHr6jUU7xUGERppn8sPEyzTmonBc TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy1dw3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:14:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFrUIn036259;
        Fri, 10 Feb 2023 17:14:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtgudnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZubTc6oljXTk0fH3+yW2phQLQFsafBwtOQIL+C876+0hJWxe7CgJ3NgUKQRfQ2B7oakYa2kN0y6oF7oR0+FAuvV/yvg9wo9cuudKN5N0dtHqd+7gx2n0uYMtRrYSrg6ozsLvVCmZsKPBzbkBBa1eWcOOYzF3akoDzsi9LiDMNUqV7qlc30nK3WLewMLnrq4lJxzugq4GN4y7/WudRRl1XL5PSk+3QPaVJ/pBEImOINK62KfJESLL5r4hNeDhwcMmiK/PWAA3oUzJjCSM6w79lH+PVFVepllezCweT+jpHkjNV2ZIyrfVPgxr/vYtDeAgMQpCJjgZcROU1WOKqTM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ8L40c/FaRuOjzAq9CYq1gcU5TUfxhuJ9anU5XKi+Y=;
 b=Mg17uzjhjWBlohnt3qPqU+Jld2R5UmTjUXk6v8Tbw3HNvDppLiohzKPIeArP8+pACJx5iWRVzAQoQzXXgrnpIuQEx/dRFBZF/Pf2TInyQYuDDFiLC4sTwnUHY4e6HSh5lnygq3cLsdCsfK789QS0/iVBO7KkunRmaYwFWDrXJDgdh1/FIBPhyUwgCrKav+dQeVtj32l6Yyec8paUW1mJkGCiDCqAF+7v7rjsSsxrRmV7wmrvgvRR9eroP/0xxVmAwac/n9vX1byhkfmMDczFi9LCE5EsltvA2NKRT48eo2mSgA6dKT2Kce4x+yUMvOKub2XGDwPSQ9u3CRempzGAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ8L40c/FaRuOjzAq9CYq1gcU5TUfxhuJ9anU5XKi+Y=;
 b=N7G+F9WRM01/4KMmPxNJ14TjwZQDSfuNXoN/jmNurX3vgGdRS0Y/rWpX1UFihK9IdXxO0kEu/stptwzq5wWJPVsmKCjI0bw4kAS6yJw5e3gZCeVkhrPhnH3E1hO5SH6p4nEBWfvvjnKAKKxnYG7OFFur/9GsgSo6LrZkFcqnbjA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 17:14:45 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:14:45 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/8] kbuild, PCI: mobiveil: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:43 +0000
Message-Id: <20230210164749.368998-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: eb25ac6b-7f99-4da0-e115-08db0b8a4e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9GV1VZXtdhEC7gwjcy5nlShtOusikY5gLUsRuXwlmnMHMskdSMFVCQYhFjMkxRXcRj1NpByNaliY6zCuzudy0/MXGM2Ss5hOZTvQ9qZjNQ7znQSbDRDGbWhQI5zWFr3vs5vnkXiwvBC0wlcER8JLOFYnXKEFv93aTRTmZtAe4cbJyas9Fbph43kUrsw2aVRP3W5lK5S+Qf2ES22NV4riMLxgHOiiHQCM+kAPiigobuVCafRnRGQ3QtkQDaE5PRjOzjuHWp5uwEOUk0kjRtGQlPv6KJbeMRjQaNCC2QVshYDkYA0IcJyIk7rL99IP3Ses6MyxZeVX9ZHZppEU5kPhAoKSQxQoNZoX3Eb3fNd2xhWDkPPUDhbraDlEz25aa3w/SAZMoYPccVoqNjxSzSRYysYvb3hUXQhqm6TVvlgS+g9j0YNqLKZXHzxwX9dNufkYRcKJiIcgivlgk4aXRMIQFW6ptpI2c+cgn6LrajzzCZEb529z89uRM5w0R/kv7+7zfBLoVF5nUj0JsTHiqtgxy8ZiWd5baBzTQk87LjcfC5zu6ZSaj/gmCB8vsm9Dj0s+BJMxxJQQA+XTHUK0C+27GAjuiausx8ISeDG/pqrbiT0hvyR9qKIndpGkLzo8+bDcdgJV5Pqz1P7shYhnJQkug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199018)(2906002)(36756003)(38100700002)(66476007)(66556008)(6916009)(66946007)(4326008)(8676002)(41300700001)(316002)(83380400001)(44832011)(8936002)(5660300002)(6486002)(478600001)(1076003)(6506007)(186003)(2616005)(6512007)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhSWxxNUPfqHvv8mHeO/dR3cDERUilhdD4ipnSQVsryT4llJdd0qH/XJtn+D?=
 =?us-ascii?Q?ND7v0Xsa2tU0rn8omN6iBsMjzSPrUeG9XzFJqz4q6xqV19xzRTvXtSA4VF1S?=
 =?us-ascii?Q?kRkrJA7/9w5aekPi+tGJAS8Xdr0FiM1ualOVxi2LX6u6r+tmTSLei2Cxqycb?=
 =?us-ascii?Q?54XBIXwOUItYNEW7GLiam6SQVPL712CUpeRWZUp50t5Md7U7aa46jlBGTUQa?=
 =?us-ascii?Q?tSmEiqp70F/ZqPTlx93Wox3PO65cuIvEhWc+mg3K3YrC0NosaEXzNhDj5sR6?=
 =?us-ascii?Q?E/vHTLjDnfG8nTNhMFgnVd6VNUdIPRWO1RWdhb3r0l4KYmm25BV2MT1yxwsT?=
 =?us-ascii?Q?eS0EyCY7lGW0NPE+FCfvegAJ6brUvvooEmGB28VWU2qpbVQZdYtyc5QehLO3?=
 =?us-ascii?Q?zvrPNWw8Wzh2glHLYUplELEarZzSS0h7wGw6d8w4axifBwlIzA0YXwhlGX1g?=
 =?us-ascii?Q?3+l2kgAn/n93HihHO9rcdkR0HAf6qTG5o/QzsIG9BbZomYkIbm9XztJr+Io0?=
 =?us-ascii?Q?KkvIOWhFQA8xNYWHp9VnVr82ZUUA7vrd/uDsIjQZdYZvCSpFmpCI7yhFCQFB?=
 =?us-ascii?Q?yg6e74n1ne+6V9JNTKwUCR5ScsMnFOV4Ps6hS8BT4Stc1rzL3dUeLfV5DigL?=
 =?us-ascii?Q?beNXA3rPv3lJVf0e1oACCUBjbh+bqEZ2qiZp3kcCPdHdzPhRPyBMtXNtIWms?=
 =?us-ascii?Q?mw6/D4pDNdIJkbuIsEFsImx0nhQDUQsRcwTdzX2P84A/JuZQxgu9dAIx4+VV?=
 =?us-ascii?Q?D4w7j9od6RbGdZ//mV5d7dBVQw6kr4r4oV0CVyVg/WEay3zbBOItLGktlbkr?=
 =?us-ascii?Q?z1dZGLQHsCNcNvbiz+oZjlbz+krbCRw9jgOlaUHhGsEGUNFxFvDYBQp2jzMv?=
 =?us-ascii?Q?mhp3BpC4ik/EAC3mqsrmI57Q63CSCWBrnTcouXvqVpkWFGqI1RZX+EP1TDRw?=
 =?us-ascii?Q?eVdk8lKy7iaCiIiwsFeo4+l1olvYvZgFy//BafKSinf0zDqe+o2KnjAqBNK6?=
 =?us-ascii?Q?thK6RXbmiDPr1ywIukStRcK4CLL5Tmd4eckBm+iDp4zSPq0I7DOF4Amw5/2Z?=
 =?us-ascii?Q?WpaDAKik/f0IvcqVTEeO/cQMOyeEy3u8d8xl21wNRvnLY2NS06HrL8TEK2Vp?=
 =?us-ascii?Q?bagjQDUcK7jlVqTawRhTf6Irq7mLC8KrNCnb+1L1E721Hkmw6ieHJV+9/8Nd?=
 =?us-ascii?Q?A2BJCZr+BGpjmV2B/9a1mMn7i4ka3KWrm77BaVPcVHmvA21Y+f9qhBvrx2XB?=
 =?us-ascii?Q?/HldLlnrkjhlnafEfpNnNi/m4IQb5+9pDB9H9Cz4xniZ/V1bO0JmkMvATL/R?=
 =?us-ascii?Q?/BOiyeWg15egqHyAa4R4SpbR6vvDsg71iJETyR8iPDqT67bAkXXXJOa43biI?=
 =?us-ascii?Q?seSl+2XM5Bw1djbHCE3cFM1Pq6l9zZHqO2JP5OF5qz/RLLhuAfqBZnyIcw9N?=
 =?us-ascii?Q?EpRr3CdU5EzEQPhJyU5LtQk8V4PS7PyxP6RupTvIrJZ6ipBp4R4KNmq0mkHp?=
 =?us-ascii?Q?NYQUt1Yq/d4qA9reJI40OSO4+YXpyewLYMUQt0aPysxxGcwzU1IsMctjYK7n?=
 =?us-ascii?Q?Ia+se0NoFVWCAbUnR1yjVM3qiF/nzGReLUFZfeVpV/lhywFyXJ0sMRTDNjc/?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PTPhDHw336Al2KDrZg5cCiEQCF7oEpMu819VE3ImbOzUMkhByRa7HKrK4nKib8v3SRUBT6fOIsOmlcJsCP6AhR7jcd669vR5k/rpz+3bsVl/P+FenFYGjtkLEQGcRlZ7dqkGy50yXM0HcfTu5eW1/Xfs6MEotxqjG+S3UzLxN7tnPinwMoOydPnQzhrjdcq3oLcxf6TDRYIEsQHDiw+WgLrxEQWa3XoKvz78VrblVHoxf1uTSDFqRYNh4E7w2L9Imn+qr/aEsXfgIY0Vo6JLPeePPD6WGWZNOO+xhm6RiXX+7lduQGhzpK6EaX6FcjR6i5PLs5sgfJjnAlKXpFIuKyxUmqYWqIBP+HZ56NQ3SShiLQy9to5xoS3oh6kc88PNcdnSaYPheGbMum0PE+MyYkclkbAT9CbcIwygQtR48t91NfyiONVXa6g6/lz+lasPBEgER59lHKxMYwfCgMqwkGOcLmMbgKyu/Tz6xwCQ0IHDdQuAPFQ4NNWIb1m+k5FD+WvJOL5FDnmKlWmWZ06JilqjsrqyyCqWUbqodBLZ/dDOrErMo/OZ1gaGvdNUSfeUfIey7Uj52oqlBc7yTduCm3Tzja/rX0f1tGbjxAWWQNXxq16G67NBJIyABkRnZV5Giz4PciqbuW5TBLZTMoI57yx53lsCY8TQS5XH6yPXH5JVl+2VdjqgYhMChmlL4uTyUAHzTl61Bj9vjhgXJxY1GbhTJIRqWpcGQYfBdomvID8NTELcTlwRe/yBd4OBy1iI3asBBN1+4tip3S0SxMRCPxl9fCQU91qxBjh99//bWyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25ac6b-7f99-4da0-e115-08db0b8a4e6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:14:45.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooKi1BlpkKkRXWm2+pePftmZNf0A5XouUAPNsJLZe/VyO6e/dLsCYA/FYYkF44d3EG5ZGCTZWF4UxxNnWQmcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100144
X-Proofpoint-GUID: P3QtUEdG5pTlXKlA21vTUX7XJAXpDDU3
X-Proofpoint-ORIG-GUID: P3QtUEdG5pTlXKlA21vTUX7XJAXpDDU3
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
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
index f6fcd95c2bf5..d16e4f5c726e 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -56,6 +56,6 @@ static struct platform_driver mobiveil_pcie_driver = {
 
 builtin_platform_driver(mobiveil_pcie_driver);
 
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
 MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
 MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
-- 
2.39.1.268.g9de2f9a303

