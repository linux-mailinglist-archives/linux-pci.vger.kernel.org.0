Return-Path: <linux-pci+bounces-15023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5B9AB3A9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A2CB203D4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977A1AF4E9;
	Tue, 22 Oct 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIno7+PC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA081A01D4;
	Tue, 22 Oct 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613875; cv=fail; b=IOUqmu5ZEFwyJjMMRA3FO6jv2LxfrDclEEeGI0rma3C0OFLljjpdXMjkCE0MmlDfuaaNYnBhRi/mnRaDrLwa1shXwqtIeCnwa3fTfiryPGxDgPKxAlTGdJjseWL1+P0O7c9BN9V51CDKx3B7E6dtBb5anFrCK6lLBSOhBxDadUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613875; c=relaxed/simple;
	bh=NpmR+59yK58A2rgk3da9gLc2NKkSmmlAWL9hFmEjL6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LlUKYftZDIne0+MhcCTsE/yvBWp0cKgGtZ8OVZ/KSY+GiIN0MrglB8MB0O9F4rl4Qh6Rri9vofvostt4wKijpNQg8F+UmrDbHsdMX4cp3+sXffCnhmSpgsL0OwG2gZKz7xDtGMOLG3t6LuN57PTEeo+DwxZzCSbg2jTXYt7QwPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YIno7+PC; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPFusWakmJx+x7m3OVzAoQPs/5nvTST4FDMBgtQj5F/M2oWKgoVko9AM8aO5MTgvyUAeBPGJ9zI2XUW5ajFm82ULsMsuZmw+++V6VJvfxnk3aJqka6Z2eEgP0iqsTHvOAJzksfOJ4KGNV9O+pwrgz+GTmZKFOhGNBqp1+vVjQsRAub3WuDv8eo5L/CUmo/r0iotmTAUUyNdupIEPk8Noa4JhdTweiKeo6ilSOe7cY0iUs28pDKa1O/9+Jb8uoHu4dwsGoga0Phq6sr7V6V4BTrV1iSZLtlha2yZlJ9dFoGd6Dje15iNhKLoQ+HhBmclhOJqLEXyz6KanSasZlqEomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWlKXC/hEneAhkCXNgaWDK95lNZff7H/Ez0x+2vxbyo=;
 b=AzKQ8oZ+m4MMlt/Levtl9Mz2syYTlK2UbX6bLnY1aHzO5ilRJLC3hBIXskZJSEz6Vtu6G2fZOPlWVxg4q9sDnX+Hwg7hdsBbK8jQ9HLgUeK6u3XYTX/3aDyZKdPIVQbrH7v5SUgxdHRR5pjL/ogBx7iMwE7qSMgP7I85/X5VS8W7945cUHvD14k0sn8OUVJpd/fgkxA1UNuOfRCNtkPffBuTa2uMWdcla9dyjAsbsRftctI1NghavnC/VgF7JSuIsT3Om9l+23yQfWKfP+w3By3V/VQ+y7hcRafPAyQmwzCG9HxjYYwJYro8Y7rklcGawnBLCC7ojlHlZHJ/b9f40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWlKXC/hEneAhkCXNgaWDK95lNZff7H/Ez0x+2vxbyo=;
 b=YIno7+PCLGelU9m54uo62V7lu2AYq+sbeDDTunZfzZJwHDyKnASQSAo5WPlZQa/HsZQqIJQhgksnMfqFsqsxQAQl5k/nDP9yja0Muh5XSii32fOzf0uX1kmG99G0yMrtU+vrGK61/UcBdcAD+NTxSXhd1+R8gS05A0d98dUy2r7e6cWdK9kcsWUfNtu/hVI6Arr9NEzAD9ec8fuL7zBDOGuIFgGIjwig3q+GVqA6pYmNlmMlVhnUJBQJMu/Ck6aBDp3RmrjMrlnjBgXY8zBACBPm6E5eWcYYvqMwBLrhUEZZqn0nzlrqgZivvUdltZC9GWybkh5Qy767Tu7eyev5pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 16:17:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 16:17:45 +0000
Date: Tue, 22 Oct 2024 12:17:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <ZxfQIKg1w1mhZ2yH@lizhi-Precision-Tower-5810>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022055223.382277-4-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR01CA0018.prod.exchangelabs.com (2603:10b6:a02:80::31)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdb7ea3-8284-4a88-7817-08dcf2b51064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nt6QQqi1OjaCbnT36rF8kqQ8Q3IELHw7Ksb28qrJICSZ5zkC7JiUCGeqBVuA?=
 =?us-ascii?Q?nOlmfSx2tn2tq9rve5jbgSTgZceSRvX+IVi+beU8Ahv6RijhVbiqhYSKz1pJ?=
 =?us-ascii?Q?BN3ctneZbRFBuTjUHBc9OjS3lrgt7dfT9ew2x+w/wtXoa0frGjZEJSBIoYQK?=
 =?us-ascii?Q?PDMJ6gdctk7SuS78tC5l/HAwNTdjibAnCB5+hHYWkpZ1TdFuZGbC1/6IMvw0?=
 =?us-ascii?Q?uuVFbViYQd5baz2tvNhfj7ndpQ1KXiVj5A4Bnxq9hEDhzoYUsnxSCVOUWw5A?=
 =?us-ascii?Q?dxmZhYixcKDnEmq0ojxgSYR5yAS3AE79z/ufikixk/fHbjMFAwF20tZ/Znq1?=
 =?us-ascii?Q?GJQdzuZeRNcs1f0JIBxozU660l7++UdNCLSQLu7XYXhP+6Q4l6UlsnsLcYnI?=
 =?us-ascii?Q?zcE8Ty8A8hQEp7NP6gWxcQzsoTdNEtWiI/YFa2CJQr8WlAcDsMk6BPKPu+Kz?=
 =?us-ascii?Q?KNRlqet5hK+pYYipqcxzIrgn0LJlYzo7M65ElMmMeYc48CO8EdANJHnFcIz0?=
 =?us-ascii?Q?F7LFTf+Xe0dFNh6k7H/sx72oY74P3qKmE6Ga74AkVjC9QKsbbsdlemGoZ9ea?=
 =?us-ascii?Q?sOWx0N+HXzcRROD6aBF4yf/I/w1U8bqbfUkQryWU5zctKy1YxjmzQT3vSq9o?=
 =?us-ascii?Q?mNobOUismboBbzQPpqjdRuwdx+MYDCVMj7b9vVHjUmsxuN0h2lqJ+vJRndc7?=
 =?us-ascii?Q?V6ZSMFAQ0CD71BkUuijZhkfdoTqxsChoupUy260n70xoq1Ar7aj50BpelS8q?=
 =?us-ascii?Q?oXb6Z0cCWqf8CoZMYmucQIA5nZAN1mFk5OmAN2xrE2x3Ty4RuwRHv1KMNkHA?=
 =?us-ascii?Q?+XOeKglcKW/Tl2ntxMKZGe/DxS4Gt2UVhmi+hO0/JsVpEA2SIWkK2VYB8PR2?=
 =?us-ascii?Q?Yb0fjXPkVXHEFNkEiDSF8I9aubVC+W4qf0VYSFoxjJVAjRqCdKTeP6dPOFvg?=
 =?us-ascii?Q?cxYs7xtTwKEm1yGYm5Ibl0nM+DNWuLEurYx5Xr6erpbqgvLZ6jeVgNTG0Aay?=
 =?us-ascii?Q?QlQzbdvCCBeoAp0qUIxUwjKcGHkI/RpQD978/5cSpi3CXbO0s94zds0xfMLe?=
 =?us-ascii?Q?jWGUO5UBrqwT3PTe6bX7jjFtQSxoTP4g/5BcLkrv0rK5in20H/UeCwq0sMhL?=
 =?us-ascii?Q?tceacId5//mrm14OQ9sywstk2Pi7a8odOXeFwlmU2TCAoqhbDrJ+WDimuKAD?=
 =?us-ascii?Q?gIrmYGOnm1P8Agc0yXKLJtnizKAV5QoxA4arJaFNNSeNS0ZteYwuTSyb/8D0?=
 =?us-ascii?Q?DMx9wOAqaKlwFcRrWSoHwhiBWObOmtQ6nA31oAqZJiTnRsiicN9rn/ifvwqH?=
 =?us-ascii?Q?m7uM42R1q6SKI+ipTSF6/KUi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHqWofNV/jtZ1Zbh7jdlQtXrDrMgmhitp2oQJXGfz59VJtBN56M9QpK2zVz+?=
 =?us-ascii?Q?ZcBVHv8AA3ICrDTDOcvXJJxEjhS3pYC/+WeqabnkAxdRkqgzmSz4GuWb0Dqh?=
 =?us-ascii?Q?7qaC+SvtZcTZGs+2d6pBm4QZ9Y5O29H/WKdwHPLe9WbrVs7stsA4+HxPdr+p?=
 =?us-ascii?Q?e+psqFeJX1fGQRALWnS6Ojgp5XrT9oNoszqEy6tlGbScIwGxi8I2gdrCaYK8?=
 =?us-ascii?Q?Va3DlrA3vAqvnfhqNloWS0O70ksAJiObIljKkyt5fqzOxcva3TxvZPJE3xYr?=
 =?us-ascii?Q?aZc3IR86ACp8wn6rQoTmpduZgVOSaYoipqzGWEIHtM5sQ1qGNKfKZzy/QSkx?=
 =?us-ascii?Q?ZcGWu9Tabm1k0vK4vleCfvquvHs+32uOkc3+ksHeT5C7HvwDEuxbM5bEMybN?=
 =?us-ascii?Q?gwPpNY0H7tXPdzkTPt+yqZ3UupHCwJPVHNgV7ZxtMVhvThy4cvnh8k031rnm?=
 =?us-ascii?Q?Mp3MdswuqKmrc2J8U9VY42mfiYr7E6EC9304gMdqREHuUx+lh2ufk+VXDPIo?=
 =?us-ascii?Q?QL+HklEYBg2eSdO0h2qBBBbZsNyjhzzzY49LWDp+5pL0vBVFWt4snkdUyhHX?=
 =?us-ascii?Q?h6CKKr/Nve5CXAkNb7LjMJcbZl27QoXUCoYRt79R0DqhRVvJdKTUXN/ukG4U?=
 =?us-ascii?Q?u0+su+MGB8rnt3J/YsLiB77S63UzgBUY7fZl9S1h1CEEKiTpQtgO8EoNdawd?=
 =?us-ascii?Q?Xs2J6+lbEK9g8EsfTrDPPaKrq/7Eiu2OdKAgKciLLV1tQE4nnM1qxSn+ytLh?=
 =?us-ascii?Q?rKPABJvXpxOuL0Q7kAvk7Y7Sva4z1qpmKv91oT6xB5PqVbBWUAwZ1AGnpOGV?=
 =?us-ascii?Q?TwQWAJFLI7hFj2glq4JOuXV/ok8StL69KOfl3U2DhikOISiOthhwiLX6mmJB?=
 =?us-ascii?Q?AvJ+Yse0jbHjrAOq4jngJVH0PvfMhUK5wvJbqa0A7u6ji6mj7ypOIVPlO/Ng?=
 =?us-ascii?Q?tZ5Es+MDxwDgU+Ixeg8ij6vfPMWZ5FFsQLne6Ww4LVecs4IdzMFY5+V9RVf9?=
 =?us-ascii?Q?v+asiozoL1/cewIlfhlNsWxgVXDK/gulmPOn97vhHNo/1XNry45WR0H3XFCq?=
 =?us-ascii?Q?6d73fHu9bZd/ZIG3Vqo0NCrkf4EKVhlAaXzrW45ZFLQKzIKG3yNIurt+Eda6?=
 =?us-ascii?Q?e7qqnieAxa8TtcH9pexRrqfETGP5QD06JrIZ0PMr69wTgntE9mmjUJ2RireT?=
 =?us-ascii?Q?JAMeBvJ5CPEgNwq0jPR+m4X5pNKfLFsjd8eoEeORimROZjQ/jFh3IWfPdeaC?=
 =?us-ascii?Q?SzVttOoWYjmL/hvnfoWEyuYqUAXKExWw7sukhU5G6PNEChWX2q4/PdI+ERyi?=
 =?us-ascii?Q?/CRKsN5tCsqtT+pJo+f+R4a5sbM87MSRoZZj+Ko78cN8Yv6MmJhdS5mfeHBx?=
 =?us-ascii?Q?/jB3mzBF63EMiUKqI7WrmyWyWzdr9Crt0f9RGeU07AhPMHDWGepJRggtH0fd?=
 =?us-ascii?Q?ZKbYvUGYpjVjoKJrDkbboMlgfMbE6Rp2Jr6498YbrZzJI5H0NJwF+JQQ/pBy?=
 =?us-ascii?Q?YXUD2dLLgKCXujidNQqLCp76AHi0HDsYDeMM84t5/sL0wRyEeBY7NdZD/T0K?=
 =?us-ascii?Q?Ca0pKAK7I1gp3ZCoU873JSfD0rgIHDgAxzMTDTPG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdb7ea3-8284-4a88-7817-08dcf2b51064
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:17:45.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSTsorNerY6p0Tx23vJ/RLtPc1pOn5cP+/TnlnWi1f2HKy2qTiHNNOnS+DJWKJ4dtv5rfNBRLc4+cZF6F4khrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349

On Tue, Oct 22, 2024 at 01:52:13PM +0800, Wei Fang wrote:
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
> v4 changes:
> 1. Reorder the required properties.
> 2. Add assigned-clocks, assigned-clock-parents and assigned-clock-rates.
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..0b7fd2c5e0d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> @@ -0,0 +1,111 @@
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
> +  assigned-clocks: true
> +  assigned-clock-parents: true
> +  assigned-clock-rates: true

I am not sure if it necessary. But if add restriction, it should be

assigned-clocks:
  maxItems: 2

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
> +  - reg
> +  - reg-names
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
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
> +            assigned-clocks = <&scmi_clk 98>, <&scmi_clk 102>;
> +            assigned-clock-parents = <&scmi_clk 12>, <&scmi_clk 6>;
> +            assigned-clock-rates = <666666666>, <250000000>;
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

