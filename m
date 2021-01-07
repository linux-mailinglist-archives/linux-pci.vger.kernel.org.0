Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DD2ECC31
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAGJDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 04:03:30 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:21197
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbhAGJD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 04:03:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVO4srd/TVQaRFDLAE9+Lx6FlYluU6eamnfK3Y4W07bZQoEOSjxksincufyEAGGGALA4dxbjctARycaS3yDcT35jWbTv2N32na0wyDmpDEprI+PIQ/yNkOyi57SChjE2aCbaStWyuaNus55u1rl84C55z3lMMlEhdNu4n9afhd6VRTb0THwtxxgpf5VeLf/hCxBXC2LHKVyfEh5x1ctQ14xudthwx0jij55xih2JRpv6XMWL2w2K4l5IxO9l+R3kWDuaCKbSqXvDtmwcUqjPyRcuLzYLyXUu6Nby3I60yju58brIi0X3nf748J3riFtOpbZeWCJAorGO+DjN2PfN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZSDK6CDrtWxVcnSPNlCMPqROCftudZh1zvB/4l8Uk8=;
 b=Iykl2U7TJJlTCGKbOAndMCH3WYeyY6PIAU8Ag1fa0diRjp6rR1Pbv6f0+uIUX6fwD/YkiUvKwO9RzCWpex+lgHsbAzWVyF2Hk7a67lSpb6nR1z1dppklJd2m0OFnMDK4/zBM1R8MXqUTvrGFwUa0X/QCEy9s1GmGikh4kVOzShEoKMCypsMOWYBbM0c44jNFM0h/CnOyzR8w0gjf8i+oBI9qKpMjftN0oEOI2+qWljcT7xxcZxvVGxsDncy7++UI7kaEn3gOtES6L4s/xKFI/ykJuDyWP4XTdL9ShqgzhWIQzZYesXRHpWGLJlrjpLRvtX/vicDNldzEZqwOIMHjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZSDK6CDrtWxVcnSPNlCMPqROCftudZh1zvB/4l8Uk8=;
 b=q5FCkEc9Toudj5SrB3XLn/JKzbEHaRV3g4pdjfPwZXhzRq+cD6zu7GlRYLsgP+N+WzUkWVrUwjq80RWkVgPA93z5MC02W0Z1qozn2qgTUDeCOF/NySSnNxUMc8wK5r/g6xTCbQjDRaF14+waI2xiQNtiMRFaJH9jtU/nFzHV400=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Thu, 7 Jan
 2021 09:02:37 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 09:02:37 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@axis.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     kishon@ti.com, minghuan.Lian@nxp.com, jesper.nilsson@axis.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hayashi.kunihiko@socionext.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 0/4] PCI: dwc: Refine the EP code no functionality change
Date:   Thu,  7 Jan 2021 17:11:19 +0800
Message-Id: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 09:02:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44fa73d0-ba10-4b07-cfe4-08d8b2eafaca
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB22977C4A12C92181DC38E24084AF0@HE1PR0401MB2297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+Dd7cNN7VkHOMhs8A2aBtzJ9mRlqMifKY3u0jmcLSQpH0KKuDhH2TEOQjhvprkO1x7866zR9ZTRi3lywie++zzqAio3a7+eha4jiwPHVnsG2x3h/t9lSlfvstObYYK6Xqd8Ht3lU86BPwB1+BbE2n95M42LayKs3nWTAJbpaH23hy4zyIu3Ypi1twyoXnXGvUE+dhOhpMCoRgbFb0P0oesoPTRNxJffqzHbYbZNrh+1hNTbkQIjjE0lXiDiMNmc/9ceW091S5w1U0N83YI3x4Ep5dkEpW90FOrsiUtlnl5Ejfc00KuTsOUFNj2kWOAwVRwghKlndqRZ5/43eX2c82FYI4x2+4l7fD1GVHDKKniNS9BlrWOrlShQ8bZVPNGQsTV1YlKZAeMws8nUZBwOY1zoKO+uVqC7uPYQYcJvxz82Bt6NdTTUea3r47hAK065hWQAzNjyRtPO9VxM0QfFIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(52116002)(5660300002)(7416002)(66556008)(1076003)(26005)(6486002)(66476007)(4744005)(83380400001)(186003)(6506007)(16526019)(69590400011)(8936002)(66946007)(316002)(86362001)(2616005)(2906002)(36756003)(956004)(8676002)(6666004)(478600001)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IjZ0zfyb4cawJ/yrCtF3d4+jqn+VIM/1NurvIyvVkLwDXfsy0e/nPgst9XCk?=
 =?us-ascii?Q?hQza/vInISU4CiG4ZNn9LaoNaq2jB39ZRhKQK1nbJBl5k9YrWvrmA4c0qcRC?=
 =?us-ascii?Q?lYI5anYYmMj3USQ84bJh2JL0pd9Tv/8cXdfonWVXtVQzkidXw9Fwvjh7R+KB?=
 =?us-ascii?Q?CFUua4m/0guXtHUHZsngODT50fL7JdQuKKWAhdGn7eGAZdpHB8dWS9/r3TAc?=
 =?us-ascii?Q?SWwPhjLaNVVzxRlPg1ZSbwv9mRHu87mfWg+YJk8a8WuSnbiz7+GQEwXLivEZ?=
 =?us-ascii?Q?obOLKYQF021/7jPWxDmtudrNImxgAp6d6p4q6us1bI9sSUNSVebi52QzYIsx?=
 =?us-ascii?Q?uWXHjQ+l2EpGpOJ9caExEIrBhifzlUChZ19rQ05mwAJCsW5DdPbYt7TslvPb?=
 =?us-ascii?Q?aQsCgxcc2DJeF3l5u9RCgbnTpM8bX76tKFELse8b9agaciSwegUb58oIXM7S?=
 =?us-ascii?Q?nbjBgqclFBbvmLr8iK6MIkBfBUf3SjwskWFaj3YP+OxzRbYbjwgPz/m8rXwo?=
 =?us-ascii?Q?+u1D2N4He+a/UxOJDjSjp2mS4RuJdbhjJlLPWfZ4xP5GP4/cHMhj/TFT3Jl4?=
 =?us-ascii?Q?7KT+Gd8EyQc6KgWgbkZ/RD7E67M7b/QSYMsmhqp+qI5tspTrof31O2UZ2sCv?=
 =?us-ascii?Q?lmDXfVk3efGIxDvaqsCLJcaJK8zXEBRxpsalxwWN1GoP53DPgdkQb3Ira7i6?=
 =?us-ascii?Q?dN7/0mZh4niIg4jyz0ZV5aOUwXjFJ0bnbkz+oZ7bCXtfuR69g9dwyf4LfwvB?=
 =?us-ascii?Q?HJNLB3GdsDW7V+cGZypJACzIOqvq9VwBjt6sx/dl3ZqlSV8h/GewNjtwrEIe?=
 =?us-ascii?Q?OWljdNn6T+c0XY9KqvK4StRtDzvBnlAsu12x/M403OmgMhW7MUMa4HlDWDyJ?=
 =?us-ascii?Q?YeKQmOQAMaDqYwdQ+MSkUAQjW3t36bPZdsif6o6QNCyGeAz9BBbWDqEiw4d8?=
 =?us-ascii?Q?+Vg606Ew1jjYN4JVjQV9w/6xhParv14vgn6Xxai+XAAsOndfX8tzGEB9GKb7?=
 =?us-ascii?Q?8ZDR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 09:02:37.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fa73d0-ba10-4b07-cfe4-08d8b2eafaca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npoDiaF8O3aIO2HAeN2mvKBJ5xRNk4z15f4Q4ftulJ0LbyofiwxthsR5X7HHvhIeLu92T1uB3ACU332iXddKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Tune the EP mode code slightly to make it more readable.

Hou Zhiqiang (4):
  PCI: dwc: Change to use an array to store the structure of functions
  PCI: dwc: Add CFG offset info into function's represented structure
  PCI: dwc: Rename callback function func_conf_select and its instance
  PCI: dwc: Change the parameter of function dw_pcie_ep_reset_bar()

 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   8 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 192 ++++++++----------
 .../pci/controller/dwc/pcie-designware-plat.c |   3 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  11 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   3 +-
 7 files changed, 96 insertions(+), 125 deletions(-)

-- 
2.17.1

