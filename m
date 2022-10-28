Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FD61169C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJ1P7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJ1P6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:58:19 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87EA21553C;
        Fri, 28 Oct 2022 08:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDYXbQBGST5MNktHqxV5DlNFvbIzyP069FlfhQGdZkVAsTGmvfoAAiZLMOJGnsbEvAgNN37398NRgDPA3FnkoITUbreWySxSO23y5aAq++zlCglz95UoVNirxlIGRzXkfyk4IIfVNMjeMyJngpyocP7IoT0fKIclH8lZYZ3dTpy6rt8c4asXcPFJfOpzXK4C9aMVBZIQnXR4eHmCNgDZ8u02xdBGYtNqa8J76Bb4DxSVwoyn4iYvkU0SJ1Cf1nfPylBYXaCOV2FuOAHk8QqmVPuyPZpdx3mFNpqLozUJpoVzxoGxf4ZLuEBlLoD3beueKm6e3myZ8wxybNNCG37ZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=UmsRE7JYL91Ytw2OrKdhwBpwFPYphHJIfiWXdUZFhC6kK/B2/jKR1Bj4888tTlu7eZOdtvz52IQ23Eg9JRmpnXUpLIlgd+wJaWrnRFuhwVChXwuwq7hVcKMP7vt06qn/CoD+QXit+CaQj6CfBvd/auYgCvko1En62qdrc2mNsyHfRwQAIondgzFOJG38n2Epv1QIuiCcrf0u/7bO86N6P8tsAKzzHLm4n2KyjMEyq6QV2R3oEFwlA8KHwhdviUxsik8EUDgMB1Pg1mZcJOu+A5hzUUSnVMgcQ/5QugP1Hz9UO0EUgkZ/QS4AN93+5oZKsmL3mtkn41c/fWs/+iHLFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=UcvEaysdP096NIeDxlocT9UVZ0l1SyVeeDSHBJQe/+tRrODja4AlneQPTNHJMHJZKu/zLXyM2Wl5G8v2/1++j+qMyJt9P+pfwuMotqvrsVU4lfflMEsHJSIfsb5FEL6bojiWG5OFDSJfyLKz1qO/axDH+FrQaOaA48LyBlh2guA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:34 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 2/7] PCI: endpoint: pci-epf-vntb: Fix indentation of the struct epf_ntb_ctrl
Date:   Fri, 28 Oct 2022 11:56:58 -0400
Message-Id: <20221028155703.318928-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028155703.318928-1-Frank.Li@nxp.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2cafe4-32ae-4bf6-7741-08dab8fd2086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLn8pjM2g6/A/qQIpVh8Y4JVOslOjq0DkyjZMMppdRQXVY/3wDpOfmHapd4JGVaFdmSaNnXK2bcEKFHvdmXuVtZf2HgtHipPwWA+wn9zhaIYXhFgb3IuQQNwakPfeMAQ+Wtg3u9+5swEOFRM21GtNKtvMqogLYH0u5fPVGO/vMF1/V/V254XTX83wXgSLGBuXY/JlgdT/kyvnLFIQOuhgeIch1jtFrZafSdysh1qVw1dVfDXbTa9amUITZ0IqRe1G/d5Y3EesIz3lfY3FkYpLPfGMcmcfuEndzqrx49pru93JCMvoNuNToIu4XftR9lBC2YJuKu1U6xGlCwHqT/clbGZDSwAeadY9s62I2ClcKNOC+HyVeqmls84MWveNzpC1J8VQBakJwjDYFUTaY6Ytx/m4RQUo32WJx6AvcAQZtWZp4S053vSfkKG3jvVnGV4eE7xaVfHzGFEw0SleXvv37B8MmCTmQ+1Lr/A3Z/8SX6RC7eD8Lcor0ZfAFni0vPfTLwZYN0NReVZLoS+ybB/FPXzXvPf5xyvCvV2Dxp6LyFIZKYunBuKH64yHYGJ6jQfg7BDWIlNZpIk+Kbft4vOWuy6Y1iPrwCT3d/Y5xewpfvkUeUb49lHlXVZH1Ai0UnBo1EkdRthG6FOd4KrpivnsfihRXqoE1H/ZcLxJ0UAtG5n/7GoWhTNUgP/HU/QEsT6DF7Ou6/g4iPsjyJhc61sTx9jPztnH3vGtukmc7kuxBcgAxgNB0wCV/wO/jNZLWI2BIdN2PYk53TbglIQY4RRVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5U6nsimmvxBEZBNnK21dS8Qno0uX/KEhhlXigb/zO/t7e5ykYSCde7+EbKX?=
 =?us-ascii?Q?+qr5jsi5sWDhgM5a7urXLmanGfDk5rHiI1u2suNApM3nK8zhcRcYD9Tiyexg?=
 =?us-ascii?Q?kJgrvH2G9UAZzo0pqwhh3TC0EArH0VSd2apqFKdljMu/8/xvZHQszVnzDYSg?=
 =?us-ascii?Q?4yMxMgASXPRVr2a/BPqml/EG6iFj/lkhzYde3VajfFqSb2bE58E44PRJHP2J?=
 =?us-ascii?Q?Elu9fT4j+Lr3h1dPlb6DrMqO7u06QxQ6qULNSRWoVCK4d8kitKcBMlo3J2Wm?=
 =?us-ascii?Q?6bp+l4TrSyMqZVLa/aDs0IFvtVn9zjP0he1+ARwYgLwtcDhyWs68qvgNF8mm?=
 =?us-ascii?Q?trPurN/X/+05zi3qwXD5Ts3Tuf8jihVKo6wrfQym5muKKEJl9z45i6Ycxys3?=
 =?us-ascii?Q?y1FqoLN6hqfyBx+9RaHMRz7Pd3gh/edXmPsUw2VAnPNjFcfKnn+12GFtbFxY?=
 =?us-ascii?Q?1PVrL2tTiq0GvaezBEJieFsT0U0g7bALg54CaycfmswazOpsuU1fR/xqvERV?=
 =?us-ascii?Q?S9xLRGxi/MWfP1rneUBM1ftOZmLVllBB9uYAZeP1oY6vAZ27hN4jq8N0hAs9?=
 =?us-ascii?Q?8NdRAOal+KMYGbseSbuWZIqnbl0OXaxhHynfz0JjzB7MQtz+q/blwmmA5xM8?=
 =?us-ascii?Q?zsC8qLCcybTEFrjs5SgFXOw17VZK2ZlB54BXFwo8eho1Gf7tFZaKIGjeDWX0?=
 =?us-ascii?Q?b6t0gxp4jCJGg4qmGmpjziGZpNVsxjmebaNarS83LgljJwu92Uje2Svkunkz?=
 =?us-ascii?Q?Cv6aXnJG5cog6D9Ac7wmjK23xUZK9sKh0XG2Mm4/diBK361VwlEoYqzOMZf3?=
 =?us-ascii?Q?VlQrEdEfvhVGIqw3bOXK/7AgL2cWXu/8mIFbDdzrX7NE/P7iv8/inZk3IyjD?=
 =?us-ascii?Q?bFxAJHXKxWbx++zz/ebs/4BsgQPnHCIl6uSZlI8y9T+vhMocC+sYvYSUDWoN?=
 =?us-ascii?Q?TpX1sGqxyXBLe+LIhsqSsOly1STFln/mxB45+cpVovCGjc8ghdUqLHTtZxek?=
 =?us-ascii?Q?wHaEptVnLnzSlf3Q0Jht8E24EZMHo9SMB4mIn/yPXtXDrvKwkrB0a/Zv023L?=
 =?us-ascii?Q?cnUoUawvaXZ8+6gWg7a6toL/iPlTpezONDPKr3kMIRbe61+ehqUz0wFjlm75?=
 =?us-ascii?Q?34f04OxyAkKPk7fE36lo9FexHvrgMGOOiUjdiufqQ/z/lRkRVF2cJmTUk5Hp?=
 =?us-ascii?Q?bysQnhXpCzWhslq9ca86e+kG2B69l8ZpyeboPyML5QV1EPWhlY5P+EG5VZNb?=
 =?us-ascii?Q?4c/1bMICQ0IudmVytFZZHnXUaNRrd+deWNaHOFm/MMbsNx5ZBihqIGyoYvLk?=
 =?us-ascii?Q?CM8zpBB7oYdSDWDATfCiCTdShy9Jwyc2lh+zo6TAOdDSeU3bAxMPzYfSFG7T?=
 =?us-ascii?Q?B6uJUPlrGhDDlAvxkKIFGEyH7YQhFGO8MwFXJbpo5fu7g93wwRU35UCbdgtC?=
 =?us-ascii?Q?wGFQecEunUjYTlc8v/Uz7w648GpKWE/+ljbLk8/bGg0IgBx00bwCxVhRWyn+?=
 =?us-ascii?Q?tfh1QAHcoXuQTvBzzY4KXa10Pu0l1enng7F5cg05heNvE07ba7/CUPMXsL1V?=
 =?us-ascii?Q?kb7uNW58bhicxUSLzxI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2cafe4-32ae-4bf6-7741-08dab8fd2086
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:34.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e923BGN62rLDEicJsUhURDWbCti61jC3k0hflsOli2qb1B43vXQ9zaYAFcCYbd9N0I0z/tevzGsQwvShwGiqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Indentation of the struct epf_ntb_ctrl align with other struct

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c0115bcb3b5e..1863006cc36c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -99,20 +99,20 @@ enum epf_ntb_bar {
  *       NTB Driver               NTB Driver
  */
 struct epf_ntb_ctrl {
-	u32     command;
-	u32     argument;
-	u16     command_status;
-	u16     link_status;
-	u32     topology;
-	u64     addr;
-	u64     size;
-	u32     num_mws;
-	u32	reserved;
-	u32     spad_offset;
-	u32     spad_count;
-	u32	db_entry_size;
-	u32     db_data[MAX_DB_COUNT];
-	u32     db_offset[MAX_DB_COUNT];
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 reserved;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[MAX_DB_COUNT];
+	u32 db_offset[MAX_DB_COUNT];
 } __packed;
 
 struct epf_ntb {
-- 
2.34.1

