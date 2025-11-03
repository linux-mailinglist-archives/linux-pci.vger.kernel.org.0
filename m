Return-Path: <linux-pci+bounces-40130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C4C2D7B2
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 18:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3360D4E31BB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0B3191D2;
	Mon,  3 Nov 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CilVPo/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321030DD1D
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191185; cv=fail; b=Ne9ZjZpmbDbB6oygf51aTGWwGUjsgNA4mZ9pb5nVzN1BeJCo+8URS4GVhO1DPJ6z3G99P67D8kDXGJiNz8/olQv6Ujod0ZXQ4/IbaHCsjzu082W/amJMGBHOieAfI21sKL2pM8UyP0hDbf6+FEu5JosZINzo0K3zkTk6L9Q48JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191185; c=relaxed/simple;
	bh=+/hfaIfy+PJHZXjkvtL4HHo1awxRNhEaw0pSJLAg1+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gmJsfaMqrZUXuM71Q0swnf0HeHPB1yYz1wKh27d2HGYRGhZF6UZFK5t3P31QxMHDDbQIjVyaoMGhM+VmZvM0VXXJ1OY8ztMArUXWOSqCFyodoC36qoK+6gwJ3sIkQW0N+v9sS7vPjJcX+tVIv8szG8R28eMM0oCF1UOb+Qz3uO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CilVPo/F; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYLJ3G6RZxw4H52CGrKNRf0T+mH2ORxRpS41AuOB4fNN0/OdoYah5D0snSp0qtcf5xfnf7ifyw4XvEK9UcbbT846UaNDGESBh6RpjgmJGqkAnpBJwvjTYTm1ToUwluVZPUirxey2Lo4xIeOncy+LOSFxPHND8gE20iZVeOr5zmiO+Qj3cMNgGr7WX6uJ3gs3qamf8iDr5122JrS+rmvnueHjGm4QtlgfHonHKrIaWIgCgQ9cPzqf8ANXXnjYpMRjZE/V8wIg8VoMsQi7Fr+a2WVH0hoq/pS2nxXLh4nRgCh0I151QClKegNTKx5HcBwZPpfF4ZUk/5Rsc+asL815mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7wJaOCUgAtHlYMMbi3+Q1ifWHJy+8sFcoqI/EnzJv0=;
 b=SpDdJ3BBM6zPPZr+xF6PisYb/4L26ZI1h8/CBKCZouLC2lKxmkJViMK2I+CftDNfEwkzADU5nOLi3GhVwgHVnpN83rXzxRfKvd0/F0U6vW8uFQxE8w/GvybWClvxEvFblp14IQDh2ceXVesrXIaI04kF1StgzY4va5p+oo2Z2mtR04xdlDB+9vW5gJ9Mioyq9VvNpUfF+LQTbh9b6Bv3A8LSO8NTK1l3X0D+YoUkegLbX3qoZLr3JdFP5G60WtJPbFVU5VV4usOF6sJ5KiT8gf7Ba69ZWilZykR3kjk5YuwHgpOvMjrKj2E583Tfuv7nFX6E0YzufgFisWJhhBB+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wJaOCUgAtHlYMMbi3+Q1ifWHJy+8sFcoqI/EnzJv0=;
 b=CilVPo/FlWZxJVsTxWbDKvz1hSfQdQnG6XjBS0AbsPgp8dLwifx8mj8WsPvmROk2cVDjCN34/Xvjm6Y0tYsmn+hrV+cXfl2C+hohof7+4Ol43KdTMInF8lswqQkgtMs9zleKj+GyTRA19jI5hp8X2pMOkEGnNzZwGu1IHj6giCeWWNgKSBpYbkCl/MzV2SIt3fwJ2qCFN3Sf4nzyhb6inFeOTj3ntoYWCYVfu31gHRK1CIeme0B8VQHoeYByOwJd16qKPvP+Fo0/sYDhj3RxSFInAViKlLXxnz3d0lruyAlFOwZN83ce91oNMZFl4mSWjRlvtmU8EZGFs8fExfml2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:33:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 17:33:00 +0000
Date: Mon, 3 Nov 2025 12:32:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: PCI: endpoint: fix vNTB bind command
Message-ID: <aQjnROkfA4qAnox2@lizhi-Precision-Tower-5810>
References: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: eb291904-b661-44bd-bb8e-08de1aff0925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5CtD7WyC3KIufHFoaI3MEKid90wMRAXw6NAqhpyU7RfEot0BgUAQWTMl0V1?=
 =?us-ascii?Q?ulnNiAEH/Nu166I6qvhpKpcamksShFI3vE3iEdUKSWlW2xZ/DVvT3kQYA32B?=
 =?us-ascii?Q?P8jxU1D6vovP8ngfBpCbLbkRYMWbDQpqf5SQpjMPvF7Lr7gbgOB7CWyQlX/+?=
 =?us-ascii?Q?I+06AwLSUmjensnMjJrYODJL4Qh4FSsjp6Je4YX/hXC3WvkDYpWzW+0XGGza?=
 =?us-ascii?Q?KAa4JFTVoCjCtAxNVipa7KSGQy/7k8ZOD/4LudBEZRbODICtHugLDXdnabiH?=
 =?us-ascii?Q?poNQRV3dN68kd21b/p4/G6RQ1LkFpR7zaS7hcBoogsF8DxWS1GRYS5f/9u9n?=
 =?us-ascii?Q?LRynkEGuvmAeWWVVtHVto1D82YE0rlrHaDMC6cEC1bpUNNJxzd2FGertV1jS?=
 =?us-ascii?Q?1ZCmfL49sG/XILJpxUmxrzx5zL6kVU86jBwZlt0LxgHHGx8PzeZzuXgkhrxb?=
 =?us-ascii?Q?WRtNEJZH/KYqX2IjMPog3SCUy0cfVnEqUqAY7RT3pwBVdJEYAOk/dWzMxrGb?=
 =?us-ascii?Q?NaCiwszyBZ7i8n5k2IXhN9Wd+mGWd9jk9vOukIB7GHs0PAvMBaOud2Pmyb81?=
 =?us-ascii?Q?nNXiA51oGFPq+RJ7S2OrB3ZdK9l6TDNoxEgQuZP9CFJjChO11K8xr1pCdoIW?=
 =?us-ascii?Q?JmY2k/yTXJOP+WJkfoWn/sFAmGBnE8oI+YeWUOW19Ke+t4pkUE0Ld1lhP+6E?=
 =?us-ascii?Q?ZgG70w229d6pGTz9R8gAkD1ZszFRrVPIcitM68KOwUsPZq4AVcjFisbssVVA?=
 =?us-ascii?Q?a7TRGZ2pt6WxNAphuT9B/oHoDUBNougjzYOrCw5VxqJOpbJdLoKWRjXsgHGq?=
 =?us-ascii?Q?yXBoKnPCSVUeqpBrDZ41zwTsRNIF1+fSNOOZVl/Tmi4dmpIgqPMGL1yNIw6d?=
 =?us-ascii?Q?OXmkat2LFk33n/9l4qCmyz9U9g2Y2OPP4/gtWREFOntQIdATSn7ou0Gv4wpW?=
 =?us-ascii?Q?kHRS48gInjFE1oyrR6ANwO8Enx/zQeC84M3abhcn2j7AgFIuludwtP3p3A17?=
 =?us-ascii?Q?b5HMzD+FVdwOITazMH+jqv4sMyj+Hu61GJ1fssffyZHoYSi9SKUIwj8ePbZw?=
 =?us-ascii?Q?KDXPRgWD4H46EKq5Z3SKCmlopVYGyUhKbkdZZheAeGfpSbeJxk+ZFluSq2nl?=
 =?us-ascii?Q?paxY0ZH/jcC5WA7hmBVZ4Cj5ukN4A11swpNj1pc/bZyGi7eVBTanEBHv+p4r?=
 =?us-ascii?Q?EeFTyTMr8awfS+TSJKTt5r2RKSxFGvhtPCXTMTCf5IcSFHx3e7SBRi6PQacv?=
 =?us-ascii?Q?DROabUj5Wtl+4uI2Nb5XkVEI2aZGefjrLxZkkvwb6AxMq2wTLWPpZoemrF7f?=
 =?us-ascii?Q?u5lYRvfsahePptdH69Xu8n+xcsLVATFKOIYe4+Z/mRAaMYBpAEVOQaktY/+M?=
 =?us-ascii?Q?AFWqyyJY+XeFSyF+X7ajFxVpC+CUr/p2SwDuRXXFfX8zb479R3tU9+Jm576m?=
 =?us-ascii?Q?5lRlfysvc4WDDLJTZsLrT8F523Y4EuxYo4JmfgxFp0FfpExMLrq0ZVTuCIh6?=
 =?us-ascii?Q?Q07ZvkAVVD2/ZJuISpd/dMfLEUPJ8kTjWsWx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVon0VAsBkpXQEpNVzgvHmiMQ9nxW+qtQKjCF3iLBmYfRquPjHTVGh3LPZcE?=
 =?us-ascii?Q?vLDJ0jgh5X5DilvK2E+HgmcnEbQQ98bSjo8EUveZbGEAB1rj+h8XZWIwTZcM?=
 =?us-ascii?Q?MRs8S64hwOXVXlGrKuvKnB1wJ0PIRTIdR+HJlDK4dAYXK1whWyzEHaDHhf3q?=
 =?us-ascii?Q?T588v3TaEUcaeaNJpqgRY8iksA4UIgCCxsZ7JurtXlhU9h7yo566kfrr39uD?=
 =?us-ascii?Q?TIqIM53PSRr0paKN1q37od3lFHIuWawV16iNKjWmn/vW7tYzYzmloGlOxzXV?=
 =?us-ascii?Q?rzQZ6WG3cUUpL5n+GSQIwUq9Z4aEo9KdRZcA0C8WP+6/aE5A3Rv41AhHTBtQ?=
 =?us-ascii?Q?cxyzVWgvFfpJ8YcGK6f/9K8BPyACHCENbIOFo0coJlZ4gq61mDkGGFc+XBrt?=
 =?us-ascii?Q?x8JKyUtvgu1JW0tL/OkFg0nLslZl/2OGPh2EO1+IO3uz5RC+lCa//vmzoutT?=
 =?us-ascii?Q?KgJb8HXsIE4E8bnDjClybXkQOrexYDpD46efqOPsRxKu76icdXUYoqgb3jGo?=
 =?us-ascii?Q?lQtubJg9wuuqCRKwGXBwhS0TZg3ZvIEDUtvgKHTRPUJ+lpECDOPXy4qsuTMg?=
 =?us-ascii?Q?Sva7nvXYTkyDBW3SLv25Qe621ctAiuKsjKh2jGTL2n+nM64WyQlCxDJl5IdL?=
 =?us-ascii?Q?rh0acsawECxKqBL5Be8bs2OdElq4n9S/vNLWZcm7sybwUPDabQmTGLubZIxf?=
 =?us-ascii?Q?yG8Zfg/sUG1/LOIpUgqt2yChv0kkZaJ6WRa0h+jkD2hmSOvRH9MY4s2x9rEv?=
 =?us-ascii?Q?g5uMNclVKFy//an802A91+gI/4WL03HMP+gZYxlVnaTA5JGmWHWbSnKQgdKM?=
 =?us-ascii?Q?ci+be6FoNSwjy48gh/eIElq70yl/NQyWogjxnOV1TC+1lbMkxUGDyv2voqGX?=
 =?us-ascii?Q?lI7TvLIv91sR5qSWw6s2t7UTP9a5kz1x0iR6eDrVH18egp3hWU3wOB++iIdy?=
 =?us-ascii?Q?4dECl8dtsB3ftC/POpcSCeNd+n8BuX8+O+td7zyi1+slBgFwmbp8hnu1Bv65?=
 =?us-ascii?Q?gPVWYWoV5t9Gdh4S2peRGvEcwsAwfqMOzK/5gpuhGhyrKFQf9AhlTCdfvDmj?=
 =?us-ascii?Q?vxj+zhEdTpzWXoLRKej9SFq/hLthFdLOILtxjApU8rtv0WMre+ZKNaCopZlj?=
 =?us-ascii?Q?gr5QjyJpEmuaK0eI1J14bjxhQAhhCi+d8BiJJZd4iPuXrw9KvNYmNjjyxOHj?=
 =?us-ascii?Q?hmcrkAXtqTqwrRgnxkQPBhTBiOzLxO2LmrhwcfindEVuxMlWW9FhfjoGFS0K?=
 =?us-ascii?Q?teBwUbL3L0nT7++TEgo7Qg8LQwmb00dMWzsyTh90eurLVLK1LoCxyF7W7hoE?=
 =?us-ascii?Q?rE0vFTGnIdXwvfAwP/JHEskv5Yd0CrIVGWmS3M8gfWzLXw2sHo/kukQSZOgb?=
 =?us-ascii?Q?EBQSNVsBelxPbEJ2a67N4CuXsT0AugnhvHkBigpn0thJffsnC/WL9pmYGcld?=
 =?us-ascii?Q?1fgbbKb52snMYpNSDxn44HR0K9zfUIJqWBgb2CJyeBL/kt5FAPWr+0EVZuct?=
 =?us-ascii?Q?u2jwimjBZv9wCVFfGgqqpWtTAjrZssjuR+58Iqakm1/UVz+P/NP6qK3u5f3u?=
 =?us-ascii?Q?6SjBUF8cdz1kC1hxMlE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb291904-b661-44bd-bb8e-08de1aff0925
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:33:00.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvA1fPEnGC3vE/kVkcPCq3Rlc5AnRka08Uymt65zAnzsBnIsitna536j7tMJ3SRYBYXjwnWPX30/uIcuEOpE8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991

On Mon, Nov 03, 2025 at 09:28:30AM +0200, Baruch Siach wrote:
> EP function directory is named pci_epf_vntb as mentioned throughout this
> document.

Nit: Fix copy/paste error "pci-epf-ntb", which should be "pci_epf_vntb".

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Fixes: 4ac8c8e52cd9 ("Documentation: PCI: Add specification for the PCI vNTB function device")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> index 9a7a2f0a6849..72b7a71b2e64 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -117,7 +117,7 @@ Binding pci-epf-ntb Device to EP Controller
>  NTB function device should be attached to PCI endpoint controllers
>  connected to the host.
>
> -	# ln -s controllers/5f010000.pcie_ep functions/pci-epf-ntb/func1/primary
> +	# ln -s controllers/5f010000.pcie_ep functions/pci_epf_vntb/func1/primary
>
>  Once the above step is completed, the PCI endpoint controllers are ready to
>  establish a link with the host.
> --
> 2.51.0
>

