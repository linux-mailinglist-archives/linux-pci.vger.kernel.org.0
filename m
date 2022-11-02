Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF344616488
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKBOKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKBOKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:10:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5FA1EEF7;
        Wed,  2 Nov 2022 07:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HudWS2rDYctuygKZZvuJYT/B5opWCcGyUbRl9mXhtpDiM/zVbX5l2Du6pD+LSUpheXyVONUfRcqvR7ZE3+QCjxI54713mTc0+f8yI8xvJaknO83NVe98tpM3GZPakd3rDNbEtc+cOHqgNN2owztQPBZH59ySqA8HbX85QH8QyrvW9Mn+7y/s5p2awvtd4UjvwKBP8X8ygoiuEVhas/Z+Kwlye/TJ63UxMwYsRmV6qHqbxzApLpNQM73G3BquwaJJEp7x1pJcNob1t/RovBp22brfNAZqd1K9u9zN2qgywP6wl2C0RW2jJoN+MfR62aGEqTIn2cDlMuazEFts1Cv3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k32PQvpnq8rg1gM/ptYxTDYrQ27DtAfbvNoIW4fbLbQ=;
 b=FSad5UpxfvM8Vk+yUgbTE9HGCsnPaS7DUVrttmoI4TZ8DvN+6UrRCM3Ejr5SXnxyGVr9kyptLNBq3ezYyN9vx9nYZCVT+hNcYr7jXjWamWamx2Qzx9pXWLExE7GmeDgmZxJeZltLPGtWiWJsEu3jyYlVk8MxCj/k/c4v6Q5fYtKkcEbPFyYTESqAPS4CzT9pWfOby8Us9bcOdwF3PuWd23a+99a2EKFSgf7hKOKP6GITyDMw9ZMns4CANVZhw+/eCzIZ4aT+WmXPSy3xyZTQw1+pf/68VCHWC3SdDuYJmhE4b3wyHapRgr0C+Zfe7PHcSmEc5EXWlSJJ/Uh8LFp43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k32PQvpnq8rg1gM/ptYxTDYrQ27DtAfbvNoIW4fbLbQ=;
 b=DxdZEVHJH3YQBPf35F7fP6+jBK7LG0Oh/QiTfqQbw/tfodutLJi+WId3vaDM6cUp6j/lFUBjRFrTlWCiPLs9J23yvJkJDaee5SDZibitQ019kjfYasA2SMYSbsUpHPZogmdqBIo0hoG01n8jBRaotKZKvgt2QMVkDyApDrEsKmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:33 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 0/7]  pci-epf-vntb clean up
Date:   Wed,  2 Nov 2022 10:10:07 -0400
Message-Id: <20221102141014.1025893-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3cbef8-c703-4600-f95d-08dabcdc0150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEPTfTcrvEj30meE0CfYysD4qgmDUD1sJ5ciyEAOC20FeKMK1ds+EjEVvYneuX2/wmjZ8WGxqJVzmpPMtkJjbhiEWYE9/atyRUZXfVf+hgRdBcIxf8ZGrXMq26z3EY/igxhV9HdH+dIp4Cemy7YhfoyISnF+FxSYGdigy+isWXaBBPRGcMF7aSaWSN+7crxGdNrQlPFp/mwkG72qBuMB92kpYvqrwxK7af7r2Mk/omnez8i0K7mwYivTyvDA+CdNftYYbK5ofN/L7dmYZu+TwsGwk/Jsj5HkupLgpJBQw/ZEdQv/AnhxS2CK1wyvW2Ay1xTyXBmiy7b73/RZuI1f8YIeEHmdkH7uFwyvgFAMhMRHdnc8CvNCiNLhwfYCC/oL+5F2MPPU0PJ72qY3pv2crr0KFBoc6YwnCjhDCb9UaFwcHpZVTs1hC80v8U/7h2krqoxXFYjcmvz59HyqSPnoK0Mba/R58jw0/O78upmVN6qdgpiTfAO4a056H+qUNlu5Z+6cRv2bxGe80EVUWGkJqjYDEVa4Lg8SFJoiTr5gJqGA5vNVjlxh/1dZ0/uIkmuHpl87eM4kFBXlTjL0N9QhAlJKcy++CrLpkCeIL8kQJUESsdI4yWwc5H4xaT2g1Z5VYzTyvY9/ZMvMoD/EtVZGos04gIqdU8BjCMo996T4IMhp9735oAnzyMyYr65V5H5FrYGtMl0b2ZAE/YNroXGl3tGVZlLGB3KYgCelY+hdWz/oXOmzdHgDhqImIYbrtnGM0GzqqR0eGx+VujVD3KB/xpy1awnAjXaoFUw9eNT/C/y2WLJuwwQo7qp1iRIc4SPsI/bjWzZiKpRjXJVuYQAjsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(966005)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3XHmxu0Eu2oa2ZMCEAqsXHK5qVoGpSt1WbmepdX6okEvnXyp9fGrjU+/N2n?=
 =?us-ascii?Q?jPyYh6ldIftPXvol3JJlXoHVj8DNG2dutyUPkQt2ikFOSmxUuk/j85f09zDA?=
 =?us-ascii?Q?GyH2ZLVQAuzrMb+EpBv5lpaRdyZH6gmu+aTcA25wnAZW83r5PCGyf9WJS17p?=
 =?us-ascii?Q?rtvXNyAGQ3v8oaLS9Q8PDW3NChkJcDr4KmeQhntcInxgMVmdDlI6x1bYmCwb?=
 =?us-ascii?Q?nAm1WL73hAxLQBL5B6WgSoYotMsU1CSDRnxjEUdPKkOXB9/JPUM67l30v6HD?=
 =?us-ascii?Q?kp0+DBWhoiky/jjKwBxrlSeOjR+zqnHaQF/lpNVzyTr1BqN/WilD29YHUiQK?=
 =?us-ascii?Q?eyU6rHKbua+FkOIcd8/H9jpjYdCtzQCecV9684XPvUH+P0cP4/oAzD7WIWG3?=
 =?us-ascii?Q?9enJel2B12deX0S/ZN0E0lHaAAUMBh8GCMwVPIgskFLwfioraGBNm4mghpXF?=
 =?us-ascii?Q?JPAs2LGRoNWdNR923oq0u4oBV4OQ/zG4JoZN9lWhmMPpaGY19AfRjFRVExD4?=
 =?us-ascii?Q?w7iXajCUFBkcqSyg0qhbbOjf/Vt+eFE1USEhNUiajPUGIMysdVQe9vQWTbRT?=
 =?us-ascii?Q?MErxoCToQ350VCv0c7uNILvQAxr2ip7wBVrnCTD8wLnYmc0fUffmQVZugeNS?=
 =?us-ascii?Q?kSLh9EnHkOFPS63I3NjZpZHTMqH0Xg+NfsiW+hPVHnuSYuVeObeS2zt7b3Ck?=
 =?us-ascii?Q?eKULgKwKlJRDhq2QWRUoz5JT89koHtgCiLgpYOu8H9JyxKjjdxISISDXlhvh?=
 =?us-ascii?Q?KaePGsx++FbTLckvoFqjh+JRm0G/Wcju5v5nf/b4aZSlaJ7Wwz2dwMjlnHar?=
 =?us-ascii?Q?llzTOzh1kejpuolg6TP3xFZEX1IsrvJSHwfCy9qhbQIn8IT/snQ9uvxtgU3u?=
 =?us-ascii?Q?S3512Mp4MT4W/YmkT6mzwpx4LikkVXJosfYMDXWpGE15h73atxGXYFX+yIXc?=
 =?us-ascii?Q?rmMlFBWN8qQ1BIInV3ik44/VHiQg7rdNPHNt9Pl2hOtBD7+tq7RXgHWzDjZ8?=
 =?us-ascii?Q?ti4lNIHpEC6TnvaLqz2Q3+rDP7pubkVwoxZaX65nKQqbMUgorNdBDunsJi9K?=
 =?us-ascii?Q?/iK27/VsBcpcY6asJ9rvarxxhfvupIFmdU/GKRDY0gcB917uehFVf5OeN9KJ?=
 =?us-ascii?Q?1UG7pO5qkVtK/DyMEdEzz1YQKXgKAYYUAGr/Rtwn+YX1aI9QAHs2epIGHpYu?=
 =?us-ascii?Q?xQCZD2JY1AE9nBU0XC87ptlHmbhzz4vW3XGiCVeLjeiolSy6fzP1r9yHkGpt?=
 =?us-ascii?Q?YPZnJaQA3wmliifbTAM9aOx6GJa3gqrvRZdoF/sqZl6cEKC7oHxIVzAEZgcX?=
 =?us-ascii?Q?sT9S8PSEFBT+X/SQBpi1G5ILimsu3FS+HpkZrXm7YG0ORHJedfXO+doBHIRo?=
 =?us-ascii?Q?WbjoPsy1pDeuyBDfZgaA2HdXaMJy2PCIxyTzkQBkHDufwtzoVx4P1nS4YrCO?=
 =?us-ascii?Q?ZP4jNgvMl0utFt9fGsA+jP6hQiHyh80T5Sg56+Q38mgPP5FK8UB1Xg/b4u28?=
 =?us-ascii?Q?JbseePIrz8llJWSnHix5aLL242O1VQVXb6qHvvU+KKifNq0Roq7DzY+w7prt?=
 =?us-ascii?Q?Go54WdqB9NCz03mrSPQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3cbef8-c703-4600-f95d-08dabcdc0150
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:33.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FAWjDanHr2tt++f7NOXaNTPJvsiWotRfoAJ5KvtR2ehGKBTbwmMBu2vY2kU2ox+8oWpQtk5IU9gfarpT1lPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
https://www.spinics.net/lists/linux-pci/msg130924.html

Lorenzo suggest create new series. Version number continue from old one
Change from v15 to v16
  consistent subject
  Add () after pci_epc_mem_free_addr

Change from v14-v15
  Fixed according to Manivannan Sadhasivam's comments, except endian
problem. Endian problem is out of this patch series scope.
  kernel test robot report sparse build warning problem already fixed
at patch 6 and 7.

Change from v13-v14
  split spare warning fix to two patch
  remove local variable reorder

Frank Li (7):
  PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
  PCI: endpoint: pci-epf-vntb: Fix indentation of the struct
    epf_ntb_ctrl
  PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err
    path
  PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
  PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 ++++++++++--------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.34.1

