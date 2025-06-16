Return-Path: <linux-pci+bounces-29889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8415ADB962
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1369618900B2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA61DB15F;
	Mon, 16 Jun 2025 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLIPey96"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442CE35947;
	Mon, 16 Jun 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101354; cv=fail; b=aqAtd1KhL2xjkx8AXHcbfTWK5gCVLYvo+8bAeMa80kWZ3iy4YXNVnBX0LVUaxZpoW9HBoL62R7fogO72HcaXXLEekBBzw2qJOgzn8yCbQsOfPHklwnc1zIuPnHhzfclxKCgTOPIiAz1kSEIwdDrRVaMICIwM8oaJPDT5eIg+hAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101354; c=relaxed/simple;
	bh=42V+eNYxXBdNwB+oXo9Y5icTM4EC7/rrKXNdmnozEzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyjspz4Hwn1kbjrmvniMChMsy+fA+ujfkPd1LVp2XcyLQ69Rt6NMCdlgQF48iwM1oSTh+ocXaGXC3xiKWp+34X84Y7npduHqYJ1ZBs2KkSR9EiXqdbR//imUXOWmmWq46bcV7CVLZYbQW3t0PVS0p+oyn+/gDuHwkGS3kwMowvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLIPey96; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbwsz3TdLd83hseLA+CxUIyLI3W4ntzlBQm3PP4jbPYFjHZBI+hC4S+utZ4Dz799AixivUHVqiK1pSmr5DDobg4sm40FccR++vh6vsReExJ6LRKA//3vFzq2u8DEicjtTObZVPrrqb7JxTFSbxTYnb0t2mHjwJ5xuNrqXckvpquV+6BJqoCmvzVYHX0RAj2sMiMHZ/PzExUT1nsl4NecXWy6u8BayNFFYjXLAV0IRW7+agdUY1hnLlfHbfsK9e73BxphLeYPZvbjekxSZ6vyY9X2c8aUhtQ1gi8ce0tzR5BSO/rhCKkXA9d7NMEYKJHeUCIuy1C4Q7wCfi1qVhcVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPk8pPzS2UeRIYVc0QbMqFQzkXLxlPr8rR5HhKhKjVM=;
 b=hohhVdd8wQqSMdXtK42IFT+Sqy8YmYRC+/b+WsFD9AJkPX/pG3O+AaHrW3L/JYLyukHZ95EL/ojIIGdDh50SGJl9tp/OBbnA8TvZp7bWKXoD5CX8gQMmTx7W+raeLRA/C5s4ingOeRTk0iqB5JjGETwBBQAFMiJY7dFUVUU0u5c6KCrFrvDaQgCNBvi+yZ4cncJFhEveYaqyZl8JzYiXvv2I3ZatH9FSPEVL0pktaA36hpCpJvnhcKgfwl2TG7e9JckBoJ2evddMnxxK8wH+DZEQkv3gVlWAy4SyvoUSfNfmfgKl1Fhko92OsTgAejlWuKG5MA7VHoCNEGdDyH2Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPk8pPzS2UeRIYVc0QbMqFQzkXLxlPr8rR5HhKhKjVM=;
 b=WLIPey96/fgwEHAeEerQW2vpFiSZgfcgMpml4HkRIaaTuVujR+YYF6L+XrLBjpEK9UEh+6Obs85vrnI2tzwolWNPOb1GzwX0qIsCv3DkopTDlvQfwCbLOetsjWEbxnak4uh0BE6/V/6RSHjzo600dnghMtifAgSqwZzRnUa4f53M3K1we1KETm+Bs18xmDUzcyW0i2SqTzrcuv9T52wH4kbJcjsmXgz1yId+bjiiGaMa5tqPG7bnzfkMxJ6OuFQtL39jb1inkI9PDP8Z0p2jzV/62EljlaAlA9F9z4GxqQE43Qkxv6y9A2rkmQPoSkqo/ZRiX6SEpbM858VqusQs3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10423.eurprd04.prod.outlook.com (2603:10a6:102:41c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:15:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:15:47 +0000
Date: Mon, 16 Jun 2025 15:15:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Correct the epc feature of i.MX8M chips
Message-ID: <aFBtXDyBep+0wyJR@lizhi-Precision-Tower-5810>
References: <20250616083744.2672632-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616083744.2672632-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:510:23d::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10423:EE_
X-MS-Office365-Filtering-Correlation-Id: ff66ce1a-a056-4feb-c78f-08ddad0a3323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OL6ebglVQ1cHlEFprGB8Lq08F77pitjN9/Nthu+wf7Uj4w9FjmdnknIKvhGu?=
 =?us-ascii?Q?gfP24/V3Jl0mkC+fjMxRkGSnl4/0VHfFkMllsHBw8WK9nU1tpCACqdnOkZ66?=
 =?us-ascii?Q?LQFxaxmnKIV5M+j4hAbiN97Y0hvchZuXXw6aPURu7NTaVc5wmqvrGgS3+txC?=
 =?us-ascii?Q?nV5iwlpIYqhz7Io/VShdawepP9maSD9WZ+M4KEJjHB62qFXoNYivNM/SidlS?=
 =?us-ascii?Q?Eiz3r9pEJjN/sNJln2fIyEehw1L6Fy2hdiuOc3pJ5AsjAYn0NY2ZDk8WjdMQ?=
 =?us-ascii?Q?gCEKFIOY/RQWBTgiI1o7g0SyyZSU1m6PH7/C0UcVI53UR0f81qfqXLLwZ2oM?=
 =?us-ascii?Q?5Drjc2CZn83S2lyfKpNBYewQVv/hUyKIYDe9sMeNem0x6h3lCWCTBxrHOC7u?=
 =?us-ascii?Q?+bebAZGaLiY/L5DrzRoEg7AF/wukp8E30RiaVWl9+n9REeWKkh0N/bLk4mDv?=
 =?us-ascii?Q?xKqZvDHBcvgJQqokDSG0GtgJN8NC+4X6jMqUx5eycIml0y5UuAHWHPWrvKVn?=
 =?us-ascii?Q?HJPlkGfTkXou3DtRD3WIEcu9PJznwIushoh/IsvwhMWm/2e+GP2x1VL8wLTB?=
 =?us-ascii?Q?awlMHOWGAkkNdz1aynyVMnwhfwal10rWX5YfwJdE7PALcsd0rATme9vcsumS?=
 =?us-ascii?Q?xZPIKY15ndCtdh21rAoVUKcN8ZognIhEOIjscNq/uoQv8+0mE38KYWHybRJV?=
 =?us-ascii?Q?HCz1QRa8Hj9QbEXGF0hkfEv8bhVvC3/OWMpkA1mQKeqbFsBsQALHQL8mghpU?=
 =?us-ascii?Q?OSLpPY5Ie655lCLgcfrDy18R8NkUQWbo4TEEI/SBXv/sMqN9F2mjSKymyjqx?=
 =?us-ascii?Q?xClMoqlxlpKjjpBctyq5Wy+n6w5HBLg+gjeQKFKYEg7NrChIi5EmUOA7KU+5?=
 =?us-ascii?Q?8aOwcnQPqi0qVOGl+j2/AgnkK5+fWsdTxGTH1hgi7WEGmkg9XJ3Pr/gMiFV+?=
 =?us-ascii?Q?Np7A/vPUHs/F7rzH8Sk7GaUMpV8NZ5TFov5EQRwfOceWMrmjvMpa4EKvYJyZ?=
 =?us-ascii?Q?Y8XEWJSJfHIDogxeAeSuj0WAG48iDdoplT4atzJiP90k+PCONTtvZ6GzTjDL?=
 =?us-ascii?Q?2PJr3Yavvs7TmLj6it3Prxf9Q8SZicVjwJVeVs8cMTkhZZNhbI9aZUj2zp7m?=
 =?us-ascii?Q?zOZvY2llKRYCyRWx3UT1zOgDHsn68cs26GNTVfG+zwT4YiqwtfhB1m5YR058?=
 =?us-ascii?Q?R4YuewvcdyuN2X+4+ul/BxyGyOprTMc+ZQ30s6V/bDCLqWJuE76K6hD0yzBw?=
 =?us-ascii?Q?L471gwJTi6QfkD4tzSumxtQYMWO28MGUPKykHuTqrGkZLUv0t2bDM53qIf1V?=
 =?us-ascii?Q?vSPg4qWhDbZjmedyLl25NpDCQzm7r5Jx6ckatoXa3UniDFKedyZefU4Q34sB?=
 =?us-ascii?Q?MQBPH72JRnI42iiWMsS2ZFyRsqr0OinI6cStKXUjGBrD6qFD2TqvRjJu3wRZ?=
 =?us-ascii?Q?sdfooWxHd88A7R06O3v8NoWBZRegDOgNP/Ehr876JMUz+R//RjVllQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUvCHSI0zg8BLI0lIiMdDZ9bb+fDg3m7b1WA4V+etVbInWJWbXvwQMZsKEEX?=
 =?us-ascii?Q?RbOtRQPjytU10YwhM0/5VxC8pbcqb+9NI2fMgaBb8qqaGlJbNsr7Zu010N0L?=
 =?us-ascii?Q?CxiY3z94Q6dMEf6ZklBKEtYNGH30+gihcBaHNJ+x28GX7b/xtWeVBZ5spFce?=
 =?us-ascii?Q?ce3aHrxkKzVfOHh9QTwe4kReQb/Dp92lpvOS7qwUr64ufUNuskejSs+jUQzm?=
 =?us-ascii?Q?b73dlY+fQfMjfrBXIvVYpXgtiCdzZrIEHCse9sP4j2oY1oFP3eatVFO/V5ut?=
 =?us-ascii?Q?FhpE56uHvmnYiedW/QvGsbUH98o6wGteX40+1+cGDVWbQF+U1HbCCuQDAPNZ?=
 =?us-ascii?Q?f01Ch2UkPl+j7fVkt1dNyp8QVOEMSxzIDRBz8poK3OdrCJuZHV/kiR/hEd3z?=
 =?us-ascii?Q?hj9q5u/z+GxE6x6+qIDVHRwnF90eiB/LwaCOnMaWbOiB/tvjJY3jymDe9bdQ?=
 =?us-ascii?Q?rFa85V13mzuVBQ3jAIoUeZcJmLhYOCw9K04sicRmdiN2tZSf8Ibp9KymrLCn?=
 =?us-ascii?Q?3rvu5EeGhUKE9R161MTrXZQTcJ+eLCqIScrtW8pjPmK3klf44RFz5udKkRxz?=
 =?us-ascii?Q?OwMOsWqlTUzmQ9wK4qI5Z+yC32TzL6VHP/CA4jgdTpbl5NAYbJPKkpwBsu8y?=
 =?us-ascii?Q?zUWPe9Neq6ym2T+tc5c8C7U6MgJpLjzaI5tcC23tdfBfMvgPO0CTyoN957oV?=
 =?us-ascii?Q?tBykU78ibvVUC3d7MNLAYnOc3s0EHu2a6C06hoqvm6Eg2eJukkc1mL9DTTux?=
 =?us-ascii?Q?KcHpvlkFYQZym/YGInKb2Tlc01AzmZ7TkUAW6SL+TxRTGeF9CQqCVXk64WlV?=
 =?us-ascii?Q?JRQj+eEfBBwnIBmQNA2NX9n0d0Xe//DIUNro4KoxVskB2Ez7bEjNewe1MXWx?=
 =?us-ascii?Q?5fnx+5Rk+Zo9tQNF9BN/m4rGyGCgYs4crFjo3k0ZYDtn/dnYYKttPyc6KwuV?=
 =?us-ascii?Q?lv7pYYPpRlKTLv2eS2JR3AF5yX1Q0I92lqFhscdwvGWSPCGKoOow9w83t/ym?=
 =?us-ascii?Q?cDkP54zW4/clCCmfnQ1h1GgjW+e1/y+IXr1/kw6SElhQKK9TNFbQyNIHPyfL?=
 =?us-ascii?Q?R5YB2So4O/lfWSKQPLMYI/7fZvyV7eEX7NvMrg9OEFf292Bl4j+eNdR7cWls?=
 =?us-ascii?Q?TuFKrhU769ojBaDBb5ULWMYMxoxNVh1vfXcyFITA4MGwbUIU4xgGWcr/jp3t?=
 =?us-ascii?Q?BlXrANM7Lpbh6bYuwSXbmDqKm6wFUT2PSdT59YIPhEeXfUOEVfvUhmWg/Z6+?=
 =?us-ascii?Q?wbc5Ha7oVSi14CQdgegoUQsv2PkeqS0gpe22cj8owX7NuMguBis/rNO1P5Ti?=
 =?us-ascii?Q?nYbOYPq2B0WEjMLs9u36I2PRHDwJpC0QqUXCYMJc0PjPmqan0NGxFZa2uMSr?=
 =?us-ascii?Q?YIF74JSxfpMtHmW+f3xo+6NVK0wZlRUXK6BJ/n202GGW9MpjOAx6dhEVldyq?=
 =?us-ascii?Q?BqcYoSena8+HHOnWf7NJdXknUT10XdviCTPkReghpZ33tlsafplATDuCfZnM?=
 =?us-ascii?Q?AAnF8OA00V15+zIpRnC01e/YlUq8X4ijuI349MZgTKfSEJxfMDnAoTX+GkFw?=
 =?us-ascii?Q?IldYLC81kAmyCJnF3jY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff66ce1a-a056-4feb-c78f-08ddad0a3323
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:15:47.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCoa6AphA2FkEbf4LTZX+FQcDXisqZ6LMNEFeKk3oplBy0Dvc+VNhkVbxHC19NEjqBhfHM+j6u997dkad+asVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10423

On Mon, Jun 16, 2025 at 04:37:44PM +0800, Richard Zhu wrote:
> i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable BARs.
> But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit programmable
> BARs, and one 256 bytes size fixed BAR4.
>
> Correct the epc featue for i.MX8MM and i.MX8MP PCIes here.

Add:

i.MX8MQ is the same as i.MX8QXP, so set i.MX8MQ's epc_features to
imx8q_pcie_epc_features.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..9754cc6e09b9 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.msix_capable = false,
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
> +	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_64K,
>  };
>
> @@ -1912,7 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> -		.epc_features = &imx8m_pcie_epc_features,
> +		.epc_features = &imx8q_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
> --
> 2.37.1
>

