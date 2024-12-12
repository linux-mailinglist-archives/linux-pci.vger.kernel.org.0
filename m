Return-Path: <linux-pci+bounces-18324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134159EFA30
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10018281BEE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD1158D80;
	Thu, 12 Dec 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DAB/yaPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0451BDDF;
	Thu, 12 Dec 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026451; cv=fail; b=rMyCFa2Zfo+p+DuqLi1llpJZGRIyxruBOOegHQWKvUtQcbwUfnkwraNqt+a7gbefMH7h940a4F9SjMlCG/JWAlq42KwMtYolQ+u90fSdGQ3Qy9CMCVij0B1aTCphPkfKeeyi6Ajl8963jJbVChrR0+geeQEI7mT/R3VtZuuN2+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026451; c=relaxed/simple;
	bh=DsciCSrsAUJOoyMRYB1EDqyAR9thA1jpnAoAGR5jfaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JZTNg9lxNbOv5CX5af2Def/7q+tehptd9N91ZgdZ08fiMWAhCGzmaPDkQ8g5K5SP1H1AR7aUSKfFCC9XH/IR4HkFcvgQxHzGIs4Lgm4SZvoab82s+8B0Vt3HJi6bssKZXcSgZumL9tLlZGzTaB9VBYb57LXKHBgc7Hh+MKXNs2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DAB/yaPF; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5HgtctXt1EVZWYs3V5okzWWJMYJG1WQJg0ZNMU0dFrt65JtzpHBYOqXvc/SBhecOxV0vKmlGhJKy6vcP/AhRZtBzYbg3Bs/a/Ykks3RQt4Ii+v1ohwySRDxrR+SwtV5iIzaD0eAYSSlQ+EzaUrScodzIn0CA54ipkSsaBfzMD22m8dZXfNJ/u+H8XdiDgDJ+Uv33EsnJPYp19RjXdY698oOWumn2CGeddzesltyOe05BcAHgNgOgviNk5y3DiuqZxW/cS1i6SeytQGmPvRtA7zUYFDogKeMDTVRi/mas9dzJaka78DMlWAKqBfpFmkReWqt5JsVjH0SPoKW0NiENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2djKsj4XqKzDUyMwPjIrVU1ihF7r+WZWnUcUVO+YzA=;
 b=LkjFtOFTvpkXNCkxgLr9ORjDukiJJ4a8BfQ755tTZjW5Yx0lUhkJ2gmO+m281VEdkF9TWp73JO8NYg76PW/qgpgIXjUu81mhCA/Z5+maUINtfqVuiq8l+XfCj544wLtjlpYNVLMcCd4mazGr01MsJn5cbi0ShHjdcV/58LdcgyQsp/LJC1YXtPj+ZYk4hDkaxAcbiUuRGtffTRLAdqWBVIpExaHXTz6g+c8AnG+GLE3yxPjY3AjJPGjNQmTRK9qXMvWkx7XEkvOnnn9efwYySP2uUKHgXztOeLiV9eOGbPVrNx6mLSnSbeSXeGsYgAF95lQeHM+PLXIbPiVc9Q2ByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2djKsj4XqKzDUyMwPjIrVU1ihF7r+WZWnUcUVO+YzA=;
 b=DAB/yaPF7ZIYaFelQ8lqNCbhbj9cl+0BQYH63rx997dLDq/1U+ogY/yDbHeCrmVHuA01I86vsw1uAADXRdqUbalatn9A8P92ODLy423E7qVbbXoDYylJN2YaDx8zg7eNuWqq/3ZAdducGG8vlfQbGfqM90S5L03+tNnfq20am5opj7vLAzEklK+ynGD9N6Xy2D24338UCPM1CDh4U4v0/uyruR0Dsy09TluCRTPamL4U/v1VgHWnk8ZPF823sTgBSYTepF7ARRjsDxeIjBGkv8vO4HDKJdwMvAOH293X4LocHVSPTFBtV84AZxg8cV/ZA3siBV0mOMHwFf1g9iLIyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9228.eurprd04.prod.outlook.com (2603:10a6:10:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 18:00:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 18:00:45 +0000
Date: Thu, 12 Dec 2024 13:00:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 2/3] PCI: endpoint: Simplify API pci_epc_get()
 implementation
Message-ID: <Z1skxldWWjxrPzDe@lizhi-Precision-Tower-5810>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
 <20241210-pci-epc-core_fix-v3-2-4d86dd573e4b@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-epc-core_fix-v3-2-4d86dd573e4b@quicinc.com>
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 283efe3f-45af-46ae-22a2-08dd1ad6e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W2lta4es1Ft+XxijvqcfzA553KQeOcYf8AmXTuhBm2gwPCeE4FAnFxGeM7GF?=
 =?us-ascii?Q?qNUHozh9jA90sj6oY46E0i8c3IWJzhGnxSU8UlZGN51XYQe2r/9tTNgzqEsV?=
 =?us-ascii?Q?Dn4B9YLtWeRtX6q1706dcsnAV2tTh5VNM7wQFWfgSq6GHsqIXLjg8+a4hGO+?=
 =?us-ascii?Q?6M5FcHKPd5Urn/7ynxrmBPa5fhSpmj10m3WIUE3pOEZP4e88k8Bl6R2BT8kU?=
 =?us-ascii?Q?IqkrUhowPtXd0R/x9biUnbysRcNTvAI25cJlwX+du28g8lamAlUmJDutiV+p?=
 =?us-ascii?Q?ZTUN+xEYtSo2YKaRcyxgjiz86x6s3n0uN+vSt9SO3IWgFcl0c15Xaae1WGjy?=
 =?us-ascii?Q?m9eGS6TEJbwNnwDBpK9HH1YLlK3xr7CWSVk5w2eQGNs984TB1Nh02Iz3PyGD?=
 =?us-ascii?Q?9gNjUPb6N038rQY+IYqyiFovlv8euHm1Gqgmf6+VYHaXN2/HscK5UE/tdaTJ?=
 =?us-ascii?Q?ZmHMoOQJ6iXeH6xed3eBWgHoe9jxJ/i+VoQOZLcDUdcg+oeFmz/Qxw46ISay?=
 =?us-ascii?Q?g1q2+ee6TlZ3XmrfNCfP/uMY+OpQmeUEURV6s1hcl/JM5vXIgpx0R5qSkTEU?=
 =?us-ascii?Q?iN7QYa9Ud4bDdgjfb2fqsPopP+k2N3NnUBfcjGLi9PKNVy+Y9Zaf1kWvkZrU?=
 =?us-ascii?Q?s/Ncf2x/6oTTxNghkdNCiRLtSOdRCiK7iuRk8lV9Cja6E7rku4Tn3puH9EFF?=
 =?us-ascii?Q?YLLBHRdwDENEK7TOiHR2cgRwwxwi5bVmGaX1okP6PzZq28b8CbYkC0vUBmwM?=
 =?us-ascii?Q?T4oCEULwiz0RcNpcODvQDNQ786dan2q280LjC2gLphgyViYM85wSOtUvj0Zd?=
 =?us-ascii?Q?c6jcUyA9eFtCyP7lc7GSrJNl3vJ6e932Oq5QKk8ShoIMKauwTdBtDusJ/Ijv?=
 =?us-ascii?Q?iT4tlgja+SDrD8fVKtLzYnA3odxTgHYdeWHOZ7HRI/pfcehan/bmEMF+1VHe?=
 =?us-ascii?Q?xF5KF9mHQJCBtVECoteXkphKAd7YtcUznBJa8loQYBJx6G4HTX7w5u1ZZbU+?=
 =?us-ascii?Q?RbBaRP6rc9L2zw3Up+G2rXyrNVwZ8BY/6ajgu9jo6nRivRE6XkItdpFtUawI?=
 =?us-ascii?Q?1iKl8nW3MSfI/HwgVRTjo5KwqXraPudPBgiqgWtbjTP2pYYrhSnl/p43/bSx?=
 =?us-ascii?Q?FcPDdrU0+W9Tnc9E85bW5KE4d0mYvNwWv4ywSZeXl4/peq1ngQqnHv8Xl1wY?=
 =?us-ascii?Q?Q+8A5vIFtgvfrEhYZEMjbAqrB2pAEFzSgYY4JY2duh/1I+PLztGJPd1ENLZz?=
 =?us-ascii?Q?Fr5LLpWjg028U9+gBdvtQvKbrXxG61F1NcCKInxD7lVm6/Ly0EvVSSZ4IVKE?=
 =?us-ascii?Q?1b54kuoowKXydiEYeKLPOXFIUGO3zDZaDPMaUcvxekx5dnjBCrRNU3yi0lAq?=
 =?us-ascii?Q?LWioUmHYO544lbzrueTsbvHaB3ZSMS33kqUuUchYFzVpXonwWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfHN+PscS0BriCCtR1b3uLacKOGGQvJaqRONe76lpfE0EVXQHMkGRi66Le7U?=
 =?us-ascii?Q?qzEKxQ+ULk1v6QHj5rCfcAZpZrE26ed/XOaxZ5mbSsOx0d9pDnA8qEwMV5pL?=
 =?us-ascii?Q?1SXoYlJuCTibzLF4o7HT12ULgr8Hvx0kwRgdNd15TE86GNFvtT3AMrdgvXRl?=
 =?us-ascii?Q?/HZX6e/UZrAHG9rdK6sN8duJtv+aIHiftefTFr5KpUCF2dXtnPKNMXOuRJe+?=
 =?us-ascii?Q?exwo6mq6jrZjbW9QYVWKUIvms9nTqvYxy1KwE6IFEAfN1WJGA8J2rBkCsUjh?=
 =?us-ascii?Q?IpAfuR+qO6/4gf+CmDoZOX+u0vzGJfcmDVCliMDnXpAFRBpaRkCHehwEJLFd?=
 =?us-ascii?Q?XBRETtWzNKXHWptsYbgA8KQ6LDdIgUd5gEl7Bw3cqfz7xKtp/4f6n20bfhGN?=
 =?us-ascii?Q?ztXaY8odJnDo2cvbjpMmera0WRsbnvezvHYVf2IbftXXVft1E4CJpJy3EfDX?=
 =?us-ascii?Q?QZRAEaT5UlEG2+TOBR0Pu4TEwbnE1G+uX9/zs7RkubGvrVEPfDUNzSq/+p0K?=
 =?us-ascii?Q?a2zlgTTWurVJ/60JjCi80RM09JHoEIDd7/OOcxD+PoNd6/rJjSrugZ3ly7S6?=
 =?us-ascii?Q?LEZe4WFcjOLXDIvFf4xv8RKMR+JE76f4kkAOerN8v3CVq4Ai9cUKXKRCvGwA?=
 =?us-ascii?Q?X5iciXC5gjgMZdt8g77btQMzO68a6Zi+2xiNaz8Z2fXNoBfgu8h/3i8mniUu?=
 =?us-ascii?Q?va83RtnTjRSgDpfhLTxtnSBqrr6ecKP48U2Q/HRNBAhRnWtZSbhPyttjhiIX?=
 =?us-ascii?Q?Fm1mEKBcJ6nguAM5IvB52YLM/ccBlCocmffcChy+1qlk7/8+aLUPTQmF50WT?=
 =?us-ascii?Q?qNU1GnuxAoY9LiM/jwe1Wl9yEnPUU4DBqFRgw4EuIbzxgPHP8L0jWGz/6oqB?=
 =?us-ascii?Q?NFi7Gi4bn5Usq0wCxUX52KOqr7jSfwUXyBbkTR2UcI6NTSdocIoPacCv9Bx3?=
 =?us-ascii?Q?FeRK9i6key2BIGUDShghYlFeuwJmM5SnFcLJFPUtIL6yMwl8Hl4YVdCT5QlP?=
 =?us-ascii?Q?WG74OjZ6DS3tgwC6Mfd5T0g+63RuXeQ7hngatURQ2YUf/3skOlLfpEMvUBnf?=
 =?us-ascii?Q?BUE3qU7civrqZlOAxxz6nxw5CL2axGzTwX7PQ5a1nhvsUTkhMD1WF9J+6PJh?=
 =?us-ascii?Q?Q0FqttNI4JMnU6ljnSYHngHRqQmkuHxwHAjcn21NgZVzd+J/A2kGsqaq0Wbs?=
 =?us-ascii?Q?r1nxusiyTseyyKUqI8WIBEB59FSA5ekPNqVkP9/jfY+XPHLh1v+E93YgYlzC?=
 =?us-ascii?Q?MGldPtLp7+u1N0imqVNWTosICfHrOwTR0S8KmWwB6AQcux3jpmVnwyH8Ax3a?=
 =?us-ascii?Q?bjoOsqrGSciV7hE3M7BFW0q7C0Ey03E5rbHT5nG7nDexggy2CmKwvvx4B8qM?=
 =?us-ascii?Q?nNMp5U2v2KqiJ8Yp9fdYu0mqccqol14y+IunmmNc8Daa4CwUlvtK4O70UPzP?=
 =?us-ascii?Q?rd7ZctRaDMafHlzksgKUhdXiz/4zMnXk9s1UwwmycjJErSLIJlwSvtjRD0eE?=
 =?us-ascii?Q?O3WKepAeacpnZBtrVRJ8nWOy8YWz4hY0rG1EAJvlr3doLn+aHi5Rtq+rI7y5?=
 =?us-ascii?Q?9ffu4pkQZ36kHojxAMLebAniJaR/NJJwhcvDNy5t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283efe3f-45af-46ae-22a2-08dd1ad6e6a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 18:00:45.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEyJOM0csoYyZQYlzvp8YrX+BjF8MUs5Kd9cWoT7COY55WujTNIHYsepENIC0Yyu8+/MT3VK/RNnFMyG+5Z3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9228

On Tue, Dec 10, 2024 at 10:00:19PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> Simplify pci_epc_get() implementation by API class_find_device_by_name().
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 71b6d100056e54438d0554f7ee82aaa64e0debb5..eb02d477bc7ca43a91b8a4a13c6ce96dab0b02fd 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -60,26 +60,17 @@ struct pci_epc *pci_epc_get(const char *epc_name)
>  	int ret = -EINVAL;
>  	struct pci_epc *epc;
>  	struct device *dev;
> -	struct class_dev_iter iter;
>
> -	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
> -	while ((dev = class_dev_iter_next(&iter))) {
> -		if (strcmp(epc_name, dev_name(dev)))
> -			continue;
> +	dev = class_find_device_by_name(&pci_epc_class, epc_name);
> +	if (!dev)
> +		goto err;
>
> -		epc = to_pci_epc(dev);
> -		if (!try_module_get(epc->ops->owner)) {
> -			ret = -EINVAL;
> -			goto err;
> -		}
> -
> -		class_dev_iter_exit(&iter);
> -		get_device(&epc->dev);
> +	epc = to_pci_epc(dev);
> +	if (try_module_get(epc->ops->owner))
>  		return epc;
> -	}
>
>  err:
> -	class_dev_iter_exit(&iter);
> +	put_device(dev);
>  	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get);
>
> --
> 2.34.1
>

