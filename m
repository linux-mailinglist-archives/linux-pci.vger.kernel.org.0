Return-Path: <linux-pci+bounces-652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69278809EFD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C620281782
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C61173F;
	Fri,  8 Dec 2023 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcOaPlV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE921173A;
	Fri,  8 Dec 2023 01:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ94szi7hj2LaDxqFpWd+RVa94oHtmc+QMrPbnaUWXIgGC34uPBSnte0OcqiS3tonPWrG7R5a7GGB05W3GyKLleAy8g2XuFuCZqljXvXkEHPFZyJRGmFFgfANb3RC3JQadISAND0R01Oz3WT5Qa9zRGZbQQyKfiFgSYKZWfYhK7nirsOeMGbySu/iTIng4dGH+R3NCueTSKWO773SQAyzqU1CSRXOfs/JkQxomYCFAirXGOFdHE7nyMtuHhg5/GbZ0aw32ZahI+i2RlvhA+wM22OHNMTjwd9CjxH5q8oGCUrCdYKcnIMwcZ+PenCZokhR6QackRYlHyIprFiQ6SpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW2JngSnkWmVAa8OKBA3QVp+402BtxdHJks3BQW4uLE=;
 b=FMs4L2bhwVd3/bHJXsxVXLsWCorlLLkI2YfWHepSmhRN/VFP7oXgbFLxEPC6frGjY+xPDfXsikVu4lYEfg9VZ1gVWoSdYuy6jj6Ov7RwIIzj9yVykcgXC1DEwAFdGeqi0K8SZj2mODj9I7UGl68dvPEQgNsUe6E6yelsLKTwOLodgCCPzIPuGN8LTG2Nsi6ccYiufGcq4+D0FF6eyId4Ci0G6ogUWgaWNiETYsKf3MwQjpZd7hbQHhyxxh+8vdeTffUTSNXDOhoZcNxp/Dzqq4Up33N78Vis94lWixY/SLinNe3fWS/srcwtsm41M1vA0NkgQJz7hQ246JZURb6Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW2JngSnkWmVAa8OKBA3QVp+402BtxdHJks3BQW4uLE=;
 b=bcOaPlV7PZ+18y9QMgKvg97njxOHhcq7S8dFRLM9lAvQV4o+Ucdzz4eIKOejB0jzMT8bJhyBXmPfbscKpo0F5XEXX/NFYkquY+uRph+LI2VWJ29xyTkZGySCIlOn6Wn3C/QdLhvpn1ZruZQANHZyTYbEm+V4I/QsqZe3VW4/F9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 09:14:32 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:14:32 +0000
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
Subject: [PATCH 3/4] arm64: dts: imx8mp-evk: add host-wake-gpio property for pci bus
Date: Fri,  8 Dec 2023 17:13:54 +0800
Message-Id: <20231208091355.1417292-4-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f40eac79-2720-4fa6-377e-08dbf7ce168f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+Agk2tGoY43vbwl2M+a6dixEFEOd/fTY8OFiPKZ2PiR3HoTVhCVoKNDlH2vot8a/rL5tYrB2xIGzrvPs33b0p+twvmRNbpBjopIujjJ9nrrhQGuhjOJU5VgkGTGXqQ4kp+JKP3C4aXD2JTGGCEBnFF785H7zOzSr1fwnWzZGwFADsi9BCRILQJ00s3IwzdQFBcIabuRgTV8AWt3eJmCzRumq+vChr/AopQWKe8H3BhXBDoGXwP7c63DSw3K9oM7cIgRWlUlBOfLiPhE6JQw4YE9vkrNIRkO9zdbS7X/TADhBwOumfIfen9eZy/noJO+F0MRP9FhqJfIRLWyWO8c448mmBfMw+j4E1WQWPj2DsQvu3W/HNcd5IZIjqsZDQtHyoVwYbas2H0NPXyIuHzbj4N8CY2BCktAtX1o5pGz/R1qQnbO8X+oc5mKL8rVHwjZXXpuyt+ASaCS85RVQU6KPFS+PqzZEgigMFxiTDjnS8nqKEVUz+JGtGQYB42xx+YZBrYUFTQASgM3syZUZ2nBeIZp7etja546OPDo72cRY5OSjBK6qvbnmx2vKc967IiJlLoZnTMTYMSv+XhK88dKB6BiwFjB7bzdnEHUgg4he1tpdoexx6zgb+QDMhZr7yevjI8roK5ZM9LjNEi8KlTaMFf2kIX/mgyblW/WcyQL9+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38350700005)(921008)(41300700001)(36756003)(5660300002)(7416002)(44832011)(86362001)(2906002)(478600001)(6512007)(6506007)(52116002)(6486002)(6666004)(26005)(1076003)(38100700002)(2616005)(8936002)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTn1kidI4nbFHWsL9QRdvkjMeuB0HrIx33lDKL909qSoBej0KMCbO7LoW2dh?=
 =?us-ascii?Q?ru0+/R4pGz2a2+NyrInvToqHbPmSMuTr4ZcvqlFO0/xOdX+MWLhkJXVn1wLu?=
 =?us-ascii?Q?noVnhBvzijGiUnjGLLBBtIkPf2kCXe/wCyp5xf3FU1MNnneMyAHqHum6U7oV?=
 =?us-ascii?Q?9SEALLT8I+JBr4kOPr+eOxgtwgg0JE6YDzI0NFkpGl3tnugvorEUmWtgx65z?=
 =?us-ascii?Q?rQBb9z7Elqp+biBBbFnwNVUK+TZaGvwWAY/PgYUxqRKjaykKXD1u0CKz8Api?=
 =?us-ascii?Q?ZdYCPMGOEsx8BfBr19e/bHu9nHxD8sxJIvgGd/JutHNekuBv+/kKMekAmPUu?=
 =?us-ascii?Q?IAgLoan1J1Rksj9xHSiIZXDwpMRdOGBysZFIs1Sd/nrasW5TbgEhrlpb816b?=
 =?us-ascii?Q?Fjevbs2inZHy/9SltlweGepMilHzvtdIKuwFrt7hbe/qOpHvvq7DE35qc2Bq?=
 =?us-ascii?Q?2lFSTy6OMvmpnJ1w8ioMpkBdnEOhmjGr5LjffSDtVShUkK/3GywXSJI9DTQ4?=
 =?us-ascii?Q?PopIDOY3Zc7yuzr3+5+hfNY48IwSeRfkQowjYC661eUzB+SsZWfEZrzg3Ctz?=
 =?us-ascii?Q?4uWm2WTQ07MYp8WqXKXt0hWsiLODxwgv20STK6SxqCvbBwoEMm6DRYAwcgWD?=
 =?us-ascii?Q?EguwSu6RoXILEISaWrHmlAn+NmnfmFP0H3uIv8wKL8tF++BYk5NuzmzOlllX?=
 =?us-ascii?Q?fIgvUitjgjaUz9Rl3mzNMDcF5a0nRnHQR7TCnp+xlUBmvAJ3j+Q7gDQOlgxl?=
 =?us-ascii?Q?nMTaBtL+8nfejjwCBApUzt0vsN2td69bt9mmCmDGBxTZP+h5mtzGZtW8/obA?=
 =?us-ascii?Q?1ihEQJsH5Pp1NUSvyRC4/7zMfVpy5PeSeAJPMT0f5X9fNc1JFTx0V+ifdMRh?=
 =?us-ascii?Q?LHqPbSnA024vGSKBaHZjOiA3hXKqWWE4PTijPLZD8dt2I83GUNzObf20aPua?=
 =?us-ascii?Q?6xGm7ap/R3U6E0N3chGSkL0IFMHQjVpwyN8YNMe5H8aiHLH1eIDMP3HRZd8+?=
 =?us-ascii?Q?Dz+HWQstdGynu2pfGSRmk0Ejl+QFKOzHe4VS05tF2SDOIc/esZ3CDB5QedXE?=
 =?us-ascii?Q?vAxk5yecLvEQrGtkBWwszuMluBg85dgkumLXNIhNlNCMljFDnnzzhbKjsrlN?=
 =?us-ascii?Q?qO/FU5enMMu4CSoaxoIgUNb8GL+2SAMA6lGWpm0B2Jdz7rYYua1HOJQu/HE5?=
 =?us-ascii?Q?FHvUoM5f/+TXAoRGCcmfG30mGKNdWmYl05aDkhyaW9qP7QRKjapJdiaXRxLs?=
 =?us-ascii?Q?K/uinMU18aWKfpLPSpAIZPKrpTWTZCVRYRBBURkaveNbikiW3VOKHdk2Hx/5?=
 =?us-ascii?Q?8j9IZI7ZRyw0/BBS+SyQWNlFo80C5M2he7cH+p9Wbh0rwueqX52QZtedMfuv?=
 =?us-ascii?Q?9S/l1Y89KJviIL7k6nXNqggp+bE+OnVFBO1j7/9acqJyjBS/WaLAxqusHDgz?=
 =?us-ascii?Q?kO8Jno+g4QZctBs2AAg7+y4TNjYPbnqf8bu7fE7NGT+iBU7WtytHpSbPtSi3?=
 =?us-ascii?Q?WpMeqVSB9Zt41qMDKilwRx4SjCxrID2r8u+pQ2MYy0g+eg5/6EYxaZliKoeB?=
 =?us-ascii?Q?txEvwV/LPtzpTX1XLGBm5tgesVxOKg6PpRhdaE3+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40eac79-2720-4fa6-377e-08dbf7ce168f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:14:32.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qJHNGm0vdfUN8WvFQfsmiIJQnJz5w51C8ptMI99yEnC4M5m/zy3uMYPz2hV5Ukmb+4ogg+Gnqs2iwimQIwXOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

The host wake pin is a standard feature in the PCIe bus specification,
so we add this property under PCI dts node to enable the host wake
function.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948cc..cc9e5e599a33 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -542,6 +542,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	host-wake-gpio = <&gpio5 21 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	status = "okay";
 };
@@ -772,6 +773,7 @@ pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
 			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x1c4
 		>;
 	};
 
-- 
2.34.1


