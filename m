Return-Path: <linux-pci+bounces-29488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66456AD5E74
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB347A3E11
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31238221567;
	Wed, 11 Jun 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFLoJhOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB208380;
	Wed, 11 Jun 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667395; cv=fail; b=KxXyHtAArQ0HAFqBmIZ45r0iaP+vYk+SXESMzs5/9Cb8idN3ZoqtOiwWbktk2rxfGLUkaQGUK78HpogNl9ck1M1EQyZzsd48Xt24I67gPedp0fzUp5d2HKr0h5+B5b5e4ywOh0oIJxfmsu7FKH6+iI9XSr5uRKJ2WXxr7Uve+Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667395; c=relaxed/simple;
	bh=85EiemqsJhQ0ng3s9OgXhmhX3x4iFAfSUvlJK5KNzso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AWQt9GCPGulUsE0mb9XMRBgr9N+E7B+N7v2TeCex2u5lHE/BAEhCAW7PUHjYxE6tJCen3uZTzdkqiy3RHGo0mBPu5bsP3/4e0jFVEtpYlG5KJy7iPsmTS2c2N2q11T42YMa1TPUHrOBbyrtrbLjvOGyNOlJmEq7UbwKWzpKXIwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DFLoJhOD; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUzDqYZELbD4hOJoNAmbraUzxYpTgZMVPRQChTDa/xIbcbe7AKbHa6Avrbq3tIvKPgzHvDr60GgBw3EvZj5+welbBUwIxG57rM6PHtlGgtFN+LkF7aYwdnyBmUWRfA2czbxLV9xvg2kdor4WzQ7PIr3+dNPw0mowSt6Ulj9rZS2u/2ohacECc1bs350LD6ikwTbIvJK7/ukOX6B9N95Ik7wPBuZu7waPm2PuBou1hHwMx3jN9dIS7tRUcTXKVkQzgobLMLuGhtqgtxB5JTkBTTACHglRuNWQ+Z5vbMDmzDdTQOujMZSLMjelmNAFsuDigy6kaf3SS3+hkjDp0pe/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMYVFFDFM+iU+redkCmKMMjvupmMQTZIoacUUXfDy9I=;
 b=H//TieUZ7ocYLf8eFjzH39lTjztdcq8+T1LCxPdu41efFq1FOMbyK6S75CgZaK4uEA/TZD1ExWpbk23jlBJgt0m2f+7SYFCS7XduyUEsU9SAQEJWCw95xvO+CFY6CVj+QrkS95mstjdNPmLTXF29qj2/lTdImGpWTb7YNOhewUEgDK8gbAQ1d7yFhcWbJtkFzkPg5MB4GoHanyfjpALTe4CrS3vPRdeeP7iblk3s7gd2yw66/2g4U3RZImiFBbcy5HJLfLHT8IboSiTsaPpYUpsUCvNkam3huv0eE3/0lJK4MMTRuJqQDPSkgPZqn8ZMhrTdodb9VS2y25gEeXmVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMYVFFDFM+iU+redkCmKMMjvupmMQTZIoacUUXfDy9I=;
 b=DFLoJhOD29kdM5g8eQPpoD/jEB+dabBljQuoQffTEx9xiW43sBQQnAqL1mmERCxA8c6ir/W1fK/pNSOof932379cepe2OnIiqMgsT0pPhwDqtB2tGnayFlOvlgUsuMRmycUqTiYv1SoizPEZd43CVQYieHnnf3Dtq9IAWfl66qbJ+ucibOpqd1VEejg0WfHRXcmA04f2G8YyHJroXj5mEuFnw43nfXUqXSaZlqwsrdvMlKDP1QVdrhvADbJsvNXXzGoTNUp7uPVCOWBt7QTXk+EJzwSAEKCvOTdhKw2sVJ/0toDoh4NWmZdAhOYU5x+U5lusUGzNbh8M3bqCqCn2CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:43:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 18:43:10 +0000
Date: Wed, 11 Jun 2025 14:43:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] PCI: dwc: Refactor imx6 to use
 dw_pcie_clear_and_set_dword()
Message-ID: <aEnONwJUSEMdMAUD@lizhi-Precision-Tower-5810>
References: <20250611163121.860619-1-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611163121.860619-1-18255117159@163.com>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: e1451076-b5ab-4cf4-21b5-08dda917d076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VK7rLw8QjHX/y+x8suhC0TgX+EDRTHN0bIIFKfnLMuucRIk/r+gxKxzeDdmE?=
 =?us-ascii?Q?9jPhNpb51YyQ+ASQd+OT4BMB0lPH+aBcinB544aTP0EL4mwCTvpoJ1fCPd8p?=
 =?us-ascii?Q?03DhaoLV/+cmEmN7dI3m38F4oXZFldU7K/ASxFaFGR8Baxp2AO4Mff2iF0hb?=
 =?us-ascii?Q?HOZaddGUTQL1Dl/x/oi+E7bDE3hUe8GsA5T8fN9Q2hIEqftAhVJhMt+EoYxx?=
 =?us-ascii?Q?vZdItc/PjOrMTGFUI/LnC2PhVJ7ahMv8Qca/DTpSnHfuobbw6PgAOrIsFF2U?=
 =?us-ascii?Q?HAJppH/t429ZHqFYGavY3OVPB8F3MBL1sVbI+hr9IKg0Au+fucQTGmcqfvq+?=
 =?us-ascii?Q?108AEpeZoD/gTu5D8gx4k0DiCPEHeIRhxoCUdBx+RpDmHalLtpiiiFKV1sUJ?=
 =?us-ascii?Q?MZAx5nVVbYQm6tqkDkWdPrxKTSWRaqF3b0NFnyGYhCq6/9jzVNS6Jzo6BRDA?=
 =?us-ascii?Q?0MwqwfeQZy+tp3DWzTB6Ee8eEpxxRYRNMi53gHQyml4F5fF56JirluTo5YPq?=
 =?us-ascii?Q?gHXnzQwPCiPbAN/zz061lUUk5LBjCzxr4lTSvwQp0kyNLl7bQnNVPbkpfOA6?=
 =?us-ascii?Q?2tSxK8oBBEs/j8YdWVk5JZqV0ZYDaJa6X1o48N9vtDNXgrUUxXtf0eLJ/WEt?=
 =?us-ascii?Q?+ZJk3Uv2SciN1v5X0YXEPLxLSwqf7P0L5c2jOp8Ylp0bG6tW977iI2S9I+K6?=
 =?us-ascii?Q?kFTQ9leJiKnaWaNKqI19PfZ3BzIE4yYvlZxd0/wqpkoOuMuTI5qHdCEQBDIr?=
 =?us-ascii?Q?A38tJXt4CzHwgWqGGsEnas3XUIZHwaMCQETseTxSNe5zN9L7dnQKnL5sa2+E?=
 =?us-ascii?Q?JMDL0IGd+Mm0z5cp3YdB99CiguTkKnBerxea8VBXSsm9+6Oapu13e3N2yO+9?=
 =?us-ascii?Q?sWqt3zDbYcIiiFfJKIhfo74yCi2+fYGvyFZnyLTxpiB6I+3PFLcJC8RwDpej?=
 =?us-ascii?Q?9oHdKYNQ+4Mxn4fT4Lc47aSW1Su4FpXa7ZzkOHzgsH01F7NswUR1P6s7Ub6X?=
 =?us-ascii?Q?vLd8gc1KNRAX5Cp7s8HY9tKgVhb6LPm2UAkXQlQe5CpT87Jl29fxqrNgI86Y?=
 =?us-ascii?Q?nNa0A03zvVZL1XZBQhf9S28XhgCv/FfCWHc8/NdnChPGGzGV0QZXKxgbGc1c?=
 =?us-ascii?Q?w3ay60YM8Vvlg3iAIcqmlQrlb4D+d6xAuPyjfy68GTlaFjiwzMWjxdF5xCN4?=
 =?us-ascii?Q?mqshOZz7DsippI7Wip4lwMBwlHBfYLqhbwoRahPx+Z3w27Eu7GQ+PQrsucqN?=
 =?us-ascii?Q?ngoRTDKbcBduQBsx5Gi8pDOnxPWG+8KbItN05lCzmLoN3f1hqMOW60xLrRKS?=
 =?us-ascii?Q?bN+pyvAOO1/qb5P3uqZkJIg5mfasAO7LEds3vf1QpyVOR44Z2C/Bralsl9w3?=
 =?us-ascii?Q?RupBzradk5L16VJVVjOD3KnUfsvkFBkC0k0uQmlsuCr1JerUvPKoWheXeq1w?=
 =?us-ascii?Q?KxB5R/C9ZCxbPj/ktU6aFZqsXig0Fcs12EL2Wwv7RhmvvKFz4BqyWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?igp5sflXOqma5onU3JaK8x5GLIEiwWEZ3xPdzfJlAoenNH26X8HtiKBP+BIs?=
 =?us-ascii?Q?6F/hZ/TksBfT7bBHJHMSVxpRyx8h5QATwTDMtMNK0z5oB/Y2JZQCUxUyOlLW?=
 =?us-ascii?Q?v3yxxLCEe5cpu/a0YdsTYjJO0z1ecm798vmOHpnq55xe+tukL2lr00hOo+0i?=
 =?us-ascii?Q?h8hgNUJceaYG9M/8azvzjYJl7yvgHEmz6MTSRbmCA0K5BDFpsF36RUMcIG8S?=
 =?us-ascii?Q?A0DenPflev6klcz62Y6fBwetkK2XgfAS5/uz415gPwkhVhotSA1dTTLII7DY?=
 =?us-ascii?Q?JI2deGmXMM3CbqTi5wTp3/mmKWU+49fqkU1o/L9F52eos4hQzGogSAt1hz0i?=
 =?us-ascii?Q?eOp3LEW356eNv8z7DlH3/xWYWfhAyy+5oMJ/RoogS9IBT6Q+DCBorkaXXwdp?=
 =?us-ascii?Q?Nhyfy9gWuKzLM8/WrozwMH1pbQ8dABGoF2UgRu2XdpbsNbnAQCQPXLvJ7Tt1?=
 =?us-ascii?Q?swg1JilraGzf17uKvNG7KCZzCSUDHFmB5gNbFcHjzSE4PbbzvWCzcwnUV0/r?=
 =?us-ascii?Q?AsegtaXxj3CqPE1h/l8OhhB3R4wLswl7J9z4nZOUJIisq4/DBiVH+ZrW7znB?=
 =?us-ascii?Q?DT765ko2Blrxb+xV0vgSPYzHQ+Whn+T8SuKbATiNnpi6qFOxECoMPgqYfO//?=
 =?us-ascii?Q?7V+B2wQzCdsqCGD58fvc5BdFyTCHpj+7icNf66Hs5sDPstYaTgQ4mn3358+l?=
 =?us-ascii?Q?jQ0rdONzh5p4/+wKzyHaDMIVl6grO+0xBG9yL38KKbq0YXuWzXN5Tkewe12z?=
 =?us-ascii?Q?R1+E0XsNF0ZmXLAzS6T32Rg+OevL2IYWEcJfPW9zFZhdnrqEvtCqBSozqUKf?=
 =?us-ascii?Q?GwdC8IqfmL34WTwQGDT6dWTpr51MUcTnfSfG1plk7fFtI0gFAfaaRwSKak59?=
 =?us-ascii?Q?wKhwJf7/JDPOGKIpR1/zUhOstNDNlq+AhBIMtRFPIplbIfEPK5F11prH/Glx?=
 =?us-ascii?Q?57G6zRjDxf5rKTuDNLKDJASVeQwDs1J1uen8/1lklAaVXAlkSGwLBCUJHfCz?=
 =?us-ascii?Q?U8X9xf2BMN6BDaGDTtQo/vQCwwXLRoyfISya1WAwBrbWSwXwqYBzsKS7KEc8?=
 =?us-ascii?Q?gm9OzgxbulChAYGMicTYLISkDIZfO0OTt3vU6/L87xNKyIVzJzMC3MsGCz8y?=
 =?us-ascii?Q?y4BlLt3QHggA8Ph4UH1QeJAPRs5I/UsB367UcscgiYRafJnj70U4f67X5hcP?=
 =?us-ascii?Q?UZDSlUy36bey+7a8mJecDqwKr5Cd82cyucs3P7F/7HAu1iOYInjVtJtfhJmC?=
 =?us-ascii?Q?FakG0knJddDefxyK4tPi/Uejs5j3P8HYb+9edYIz5ESEJzE4taeGgllap22P?=
 =?us-ascii?Q?ZvfvhDSlqlx/bLVihDzyIhKWcqMG3ve/aLwy1VmYOTcqkjV2duvcc0SOkOWZ?=
 =?us-ascii?Q?oeDp+Hmbg8YZFbJ/rYgl0FyJgcp+FDcMwsnvVl3a1JwY/kMtlDZ2heOugCxV?=
 =?us-ascii?Q?FWaJBiVl2/4iUp9IhqEsqxFcinScsxFuF50hw8zqdVyvShRahD5NgnYgor+y?=
 =?us-ascii?Q?XM378oCuFNUmM8jDXszwv1sG59T+hukZi/95WHIZN48J+T6N5bgEv0sB1bKh?=
 =?us-ascii?Q?vig86jvikQfunQ8RrU0hF9qsgt1nqsl3+RAb0J/X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1451076-b5ab-4cf4-21b5-08dda917d076
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:43:10.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzPgqafyWPZJjn1iIyiFti0FABqHGqK3DawoNg8E3ByU+E7dFLVLxIh88NX0lVNFdpmsM367C3OCKzO/BKBfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Thu, Jun 12, 2025 at 12:31:21AM +0800, Hans Zhang wrote:
> i.MX6 PCIe driver contains multiple read-modify-write sequences for
> link training and speed configuration. These operations manually handle
> bit masking and shifting to update specific fields in control registers,
> particularly for link capabilities and speed change initiation.
>
> Refactor link capability configuration and speed change handling using
> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
> by encapsulating bit clear/set operations and eliminates intermediate
> variables. For speed change control, replace explicit bit manipulation
> with direct register updates through the helper.
>
> Adopting the standard interface reduces code complexity in link training
> paths and ensures consistent handling of speed-related bits. The change
> also prepares the driver for future enhancements to Gen3 link training
> by centralizing bit manipulation logic.
>

Sorry, where define dw_pcie_clear_and_set_dword() ?

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..3004e432f013 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 tmp;
>  	int ret;
>
>  	if (!(imx_pcie->drvdata->flags &
> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +				    PCI_EXP_LNKCAP_SLS,
> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>
>  	/* Start LTSSM. */
> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= pci->max_link_speed;
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +					    PCI_EXP_LNKCAP_SLS,
> +					    pci->max_link_speed);
>
>  		/*
>  		 * Start Directed Speed Change so the best possible
>  		 * speed both link partners support can be negotiated.
>  		 */
> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					    0, PORT_LOGIC_SPEED_CHANGE);

supposed 3 args is mask. 0 should be PORT_LOGIC_SPEED_CHANGE.

Frank

>  		dw_pcie_dbi_ro_wr_dis(pci);
>
>  		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> -	u32 val;
>
>  	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>  		/*
> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		 * to 0.
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
>  }
> --
> 2.25.1
>

