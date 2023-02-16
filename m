Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44F6998D4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjBPPZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjBPPZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:25:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6056EFC;
        Thu, 16 Feb 2023 07:25:11 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFO7Mr018324;
        Thu, 16 Feb 2023 15:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=76hpOm9tW+MChi9tU6I47tWg9cd977wxbEG8c6iJ/w4=;
 b=Ye1F1lAAVAFLSRh+sDDa3UlLOdTCIXbVblTfsB5UnNn0rDJHofuIoqNKCPyBy3B0/xdO
 P95L4T7OAC18uf11kjvQT4AVmV7z8vcmcBnQsK/Fy8rEqBClo+4fNxtY9hl2hSOtPrs/
 24OAU0pUCKzmfEj2Jdxl697r195XrOv62cOdowwcwP8v7YbE1jR3jbDWg4Jvf/OjZsE8
 IZCFQaNTqN3opWgCqQtzBdl5P8j0WcRLs/DIAqCwlc/k1gcq+CHXjAw5TUwMB0Pu8/pg
 2iEOU0voyGnnWOFYh3RJmdpJBz9eeDgb4aRhaZ6YwGmZIwW66Aqd4R6c5ckx7Pzvn9dZ Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ckf0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:25:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GEnDW7032456;
        Thu, 16 Feb 2023 15:25:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8s09x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRFvJy8Hkcgw9xuF46gnruko36/9/xNOTysHWk3uHoHpdICLIFJGznEcKzSvllAv8DOqEjf04YNTeMy4biEOBf6ebhfu+9XD1KRtudhV79JkcgEfVVeShtpXso2YtfOwFMlmmXWismvyrLt+0Hf+pTIRcVq90mkLXl0kmL1InisZSlm4TWvlY8lqclGcPatlbZmXQbK/fm5TMYSKg0kDsvQgmAzu+sOilsPU1pN3Kzk9dzYD+c7qwjawLFQKK0mqjusVaUPRNQQGQc69jnCoVbEaG0ysmwExC6QW7OWRzlLcTwjVegl+TOe37dZ4LKT1wfbB0yKp3xAQkgBxAoFkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76hpOm9tW+MChi9tU6I47tWg9cd977wxbEG8c6iJ/w4=;
 b=f2GakYKdd8HYFZwRzLPuMvdEXn8nTjhab/J5nkT+Gr9FaE74rfNBtRk25hq1gMKzJgLcU14x/WpW+lb4lF6o95oop1JHSyJ7Gma6DOeM/UD4jP6fyWINXqHej8PW2fpYewdZvVUgyiX0DtivbI3ibwPAYYAuir1fOA7IisFqfbxkaRcGi1eQ8jAti18mfYEKZOT5ebIcJ5bKlj4vRigmNKrKABv5NUGjgqBC3cebDu4Dvj/OnljPWHxIzzH/nt8d+LeUT/s2GqrAnSluV6tSZmF5OThsZFHzPpPU/ejQSC9aqc1QsNR7UMxU3CJCn4UCwET3ibZZ6YQQyk6rJp8i6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76hpOm9tW+MChi9tU6I47tWg9cd977wxbEG8c6iJ/w4=;
 b=UEHhLsI0l1XQvSkMFaSFhaNz3srepFl2XA/KIWCSrY9h4XrD07ifs634iQXlysnDdgoEcmGQVfaafDz7g7V9gETXzfgdRafSqfmgtnIxfAzBhYaidPPZO7Y5+Rza0kIf6iOqd0xwZaUSuDJ+zuosokzObrOdj6YGdRd0tr/Lhp0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:59 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:59 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2 7/7] kbuild, PCI: dwc: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:10 +0000
Message-Id: <20230216152410.4312-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::24) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 213ee1a9-b11a-4e5e-8544-08db1031f745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uGGWjLWteg1FjajDoRrzvbJEgX694R7amnFWdjLINB/7+A9Ux1D/EQwhNW6IGC+lXiSh7MNNd8Kw9huxYHoxvb1JN1VuYUYQaZ4oWafTc8s13RYTYiNYZkzKLy+zWmF08nSLaJbDIIH+4ahOn8wQB99gpQ4N2kVGGc4mYEn3Il0e9Xg+fLmq+2D4Vvdj8DaImReBTzFYFWmVj/hqGFHjR94NQ6X6ovn5rgn5+zQPdNWj5rxVNiYOhnCER/KJOd3Lpt3xmUcNOUfIhid04NBxr6TBn85Wn0HPpLu5vsUw+10gBzouVUSm8/epWn6y3FPN0EwKdrp8/6SBTrc8ZI5Rggg4vOB8tQ/ynPLzJyBDz7kuxvhtNhEuFq4elPnKU84DRVq+ubDLD2Sa1vNBfCA/njW84eRHJDPpthz0E2ab/zwLmWj4d30Ed/EryL6wcvM8G+2I1/bnpdr0bG1oy+pD84cfMsqvpofbezAT7oXXklMQSwH9FIIRT5QUthhxiPMt+qBCjoIw1JjAlCk3Jm+RpjvlSSLXLBdyyBZFc9zxhGAiG5544O/ry3TgPuer612TwF+GUKQSJ2B8kCJTzMoJwYgKUWfuMMzwEVqv9w2ZeBIaG1CEn+tvVSXBqkbqc+U3dKWoXKMs3AHiJCPlB9tYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(7416002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE/s8YpQ3aPtxMvc3FFZ0KqE46167M3oGBFmrK1hC9aSb464mMMDJPFVqGZV?=
 =?us-ascii?Q?IDbCygk2tdOE5HtRLjuaLCIfVE1B4a/LjPwJx5hYP4Y+dAWzR63nvLuIn8Ag?=
 =?us-ascii?Q?Nd/qloHqN+X4k1GGAVFvkDVY33ZYNJ501tJDCoojrHPNqrgABV6JnTfuvGe3?=
 =?us-ascii?Q?aYk87L2x1+LCjK1/zshWb+NSMUycKS1PtKH4MyZCu3nW9Gr0N2WBkF6MiONo?=
 =?us-ascii?Q?BtGowhnzpX7aRaDo1S6yH+XjPk+d7aec9ZcmaCFGYMJWms3s/dY5xZDQeCMy?=
 =?us-ascii?Q?OcBSTZQwkRUHZQQJ/ZkWgqPSP2ddbVVrbV7NUaCq2gVh61fYkz43ExQQ4UDx?=
 =?us-ascii?Q?nLObOmheNrJMiWYz1NdTxvE4OXO44D4p+CNEKfDCmKfnzAMWUI6moWkzsHCK?=
 =?us-ascii?Q?98IVqwQXISS5MfSAoRQfGXV4RHsEQnaBIaydfbmVTL8iCg0ZIxZlFSnMrIgm?=
 =?us-ascii?Q?nNFYgbbYVCr8KuZoECCjogIvSjYwvJdRI7LtZLEnGR1w6+9DXOWNw4bdEUF5?=
 =?us-ascii?Q?Ww9IchH2KTJPS1aSaBjDAQvKRIKoIdGsFmfgckeXL8FCLx8LmbPhqIgkkHl8?=
 =?us-ascii?Q?Azd5ZDumunHh/loQ+3hPEHh0/ljr3MDAVyZa96Yvc9ldGtslqW5tBB0kWHwG?=
 =?us-ascii?Q?auIvH53Z/6fcr/eElo7R8hsPDxUXHuAX2aqeZb2N124uymOvubv9rPhtmol7?=
 =?us-ascii?Q?c0saiv+IKG8l9ugFx+ihXXinV0SF3MJweq4ATnHcgYoRCVPBGKj253yY/Jde?=
 =?us-ascii?Q?ucz/Sm33jzB4II61Ao7pEasfrN0PuFFh9BrPBSCbCAy7Lm9RscMNifUJBWc2?=
 =?us-ascii?Q?205semF0EfINM/4PhYO9kKoyz7Ay2AGAmsgps9FdwncqFvCXcKmTy6jh0mIn?=
 =?us-ascii?Q?vZQVIIrAOxHkFL3H+M9PywxeDg0S4H+8LIDjrmVGSZx84/opJxEhBXoR4pHH?=
 =?us-ascii?Q?EITTWuMRyHwO/MxhETa2lEquUwKIq/5CODwHbsUzdYPvwYNk64b/c1z3Ujzw?=
 =?us-ascii?Q?YYIaOt/vzlf/m3Znf9368Hm6WRbT7lHZyk1p1R4GR2ryP7XjB+eqeVIzOjQn?=
 =?us-ascii?Q?G+C+dRHp3dj9rBuHaOM0K/BOq4Uc+I++Qv0aAlvN3y3skjsoy8CcnOp2fu/G?=
 =?us-ascii?Q?itLaYiQK3Q9yxXSsD3b18mIJ+BoWI82c+O3IKjZYkIsTXZCUcj1WMe5879AK?=
 =?us-ascii?Q?NaTFhenImd6v3ZdbMX9ssWVwOkpZldH7otoag7cZS7zG082HO02rLqpu+nU6?=
 =?us-ascii?Q?KHOyC6FNIjh0Lo9KTR6A4KgG8guNgHTc2tbJ+pbNcz+yOJVZgUfwC0L7iVfL?=
 =?us-ascii?Q?nUyv3vVc0/+mJTPoVr7YQ+JRJm+tdcNrqlsTJid2A2cqB2P2pz/1bUNTTYP9?=
 =?us-ascii?Q?EK6areqBtxVjTHvO3CkqJiC6AVZDJ/FYFtieZENXy0lEZ8Xoqq/vG1qe9ZUa?=
 =?us-ascii?Q?83l8OyVkkiIXGpU4KwZs5yf0ZIjfZWdScSNKtcejr02mvR2pcMm6JdFENvYB?=
 =?us-ascii?Q?TEInl6o5XeMABC3qX06JKZSXECAj6n5gp7t4fE6h02BdlWDScxcKOzbCmJl6?=
 =?us-ascii?Q?FPAedtf1XQS7GcyUdsFVKhkGZnAcnxVO0mVrvQDp6Yu7JOqDZHZKzWWoPC+L?=
 =?us-ascii?Q?jsK49e6hG7vdivB2fAGAsmg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d84ZsYCV405xvPwwsWDO2+JZ+QbDhzDVJgWZBnlegO6V7/kuQ6TjkZI5lyZl?=
 =?us-ascii?Q?chfiEWXAxhc0X5Xip4bxqrkHm9ivYBdtFKHlQxJG/HU0+a7TNtYG5ZDuvZvM?=
 =?us-ascii?Q?0nPx94zDAfw4z2ikU1VXSr3lXDaU429DbG5kAQensRseKXC73IFxTTSjrNmU?=
 =?us-ascii?Q?6dqMWZloh2s7dpH0P4hbj4//3CSrOHg4MxunH3Oyy5VklPQVXFhYf+idN3Dw?=
 =?us-ascii?Q?pB58IujZaDIlJEARdE22W+AmLsVtvfyG9jFgrYaM+k+4DvRkMaPhGpfnwGx+?=
 =?us-ascii?Q?ZONDlxHCXMYVlUfsyWnml48P3kiqIaMrPIF0dNwczmiNDGl64JsyRPIn2F1c?=
 =?us-ascii?Q?R2/SMoYQLFJliH+Juxx+aDKA8Omy0obD+RQctCoMSpzR4dk6OEexlIztzY+e?=
 =?us-ascii?Q?QVyxjmN7N1b7SxE4vUGH5Ak/nza5s2AG+E0ZSvXnjnVmkmDjpWXLI8Z9G/zO?=
 =?us-ascii?Q?TlBpI2Nek8bBPBCtWd4OapNe0gti3KnY7/0a1gOV7axtNqA+KRQlxN57LBPV?=
 =?us-ascii?Q?OCkPVIUGRd6LfBbNfMe8ZEmvAl0EfPLRbjDSZU0Y5BMfakoUXHmB3htDTiY+?=
 =?us-ascii?Q?weXf8N2s9Ro0WFdDaqMK4NbvxRfQknkPPfAWxb+PCo6cHAOEa9W+w0fUakLX?=
 =?us-ascii?Q?qrQCy12GROZTaktDIlYcRpsrIOepsIaFbNouT/ZORYXJ8ahok39dhpE8GMci?=
 =?us-ascii?Q?ldKYGyHs/ak72waUlYQ94v2yVYsC5CxlAHWFI9cLvjmm/VH1d5ZZ1SxnxrWB?=
 =?us-ascii?Q?D3/nEQplX5FJ5ttSQ2BhvUB5eWbdqIZ/iCc+p3cNHdOR5i7ml7hWJHrdxrgz?=
 =?us-ascii?Q?arZ2rHAYjf+1POnRayoVKaqLZM/EvlUmbAQBJn13Il+iXMXuVmnwiYFbx4D8?=
 =?us-ascii?Q?VojyeOTal+C9sfUF3pO8X9taTkzL5DDqzlAM4vfnRaxfJcWoFWRBQL6wp/z2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ee1a9-b11a-4e5e-8544-08db1031f745
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:59.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IDNVFew48OaKCBq/VTrVScjqnbefDaR9PQAbJ52fS1iXoLJWdSUljDgoOOGA/Q/gc+yD4h+H4OQIweEsejRVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: WEMncfBYmhQ2fdbzlFoB1O5Y-fbDpDyG
X-Proofpoint-ORIG-GUID: WEMncfBYmhQ2fdbzlFoB1O5Y-fbDpDyG
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

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-histb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 43c27812dd6d..927ae05dc920 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -450,4 +450,3 @@ static struct platform_driver histb_pcie_platform_driver = {
 module_platform_driver(histb_pcie_platform_driver);
 
 MODULE_DESCRIPTION("HiSilicon STB PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

