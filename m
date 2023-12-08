Return-Path: <linux-pci+bounces-653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CB809EFF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FACE1C2096B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09111C95;
	Fri,  8 Dec 2023 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RgV6bYs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB041738;
	Fri,  8 Dec 2023 01:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdmRu/7mabmiIEMW6azY+wwklmxWyh7wBeKuOtz7LudbBc7edp5yyQc/xmKESQtsnQkpm9oCd7zNSCOQiXEL9s3ZI35nKBRCbet/ZtgAnGdl2Lo0smmw3W14DfbamWurMkMj1RHpPKhb/VEgUEFGSKQj2XrbKV942IyQ0oeEMGza6iKXYSoS+BeCOOJXUvnlTK8cRqjmDvQoF9DOCQpk/zWbjfBY8ThmH8yUVDKhLGndhXJZa0YeKc6CNYjO5v2drj4UaJP4aBUHLr4uKnrCtjnJDlAll9Q+R8COnIsk23KhNnpWLOCFAt//+nmdT+8ZLFwlzZ2EeAIUBwgoukkW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoj/DQJlzz4H3ZDH9C6WEcRJ3ioQNU3k0jovdm9Zndg=;
 b=VEkEm9EJMFFIUW85wst84DYtcqf98JLDg7gfidF7I0IyJEYVhizITBh9Fp7dP2L+ROazQXlrqTRnLDEXIysH8cOTM1z6ZUvSOqzlPJbKjtJxzyfKB5XssK+8kSMtyaIcYPaqdSgLoRS6+gutzgnFxS12B30Gt09dLUIQo4nYm8VNDkQt/vvdQVbBZoZSEv3I4aNHwKFPV565rLs68tgkMQeCrPDvNz/LmIpvE0ulcBbTIeq4YlissJSaPpv/PH70wqBpsONQEdp6UxtlixC/qiqywhm1DLgDAUBQQLMxUZ3CSboHHFvQ7SP2YpD7L0AJ4WJIx5FId0GJf4jMghkPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoj/DQJlzz4H3ZDH9C6WEcRJ3ioQNU3k0jovdm9Zndg=;
 b=RgV6bYs9k1R2T3pip4WhcprdL1MjUA7NJ2981DcaoitrLNiVHLVJkN3tTPFan7IzwQB4k77wTMJi7IP2fTtp0QsEpDo1gamA2b7O5QV8hH9BL4M7iwq4IX/MWGIcik7cyaYvBA6DJ7P7LtmA5RL8qri3Gk/SW1QIn1Br7qMjUSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 09:14:37 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:14:37 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-imx@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: imx8mq-evk: add host-wake-gpio property for pci bus
Date: Fri,  8 Dec 2023 17:13:55 +0800
Message-Id: <20231208091355.1417292-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091355.1417292-1-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU2PR04MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 259bdac0-2dd2-4639-6363-08dbf7ce1a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oLZlsI3U/UkwCBbO05k6YXZfN+mbGgqPUJsXO6J1dxc5xz6C+ac66ejyLEf/yysREWatsOZ5MzHiCwdtxyMMoBSyg+VX2dzk0kfinRUfQLaAf1Y4LBcwldx671UA2Pd2j9u71iLKBFb6XgZfVektme7OXURyDKC2LygPWrriIZFN7/bQCjrUvo7Zj99a4cCAIJHkvn3ROLgfFnQPL8BcbKo8fK67VW0GkFhLSxi9cLyuxQR5ovJx7uG/nGTtDofE+gtETScq20nifCb0wOR3EVhujK3Av6Xr3tf0JsVMZDMdI4SG5VmRq7S59UldbWqZEqe3sv94uV32W9VxOkCXnllxqNFHhmgb1btZ4eWJKP8vRRzvcEKqr4mHphwxylnBnLqxWdlRbLTnmvidJ9uQCJ2rJMVnOxydP+ZQ3l48WBruoJoE5IzavdAiT4ExBHEx6GtTWmcGGdUsSNgREfGqNgbGsgYcoHkKKtzv4HOTACwzZROqiO5GzzJ9uaJmrM5l5m3QwPzqRT6LjdgI0aMo2vBUEqADVABH369A2Zf75F2CR4iq9zzDYlKktHW74BcM0E4zNHbx5rAOHWXPcv3frrsy7aeZdKeVfqyd0WWffQFfxVPF3bBJcSERz3gBVpdzqZ9UjD0gKtsot96OogxS5eSUnzBwibaV6gWu9wDfpaJzS+Tu60A/GYo6jqDD9kSk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38350700005)(921008)(41300700001)(36756003)(5660300002)(7416002)(44832011)(86362001)(2906002)(478600001)(6512007)(6506007)(52116002)(6486002)(6666004)(83380400001)(26005)(1076003)(38100700002)(2616005)(8936002)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lo5r38Q4GB/tBufYWwSagKfGLo0lvsi3FTkB2Xf2J/H7RygXLPsdJzWSbq6X?=
 =?us-ascii?Q?nyB2MbFd4wMWq5OgPBUqBvSID1A/dmr/qR6g+FK9FrSBXVQzSJoRGqZo1Vd+?=
 =?us-ascii?Q?cbKR4B7RCgK1Dso9G7TbCnqGEBGhGjR5goQgOHzHYrDXe2lnVX0OIaLd5aD2?=
 =?us-ascii?Q?sEOT+LM6twYf5dmbABNDpeLQTEwacxDxiyte6dQs9Tx79wyht4hLfjZmfVUx?=
 =?us-ascii?Q?r2dQX4jxUZ4Nxp+ipYu8pocEh3N+UwUBbPKaJ8OsDe/kLP6vY5SSiNfwesQc?=
 =?us-ascii?Q?9KH0u94R3v/RZCvUVEsuARZclfzCD11O7ZaUIOJfD+1dfzWLleQ2cZoRUK09?=
 =?us-ascii?Q?uGvDPjqHms022DWYXi/g2GWFGVeKHQMP+ie6uZE9oKAKJydmKcRbi6OISiU/?=
 =?us-ascii?Q?6HqVfyBpiQzivCX84bkLMf6O6qhJTu5fvc4rk3xHsRrRf02s2G6i3bLPgfcc?=
 =?us-ascii?Q?rZMRLWBePEJ4sBHoI2v0j+LEPwXM9Ry+Q2ov8oPzvy7viFQP3z75nVabTYol?=
 =?us-ascii?Q?fLT6/RuPsYcBbRWF/1E8Mum/rXgKXI1BboaE+bz1DUUD45YH30QwC8bzfj3Q?=
 =?us-ascii?Q?OVrhkRQwAe+GhLRl/dyoYDDtgV2XP8LfQEvmSXTXdGgYbqzfaTyhUY59wobC?=
 =?us-ascii?Q?lfW/Xb+rgtbMCiywyMz8UEKK6w5ntdx42ZBWvFjsyUj4pZpeq0wWYyNdKq0/?=
 =?us-ascii?Q?lnLvzLxc/a0Mzo5Z4wySMlnOQR9fuS69MTIjDm5PRXhlGTl7FbuKLzQBW81n?=
 =?us-ascii?Q?SKigchNVxxSw/Kq4uKqIXPr3lvhOV6p826TNodh4+BTByoQuiJNy1e3pvC05?=
 =?us-ascii?Q?oxo7+N9g9PLjdlOV/zzGa69Y32XKTmLcxxtEdU8f/po0zOTWTUnyXCtnxGQI?=
 =?us-ascii?Q?Ny+Z9pENRdBVHtD9OgRc6p6e23tjJJUYFyi7hQrTQtiRmGiy9Nj+0EaDMLBd?=
 =?us-ascii?Q?8FFqaC+jN5sXsN0W1ZxWmc1/Iv6eiecRQgDDghwLYMacDL5mKEZFtWqIKiZ7?=
 =?us-ascii?Q?O/YmujgBwDiH5Vnhx+0BQysz9SOwBTaCOQJBYEOudFdbNMmLPowNRqw4Ekq+?=
 =?us-ascii?Q?gTFeY0UGaO5Jh/oBMX9vIlBLEARcUsWYa1RvWEZ3FdYpCFGEb37+jStczvuM?=
 =?us-ascii?Q?ftlQVsBIhS6z6NnQevBPssNF8gbXC3sB35TKlo57/pKF5EpOipHZ8NkpluAp?=
 =?us-ascii?Q?OrmOsYeCk5B1JCwI+hv3p2WNmCTBqZUlXbq0d1j3xa50GaRWDSwHwm4IJxn0?=
 =?us-ascii?Q?FWpWzCsvJZj6T2nUMfp2qzSCKK5CnFcelrNB9C8jxGPqogV3kTX7M6mQnk0V?=
 =?us-ascii?Q?Y9x5JTRHJe4jB0mEi8AiKBzaJRaDptYsM4mo9XO6CTanwsmCQSTMoL/BLKTt?=
 =?us-ascii?Q?cxxqTExHcd0ZkiXfeMPAETH6x9bVlr0p3AgbenXvGZ8yHukhfsqT9tgdiQXF?=
 =?us-ascii?Q?/kmuyx7F9OIElrDfFiEV/WXTnSQQlsHUshObLQoP8apymUNIPm/vOaNZYOKL?=
 =?us-ascii?Q?L8FoWqzWSgOKgMPeDMLCzE0HsPALXf6CZBxT2GcCK1nd74ZmJ9oBxDBI8xQL?=
 =?us-ascii?Q?InHACze7w46nwruvTff/1GOt68QAWIhaOEbNnTcz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259bdac0-2dd2-4639-6363-08dbf7ce1a01
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:14:37.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWbh6GfYRWEKXTwP93hll5naPvtcBpUPZNxat7isx/AhWeOEYQ1uVOiUpNUflmwV7oWm1EiVKEenUTnD9G700w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

The host wake pin is a standard feature in the PCIe bus specification,
so we add this property under PCI dts node to enable the host wake
function.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 7507548cdb16..ac824046c594 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -367,6 +367,7 @@ &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	host-wake-gpio = <&gpio5 11 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
@@ -545,6 +546,7 @@ pinctrl_pcie1: pcie1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C4_SDA_PCIE2_CLKREQ_B		0x76
 			MX8MQ_IOMUXC_ECSPI2_MISO_GPIO5_IO12		0x16
+			MX8MQ_IOMUXC_ECSPI2_MOSI_GPIO5_IO11		0x41
 		>;
 	};
 
-- 
2.34.1


