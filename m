Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772769247F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjBJRcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjBJRcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:32:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8E078D6C;
        Fri, 10 Feb 2023 09:32:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFO8pW031086;
        Fri, 10 Feb 2023 17:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=K0rtXJOevCeTy9zI9iNUy8835YavGLlPvGKFGX0sJdQ=;
 b=eCZ2PvJWuWoqhWTmaSE1WuC+xUJkjafgWj4iV4NDp9pKODTW5TftorGJpaFFlSWjlONh
 3S0YNqPVEtrNdUv2X2p2FwQ4BfT3viyJEfI268TZ4z1fT3d/WKSbfJI7Nn34hKmKWx3O
 YImaWTg5kS48EAEaCdguT8b80nOGY4qbftX7gy/na5Zgz/iW240YyldV1RDSI50W/WrD
 WSQgnOUfXuCBk7lHTeKt0STo6mONKQfIXxOSQs20EOMIqthLL6ZQtN4kI+uHfderoQ+S
 P129nvyHiPqdLYC70W68IK4XFaSJhr+qihHVk5pw1V+zhgFfuNDWcNrgveq12kHvo9jv Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu5w5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:32:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFx7Gt013675;
        Fri, 10 Feb 2023 17:32:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtahe44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THHWYai+l6C1dUDMdVdmj86QVpkivsfK2pSDlFmmQWrNa/WHrSx5kvdKZTcb9qyy0GLKV8u1MnztGEEv2HzbhO7VITcAtX3PS9lnRCWDY5zeN5oij3UkvnCEt6OfeenqaL7K06ok1hIs/QvVo6GQ26vufA/YJIZsSlYUY7bgVps3uy3j4xycME+y/J126gHBiuAZXgAJ4XcgZ41oPKP3UXWqMoP7wlj/4kl1hURqtd5vu51g1zhQrnKTEqj4TmXNYCKBSG6Ht+cHGzCMDqzjvGHiEj0ikhM4P1N8NdyqK9Fm3A9YO9oKZhBTB4DKYnK2Qq8zact6eV6fzx30JC+tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0rtXJOevCeTy9zI9iNUy8835YavGLlPvGKFGX0sJdQ=;
 b=Kh6T9VYtv96ODU/dWX0eX0PbevUKqmG51ZD2V/QgnEpq9vTtCN4g7tBadbriJLPSIwFf2CKAzFOZSYLHXx4rTDIKkpzuTpz5WGBmt7Ekd8PWtdfCJ74mnT5iSxPggbwrXxIs7VgwR/Dto9/dfxSgg/Cq4aKheMLx7lOtpyODXZ4lFbduxMt0jt35PtU+EZixI6vYeba8k2/x4frvVQvaW6v7XlARoAde8ESQPNgnJvcfmaRgLbkgLlaTaBDbiWcafIK9zb0l70HFEfcGtoZPubczTWhE7sWAT8ghPuvLtJZVzwJQnrEqy4q8YSZ9D6aX7dNChjJsTVByWML5PexBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0rtXJOevCeTy9zI9iNUy8835YavGLlPvGKFGX0sJdQ=;
 b=VWs3TwisEhWYgnvDOEIv6R6eOIb+yPJZDGVvO/lPg0WNcnPqQBJbei1ktnlW7ribH2JTKuS2Yf85PGY8Ob16vM+cmd7hUXjPGpOAZmNMcDeai7mTvPc1cHN920HxLAgvroJOC6z3ISl2mJtbZmr5wgGYGAabm8d0Av7/ncE+giU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB6809.namprd10.prod.outlook.com (2603:10b6:610:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 17:32:35 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:32:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/8] kbuild, ARM: tegra: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:44 +0000
Message-Id: <20230210164749.368998-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cade77-60b5-48e5-091d-08db0b8ccc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KUCz/ZW2qrlQKiV86inVmHkfyFEQPCE21rTbW7rR4/2j+QYzbjOo5N1Yqf6c4pdzCgdRPk9kFd6yZH+Y5NRJAKjATRy/7XrjDMwcY+XLUEXmsQ6+dioGhNewWu2rvWuK8tgZo76yOh7x6bAqU7Vlth9yBBNSy1Dq35dYPiZRMa8MhD5I3UDOjKQs9o0wP+PLif2mLLETIZq1xwLa4Q3yxGR4nbhgL4+3RCdSfapgK6XuCLHz6tREPBha8NNxUuoWqMYt8G1zBgxebmWGmhaA/FJqiKJTS5CxsMpWMp4egKad4oZqdB42KIiEWU06m9G7iyIYvzHZEHJ2aG8TFGJgYyq0AaXd4nFSTQiZ3utci1FUEY5MmiL6tUgo81kDTq6mhrg1NtjB+LHLxopvNacl/IShVwFmiYnMl0VlN8I16QbpPLSFpX0QE85V5DWzZ5STRkbdEWNz7vgD0k+7FO2QqHYrUhnrD/9yDgOmTBhNnQy5JV64m33Vh+Gnmx1zRs6OFCucqtN8boTGWvdVldCjnt8tvxsx65MMN2yweOeI94+Rmm7Byw8E14yLgMR4vtXFZY8UkhR2stvdovIMfc34/pT0mLOMXNDtAieodgVQ6RTRtxA6Ch7T7NWMrdozc5d0+V0L+bWK8ZCkfd5zUvz3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199018)(6666004)(41300700001)(6916009)(8676002)(66946007)(4326008)(66476007)(66556008)(83380400001)(86362001)(38100700002)(6506007)(1076003)(44832011)(36756003)(2616005)(186003)(8936002)(5660300002)(26005)(6486002)(478600001)(316002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tz//CR4436HU3STDCx7j8ZwWXh0WoUz/P889N0P2GVo3Bb4mL3rAy99vXKd?=
 =?us-ascii?Q?AQYKSSYPjne8TMKznSuSaCLgsVyE415LHI5O5reWYDfGMjshTjayxr4v5MkY?=
 =?us-ascii?Q?jZID6d1CkkD4ACHI2fmrlXDcAkc43Pcr/f8o7XQIU/gjjDk/6PlZwW5ERMfQ?=
 =?us-ascii?Q?hRjb7vFTGnKWGBxY/Pbi8/n2X23f7yvRlk2br6PqtxRBWPhYpPzgq7Cfpjd0?=
 =?us-ascii?Q?wXKTj5rHU/TBB67jjjRco5qPUZKButN00p2InqEk5li7zmM9Viiwy5btQR5j?=
 =?us-ascii?Q?eO/Igq7NSmOf0hWlZSvpMMHZt0nsaiAzgaPQTCfpSuiUriW7oNqg7xpLJB43?=
 =?us-ascii?Q?HpcTwgGpdWiubsmk5qYIE85X7ZpaLiXXVeOBCP12Iy6PvLw1yU3E8TxL+B1q?=
 =?us-ascii?Q?hjeP6bhoUocPRsbN3l/e7ygWVwPcsh+HF+d4xrltgBu1miVomq0/Fy/vh8QZ?=
 =?us-ascii?Q?HhaXb1uMRPx+U2zkbPOPHIjeUYdlg2+/pO/4fbwwOzKct0twC8iKd/JE/t72?=
 =?us-ascii?Q?0f1op+DcY+D42Vu/0SoQGAPlCE6MaYrQTaYIqxT4hhC445EH0zB/GElgleBo?=
 =?us-ascii?Q?ZWSgpvLCkk4Qy0peoM92UCVQY+pWE6fIpMDJ8w1iaZVKdPUyIb6m0ch7PmEb?=
 =?us-ascii?Q?4Z6JaIY3NjoS+BnWJtvb1l1eLsomLvGSNUgFTueDtxd6buY/WuBzssL3+Rtz?=
 =?us-ascii?Q?LxBjdlgX/RXjgnlxbDl3Ej2oIWs8DNkOy5wqaICDzVWuG4XYpqlG9rNSAsWx?=
 =?us-ascii?Q?Aako4WAYJBP0eNXWTjH86+8dHBBVilgBSIhuPFJAm3zKjKQWIHN6md/lpxib?=
 =?us-ascii?Q?FdZeqa1w+wMlRDiubo+/6YrSgVhOiOpsY+uaLFPT4CAVmckHFNO6NOgOY+Tw?=
 =?us-ascii?Q?ttOYPirMfgtxy1VHQnw91MB72bEaeofMUtkjoS9GBZLnH72YpggSiqFT+i9z?=
 =?us-ascii?Q?wyhQGAos8dK6kg05P9Pqfjpz4umOKJ8jNnn5T1omooXZEQThkGdjpQ4ydq3n?=
 =?us-ascii?Q?ZC/Fanq5eGQCSgeEQTy6+9Ra1Mc2Z7mcRL0gvPeSrI1+4pDyy3CEY+GMtR2E?=
 =?us-ascii?Q?5RwXwb0L2DDPs7/mMHrGmKi4HxqetDktuwG6A1tClNs6wnpsQDp4+L9MSwoT?=
 =?us-ascii?Q?h+ZLAzKNMsjCSI3Jjxa96Rbz/RnObfwmvdnHD3GjY2+COatWU4NfajtctfN0?=
 =?us-ascii?Q?Zs61ghaDFp0bsbJK6+jFSxPjmlinXgDj9syK4dldCakYwxje2rSetLEpycG9?=
 =?us-ascii?Q?Jsb7n0+8pPZW5yiWVMfPc4cH6lSnLh1tuk6SbRp8YuS5+oLiiVY9GxH/9mMm?=
 =?us-ascii?Q?31RtQ5CFaH5PxOpKJi1899W+zSKcp4/Lw8rA5AxxpjEpy9q0f6FyBj25Qt2M?=
 =?us-ascii?Q?VbUZ38UxmlIiRelhc2Y4xGdqYDvz8+wdVjO0N+w1XYhyEVZUc+8EbHw5h5N4?=
 =?us-ascii?Q?fIuwvFVn3TIbcg5U2b0OvlIzvkcyu1k/2Ngh6PzEWpoeOqwDGR5lPJK3XYe3?=
 =?us-ascii?Q?A5x/rOTxhZvUd4TrxW7Aetfbh1GAtBP3/xc8wVgSMsU3M6X0ndww3Tevd2hf?=
 =?us-ascii?Q?cgz0fey6LFYqUUip/ym/9X9dijNMqmEVQXyJf+5s2q+LXdiD/GDCPV08d88a?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Brk2xETjXJQ8gAcWcw1LlRyjG+HdGEBc5Rc9VWu6v0iEhxjX94d46MRDegiIhqIwdrFNKUYvgOMBA4J4o8Px3MZagmg2retbMrzRjz8a+SzN9wY5opMvoks/XDDbHtjFt2GUFVGCGn2sBXiF/567j7Gcm+/4I6E8573izEAVc02DBBzbckG7UJ4kfhfJ9GGv8Y8lzcj4k2eIk3y4Ijuf3y/mwF+3rD1jFlLIvOtdtiLGKVSXPi2CTg2vENJhy7TZuR6ZhkvaHzt4vsAu21AQql0g8B5r3oNjSy8ACaZONKsgjejJOw9AYHY+c4OzQhZ/YyDGwkTb6Es7o3/6GmmQ76qL2nsuY9yRwjIo0kLPj8JG3mW1b0W9BWHweHQ8q0j68aYjdY5OVQIGWOhBkJXfsF4i/JGnUTNwZ+uVJXW6VjZEGUMiZ+g1Qbhgx8XFTvCoV2jd42CIPXCnEjIjRIzcN2hv02JFULyAU39/Vn10SX2T6Jar3daS4JJjF4LVGqFoviFcC8LvvpD89J257yppO+G5Fjg/X2nRvWxcC7SLiBpiRF20bOcRoYdVAeCbzhG/A7o3mQBzGc2mFiXKkuEF+5K6v5SgCU0s/nb9dMfxsZEe5DV9G4BFiFlKRu8Qva5V3Mh/GmFZMld0P5XPjUhcObAsJtqfLfKR5DghJOudnyrb4Q8FD6abtoB9bmkYKtf98X2j6VnQm/+z37PRBbQqq16T6KqW5iiGywMqyyQvaFJvomPrMX0GYqPGoGd0lxpiAQzKDcBSS8eCe9ePXRhoaxKavfa0OLBYMtRJR9lxZ7FnvLdxJTvALMu+gNokEH3eTswrGjq6CBt6M4/FLQlIxg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cade77-60b5-48e5-091d-08db0b8ccc34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:32:35.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MjUtOIhW77NQqj3R6snJ/Hl5qEkHem7LvdiRY/KWY0L7kekoAi/N7FkB45Mz4Q8C5PfewFJoeA6fGXtbljfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100145
X-Proofpoint-GUID: jTs4Txu9ocAbe3pmHnB87Zdfc2V7MN_-
X-Proofpoint-ORIG-GUID: jTs4Txu9ocAbe3pmHnB87Zdfc2V7MN_-
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-tegra@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 929f9363e94b..aab1497411c4 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2814,4 +2814,4 @@ static struct platform_driver tegra_pcie_driver = {
 	.remove = tegra_pcie_remove,
 };
 module_platform_driver(tegra_pcie_driver);
-MODULE_LICENSE("GPL");
+/* MODULE_LICENSE("GPL"); */
-- 
2.39.1.268.g9de2f9a303

