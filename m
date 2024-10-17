Return-Path: <linux-pci+bounces-14751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74E9A1C86
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B07F288080
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E301DA63D;
	Thu, 17 Oct 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgUYYTN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABB1DA612;
	Thu, 17 Oct 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152213; cv=fail; b=fow8SYUqNVSGIvb4ZVL3jYGV2yj828uiPvE080XtAB2HynpD1G75Qby177Zgm3dBNy96K9Nu3AtbkyCSdVPUSUo/zED0SgSdPXoMUERirwTQkMKykinBv27qS5FJhNh+hyTnVkhA8M6ei4B3hc+mh+HJMe5Aikks9701MXGVj2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152213; c=relaxed/simple;
	bh=acNvwyCs42Sp09+kRTmvfeZBBP4Cmo8A1uI85gGdGDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZH9o74V7OUqdPE2WJbHP197PPtI9j3VeN9p7NBBuaF/H8AFIYx708e+R0oxLgh/xQqNcSI+iW8lsaZ68Qysd89a7yid7DHioW9sZlNlHXE2q7cH1R/cv/brt1W6/OuwVijElcsoTypKjabrfl2tU4yn8qUcAPsBi2yB/xiN7kG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PgUYYTN9; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/khAzztdkzEhvTy+6b4Q0w1tl9O1RSOtW/bp9G/snbnt52rOzCdEpbNz5UbLOgfynAhHheX76ZWHOVfXcoQH9Cg3CuBrVZT4McYXNtNhfOeEE0SPTqeWKItoAF6kWkIciXNUi3mrc6VpWVgOAkLiLYnAWcul4MkGHlG0fTcHF8DZUehkmCJpLrGdMbk2/4GeTRdLmROtokckuniFI6/O/i8fXOhkwXRLypyfMKyMXY6eUcjCzwr8Q30VYZ9ldOuiqWfPa6LXPsdsTAxHbyDNPeX9DRHZAck+ToF1RoyTDAgB9VysayvgB3hcsCUc70I7vnUQPKQc6cqESwZCu6sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H4b4U0gEWpy6pAZo8qPEZggP+nsDjBXAOMDtOfbc3I=;
 b=r6pxO1LTSn5f8dPAw0+ta3Imh0bIvlQWVTvC07/CUCQ4t8o01aIcFiqcaq8/F0fqvclS1XZF1ch0QwvdenJ5ICpowkcWJHj+e5MwHgTt7jKCPplWnG1WUBZzhYXqNt/yGB2PyZbNkTyu77RH5V1Duf4FX1AyMTy5ldGj7R4BfwDAZ7/bzkw4mZZ3xEoDDHBd2T2EB660f76YqpgPUJj6wmFxZxAJYAeSGPPhpFagSoblD97HdSel7zmsXbVhQbZzgeUGQSzO1pRVJmkVzTmfgqJcKrSRNbSHJg4RghsyvgaMp00fb9oJTqv246l5Y8mZtD1OSF20Pjr5dwSqStWE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H4b4U0gEWpy6pAZo8qPEZggP+nsDjBXAOMDtOfbc3I=;
 b=PgUYYTN9RA4zLjIFKojtLEbArbtTO5mbqHRiTl0USLFptqOUo+OK/lVw2S3XEBRqPeoqLGj6zH8LXYFSLOgXXwvqpdVb8IssWWiJl9Gx2BpXMtJ7J5N2GY4vCQG5TeGLrvpqerfMlGm3LErxWv+7VQ0WmL5IG5NtZBWKQHvvASGVcd3w9QUnleGeySoLtDfG47CWJTEax8L0LotUJdbHQmUyt3nndj9mn/7hwp67Ck0A/rRhlU+4Rt7dXPfKSrZHEblkAKm7fjNTfB0gaSVOKdwwckhGfCCmQlzoJ5eIY89RhBzg3TFMOn1JFFUM5fmyW6HLCBZAGxCzdmUYED14HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8723.eurprd04.prod.outlook.com (2603:10a6:20b:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:03:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:03:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 13/13] MAINTAINERS: update ENETC driver files and maintainers
Date: Thu, 17 Oct 2024 15:46:37 +0800
Message-Id: <20241017074637.1265584-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: de950a72-37e3-47ab-9f1d-08dcee822dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZaaSXPp613khxdC/jbz/4VvRRajkSfMNEl23aDc2Y3hydGAQaOdm3HhPURQg?=
 =?us-ascii?Q?cKUMqIxtv9r2IdjJ5xJl38ptHYR+QbxI/I8Nx4F5yK6pwcvt2UmLXJIS8ksj?=
 =?us-ascii?Q?FFP+JyRpl9ZFmA2SGDYaJ+VnkIETLGTWxQLQvz+xbW54lq6KWpkCD2/gcv8e?=
 =?us-ascii?Q?VHjKIlK/NI4uZPRw9GuYrnrrkEVbe2E3VmM5GmIRyeVVLacclrsd2MuIa3zG?=
 =?us-ascii?Q?G5oLw8l0nO2rZVTWgjxzVByfv25/TeYsJTWqmas4EJ1kiAaOgVJ9hTtveQaT?=
 =?us-ascii?Q?Mh29LYie1WBjTF1MWXBJkygXUCxqOM/E5d0e0J9zmCe8zMDvgSWKcNlr21XK?=
 =?us-ascii?Q?00IyjLUUZMthbsVnnj15fappUGG/XaN6uH48ccWQKZPg1AcK0oYHiyJTplwy?=
 =?us-ascii?Q?jzOOd3ymB3o7qwrqNrH+qjoqmmzSWotrhnMfatf5XNY1q1t0bQmdkiALz02f?=
 =?us-ascii?Q?Cc/xPTkaVG+OqmLVgVS6LfJzsh9AMcpfZpFHkMg1yG0j83j0EQo8PzgblYgH?=
 =?us-ascii?Q?uWiiO7tWAXTZWz4vYvQ1WxV8+HD7IoHYGV6S+0Nbof3GHZTOQnmr0ZLI64SW?=
 =?us-ascii?Q?TTmRUzGd31zt092PS6ylwhsLoByG3bn1m+TSpI1P1nksQT0KDQX5Cp6D2g1s?=
 =?us-ascii?Q?DS2vt8+e8PqnTdK2Co68Peg2k8jKXI8mWf5VMMn8bUQbTRomsGc7F2FDNnwY?=
 =?us-ascii?Q?GckCYbYIc1foYmbgAwbGyUoWJ3fGL4hXAQ8AS2Us1u0LeWgTyQsQwqZUgMu3?=
 =?us-ascii?Q?+OuJapvRIVy3baWb6b8IT+R5O98L3SPfJVhe4fI6XWPqnb4nSQnOG6PwPf1D?=
 =?us-ascii?Q?m60Tj2smMuMfH84Dz0fSHgf5TSIL3TwsNA6fJefm7kbtz+wc7TTAlKrnfv8r?=
 =?us-ascii?Q?NKR6hGqwRxhVsNpqWWkg+4+Nh1nxqQv7rZpr84lsfu+xt4jrYYUn4KzcO7Z9?=
 =?us-ascii?Q?WFpCyLVCgUxBg/aUAqS+3/AJSkJ4rQKsXejEoD/6CxlOCBM2gVdhiPd0+oX4?=
 =?us-ascii?Q?HeGBVznnm1kJzhHxvflBZmgeTC1roUJUO5LeGmAhQr0bRG9HasBK9mbQicey?=
 =?us-ascii?Q?cKvI36NEXaWzuobMBVARmGXhDcM0+gmwA20ZpjhpbhNxvsuLfZi14YBjqTys?=
 =?us-ascii?Q?UBAOpUNl60brQ93Nzl3ic4gR2A/3yDoR40Rs9yNAxVLI5bLxParDHKqZatqX?=
 =?us-ascii?Q?LlenQ2ehBj1KNLBKtYPtG7BMBvmuklZdpNIRQzE7PLXh0f/RnM/6qaSV7sEg?=
 =?us-ascii?Q?x8ZHEDsU0oIx1uKoqjD5ThnwRRJGILKxQKpGAFvoA9mpNOjJplPf60pGzZWs?=
 =?us-ascii?Q?VKwhG6nlaEDkX2qsGmoZ8CdpIVRBIp+v6N8eU8GNV6a6KID+5xPEa19C65Vh?=
 =?us-ascii?Q?mAxk1t6hj/i5yUuBKyb9yRj52vU7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHU6WPTXCyHvGtnTRRIPA3m/a3kn0c4idQwaAkwahVcT5xjOwnKRJ8QGY1dO?=
 =?us-ascii?Q?bT7yaJQ8+0h3T72PmaIopTW7tRUnl3rwufHixkgG2ozRvdmBrpq4JeUHjX5d?=
 =?us-ascii?Q?zNk7OkAccpr+9SKZ7vU5szYSLIFNIGlEBRpZ/OWgSfkspDG9TnFSeYvHtSd9?=
 =?us-ascii?Q?+FxB+U1q0OWCHT7Hyxt4cjSjjM5e3+2c9Jz1twfHQDiYH9FMCaLHnHPKTVzd?=
 =?us-ascii?Q?+5Mi4Ah3SCYYV2ef0Ah+kmeG22EHYiMNFHcnxhCDq8JVM/br58aDwgcSo+di?=
 =?us-ascii?Q?uh1kf6IzNuPoUr4rW1fPCIjXZOrzIyrpUoMWiEpWwy0amRutPdt26J9Abk2V?=
 =?us-ascii?Q?8+G/AOcGz5liaKYig/cRmGjNLnm0+BJvBicum43KmAxi62UrG/al5K7c0BJq?=
 =?us-ascii?Q?72QBhL6EIygnYx94i4QpEsXLtVX/ehqlGvockB+aabnjagHQOtFJAQ0gJF/7?=
 =?us-ascii?Q?JFlodOUlrY1knGrbpTZwB3m2pHc4x3xRLIIRsyFQTu0pXgRISKdpDXkVg+fJ?=
 =?us-ascii?Q?4bC3s0jbWOuihdupRYbxIw/EOQA7Z/MPtdHc7QHmZzS4aWdnGpdMIzzbDKOx?=
 =?us-ascii?Q?jwf9GmxygB8YIcQcUGcFT9sr56/GtNZm9XN+jUPgPinTO/b6qKuw1myWRRbK?=
 =?us-ascii?Q?qKxw2zNHl4ZKSCt1d39Er+tfKjduVddJOf8VOqXI6L3/rbzPXO8hGQNMhGOH?=
 =?us-ascii?Q?lTBrAebGp3yDkuNXbY7H2bJeaNWOy/dXi8+yN7UtFn4muSbSE2Fei7D0vBdy?=
 =?us-ascii?Q?mjwRlY0XSzm+RD1wngDuFrS/I4BWCjollqPFPfnbeyCuyoJUYsb1BJ7iqHph?=
 =?us-ascii?Q?I+N2K2dUNEeo5w0bHFjogQBOa5sADF/zGqVkSanHBqHrkniVM8FGQufmjmHL?=
 =?us-ascii?Q?1x0vbl1NDNWu5d5gW5/eA/VFuO1jUw7bB8vcklBJpzNckNZCRUduqiTFwHtC?=
 =?us-ascii?Q?Wqbp06uOvFwNGA6ySO1eanZj7TtE8b0EG+HRDwN+ha6A4coD6D0uhOPPVRFv?=
 =?us-ascii?Q?PmSmIia2P4QyrQ9xh0xafYt78IdGfu2XX37b6g5bKNmnlAUx2l3UdJgyQt8U?=
 =?us-ascii?Q?3xBf4KhxS2Gd6cO6/IzOmSrHhgOCKWvpnsOh7eLkz+iTeYpepu/4VBmnGpYD?=
 =?us-ascii?Q?pWqMH6iTM+gkD+n6FOiYNWJFgtwPqhG22OrZeHiy2izY5V2RKdDg7zVJ7BOT?=
 =?us-ascii?Q?ypkLkM0eYrtDvaJMgUZrbfNk/G5leRoaBGsve1vp8XFyK6+5fREEK0baoSF8?=
 =?us-ascii?Q?eaRMjrFivN1TGfJrGlgGIdguBR7v/xD1QOK6Z5ht72rms0rp7+vtxNArcwSE?=
 =?us-ascii?Q?YWT1i10879QzADy3GdRv+v3ypYxX0wJjC/JrDPO6vOwfPOx8FD9Viiz6hOgr?=
 =?us-ascii?Q?a/RoZYXsCH90jsteasXjYOUp5EyJKegXiWnm/2SMTHu9rwy/HShvgktmSMML?=
 =?us-ascii?Q?rUGGw4p10KD6j3I1wnRHFseI8GzZcnR713mAtRUBvFBEcK06Q34BbFloS5Tw?=
 =?us-ascii?Q?3ss8Qm7z1sR9ngYdtSjV1Ud1JEU7xUDIXfcN3L7hYpiM3SZuikbn3ePP07Wo?=
 =?us-ascii?Q?bRtJsUSBA+FUbfIPzJaHpWjoVtyEJakn3ag0oN75?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de950a72-37e3-47ab-9f1d-08dcee822dbd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:03:26.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LM62MGfuOUCUXiIDhWKcoUQmld7IjpfnGH+8/rhGy8PJBxYnkEsSga/Xyn5G+8tFZ+6rsHAeILvyJ8UcKM1dNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8723

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: Use regular expressions to match related files.
v3: no changes.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 560a65b85297..cf442fcb9b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9018,9 +9018,16 @@ F:	drivers/dma/fsl-edma*.*
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/fsl,enetc*.yaml
+F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
+F:	include/linux/fsl/enetc_mdio.h
+F:	include/linux/fsl/netc_global.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


