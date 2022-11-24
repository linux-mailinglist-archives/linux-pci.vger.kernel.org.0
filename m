Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E46371E2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 06:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKXFvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 00:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKXFvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 00:51:08 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C5CC6891;
        Wed, 23 Nov 2022 21:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6280Gf6euV5R6AyZLQZLvwjPeJVlERRNFrMqzFxhExc+L5vZPRemAx9Dra6fKIV56Rhcb0+YLn5IxGV28jhwrKxrALgIxD4IBAkqjh4iD25FrjXGVx8CCU6Db/TPxPStljBdGboYM2YI8v+Ohoapl7OU9BPq9PKGDPmmQ9DU3k1xE6eHF846KdBLQTU3nWpxvv6wKbWmzOoj+vXdPtorcjFoJwNt0sc1Ge6VTxxRmUYVdEfkCa2Ojx29blaDxEx30rPYheo9sBu459ymI1OPgcjKK/zf1QeqSVXpFRxVmaSgKVigpsTHy/irXmnf84HAshqmeS9CGiin5hzyrx0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGD6RSOYAo0lFDou4r591YrE0IGwB+2GA06tmtcShsA=;
 b=nIX0A9q+mnxN9u+6PYD12pRxItR40lkFEzuUE0Q/qj1OIVwenAbfwzuCGlw7nMtf/kC4yN+dQdS1C8P7DMns0VTtRi7IgrBjdLxPYt89Mv9hFFfWQE3glqioCE8FkUadgOo1Q436G/ZyTWGqqcF0NgSkz/heg/67brdch046Rjezp8hRG4O5Umoo8cnZl/LqE8k2JaWRvJkUACO5vbbG6yMMjDsgv1tXUSZ+CYnq4NeAtbbbmnZNkCRYCqBJf/f6lWv36C+9a/zI7nYR5ZrapKAipziexAQKa8JSwJrlhW1I3LaOMxZHPqjS/sfpe7cLSza1HM1S8GQ9cIDji3PRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGD6RSOYAo0lFDou4r591YrE0IGwB+2GA06tmtcShsA=;
 b=T4dujJzDolQPKtGeNluJXq8NdnTxvZodXkPWG/2KfeRofCMiZcDMnFUWQcsMx6M88s6Tlo97QdhilgN6NusWEqgWDwYED2O5TFQfGiC/HOdshAT0q/u9Aae3D/LlcDWl2qBwJ3wxNW1ytVvVqNTpi0/iJPxO6mBTYlS/NhVEki0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 05:51:02 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Thu, 24 Nov
 2022 05:51:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lznuaa@gmail.com,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v13 0/2] PCI: endpoint: pci-epf-vntb: using platform MSI as doorbell
Date:   Thu, 24 Nov 2022 00:50:34 -0500
Message-Id: <20221124055036.1630573-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eff9183-cf00-4844-57a2-08dacddfdd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scYdUQxLrTkv+jpgejFmzv4cYMfxNOrbngVi6sX9I1o7r5Y/wVLPUjSnvfslMudnqUlqnRs3CncI2Zxp8nsRWR7lKXE6vV45tqWt2+ZbqaGK/s7LbDhTE1qX+uPwUWYm0fs2o1Dkm0vrFSnqpHZMjUZM09jIT31caB1hjIdFrT8KOHUIq1to1TJGZec/QSgH3MtnOv0/9pirs0HI1F6pDakKmF3NkIywBIVYfZ2UEEhPl43UMMwoFjMcM3ZTpFe2QOnhoPBOTWySr0aRGYz4WpulWxwHjkk6hZLrlqQq+y6+VN4UpDP8FXWA0XaXRl4KL/kSweW7lGPzV5GYYSZusEyc9MAZvy68R2D0UcT5izAB4RR4aAWpCahA18KHJw6etxWqojDDmxq+jEHEPEZodmse0fssYI954SndEV/d+6Cbot81a45+dIF+SieJw/CDbJSsou2w082miNpz72QNBlXHDjgtM5Q3IteL7DbzIoqQPZY5M5XoYN8ywkmaTjkH9DjrhzM8uXWcLUnC7XJVv/LSNBkMtZ3HS3V2jZoyWPoHhaRZiNxxceso1krEjFx8bv0ngkePHarzttebr0OjNg4iqaWF/31VI2+tvI30e+kTIDyCtq/SHtKGD3OWVxgH8CQvq9/f3ppCtDnX3pkDRYuvRhl3yKVwULw3PewjqDzUIUaUyYVYABEJKaSlIDNJixpI0BByBJrexM795l9SHmuxv1JOHZhXCA0CXcZ6ZmWKuj+xndi2lgpVy+gbuZzYg49upTDQKkuIM0Lik1ashQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(7416002)(86362001)(38350700002)(4326008)(2906002)(83380400001)(4744005)(38100700002)(316002)(966005)(8936002)(8676002)(66476007)(1076003)(6916009)(2616005)(6486002)(36756003)(478600001)(186003)(6506007)(66946007)(6512007)(5660300002)(66556008)(26005)(6666004)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzh4dHVuMlZGVCt2dHRnV2xTYjdIdzNBWXJLemUvVTF0ZUw1cGpLUC9wOFdN?=
 =?utf-8?B?bFhXZHNZdG92NlBBUk1LL1ZaeXRyblVMVGo5ZDhQZGlHL1JqaUZrdTVTK0ZV?=
 =?utf-8?B?UERzSzEyc1ppbTY0M29TU0tLb0M3UFpVODJmWmtERzJXNkhkN0s4YVlEZVM2?=
 =?utf-8?B?dktSb1BWZzkxNGx0N2hSL1l2VkFjc3R1SUs2aGFyS0p6R1dCaG9Bd0NiemVp?=
 =?utf-8?B?RG53Um5BWGVJZW01c204WWxLQm5LYjNvZlAxMVdFWVF0WW93N1BkRnhPVnB5?=
 =?utf-8?B?R3Z6YXNMTUY1NENRYm0yRlZnVG93SldDdUFrTVh0QnJ4SHdaR1pnbzJKZlEy?=
 =?utf-8?B?Q0xlYm1kZEYrUmhuaHR5by82UHlWeFd1OGlNTktXcGdwTTdyYmJWSDhENjgv?=
 =?utf-8?B?c2ErZ0xRSnpqSGtFQmFKZ1F6WFpnbXdXc1lhTkpDZGxlUHBFeHBnYUtJQ3g5?=
 =?utf-8?B?RmZBK2RuMXpVU1JSNk9xVWs2RThEMjZwYkhzbGFiNDR4NWpQR05aOWhMZVFY?=
 =?utf-8?B?YUJXTVBYTWFJM2w3TEljN1hvWDV5U2xPcTdsc25tUjNoSE1RRDhxbWdTUWJp?=
 =?utf-8?B?Y202NnNBTXFrTkdsVUlZSmppeTlRa0p6N3M3eWp6bFN4Y29JRXJXK0l6aUtW?=
 =?utf-8?B?Yk9Na21Md0dxVTNpeTF3U1FLMmxHNGNJQTI2a3Z1VmtSRHlsQml6UDdsR1dt?=
 =?utf-8?B?dTRTRWZiYnVmRnV4ZEFaQlVXSDlWNmNqZlF3dkdRMHBlTEhJQ1JkRHRnMzF2?=
 =?utf-8?B?VVRhcUdMOUhvRk5aNEdrMDNPZHNNMS9KNVdWbjR5YUI0YmUwR1lpNzlOSXBU?=
 =?utf-8?B?K1JubWRBU09RNk1tS1gydnMwMmtpem5zMHgvMk5ZSmE2VkNndmsvYmtMSFlj?=
 =?utf-8?B?SVhYQkd2NGFEL2RZQWFsaEdGVFY2QWpJTy9iVzI1bUx1Q3JXK2gzQzBKenZq?=
 =?utf-8?B?cFNMYXl2U2g0b3IwUFhMSVdOaTZ1UytHSXRCbFlGVFBwWlIvQjdqbXFURTBt?=
 =?utf-8?B?aFZJK2VVdlFOOElpRzlCdWlHSnlRenk5eU90SnFwM1p1ZTEvVE5pVU5CdEwv?=
 =?utf-8?B?YU1xYUxVMkxWQW5iYTdYQ2NST1JLSzE2TGRSTUZXQjBnbnA3d2xGME9DZWJu?=
 =?utf-8?B?WGdVZm51MlRJc1RhbTVmRGNYRllCOVBzNUZhbTFrVHB2MS9jU3k2M3k5cTl2?=
 =?utf-8?B?ZVJXQmhKTDBQUWttV1FqN01BOStvQ01QNE9ybk9nN1FUbVZWNlRUMk1SSmk1?=
 =?utf-8?B?NDdyNEhQVTlWZisxOHAwNERIUkdvc09SclI1L2tja1pQQ2NvNmpGR21SZE5W?=
 =?utf-8?B?dFNnb1Z6bGxBVE1tMFFEUDlRSVpqa1VackZWNXVFNFd6SmIxQmdYY1ZhS2lw?=
 =?utf-8?B?ODlrQ21VdmJZaFBBYkJ4QW9idXRDOVExMEg1MkliRWErK3MwMmJhVnlLczJS?=
 =?utf-8?B?VU1pL2pxb2hYbDdZcGFRSzhYQmFUVjVyRmR4MXN0WW52dkZGTGNKcmZBUHF5?=
 =?utf-8?B?YWlENXYwZkFqaUpFWEY4NWJCVmVDS2RYUzNnV2pMQXorTkRQaUlzdy9VbEo5?=
 =?utf-8?B?cUhoRWJLUEtwc3FjYm9xSXFUMHFpSkVrWTdUS09aREQvdDMzY3ZyTTIzWmVT?=
 =?utf-8?B?eGxQcm9QMUhoZnpFam5mbE9sUTZLTHBDSEN1amRraDU4OWZwdGovcHFFekZJ?=
 =?utf-8?B?KzZlYTNGcUdNK0ZQKzZSVjRkaG5aanpoL3dSWmR2RGlmYVhRNGpacWI3cDVi?=
 =?utf-8?B?TzN3Tmo2dkF3SE1KVzZtQy9Sc3YrZlhIckI2QnJIdHNYRWQyR2FiNjU3Q2Ja?=
 =?utf-8?B?VlpHUmNFZW40eTJ3dHEvcFgybnZNRlpTMFUzLys3YUpzM281S0V6OG1oMTY4?=
 =?utf-8?B?TEFsY1YrOThhNXQ1M2lGN0dja2hKN1p1TmdrNUpTZDFwT0ZNWWNBWkltcVF3?=
 =?utf-8?B?L0wyY3lqWENRdTNJSTFkQ2R2RnRsRVdCdm1FemllZGhFdzc0REoxd2lMVjBE?=
 =?utf-8?B?alVtTnM2OHNEOHJGMno1b09tSzlTNWoyZ1FIN2x0RzBrYnFUOHJya2R1ejdY?=
 =?utf-8?B?YTdPbzVEMmVhbkNKMEU5Ty9McUFpNFd3YkZFTWdVTlFCTVdXRmdmZnkwd2Y4?=
 =?utf-8?Q?Yps/4abDaffzbUbKLMB9r6yY0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eff9183-cf00-4844-57a2-08dacddfdd06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:51:02.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z50+Be5+AtrHtobeSGEpyeZxucr2jBysIzLeqyoRq3aUL/XNuPPe4WMkh7dOiPIZ+yqBwguqD87Q1plHOTqkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch continue https://lore.kernel.org/linux-pci/20220922163206.21281-1-Frank.Li@nxp.com/
The above patch series fork to two parts. clean up and use msi as
doorbell.

clean up patch already been in https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/endpoint

These patches based on the above git branch.

Change from v12 to v13:
fixed Lorenzo Pieralisi comments in https://lore.kernel.org/imx/Yz%2FuMiElbqB3ThGd@lpieralisi/T/#u
- update diagram
- Add platform_msi_domain_free_irqs at failure path
- sizeof(u32) is because hardcode by ntb_hw_epf.c


Frank Li (2):
  PCI: endpoint: pci-epf-vntb: change doorbell register offset calc
    mathod
  PCI: endpoint: pci-epf-vntb: using platform MSI as doorbell

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 150 +++++++++++++++---
 1 file changed, 127 insertions(+), 23 deletions(-)

-- 
2.34.1

