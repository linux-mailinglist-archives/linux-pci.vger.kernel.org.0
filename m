Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450A3772773
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjHGOS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjHGOS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 10:18:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EA10D4;
        Mon,  7 Aug 2023 07:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE2hqW3vewWKyX7Nr6JsCjufzSN6MH++qjrztwyJTmUjygEOtPT5P5WUcL9kEfq5z/kBHpuMq94oY0FtQi2e5J/cPJ4O4yNBu6QitCSJ1f9ra+Zo2xYkBjEPL9mk6DnVpXEZMX65qFMQUTvelQCxajK5w0RB1RfFdUqfNYQe+L3QGA2eF7lLdtb0kj56uxWf1r4Mx3t71W+dYqwrQHTzudfReAdrH6Kx7fRE0Zj2ao8wcmhs5eVNEGxsI3IDjZSK+AL776I6jrYOpo2hJ4mu40mKvZu4FWC1pHoiIzbSL7CiKGHrShpDmpUX+l7pNDPAaNm5SvCY974ir46ZeVQ7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x909Zqj0hdrgfJH0h6fYkvizC0YoU2vAXBTQu1yL+3k=;
 b=V5lzQ7dxgH7WthtANEr8xVTdhjABlddllpazJIJmOJbzMnspS4l8j17STUc+dEFk1jizBcgoWYJ+9PB+w5Zz7q7px9Dik4zQ4VETGFbDkVZRpjRJ/X4qLWedCs43I6GZjeojLqb7YCX9TUQHX17O0Rm1I1x/9u7Ylv9ePGZvK+5sZoMWH2T3WcMK0hIZnj47jKSBwE0lVxq/27vV/S7SSDlOXwJ3tfwhpXu8jsV6fKgKKa1qd9yuaER1vE6HfGHBTYpc8JQieV5daFWQF9m7elAF775SLrfO/3YIDgn0nYQ4ug5y3xvvqnucVgIGRPGGIX3RDxp2D8k7no5sY9zYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x909Zqj0hdrgfJH0h6fYkvizC0YoU2vAXBTQu1yL+3k=;
 b=QF4qGJY7HvFITlIWdV5PephL49WpTUeRy1YLa9jkWRzo2LgKMFv9K4BbDPudFN5VgH3m0dOU5zTWeyVTvLB3/F7P5KNBf07Np5mE1kY9IYyci3QB05CEUKdgYo4M6VjCJfxsP5wZ3ertrX4eAKVTCkqclOutXUv1BptgQyPy1EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 14:18:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:18:54 +0000
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
Subject: [PATCH v9 0/3] dwc general suspend/resume functionality
Date:   Mon,  7 Aug 2023 10:18:30 -0400
Message-Id: <20230807141833.564479-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 584e1f72-3c76-4d23-cc3d-08db97513b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndSZ8GVTRnSy/eu8kY0cbwy4q1/+C+WitVEFBv/MgMXgbpOTXNCWuPZ4H3wrudGMHQyUrRqUzmScVwKSGQDVIgcQJqTlZe26UgLys6lDDe/St05rh+/liycF13zg1/+SzpA9oyx+nM0OZ19zXObOo/5aeWoDazfW8poCnuMHcRAIe7QRCkQbPDFFo3gOt5qCLr+bAzturpBYpW+qdiClajsJzkhdeXBpdRjDKAv7fFS9UXEZUvxuOQxsYnTRsrrT8ihW2idVWhlweEGPEEb91Aou4ZY0MebP6DN4VXDx/Pe7a6qdK43Veh5sAUOcxUApZ9Vlx7SgHT48bBmGZFKZPd2sFev2wZ80LfcL25x+o49SUk1X0wirFBADDGs7Mj2Dgw3HD5x+BmF/tVWxSd4JxANzvAPbV+p0r0fmbOLA704QlO2zQjkFBIx7msU5eQ+lBnTHnWOkpEwEBly3tfcPyXASCCy5rdC8iDvPS5UJFUq1qEe1gfIA9YqF9Xh4w8lPr5i9uVHcro/zORiNjKxDq/rAqVrMad4eIp+HNdV0dDqG+rkg2oQPln5PIwviWlOnrj9/55ZkpYO02Hm+M+o1XVaHnWBumyUi0nkJ5oIZvPJ8ahyl0RiKtAJjGScgcX2x0qzdNfbafjqJGk61Sb0leg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(966005)(6512007)(26005)(6506007)(1076003)(36756003)(38350700002)(38100700002)(5660300002)(7416002)(86362001)(15650500001)(4326008)(2906002)(6916009)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(8936002)(6666004)(52116002)(478600001)(2616005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50bcXrL71JUXSuG1MqJcgGOMLT8MKsDIsOn6ktz415mSVIcvun1pO5uPua4F?=
 =?us-ascii?Q?exspB6Yk2Y+NlNcwEpSC1uYdhhtnJQRSXdk2FhTXXjq7s8lhhlTjriTeggt5?=
 =?us-ascii?Q?13gwmUFPjQwpDmPmm2Hsw7jVfcyR6NxURTBDgH8gWoRE0FYfTnsGWBx78O8x?=
 =?us-ascii?Q?Y8LG9QrnerqchR3S5PKzz+J+0c2X2W050nnUzynuUrWTBP3ZZMjJuGaDlUao?=
 =?us-ascii?Q?CM5EUmMDC7GsS8+jF0sydaCvK68mLGEcIcrjbOn9as3n7bGIy73Lso5jM4Tq?=
 =?us-ascii?Q?UqhL6dLjpnWv231HPYKO8BPl2A1/3iUL/SPv4IWdmNIaT6B48VL5r0s2x1JF?=
 =?us-ascii?Q?ulU1vrPAfzED0mvyMGKODQdn3pFx4Rc2NVPT1swyGWTkfP6/2N0MvlgK2VHS?=
 =?us-ascii?Q?Mqv/lTz71hV/PcjXX2HFFmkiE8/l7yCC3VCoEfIoE67rg6BoyHNAukwpaxgV?=
 =?us-ascii?Q?3sd6BxJhO3DEVlNRZ+r7iGfYGAkeDaWhgRB2ykRball2Hp2o8XXbj/3HhzAW?=
 =?us-ascii?Q?Wi8nVkDcf0UfNPcubOrT4qUyupd4SdBTinyrFcOclioSv/diMqy99+D1RCtZ?=
 =?us-ascii?Q?/csCNgSO5XHNclQG7qAg2r2uUVBANthY8483wMUyeTtzfOB0m0ZeuoqJDIsQ?=
 =?us-ascii?Q?f3JXjVyCX1wo0r6kffuF1ev8WL8GxBC9AKfkltuFKGyh5/8d/2P0YwPDys06?=
 =?us-ascii?Q?+g3h2XfbMoJlhg2vd5Rwe+1ig3lsdzcuA2scs1xzHOzZJVg/zTaoa8XiX1H/?=
 =?us-ascii?Q?VYiRMGf8A71kOneReedFoYsR+9WcRWhITLvI274CshIvtfO165xpqWbgUAfX?=
 =?us-ascii?Q?ziyitMRPW+iOYz3iT1mFWqcYhKHD3eOwv7FnmWHAxFdSzxroWdIU0J4BsJN6?=
 =?us-ascii?Q?Zo/H2uqoIbmnQ5eTAFSaoG9kdHCLyThmjuyYYJQnOkiYZVYmGcrXjBoRUzw7?=
 =?us-ascii?Q?g1Xc5OTc7oyYJSApM2d+4JlOG7V5B4Q9pY6KlRtO1jBLms5VWtAzwj+d1M/j?=
 =?us-ascii?Q?knpLWctAgt+xUIH4anRr8i8Pf5pRoXO4iGhjZo04iH6QcdKtZcwpC8pDCxNv?=
 =?us-ascii?Q?2gWcBoO9UlF/BWEHwb3FAWCvy4oxiHOBikABPYR+xbBAvMVSoLmwkdhaBn/a?=
 =?us-ascii?Q?UxDUIdFpD1sm8OuDpvyiXFMCtdS034suQPx60I8bWimGej+cf4i+kyW9gWf8?=
 =?us-ascii?Q?xAM0TjoAX646Fig17a86S4ziBjaX8A02LBm3s/LYPch2GFL8E7gPazfClEv3?=
 =?us-ascii?Q?Yjn8WlE9MGKUfcPP1CHlRNNEsZxeysnBXS3b1b3Er2/HuZMHGQDaSOHdPkA3?=
 =?us-ascii?Q?30gz4nPMbweJnLqaIePgk63pX+Qoyi9mBoosP81HILu5XAK1hPXPRgjxARBQ?=
 =?us-ascii?Q?UgVNxC8KlzRrsrREkMj8T6/O42PEEoZnS5Z4ruHYYn9mEoUG0ZTesOxHKeep?=
 =?us-ascii?Q?cSGv5HTsJF7AtbYutkn4JyFr7XOIXSXR7z75xj4/0YMrTzKU2qHawGavKhhl?=
 =?us-ascii?Q?yXkN+/9GA9BLrQGmjYIyZZlYiVLSEO46JS2e+J/ZZMLKeJ3UH9DZil5DXxuC?=
 =?us-ascii?Q?gzyL0gHTVr04hIbRDtw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e1f72-3c76-4d23-cc3d-08db97513b01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:18:54.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkNf+e9csmi2+EJbgTumWkOQ3mO40WJfsDphNCsutfTvdlqotKx3mjmlco3vaJbOJbFno/KpcL/Z15O53QOnGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798
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

 drivers/pci/controller/dwc/pci-layerscape.c   | 130 ++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  76 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
 drivers/pci/pci.h                             |   6 +
 4 files changed, 231 insertions(+), 9 deletions(-)

-- 
2.34.1

