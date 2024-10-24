Return-Path: <linux-pci+bounces-15170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7219ADD1B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC991F21C5A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BE18BB88;
	Thu, 24 Oct 2024 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CiZ+ALGr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAC18B477;
	Thu, 24 Oct 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753730; cv=fail; b=dPLUuNl9DP3P8qHwl7u3t0+Uf2bmFMj0yZqVzTbb189p0gTpQL7If+L7iVCwLK9DtTWZnD1YLLkygATqt+D8EGwVJQpV2Toh/qv6rWFiesNDdhNa7bMf9IWvWaEaHHlzrYWmxUasNzkVOq7m/FGEDkxpQl6UWpMoF3h3dolhWNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753730; c=relaxed/simple;
	bh=2y0zDTC+mj3yIpX6OkVSaHe8ShPopq9CQGHyh6jzrj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqKziCyCO+HrnVxqCSQthhO617wON7IoBTZobW5C7jzPMUUNbIM2JfqFy9pHHMDaPOVpBtuCxSfxtWBZYHsAP+uWdvXIdkt/qPP9XdcerlarqLXYD7bHalJ0ds0yUbneItqYWsRCbrOOWWyji6VAA1J2OUDMQIcvh+MWXeL8LxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CiZ+ALGr; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9Qv2kfQ1Q6H8IrHsvNLLKasiOpacs6HfylxZUX3GMTCHBTr2pE1yaVULxCucetQ1kfNhQINKknjSmArZx8p0M4NuWuSH2ipXJrtiO5c2gx+ujqimHK/tiqIrQAsUW8lGLEYRJSj4L9xRg+tE1omgSM7kzMFMoubgcI3Z03sAHLUawfnGJ2TEi8qCDpWgvyJoX3Mqd1NJCdYn+7c0Jtho8Ru4KEdPa8+8raby8YyNN0PItltFVjc5NGAvZMyu06JbWMpmh+rmETKmr+aN9kWbk6oZU0j5t1c/JiBns2NcoEfHThKCuRPImuEg6Q/+J7h9M1e+mPNb3L1VPicPj4CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2AFcGOUub9RJ149gnjmcK1RNi4I+ZN6Rtac0LgyMME=;
 b=t/A/wxEbRucuPaLs1srBDlG2HmpwZ8dlQbTm3JEJSmPbuzQsrbrcB9UjE49Eq8QQvptKhZkfWm15jIgEcy2gTJeZEN/FadZ6G1vcFdKCt/C9bUvIVrnb9OxAJeh94aW4Pt9ATiuDeM1DymaNTPR6WlPxLJKI2F/Vf9BdqrkelB4GI2pIKD5k1oQ/gyBkep9M8KbgmDauO9CVfQBTECwG2QEofT6kk1htcQrQv5PR1l6CjuP8QlcSo2ln2+kf8NZGeuBvhwUXuwK3raPSIswmjsGqIR5ZRAqNtQ1e3xTSiYMWKu/Xh7a2UmL9LHjjCgL6EB+nNJxU3K5EyWy4ad9uFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2AFcGOUub9RJ149gnjmcK1RNi4I+ZN6Rtac0LgyMME=;
 b=CiZ+ALGrpAHp2gx2tjGuW2CCuePzGRRwnshU1lKp4abQIx4T+2IQ2jFLBonPRAMR46znTSCM4mysLPDuyI1wegXpFbL6y2baVlsD8ZeObsbBvr2nvBNhqbjeLGcArkAXfseUl8cD4KClayIm1jDHR/Mg/WkcfsHy3XnF/LXpAUnqsLsiKjHMhN2+6yZ4tafmHZT51gbgoNfHZDjS9CtShoZLQq1IG6GCbweCzYt4lU+NmCaLMXWLgEzlQzkxnnCrM3yNJ6FtKy8IyCyRAlnLwx11jtgZWeaSjr0k4D0JN7IzJc7Mm4MwjKaa7kXSknx+SleQHakY+dcIwTH23rpfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:08:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:08:44 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 01/13] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Thu, 24 Oct 2024 14:53:16 +0800
Message-Id: <20241024065328.521518-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe8e16c-3aa7-4e91-a663-08dcf3fab21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKsG/2tcH32LAjhKGffEPUCz8whtTG/wy3M0p0IuSPDWjRk9iRnWRZEa0o35?=
 =?us-ascii?Q?jRDdOzRaGkQuvgEASH5G04uV0JozEZbjRvGTSjKz9nrSDJniorZwgsMW3TpC?=
 =?us-ascii?Q?cHSFRCGYaOIempXseaXpfzb7Ku18xE0DEF0Uv5ToLfZpUQlPk71aIuMFgDDA?=
 =?us-ascii?Q?2St914aW8NHURjqxu0hQRSmTEdizIfz8qO4LqmZaocIlgA4EgxD95/c3sAHl?=
 =?us-ascii?Q?KmxHmjPUdJncFbZ0WlYtJLzmIfAL7IoTxH0p/Av57bagy2fypM0xT9FckBic?=
 =?us-ascii?Q?lxBn/l4Bs63pL+pBMAL0tyeN5HwMLIhjiRsn4tttD9B2aURby9d2tL3paVEC?=
 =?us-ascii?Q?K36dNihC8S3BgRQtcSYE9878PqPsLoyYEkCmybagqlCz/CAZrnGfLNq9ehu0?=
 =?us-ascii?Q?fNU6lu3mXcWwly6gVpJ4f2XsBELq1kjLbkH9sI1dA04khx5sDpwXpFnuHQT4?=
 =?us-ascii?Q?izuMHda2WSzXXpDnveYJEaN2tSV6OrSBQv3ttYOB35HXrGGPem25S07v2Fgu?=
 =?us-ascii?Q?isRgd5FlAvGg4VSnhU2NJ2/bcDlGTGNyYcDjedeJFwvKNzzUc8T6Wl0PbJfy?=
 =?us-ascii?Q?DxNPbfglAFFBcyltxFjHoWS6M7RYdniM2owsPLL7t7nZsj1e7/kUZ+rJOixm?=
 =?us-ascii?Q?KZ9xX2ywo2sHNCk0vLpmntdk6f5pkqh8t+xjb745mSDFEAcBqo0uyhkU9SWM?=
 =?us-ascii?Q?Vl3m+OXID+8WYp6dYFvOJTyKlSnBIvRNLo+wNP7i0jlt3+GbwfE+d5Ze6wx+?=
 =?us-ascii?Q?vRNHdR058N1wUZ9/Iqee2WOP3s9IN4TWCwLl0S6HUe9xx9jYyOVOz/xy39mD?=
 =?us-ascii?Q?DFZJdZg4afVQ7FScDsTgdPL5r5hdGkDwMujsWgwkIVNi/ZjxFFQLxAz0Zmai?=
 =?us-ascii?Q?SJV8uEw1I/Cw2lloJBpI+/NJy+tcfTDRNSca7yXyVv2WiRMUNSqg/oTAqSc6?=
 =?us-ascii?Q?NSRMpUuNClksAP5YdQHYazQgBX4Ic28F5hcYritCz8CWMGBUkcotRjcb4w3Q?=
 =?us-ascii?Q?/DNgX2gCaX9DGzRw0E05foE39S9thCgnWsEviv+jHngFs4DrQ5jceQPKUzlO?=
 =?us-ascii?Q?BoXp51X7f5tgQtqEzlaKOwWtdYkNyl3tqh2Y0n4wassLTtv1YxqTdLynGxRp?=
 =?us-ascii?Q?36mYS/EaK4VgFpa2UX4jg91tLK+703x3fgZboLv76vFXqCdRCTHPNkpLng9Z?=
 =?us-ascii?Q?NHKc7wLaMZOIzuO8wwJd7SL28mCysIOsjPBqgDptMCdZiFtWnXsefxHnAM8m?=
 =?us-ascii?Q?vRjS07o7hVwjFl71crd8JfGGfrHSaKvfXmdnEKWgR/Fe98HnPopprhE6Quei?=
 =?us-ascii?Q?w7n3zeeaS1CavzPdBsG7jUews+x67wMsNTjRCTPkpSVH6jwgjJoNVYeHDwxa?=
 =?us-ascii?Q?oUsB3esCYJsX+Aryw4cO2fD0wX+z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PHTA31StnMe2KAoFWTxCWIFIB0cg/vhTmZ2aaFi6cxbj0HqyQJ0MlWwQbQiO?=
 =?us-ascii?Q?1b5ExcH//nT8QgdwjYH+Pa8zxAGFXzotj24xbyZ1fMxUntzHkej3B+TgXNQv?=
 =?us-ascii?Q?sckKz5Bu/VplACV60UAoEZRMTNXEWVV+QDoP6gPWN4CqzTNoYuRMJiwJpMsR?=
 =?us-ascii?Q?99WkvIvjLCeiG3G0YwlJlGRAyEYP8vIxVQF/HHIicPYns/hfY8RW6UN+N+O6?=
 =?us-ascii?Q?CG9PWVB2Q45y19Oa1ZWzkHEjvpkTIODUSKZ4VV7xD3A/aXbZ9zSTGHygVa4B?=
 =?us-ascii?Q?XuciUczrPAyYX6fRqFp4Fd6HBodvAs9G5u6BtsqrCbSo5zPSYF8+WfIRQUQ8?=
 =?us-ascii?Q?bdPTjLt4rRvB8D5F/99XrPFl+DhTuSMhWC1PjkjHX767JjikUDWOgX38BrJ/?=
 =?us-ascii?Q?JDk2bDgwy5kUui2MwCR8axF71jBJpy0udcVaRB0VLC/hM0O+gr1+k5y/GCux?=
 =?us-ascii?Q?mG6PQ5a6OP9ynyKb2mK0HqjIXkwNhXMFYRdWTkZORsgnM61WKXIuQ2GqcOdv?=
 =?us-ascii?Q?/Hr/OxeTvHfxq90Wmx5jkF2ZZ1VisplbARxh7vcJr2rwNVU13t6YeXtgqyxq?=
 =?us-ascii?Q?GEgQqZuFPVMPsEwdCY0nY/8QmmckaVA9vBwTispmXsQNHrJvl9fEiz3LeKaU?=
 =?us-ascii?Q?C5B9aEsa70Sx/QszydPo4eNrKX1BNDFrGyI6rsQbfagmFd688aGEDPRzc2nf?=
 =?us-ascii?Q?8nfgRx6Gx6uGZYfCySTF08XN+BXNFXIXR8zt8Swf9Wkx9b6e0o0+pUBs5mEF?=
 =?us-ascii?Q?WGBGrpBO9ETr67eQrki/OkL7/SOvNBZoRuzsNvJDI5QR1j8sKtedcOvLs+kn?=
 =?us-ascii?Q?HoeE/8oYgJ0TFzk9zSkXHutWWiESPns5XLAthOhlOY6VBptK1Q/hIz2JHjLc?=
 =?us-ascii?Q?46cbNOG+n1SfeKnl4RiNfbxZK8hGELIV/gJEYdSCb71SC6uRjGPXHN8zCsnt?=
 =?us-ascii?Q?FWNpESVo5JGuG3BlhIP/JY/jF1Ukpa2tpa6cRIxANvr+h8n+jwIT9kkanCVa?=
 =?us-ascii?Q?mIIvOTi+3JYmNWUcL326RizVo3LmvvTfnVBBazI2p/vZEFfKGmxJZFLeBWAq?=
 =?us-ascii?Q?bEmIoFmoVs/3SXERuqFVqm8qNBYMMNAhqCJRBEQyqAHbPr6Anuj2WdyYj9Vf?=
 =?us-ascii?Q?vULg6dNCPmIyw3miNF+FwkgrTVfARB13GZgjbQ0YbZo20C5Ur3J+uGAKL3BX?=
 =?us-ascii?Q?NNOb/woQ/Eiuw50XHL31I115cOFVfHcjewWeZF+CWeJwGOi3wgJLmCJWjrQf?=
 =?us-ascii?Q?u0xlgx0ObG8Xk3dn2R6e7VZk+PGP0Ylw+q+g6NOunC3UxE8zcgkLH07SAbJf?=
 =?us-ascii?Q?/oJQJ82TajqFeGyB3iVCRy6TqC1ukGAkRx327CxXGG7gHkch9JiJX3kCaISd?=
 =?us-ascii?Q?qOK7x5a+vpCvCf65k6nCtkhNWhv4AOJhl1r8GzmeXudRpmWacQe9KVu5BCh5?=
 =?us-ascii?Q?P6VLJYVQ2dLga8sUQDs3KA7x+u+oPSCjbZ96SxYrJZfeqnZlYwSVHBtXfQmz?=
 =?us-ascii?Q?aH2GSdhEdZZpsg+r2vMWy7BDqsSOjMmq0ZxfVJbEGbE3fFho0rHT0h6KR/WT?=
 =?us-ascii?Q?v+aqa7KDea18SisVnpxKrv6HilDbQ5BrqxIqdJCr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe8e16c-3aa7-4e91-a663-08dcf3fab21b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:08:44.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIx+J+DsBJX0GMtPJVXKjQIXCxD5JYndpeU/EKf+BsVfarn+LNBSTqwJzC483h6OnBvG4YmxAI3SYdIsCcpBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v5: no changes
---
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index c1dd6aa04321..71c43ece8295 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -20,10 +20,13 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,ee01
-      - const: fsl,enetc-mdio
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,ee01
+          - const: fsl,enetc-mdio
+      - items:
+          - const: pci1131,ee00
 
   reg:
     maxItems: 1
-- 
2.34.1


