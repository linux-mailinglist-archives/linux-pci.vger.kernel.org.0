Return-Path: <linux-pci+bounces-39964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B36C26D28
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940624E8B11
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38D315D41;
	Fri, 31 Oct 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ezr1nzmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC215314B85;
	Fri, 31 Oct 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940135; cv=fail; b=Q04YsVtC57diYJMhvp5zm4D6xRZlhMBL8LxoYXqrI4I/OXUpkhXjirwAZfNcqIw86HzDBVimOW3lw3Fub9vUs6wpK3j2Gpcw0usmiPz57yL9SeK5zKHhEyRhH3JYwR3vX8bvc6tFloeF7tYtvLaSESsF0H8jtmPdjlWmulHIYNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940135; c=relaxed/simple;
	bh=Lix9tBEg4vLueVMEd4g78CIzjp7RRqsu/ZOXY1zzG3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VwWvpa4mJOJLaQfZ6Ni9axXggtSEUPadD2wNL2bPOX35dCWHBxUCgwg3MPqAOA3QhhWSVbLS41a19OdcfAfifxg62eXShSJv1BArFtnZMXa9u95J8MBzuLY2d/u/zkl4F3qrlLTOTQTDtw432yjbEVoSmBACp6pEw7CcVXmPMrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ezr1nzmY; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkLi7EWl3ZweuxCOCgzoMXNdTSx1hp6A6LbLcT/ErouDE3/r7L23+WBS2cmu5Wi+UwjBnUnKO8QlOCf/w5KLvUG6z6tIV5mEuE7kAAqIKyxi9EEtnj76jny3/mnQ9NXv8jO8OkMEnq+ioFxNNJoA8xoJ9CMV7IUA6od5KlphUz5Egc7oAMZa19xEbXsCfb/lL5RCvGTKSlCeMBQtFRX4ciIsok8v8sSpYI0i3CoimQwaYnHvNQR3vhWFg7QDv2UMcPN/fJbXFXsEK4EUyMex+LMWWPP0Sxvq2xZF5H+DjaAzoYgvhhlXYWskbnBqxh7hBk5eiLTmUpjiEpYtWcaX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jxpvOUKxbdNT8FJY/uxWfhGAYZLECGEQixyRMN7w2Q=;
 b=C6sjQqiz8836zOqHv8FEhuJq0JfIVTGtQnzTnyEZMs33FH/ybOx/eONlWl1AyGHg+xuo5P94hzn6LGmW9OPo72osoZ6gZRwOxt4na2mZDP0Rdpuy0qNQI+DMZBQ+4GlkmrYFO6EqSmy7dXx5cT/0gSY9z8I2L8NxRfOb4m+1qPEr8q/dNhb64naeFt/D3hrBPGBt3AjxqQ2T/cKs2bPqp06iP3clF7PiGa4oJ+ohCbFtshtxUY9BF9j4mYkjkqWDUs5cfYTVxA1athWWISqvUUbBsf/MAArfNQOJiLtL/rpyAJ27i0NjBONKw99fDzqEt4DkZ+vOgj313+lL01Bfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jxpvOUKxbdNT8FJY/uxWfhGAYZLECGEQixyRMN7w2Q=;
 b=ezr1nzmYUM7tsytdP2Sy+6V7jaqfD4RzVs1CUI20Mt/2WeGc7Y59/oeG+949kkuUG+joDUDfIkBpAuPVM0vq/wOArt1r6/pEyR1+g0n5gpJhqIFG3PqreUHHnp+pMf++KBBu26xufwmMxYyj+x/faaQ90vZg5gUSIVNORGF0qqimfD///+hZlWhxcSJ2c4ltzTOde6zuDeiWWOr6leFxLLrNBUEHNLlAVHHyxgxpCZMG2lxLEO4o1sgDyVV9Jw3/mr9/jo94J+2zDaqb7Nm3UXus1fWpISE79To+OFAGY9buqWBLp3dsy7vGKwgg3UEqaY6vlg4IEHLOndfczAwX5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI2PR04MB10090.eurprd04.prod.outlook.com (2603:10a6:800:227::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:48:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:48:50 +0000
Date: Fri, 31 Oct 2025 15:48:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/11] PCI: imx6: Add CLKREQ# override to enable
 REFCLK for i.MX95 PCIe
Message-ID: <aQUSmjPQN/iT1HMB@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-11-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-11-hongxing.zhu@nxp.com>
X-ClientProxiedBy: CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI2PR04MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0d2258-17e1-4854-9a65-08de18b6831d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jrsAW/dV6IX+KY69zebB88Dbp9a0c31CiHYEIASxRvQZfmL0U2K+Pm7LaPp?=
 =?us-ascii?Q?zGjMY014mTB33JZitFcli2Yt3PK4KyUQJDB708xKBUlFVRCPtIwmOtPl24rS?=
 =?us-ascii?Q?HonyRh8n8sZbq5RwYdzRx64uNoKTtaqeAVVV4ShZecRSnLIqdTXkNgkxsSVi?=
 =?us-ascii?Q?nr/rsVfScJq+ILjk+xibPaFVFLoDsKjGWMAUbUQtOA6sPwegmFRynBHbzEB4?=
 =?us-ascii?Q?YzSxOl+qquLZpn5nvRSiEakLiTawKsaB8vNK2eaYkvfGnINwfmRgwuYiU3Fq?=
 =?us-ascii?Q?XJ8lrrwjExIVLnhThaMpGkuJCRKaNFW7WhzJ1qfGylNqJydErdQhGTVcjWWP?=
 =?us-ascii?Q?06MgwJEEbcl1xsG4OqxCGS9jNihplSno9vPU6h5Fjs3JKn6UyaIeBr2S0MRm?=
 =?us-ascii?Q?72ATtn+1MR/tnccmNLX3qLib4tRI5lQ14p6Z0r24gxg5+8j+SxyJt4OKe8e0?=
 =?us-ascii?Q?frAFkau6Qd78STNMG+v7SUMBdFGAA4QVynxAspLZA2sYm+0gDn8+CjsffBZV?=
 =?us-ascii?Q?DREtbX6k0/NMcd8ynjve5m4U30USRkr0RGfV7s5+E5ymTRw3TKAeJACMwYMc?=
 =?us-ascii?Q?gWgvuO252AIsc/obth8bFrQq1KtFHLLvwzikCUbZmaLAp2NOdLMsaToAuztI?=
 =?us-ascii?Q?q8yB6aGhb6RW98rolY3d05nMjKSyrhgN+UeVGv+z0ppbfD6/BJs9k0ky1VwR?=
 =?us-ascii?Q?nZNvvp7uZrkc2x2cZTFgLFlB7n8f1IO6OXgfrGISf2jdD4Vy9zNQQXiZvrbA?=
 =?us-ascii?Q?OT6LhOWOukl3BcVFTzLqiftYFLSB8MAzikrgBF+qJmhyzpjBGKtpJ6IL7YIu?=
 =?us-ascii?Q?tPubnjZh0q6lHNiFKszaaVgCcEm9xrp4JHcaxfDWbOCXprREe4+fj51uxY6g?=
 =?us-ascii?Q?CnfsbAiqKFz0UwYEw1kqGEypRwhhGZJH9XvpBpo0ipyuzRBWwfujw+pE0Nmh?=
 =?us-ascii?Q?rdaSJUBzM/6TsYobalIxIwLigpjKA5dsHSkeH0K9PNZOuiDn37qhuSadEEpu?=
 =?us-ascii?Q?An5KOiv5RzsCkEx3NMZvSMba4GXldV1fabrHqz8poM4xtXQGlmXCzkIdc2Ch?=
 =?us-ascii?Q?C/c/yQJr0OxP2+pNwU/TMKOJjOZkQK7pfl9X+XxhkZlQzS/OLAgGB7J/ahNP?=
 =?us-ascii?Q?jLtiELwOINuLt1tixBYczztxXva0nAeMo0C+VMPRe7yTzugfuGuplt6MWqES?=
 =?us-ascii?Q?GvX819q1lA+JHabpY9slNvYMPs+FSoNES6P5WBYkdVGLW3Pc/SmiLigBSZ2j?=
 =?us-ascii?Q?3GebPMeYesJafqzfUIop7n+A3gLIbiMKOH0izlK+C9W7ICwZK9oUgv9afqED?=
 =?us-ascii?Q?s/FPfTooJhJ85Xz/5qAUx0WP3lO/BaxOJBx0aDyjxsICPXIbM3VMy6C8gq7z?=
 =?us-ascii?Q?yR8nhakIFmfj6FxAGweEqXoVJ0pi2ciJbE/YKZKL+Lxcl1DIkpKO8OJfQ0sj?=
 =?us-ascii?Q?teadhE+Xj4fYtpDAFuh5YetYb+HanIYquAYOS1QOpdUW9OjdtbMxHHXZxtHO?=
 =?us-ascii?Q?5rEmUTGKIQEAUNJiQkqFPtGmI1tH8jYrCubs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtWqEV/2zeU1j9wcw8RXnyKc1t5ns/tJtEF5TECrZWYLc2IRlJIuSk+2KtrZ?=
 =?us-ascii?Q?+FRSVNmnrr4ZZhO9X2YL0RX99FrMeiiLspsVzjIg9Wf0LiTRojLK/CP4aaVF?=
 =?us-ascii?Q?g76eUdF0IBig0SE29poxgPdznJOL/MLGmNAaddYJ+fqvWdA0EF7TuSVMTem6?=
 =?us-ascii?Q?pD+RTbzt1juHnN0GRhGaAu6dqbk/U6H/zcfk34T25xQH4ox7ghyyCRsP+iWK?=
 =?us-ascii?Q?ikQ6z5asNNOIBYTnZSYF37Zug/iw3WLy+VtxWEPUfIeO1FC1CuYeZm/sHeTZ?=
 =?us-ascii?Q?fAbyd7C/hwUFGidhBnDfIIh476uIFBz6OYmLq7e4+MPOvjTYdUA8pldyl0iI?=
 =?us-ascii?Q?Nf3MkuWaHcqlURwzj/yKzFhPiNZ/y5YVkWknMSEu0n0UxQeHHE2P1QlZ7fmd?=
 =?us-ascii?Q?0Q9fb3gO+TbCDPVb6K9AoBc20o6BKdrGo3LRm1I4PYg3yR7vlzC5YfavlOP3?=
 =?us-ascii?Q?LRQcT5hW9tZByP/J24JMi2mG8gzBIi8I3ei0YGT4bIZ7wd98/6mnTOSlLgCu?=
 =?us-ascii?Q?XLREsU47B1rhjLFAg42pYCGN+J8uy5jIRJhlZgPwh2iFI7CQ6PioPTpbOm16?=
 =?us-ascii?Q?lo5Bt++NlptCJr8P4gT6V5vkheeu4OxcUZr1/F9sHIcPDrOVfV2iE5uNzteM?=
 =?us-ascii?Q?teUaDW8ZT+A25LWwnFYg9VIPDbLqzbxFubxI/UMvQ2qDjyiKr2Y+3/uG8oqC?=
 =?us-ascii?Q?Txg1/zCb8QnjArqj7NOCP8J7bb7/olfP6qgLJc3qCseO9HDV5MZBe9hbmmuV?=
 =?us-ascii?Q?ymFbaOujkbSev42/f8cK0FSjI+5ciJRqOd33Fcae6aQaBkz9WVy6Rw0h/1zl?=
 =?us-ascii?Q?XeynaZSL0DT6H+I2VS+ynB38QK/IRnpkQJoYqm6szWoP2hyz3sU5TC6gdpFP?=
 =?us-ascii?Q?h5Oa/8aMjeWzKgyGfJeJehNEWlT3kXB4NRYQ/Zvsm4JN1BzpkFjnspXS/PEZ?=
 =?us-ascii?Q?KySUrSO/dWEJ8HjZEy1EREkOzY3qwp7WoBjhj1b2ydJYLspzSzF41LgIEFch?=
 =?us-ascii?Q?LbbkNHWxduPtvljBLR58bq/DupO7lz+bUFjs2Vv5vz6Tvb4wzXRpHftZQAEx?=
 =?us-ascii?Q?GUYKWkXdSOX8C0ifN2wSH9Gg8YKvTzq+xL8SGGL93zqdRWwE4nBhS0fzwOT+?=
 =?us-ascii?Q?02KZtmKFBqy5FzPMGaYMH2C+u0LfQLvOUOEWoOtz4h0dzLwXnEisQhzF9cqH?=
 =?us-ascii?Q?oVg2HLyJVzkpD8OuA2mFha5a7biahJGEYvSseg6Eg9yNBpzj8hE4Tq6Pqnb4?=
 =?us-ascii?Q?P9aVuwABNPkK/kpPUYQmzPS2LD1FhSOzIdTNqbW8DiI4ynzrEE2qNksLW4+3?=
 =?us-ascii?Q?wludAX9enF0lbBiQhCVRe954AjXVVTvb7SXOWw9jzPRS4DrT5n7s1mD4e2Id?=
 =?us-ascii?Q?PRSz2fRV8ieqfe/IGeBK+McZJmT+x3gcuq8uzbasFzUd/SAqtvIR7Q2I5Scp?=
 =?us-ascii?Q?LSsSAKuYwsR/txhPFAsgitdySgM++BgqmzY4JXvODXNndyLLPrGk8489nqRw?=
 =?us-ascii?Q?kPK0uUtxfIi2M8BQbweECy9xuWD45swc91qu6aa30EH8CjXxcRk6Tus7WsMp?=
 =?us-ascii?Q?bx0CbuGpEzdMXE7h50M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d2258-17e1-4854-9a65-08de18b6831d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:48:50.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj5DucpgFHNEVX2sxiaLYCmzxx8FFtZ42kPtWPXO7Maxot6saOK7634C5NVmD+ONupD5RnxxmCH/Fqy5compcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10090

On Wed, Oct 15, 2025 at 11:04:27AM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock. It's an optional signal added in
> PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
> reserved.
>
> On i.MX95 EVK board, the PCIe slot connected to the second PCIe
> controller is one standard PCIe slot. The default voltage of CLKREQ# is
> not active low, and may not be driven to active low due to the potential
> scenario listed above (e.x INTEL e1000e network card).
>
> Since the reference clock controlled by CLKREQ# is required by i.MX95
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x the scenario described above), force
> CLKREQ# override active low for i.MX95 PCIe host to enable reference
> clock.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a60fe7c337e08..aa5a4900d0eb6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,8 @@
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
>  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
>  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
> @@ -711,6 +713,22 @@ static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	return 0;
>  }
>
> +static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
> +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
> +}
> +
> +static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	imx95_pcie_clkreq_override(imx_pcie, enable);
> +	return 0;
> +}
> +
>  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  {
>  	struct dw_pcie *pci = imx_pcie->pci;
> @@ -1918,6 +1936,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> +		.enable_ref_clk = imx95_pcie_enable_ref_clk,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> @@ -1974,6 +1993,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.core_reset = imx95_pcie_core_reset,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
>  		.epc_features = &imx95_pcie_epc_features,
> +		.enable_ref_clk = imx95_pcie_enable_ref_clk,
>  		.mode = DW_PCIE_EP_TYPE,
>  	},
>  };
> --
> 2.37.1
>

