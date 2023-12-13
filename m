Return-Path: <linux-pci+bounces-848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2D810D6B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136181F210DE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56242030D;
	Wed, 13 Dec 2023 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="elJ3W2sI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB035DB;
	Wed, 13 Dec 2023 01:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aio2+YkVBerso08G3DXeozf54/Vo3U5VahhYHXgCvKggBt65TQmxH2Qa25mXr49n7tEo0jbWNEGaHdWNALnxLcz1/eZSs3Rb4n/VX4xr9Ojpw2/ahnGBOzkMNh9RSChB4njSK4e65XQfdrWQX1VlabsKNEyB8maw0i3DHTsasWi8zSLlaUshiANGJjGoBlVlsomfMf3OJAR/6rn/cIhh/mrjypcrG9aoBBGNsdmsx+Vj0HhukuJmT6uAI6c/e5CW4nE/kClsooSp6FcnA6n9OO98BaM2rdXt9/XaLl0aetOi3mZqm/VP6rMuiQ5lvtk//ktWON4WRLFPErqkMsOczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbCK6UKQS9ugxBa8Bfy64tCBnlGdoAhAVYvTWg7qtdM=;
 b=EQ5cnT5Aso2o8V1NCSMQoGYsaZ9cEUPAlgCzXs0hvtGP41Ll1JxN2q804KKIhyXvmf30G3PF0XHDxvTZJAeXKm0DqO08ccXX8DzDxGGL0GS/kWS4euu1+Pr4L7VWtXbc5482cTjRyi++wH3h/SIwn/PRNbJQap6ZiCfTTZpSq7EQtAwnezIJTZZ6O5akL8e/J4HrmlN9DgS+IplGz34lHVPot4onkZn16uaxNgqOWvtgz49RP/sl/4/MZQEkBbmHBMGx7BcECHfY9BwuV1JVC4n2KeJFaJWd30V96eGy1uPZNZi1h0HeI4UOdwiSO9sd6r4zBvS1JFDwdFdLnvK6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbCK6UKQS9ugxBa8Bfy64tCBnlGdoAhAVYvTWg7qtdM=;
 b=elJ3W2sI7stwSw3YeAwBTCXtzU+8aXcx+9RPfvN3TyhOE5CM3aOVxLt91K6IQqgCv6j3uYkgIaE6Mo7/Y/j7bf+bX0fO3/CAS0mH2b39nlVpKlRJT0l/AExjosE8wnEfYRrA9lQfcNLY4cyOYgIT0Fn5tPqRu0MF4VdNjh57XX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:28:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:28:49 +0000
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
Subject: [PATCH V2 3/4] arm64: dts: imx8mp-evk: add wake-gpios property for pci bus
Date: Wed, 13 Dec 2023 17:28:49 +0800
Message-Id: <20231213092850.1706042-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213092850.1706042-1-sherry.sun@nxp.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fa81ab-b05a-4bdf-099f-08dbfbbde9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aLh1mlVUqTrMR1SRx112RrmfKfcwlJDMkIQg2Uw7E4mq0xoaOeEi9/vcx9jgZghf9cVfavmjEUDe5UJ+fj5vRcqKLrMAkLKfXGhg09RdxDraZ36aCtCLImob1Vyf+VvsnR6wp0syn0JXO+Mh1JJYoOS+6OIy8hM6X32Ax8YYO7mkggAJcm2pKD/xMRjTJ2f3OFzx5KShEc3x8st5hvF9Vao4D4Midbb47ocAdukgDaaSfu3GB27xPDjOc7yq9e8C68vM6cAMMWnmNMRdf7o5ZMnavWufohyGv/nFAXQA95pwT7wAg6CfZ6c+fNnRB4NZMdO5XP7F0uUoMMaV/3aO/luQvS9mmnTYQm6Nkmgg2PRoeMXmlH6cVoFZyAgbmmgkQw8mdGYGIdvl08ICbMZ3eH0tJ/prOke0/hY2OoaPGUESfmhsfRA7SwhAGmYkw5umXxh3mLSQbG8M/8UjvtwdK6TDkIRqjuEIPWCtEKK129M6KaxWNHcvI7JVfY6CvQrYMwp6Tq6bkfpproufeL+/r5aUk6tv47Zz4OUn9HUz+4KXG/5E8dKCmXiLvVRqY/0CiaLhIfp1L/n0SZ54aUY0G99pQZjRZRV9VSdHWOegZFfR7OHhb20QMP0PS1xXyW4Kea0Lht4qLxk20HMPnlSb/0BaTDmYFHE+PGFpXx4XfFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(921008)(38350700005)(26005)(2616005)(1076003)(2906002)(478600001)(6486002)(6506007)(66946007)(4326008)(8676002)(8936002)(66556008)(52116002)(316002)(6512007)(66476007)(7416002)(38100700002)(5660300002)(44832011)(41300700001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CyZC2CTCeo66MOaGwjdye/8G7DbXQLy6rLs9cZIszU9KsQ7YyAmndeZsQMcX?=
 =?us-ascii?Q?7nFFlzURTnPsqIOdc0iVgQNWY2ZHtCmaashcpdTMIyc1/PQqF13VWU+u/CwP?=
 =?us-ascii?Q?onNRajL6xfhhi+b8kr1s2Z/syuTotfzpnfaAyZDDiY/Cnypj7cCrcpYbFjLB?=
 =?us-ascii?Q?oTktB8gVXjImW3HmdVU3Ae4W4TRpSpZgLhNSkp5Vm+xxx4YZ9qbtwrx1yFhi?=
 =?us-ascii?Q?H4GYIP1KN5+54GJ88+5+OMhN8aMwwbKqxYVM+3TOCb3iJ5GxowXLYhVcBDob?=
 =?us-ascii?Q?n2/ntwN/hKIuuph6FOH/bRRoRuegMS45Te9asWWPg2ZKTR2mNfzN9ek5ZHz5?=
 =?us-ascii?Q?Is3COYHjJt2o0lRcK1Sx2wlt6duFvjBI+i4WnPLaCdp4bgpS5dD+/RzxjKZs?=
 =?us-ascii?Q?AT87HsAh7hnasoXCMi1n4Whz6961b4JzEY1YmyoQxQcUUsdNXNifhcmkK/xf?=
 =?us-ascii?Q?YhsjmNgNsrkZpQc739MfReQyE+MVw/Cj3xh/tM86dQMJQZB2/3wkRdNC13DR?=
 =?us-ascii?Q?GsYIGdq8a2k+U5Sdnztn7wh4/4l+kl+LboDbxFfzLjiDNcc9J7LTSvNG9IJ+?=
 =?us-ascii?Q?/Jbyp7U9rib0apU5DJ3Z7iIsAAe8KYMltbgWU7Sx6vbX9AEqHH1bMS6qDH2R?=
 =?us-ascii?Q?p7p8hpB3EyR9e6h0p2+MjT2sUmo4qvI+LNERI1c50CtJQF4cYcM4Cjv7XW4M?=
 =?us-ascii?Q?CwJQVj9c28hf5EzzhF33eswMhcqZUsj5y/+nmfDDcdqxoGSYY5FFQSbKoe19?=
 =?us-ascii?Q?xpkh2/wHh998dtxNyyzrK5r8P9JUc+mel6ztt1JPPP79nhkLRmyhAZi2jh66?=
 =?us-ascii?Q?Q/7GcVu9inVHtcKuIWw964Z3+Bbg5WlJoSMBJKqcp239SAU4RnKEh9rxsG8/?=
 =?us-ascii?Q?RaWBhjuSfoFcRq4CwlkwCoqaqz4yDUbTkJnNhHFVQ6DAvOfI66Zq8xZ2lMaI?=
 =?us-ascii?Q?eYtC8tAYH38KuXtH+LwNBqpjOG+ZBIAx3vn4zr6ayf/fW/Hp5Lvg4o93QcZB?=
 =?us-ascii?Q?5OCvNx8ScZjEXBQBAgqh3HKGYeNEaDf4Q/ZM1ZMuVoNYpw28o12axgFlrQG+?=
 =?us-ascii?Q?S0fS7yMS+vMoGWjbiLKKyJaQMinDMafgz5hDO5fGkvf5YXeSCjpRM8oawTZM?=
 =?us-ascii?Q?OzlpZ19euBJOze1PxaFFm4iedogE32JY5rbq/qY7q+C2dBhnjBUDwxSkb+ca?=
 =?us-ascii?Q?SGc7p99hCtyETTrb8/NEaJWXudkgjCIDJg1QnULoFdc+0u+VKbBqUGNpQo/5?=
 =?us-ascii?Q?8+XqODU+meZwdJNxTF1zcHrgfBCvpdsp8RIxevBMSxArZdF8n+yOkYtgmem0?=
 =?us-ascii?Q?c8g2Q377DOltrETV+C5JLPrL+1SUzyFvbVq1BVbub222lMm8CKGSWH48488o?=
 =?us-ascii?Q?vA1lQHHlp1z5FkTTN8cuEvqpDPXi3DnVmhZXYOrxiit0OtH/t+dWnTJXScht?=
 =?us-ascii?Q?gd1OJGDdeJHrwrwgUHDJq5yOanVClhQWvczYlcAvpDgfr5/3Wvzz1lVdgGAO?=
 =?us-ascii?Q?SlGnwVhozNBXOxY8r9M37Cqr4PLWCMF6rln8D7BgYNB6jDf5t4aM+Keeec/K?=
 =?us-ascii?Q?+NyeAPSWo2VZzWht3yi5rVZ0b/Y/nwLc6vBm+8gC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fa81ab-b05a-4bdf-099f-08dbfbbde9cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:28:49.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn9DEFRz5fNJ++97TAfM6IRlo91ILVWfX5xwy8Hud+qS4eSO94WAAZYeUPSW0xzGMBKC82JyOYa/Zq/WHErzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

The host wake pin is a standard feature in the PCIe bus specification,
so we add this property under PCI dts node to enable the host wake
function.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948cc..4378b9c1308c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -542,6 +542,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
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


