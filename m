Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B0783075
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHUSxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHUSxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:53:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03EA6972F;
        Mon, 21 Aug 2023 11:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkAyrWjLbjvC+EOpxCzhLAyGhoUybmCVfxHvP7D5sFzCb6DJEdsflPo1dm3pMmuTqPdx9gN7erOuX9IgTtAE5hZr0D4LnrAp7b6wqLqpX0V7nT5gr4+Q6V0SAsEZzIv5kmKf2YDmatddjG1OcbmuyHoxu8a947WX4NLfuR5LnjIMDgPyHX6xX3CRfVprbdYvaYz1DQrNNQBVQDio/1Klv0L7yqTiOgWpfZodP3qA7x2ckk1slbUV2C6/E4ByM2Q/YA5uyGHKfgdgR4OYVPDY9QDqYmfJp68T+Jhs2YUCGRoXdmYELBb9WhMglNVB9Fi9OMcl1+YUpk3/c2yr8FgbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TNgc5ao9HIIj+lcJX6KzGjS/yWAIN/MaPR23drMKgQ=;
 b=apQwoZrsiQwrtUAMskTYN31xjjL1mGqFe3TURXQpX24k7IDxM58hKDfZjboZbhQowrTrI6WChDGSQMUDP1VckJoFa0xtQoQdvpf0pw3zjxPy48t5T4rgVfugq669blg1sthkkrAm3bY5hfpm1oZezM961/qdGZsLPT7tD4xamZ1MGy5jKKZKeSgNdyX5jWadaxUEQjDPFnNSMuOS1Tqoi3rVvV9kdYBcE7Wg32OtPRnzX2wNhFi0qMRQdD3zZwwZjccFQH9fLvWbPpAoB6bRItp6urukZt5GexGR0xKMaC3Y03djU+4EznXDjXWca9+ZC/vvFcPlEuwDFHjZcgMdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TNgc5ao9HIIj+lcJX6KzGjS/yWAIN/MaPR23drMKgQ=;
 b=c0Eolldy2eeYFcIVwyu9l1cc9vkZEjAkhGgcnH6yBOvem+UGGlzdFMt9BOJREPIAUYIQQqhh14K72RbclahjNIyUNN4hN/S9R3m/VO6G3AbQe/Un6/h8JpLFtOx2BGWCw76K/raCsGAd/PnrsJAUAHW55Ksee6LSZZsCgM8zC+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 18:48:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:48:40 +0000
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
Subject: [PATCH v12 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Mon, 21 Aug 2023 14:48:13 -0400
Message-Id: <20230821184815.2167131-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821184815.2167131-1-Frank.Li@nxp.com>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7f1b63-a032-4261-9d23-08dba2773c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjuLi8NoeFIvxEHsNaXWrpuRqBF7s6/MNJgscPWc7o/+zPEr943kUoCT7YytEbMhKN2aKpOsHYiPy7vH7WUFrCFTzbuUIljh2vG1WreqOBuPt4DTxcfZ1ESNSqxc2+8D6rcCO5xVKf6Az+pQVejZr3kfKrevB8zbYMHi9CT7lvF5crAG/NDeeZlLCKqFyQM2BpdocWTQpUPCo7DOgYjaWopO0m7AUi132Ae72CGUPel5nrKSHt+0cp6u/5Bl7iDDJOHsjtrY228GEivBU5hW+13TflSixGIvg9ldCLOEK4ldRgaRkE33wweuuPbvRoBLg96Zkm5Vn+B5/roE8SpYV9vrlq7AruA6fkdpAfV4n5wJtO0jMgs3rbbCHlssxpv4NpLgYJe9fl529QzfI8YM+L6I+fHOg1wMA71TBguY9/KBcwvq59+iHferF05W4K/PpG8nXmBr+0Hda+elrl5b0zmx7im7bz/auoheNS3aNUwK/9z8FjjtpuM3kILfw0RIY+e0gEcNw8gmjElmlHEmV0NL0Uo8PA42Tw08ocHUC7ebfSxEtIPlAz/I+mm1PSBjhPIkXjldpFUu+5c3FROjiqRZfAmFco3XFeeTs0jGZkL5RujOxrAcbiS5xRW4w6xH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66946007)(66556008)(37006003)(66476007)(34206002)(316002)(41300700001)(38100700002)(38350700002)(6486002)(26005)(6666004)(6512007)(52116002)(1076003)(8676002)(2906002)(5660300002)(7416002)(6506007)(4744005)(4326008)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+5IkvLxi3o87fU1o6TCdNGe7+RHNya6n3+4FJib2PGizJ+atbYVprSnwXBt?=
 =?us-ascii?Q?IWKPeIsck3ehNy66CI3MkzK9I/TZsmn7KrLfuTDpIIYBEMKDLkZu3oXUiamo?=
 =?us-ascii?Q?YM0bMerefoikwnapJlm/Ul+uTxqbs13Il/NJF4W1RKxgfyfDpHrVELBnRIf0?=
 =?us-ascii?Q?pgZv988EPqNWMNRL2aNJAag58LgmXFO6czLOu5VoGJymZTX6ML5A/KyjzUsD?=
 =?us-ascii?Q?7TtXgBXSWI1jTV9eLUxYbtV9cKdSb+WRgksb0kOX8BYm40XJs2ZmIHg+1hdi?=
 =?us-ascii?Q?GGzsdDrpCGESjrVgZNRD10Fec9XAwR/pLtVLeSqPzB9QdS5rNSLGW9iuMDjl?=
 =?us-ascii?Q?qQdtsaUgVIC1vKEGVago8+Fww0wbRnFObapumejQ30BgGMi/9KdXTFbNjvM3?=
 =?us-ascii?Q?C3uaopG31Mr13IN5rqGSzP6f0ax7IbV7Ryfe8tLR7pqZtnTCy7E3itA6N8BZ?=
 =?us-ascii?Q?S8YOGsfD110YXdV4r2ZeCrLPVzUUsHQpCsy2GBZKBnmH4QnSKD5tE1yQM+22?=
 =?us-ascii?Q?0FOwxZ/hpf+qnaP8qB4LsHf8JQrXkzRF+avWmcfcqPKU611BDNYQUmw42LOz?=
 =?us-ascii?Q?YjmuvEaaeLCdoPrscGvjiU1j/5czzl21fsbPmasOExcd0HCptyOsYU30HQn0?=
 =?us-ascii?Q?SqKuUleVscwt34byiPGWzt/NxE4abQV40dJ/5U1onfsm1jm9KOkVYphRndt/?=
 =?us-ascii?Q?j2eG7tExFZC/xQI32QwmG21xjgbSXC+t55HKZKWUZswXp32ruCkI+6CTrffx?=
 =?us-ascii?Q?kdBXEj7iXBLQFgl8YqA4uCd07Oik44sQ5gBkWRxgxAzbHUwONf8Dll1gwUSP?=
 =?us-ascii?Q?1sKpQUcHNt4XDk/kqHF3W4HIUyVupaaX1UtdVAPzIjSfUWR1xX2ySLVJ84ym?=
 =?us-ascii?Q?5WAa4G8G8guwg/5XWO265tlwWrGnDeQYUSGOShCW2/MbHnLY87Opu4a5A/CZ?=
 =?us-ascii?Q?HImlbZE1IZpVPEve+E23+KSoDs3kWJBHqSk3trwXs1vWeN+J0Uc092ST4dBo?=
 =?us-ascii?Q?YaeI/2Atfw+CF/lgyKqjRdyXlIrFtrS/Hg2Ld0xBjuHHyaIiDQgvIcAw8Iq3?=
 =?us-ascii?Q?ZRaDSXBgge98GaqVIuCIlTXknDrSVdLTI6tGgNKTsLELOPQYqk+lPv1aXbGd?=
 =?us-ascii?Q?8L+gbmEdklfsjOUR/QfPIgtKj5KEg24RsGhKYHKdg61WePZpMomqf2+mT22N?=
 =?us-ascii?Q?slQU22N8aWHMKdQqhXDKhGiorvIcEBLe5MAM6wLzhrh4P2O3abc1Esqnm9Yi?=
 =?us-ascii?Q?2c2a+JdElS7wvR5mgK+2IwvYOP3qIpOlqISlXLMSMzC1u8Ltl/dT2RbZRl6D?=
 =?us-ascii?Q?buTg7YZyvBRWzqTmTIfM8N9ZZ3410VYEMFeGRi0qacm0CzUsXxr/M1tj1BmF?=
 =?us-ascii?Q?SY2P8s+S9nHAm2k9HmYL1MsxES3W+wWszcaba1r727Ee4eed/zh/1fUzwk+H?=
 =?us-ascii?Q?zgyQul8Wnatdx/ux42JCNyrNCObhRYsozTIimGJfu5T1VUX3HOL+5+WYlFd1?=
 =?us-ascii?Q?7bkg0fb4dP2HfAuxgBzl+55wM+Or4cSSrdhWHIqYIcM2UngVHoEFHp2rSZOW?=
 =?us-ascii?Q?ovCcdQYIZm+Sicydc648bk0kB25j8Wm36/WSi4vO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7f1b63-a032-4261-9d23-08dba2773c6a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:48:40.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBHBw9kfx5FkX9mBj6/ix+BsiAcDoOs5K6YDQ8gfzLkTmhrjDZw/quKVoxZjXNKkE4DBh+wxExA/W8lFtZU4Wg==
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

Introduce the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
L2 ready timeout in the PCI subsystem.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..da8156663c82 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,12 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/*
+ * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
+ * Recommends 1ms to 10ms timeout to check L2 ready.
+ */
+#define PCIE_PME_TO_L2_TIMEOUT_US	10000
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1

