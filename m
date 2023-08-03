Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B476ED84
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjHCPEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjHCPEi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:04:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D57187;
        Thu,  3 Aug 2023 08:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enyBMaOVYnDJKtzC1tlXxt6XGZlBWyVJ0Jy60LjS1U6AHyEXyK5XDGJDBFvIuWaNExcMqxsNI6xZMzvmJQbihaoeyP9yLVXGMcySL85ljd4h7bYyEg3AEWgi4nz1m3K1G8uGJmWoecKrUPBM9Xv36UVHqVKjX3fKHvoG5sVZYD+5f5rp93NahuIHazxFmUjks30mF5ImyDNtjDkY5CLcgA7X3JUkAzmq9wdc0uqwgZTVx20igYhOvDHNOu0mPzaxQHyvazoUGEg5SvibH4Pli4Lxi6OgRMhMCM8sI53xEYNZjQL+F0nhFg7qzz524O99+F4mPl3oUPS8/cZ034Ookw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJkfjaLRfErs5J+V+8p84WZmDnw9awtPAeq30m3oVW4=;
 b=TQOUjuegTl7wG5yrm2TIkEqsq+qkyF80WVbZEbRIL1N3dS/ONQY1xkek/lo7OPxJogsV3ss83sktZbRs6zpi03gqOweVWrcr/B72emQz8RGKVUqFm5VJi7YiKB7Ze/pUyWg1PrJXtHAVzxd4rTxKEKxM4ExDF1QpkRsUB4n8YU42k/zwBq7QkbGziiRbJxmm4v7aWZRWDexkT1O2qL5oDcsXfpsH87aHKg59OIIUyDttgpTWxNrzy5mtfeXuauWska4Ixz6tXF0nOCTzY/IfH237FizmVLqrU8AfX78althgNEV3LMpOPH6cJVACgMME1CFdk55t810E1L/OR/eGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJkfjaLRfErs5J+V+8p84WZmDnw9awtPAeq30m3oVW4=;
 b=VPXOBlyWiJK4wi1JlCHdjwSjWAjUnJFQJZqqv+3ZtGNPnRN6OtzB2NXgNsGik2kvlobAt3/EI+3fgGMqU5JOE59tZIgAVeO6exIBNQasXrvoMhvPuaQss3iyoCs14wKMoDDvebFnEylndJh6kM9KckNu5tmKP9gzv/3123TrhKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:04:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:04:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v8 0/3] dwc general suspend/resume functionality
Date:   Thu,  3 Aug 2023 11:04:06 -0400
Message-Id: <20230803150409.271155-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 648059d5-22d9-4bc0-ccf4-08db9432f0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aR+AJFSvT6tL0FUENPek3Trd5r8iElsO6xMXr7XcQcBYLBGKsME00EygR0e97ZlTU6YgLZfLkwfejBKXU310iDJ1+Huz/S4rOhWYO3DmwcB4xYLy+ltasmR2RxP/XOlPOqJLcQVo9qLpeBrNiRoSK5/OZKHLwfhCwUNLQ5YCk2r8i2fimgrR/kHf+0RtgBKmqwNnB5JGCZuw8Db0oM/ODIh5kc0TbLxXyvG6+4B35tC/eGfksWeCCR066Qnlkuyy9E0hAyt7L/dMcFHawH585OLlvkOeGYAgkYR4vehzA3o/HPfp2XDrIGt7x/7Jb8llixQq5uzfDVFa2XlnXkYIFl5lYTx2svdLy9qpa+WR4wXv3YTsj9JC+ngSZYY66Twzs5bYQt6AzXDwssF6Kq3dyagyuc7ZPCCnJAF+LscZxETgFyuoh5p6JK10hT3LRb9LIQGbbQxZ3skuOY1luJTgR0RxTUZdnnz0G5CWVhvZsLQxYGkyjspAIChf8DK4VdUni8pkoz+gXMquBNN7+GjcH85WNfxtx29KXoI3WsKrfGzRzOCHz9qadRk8/9j7AJfWRkDGAv0f81y8UrBNSvG0PRYZt6aorE4Ksb9wxoX0HxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52116002)(1076003)(2616005)(83380400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(316002)(66476007)(7416002)(6666004)(6486002)(15650500001)(966005)(6512007)(478600001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k43jSKAPkl194coGVAdUMVyXna3xZMxWX3FYkZYObrnOKAJh58DMFt70Xbby?=
 =?us-ascii?Q?Ln9fnO++V8wAWRZJwKCpY3yDvPHn77zdHH5EQQzk7h0/b2dLuP1L9ccBmX5g?=
 =?us-ascii?Q?AMh8fBRaExskwucQRrbpdoZHkmVFp5pBbcR9fZ4nHVcyQ+WEN0LgovxugN7X?=
 =?us-ascii?Q?WoWpFhA/lomeV5ZW/lgE+4w6vAyagFtGXEsT5f63JhbB9aZ9XfOsf8Fi+6eo?=
 =?us-ascii?Q?XtF/GWnJZA0v4IF633FCh6Nh7RMsgDitZaqerAtcAd2K4q1lf9XgHhs5K5iK?=
 =?us-ascii?Q?2IHHOsmrGgLxPQScuxKY4LsnKJ00dR+YyPVLqtkUZT2V5Y8C10kpXXxtu9uT?=
 =?us-ascii?Q?uJX4PxsrHqYkLALH2L7mOkMd05w13972EZqoPeYulKreB0Y7vUK8wSk6QO6t?=
 =?us-ascii?Q?kqpgqSnj8YvAuD7WO1BVgCAAlxlcdKqVKEC9PXZy844e4rUx90HUONdwPiWt?=
 =?us-ascii?Q?2BxyEe/qVwPHH2q1M6ObWoV9ea2vcpi/La0YArWs/7Q0rWN1m8cIlllTjflZ?=
 =?us-ascii?Q?2jVX0ipOQVaWrqaBZj7eGFZFOUfebHKJncWZMNSKjTuMpaeorIBYBePErJ3+?=
 =?us-ascii?Q?83KYV8PrEEfmVpJE1hkdo6Or0oX2FIf3RkpKZo+egSN1vEjwtTc6uYVM/e89?=
 =?us-ascii?Q?v7EaLqej5Iol8KQbd8FsaFQ+/UTkc7ch8vZ0qxsUVFqQvsyK/E4MIFzmEEki?=
 =?us-ascii?Q?yBxwBGiZzR7j8mslJdsLlo7vFpMG3SUhoSe3R9mLW9PmRJQL+cDX0ekhVL6f?=
 =?us-ascii?Q?QoZFagvOVvyGOQ8BJU0GIqu0ICN/FyEtBLz2BmQSsx24+/ScoI2/Qpyl8MI/?=
 =?us-ascii?Q?zCJrBcZs57wpUdV/jUCXaLj6+OPkJSibqKWJZqbf7iORml4lKVs5w6lvIgvj?=
 =?us-ascii?Q?dndFfzXCMIgio/7Y23ncXt9TzH6+erbUlo9PkzEmyBXOoMu/lgH4aA+iOOKA?=
 =?us-ascii?Q?QvWfF1cDXaNlfOtcbiH/Nn6jP1oBQtYtjyTNZGDU82vEdi5Ig42Z4B3mOGIW?=
 =?us-ascii?Q?s0uKY9wZGYUUTJVqHcQCEQ2Fo530wDiQsbuuGmGEu0es+UDwpHmQ5Fi7jitu?=
 =?us-ascii?Q?m555CrjU7Mx48SY/WCG0L050BytoLvfjBJVItmsuH+vDTYdDp307NoIhNgfQ?=
 =?us-ascii?Q?f1uMZeQ45VOU/6t73TT89fgxvpdolEJpdnUBdMt2rQIE+XXiw6quVym4R3jG?=
 =?us-ascii?Q?A/GaHyhmfMvcdc2h1O+derRSmdR+6il7+ZdPXAOPVoz+N8qgCQVZwbmZk2pj?=
 =?us-ascii?Q?NK7JBeRHf1IOgYW4nG8nVMDgQdERhTZ9AHkuzpc1/8dqiMiByhqFWcx+SYap?=
 =?us-ascii?Q?L5p2dKSpwVH45iYYfp+HqX1W7QTDAVjZTx3U7HmQZI+oxmwuQ/v4HA0rZ5ui?=
 =?us-ascii?Q?FijGYgtVfUp7dwTZWLRvIEy0mzSXN5jpGrwsnshQFTOX46IzkPBNinNzMtSD?=
 =?us-ascii?Q?Yuy111Tdmhhh8REllrhlAtJd8XkY0TxvBPWdrXyPiFbrPjFKJlAdPheNlmJ+?=
 =?us-ascii?Q?tJLrQjbiZmtZsszeoUFEVPPa2ot9qcAe1FKxtsm088LIDnKNMGoIg3KawixB?=
 =?us-ascii?Q?y7ZhaJtG/zWcIW2v8IbmMd6gOpydyn2Dlcti6e6x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648059d5-22d9-4bc0-ccf4-08db9432f0f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:04:31.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41NqX4VDXyYTVAAsQ8PYki18+gBHI232h2SU7ma6sZfzc5gywfJz22M/d2Bxfxx4DVuAJiFm1HYQaswc76RL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a API for dwc suspend/resume.
In layerscape platform call this api.

Change log
 - Change from v7 to v8
   Add new patch to add common PCIE_PME_TO_L2_TIMEOUT_US define.
   timeout value using PCIE_PME_TO_L2_TIMEOUT_US.

 - Chnage from v6 to v7
   Remove local varible struct dw_pcie *pci = pcie->pci
   Change according to Manivannan's feedback
     remove unused lut_off and lut_base
     fixed  100 to 1000(for 1ms)
     using dev_err for timeout
     refine commit message
     fix sleep value 100 (should be 1000 for 1ms).
     use dev_err when timeout

 - Change from v5 to v6
   change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG
   refine commit message
   change according to Manivannan's comments.
     remove reduncate step dw_pcie_set_dstate()
     return 0 when .pme_turn_off is zero
     call host_deinit() in suspend
     check .host_deinit and .host_init point before call.

 - Change from v4 to v5
   Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

 - Change from v3 to v4
   change according to Manivannan's comments.

 - change at v2 to v3
   Basic rewrite whole patch according rob herry suggestion.
   put common function into dwc, so more soc can share the same logic.

Frank Li (2):
  PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
  PCI: dwc: Implement general suspend/resume functionality for L2/L3
    transitions

Hou Zhiqiang (1):
  PCI: layerscape: Add power management support for ls1028a

 drivers/pci/controller/dwc/pci-layerscape.c   | 129 ++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  75 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
 drivers/pci/pci.h                             |   6 +
 4 files changed, 229 insertions(+), 9 deletions(-)

-- 
2.34.1

