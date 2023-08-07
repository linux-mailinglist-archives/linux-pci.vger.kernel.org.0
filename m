Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE9772B81
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHGQxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjHGQxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 12:53:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C9A6;
        Mon,  7 Aug 2023 09:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmLcwE/l8JgNTDb6drDZuWhNkVM8B77LfOZKkDIXVxJqAk3k5Up4rxcWiZl56ssNOhR8j4pRbMHzUVrw102zs1tpZ0LXTS3NmBOBck284ZEMViWvzUiZG2Q+Kdzi/LMCGUZosoPW2V5tQ7JgF/D8Ruj4mUyxqhg9rGVCqshjPkUScOBHAaasRayYcktkGHAIDs4ZLRdJiHmTCxNxcANGRpRW9FJQfY/MZ9HsDaTBQUg0UQovK/0AgY0c5ITaztDbqTjPVA722NG6x6i2sCM3BJKAbv4xGXiwI3fR0+aQjK71VrbxH+mXuDdLYn7SiPNflDIMs1xa/aN7Pzkc7edJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x909Zqj0hdrgfJH0h6fYkvizC0YoU2vAXBTQu1yL+3k=;
 b=dhtyFXz0Le90ii5ABPAqoW9WjlgSMb16NjuaAnuLEcC1TRXNMzzQcJofpdRAgkN4VCfhkBbuZQEYrY+H0a6WHmaNS5WCmVx1sTc1Llig/rfUSuxSCMTbK0HGb/I/UsqLOOshOBa3v1/ckBtL+hyDaEqnKI4lh/KohblcZryHn0LLlasYYNlIhoh96JUSgFDO5uw75dZqfs3ovcmijSycYFCFwaZ8fAZQj2qyK20C7OODeVCOz1lfkQuwiseTi8Y1wP/8eHi73K59FS6VJ0V99auOEoY4JVLq5zJeYwQQ+yFPb8bGagpFrhQKBT3qaKi0L1s1yL5LoNnXvv6wHqcnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x909Zqj0hdrgfJH0h6fYkvizC0YoU2vAXBTQu1yL+3k=;
 b=TkQ+lUtXMb3hwek6WAulVwEzWdpSQyZVAmPwp2GF0yDbtLAmXL6bFpZoMjIrxkcOJJmzf1TwIRkB6OjLPEsZFRvmIvwMCIT8B1EH+At9y8vNkGN2bVPMDCpsfVFdVvsmQwS0W627pYYlMoKtArMHAy9/kz0QO/PFi+KOlnp5A8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:53:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:53:00 +0000
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
Subject: [PATCH v10 resend 0/3] dwc general suspend/resume functionality
Date:   Mon,  7 Aug 2023 12:52:35 -0400
Message-Id: <20230807165238.569297-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a202f5-0204-4d24-2bfb-08db9766c207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBrj6wGfBEyOBSDBXMdc/3MIyRcOkVd4FoBVXwjmI30wTDQe0r0rdAXn1UOYx5YmdYRznR9m49pjpYHItKuI6dxWRq2TkFo9pP8fERQA0R31RxOsX3uriEqmKJg/I9UMWgkmzsdI4iw5IIyTBdEy7zNz43NngH+JUzMzH+hlcEG2tO//C6wyo9fISqX5mkQ28L88P0Yn2ZCI+L6KbuHAFocDhvgaYqBsTvvLDuw6ojzpgtY971SSk4mdFeKcre5Op2p6xOLea/gHWNDYyu9iyP3UFMyTbV24fByfucWq2bp4ZLmvmQ74wlMjkaPa99+8QcznuxM6eZtRkd8QinGNW4/WOl4J7KUzuxxFMM+Y+Y96cDLp3IIBKP1s5kssch6YZHv+Eq/s6IIgqliyCTmWgLl1Ap/seWRTUhv7WdBb9nYn5qVXIXzPS1xir6YxVlEd+ozZB1AAziB6plXBUI0qoIzl+Wx15h1pro8lRKXOz6D/rjL4C6/ByZqNTh3SNGee2g9iqm3AuehlA24N5GcRkvdz4emRstntMAddWKNv/tl5sEMbzddgjzx2AptzNvzCWIJNkKTT6svM/WunuEFmV6MmatBIyyaYcE8aozRy8QfTun5kzjc+l91/JvNshXx0E2UhUtaBq7eupd5l1lo1PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(966005)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38350700002)(38100700002)(52116002)(6666004)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(15650500001)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbUnaQMr6yb784R0AUnOp1glNJ5E840X2omX9OzfBpDbj2H4Zflj8SeVDiMi?=
 =?us-ascii?Q?ZlD4LASGOQHcSEAlcK1/V0DLReFUZZ7LQKflPFapfZ8IWD/hcYi/Nx+HAtpb?=
 =?us-ascii?Q?h10QXhLYftnYRz4FgJkIZMbaD9BeDlrI3MJGTp+XTlY4coCoE332MR4L3lL8?=
 =?us-ascii?Q?vuj+XpHMo0nHXusDIYttsORusb0kon+b/cVbc17Ix17xsSpFhKsrGDkOUKOb?=
 =?us-ascii?Q?6lQK/fN0Z/5EszTdbTy/t9WYfrouMUZYT1if1JQVokxAyD/6xAd6okYYtkP5?=
 =?us-ascii?Q?iBK2j8YMafrZyuTjb0xOyDW87fOdPCLmvLRpUlrWmbeMWoe19F5do43AUiN0?=
 =?us-ascii?Q?xToweYvDDTX8oh93OoqWXN2tFO6OSVV9/OEDJVRsR7TRfnxBD1J+tBC4Bw1M?=
 =?us-ascii?Q?/cC+ebwbRW3X8s2cCe1WV0LJExxFnBearT1D7PjAmktl7yMGSyPBtpbAeREP?=
 =?us-ascii?Q?i0h2bYi8ZjMmW4YY96DaqfVe0xxgOZD6ic0VV3Ge6jYjtrgNx44/ScpIf8Nt?=
 =?us-ascii?Q?+dQn9YQTnRuXeM1gPV+RfXotnsLz2Ml0c4Ebe1qaD/T4z+e8ywM4H/Dv4u/f?=
 =?us-ascii?Q?JHwfCf6VDgQlaWYs1YDZspiXK4oNhRIcd75chl5lUf6+y07F+YShiom1GxUr?=
 =?us-ascii?Q?1Ib4AYW1KB18h9/Z7k+d7VD1Z/rSd0psWwrAYZXy+hhRuT5nfK9OyLhrv39a?=
 =?us-ascii?Q?lZUZOabeGQe1RfUYkAuaWc0+kPkGh9XEpLgJoNC+JTkYOUpnS1GKCmNQyXTg?=
 =?us-ascii?Q?kfYo5f4UNR/OEkXPd4sERY9bJ2A8jfm00TM8tJNpG9aT4T4734DSbrIwJwk0?=
 =?us-ascii?Q?kbjSf+1KzjX+PpmIJ66wdifKAZO5lr6P3sTfYMgio/d4O7acMcLCTof6p0Yy?=
 =?us-ascii?Q?tzXtKzMdG7BNNmFRnwLKzTsJiD7n8UDaEq1efLMklCz72nMxwXDJ42IjkucO?=
 =?us-ascii?Q?5Fxour0Fil87gyeBgBiFNoWUHRin031g6L+zYfc1SAPBD3Qhn6AZb5YBfDnh?=
 =?us-ascii?Q?lRcgbBpaXvhhW8GXlljO//P5lKuFz+qJFxpsWC6731dsqk26THYEwobNqRjy?=
 =?us-ascii?Q?I8z44INM4gwvT3FltkUHJv1NTyHsztOp/s8N7rLcB8vxBJZ0HlLP37j0not3?=
 =?us-ascii?Q?lfyMJZBkr2NtN9iWwmGq9HkH6Nkf7DyevNvDuqnPP+jJ2rbmf0p9z2cP6i6q?=
 =?us-ascii?Q?HvMX+aJMimOAK7judg4N+Lq9IWkBnm6r42KdImDVVaPSeHbnWMQ9RvOZzjhR?=
 =?us-ascii?Q?bS2g/r5GyeM1Y/sMPGanuQEv9Y2AC7u+tHNTilwGSkWLHi8CF4v3qXxW3Thy?=
 =?us-ascii?Q?kkbiEmcACYLcMpVeOOdjYDBXfEI9zG4NYxa6w2ZPkA46pQylznkVdczWqBSQ?=
 =?us-ascii?Q?fVgC4yUC1sSP1Om2/SDfYTf8OvMVz1yaay85Jf361+ujFXrPKbCrd5c4/FKf?=
 =?us-ascii?Q?kh6YRaokDIcuJ/ehoYa/RQY/AB96uHhuv7GB8FiHkjVx2lCH8ghBQHPn/uvu?=
 =?us-ascii?Q?hlXk2c/z8zXHO8TeKxic0NoKIERPSaZz2Bl0gZeC367t3xKs7/0b6mN0r7aK?=
 =?us-ascii?Q?kL47dwQPExIJfS/hc2BmjdUVK5twLLL5VaOcWY7m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a202f5-0204-4d24-2bfb-08db9766c207
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:53:00.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3MXA80IYUKP1HJBPR3e9KEVCs0yCh91ckwQgepHjT73nLX/Unntyh/fmpVLv8wJOyy89lKcSHAXD0XDdpoJUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

