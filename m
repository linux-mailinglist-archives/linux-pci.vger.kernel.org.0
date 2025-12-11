Return-Path: <linux-pci+bounces-42931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF5CB4EDF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E70B301E587
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D623229E11B;
	Thu, 11 Dec 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k9LZct9P"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8401285C8C;
	Thu, 11 Dec 2025 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435752; cv=fail; b=LKKt5e+VzIl92M3HnBh6KvP7ohwfhs4wIU+hF6I5DaBOYb9y0z0npeLif1VJDfBKQy+YSlYOYxgX2OasBQ2KsKDYhuC9nR5H0/SiXe5GDPuPaSrD8kHpj0oIfZegeblX0CSY0tei60i0kxPKTC5btPWzSslOaFBOErxhMSXV4Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435752; c=relaxed/simple;
	bh=qg4KmE4YC6ZO5oiWfcbt30sHKlHP603kEkZvAEvExaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quu9QqicD29dKYWnHzNlPiGIKUhDvDjxh9M63Rts7pC6Nylrx0JHtRMM1RbwTtOLx9oulcnIaUG5firVqOtGEx5t3cTnSWyQSzspMpLRKagI78EtwCMAJOz0paF04H0FiQtm0AbNItbx/AhJai1pep/9/m/I+gsxjgOidlqq4Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k9LZct9P; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtjPvTehoue382RxCWC0XGxMXaU4aECFqMOqYBEUiJNzWnTRtIcs9kz03KTYGNE0NTwg3i4r7QfFl1b+Qvmf4wypNRnyGW1RsvmBoWciC+P6CjaOFDwQzxy0rlWWI5CSi5a4z+HdPxcyzuO2QcIG2U17vdCoMyNDQWICkZcwkSoPuy+TT9WlrVVcmC5U2MzyDK67F/pth8KPAtheNZZCDEyS4F1ITrOTf4pB0wrVM/UKMArGhkbYdgTIShJr80habz+xy9WwFmYKhQXIQUcrhOqUQWSfYlC6A7bVXpa/jMGkP7pJO6aiw5UVnfHN9x7nqiqUyZSwza0Mnmqwy1eRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyWrw/HMgjTStB9ONP4DMXVV+3JL3ApRb5Hwjv7Xeks=;
 b=Sm9SYs+DJaGuI8IwWHJOO/0woiBuzoONZiU9P9yWZGLErVWmjk4+8XSIAItdxsHndSplKKxKp5BD6nyYeJ7NUsmSKYCqFSwCiWWqRBc6P1RfqCSXdazrM+QTLJFP8GiDJVVkFG14s4s58mlkYOJ+GSwsPiS+QJYgmQT7tkPviszYltGBABn9sXVamHDPQQocgcetPiqIr1HWrMxq3AF2zaYL5QCd4nbfxQrNrkm9QfgIPqHE3905lKVd4Yp0HwefRQnx5PZfsqDnABPTRDA9SPFLJ3bute6hfhedccel8Q8pmmKSaKTcGeuhBKPK+qRzmKUpV8fEoONgUYGrZE/Utw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyWrw/HMgjTStB9ONP4DMXVV+3JL3ApRb5Hwjv7Xeks=;
 b=k9LZct9Pr3+Q8YniKAW+arFoLR0zLRvRhaH1D3VxxD6lemldM0DcYKG7VohzKrEkb6QHjvDxBdovJ4SvTjhDnNOeniKWtnpu9rArGaZaIfzwNKMlmAPIhw9gEao24qwXbmTE7uNj15u3ddJG1jk3PFI0yj8QrFKg4tLXabr+1wlfJ7Zh/Gt0pGbSRZMxSkeN8sU77Od8/wd9CCGhHfyCIRjNQ0b4gxZTfbTvGm8+WVcOq1YQoFiLDwukWYaFVeHwVD58pvnC25tiwuIWaK4Fxs837rOra4GbDQ4kmlq4YHwDJkH7K56ZmcNNuEfL8gEy3iNSFQ91BzdZocWhwTiMFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:49:07 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:49:07 +0000
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
Subject: [PATCH v10 2/4] dt-bindings: PCI: pci-imx6: Add external reference clock input
Date: Thu, 11 Dec 2025 14:48:19 +0800
Message-Id: <20251211064821.2707001-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a96ea8-2b52-4850-3892-08de38816171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGLR98OPMw3fVfFfKVeaeDyGSjSKWarr8Z95d/NwEGpeD862yBgqVvkE+vQO?=
 =?us-ascii?Q?VIdOxPjPgGatjqF3PfWVb5gR90deTYI5qmi766GJv8Hbvx0nX6z26x1fAKAT?=
 =?us-ascii?Q?glhoF1HvcpjrCLU1QSPd3OTf9hXpKTqoSramtZQXWn0An4Fzc3nnv4dJWGvC?=
 =?us-ascii?Q?Qj3APnNhr3JZuYIbgo/TPbSpF38VtP68VMKeXEPK4cOE8JXhnZAr20zyc0d6?=
 =?us-ascii?Q?TsnPUGdoKLp68lExqdZdeyo8UhiQd8Z145lAxNujiQAT3308igYwfsMr0auQ?=
 =?us-ascii?Q?EN9MDeS6eMnNfVW/T9AX+EJ9dSED/voEgxzFbkc+M/biEvcIspcw9wKIpswa?=
 =?us-ascii?Q?EmXI3WX/a65cstWqHG65AdYlv2mjC6X6v/uBpE/MLPLNpGHrf01Hn75rTTj7?=
 =?us-ascii?Q?ceW0pW+Tiy618Q5B6orbMwoaMxjkFC34sAZxBM0l22yN5Ns/XuyQ7jFxHUTr?=
 =?us-ascii?Q?mnrd0TEAuauheAYrccTh9B9J7Sxp7vCZz8BxV1z84EN4ntuwLyEOwX5wIvkb?=
 =?us-ascii?Q?uxjlgMEVVL4FaOBphxvUwThfykihXHBbcg/iy0plx05jkPjirEWPtyXgNnBx?=
 =?us-ascii?Q?OqrtffoRtN/SdGjJXR05UTJnuraM1w+8kiwnnKJ3g1Rrl4AXgMgQdbs25gQZ?=
 =?us-ascii?Q?WpmR4bo69nin7X4YkXZfKsXQV5gLiL8aFZ8M7JAMl56fkEhPwZ9ZlznYov4O?=
 =?us-ascii?Q?HQJj3VcKpinyOyb4D3mhmuHNWjSKTbh27xXsEmrTRCrouKfyIY2n6oVLfMEo?=
 =?us-ascii?Q?NZ2xWHDzRkEk74i766fFNRTGpoBWrEzM32eRueDvh5UIPhwy9T+AsvEooPd5?=
 =?us-ascii?Q?wE1SQ0ArFwowDQyxnwVE3mtNdcxhke6qsnhfCzILsGImR/VmhHCa6YovGZ7R?=
 =?us-ascii?Q?UC2R+MPvd+b3Bmfuh+PkeHLBd2ETfIQmNVuis4qv00tF/+8jcosLCF2c3B1O?=
 =?us-ascii?Q?WF2UqgO48U0isP27P6EXDesfe93cGz7p+o+gP7dPp65ND1s+T0BQlVd9GkOQ?=
 =?us-ascii?Q?DFiJwmM2oKhgzDGUE8MUp9jK9iGpnUJS4A62yivXYnn4gvOFj+bzgSm1HoCF?=
 =?us-ascii?Q?LBnl11QtGXIfIk0uhcahuSyX8sMLkdnGwHyNbIJTKTBQf06UYH7YKPNGPvLB?=
 =?us-ascii?Q?t2LO+/0ptpvXTLG66YKt8sVjyIm6acdhlR5eWQH6MpxGKPatbaBtZOZUyrsk?=
 =?us-ascii?Q?uLVV1xdWYvzMm33TQFa4KoIFIMvtANnZti6sq3RlRiV0LNi13o6AXA6mrAwx?=
 =?us-ascii?Q?wDh6ixSrnUanOu0y+5Cu7NHFY3pWhI/h8FftmCwCRUNGUEPk4R9tsmueeUQ9?=
 =?us-ascii?Q?GhKd3qT/mN9uy8TYYFKmBCa0pbg4d9bKPV70f+ozTnxWODa2Fl0RN09EyJFR?=
 =?us-ascii?Q?lKGDh6feIkadXB0sRMP5u55Yz3aq5kYL4HnmwLhAMAAQcMGm32guT+rr3SwC?=
 =?us-ascii?Q?M4z+Dry2ZRgAsXP+zGJPW/mfmmfir7ssq1RJJwixoSal858sLkF9NCZNfFtp?=
 =?us-ascii?Q?TBuBYp+NjeZsD9k05xbQ8gYy18JI5bhSXJcjfTQ1rVKN15yDr7heO3vJFQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWaYFSPDVgXR5nlzouNLQoN7SaLAlx2Sm3f2HbIfEFH01jiYvtvbHGNI6+XC?=
 =?us-ascii?Q?tsdbeqMPv6TzfpYHqXkMV1Lubi0UUNh/uTdb8tmQumQUvKwKe6kLQ/nYu+Jf?=
 =?us-ascii?Q?Sa9MtNmnibPClCIj+l9yd2wc0NEWbzPtKE/fJPfPcAv05mlHi5iuPUYHolXI?=
 =?us-ascii?Q?F+/GQzQvS86AR9lfMlBdgF1l1B6vmpLssBZ1u8iNoYh+xdki9zIJ1msZpL00?=
 =?us-ascii?Q?vjf76yjmJ1kqL887l6Rr3i6Iwh2euAiiPb5Sw9RuzHSDjbBNxHsF5xWRTM2K?=
 =?us-ascii?Q?RkBH877ZjqOCCQhYgH6NexHPAjrkjTpWM8CfJXgt4B6rZgHPU9xwITP47p2e?=
 =?us-ascii?Q?vzud0bNbqcgG3fY0hdeHnNbH91Xqv7BSE4bKjV5uyoU7Cm8aW8aVgfyT7Jwn?=
 =?us-ascii?Q?kkKmsW0dXbmInLaYyui2HG7Xoa5mL58xGrOe68whyvoaZq4PyWeBSWWKoRuo?=
 =?us-ascii?Q?zWO9Hro4pnqsEgTWcG1BQZBRVYR47kpGjV2IR6c1/RDzjEqpIoOcNVq+GpcT?=
 =?us-ascii?Q?JYiQ5oQdfkZPEfthd0dCmLGWwZySBRCVzSIGuMvGBP6LypshJl/2N2gmZQA5?=
 =?us-ascii?Q?5UcOpdI+JePhnvQXIwce/4hqkJsVjbFn58jUQ2RkOLGy4O1CSQddUZjmo7qe?=
 =?us-ascii?Q?ZLa6RGRSiYrt8/hxOEdkfQUHbf8MnK2ZNr9p8ustyx7LbeQtVf3IbsNNxEMW?=
 =?us-ascii?Q?CwOOzeg1XDp6HZfYo6qAPophSY/9edy8u+q5Kf3B9InTA7jsa/1IQm+r4eKM?=
 =?us-ascii?Q?lPzyIdpZc/MZlcJ4pPFPIqIjZsNdcJ49wXtQsxF9JpodThbWNEtMphG7289K?=
 =?us-ascii?Q?FH4asTN8Rw935MvFquCQBPe+SVNVc/JMZuGgZYRZWD1jkwX1WExIHh9ctDT2?=
 =?us-ascii?Q?/QbWqJRYnhkJ7PjDfAw53wZ4+DR6vblEbe4lwOW+EqzbjfUSEks9jDttZJv9?=
 =?us-ascii?Q?CLjHgGig3MkBawO0pncxdWHo09SlZmJXFmNjdgoGj3JVLq4Nl/Fb8SU5vaci?=
 =?us-ascii?Q?nM9rjVkfrfCLahEKLwnhfZ5VoYkmhZi8VrSPSIM/qK9PmMDjneOaBPg7+amp?=
 =?us-ascii?Q?svdeXQKr1FjZwfLHJX+eU3bLd24RNOFSln7xM1SQy1g3ssdyvLwvjcYjPvfA?=
 =?us-ascii?Q?ugIGcT+sNd/RRiKaDB+l/j59ySeyDE32r2O9paScnC6XXzWJqSP0NkVyBKSP?=
 =?us-ascii?Q?LMLhy3fc2O3+SemXBZvfUcldUDRDZL0b3FFwg4ExOZNMMYDfJZo6AcL38OyR?=
 =?us-ascii?Q?buKeKbWJh/Gl5KrbME6sCWXaJ0VPIRdH3K2VQyCArhEDBOTvi+aIhL4iiRMA?=
 =?us-ascii?Q?Kiw7oN0OiGBDqZomjYiMb/724bNCjq02bbjgrn/g82YkKoBvlhAf4c2JsbJr?=
 =?us-ascii?Q?2rK5BRuFFcKDQKZjo4dthPL/If4nW2/LnnniWTtz7cabZYv58tatxr7kzUiH?=
 =?us-ascii?Q?EXqkIitqydWyBY4szYVO32UDmt1LCgORDqCdX4Evlc9acuPBWHKjQpPGVwGK?=
 =?us-ascii?Q?zWUafVIQUXstA7+mcGafWSwZMipuHrq7lUWqv8iVhFByTsbQmUdmjgJzuMn0?=
 =?us-ascii?Q?ryYul/Pm60Lz5f/QevxzcLF9Iskb95D9vYjLKO2e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a96ea8-2b52-4850-3892-08de38816171
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:49:07.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ETMCP4md1huXREngnltmEOgl6KaDtc6YPAvASPKRlCHeiE5UDa3bEOZvarx2QQRcs9LAWe+hKB+l4m+7H0m3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

i.MX95 PCIes have two reference clock inputs: one from internal PLL.
It's wired inside chip and present as "ref" clock. It's not an optional
clock. The other from off chip crystal oscillator. The "extref" clock
refers to a reference clock from an external crystal oscillator through
the CLKIN_N/P pair PADs. It is an optional clock, relied on the board
design.

Add additional optional external reference clock input for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217c..12a01f7a57443 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -44,7 +44,7 @@ properties:
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -212,14 +212,17 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 5
+          minItems: 5
+          maxItems: 6
         clock-names:
+          minItems: 5
           items:
             - const: pcie
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
             - const: ref
+            - const: extref  # Optional
 
 unevaluatedProperties: false
 
-- 
2.37.1


