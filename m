Return-Path: <linux-pci+bounces-39224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 087EBC04274
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2873F4EF28F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084F726562D;
	Fri, 24 Oct 2025 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0StxYIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A600264F81;
	Fri, 24 Oct 2025 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273675; cv=fail; b=ZawCd4KMLpZypDezU/icmB82l0/+BwvL12EeBIrx/FtPNIJoN4eU1PVtrw3CbaTuvP8Poi125vLjBzZdzKWEk3R2lz665jscLRW2mfG87nQd7JSR1fAZE8Y8dlfo5lkSiW6y4v8L8HfkSnwrSlGdKX5rXOLDlwwkXXQ+NneD/r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273675; c=relaxed/simple;
	bh=JGisumnVPKhoOEEp2YqBI0H9XjaHki+sL0H/Q5mh+bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDrLqi7vWEZ+sziF7vOFJWu+Hu9hC2Qt5R6OTzdK2AWMzicGqK54RjY/27L3v09h6zptMlkx5XpI05N1exjT2pUQfBAjjqSquGqGgWM6LZ13dBrW4zdpRSvzdOst5GNcdIU8H/0A44Eg0LlqM4xYd6JrYUAQWcYCvlePO+S2ANA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M0StxYIG; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUUzer6e4kNczcjyzUxa6REanWBY0oDX25hguZGO4S9+9dNyhht5OyH62Jye3bQH4WYS/wtALsTTH84ors4uTRh1ZP7hDZZcqHLVmzS13CoePOpfhIqxJH3bWSsMnaqoVy9veEtnsJeh4z5YFovnXBj6dVjdSFnUakjLM8/8lSBo8OzL1QydtvK3vc1/4BgZpo4WX5lrLPGJPKrlGkfrax8PJ5PRzAwc80fuJzP8Yn5HaXeFYgSnlcaBGEKFj1xidofZCg3Qy39VwZYSjlUPezi9xyW/3I9HjqPKzi9Wb2rV5kutWk0X4OecjFAi2hfpnMlA+YBtiTjbsyRczVrYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slc61vDsw7WGxQbx5bVC9rWYUS60mslnF6poCXrPq58=;
 b=KLic4gYS7Wkx8960za0xq9HMwV7B2pFjr261el8PPO7RBk+b5Rq0K8/qwgiVVgECl+cvlYHITLDf8ml7aQNODNSZu9YfGRePSUJPh3T4XStRyNe5jMPxCVH7m/B85izmvbRlNFxzBcDzys1cexP+LWyTi5IwUxIR8ndTU66X3yN3SXSKfNAXqLkUoBSXa7VVLkSplGAj58KgwXFXKt3BwHvFrockK/Oqf0srJOOvrfZP452ntCeJzQr+haUIf6jjVg+Nb0Vf6bWEAEncG3u+oKr5OePRVfaixgfpXAgWBOH/iBw4c3RRbNnMEhag7oO8kyrb+bklxe3ThTP0jSPhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slc61vDsw7WGxQbx5bVC9rWYUS60mslnF6poCXrPq58=;
 b=M0StxYIGd2uyOPjheBWTmtxmqPq6x6X+szdWmj0ys+Z4LTqvdce32jdaxT1M6pVn69zXoRktHJGD5jvTSNWGcPSA3KyVCkKiMQPEvh5fIihHDbjqA/eWJTlA7jMdKUMhhWxSomj1NTi+OuGLns+SeYtHC69DZRpVFYCa/1+hJr+BVhlgv0WMGjdQbPcdjt5yBKAP4ZJSu4GowIMxz+lZydmSOAIJOUCcLxLfHAcE8rsGrINuJBaMTPY5pSgpNqO5wnba/Yu3vLltRUjmDS19r9MdjOFUsK+YnGQUeYJp+P+My7LHQx8Z42O+VupZLOXaXMlolHGx8HjMp8nM2K2QjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10624.eurprd04.prod.outlook.com (2603:10a6:10:592::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:41:10 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:41:10 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 1/3] dt-bindings: PCI: dwc: Add external reference clock input
Date: Fri, 24 Oct 2025 10:40:11 +0800
Message-Id: <20251024024013.775836-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024024013.775836-1-hongxing.zhu@nxp.com>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: b1407813-1d95-4b73-b5e5-08de12a6c795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rjTrjx2UlpbgaLC0g+6KLbdGUUPYyEY+R97Q61xEzrZG2BS8I53WYXvd0tMh?=
 =?us-ascii?Q?6kYX0VOk9ShYLwUygQxBL+uuWnaV+aK8CE1QXTHwj4R3ooWxtLY1CqVQIfPZ?=
 =?us-ascii?Q?XuLZ50IxKnqL8N63xIy0aOzIX69wkO5taNopa5hel7XEPYyGFybsJ318s77W?=
 =?us-ascii?Q?l/3MFKXQMBeutHP8UG5y3XwpkB+ARzVKbmMjdDWc7+wgcgF5BJjPacpMDfi4?=
 =?us-ascii?Q?3421aDwfcMRzbs8OMjlEOvRpN9Lcu0ZeVJvObRACNz3G7hrj2yM8096tOjSq?=
 =?us-ascii?Q?51M/ZBIa3IKddEXwAfxmTT+aG+KVMfaCSPmOrV7ahUt1LBuNXyufYCF56CmQ?=
 =?us-ascii?Q?RobIKpYhGC6eXhWsYov9Z+YoL6FtUn1sPEve7wymscg4nO3rsxvXmSOfrcja?=
 =?us-ascii?Q?O020/PGkeDRQUrc0dhLMN51XHswqXA5/UIEBz+akeAbhd7ABe2oiVTsLhWnM?=
 =?us-ascii?Q?zxLqkk9O4tEqdO61+LevRCDcXnqdZ/DPirmtCThlb2BK4YLcc2Qd/ILCt23O?=
 =?us-ascii?Q?MUPKVe4F/8sXx7M5Wks7lgFa8ZEhp5KYsuAiqBSZJ4NzpvQ3i5WmrpLtpCb1?=
 =?us-ascii?Q?OfLy3NAKSzH0ZQlMpO6BCCt3xzqhfFmcZP3RG/Tsc/oadfkH9GD9hMwFr8HU?=
 =?us-ascii?Q?IY8xOY3+2h1Mrkc8CTg15/nDw+VB2CJLL/FMYh102uGf8oE/CbT8TM7jwOEx?=
 =?us-ascii?Q?ikNQ1V1SmRV+LIWr8K1pjwZ7xScaQ6oRIeddydYa/fC7nwkgO18e2iviKl0r?=
 =?us-ascii?Q?c/nj9Z8NHDPMvKR2MlxRfsYfnHjo1baQFm2WA8Cii1beCXh8zCqbO9IQMcDX?=
 =?us-ascii?Q?ZU//1K7kDLWIqWFOjhg5GoFL8b/wmumAhSnTRcQrYGRWztvDRPK8X9Q03lWA?=
 =?us-ascii?Q?03R+QLjKG/H9+DNDytCaj4cf2x0WY9cmODlfPxpM2lCVVpQIO83IOwT4HxAe?=
 =?us-ascii?Q?lrqvOy1Jyk3Xm99dIgdCQXRNJZEq56FTwWLuFd6Z4Fx+UZj8s4S4UFgpOC2r?=
 =?us-ascii?Q?pX/jujTyE6tkXOA7DzVZzmpVLovFI0xnOY1Fw/3HLg1y1UqDoqf+Nl9o+EFX?=
 =?us-ascii?Q?mS76vaM4n23S0KR/R38M/7jW0OcJGUYHO4vt9PTsMWiC936zsuR3hzJYU+NI?=
 =?us-ascii?Q?OPQwpSo77GfWQXw2G0a9VYlRhXUjxbq6f5agsS2IYMkrq9/a9/l56x7OJzSR?=
 =?us-ascii?Q?sPfFL1G9xoYVmfppYTwdEYa6ujxDOL6Cn4njltfPjzqAIPyuDioicSse/PA8?=
 =?us-ascii?Q?52bo5DtQgYkgJVh0LeJyx9jMYhxtgUh6nHlO9fVDY7vEsG2Cq9soPFkYcf+r?=
 =?us-ascii?Q?+tU4QSnY5yApHLnAAJxwj8eoWuN7jkuMJ87LEx5lMI4tKhXZjs9GFVh6GMlA?=
 =?us-ascii?Q?eaXZ5Snob6NBSp0sgZzUL164Hv2cFtJmABnqVFaG3WodSp1zWkijcdKEQitN?=
 =?us-ascii?Q?I8hEIaJy2qmeWDQxFnnZGJM9HFDxK+fzlQQVwbG0j3FWerI7Y23KZ/Mvhvr8?=
 =?us-ascii?Q?YEvYEFDVQo6anVG6cjz9PhsLpFkM9aBQq5Yui3+ofXpusH2vr7iWotNSCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncm1wuuEpg+3Eb6ZVPUIHYDBr/3JHGVKfzpqzRQ6bF817hBbjV9wMh+m+CGG?=
 =?us-ascii?Q?9qoiF3tY4YXvq5saP9iiLOTvm1m5DlMXdSb5reT6WdEGD0jb5WkH40iwz7mk?=
 =?us-ascii?Q?2rZadVhRUpqexJH3kl2B7JchnxThws/Mmbe5J2nF3H1fMQBMN99cR71iI6UY?=
 =?us-ascii?Q?LH8U0+bPhFVAqIELjFk72BO7J7ZKcee/15MHj3yDyEKG4iMUms3VB0kJiqSW?=
 =?us-ascii?Q?jTdlW/reACJb3I8Wx1JhrMxabX1RgtN//8UbsaoJT282Ldz2NiHZMBoa/T93?=
 =?us-ascii?Q?s6zrZeJ940UAgip2qbqUqizXuxG29ujYJbf6nyI8+b8Nf0xmEdbwfkrNNEzp?=
 =?us-ascii?Q?llvnVPO3nS7doFWxVfE+s08DoEd33fMErGaT6MPQ4eIWET78fUaqhsZr9KvM?=
 =?us-ascii?Q?N81ONoC8JmKMsvsKDmqDWCoo8wAtqQnZxp3jOzM/usdO+SFx+BMErjXNL0IP?=
 =?us-ascii?Q?xQekUspM9foHDhdZpNCXsE+ijBLMMX5t81mk1PGJVeX9pRAR3ZhDwhspdody?=
 =?us-ascii?Q?vOk+eUj/I6i+7kQFh8JhxjmJqc5B//GnfEkM6FvchYfur3ZOLi/8wN/KYz7c?=
 =?us-ascii?Q?fGxEdv7/oEhKx69VT5S9yo/Nf+Aet/aGzd9RDX4tLPIkqBo4mDlL8DYtNYKg?=
 =?us-ascii?Q?Ph37m/SoEQiPFVnyV5JF+TqszSEZwDzn4dfWzsyfFNRhGS/wqYGbuXUdjfGB?=
 =?us-ascii?Q?k8FVxpb+UvxHQAKEfQl/eNMTDBOTXGBzJpdHFS6IpiXDcaia6MH6zQnDVSYa?=
 =?us-ascii?Q?fz620EGqjCteftuYEP5etvAYAT5YkB3Uc7we3Qnnj+qGaq8je1nXmrNDz4Jo?=
 =?us-ascii?Q?ByRztmn8w/VNmAkYcl+rRujvVSU+MaqkhuPSxZFu4OpzQLKZZ72yKtoe8KzQ?=
 =?us-ascii?Q?gjxgXBeINomsxUOPRWhiKEubFcwrPq0Bu68Y7DCrfNL1idsmgSkzGi6GrUai?=
 =?us-ascii?Q?dOzr7y0KN0fLDiLJAQd560gyv6Sllt/iu7oHOgTgS3+cnsBLO5z0sY6JNYjo?=
 =?us-ascii?Q?Nkhy9lweujclptMfVJGtTn+zwlBlaaymTRwXsJ+fF1U8OZ8os237v3zuUgD7?=
 =?us-ascii?Q?mPsiTI0z/ltNhfM5nD/dPCyKh+tRFHf6H/J7XN+ZDnvtNXrcJwV58Q8biakm?=
 =?us-ascii?Q?49tKOHWGA5q0Y9+UWjQLmqAodXwwPBRJoFXtJXFElk2exTHRBH+4JjvOnm8E?=
 =?us-ascii?Q?bylsyhPqDZajWdCTTAtNYJBfHMpmHiOnzrC2P3RiCqaev9isjRTONlVP4HFD?=
 =?us-ascii?Q?3ZCP2UFjLpzhLldIm66VTIfLEM88RNZqkKRnaZ3/ZRKAKkEGRJrA9Ngfc0Q7?=
 =?us-ascii?Q?Za4THaN327nWzaVr+N3verdN1xZbmg3BU5KaVtEhNj/d4iw5P1O1GaiVJfdC?=
 =?us-ascii?Q?HgPozlUbog7pvaX36XVMVGEvryQUJxLMDSFCg1DQplZYD6LJ4hGOfUchCWQP?=
 =?us-ascii?Q?VQ+DpwfYV7uOgPRipcUJeZ0O7kjySlWrvtQ5iB1OsOe/TM7/UUXyG9Pm0BVh?=
 =?us-ascii?Q?iGNU+5RpCHqYqz1Luy8coBCqzX9n9rk2Rms9YGHKaKbH6He4oaC9OU5P9lyD?=
 =?us-ascii?Q?khDKpZEMX6q72A8ZwFbqCG2C7pdrEk+MBir1Wya6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1407813-1d95-4b73-b5e5-08de12a6c795
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:41:09.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quJIzKfF07l/6APg2/1+llBfU5cUI19ODkHY0gmFfzNV/AixpABs39XmTI9MFzhcGm10kBlHY1Yj1wJPkUUwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10624

Add external reference clock input "extref" for a reference clock that
comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8dbe..0134a759185ec 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from an internal PLL, the other from an off-chip crystal
+            oscillator. If present, 'extref' refers to a reference clock from
+            an external oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


