Return-Path: <linux-pci+bounces-25948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2BA8A795
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119EB19028A5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D82405E8;
	Tue, 15 Apr 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HEcxrD1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAA23CEE7;
	Tue, 15 Apr 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744410; cv=fail; b=bBmeVSiLkAh4Yb6lntDZquCC3tceufm60Ah/y1+dVFrHTmXlPlM1tLB0sevcroNezVa/ddwlHAn0mIZEJpBRjSUuDB3yxJ+hZBl2gWUgRlVaystCe9zvuaC+jYsJuiPVwfUQNg/fwvt4byMw132bfMSBCoJieuE/X+RNpZHI5m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744410; c=relaxed/simple;
	bh=Wt4vsHqXJgLaUM2UCwb2vLEW0l+e//p8qZMZIDwoyyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9wnFpUcC7Wpf/d/LBE/9SYZFUemDnDdyk5EwsQNRyw40rwSSyBVNFEgGV/yBBFjkmTDw+W6wBovONyxybdf0heUz3RZZfh3dFwBTH7tni4arFIdegO6iwJCXcnnQSvzFMS4xtWZSCbHXvZO/PNyNUcnyNDykYWKl29Id6QMdYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HEcxrD1w; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3fiRrYVP2PL/HR4Qzh6A1vL1DPmDgu+gBW0U3CaSAgJaMC6vZ8rhBneKrb7gI7Fvj+ogDxtrnZfc5Wbn+stUmltW+faMN77kVruB04dDKa/zqQsWwf6LncBof327Rj7n/Nn6fo9b/9xFmeZuLCB7QV6PikhDae7pVAPOOMEbXi8G3WA7ZWW9YBlhaT/eolKs8GDJSWrzEyIx1OPL5Up7Dg8BGAX8cCvVrG1LOzhveoeCCoG4KqqWULRuXSWNj2l3ZuylnGU3fEcfmOH/NXKYS/GXx0ud5GW9UrdOvepCt8WX6Bfwg1lVzEMjmdlVX090jFBdXIHKh4YrECmguq0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZQ88lK+gCpJeTX8mCB8Cng3uKaMgrXugjpa2QwDmnU=;
 b=wvhpKtMpMVNx/UJa3CA3nCYMnt41tUV9ASGKz1iC3BbPhBW7NyibW30GKUiRZCRboEaydCj1iNRVOu8I5ov56X5erVEIHVnSneYAEr66uOak9WjY8Zr/kA51thSM9GPL/76r6OtRui2Vq9tVwvEXRzW5JBHQKtlUm00S8EVmRXVPt7R0LZI3CZjISOsOVwX9Qsa/CeyDMWP1mQtDwP9VNBmZHBvjs/MQbgYhNwL9fBg6RvnisBgT3AwYzG5XvMKZ+uDXfPD9+vL/YNnpmQldWWRY/YOSOhbgUC5eyIdUsadPGXKOh3/XMR81azMXt3Tq3k6woBZ29Ke+/0ksae0ZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZQ88lK+gCpJeTX8mCB8Cng3uKaMgrXugjpa2QwDmnU=;
 b=HEcxrD1w+9QGYIhMkAbRwyuZG9tw9XJC7NqrKtFbIakfUj8w7ZgRBQPXwkTUXh5zbtcEjl6GrYvKtWBLzPDvlHKdPqaO7e00pX6doPgtNnKpt3sOBlLP6Wo48BD6XDoX3N+bg2nyahiR6ZqYW20/AJpicyBwhLvr/WXyQyJTgapGNJMMb8bKcg/thBQQ1JYOxqnGuW1Rz84k5v4iXP/fNJewkQm9W2Rr8XrxGHGAfgptSqXrTi/KnUxf7CE/FB90aut5n17ONE+BlsmXJtk/tDbZxk66hlofHuTf7hyTmjMh5KySkzd1xPN37K+rxiHi+fDRr3k4fcTNzNEyRdPWPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 19:13:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 19:13:22 +0000
Date: Tue, 15 Apr 2025 15:13:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 4/9] PCI: dwc: Add host_start_link() &
 host_start_link() hooks for dwc glue drivers
Message-ID: <Z/6vyaNh1XGEkJ2R@lizhi-Precision-Tower-5810>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-4-5b6a06132fec@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-4-5b6a06132fec@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5db13d-c99e-4fc3-1eb4-08dd7c51972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SL7rgwslmIhZG/ElOQhQxVrVfXepkuM1otUln63MZDKK8OC0lBV8rOAG8MFz?=
 =?us-ascii?Q?26ylI0UTWhYwJ6Nw/LteZflUY40mdGSvF2iT5AXbhG7nTNAjVaFhDIZBMH3B?=
 =?us-ascii?Q?E2bMltQ7ftAeiqnxDHQZnswXrL/GIRDMJjuisACHcoYAUjvLJgzS36hVytl9?=
 =?us-ascii?Q?xceedo6cWVaNLdNtpmqjNCDuwqCnRsGGMqRNQj34UFDxNfLDtW35jXb3cfyT?=
 =?us-ascii?Q?sxZSn9jUclscCFZprVW79hjKF32oNBzR2ZYHNydW6yGGbn8KyzSV62s5Bk+k?=
 =?us-ascii?Q?1uaxmyzvt32QGK6psiYcj4qYbzvvvZZ17/P8UqyX4B5jWmvHBEW975eC16hD?=
 =?us-ascii?Q?LWfz4aOZyKnZXZcsV0aQjB1oGmAeewl2EGBMR/u1gLoFlCtvZ4Y8R3JZSYaL?=
 =?us-ascii?Q?FR6l1fJQN2ZHOxUoICyrsvllf45Fksl2oTulaorpqpcZQeGPPWNWWjwehJeQ?=
 =?us-ascii?Q?+8PGXfycyYsRxKznf/qTL2+lUDWrOBYqXwVQUkDGul7Xqw/gWhmW2mB/41UG?=
 =?us-ascii?Q?bduoz39cn4TQ6A9zToCXT2rfOtYjOa/IDlndj9pqzIjsQ8DNwbVHCn2B4obA?=
 =?us-ascii?Q?/JqUzzCrIGqFhSyo1ORVkQqlGmNOlaAGojGchXRKS0TWjHsn7I2LYP1YO8fA?=
 =?us-ascii?Q?PkazY+/jf4jNvqJZ8T81AK3jcts6BwBWSfappV3JFxhsNyp3e/pcpSqrPJrl?=
 =?us-ascii?Q?rHXvNT9+RWBGMAiFg+x/uwuIm+GlP0u7d0kTV5KQqeCNhbTBa8cJwO87nIHa?=
 =?us-ascii?Q?/J3qMA31Zzu9R0HMTGhwjI0OMcXGX5B2hoGjbeTzZ0vhq7Bo9YkGNWeRPU1+?=
 =?us-ascii?Q?YVXdzCAnI1etNLgJCMOk3NNS5RbX8F6NrPWhp5t2W+tKZ7nXlfpvoJ8x0YHd?=
 =?us-ascii?Q?XGLI7bUghj575HRmXYj+WGrNEHcVwC1uoHr8cHq3udESNZx9N27Be1EWyhdv?=
 =?us-ascii?Q?YIZV7c4UCscCALIvBB9Umnimq0Y+khGUDNaEOz9b78LaPjSqAJzXJDDYMDKp?=
 =?us-ascii?Q?RYBu7Un5t0llU3pbSgVgF8DJQj+l4r8DYFwV0sN0PxWNgfN44jbbNDHT4mFf?=
 =?us-ascii?Q?aGvW3zlQVOSij0uiK7Q3WaPY2xT7Ji8T8FQNNzmt287dwN99GgYSt197AeeW?=
 =?us-ascii?Q?HGxW03nVWekAPYJknRZTPqDPuj0kZFPjt8yzokQqamkcMnevOllVH0MiXu/8?=
 =?us-ascii?Q?CQb4uOy8Cx+rs3NAGTr8iOakVcYflNv84szHjFrVKn7HJMI0A5LSivP1KwMk?=
 =?us-ascii?Q?YZhGXmNHLmBqzETUN1abDsgmXQaYLCN/1w7ctLS3VuQIPvDvMxkV+fGO0yps?=
 =?us-ascii?Q?MmPLrf9kV1KVAuTll4nFLUx06rbeanXkQT4HDgm1Ptwu3hRVZf6U3ec/GTZ9?=
 =?us-ascii?Q?6Ui9plOES+hd5lFMpcLtG4n9bvmctJS5t83WYJ+vvtjdKmzRzpDnGRINrwQ+?=
 =?us-ascii?Q?hCdh/+5LdYX/m952dzabK93qhqvGvrp5OrxCJSvY+E7PBnavX4Pd2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8yAUMVCERTDJU6z615A0bwdx2dYX5p4apO5MlRqjEV6+2MeTqhIm/AadviMp?=
 =?us-ascii?Q?kGB0xWxPJ1bhiB4TAjEAzAVjkmt2TNOBE5npmkXTCmj1j1C7RRwBXs0cruRa?=
 =?us-ascii?Q?nsHthmU3pRqVgs5oS9bsuyjrfYEwYMw9mFr9A6mUFB1AGgPfVbmWNbTr0IWK?=
 =?us-ascii?Q?6flz+NL3YtzyBUeqqvOuTyfwKCoW3eaQa+vJ0G5F/Jtl3NJUe6p2iFnPPDXT?=
 =?us-ascii?Q?uPPLp6pujsISpGMkZieCOjhsMkGkhhJGRW3NBSRVYxxoxpn1K899TLrGwgL6?=
 =?us-ascii?Q?T4HazSis7trxsAK689jZG2qhkqj3nKhD4k/lgeSX+GKKI/sIgRun5u8xirky?=
 =?us-ascii?Q?h8DJUObEybIKY5hMyQCPRhY6r+FoFNTAHS/ys+1HQi2d5acwz4qTJNAg0VaQ?=
 =?us-ascii?Q?5cGtsR1XCEtIC22SuH9Afdlbfac/tfSLH2kwVLEW5opSEEaZdqnAFxPajeKl?=
 =?us-ascii?Q?qddf6uQquDIaWtJ0+IWxVyCEj3ATA5psXXL1dF5R0GuzaASzCIf/OfgprzaZ?=
 =?us-ascii?Q?SrClHwGM/pSJnNUX6MKsSMMUG0z+0TMM0MMe0/0G+eGm7Q6LIgGaB9MouFQI?=
 =?us-ascii?Q?+eZDYGv7gl3pDXa9vTBSecQmnVUcZOnjNfsCsex3wuD6gn9S4ZLgJVr5qbVP?=
 =?us-ascii?Q?Fh7SfkQPoh242MboyQIwI5xrvhZ93gGqMqUwms/5m95jzq69IAz0JWj3ZX55?=
 =?us-ascii?Q?tp2IjzKmublhlquB+DMfz7nn2r5NP4uuwDUITZamPun0UNn9KcRxwlBQF5+e?=
 =?us-ascii?Q?JK/PAMZeznrTx9P+4seAVEuEgnXJS6rI00XyT4spJtk21nLMXF1FBjjVEjUF?=
 =?us-ascii?Q?+rr+H16sENqGjKsmnlwKOVgJ6Dy+rIgWi/rOX2gIg6BmedWbHvsWo+QoT/J7?=
 =?us-ascii?Q?gMigBEetnklyuIDVQHvvR3dsFWYpd1wVPA1zI0nK+gItezzMTwXbg1Ei7fW8?=
 =?us-ascii?Q?jUFEw3uRdBkJe6tGe0nJifaL+EZcrERSYqYfcTZVTm77ybJtEn0Nf0oZ15Ac?=
 =?us-ascii?Q?RQIKK0HydavTOVaFjc18PJic5Vo9R8RgeuOQXoLxn4o92kzU8I/zuvSs8iqc?=
 =?us-ascii?Q?hyHXqfhwHL6KtRDJmCSZj1V+8GxVnrbFwFAoHAyGhvVHTMI/sGklHYaHP5Uq?=
 =?us-ascii?Q?qb8fvHPHurxtHNq7RYUiGry1KbM6KIb52J5ElqHyzhIA4EM2FoP6UthakSMG?=
 =?us-ascii?Q?p09Wreo5VFXUl7aB/PTrPJ32RM5wO2FviVk+a/eu2+3wQfF/YP2YMMhC8ZVv?=
 =?us-ascii?Q?xrSS99SjgmQakRvh9H41zwzuVy2KV17YbITp6Y5qMZ/z5nDqKpVwX41IEYQX?=
 =?us-ascii?Q?bMbpJ4pyiQfSOMCvmpehAHE9wU9MtZv2P3Hq/NKvU7vRaOHzTRidHhLb5Efh?=
 =?us-ascii?Q?Te9zz2r93rHdvbZ5pyCDlsbKGa4rWBJJxX7rGL09aiXhy+9klIZCIJNlwTUM?=
 =?us-ascii?Q?nsRyjrGAr0uboWaKcOCkgy+tOX6ZyFBukGX6uXyB+g0XcRoh1kRRw91176Aw?=
 =?us-ascii?Q?iGvTUXsUSd6+k6ioSAniAOV6nWa3yUGHru3ZZZzGKdxVUSewuytGc0w6n8Sy?=
 =?us-ascii?Q?FicQQGfyAPXP/jcrSXsALW36W7/oOEImLpUysX/C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5db13d-c99e-4fc3-1eb4-08dd7c51972c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 19:13:22.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcBXnMbBHYNhIs3wwkV1jugxMQ7DrBrUoDtcmglMtK7sN0LaJxHj+/4H4WisQdv4CelQgG25XG/PK0WKb5gDFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225

On Sat, Apr 12, 2025 at 07:19:53AM +0530, Krishna Chaitanya Chundru wrote:
> Add host_start_link() and host_stop_link() functions to dwc glue drivers to
> register with start_link() and stop_link() of pci ops, allowing for better
> control over the link initialization and shutdown process.

what's difference .host_start_link and .start_link ?

what's reason why need .host_start_link.

Frank
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 56aafdbcdacaff6b738800fb03ae60eb13c9a0f2..f3f520d65c92ed5ceae5b33f0055c719a9b60f0e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -466,6 +466,8 @@ struct dw_pcie_ops {
>  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>  	int	(*start_link)(struct dw_pcie *pcie);
>  	void	(*stop_link)(struct dw_pcie *pcie);
> +	int	(*host_start_link)(struct dw_pcie *pcie);
> +	void	(*host_stop_link)(struct dw_pcie *pcie);
>  };
>
>  struct debugfs_info {
> @@ -720,6 +722,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
>  		pci->ops->stop_link(pci);
>  }
>
> +static inline int dw_pcie_host_start_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->host_start_link)
> +		return pci->ops->host_start_link(pci);
> +
> +	return 0;
> +}
> +
> +static inline void dw_pcie_host_stop_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->host_stop_link)
> +		pci->ops->host_stop_link(pci);
> +}
> +
>  static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  {
>  	u32 val;
>
> --
> 2.34.1
>

