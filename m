Return-Path: <linux-pci+bounces-30191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5477AE0907
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0133A1AB8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E53085DB;
	Thu, 19 Jun 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRHeTLT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7E2D78A;
	Thu, 19 Jun 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344374; cv=fail; b=IYr9DZXyJA8lnJv1PvwqZCbiPp8JMMzS461DVVMyLsm9XlsUgQOg5RwegzkPpz+YnsupQ5W6+2DIpAvaZ1OI1rdSao0odulPB+EVzk+JMWLnjWDmLpvcBOuG7w3Ly0NYvF9m05Ij0nE6zwCAm6QMmQd4Xhsv4KN8nL7HFSkPmYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344374; c=relaxed/simple;
	bh=NFUUBeZQHX0L+ipIWMilIFAJqvp6259xld5TyV2awOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IZrcyxvHK201eWgXUtG4fGQHVh4PK2j5aOs0Uu8PL0xvhGTTwpCJgkqFvnGDT2dxyPokX6QPq+Dkd9F1RhGR4KuzgsR5TOEAY6/6q2wdR8DFTq3zL5Ilr5EXvSJwp9EeU6PiFoRA5+2ruAqJmuU5GQQDbeBXHeWfbgIRkqDyeRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HRHeTLT2; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHWRU75SlyJ1CGeHo2kfLjCdp5IaM7wqpl5e3IGwptqZSJU8OU+quPOx3B9VkpjsEIhUaMIvp1ND+4158EuU5UdrjCpJBZXKzIDRcYhQdfGnAEBwC8Cg8qWi9QhjNGCNMhVIYIzdT4CH4FuyT3RBKHCsfjavwVDa7jrCkTZ6lwjzhXvCg2kc6bkyDXUenjF4Xr+asdDQJm3H/4LmgJbF7fRSfSsnYoNpaak4C1VYiHEjEBvFnCj0ai8N2J1XE4kM3iqHdsma2KIrgWabFOJp8tN9pXTj5G3pfVoGGSM03SaYFIsuBFZUgtcxgSmsx6om+59eJ3fYa8Qq3IS0nnacPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCr65oFGFB2pxsr+TyMpMFrk4txg0UiykBwVyz/evQs=;
 b=jGv102rWGayQy3NWLpKfDeGcmRHPVmlt5KNOGZlkiIWU5coBRX0aMwvU2PeDogPs/TTBrFwEYY3T4Lb49YKn2JpObit4Z5Gc8XeLXkcGsPOkqmfXHw2fPNGM4HRBtasCniYt6BFfxKxeZye+32GDknvomr1Oh1y/vEr1csG3gQ+nXq/DpKmXFbHUIMY0Y56bDhNwYNKdLbmGSLTBt333PNbjzh2P/Yd7oGwryHN6oSAKN8tV0FaPb8c4wYG+0XL92o8kOOeoCJTa6EdQCxQuUqhcTCDu30kbL2eGQgLF5rR/iQSla9zrkqJdgQTzZB2z2daGZatg48RFnOiLzxTorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCr65oFGFB2pxsr+TyMpMFrk4txg0UiykBwVyz/evQs=;
 b=HRHeTLT2wpNYWdB6J7kHBc2dAI98+wMNTgUq0P3o7TeEnEN3aeidJ9FavSTCwx324teqDozABERzgIvCenkE3xPOB8UycpbjyWj9vIXBmrVJlaHF/S+JPlw87WEkfqOdBXCRkCxuAoZTLr64pA1Ur2vuLGbL1Jfh1J1pnq4KrXv7RrQ9yNOwZi7qepXlK/kBAMm6F4AvMG/Ji2oVkI0QnG+YNsb+XM1g91V9nZi27XCpsuQw+OnW04Hp5s6Sd5skBoFYRz+0Az8WIS4mXPFHbDLFAolNT+onv+DI6BLxp+uvMw4icfKL/JIZuJARhxIAZ8hPGkYyRmPuxmFdJLrI8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 14:46:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:46:09 +0000
Date: Thu, 19 Jun 2025 10:46:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe
 in PM operations
Message-ID: <aFQiqXkR6Uok16Bw@lizhi-Precision-Tower-5810>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
 <20250619091214.400222-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619091214.400222-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8d1571-f8cf-4751-8928-08ddaf400765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNBKUN2ALbQ0W8s4GwhOvg1ab3QeGuemp6rVGtvea3GcHatC+70p4G9UJZCL?=
 =?us-ascii?Q?TDjGazChsDGXlRyh6IVp/QJLj3A5F24V9cNo9H5//d1Chf7vcYEfz9q2c1dj?=
 =?us-ascii?Q?BWhfLvThBwicLA99yCR1UpPNmkUc5W7KFKmdgknvYvJpKUcNZlAGig0uPEE6?=
 =?us-ascii?Q?Pcumcz49GhYxwLMRQy8iS5W4twj7IABTSm9xB0nb8DMAn54UaHkrIQjB6FNa?=
 =?us-ascii?Q?y2am1j1bZN6hlkpmVRzJPmEopS+m1rPm3qHcnC09+VKeET8pL/7ghmxTuS9w?=
 =?us-ascii?Q?pjhS6P4D9w82gtyS0q4i8FZjFhZ1j2bQPPAmLTRFX3gFX9lDO5QQETTe3aUM?=
 =?us-ascii?Q?JYIiG4fCm2E+b6KEJkSWcDtGb502bnPG66toQVLqOrHlRCNeE04Rqtnpj+/K?=
 =?us-ascii?Q?TGEERSpjlT9oL/rITfPJe4zxjQj5T4SLEgG4sIIY+ScT63CeDyZJy5JEJxva?=
 =?us-ascii?Q?p2sEVOLvfc+jGAbAuoXJ/VZVhKNz8gyoqBCDoLLj41gQo0MD/xdB9GLCI+ie?=
 =?us-ascii?Q?pUgbNbcIr6bSHOZS4IruosPQ7LtQzpod9yM+KS8BioGQp6EG4gulyxpguMr7?=
 =?us-ascii?Q?V4/KutaAxLS/Tak0EXbbYCkRp4ZQZ7iuqWD1/aK7uXY34I7P+2XWKuk4yHSM?=
 =?us-ascii?Q?BqC2a8GkPbWc6ipEnEjEaqyjfsbX4b6x+r8nfoFLFKLTgbi/HwkZ1vQJ+eR4?=
 =?us-ascii?Q?39VbZ0MRzEZ2XOKivhAi0w4/2zR0w68ImMkFRtp2CYuVbfACYt2XdUT9GtwJ?=
 =?us-ascii?Q?0yKUVfETk+j1QPdHq87gOirIpdNh+OLF+LJDidwOOTYQrTkvbwbf8d4+7w8s?=
 =?us-ascii?Q?n8oZvYvEsIuZbYDEx5jALQUVTJE39bj5NSvWpeTJeYwKWMaS7Qh8P2c5zBFu?=
 =?us-ascii?Q?r0ZOitNj3tMEJ1ZR1XpQH1MjNZ83TsJehBvVro9y9mpOKy5DaTgX1sEAUGuE?=
 =?us-ascii?Q?RiM7M1Q7Ljq7iso6r4LLe9uVe7p+/OYyxxcqpoVTje4YfbtVg6M/yr34U0hR?=
 =?us-ascii?Q?lsa9fqeVaVZcGVvJR9CozhrJNzKey1oSa3yH/ae0iaGCL3yP3rbZPNPKV1Wz?=
 =?us-ascii?Q?Z4DD1uZfaldaIk5KgOvFPONUozDQ8orKQkChyGAEojoW0wH+Du7OooqGZaFH?=
 =?us-ascii?Q?eL7RZCUJHTrQjBQdiAoAXcmqC78RxGCAaBzxXfqngP5ww6H9GJzLBDG+wpAQ?=
 =?us-ascii?Q?UzakeB+1o8UTm/SdlAFcc3I6bbS4LCkttXAUUqtycYSo8OFHKJC7+7gHbEsh?=
 =?us-ascii?Q?rhiMsx7JpbMxupvbM9EBcFBSC+NHMSOEbUclTaDkXca6JqrGZ10tmvem/g/+?=
 =?us-ascii?Q?bpDco9diyEksygsFxYE4vORcMSYSzhbMgrsA/DRQmV09fFE9dwiF/IPKpPrN?=
 =?us-ascii?Q?/u0rNhQ/yxP56WwRl6kkKGJMJkfg/K2+dQShBW3RXlFzoixXgyWPtIjtr9i0?=
 =?us-ascii?Q?rJN3pXdgm08B8JTwrMM3dgg8lPYqh4bgW1VMgaJovO2K2DCs2USJmFoDgf3c?=
 =?us-ascii?Q?7ITXaNVYqYdwaM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4yRWxkhWsL3y3pWk0wlYr1Bb3ZTHXfU9KrOPflnfQKUEa1yxKvCkk1qDIMh?=
 =?us-ascii?Q?nKninjwJLexgVxmHVbidm2egS/ZRCo01C/qAMBY7Ga1W/SWnLoT9w9613i34?=
 =?us-ascii?Q?jvw0ZTkfXe5DU6WD85+hYdHPvvFZo3q+MSNm4A4UYzXNjXCRA9rqCOvWDgOk?=
 =?us-ascii?Q?Ezuw4nMvocxtAl2+dj1W6JZzHBYlwy9Bc97VECDxvY6s/h2cl13cENNGxtqv?=
 =?us-ascii?Q?N2iCIa97bOZZo+fbS6R6PjMJylrP4SaAk5aW33D56cmtzNKXUwrRr1roUeiJ?=
 =?us-ascii?Q?Y02myRGQ8/oKFa/IVKVscP5JLgq+XrUpEVz7TT0GlofDttmuoglnn5QuEWrg?=
 =?us-ascii?Q?g+nol/AGbLrSqjEVE5kNKXkQFe7cQvOaQTcG3sZ8pqaxc2d4ulb5nOw907pN?=
 =?us-ascii?Q?oe5ZhxqmH7lfU9qqDySOAcPZOsWnd58jkaTJmkL1Imm4TJWzOH0x/5qg4Fuf?=
 =?us-ascii?Q?ePXqNN75L/F2TWUm+vVc3LX0k05MCsmsGJjMTkOBmllg5gV8kFqFHDtwBW6T?=
 =?us-ascii?Q?MlagUtKkE8SEnmksZdZkT9RyE2vinrF/yo3Htf0wYDfZrcLl6yfEUwyLFNQg?=
 =?us-ascii?Q?TPafQibnbPCBVSOVn7lrAjAMynj5o32FbLHkZ//Vdgl3tVXD1oqMyp2Jlm6a?=
 =?us-ascii?Q?9iGWdm3gr9j92s+cAeDz4PhBO4PHGOfDjxDU8KGIqsLLZAu8weJ6o/7+ogOX?=
 =?us-ascii?Q?sU2cJsqO2ZsR6Irtsknxqs+lA8wZ+WEHc6pi3jFpL0FKeOOVjEKdC3IF6FuG?=
 =?us-ascii?Q?ILp9M+CrAPB2Y25QnlNvuzNG25/i+xngaIDRClWktVmTX2be5FV5c+h/E7MG?=
 =?us-ascii?Q?QE0YJ/tiZS7V+kBSSVwg69th+fS9tj2BdXe9vQloASSMTwPzUHFh0D8EQ8Gu?=
 =?us-ascii?Q?Kdug7bWk/LYvoeSoevjDzpH0lRkAjMhb9CFUsHSJL3F9kMok9wWw+FNKO3SM?=
 =?us-ascii?Q?Y1rPJtJ3CdLtrTFya021puU6bQpHAUMnWf4UEk7xduZeKrWIWUYpKEw89bHe?=
 =?us-ascii?Q?pSkeMRp8xnCRghdOHil7nB3D+w1k36cDSNeSl1Bep6I5zGDjh3ss9p/Iwip2?=
 =?us-ascii?Q?t1EkAl8BwQcFGE1k4aLLroGPkGSFY3KEdWGdh1nxoEtx2cEiaT2Fu1qHrml7?=
 =?us-ascii?Q?R7i0XNHvoKvExOD52rLUnmfw1XGFocx3y5eIqHtET/TcBrMWeNuZaaY3i16C?=
 =?us-ascii?Q?SFRIWFLVBsxE4zQUerSooUF53iNm3+xorMqxsT/oEhH5zo1NGwwVRT2uEVUr?=
 =?us-ascii?Q?V9ihaBVqm8e1XyfcyI4pP6eQg0rWWN59k3rnBoS5M7G5YOtBmqPuhxjbVHS9?=
 =?us-ascii?Q?SDuTcBG5sqWeHfTuUS8U/X3W2cQ1YmTlWgdcUMfERIcTM+gGpNThWiw9S5zC?=
 =?us-ascii?Q?p6aCu5+wCRus8nlkVL5DrIIt0Rc5Yrja3eZHO5sa/xIJM4SS9s8HQwJwqo5S?=
 =?us-ascii?Q?4qZoifwHC1yC/bXeVoX93hIPK7W/ZZYZ+44Q+PWMaA2oUFMdcqxMeXqVLqZT?=
 =?us-ascii?Q?CcFOOkfdJblgd5stI2OnaN/JM2os6d6OB9/6NYlu/yl2nN8rGAMd2rfLH0s5?=
 =?us-ascii?Q?W2OYFqLwjzp/7hEoHalhiYmeUXShIjhiCdx3x55V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8d1571-f8cf-4751-8928-08ddaf400765
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:46:09.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uv8jrLfBez3i4T9numcpbH4Sjovf2yRdtvoSuetD7EHBR7FNfr1YX50bB7zigE2neiSXzaGxatkIhPaNTNR0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387

On Thu, Jun 19, 2025 at 05:12:12PM +0800, Richard Zhu wrote:
> Add a quirk flag(QUIRK_NOL2POLL_IN_PM) for i.MX7D PCIe. Don't poll the
> LTSSM states after issue the PME_Turn_Off message.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 8b7daaf36fef..f084a9ad1001 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1851,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> --
> 2.37.1
>

