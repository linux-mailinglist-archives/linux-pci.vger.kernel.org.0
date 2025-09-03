Return-Path: <linux-pci+bounces-35401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1BB428B2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2CD1BA1218
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676A2D7DCB;
	Wed,  3 Sep 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtdJRe3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DE1EB9E1;
	Wed,  3 Sep 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924302; cv=fail; b=RSRQUayVNGw1Nwks8Jl7ZwGlVvUB4XL5LsduAYCQqs+qp3X+2QRySxv54rHmHIdIRQ4LRnwDDt++0InyFo+jcPCaXhlkFvDv+IYYaQ5PmVUFoMngNRAwG+VfuPIF3CyYtiVspVIZbtjBJMPKwE98s2N/o0UwUl5bXBVFy6/UdAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924302; c=relaxed/simple;
	bh=G0HxHAPP1zXoYal6KxRqaeCq6TY8QcoEt6NN/dWGHi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8Qv+rcXn0ap9Fmp2AwIoRdx7agRzSxgB67GJyh5uO01y8sHf1YBnDATY/Ocx+2NEsaBoXiLdePVZC7RE7LLWJxTNVV8VOKdO4bQJEHR7dDnXCZehms3DYODV4lJL7xKxzSK8T3Dk6gz8hnyjtcPqPjasBxePVZQl4ZD8xAOpE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MtdJRe3+; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYTTmf9UNeEZ38hLg9STgidhPUWv5qPo5tgeSsTa0n1Ns/fSDV1VKPq5c/sarbU/v2eluDxpPVPeBDE3nlCTdhKB5aPDPGx8u+Fty2Z6vioN3DtU/ZT4l/HnKWnZr4orvLOxuICS9Oawmfs5sZN/rIiZ5VxRsmzGQRR1rlYHKg89mNgNUsz5ls6JyTKIUSP4FNW9Lt1K0HoXLdkhPluf/Qqlj2SDKWuU/0qD0cxCeIewDilg7mUNs2r7CMw/l6tTwgAe7qxv7KfSs5qFnKa2vO1AsfxcGePpb2/xwnhjxXrJ99jGsO5CoPFnNS3rDFaAk8A6xjGVBl+2lk9BxbF2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwr7eoG/Z2UGil+5oMGXcxKfDXIAymD5E5RPIShPM1o=;
 b=X6rhQTL9VZyMMg7mcDXFdHV1ls+602sQwQkylKokHRDV+/gLvEm9CZDBgzQjvALxR61dq7rrGH5mMvKFqppZyoMc6eBOi0588XYno6sj4nqI2JXlGT+IOcmFf0eaLc1enWoIyHrms3o0HyGMp1xRJZSqe4ecQMhkUHNO1Xl28olBa1UIylOwrtwkiDABtFY2ghlTNwBlXi7Rh06uhaoKfL5Zt5hkZw3ErzypdQl1lNdkJXcwe8d04ZrvpAyl865dcTgef3aSJuAIh4pOgzoRZDzI3YbBwcSlUwLApOnRjxfkrchzRHSOe3OvBEyUBkvHq1HPUlpWAPb9SipmuT831w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwr7eoG/Z2UGil+5oMGXcxKfDXIAymD5E5RPIShPM1o=;
 b=MtdJRe3+mfY2hFdqok1JCWdSSDiBA39R40E3U+RE2ioLFKOl/OAlerCev9FOe6QM/eYpWppZutPsnNhqjTS3FcQIRysPEsmADNv6B9QtCfDTmI7u3g/pYtJRWe7dLPg2snqwcy6KDitYMkGIeD2p4q1nmwH4xIUmofYvacBRjJAM46/am+RSmMYQNlFIz5MbCuS6xXmsIthA9e/gJKurDvzndbP/r0YjqRzYsfHvojHIP4WUa3caNnJRmrIrFivhZqoD2/jkh2/SS45wnc66Lu2vhaQW9n/akKp4JZNcC4S17ISmFIrrKEfQVQ7mxDDagIBdDIMBstrprKo2zJtMvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 3 Sep
 2025 18:31:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 18:31:37 +0000
Date: Wed, 3 Sep 2025 14:31:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: imx: fix device node reference leak in
 imx_pcie_probe
Message-ID: <aLiJgMXB0wIjadrd@lizhi-Precision-Tower-5810>
References: <20250903135150.2527259-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903135150.2527259-1-linmq006@gmail.com>
X-ClientProxiedBy: PH8PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab789dc-9792-4062-380e-08ddeb181e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIqut9O14cuF5nKtPASJ38qRCQXmVU1fl/o7SohWbO7Mb6pzDRY31+ZfPnjW?=
 =?us-ascii?Q?SQJrZ/7rhLL1Tt8VZ3hb+0MpwcPqK4QoXC4TSQx6EkKBXnLSz0eopJI3wOJI?=
 =?us-ascii?Q?r4ZID2uq54qZOHaDt3Uz2vAw25VrW9QZljUIo50IPpY00fCZ5Ert6DFEoho3?=
 =?us-ascii?Q?zu+SX09xqQbYw0sChkARG6/H/EgulZE3fSG8eNvtldVC2YnCU6Le1t3LdK4w?=
 =?us-ascii?Q?Jqby84tm9wYAOQyDDWZdLoBcHg1SNP/Tlp4JchVwPE7ey7XxKQXtyxGuSJMP?=
 =?us-ascii?Q?DlKzg54EFDEvY2L8T+a5k6F6tBMU6pulkTsK4lKkttBCrgYzvrbe/rUROAuS?=
 =?us-ascii?Q?/SmRe7HPuVVKAPXBJyeZS7W1ptCk1iYzRExBTazkdILVv7pzCkAfLmUfHs9+?=
 =?us-ascii?Q?BX5UaoWSvFkK7KDesCOLuz3XXepr1ladb/af1HQiegawNnk8uvHdzwK2g0jP?=
 =?us-ascii?Q?ALUtyBaJEaoEL6YW4YPUB5VLczPOc3qfCpggndNzGjNr4otY8Fy2IRybIm3S?=
 =?us-ascii?Q?276guluMeAtJf3ITcPXILj0+0h0XpfuE9aU4FtMBKm4rKUjrACnY13+WISQE?=
 =?us-ascii?Q?XAKGIP3BgqZBC2qn0sTyEt8Sns79trFr9MG1IpPN/9sjQ9jwwys84HUJvVmi?=
 =?us-ascii?Q?n/I9OrVfBAfbLR5z7PaFwOhQOCuhz2IZcQNKp+2LL0hAhSp5TN1ZV19lzpgc?=
 =?us-ascii?Q?09KqkQXVHRw0pptFdTkG1y4O6Nhhb3cpaayPyusfWnL4vLkj969KRi6ZDfPm?=
 =?us-ascii?Q?JQ1r4lGeX+gLqrZVgIEwFg9soqmS6mmgPc60U93UG0R9cSS5Tsh2xxEEf5lT?=
 =?us-ascii?Q?OemmqV2cjSdl1vb2U0YigSAkeqny34RQECqd+WZT3aToWsD28WOKwi7/mLLw?=
 =?us-ascii?Q?38XzHsgj6Y8FuIxl678ZcZLsBGEWD+5mHcph7VDPDVkAJHmEsmcWylGZGqAY?=
 =?us-ascii?Q?/synESUFq/uo1UVVO4kz9AGKcS3oklAgG6z8epKL/ewiScBj+TZDi0zr8gxk?=
 =?us-ascii?Q?lH9UCPz6VKgC79MxSfv7DlJW65g9O4foOiXUFXzKcvpHTkFov5MdHFdIzU3Z?=
 =?us-ascii?Q?iNAQ/7f+XCYNqWxxbd/lmksFLLyxh5T0Aou+rBgjMBP8Noy1qG1wHn/5R9fL?=
 =?us-ascii?Q?F5zHVD0w2Ka9TwLqI6LpeSooohV5ffoT2495UdkDG33xcQUTAPZNry0wEsPT?=
 =?us-ascii?Q?W1O79aathQNYbLIPVWhVYvck/H4IXJcXQ9SAvzsWKJAHMbc/Fv6WH6wIbvl8?=
 =?us-ascii?Q?ffPMHs9ZiftFD9ukUuoVHRNfEm78p0yffzafdpVZABPIY8g2oMdEHzQsKBq9?=
 =?us-ascii?Q?jQZUHWyhe/f2Cvasgm9zddjF1hq3QgkuKz2ykWLGBjR1QW/RHhh9dq7MvXUz?=
 =?us-ascii?Q?7nLXOsRPgEXetlrxuhlrlEIURsbp7r7vLOcI0X119y5RKVHKEckuTjawEUop?=
 =?us-ascii?Q?SQgUQmN2wfI5QZjdAJxkXftTo0o1FxykLyJb3MYqHGB52hyETAE1HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WokjJl0mCDMi9qfvb/x2hVyz2fPOC8sUDVn41yPzQwur1Z7qVVdS7PVCyylt?=
 =?us-ascii?Q?h0oc+iSA0VpV+ndxNFlC3MKc1XpQBLUAL0BTTAvNYizVyOu76Ghl7/e0OXoR?=
 =?us-ascii?Q?c2ZKtW7pDOr9AxgorqV7NkllnsWbWttdgBTsk31/cFEjUvJVMPjUPS3N+9It?=
 =?us-ascii?Q?6jQXtIGQickRQ6mHaZmUzuVdBDJP8/xGhu8O2coAhV1lXLDjC/H09PqoXg/c?=
 =?us-ascii?Q?M/7/ziEaISv7jXMVF9GqLK1XgTWWouWhzGl8zCNzdw3olrZozHS6aGd9hv6Q?=
 =?us-ascii?Q?ICz2N0GYphC1zlVDNwQ2D1FWv7adOlghdgfGjW8QGoNUcdF7Zpl2+wsRtqki?=
 =?us-ascii?Q?2PcAze8PcFN25Mk/wO/Sizl9Ql1cSjIWr6eIjcLLdJC57wNSVu8chISUX4nw?=
 =?us-ascii?Q?4G2kb5QpysuT0/bga/ZrXfUxFiWVFlErq0Y/n6b0MB8G0ZKzCx4mqG2kKB7+?=
 =?us-ascii?Q?36W2rWez/k+oeaMxOdHgFMlCunW8sQn08I0faizCbOaUUO0c9kZN0cTqA7qg?=
 =?us-ascii?Q?xPih/1oS7YfdPCl8S58AHrlOmnePpFUybnhs6x53rxcVUHIf3piKSdj448x6?=
 =?us-ascii?Q?2S4GiUA1MkPuzC7EJY9h+vECtfRBmi/XOmoK2z2b26uw9q/8YUpufZqeW5Nw?=
 =?us-ascii?Q?O0iKDQakUsASItz1Lg8MJ70lOTSAWvFq5QHZWAvvp1zQFCTCnQ7DQVQEzcuQ?=
 =?us-ascii?Q?VaR0N9vdaAqw4t9pOrpSW3GPNDgBNcunSa/Ao5gdrglO6Va1KmGQtG7L8gAr?=
 =?us-ascii?Q?FMvnlyBzEbOj7gHv8qOND1lDIzbC1MgctpzvgleinLcZN+KJ5uqOMie0WJ0i?=
 =?us-ascii?Q?K8Q1XIQWCQpsL8xIiRY+kx9uzx1vTUTmM/TFW7tNm5cyJIkMZrQsKGdz8gvX?=
 =?us-ascii?Q?qiAd18ze5bsRwGcuiG08nfke0x5kU+Lcv0maDTXrWSbF1YdmeBqtI9n2+i01?=
 =?us-ascii?Q?aglym1U1kgXJ5E3xJ9qK2oyybMtflZzh0qOcaZdsDYak1xWZtfy9mmkUDZNS?=
 =?us-ascii?Q?L7ofyBkBwZb8/3ex9nXtBbCyUTb7LMpEf53ziirnWlMm7tsBX22w2r2svoxg?=
 =?us-ascii?Q?456YABYyXaWjgJkXFaUqDGGBixaO6ILhKKVVL8cwoKoVMGzlLIq0oybilvir?=
 =?us-ascii?Q?6+HDSKnApN8N9wAFAhZPEL2QigkmxQ5Hnno02sh7dW5fPCelvUdNkZ3P+O07?=
 =?us-ascii?Q?Qd1vTAPF68h+mCuKpbQDPNJ5rNEQtlk9aEHrnU4t1Rdm2lqoVbMaeAAxOgwr?=
 =?us-ascii?Q?p9HBXOufCxOmC+LD3ETF1nCkcvqxB1i4UIlIQ2nTWCn8PRdY8FUM80ooMG8Z?=
 =?us-ascii?Q?Ph1Mnsgy3c1FHn8SAx38oqsTbcyH8YxreNwT96xVU79g08aapIU6sQ3gGkl3?=
 =?us-ascii?Q?CdC96jFEuWCpCtsOv1X3k+eiYpCoE5+EZZsAtuHbE/9JqZxMKZCNBOMzXrbb?=
 =?us-ascii?Q?3Xvs/bhYh41Wea/b5fxP0FU0hv2HGBwsldGlUiRzgCa9PtFfqI3lza9Ntxyo?=
 =?us-ascii?Q?o7jxIM1lLDFe0FPdNAkt1myvIfr0IoyhssVdwTwwwoxBjOBLHm6drgtvPDCU?=
 =?us-ascii?Q?cvYbxU/X5NOaepXOBzfkD2WZax/7oapugRezgZ00?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab789dc-9792-4062-380e-08ddeb181e0d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:31:37.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MG+qK76r0cB1eQAMlJWFPHMVkopSmn+vzarB2/uiv3/I3bQkrQ0FkjVpR6WTyJfTnSumhQlD5PfU/SfNzcVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081

On Wed, Sep 03, 2025 at 09:51:50PM +0800, Miaoqian Lin wrote:

Subject: PCI: imx: Add missing of_node_put() to fix device node reference leak

> As the doc of of_parse_phandle() states:
> "The device_node pointer with refcount incremented.  Use
>  * of_node_put() on it when done."

Needn't this paragaph

Frank
> Add missing of_node_put() after of_parse_phandle() call to properly
> release the device node reference.
>
> Found via static analysis.
>
> Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..618bc4b08a8b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1636,6 +1636,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		struct resource res;
>
>  		ret = of_address_to_resource(np, 0, &res);
> +		of_node_put(np);
>  		if (ret) {
>  			dev_err(dev, "Unable to map PCIe PHY\n");
>  			return ret;
> --
> 2.35.1
>

