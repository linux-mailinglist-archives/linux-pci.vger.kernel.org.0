Return-Path: <linux-pci+bounces-39962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA41C26CE0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA6352A98
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666D30F95A;
	Fri, 31 Oct 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qx+0fRjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B6308F32;
	Fri, 31 Oct 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939666; cv=fail; b=rEMFceTbRNwp61uTrkUl/9sgvS12shsCr+FkmXE3E2TLpVdtSL2yFU+nDb89i2R13UY7vJYmFE57WZxVC/9pqGNS0T2kbGA/uPS84GI8aXU2ut4jATSNWl0ulmmSnEhTRiT+vRLQ2P9tbmFsGLxU0txeWcA1n0NpSVNqWuD8sKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939666; c=relaxed/simple;
	bh=NiiJxjZ/raFxaVO7zrgqAx0HDm65w42uKM1L+CzDjSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fohoFa67BclxFGGSBGItCvRMt4XaAxD6oxloTkYPlBQbBZDeVeaY6M6I9lc7uw3GvtcM8Gcm/xZLG5liVqKFu9oN88QWHpeVxNhjn7pGqtJp77QVAM7CQQ2PdBXaE6ENYFsLv0MB8Y+ZkhLTElUOkkSJDAhgzs92wpOLebdYf0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qx+0fRjM; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQXpkHGcEdHiCCP06ksY6v6pgRtp/LDJaoTgp4mmKz4HMD4CwMrFBu3uNl9WO0VdgapFM/ZKjqD96af4ySnq5PZGANDzcmO0uL+xLA0R0+ykD2S1VPZVLiccLA4RXp2hGRjpnmaAnjJNGU5+mV1PlBuZJ/iC3HtVYme7Dq10qy0H64lGM6ZBPu0pLLn0qi1DOKOYEdiOAV20+rGpNI0rOKnq654yya3DXW3sBbjWcPkx5S6R9m5ZCc+Hx1V+GsxmTSxsBy946aAzqoR1YxY8pu8kZ4Xsh36ycIW50HqhaKJnzwjgrILtybAY5efNtt/K1byR3d4OjZiTRTOPVHxS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g/QHgColb+qo+Q7mrPCsLmZYNofceCI2FCYDZRnzCA=;
 b=QPbaOkd6LLwmlBwIm+zcGs/h4VLdtLezZd2AEYVX67BO5If2g6g/8wuslG7mWUSBwH7hZ8j7MCp3QBXctdMlaq1VUnKfGU6XU3+LRzn73BOT/vuQYUMdmNA+geg5Vto71CUaIivRVYw/lrPkN2TKDcXjqO92vTJ2VFwzc4QqmkSNB1TPZMunt6vOFFqC8EJ4A3VK5JwQvv8cYuq0rB0F/3OmbROZMeWIQqeHIdfYTb3Z43p7CwCklkZAehwvgibGHv5ZmrudXXAhx0feG2Qbh78WHtcoUncbFrHF04FRDjLAI8/lXX0JzJOcP3lof+C++VaTreZJH4lZ08y3uoa0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g/QHgColb+qo+Q7mrPCsLmZYNofceCI2FCYDZRnzCA=;
 b=Qx+0fRjMRiyI4K9m0yf/Y9lVQrVNjuCk4Q/6yYgeVFeNCbJqRM4bnUgEqQlcOnGZmcwXVkWORRoONX7fTIEfQhTRl8cQoDUynyStl7cpD8H1VKUifkeQrg2FvZJLLY/gMwvmSyhouURhS5fZfD20CQdrZ/oWcs+iDVx3PVZD9Oy4YEgOUgEhnIjBJkVgdkz9DDK509laoOH6/4ioXPpNDiaAqrcse9rgrOCe+ohXHAZJLQLdWQx7C1n8EqACtYC0OFmqwEuGzbgui3wmDlvjrc+MTwdK+Znyr+WXpT6jSPAsATIR5K4sqqaipTp5f91ANBt8RGYqdZKdxULZniDt8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:41:01 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:41:01 +0000
Date: Fri, 31 Oct 2025 15:40:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/11] PCI: imx6: Add a new
 imx8mm_pcie_clkreq_override() for i.MX8M PCIes
Message-ID: <aQUQxQPEEsSrGrz4@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-10-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-10-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1d2884-c906-4914-9161-08de18b56c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d84XBqOvAiNc6VgnTPd7A04JpGH58QjwXAZ5pRYPV8kqsu2PUjQ6cMsYuDS4?=
 =?us-ascii?Q?0XASGIPQl2aa6jVKWqvQKbgaJtBdyjSbf6e0UYFeVFFdVlAgEedQ9jUXIsxq?=
 =?us-ascii?Q?Jp6hXEP7/E7iqeBqX5cd3AqScEJLhldpv7FwEshC/wP2CQSfKS5oNp305gh/?=
 =?us-ascii?Q?Aadlo6BDzWD/revy/Z7V/r6cVSakcyPwDi2DzlRaZhNkh8rp5iZZtMxyZd8l?=
 =?us-ascii?Q?mRcUjIn2CTVYJMMkyQnmex4MpAJuLv1blLMgDHoGUaKWzdO+Cqf8rRcc7S0V?=
 =?us-ascii?Q?tGc7E48wcGNoSm8Lf/aSiw2eteKvMavlVSzuRKoVZYA3F8hlQPZ/98KV8WyU?=
 =?us-ascii?Q?vLsbOzk2ltfBJUNVJ0041bShk77GOOTjfybnGEapoyXHatz4cX3AyFcIU7yf?=
 =?us-ascii?Q?1HcgUi6Em2YS/S0/+5ep0+kljfaZa/fEUthdxZcB6g5N+hxRs/b5DDw4BU8V?=
 =?us-ascii?Q?VY/J2F2m+4uyQ1ZeSLG8c/gzEbWvMGD911yL/EAGGSXslI6O8gWhiwg/tnTV?=
 =?us-ascii?Q?7blSk0gnNBF/QbMmFZDFu3jYuyrZWRAxMJa37cazrYyUyCT17Pi1ff1xx6dp?=
 =?us-ascii?Q?u5MnxHjaQvhw2wcb8gW1SWbliqWnOcp7NH5+1njEVu3gke4ByrW3KBg8SQSp?=
 =?us-ascii?Q?MhEV/07ur1DWS+0mxi8/krYqxj8Vt5nXvTQ2zOQyKWX2VstnugcLZG7ZNnMg?=
 =?us-ascii?Q?w7W9MgHS1qvinXxswqG374JVt1ySQ/aym/EluPpP7rMJ0d3nSXO8NcLD5jxv?=
 =?us-ascii?Q?Gf1ReE1uKlAPR25j7Cain0w6cDblzZqpPfhcxD1QDhnvuIJdIn4/9FiEMKd2?=
 =?us-ascii?Q?RSEdyMRodRCOB+XGlm6G9VmSImkRTVWYeUS5qaL85wBUinq/Er0KKpjs8jW5?=
 =?us-ascii?Q?OVnAH3xOzwkrTlC/72iOEEf1zuQhABehsCes1rIzZ+Ai+Q85WHDmkXDQsZCt?=
 =?us-ascii?Q?Y/1IhJO4mkI303SmfeIOb3INx1shfNRb9GO5zxx+e1lZ7VjWz6k7JfLxGU1B?=
 =?us-ascii?Q?KlQnPZWZLq5gTdjC92rltxaFxQZVBb/ssHObcf+dSmgNBKygMKfuEHK3ruvN?=
 =?us-ascii?Q?pqhQ3Lv3KuLu30oMaF4re3YEJM/eLu57z4TszPS6Z7/a5Pb91tAiwudjiK0S?=
 =?us-ascii?Q?OMkK4UhZJGU575SSDB0gBcjJw4fw7uamYjUEYY2Vg719j2W3Fpo7gWPrC56X?=
 =?us-ascii?Q?rgrj0a+ct4+yAB0tRvSZVCFgQfCVn59vqQQrhyg8vOcegRb7tIlRJHvTrs+V?=
 =?us-ascii?Q?M1eVcEuIqnsXoyHqAjMl6GJScNkzpIcTGPNMqfYZyzw8dJ5fFitduhgxZlo8?=
 =?us-ascii?Q?9mpRWGigV+d70nsKCGlaPWtjWoH4EqCyhWam+4DZ/1OKEbvSU08awO1NsjCA?=
 =?us-ascii?Q?97PLEMW7xqNkYouWVcQzd5ZC8QfTKEAch/ubLldaLJKS5VzoFaoQywNmOsrG?=
 =?us-ascii?Q?XJ9OCkhGv3WX/TaSQy0/fTV/tAhvjKervN29AacB9K3shzJ6yFvg6ZWXGcx0?=
 =?us-ascii?Q?ui9z8NMK3zzEeA/g2SbysxQ1RugR1QAhWBfO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdh8jnzBuC9CuW+XYiej2wGMmt+WK8PaFSCajVA+W12RMd6PSKNM9hBmFSfw?=
 =?us-ascii?Q?tOnAhg78mMweeJgIXB5dqSEKwUmKYxOPEynUA7aeOR3Y0IvnrIkeuh5//0wS?=
 =?us-ascii?Q?cx3LzSLnYaHA2gkUdDlLCAPt++7lQ/+v6yK0Od4l8oaJMoRwiAu9WfPh2wNv?=
 =?us-ascii?Q?PtpgJZ3B1rw0N/7gsWAPYRN81/W5Vsq3tb8OTipILqcpc+mvKrfp6FIzQe+2?=
 =?us-ascii?Q?8dtK34Xm+kyI52wV/2j3TSehkRy7bySfAuifh8t0dcCNK/jGQ79pc1jGEFz5?=
 =?us-ascii?Q?4P9GL1AYd3fjZcatr25m5BkEtOEtOPEQhg3xhy9CM9SZcJmF/w+Fg8BL9pxa?=
 =?us-ascii?Q?SOgBIfq0p4JO+WP8vzLMY7CgOxVRE/6SWNc0nC29N3UoeE5rrpKLN8zhfUPg?=
 =?us-ascii?Q?vT0IJiYPjqvUNwgTDPU2cd2oSIXHEK+j/u4ltyTPVF3ZoYQx3rPP0YRqmh5M?=
 =?us-ascii?Q?rsn4EZozVOIhZMHpKoFX41KtHYunfoIpOTxqRpG2kNiS9p1KhpktDZ6UEz6v?=
 =?us-ascii?Q?voh6iYLvyKKQYMIDJ4WtOYC0ril/pGFvhLYyFDeDiqEf5QubGjdKY+3r1H0x?=
 =?us-ascii?Q?rqc2I6wcmna+8yNaqY6Pyq63hSNor5zgd/WY2sktGpCmza2bI0RTs4l9xhQl?=
 =?us-ascii?Q?TRLGrmNAdaZtWdjK2AAo5U+BWMjOcemNJ9xgFPdV9MXuGY+gdctCFWOrGJzg?=
 =?us-ascii?Q?JrghYqYt3Yyw7CMvBFOvVoMBFWxNZPBbRNcN3nP3TJyde00DWFkPYQMtzplh?=
 =?us-ascii?Q?hY77rqGv1E5FnPQM8ycJfh4pXxyNRVsUUODvbVAQddopGpHsLgGBAXcAdDuL?=
 =?us-ascii?Q?D9Af3gljQzgx4vBJC6/6le21OUuPnOHgjsfSNVNObpF89Qvl40CMkMcHc9gt?=
 =?us-ascii?Q?ra4zjG0mSymLHQd+XxdKAPaBgLLDEWUDgRGnJL1zBklOvRpn9rKl+GdSncys?=
 =?us-ascii?Q?t6rv2p8TYgI0RJ8SqzFIJoOWfU9Nuo0xIWfaz8Bo9fEybZX2cMBDdUzxOa9J?=
 =?us-ascii?Q?eD9vcUxa2iHfBcJJKBhmUanwglQukDmKutvcKMXVkbsjWyngJvx8NonZPtaV?=
 =?us-ascii?Q?Ef5LeDyqyrp26hnFlCXgN0wu2AKtMjOAR+BgZPssr7p0XHlaSma3f7Dk8s42?=
 =?us-ascii?Q?S4E2CEHFfAqpkhn5lZu2vAJMOAiYUVQhi5WHgA/4NbauCAwjQHW6JgdFo2Fz?=
 =?us-ascii?Q?N64P4+PUKiS++GMfz20P4ECFCygzSPzxHdsUjDvuRXdQyL6LJJ2VZKwf+3K9?=
 =?us-ascii?Q?LNO0njBv5LJaEPNRbKzUB0L8vcct/Kg6/nE3aK/KeTRmHL+ipJ1zdX9EfsPj?=
 =?us-ascii?Q?O1nUoVEU2duV185iEv9UYwcssULUdRHvtanB4ueo3vm725BtR/duVtWCgQIR?=
 =?us-ascii?Q?Vq7dZUVyxXWaibhIpNLq0I/+ZdGdMS8WhepRGqBOc+ijaDlCCz/DYfb7PuXg?=
 =?us-ascii?Q?o+HZbE/5JuxV+B59ggXBajRVPvYvaK2QCconmTaPpCzkLFMMzM8Aq8EeWLPB?=
 =?us-ascii?Q?3tXsDq1HamTH1Q0nS0qDDIv5zT2AHz3m8yaZLmPOfsUPxEWU1LTjkVrZdUmz?=
 =?us-ascii?Q?7AM0EcQbM1N8lMgXE44=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d2884-c906-4914-9161-08de18b56c08
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:41:01.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAwJi6phJEXTZSK/+3n8tzVS4GXIMB21PvRHZX/WZzv6uRt+DOLLUNcWxRQb9PUaE8tl8P7lhbWG+qDSFZyXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:26AM +0800, Richard Zhu wrote:
> Add a new imx8mm_pcie_clkreq_override() for i.MX8M PCIes. Pave the path
> to support L1 PM Substates after clear CLKREQ# override. No function
> changes.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4668fc9648bff..a60fe7c337e08 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -685,7 +685,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	return 0;
>  }
>
> -static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +static void imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>
> @@ -695,6 +695,11 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
>  			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
>  			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
> +}
> +
> +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	imx8mm_pcie_clkreq_override(imx_pcie, enable);
>  	return 0;
>  }
>
> --
> 2.37.1
>

