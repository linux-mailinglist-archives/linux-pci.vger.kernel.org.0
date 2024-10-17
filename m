Return-Path: <linux-pci+bounces-14811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEF9A28C6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B1728A51E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999371DF263;
	Thu, 17 Oct 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVeqDB76"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277391DED75;
	Thu, 17 Oct 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182482; cv=fail; b=O5/jjblXfyfCSu4tgMNhNgkwldgCuunlNuFUlFo6Hf0D9T4v7zMZzAPpSKM5e/90X3ME8B18R4whPgHYIPxbeLdFN0zJ/12x0nqzy1pQIAZv4u2IbsLjVUIFH+8Tm/oxWWKGBV2M1PDuxYO2YfnA5umya3t39b3gXX2Mjd349n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182482; c=relaxed/simple;
	bh=LQbzErqHZyBYZMTRFv9uSq6EtAMkrTN3MYP2Bl9fdzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxqLBgQ7bWtoxL5dJjU6feLAaUlzDO6PSudNFYBgzKaW1bt+ESET+CNslOJC/Si/TZugrlS3igGxZXw5KjqpgNY2gYiefY8jbOy8/xENnBh8tBD/CqGEsbvLg03TxApCLk8Ge39AdcJAs9qzlc45Qj3/K6bdY7L72HhcRkaqCnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EVeqDB76; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHewJ2pyeaiGTBOJ7FsplVvE5zwcEzrePoWeanaiIBsAminj2+mhuyibfjAFhVAlH3xyPsqptdX5a7bzwcSqmEs4FNNca468hmLytHwzef1gPXmSHDEc8yaUkOZatffWP22oj1xFkjVabxN+6m1zhlM8EhblZoLKS6XDB+ppoRgKYEY7CfYtWVqjBYBJRU4YTaFR4OT9E5z06a2g21nKSnRmlElQ+gGaGqrPd9BCilkfV+ZP2GO5y6zT5Z7e8VxuIctx1yV/ZmWMN0Z0C+v9cunDeEFjdrVUZjTslrthYDHLbbl/uxalPRGjJ7QX0QCo2uP8fbigSWZRS6AWZelnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJu4t3WRuWRHA4ms3kxt3fj6cbzXAfcF2NeQCFViADk=;
 b=Sawp+kD1ch1MPZEWW1gMV7oauypMieNRXUKklcPxPfbS4dIGcXDdu7XGM8bMgxQ1OtY9kuTgtE24x/3UhLifgwmbvVgJvotG+o3OFRHdPU71YcmimIvWG416WEOIFC3r3SSHHQs8Lv9YMLWpXjxjVyWt9AsYS2AVnAB9M7y5zaIXNbxijO8Tg/PckuySjalqc2BTJRBlAMPEHp9flCD2KoNfnz/lJrCo12GgCjOQ9IbFwMjr/LC9LoaTc3Sz6rVmndjEx9PuOtVH9hybmHQBHjrMMZwk23pnyhR/7K5aLvn0/cnUzmStc1R/HPPDlj6Hl4tb9BB4dsNBvEugMAUTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJu4t3WRuWRHA4ms3kxt3fj6cbzXAfcF2NeQCFViADk=;
 b=EVeqDB76vkpP73rmAjeIXuveRZ4jq1wQShGixiq8GNZTctNWxIYq23XUHfiMYmo7VxRzSBMVBu8BwGV9cIq0qpI6BJFyIGbwLyfh3+RN/FW/44PgObXDzcro4Cv9ND0Wz//p3jA+hUf8tSRLdQcBTYi4kTYC6L3WUQdgasUp8XWNTktci/mhf+Pvn7wKr288A45yrTjS4rUuDeJ1t8UB363r1dPsc3QAtg5vD1ZWHuBBoBeM94oRTkWPZrdwF2cMr+hZSJPZnBD3qoWSdxdx/RFbVYJvdmp0/YyLgDLS5l13PH7SKmkpto63n/xLqNxBtd/ER4Qg+5k/xiqwAga4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8560.eurprd04.prod.outlook.com (2603:10a6:102:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 16:27:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:27:53 +0000
Date: Thu, 17 Oct 2024 12:27:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <ZxE6/3enXdTngDRU@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-4-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: c44bf83e-643e-4e22-912e-08dceec8a61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVnZRJ+gYdiafV+GG2DRYsBCDQR7z3SFjjjOyqFWxCAA/oxx3sJjgoex2iLZ?=
 =?us-ascii?Q?8euvxig6Zc6EYccW+4fZN2+2ct6Om78JfKO6xCGCJjsEdC1VugxdBblYDiDT?=
 =?us-ascii?Q?4BUy0846bQTGy/OEkhbwvkVWMWHwzKMIooNkVQVcZ1Z9IfhiWUjqmLYT/RPK?=
 =?us-ascii?Q?AHGRT1Tj+M2HWIvs+imxc+h5pj+A49QKA7Yxlivhn952nb1ilpZMw/G1ZKpN?=
 =?us-ascii?Q?fAmiCB8KlKy+nNHgvvqjBedUpVakkWYdmEsNLiBHYMeQj3Js0HmqBO/HYH17?=
 =?us-ascii?Q?NB9vXzMpwow8yBBTRlG4fldFP53uvPPSrOdwjuJpEah3VqPfZx/FAqHG/3yg?=
 =?us-ascii?Q?Lngmvy3s9T+ZAR+KsDdjImxi58iZss9jY4NDSQMHNIzw6Q7GObmeXQN/37N9?=
 =?us-ascii?Q?qu2gzvY3+22CZ0eX3C83Jrd2nWk1G5GWA+IPnxsVF16RKQm9QwU6Dral/YHz?=
 =?us-ascii?Q?nTt0QeTrxwbtIZEjObvTtR6fub2Z7CYVxiRx0Dk1ffdGr3vcH/nCXoGOtQJz?=
 =?us-ascii?Q?2yVzbUA8kyFvZgKGtqeU+hn2hMK2QKzKJQf7VuG5Fhn6IDnUOqhkXNArzFrE?=
 =?us-ascii?Q?FYUHOaSFHpz4Iw2hw5AqnUYBxen7JBdgn54IkKdHrdOuDZeLEazkUruOPA+M?=
 =?us-ascii?Q?1HiAJxh4DLiucak26myxwKGjF1ihBNNsZfYTm+KWTN0D/F+0jv2r/EBzxb+7?=
 =?us-ascii?Q?rSx+I1qYcfKPa1gDKtTkkr2OZTLuqKTU6J+Xe/RhnukXKz/0wEZesLacNAHr?=
 =?us-ascii?Q?hhJtRag7NEb/Qxy8hWKKt+Mq7I9ZXyQMzgxzpbj2BOffjepN6gdzI1T/aInJ?=
 =?us-ascii?Q?jeopjnlwmIGXh0F9Eta0hXHP0tsiwHkBdogoxUOPGD7x/xRJK1jG6zRlxzGh?=
 =?us-ascii?Q?5CC1BCxEyTubP6xAOAGbKc/d3RY1DunKRdp7DHIbV571D/ZoaRWaaQTMb3nD?=
 =?us-ascii?Q?glmyjDiw7FpDOitw/fZgGdrPY64dxuiIUffXXrsCWZXjDIf+C1rN1A9TxXRu?=
 =?us-ascii?Q?Z1Qk6U4N1s49DmM4LbWnRfWFk/PsCV9GkIiXhlRGEcisuYJAzJ75rgGHczxA?=
 =?us-ascii?Q?FZMn7s7hYSGIfwLgHTakGW0Trlze0lZcvGvmQ5SZfAHyYROHSkYyvPgsrNDW?=
 =?us-ascii?Q?c63mFIggH1qMBpT4w509oNjeUEFNm+RUuJBaK2mYU5gVsQ7HweL1eeDwtYdc?=
 =?us-ascii?Q?fwLqDm3G/O1NMuYiLZqDUqj4FwkMj0c2G7BrNqxa7AXeec2cnWVX1/a9B52+?=
 =?us-ascii?Q?74aFPBsoxE49hos+M/v16gR+N7SLPsnEwJw6F6G5i+fbLafS3zmpXI/Ru5su?=
 =?us-ascii?Q?3npXIHc6KJojm2hfdqJ6u1QN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gW6cDEVhTuiU5Bi7OJxzhUEn/B6RMUfMlOz6jdoPWYTtzAFvpw2JH1dJcDrM?=
 =?us-ascii?Q?5HE1cWm9QPrLgNTZrjPrpHmcRl0onxuO2nm9Vi8mBV7VbiAVlEbejUsFovB0?=
 =?us-ascii?Q?euSMRY4foOz0ANrwNj3WMk18SENZhHiDy7qPMRqevtUCbGxnUdkQ5h86CYmD?=
 =?us-ascii?Q?tmjYe12FD5Bf64WZColBSoTCGHWMfTYkV2nXOUCuNu9Vlg+fbA4GnBy051Ia?=
 =?us-ascii?Q?ORl0ZNqyUs4MSvUa+7G7Fh23e/xHFnvo1sqy9qh26ld+GKWpB/l/IgereVvR?=
 =?us-ascii?Q?J1qIlcGlBWeTFE6/vfEtvHCJXLEn/2Rl0LHZuHvKBt4Yd8vr0XPpi2CEyyQl?=
 =?us-ascii?Q?EGfQsUUUVw97cyU5OEFPpqvm0+O+RAJtseqjxscin7JzKk63AXfnIwt4z7kO?=
 =?us-ascii?Q?V/VfYiS+SWfXpnb0HO6kcnUTDML9YJwGJ7+IZwkh7Y4Q5wSuRGQnIxceS3NK?=
 =?us-ascii?Q?2zSE+NS4cZ/hfUFhBZPCMFYIhaSO64edvDrM8czMRQDQiYqHF0MKCK0091AN?=
 =?us-ascii?Q?Fss6FasSIhkqug/DlPbHEWfhrA0GDighTgzZEDHrka9pPoqWns/A2JcqlBq7?=
 =?us-ascii?Q?zA4TQZODBDtk8oJizoq3yZI0uqYrVuOq58xrvolmSpK7fgr/RusKv3NjBstF?=
 =?us-ascii?Q?OZE5qUCLZ9q32rLQhosozVEzTMBbjL0n1FWBxbnyW5UjK6/1pZvnQUyoTtHp?=
 =?us-ascii?Q?Ak6dVU6tcwPdDKjheSlXEVrBnrbFW+LV3dfsqamg2XEK84NZORwFZvOrP6t9?=
 =?us-ascii?Q?P2lm5gcLnO958DTtkA0FOmvQWNLoAvmc02lHzGtKlXs5W6ljGZvKc3XlqbrR?=
 =?us-ascii?Q?GOJeFk7qWa51d9Zwm8p5RevyVYaBSm5bYEYVM7uFPCWd2GgtAl4AZTDldS1i?=
 =?us-ascii?Q?EOHc+HKyS1EX7cJwBLieaV4LgwlqS5SkeeFXAvIRo5JS1eKFGOSXslcCoYE7?=
 =?us-ascii?Q?rsxtD3w/5CPQtCLzyXN9yHv2Xbh9GKVar5gVlv9nMidC2iUtNjtXSp6B5Meo?=
 =?us-ascii?Q?5hr7ngz0DcXN8a5o4t+gDHo/nKi5/J1mGKmD5qfNYLxgfiyvWXE51XEzBKeS?=
 =?us-ascii?Q?jM0Ij/i6BI400cY373ibqg5jXjV8siZoypnwoey9FHthm7NEF0l9SdNY9CAB?=
 =?us-ascii?Q?yeX0gUxOZEq1vqt/3ztV4VnPjtN4jV1A7+gOHl1ekpNnPoRb7JP/XRjmdlQ1?=
 =?us-ascii?Q?LZYH+RcN48TcrDmaUMEDVfWVf9DLwcZGR+TCzD/p1H9wLRO+mK/Wh5EebOdo?=
 =?us-ascii?Q?m+i7PqeHYxqvSJeL0A9WTT8ukgskiYd65k5FDcLNBPyhoa/aezjddYAUm2xX?=
 =?us-ascii?Q?f/AJIJgQ/FC0y8wYxAVXfNFwpUG8u5b+Ym1VU9Cujbtj7Wq5z90q9Zmu3Cwm?=
 =?us-ascii?Q?fw/y4WfaLGfYqSXRfR1gMyv2+oL6ctxATyFvdmJzkhgS93wmCLXqyDPWH3l3?=
 =?us-ascii?Q?ondDEXRA7iYEHKFWJiASV5M1a3hgr0LRf2eswxSVTRPp5dmyY68W7JMwO48y?=
 =?us-ascii?Q?Z53zDaqRFIGQQLcV7dR7DOygUbQCxsHaRyIdPnGTdPqc5Txnhbx0hP83Ha5w?=
 =?us-ascii?Q?alRuS+1siur17yUaIeAoP/EYoiL889V/BFtXYSJD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44bf83e-643e-4e22-912e-08dceec8a61a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:27:52.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo/22QoXjvmI65PkCqbtAorZlZtl8w7BL/EdL5wbkBlu6bXx37acKeJ5Bs7wlGrn9FcpSInhmsfjmZOI6b9K/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8560

On Thu, Oct 17, 2024 at 03:46:27PM +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
> 64KB registers, integrated endpoint register block (IERB) and privileged
> register block (PRB). IERB is used for pre-boot initialization for all
> NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
> global reset and global error handling for NETC. Moreover, for the i.MX
> platform, there is also a NETCMIX block for link configuration, such as
> MII protocol, PCS protocol, etc.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Rephrase the commit message.
> 2. Change unevaluatedProperties to additionalProperties.
> 3. Remove the useless lables from examples.
> v3 changes:
> 1. Remove the items from clocks and clock-names, add maxItems to clocks
> and rename the clock.
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..5e67cc6ff0a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Blocks Control
> +
> +description:
> +  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
> +  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
> +  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
> +  And PRB controls global reset and global error handling for NETC. Moreover,
> +  for the i.MX platform, there is also a NETCMIX block for link configuration,
> +  such as MII protocol, PCS protocol, etc.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,imx95-netc-blk-ctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: ierb
> +      - const: prb
> +      - const: netcmix
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ipg
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pcie@[0-9a-f]+$":
> +    $ref: /schemas/pci/host-generic-pci.yaml#
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - ranges

Nit: need keep the same order as above
- compatible
- reg
- reg-names
- "#address-cells"
- "#size-cells"

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        netc-blk-ctrl@4cde0000 {
> +            compatible = "nxp,imx95-netc-blk-ctrl";
> +            reg = <0x0 0x4cde0000 0x0 0x10000>,
> +                  <0x0 0x4cdf0000 0x0 0x10000>,
> +                  <0x0 0x4c81000c 0x0 0x18>;
> +            reg-names = "ierb", "prb", "netcmix";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&scmi_clk 98>;
> +            clock-names = "ipg";
> +            power-domains = <&scmi_devpd 18>;
> +
> +            pcie@4cb00000 {
> +                compatible = "pci-host-ecam-generic";
> +                reg = <0x0 0x4cb00000 0x0 0x100000>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                device_type = "pci";
> +                bus-range = <0x1 0x1>;
> +                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
> +                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
> +
> +                mdio@0,0 {
> +                    compatible = "pci1131,ee00";
> +                    reg = <0x010000 0 0 0 0>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>

