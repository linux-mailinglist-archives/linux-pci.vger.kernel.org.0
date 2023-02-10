Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D641D6924BC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjBJRll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjBJRlk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:41:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4306BAAB;
        Fri, 10 Feb 2023 09:41:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFO8xP031089;
        Fri, 10 Feb 2023 17:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cbqKvme+VaREq1Ma4oGBVBnRer5emw616OxHczoRRC0=;
 b=d6ho5zEsGqi7KtIcQjRHY78N73RgpIQyLRkCfx1ZmS2sGxCdtKawh+K4UsdP+wFalC/J
 RkXOUeIjMFb3oXwK9jyUOO7fiyoxT8vQXhilkCjVYMwFOz14aAXGEIDDuwR/pqLUWPO/
 ZfDxSheNQKPpYSeq55tQiy/3rVaVEFiDcXZdh9CPH+v6UvFcYRugu4xp+KiyFfxZuj1L
 7s7Ig/q9FXuZAm+zrFwtomhT84ymIOQ4svCn9iC54P1mc95/G0B9H84pouhi3zteQoC6
 PB1mu5yB+x4KY8XqRQbIum/i8hA+pVcwujDqHz86S7HpFaKI5NivRfSHxuTsiEDfmMsi 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu5x0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:41:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AGE7s5013647;
        Fri, 10 Feb 2023 17:41:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtahur2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtsMiWQegvFj7Qq0j7bBiIy03KtosnzrGuWaG1wz3Ah0FtMbD+bPrTIj38McBLpuN/WY442OgnS+uuchDXQ+PuVzIMAx/unsRjFT9Y7ujTuntMOOtEh9c7QWiUUKewfRftrYZsNGnINuRGU/FP3cgliFQ0Us7f00J9tboi3lkzeuj1JfTcF2pvEpApnyIC1fPWgaWONKQfHXBZOWJ+YXVrw9ceVM1z9HprgUTA6R4KCfRSLGZPpvjRyvhLbg+YKFtkEa/qxoU+vdFP/am25euuvoTrY3qgiP7B+rwK1LIirUw3cAvM0vk2/p2DjmAqawFIF7PEqKCBWd5+mNtGl7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbqKvme+VaREq1Ma4oGBVBnRer5emw616OxHczoRRC0=;
 b=gag6GAii9w7OArZCc42NRDvNqvNMKF58ifNVYw+uIC7hkUd5Jxo+3+m85INjxr14IxBOxyuq1W1gYnJnRJs7Qu8BOiKDOjPzv+ANuGssxtwjnAVsXjxPevVZu1D4Po/XeTAjlpucLLtjoAaqJbJPPU78ylrWMjggJXFgzwx47RNHWs0EVBRmG4fYRqLiBEzuLx3hOwHeelXF7JJqxsBS6Uh5wqtXeSODFLf8kQnfqi2um3EP1m9orVVNpY8v9WsVpVLE5Quj7mQp8XP7wYiVWm9mkM85kZDXoSc3+bH5BacQPKX3cyuvQCfHQeygR88gStGKU0lRHFLaqOBIbufIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbqKvme+VaREq1Ma4oGBVBnRer5emw616OxHczoRRC0=;
 b=D2bwS4ME8FAUAVHot6VqRJB+VdsROeXTICF79ew9rXdX4tEiBK4YmnnQs+01pcGD63O/8wgreSZyRwGCQCuOqMVgjkqHXBNPIYQd+nU0U8/tELqmlpdBZm1SFxlVquRTWj9viup6p0dVGX2qhGy1W2pFHER4/2N6Rb2JXWjJtFw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS0PR10MB6775.namprd10.prod.outlook.com (2603:10b6:8:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 17:41:32 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:41:32 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/8] kbuild, PCI: endpoint: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:45 +0000
Message-Id: <20230210164749.368998-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS0PR10MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: b93cfa16-e179-4c9b-f020-08db0b8e0c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOJdKdV7L13eBg7gsj5zOUEPcEjash9OPEQD0S766mCZPCY7+lHMSRIM5PJ5fMIx8oxagGipbhQA4ntYnPaHtQjvViU+L1ieX3IvYXP861TIGtGcxcIARl1qnaxz36vwEvXR7A7U/wuBSFBrfNwQ2Cc+q9/rvx1XY/vedhXb5TcsdsEKo06+w86HUV7zVRL5YJQixn3JINkKsW4wAzPDlpQ0v17sgVlOyfVSdGUcPNu6hfPrpY1X31VIL125U0tNTj3Rck2wZ1bic015L2dqBtsPn+S7pD5s0qMA5oVGuA5PCoEUNeMFrLjyK0u+vXsGNKeRnTkMiHtu4EaYSYneSyiw/N5ZQhqJD50BYnFCCs0vGDTJwUJ/K9kWePfGKH/5yP5DNI2bfPXAKmKLBMxps9HF3qZoobcix7R+yfE4byjjbfWNodvbhEJ9bYmi0PMo562I6E4RndH4z0J5itpoTWJ84LFN7sfYK40bbxzPYZJUoiqY3d+ay4IDhYIQC+ArVDAVbdOJqft6NhHb2lblpXmY5ooQU3WMV+z/SuYhYn+mzULInOIsEc/CEVMteWBuAg+Xv9HU1MQcrY3sknEoBFA8J1jerQi1FS5552NKGZKqrBZKpnDKQTLxqYEasFxcfu9YcNRSwb8AzipeXSIrWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(6916009)(36756003)(83380400001)(4326008)(66476007)(8676002)(44832011)(86362001)(2906002)(66946007)(41300700001)(38100700002)(66556008)(1076003)(6486002)(316002)(2616005)(478600001)(6506007)(6666004)(8936002)(5660300002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9qBGion0x5Kdt7GKnoA3qEVf+E06ZOD4LVEF9HrIBzlIR4i0RAHKWZVKZMd?=
 =?us-ascii?Q?C1gqP3WXOuUW6s4HR76M9GKxngtnMnl2j9vxLJlUOPHEKkDXWKgGYUK6+YMR?=
 =?us-ascii?Q?Imll53YQXxSfCoAo6tAcYwJ/l8A5rlRUO/Oz2Pw6Ey2skF73blkZWwjrHQrc?=
 =?us-ascii?Q?Ga85a4Dd/CJhKKxyVbRzCWwPaRBNo8Uc5SN/B9ej75vkGleIiy80WZd1//W+?=
 =?us-ascii?Q?pIw1FGFwRsRFDJZOiivZiA9yOq3Imjg2VQOUipI45nCDWoh/kevyh9xZ60Al?=
 =?us-ascii?Q?f83Fxz1M0fmxRPDTc7niTVROv9HvT8v3RHwwcLtqLbnDl7yZL5nvxneHlT8W?=
 =?us-ascii?Q?6JT4Jmqy7jxTMyUzQqzgflbUQhB0LEUoi5XdwWZQEmFdRffZdMnF59tSPCQL?=
 =?us-ascii?Q?21PQcl8oUtGL+P9NOxDQcLLlxY9nl0YThJ9vbf1W/CfSvTwAMWedc3TGQYJi?=
 =?us-ascii?Q?swCNX+7Kl24SwWPd8cXOIZHBQVrZjwqp9sdnykL1dcktENlJ7OP5pnwSClYA?=
 =?us-ascii?Q?gJXFCHD5CgrfOl1cmsnGjeXrM16DcSrZKkLoHI91BBNBT/nOzOFkb0qdHw8I?=
 =?us-ascii?Q?CbVEPkF57EEJgGcm507NX5Vpme3ywIb3eCSQrW0GA+slwCt7SWPzBIffqZaw?=
 =?us-ascii?Q?dF9m4eCy6r0zDJWb5TZ3tXNXXtQtwmmFWV4gkSx4BMzGrdX5ihGrUqT9rJA8?=
 =?us-ascii?Q?JR0m8eUwZRVLdqgzOBKj7dLVyrU2qHUoC8DJKI3cUstEntFwspSzGlBODslE?=
 =?us-ascii?Q?v7yhkoe7jbU/s3hbVNE8afVJYiKi6iy8r40kXEx3/L+wyEfn8xOw+fx606Kz?=
 =?us-ascii?Q?UpB4OnfoYs3pCUyvqnsCZm6AAqs6vCDCUALP9Ta7zSayZprnApeaGJ6f6x4z?=
 =?us-ascii?Q?953glCxwYGub9Ow6VO5nHeN7+pbQrGuOKdh/yo3847988yz0u1IR/Qcj8mvc?=
 =?us-ascii?Q?Yp3UPgL3UUryQlIo95XXR6dd/HkVbN8Eflx4yfBnHdXFwDvyyOBNHsFUQLed?=
 =?us-ascii?Q?65taz+XgDYj9H5IyUH1nrjzVELTU5rEjcHJTFz92V4PQf6hZzDNqmU3bpqwp?=
 =?us-ascii?Q?BD5+dTe739enjJiUaexkHFC2VWzuryxdmF8P//6H86ZrPObzBDF1zGUE+UDY?=
 =?us-ascii?Q?a1myekqJYa4m/yUSMxneLRGXNigy+vH4w7qC04yZyoMmqyij6rQIdFx5PVPr?=
 =?us-ascii?Q?0cKpi+YMuxaZCWvRSzozKeCy69nJSCsg18smh9xR898BKhwy+m8I7Y8IT7MN?=
 =?us-ascii?Q?umbMO6NmtSngD2mv25RgPDiZGWf/62UOGDQfEp48tlu+lJT0FHawEI1LU5R0?=
 =?us-ascii?Q?bhTI1aJFwtkvCY3tfDjFRCxOuFohX7aLN3feltCdlqO1z7slFKvX4tX9DMve?=
 =?us-ascii?Q?QgE4sKYd2jONl15y6ZlEyWVVL033ra1LlVfq0qDh3DvTO/+3yZxHMeurgZvv?=
 =?us-ascii?Q?uHdec9PePsSlp1Enb9nIoW9fLCFotN3/xpImjZA/J7DzZDJGchAxhRQTdMS3?=
 =?us-ascii?Q?TQA9UhibNGre5niqXH6vfmaHhYCTcnV7rEw5iR+fIwo6zgMThRKbua/y8qVf?=
 =?us-ascii?Q?IlgFaqw64KVWkV6VFo1Wm/OwIrh5W0uz1y3H4beVu2cmk8KfHtqUtz3z4jbw?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 42jqdQ7cL4HiL+RQZsdUrr1JZ0MtoP5Ox+UOZlOF2oDa2gyjhx/C9PvSOY7nCptJuSnZIrj/wefLhsw9z/jn30nw7mCQrzCGQIOPMJEPL451k1akInXZnB19ddak1oMbbRakFyiMKYfdFH7T4IpfSZqlFrkyI34Wqa6K9CCKY9IVGz72fCHY/24U3xiqvmWZQ5gFBp2KHXQotKjNbz9JCM7tP3b+L00gIhIgHgCVjkOcRUrOl5Y+3dJWORXFBryWGWLb5XWRc/WYsYzfTn4t1zOVj+qhw5CC295oE2GtLxryGFPV+qptoaib/dw5Nq57bdqtCAS3OxhC3cbv8MVl/UlbTFTEReETr/t1v6hbvJaZvL+OHoBXPUShDBHUtHNZz4pZ+GUx1jo+qqNa6bkHTykM7zAdspgIriIG6suju9tzB+n2MO01MC0C6zU4MBQl2E2oebDeuWqhdr4hMKyEIGu/HmJHFOdkCKiZs2cDw2o26mqdOLt8JIp+elirP/eYRRMDTWIzhQyRscdIoCgEOINJM2teZboZWBgf2lRTbTUZ83BZTsNMxfXF0t2s3XCDS74F4EoTuNJJ/Hme51fHyKP0zQi5Q62dSbN/WwXHTG93XpksCVH8h3OCrk3tkPGOcC1O2G0cduvllxYRZREhVn/6V20aw0UQQwhp2oPa7wlqyMMEQHUKu69PgNsAJqgZF8aEdqGdNkmrKAYu2jcIMkt88jOGbYVcs+wrKzLOP1aZ8VgPmzZdj7L6XX9cEQPkLlwW/cyMT6+jPO5yj5iKtINSLhoLIhXs39u0RP9lczI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93cfa16-e179-4c9b-f020-08db0b8e0c0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:41:31.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd+2GDbtQSSV5/4vfizdqfTG3kBTKigi0DA77MiXu+cohylBigJtGfjHAWXy2xgBKpGXjG1B+aO4KqXuj5Qwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100147
X-Proofpoint-GUID: 2it0bOGJeKAr2lMqHos5J8w6NJA7ABAS
X-Proofpoint-ORIG-GUID: 2it0bOGJeKAr2lMqHos5J8w6NJA7ABAS
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
 drivers/pci/endpoint/pci-ep-cfs.c   | 2 +-
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 drivers/pci/endpoint/pci-epc-mem.c  | 2 +-
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..52cbe1a5d677 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -728,4 +728,4 @@ module_exit(pci_ep_cfs_exit);
 
 MODULE_DESCRIPTION("PCI EP CONFIGFS");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..52498ac868ab 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -861,4 +861,4 @@ module_exit(pci_epc_exit);
 
 MODULE_DESCRIPTION("PCI EPC Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a97b56a6d2db..a3280f699f96 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -260,4 +260,4 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
 MODULE_DESCRIPTION("PCI EPC Address Space Management");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..002310a3b55f 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -568,4 +568,4 @@ module_exit(pci_epf_exit);
 
 MODULE_DESCRIPTION("PCI EPF Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
-- 
2.39.1.268.g9de2f9a303

