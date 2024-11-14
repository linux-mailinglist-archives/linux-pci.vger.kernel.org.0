Return-Path: <linux-pci+bounces-16792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7939C90B2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18D41F235C2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9294154BEE;
	Thu, 14 Nov 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XYLGBGI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1047262A3
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604927; cv=fail; b=r3ddREWxjqn3k8g5zjzx6ycHes0BfUotNPTZrjrxl4vTSeNE+V8F6S0VxVlLua6epKg+Gcy1qjutKeOD31EU/zPuTWJefoCIY8CcJ8vTWnzJdwBJMp2YtS6AxSlOSXyKbtvxyHAvk76BAxF3tY9ypBTq0vb1DhmV2uKbl33Y4Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604927; c=relaxed/simple;
	bh=T5fz0D37B2TQTNR1+soYimi2sGM05YjEobftOYRPHZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gs8GK1f/xKGPZHIzkWkiUVT6j7d1HijDXEOqXArIIIHLxTb8CC6I+/nKwziu7vA/BFiBwyNIIu2Wegw1FmpqFyKSmaS2iSff0DLyshod4fWblCBuNQ52pDZaqyaT3fObVTf6QDxwG4yH2QnWd+g1Crr0NXAlKSH06OmO04i0auc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XYLGBGI0; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8k0wXBLsaOFM8g3Fs1t/cSzfqp9P/jhSYEEqPknfibRv0FVQePcAvCGcjeoEJd26Z1g/60ol1fwzAPeF6gP5S1Wf83N5rpJZsaUw2wgIlo4TERybOjKFu46K1DTMV/TFQkfH6FfnQn9hdEJkMtQVU/QiiSIRh6pu9hIp0n1+KMsV3DURU53IshtuSw/FpgdpsFkHfile0UQrdoraVIR7HX59IBR/8jeVwwKrGUUtwnYRmRWBil0PW30Jre5C9KsjrWvRrnDpsDKpp1OxmnwB3oA4cxp5XzhLiZD7VKj1i1Qr0WPAYdIrOoKJJPaSMQDi4CYvr5LXzBpVIcxo+NbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9XPtBIY6EdRHGM9CZF9jMNUODdzbhmIpAmDYE3FOhg=;
 b=SeeO5anUw6utL73+iNeUSnb74YkR+4bTdaeFIbdZ/1mBzZnt0q9fz8iNU7R3swv50UpIwYLgn3vVunmxmM0WPsmEy34nkgve7VUFTiDHKu41GLbt3tdwV1xrE7a3Uh6xQ4Z+Vw5+pbx0WC35FzE6epU83AgTyCkJQ0L9m3e/69fBF+aN+ENqiskIEDeUA/NCa9IlEIozKK47qScfc6itHV11bbh6EwBOjEj6CjLMJ63HugEu7SMLcnggRcabK1REHStgOPFnKDeDnxoDKu5DLRZs5AJq12GB212rv3c3LfOdB6ZfBQVHz5l7dX8Y2J6UbkQvPQ7encbhJtJEXXryAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9XPtBIY6EdRHGM9CZF9jMNUODdzbhmIpAmDYE3FOhg=;
 b=XYLGBGI0fm7unYTCy11bgYe2bU7ltGB7ZGI/mBn7Pw5ClXzF3HKqjLxVjpmntDhArWJz30a3JSOOHqZX0fLQ1+W0VKnSvOWlXNLUKbkQCJmIZ14lGBHtby8fzGED2hlNag2BIdERy9TqkLBUvCdLEJN13TiuXRlfuHeiBA181hYMWIAfFbqFWBX4CoYnqt+zJd5nkULfS4hNAa4j6VkJ0CC5m+9aI5KHnZe/k8cb7mBFtXEKfQfYAQDJmeuHs9hTeZMuyPdDMG576x5c08jgHaIOPJrpV204oRDYA6ChTE3LeAPVPDmIFyuptAAONqHKcpN6Lxh9dX8bILblUWPVdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:22:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:22:01 +0000
Date: Thu, 14 Nov 2024 12:21:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: ep: Improve alignment check in
 dw_pcie_prog_ep_inbound_atu()
Message-ID: <ZzYxslV+c1QxsJCM@lizhi-Precision-Tower-5810>
References: <20241114110326.1891331-5-cassel@kernel.org>
 <20241114110326.1891331-8-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114110326.1891331-8-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba5461d-4f55-4f40-fae7-08dd04d0d9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MK6Hw1furnDGPZRoqoEZ3qfCcI20HKegRK1kcyTArOFGYwUCAt8NBOtOEJmS?=
 =?us-ascii?Q?qaCOqpb5j+Le5Y7w2iik/O9p+R7we+0ngCmWYYefpSGo5yneOxffMoSnLwMu?=
 =?us-ascii?Q?zyv+nKcSVP1wqmro7iohnTjV6H+7cCKRoH6RbIKmY5OTeUB4H++uJCV3ZLsy?=
 =?us-ascii?Q?S4X1n0e2i+ofvRn07GqAgZCit6MgYjmMi8QJIlVOf8t+z/PgJB10Sy9fja/A?=
 =?us-ascii?Q?9EdW4Cy4xfZ0YqMnXf8w1sU1EIMjwCQY3i3Tqh7FoKYzlli7tlITYp+71FJ8?=
 =?us-ascii?Q?zZJ42hOM+KbyC00PSC6eJmpMcq7VJIQajPhZX8onEajQNP8VdIbzoSTZQjSM?=
 =?us-ascii?Q?ig2RNN0K/u/3O15XnkCP/fhCpKpwBS/n+IWIcfCkfBgEbl1+9VwhAPMtXFVX?=
 =?us-ascii?Q?SUs10ecvkwdjKUPszSS2sxbE0gMW5SdARayESnc6EyfYRtFdHyDL665byK81?=
 =?us-ascii?Q?tGL5BVoGYIUAIoSOfEmo5nJaxcLrGd61VRlkcZtdAjKLRhdqDNjb6ZWTnfMc?=
 =?us-ascii?Q?5+ogoI2nGNsd1QalbnMXMxUgU4bzA5Plkr0pElNC1dWtsvuugS+2E3JqK8Si?=
 =?us-ascii?Q?XryYiQHiUsqbKIfd5zDTa+SKvjIzc3W3IeCktPdcSjsRVCY3ROJgA/KalFF8?=
 =?us-ascii?Q?Dyni9Yjeiirze7sfFYefWjBoW9Wd3gCiNSglciiB3FgRhsuhLzvCvkd/YK7Z?=
 =?us-ascii?Q?eY1TWxwrO0lvNV+zp+V3xaIb8xEOeeo7w6g7CyPMxAWunQCYR5E6gGwxWudG?=
 =?us-ascii?Q?bVMqb6cgpTndonJcNxbtoK5QuS8lJqePXGg1ETzGcHWaPoM5F9WYAaaXPe38?=
 =?us-ascii?Q?b2MDlzHg8QJb2xKUsu94oD8LHnmkVnJeAjAJ5JsWqMblV5DX/jA28II8wkmV?=
 =?us-ascii?Q?Qej6Xg2bC1TUu22Np7IMPksc1bLhWPOLJ715+XN7nYMb08125YagxMnlGaCx?=
 =?us-ascii?Q?IM7lK7o3YHzRHB9fZxYoBYeqkUWMznhGPik0nVOY8C6KssC+U8zDiNsqsvlK?=
 =?us-ascii?Q?dh2RvY+4JPa3bTk52HwFT6wKcEY0Y8dro3TfVuESKlSwRafCSFCdVFBy/ORn?=
 =?us-ascii?Q?OduxXZf1jhCTfAhNiY7BeRPPNqUakNtmWw7ivBm9ZXHH9dLVyk7Su5+d1b7v?=
 =?us-ascii?Q?UxutcgQj+dD4jVkvzH9ENlNpuSKcF9cuUkBLxbnWcud2FxBMswW0KLjhuAbG?=
 =?us-ascii?Q?zTOx+VVrrPu9P+OlZnyTiYWR3btX8rXbIpVBN+0dtYfa8R16fkBCVELjVbq/?=
 =?us-ascii?Q?KyITl6n5O/eGLRw/6dxG4nvuif+D0gu0SwPajaQOuecvxoDezl8Q/4E9kVdo?=
 =?us-ascii?Q?0zksAzYJ2hS2fhVJLGqKP3omu6fixaI3ZyicN5jMXdlT604vblAKCGJ2XmBc?=
 =?us-ascii?Q?zvw0czE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MX6T4NLzB5LQRoLECnQqJqh0VxZgWeae8HNZqDPDyQHhV1niN/iWWRSHb/ba?=
 =?us-ascii?Q?QJ25QmufkFCVjlGqbShH0veK+pWkGw811MKeT6iA8BuWH0gqtF7wK4VkC9hJ?=
 =?us-ascii?Q?b1ykWOJ8mWiOHpAT1vp/8gNoLFDWbQu030BYl7Tq6WNC8Vo/QxXx3ivgosVW?=
 =?us-ascii?Q?eBsAPgXqpwHd163Dnhp1GvbjjmTYYb/pz1pKcjy01qWjTxRRJModcvtAv/cw?=
 =?us-ascii?Q?3rSfDviLFgCNB6t4inNAl+FcwJ+xOaW8s9gPkMb+ZCuJfL5eGnTwD5DZDaMS?=
 =?us-ascii?Q?YRAbsHrRt5gxDPg687KWCOdkTi3U4Cf7Wd7bTbRAHsIO2y3McA+d9SKOF0Ar?=
 =?us-ascii?Q?waxhEuwRPN8bxcW40mkILNMAzmHkgo3+ay5chNECC36EHtyQVg/ik0rpFyaK?=
 =?us-ascii?Q?SW3FD13/T4Ugl2cMR9TO5fh4jVIIj876JV04NqShsnSth0uIMI2X8/xxwKEZ?=
 =?us-ascii?Q?D/tTOG/uHjHpHPjf5dS/lF0A0zrI3ynkrCBmsPuA9zo+GSDJqzSKIj3vmi8c?=
 =?us-ascii?Q?tFuCyhDlMy6HovURk9CzFB7jEKG2UjxXGE59plcz3MqM71cK3FelhzI1zsYL?=
 =?us-ascii?Q?TQjuInngH6/MpZR8v4KcOHmITTz7xk745Qsi7EqzWeHe3JE7YsZQk4/2H6mX?=
 =?us-ascii?Q?LNtBHN8QOc3juqlHbtwXAgF3Daq0W91SwKwj8kVc2JXkVpNxFdusXVI0Zqc3?=
 =?us-ascii?Q?/I5lMlUIvx75x8yhb7tnJ4+XBOEu61GGs8YHzAZHh1Bzwiy7H02ksb29e5De?=
 =?us-ascii?Q?DOt0bWRASWubyIvGAQc0zpS9oD10CoJ52tUSBOse0DWxFi93gBG6uWaZWcHe?=
 =?us-ascii?Q?vyrr2WULgNTaY7RoH0F2hp7JE8a+Rd8oWL96zns+Mw1oBJXj0zxrVNSVIRQt?=
 =?us-ascii?Q?frvEkc6/h+EEVgPUmcanin7Qr1CteiEWqTo36HIG14LJ38Avz9kDxcqniBDG?=
 =?us-ascii?Q?tT36jeaJVmY4JdUvkY9EOdAXZDeWJaqMg9PudMEv0H2UiMEZ55/WXmuwZKKW?=
 =?us-ascii?Q?0v6HVgepDLGbdCmzVmWSGNPw9kfBHDfs7pnuKl88Nae6nmdWC19KXcWmYOTM?=
 =?us-ascii?Q?9r1iMMlguws/96NJu/ULoP0YWILflymcSt/bC+8wgLcHxsQ6xHDOcf3Ogpvj?=
 =?us-ascii?Q?2s+WTIUvmG28z9H04NtAt1ozTBMinNTCHxL/H8dDmTzp08kJriOl9JsFPdTF?=
 =?us-ascii?Q?iLcJ5xetfQLlXTAzsrvvXLuVke5MDVmWCZjSjkyrbhx7iYEK7ROWCXIPcg8r?=
 =?us-ascii?Q?goLvZwkUtLkgWQHRWSTZ5H2XQKI9hxusZEqOCG8ak4o8DOGihBWrKMoYqzUE?=
 =?us-ascii?Q?CFWdejdaHxkEfY+iOvVy1mUC5+CXxVl2aK4Ht5hfvBZrVudFm2B7OT1wgvi6?=
 =?us-ascii?Q?3U+P4QFj28L1UQmLv5dq13NHsh8uIZJbTJCqbeeaFZiHwLnUKQ4Yfjl5bhJw?=
 =?us-ascii?Q?P9yoyKFmguVsG/GHN1qVNbV/UNYdAOjcG2G04nN9yN/icr3lmjIjvu6gAswR?=
 =?us-ascii?Q?z6IDBt4ATTJonuH+yAcKYApjw8PBuLdOsGRO1va+rimbwKEK1LS9XeNDEdfM?=
 =?us-ascii?Q?2/w86X/+VCq7uJbgxNY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba5461d-4f55-4f40-fae7-08dd04d0d9f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:22:01.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/of6ZGqIR0z1wm10xU3YL3Q1epDzUKba8FVGjPt0yifC8ojUFD0AnTxDRTdIQTaNA7Gk89O00QZAJmPE5yCWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193

On Thu, Nov 14, 2024 at 12:03:29PM +0100, Niklas Cassel wrote:

according to patch, subject look like

"Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()."

> dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
> "BAR Match Mode".
>
> While a memory address returned by kmalloc() is guaranteed to be naturally
> aligned (aligned to the size of the allocation), it is not guaranteed that
> the address that is supplied to pci_epc_set_bar() (and thus the addres that
> is supplied to dw_pcie_prog_ep_inbound_atu()) is naturally aligned.

short sentence may be better

The memory address returned by kmalloc() is guaranteed to be naturally
aligned (aligned to the size of the allocation), but it may not align when
pass to pci_epc_set_bar().

>
> See the register description for IATU_LWR_TARGET_ADDR_OFF_INBOUND_i,
> specifically fields LWR_TARGET_RW and LWR_TARGET_HW in the DWC Databook.
>
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
>
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
>
> Add a check to ensure that the physical address programmed in the iATU is
> aligned to the size of the BAR (BAR_MASK+1), as without this, we can get
> hard to debug errors, as we could write to bits that are read-only (without
> getting a write error), which could cause the iATU to end up redirecting to
> a physical address that is different from the address that we intended.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++---
>  drivers/pci/controller/dwc/pcie-designware.c    | 5 +++--
>  drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 507e40bd18c8f..4ad6ebd2ea320 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -128,7 +128,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>
>  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> -				  dma_addr_t cpu_addr, enum pci_barno bar)
> +				  dma_addr_t cpu_addr, enum pci_barno bar,
> +				  size_t size)
>  {
>  	int ret;
>  	u32 free_win;
> @@ -145,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	}
>
>  	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> -					  cpu_addr, bar);
> +					  cpu_addr, bar, size);
>  	if (ret < 0) {
>  		dev_err(pci->dev, "Failed to program IB window\n");
>  		return ret;
> @@ -229,7 +230,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	else
>  		type = PCIE_ATU_TYPE_IO;
>
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> +				     size);
>  	if (ret)
>  		return ret;
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c6..3c683b6119c39 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -597,11 +597,12 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  }
>
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				int type, u64 cpu_addr, u8 bar)
> +				int type, u64 cpu_addr, u8 bar, size_t size)
>  {
>  	u32 retries, val;
>
> -	if (!IS_ALIGNED(cpu_addr, pci->region_align))
> +	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
> +	    !IS_ALIGNED(cpu_addr, size))
>  		return -EINVAL;
>
>  	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35aa..fc08727116725 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -491,7 +491,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				int type, u64 cpu_addr, u8 bar);
> +				int type, u64 cpu_addr, u8 bar, size_t size);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> --
> 2.47.0
>

