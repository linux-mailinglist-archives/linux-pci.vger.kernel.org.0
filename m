Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9D783073
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHUSxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHUSxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:53:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC63868027;
        Mon, 21 Aug 2023 11:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SifuZjHwZ7ki67P41QaROjn5PEd3ThrCoRYqN3nrw5DodaTyUTJtLVqp3VDd7V4W8CptQ/O9PtTpTTLgVt44ow9knjIDTbrCTjbZ5zpjM/eS/40znIv0trcWi3bqf18jKWJaWGbj6styIZW9F3UIsXejGf7bLX0DYSKUctWZ6NAQZS7ptsiu+VkLhJRT6dW4Uu/KZqiQDZfGS20wSQ9XEastwGq/0eLiENLE5/RVdemqS4T6MPBTtrFathQaj9fmi3aAMqaeV9ITxLusDeV5wxU6IzQN9cWvjAZWb+249yyCE0UhPtu0lEmm33M9wz4EwUgPogXbhBDy6mtc2k6U7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGEKzhiA/QQN9AZru6gDuLoSlKBKRKGDk6pVEYYmdTk=;
 b=TgSl1Eko5fTb0PK4VIchM7BWZXi/R1cLVfF41pdilzW/CkA6QDl162m0aj6G1T5nVvHdsnXtZdesGjoo+DISp/2dSzJYofeyx9/pGh1x+Nbh3TcmttXPietzMQn50bMDeTGoPIC8ODLkyuYzpxMDb/HFd5eiV4OXPlxlIAsEW6346TAdiqp07tg5Glvg6RHtybrMBtZaskMEVq4E4Z4B0WaOdPjmnBLKRBMfho06iIfkt1O7KnpuvFKwhplZjr23BhQas3WY9LCuz6LWIkHGtV+E5HL4qpq6su7Gv+qXk0zDlhiwVyQUFbYwJ35RocGDO6kDHprkyYCCvvDWGE76Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGEKzhiA/QQN9AZru6gDuLoSlKBKRKGDk6pVEYYmdTk=;
 b=ff3Y10FAyNSNQQtuBneuJb0hefz5iabEcDMLUwOhwuVYJgIEsPU1ma7LQlIyLMpxhFZjv+miOL0qO8bOnGOq6DiZES5imDbANUbJLIkkIQqwBZJmPG5372Go2nNzsaYEoV4+ixUYRYw3lPrD/R6+zBVRoqZzVNNhCRaoCk872UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 18:48:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:48:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v12 0/3] dwc general suspend/resume functionality
Date:   Mon, 21 Aug 2023 14:48:12 -0400
Message-Id: <20230821184815.2167131-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 10067f46-54a2-4a30-6e65-08dba2773942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pNgUMDDwYSw6N/YRqTB3UL/MZei+LwnhEf/XFTdA5K7qKdtqoIvWwJnIo1HojDUstP4a2Jcqut7yjEuG2feuChsCQkoVmxgzLp9AeQjteRoSyD45cLvopetpCxWJTZIctnu7RAdQ9WAPrT8nHWXxOk4HuJPSrRuiF4qM8JO6zVYiSaYRuFXq98QVYEuf5FwANMEcJIpw33vh+D8aQ+6GGzN5MC7TtwABw+i5lyGwUYZd1CWeprMpOqNm/BNnN/aBlEkrxMHmtKdD848Gm/s8VgyKsqBxsjg36bOgcWkn1lyxQAL1E42HQwP/1tjYRYKcnOUVeufkhoTGBLnkPYATzr65Ue0di//d9E+Lm+Tf2F5Ugi8a8AQbmTu2y7wm7z9wDP3gcha3ChHnGeXfKnVYyTzz7Bj9wkWBSHh2F7Sg23Y1/VIXKgP7lNBbdrcdTaTQk9osRdHu6cMkQ/7bmdVXKc8IlBZ1bp4P8mj2p6IE5mkL1CteAxtUtKIaPhpnGKDjuNZh/El787wHt7eVHt+SM6VW88IxTOHnAOcW1Opqjg+MY8I9p5DHD1SG5g2SRZUYCjrBnD+rF1k5isXkXQxsqNJmjqXTqbPoo+8PzPESik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66946007)(66556008)(37006003)(66476007)(34206002)(316002)(966005)(41300700001)(38100700002)(38350700002)(6486002)(26005)(15650500001)(6666004)(6512007)(52116002)(1076003)(8676002)(2906002)(5660300002)(7416002)(6506007)(4326008)(2616005)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4nyGz4nyutVZEJX8SHc75ZEr7eXZfgNan/C4Y6aiAZ9Qn0oHccwv4IUnacx4?=
 =?us-ascii?Q?3V/VTBP1r3NCGJBbtbHBfXQpLxPotn7guK0VZ7gN0n7Z7hjbaSyKAuS0iIUv?=
 =?us-ascii?Q?bJA5c0Rvlj6EqY6zqk2R65fFlqAht5IHu9MpIq9y2PnjXgyNIyxe3cywQvxE?=
 =?us-ascii?Q?s+cCtwBtQkekW8JxJhs6LHwfCaX/Oif98GFmOIkUbeqYf47oAoFoLoToCTAX?=
 =?us-ascii?Q?pLVUiq/HS7jDcRNF3xhN1A8G0lAy3CUL0/vP6JNO2g/TFQ6LVzvGCQgc5+Qk?=
 =?us-ascii?Q?7wKEMDNDdlSApvtLlWwVBsHB4Xt7a8ZIpjfuVt1tv9z61OavzBfZtoVgCSWE?=
 =?us-ascii?Q?bU2cIXUXwNyxNZjCIIlkZQZmB8ksPB1AcX50kZxBmSGFH5aTBKOAi+b3J3EZ?=
 =?us-ascii?Q?UukQh2lVVKdLQpfGCBm50mSd2XZnNRCmvm82zc8Vb+9LYY+Ic8DpvqD+6fm9?=
 =?us-ascii?Q?EXhnTqM4FblHLLt6tNXxcVP2cJEuk8Rpp66qAke+U5RwrcFkmJp15uBJXue8?=
 =?us-ascii?Q?xmx6lXldLy7WTYrJHSCNUqp6BJr8E9DC3HVPwavJ0JribDPQhZs7PaNYQCru?=
 =?us-ascii?Q?VfWlCptXpySqP+O/hFtHqkRcmIIyEHbzoQ14Eb78v+bAziJGLIEfXROOY5VB?=
 =?us-ascii?Q?7GFy6JOWghMGV1li+goNE6+5iPB2tEy7/gOuqvyk0JcOPtqAkn52xRqk7hYj?=
 =?us-ascii?Q?DFVA1KplahjxWdsotMfUkmy4R6qEIIrmfo9gucHLnVUXQXqHsvGMZs2FFNoI?=
 =?us-ascii?Q?F713prGTha9jbN3HDJFOw0xfXvmOlcrcC3IWa2OXNx4OH+JqgtVLdRf2T5uD?=
 =?us-ascii?Q?JqJFe20lxHfeKRklsS3bBwgT2Z0sG+4WVekTg4HKXY99zp9WgVAzSzpgIFf9?=
 =?us-ascii?Q?Qbxi6al6IFBHA/fCtoRf2Nwyem27gisUT6crw5jJdnN4qWTvivvHBL/GVhOF?=
 =?us-ascii?Q?c3MUTfOOry7Pv+CFRNqX75p/zwixJrAqeSCy6+rdDO/h/j8hBYWApf2er5f6?=
 =?us-ascii?Q?5dqAVwxkEcnDMQOQ9vFwywbRdKDHnS9PqqXmD6rEx1cL+p1Mp3aNEpAshaX3?=
 =?us-ascii?Q?9mVOpc7J994nuDY4ZXuOvmPy3jU2CvHIVADcagD+wQamMKad8DrrYzH0rLLq?=
 =?us-ascii?Q?jG3td4pXSX8vj7MpKIz9JCuVlU8A2VPnIeCR8aEGAORn2NUA/ZKyNDEZ/9og?=
 =?us-ascii?Q?bXsZlAAnE1LvaHnqlH6fYFDXxK5MxldqvbmAYDWklm0g+hzlNusDO05Pk3rl?=
 =?us-ascii?Q?LhbOilgs/UfrwENI/hINhs7ougixLJjguNYBeE6LEq6n4aB6qOftRdwR9Kih?=
 =?us-ascii?Q?MYm8AbeRUSmXgEpbDqlu1VglMgksgV56Pw2+AkekX7mxelyKhuGNK2sAVv1c?=
 =?us-ascii?Q?aUrtCfyNLw0ySzXECXddHKOoe+QCJquEylXBEu0/UxCVKG3FoIWuIqMZ5aJR?=
 =?us-ascii?Q?UvJm/XX3p39/HnmxV3gO8EvYJKXK8nxIOLIXSmQIsMnvUGumR1J81Qjb8Kjr?=
 =?us-ascii?Q?5Ha4IfbJ835dgzBS0jYAicNiwso6M+0a0fr9OSYeiSbYaUR2P+JnslUAxZQV?=
 =?us-ascii?Q?MWfkQLrWE8JFaxH3blI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10067f46-54a2-4a30-6e65-08dba2773942
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:48:35.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY7UT3DbhxvE0ZfpzYGi/xKbep567lWmR33yxM7NPdUXGTb5Sn4SlegsIJddB1xAGCErjFlC3Gbksq/WAd/AYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change log
 - Change from v11 to v12
   Move exit_l2() to layerscape platform

 - Change from v10 to v11
   Fixed two missed dev_err message change base on Mani's feedback

 - Change from v9 to v10
   min change according to Mani's feedback
   Add Mani's ACK tag

 - Change from v8 to v9
   Reported-by: kernel test robot <lkp@intel.com>
   Closes: https://lore.kernel.org/oe-kbuild-all/202308042251.yGAFqeDw-lkp@intel.com/

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

 drivers/pci/controller/dwc/pci-layerscape.c   | 135 ++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  71 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
 drivers/pci/pci.h                             |   6 +
 4 files changed, 231 insertions(+), 9 deletions(-)

-- 
2.34.1

