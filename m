Return-Path: <linux-pci+bounces-36865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE43B9ADEE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FF419C53D0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05E83A14;
	Wed, 24 Sep 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsxJzhNb"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783DD1EF091;
	Wed, 24 Sep 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731046; cv=fail; b=F3JTP7hT0LT4TAGg0HvGHrgr7vXEmL8Vw5bSTofcub3Lierx/yrZfhBOvw3pEhGhb3wbnDS5rzZWihpPN0oeJTmxYCyguHZ9HvB7n6rDy97tfuZBOVzxKRI9OGuXFGa+2FQoU8X9jT2yzvuIXla4uoyFDf/8kN4Jjqknk6EIFZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731046; c=relaxed/simple;
	bh=E+pzfW2x86NKXwXa64/FmNXh5G2VHcbHKt9q8W9ucCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r7LPIPR/y9PDMWXl4AxDoOggdew7+yFgki3ZpVP24ktZbQu+S3bIj7IftBjFPisJafD1ypZWjHTZBwBQUa6Ksmn/VfrLbW2GtHPkSYT7xu9fo0CbbpHd7La/tXBCmn0rVP+yCRAPHrdCKn8e8Brg/8TraYU5CnfnQ42ltMeK5zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AsxJzhNb; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz8C3bv9OfP1xKw8xOobRz5uhCNuz7ATK2BJkbT6YCDOreAJ3+V2DM6PPPRxAp+cCpsr+cKCRQKEvZXYRYz01qOyLrCeeeaxBiHRfGTNSXISOMDr383OMhnY5YZqfeg+8d1BDBwvmqUwliufDO9K9FZLgtr9p/nR+xfH7ETWOcHOCeBTx3efEYkWvvO2rDx+lhScjoWjS67FLZLLe3IR6/GbjBgk/2gxQCFJAuKfPVeGt1dCgDc4GTmcwXhIGghnIzQ3ic0gV4T6+8LpSNj6wv/CqbDW+zSJxD5Aqwo6N5IfNNEglK2zE1azFNSsh+C1rrpEVQ0F9A1nDElEGb8LJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdtoaZG8+GvIVjLdp8ME94ZeKdNx49Krb9LjnSI9Rzs=;
 b=LW8jrHyIdRdcTYnihHjJErnoEw4dTPrMyXojnismz+VV0hiQ53yQbkoQFBLDSd0EtVwqSCVXm/znbshGS0CnDyWYGhez5jYgBb3zMD/b3gU9KNbkx8cv6xYlK3GNfXOrt7EnB+6upIr8FiP1xXt+c1VN9/MpZwEsQpdO3DMJAkkhBEmOOcXB3uTd0WNGaZcK3+5QVT59Nz7+A0cY5R9t6eEJtTRNjrL7+3BJGcLP4JdpKqrKY6pIWVU4XAelOjAxC6ejldw2cBZfjoVMFBORNtT26tCwtltgw3x6zMVPBJBYyfcmgmKyWrigTB/phFMvaA74o+QOtfQLvmQOj02dtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdtoaZG8+GvIVjLdp8ME94ZeKdNx49Krb9LjnSI9Rzs=;
 b=AsxJzhNbPKkb7NTAuwb8K4qz2lFv/tCT3AeHrmyRteUE4N+MPrmpn00vc01U9BqW5xqxBrS25M/I3x3pAqGCLL5srhne+PmR3hrTsePXZJRyTapngTnlD0l6UWHncwlekye7qPgVglWlJNvhpGdenEEwEvYEGSRR1C9CgwT+gg7SaXuXxc9iGu91PwJHBD0ApVI6FUnJwPsIF18RSXSH+UqMakRQZZae1F42IYshrcImFprMB1ncykp8GVZlaGJ/eZ4aq0qpDO7tA3JaQnnZUHTkiDj1WG5K+DwdK8CkBGCLotoJaLEpUOYOga3gf3UF8MuDhMpuRRMFIrHMGSlB6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA1PR04MB11035.eurprd04.prod.outlook.com (2603:10a6:102:493::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:23:58 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 16:23:58 +0000
Date: Wed, 24 Sep 2025 12:23:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/3] pci: endpoint: vntb: add MSI doorbell support
Message-ID: <aNQbF/5gX9VXlv0o@lizhi-Precision-Tower-5810>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
X-ClientProxiedBy: PH8P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::9) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA1PR04MB11035:EE_
X-MS-Office365-Filtering-Correlation-Id: f2684a78-f30d-4752-ca7b-08ddfb86c353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DIVoXaLiFY4LCwdMYbjnIS7B/8jPMvexvuA2q6nxl/I+8jLVSRZfcCyEqKe+?=
 =?us-ascii?Q?8gRnx+Kj2808xZgEaM0/pdyr3RhRHuY25FbuixcpXGNIQ3PYXILST16sS6SW?=
 =?us-ascii?Q?EIvNPzAzDWRXcMjgeVCTBmjkjW0SVUIxWpGaE931xM3IAd/yClw40jNoK5FG?=
 =?us-ascii?Q?RW19Wh6Ai+eEXM448KVnpkhtfrhLNYAqCofOS6EVZ3e3CCl1hgoXsijWcSpf?=
 =?us-ascii?Q?pYdYfDdX0of0LUCkl4OMhybTaYIf0ApHUh0EmkjucjMnhyAadbdwt8M9I2dZ?=
 =?us-ascii?Q?mbpdz/24Q3LmS+2O03x/pcm0RueTx9f43gBMVIISjuU2RdcadGy/y0X1sWV1?=
 =?us-ascii?Q?//Mj1IPW9VySBficUqWAS7wZrBHQmC2FLXYgLyB8CetRfYq8qMk8DoNjwhkO?=
 =?us-ascii?Q?YCKaPdTP7XRtW694/q2jbiZ1nwD2TLRk5bWtRrDEr/CTAy74RfKUHCV0VyQd?=
 =?us-ascii?Q?O67yrU/F6q2LYdu/nhcrWS9Hl4p9td2qSJSlt7sykuZuD2peYv1kjhCB5MwD?=
 =?us-ascii?Q?sVQltpNG+FEAtYUhKxGd8jzddidiuoofif6QEEaF1Tcw1TDNT6dglFvSGJu/?=
 =?us-ascii?Q?mSZyKsfvOt09A887yW0T+zUOpAoq5CZuUHLCHuFnrs34LLSKX7fSWQhkuH2C?=
 =?us-ascii?Q?SCeWUErLnywlqBCY6DKWjMtcepJ17eg6Mh+kjPdJwfPsknMcTK/ejMS0JblM?=
 =?us-ascii?Q?hq7ZBdzBN30MZwPC0aJhGU3W2+ym3D7ApVal1QKX0EhvDc7yEZBztJgVIUqO?=
 =?us-ascii?Q?MgM1PBeMFKiyuicAbJOimoGPRuid/8UtQ+jDRSqs1oThdNZOsTTDIJ60Pai0?=
 =?us-ascii?Q?99scgBvrDmr3LOzOXUNZUFyJSK8Pwm8CDHwdtOfG6ryF1WxortXQL9w6T3Yc?=
 =?us-ascii?Q?7Ris7EYAAhhjPr3PWi5hN5g/CEbNSF2XCMQXQlIRBapKQogt+EEaOBVYN3sz?=
 =?us-ascii?Q?+V1NRQGxdopfbLgSPdbs+RwABoHB8fdjtHoPg29r+P66Ergdlglqng7uZEp9?=
 =?us-ascii?Q?h5dMr5VgF7ILM9X0DdvMkPGCXspJfpcbz4dMkg+BffEQH789i2uxK4gEL2t0?=
 =?us-ascii?Q?xWvZeShtmwNKrMu4CYyI4Yw1jy9qI0I9YnxWFOlVhfaoUb/FpibLqnrgRhb1?=
 =?us-ascii?Q?JxDuOj0Vk/J9PWkz/WBJLEaoNOZGz7b/om7M4RlBUj8kNF/x0Pkfwxcbq969?=
 =?us-ascii?Q?iLpe4vwaax5X5O4jNfPT2OblrLbc/5iifZpEJoHbuRPmysttDvpmeVpHg+A0?=
 =?us-ascii?Q?/VcDzbvG75TLQJnUZ/Rs6OynxeDsuCLT/kk3rZbRa5dQLfc7StzNJ5yi7Sep?=
 =?us-ascii?Q?OzR+GDk+JWr0JwHSLLAw33bku4d8ScJle6Ur9vXrD34lkmKaasBw5/Ok+0oL?=
 =?us-ascii?Q?ofBLchiKlpw5xYGz/n8evogSm2ItlfFzSbvhPJA0eV+fASVesSvYXqcliTpL?=
 =?us-ascii?Q?PGAv7mNSwMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8ObX+X+vLQBMYzoKczBIQe3lxsJ+CkGg3f0E7xUmT8MLI/Z9e5j7FCdx/qS?=
 =?us-ascii?Q?yQmBP5lk5Nj7E2nNufeGL0UmHSClffMuotjchU/WDXEOedNiGSs+LiLxGvvr?=
 =?us-ascii?Q?jEqHcOBROUV1rrikECORKaUXn4aV5Ln2dDwsXHYea/7UcESObW9Hor9xxFY2?=
 =?us-ascii?Q?E4fKQWpDY2VBJn6TijqipBTMP+qMAciK2zuE9v8o9uPxcYfHatc3xl8yIxX1?=
 =?us-ascii?Q?wYeWUohUFFgRRtiveHJinem99ySoXjzhmAWz0Ub1YNt9n1klOaDIJiYSlFqD?=
 =?us-ascii?Q?R7NnCJOboYkCREr3lZILkdB6ddcbJOE7bHlB0UXwQsxdKbD5wtjlMEKU/x9b?=
 =?us-ascii?Q?uqLBHxGL+uZ0G6oij+SN76/V9MUFOsKqe43vp9h4Jp8am6gcSX8tSkCWdgyG?=
 =?us-ascii?Q?sMU/7Lt8IjTeWocry6/YOTHNwRgwC9r7rOxh5izwCFuw2/hjocmcx36LlFSD?=
 =?us-ascii?Q?VzkLPE7eSy4qutMR69dfQpMA1bkSifASBYQx5PZ2mfKm2IheM+XHBvl/t+sF?=
 =?us-ascii?Q?OHPXMy7WPf+hxlKYRO4ooNvmq5gme7zkEi25KoY/JzQk6ZIUS83w97NBbv0I?=
 =?us-ascii?Q?qjcl8lDWYlfHs12dLolUucNl/7AGQAIQP2K1odbrM/vjXL1ROYXV0uPMjHkz?=
 =?us-ascii?Q?LaeVhJZO6eFsuEfMLyvIFxkbwYrZ2C2FEPVzpE6c1kKjBEsRpJdc7KmeZET0?=
 =?us-ascii?Q?LOtOYhhx8t1MgD1D4WO908+9Y7eiB0q91WrGGJb3r8ya7FGDd69wHiYqvbi+?=
 =?us-ascii?Q?ea0kYkPQUVCM1rQVso5o3EM1/fSjPEsOIFNbu5owuaBO96/2zYiWFIDc6tgQ?=
 =?us-ascii?Q?j+8EEdjNEzHZ29pY6FtYnLjyt2yagHtWEOsCRtremGn+6TSukHokRnKGeAP/?=
 =?us-ascii?Q?WLWm+OdKIK64O6O6Yyl1xnV646BjuEGVNKM1JREm2KKDyhcDdk03+RpIw0S/?=
 =?us-ascii?Q?guWXcCM6JWrxBtE/ykYl5uyc9Ka2AiyO3Mv7QWXu3P4JO5Z8A+caZn5YXNak?=
 =?us-ascii?Q?Wr5Dm9jxRSEGBz9Apt+mpVaEldkf59r11ViuFVb0XA0QgB0sAOSwK0jUcggY?=
 =?us-ascii?Q?a4/8uKHpv0l5CY8FvH3+Ghhz912hm2T0n8rjqIujE0LDONQDpCEgBM9w0y//?=
 =?us-ascii?Q?kyhWuXu3i+1IL9zdMtvjCpd9TEqLLdqi1MsftVqB7tljTCSom0KALfkU+iLf?=
 =?us-ascii?Q?eTq5kh17YoPX9rhxkfYm+20SBvF/T1nMxegEmAvSQQuo7bVCib89m4BFq4VV?=
 =?us-ascii?Q?AI4Xp591D+Mq+HyJZSgyMGk+9aHwssipOvEA4FxkWINF4nrxvgQMdKni7n1+?=
 =?us-ascii?Q?inca5yaHq/+/w5WDgNJS7I1szlhkM7ntyVUIa6xxLpmY+hFm6ukR1e/zIilC?=
 =?us-ascii?Q?cBsL5gnX46+GkRK/oIUkMdAlIewkfZhDJStjNGRj7DrHjloyTxOG5QgAemkA?=
 =?us-ascii?Q?Us2kj2I2A49QVBpnvc9IsC738hL6axkY7ei11Y9zcLC36EcemyVCM4GetKt6?=
 =?us-ascii?Q?QI/BAwvQwHlpeGPgVMwbG+HUkzitoLKzFUrBA2ISojyfsJuZ+4BSrRS9A9Ex?=
 =?us-ascii?Q?JeQ6dPXc+KGmE/KeTddo+xJQkxlmqB9ZIo6HZ06U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2684a78-f30d-4752-ca7b-08ddfb86c353
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:23:57.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hyq7uuTqpScREjogg4B4jCzzonlE1EMlQvb2jcNu6VKECNqswdkmsdiQbnFziuBLI4gikIDfPTt9SxIsmklqiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11035

On Mon, Sep 15, 2025 at 06:22:43PM -0400, Frank Li wrote:
> Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
> using platform MSI controller, PCI EP can get notification from Host.
>
> VNTB use this feature to reduce ping latency.
>
> The first patch impove epf core API to allow set any MMIO address to specfic
> bar.
>
> The second patch add MSI doorbell support.

Manivannan Sadhasivam:

       Do you have chance to check these patch again?

Frank
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - add help funciton to get bar's inbounce size
> - fix miss x8 when caculate bits
> - Link to v1: https://lore.kernel.org/r/20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com
>
> ---
> Frank Li (3):
>       PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
>       PCI: endpoint: Add API pci_epf_set_inbound_space()
>       PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
>  drivers/pci/endpoint/pci-epf-core.c           | 138 ++++++++++++++++++++---
>  include/linux/pci-epf.h                       |   6 +
>  3 files changed, 262 insertions(+), 35 deletions(-)
> ---
> base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
> change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>

