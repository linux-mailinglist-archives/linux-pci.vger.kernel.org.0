Return-Path: <linux-pci+bounces-40372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0090C37191
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6BF6848B9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66D225408;
	Wed,  5 Nov 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GDA9SUZR"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7823EAA4;
	Wed,  5 Nov 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363415; cv=fail; b=AmE4Ejo9WDBug0Z1Q2cb81rW6cHZrjwSZJjqvLx2H78MIW032TxcozxN+8DLhRXU+penCHOP39wc2bzXPABBfgHghIqGyO5y5H8moipXept+Ou5KRSeJq6lAw7zyxbjsxXc9ftbt/TkGpQ0GM0ecJGpjpfM42P2Bxs6M6woXatM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363415; c=relaxed/simple;
	bh=WwGxDtAo2I3w7vvfdq+3eUVAwZbleqLtbhh7F+NP578=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XS/wNzeKnXPIxZMTOnUj8ALXBHqzWI4x95lOqr2u8iBFbHcE4qX7GwceuLMNKSCcjrCEruXkax+vBGcjMHdx92LI514T/VCyF85LH3szRHl7Rar25gDVbrFacUimpdOzp+sO/NlN6nw8ADmSujOJvK1as67DXCMUe9ogbFGFAKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GDA9SUZR; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYuOONZY1cOFiE66ptQWqXUq/hWO4lsq49YlLYw2WYrI9Wt6uh8gy6VGmrRf4dkZxjqd4kMw4C2ljLPb72x92Zj2R4PQflCA4Wk1YfOJrJUOahtr3YTtBbCg0uyG96iV3w4hX9BwZA/BuFwUQvjtPMnjTalMJJQuuJMdbPPfx3fVgK7p0If+oMgrQjwHDBv0tODc2J2f++JzMc8sKlGFZVGA6nC1eq7eDu8bgTCiIU2xcenGmih3GXN5zNg9f0TDVyvtByQyW27QQt73Ekip48Ew17g8bZBNifVeKmrospq5GScPzEVY8mYZkLD1vkv0gOZFt31eOJ0xqH4RiN4Xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4DdsEWMw/Go3OZQCUlrSq7tydHosWYqFtofeu7Glng=;
 b=mBqiFaKBxzy478mAK64uPsA+YgxgOM2z6qgGQ9pq1dAfH2Kq2v28T/cU+uXIbQn9o9c6kaJ4Mggpi3JUmnGoTlH9Xmt+rfS33YTB5Cs0tO7gTtGLNQEgzS+2ssvZWofRf8h0ht58BqjklArOAz53jb8453bAwSdxs1fCNMz8NQFQFyr+L6EQflCf6TsqPBpIIi3Y2xFwmRUaUUIRg6gHLG2o1eVr/vWFgG8ROJ8kt1uLz3sNENeY9yF/Uo2oBJafZAwY6sieaV4E8ZbmIMyEmWENZ2GJ016MBWCgXefweh2ZrovElRyU0lv9SJjzGrwu9lwJweaNSzx/5zo5FcCjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4DdsEWMw/Go3OZQCUlrSq7tydHosWYqFtofeu7Glng=;
 b=GDA9SUZRu2IEwJ3HYszgiC6bEmjt6dbRj0m1QEmZo1Q7NwjOA97TEz/sJNz9pBiKzQFw/E6tZ0JELL7pzKqgfiucrwEDXPvOKH0LKT3HuHY5BDL4gXitX8O1ZvF03pp31E1J572BeO1jceZIYMzRKsQJH756ODaDCf3fbTlbmDloY14F+iLOkqBSSlgg5yULQMeEyFw4XNLnhphIK1bDrUjuUAV7bsIPg48VbRhVomsZzBXVM2tvl6juMIarPS5kl+rvspem6mDdxJLzB6wHNpzmq646x+/VeTIGoBC+SHjXqRod8cyxQZD1m9bEeSzLa/yEY/NEIvCRCl549OgbsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 17:23:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:23:29 +0000
Date: Wed, 5 Nov 2025 12:23:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Message-ID: <aQuICrh4qP0wftIl@lizhi-Precision-Tower-5810>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|MRWPR04MB11520:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5ee0f5-b6ad-4fc9-da98-08de1c900974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|366016|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5p3j2g9QXqQYnbVobNzHYv6rfGpvvMr/U32upR0mcrBR32W+AFGhrs2mLJF?=
 =?us-ascii?Q?qQSZ6S/WENezLxOxD+lJ3XuxgRtYv1QQ63grNPZnliriOQk6Mrtrw4LAM672?=
 =?us-ascii?Q?uFsyW2TG2/ibp8Y5iK4exTaHgY1aF1duevfEiOlfLfRNY05N5wNPARPp9KPR?=
 =?us-ascii?Q?mecp1Ben8xUTz74J9sYf62ZLgtSxEwcUc4xxZIjsucIqw8n2PT+X9BeTuH4Z?=
 =?us-ascii?Q?ORi1MpPMkoS0b9sjvAlpOfED02e6LqwwbYXC+5gK6qKMLYGRHRZnK+OWFshc?=
 =?us-ascii?Q?4KyAlz7GjUw03SeX3LpaXr1u28SFsHPFkc8bEC0CegjMb5RY5PIsO0byD/cs?=
 =?us-ascii?Q?3dmYl3iP2gzvhF8ErZLpo5mZCP58ZYvKirvJYZtzqRpeLUGO0PnCRfhdC9F4?=
 =?us-ascii?Q?ittOBvTkEh6yIp0yBHnKwH4SEXkUNLflgvtGeO1EAcR9xYpk07CHdNDQsuBy?=
 =?us-ascii?Q?bk6UbSxw1Hi9Gnej6y9thueuuCorvU/FN6dD7LzDhZ1RcqTbETuAyeuXtsSu?=
 =?us-ascii?Q?HGjTKWYFVCD2uRi09cWQXywvBdC1cksQA4HGLSphYv686cB0N2TwgL1ycWD6?=
 =?us-ascii?Q?bFGW0Jn43x0XzLexnllkGj9iDAkLmnwNIhpNkvJZZQEv/3Kn5p2AUyTpTjgr?=
 =?us-ascii?Q?/FHgn8XTvpCSeRRibC0ANfpZK7as+HVwiAmEkHKIb+d2d8anB6P6NT6ziPOQ?=
 =?us-ascii?Q?DUKSs2k3gA7JKTocIlDk7kUtl80BJAY6AiAinGJEDN1+FGWsPZplHCUNTyxk?=
 =?us-ascii?Q?juDsXosnjLNWOSHWfm5l+nIjGinKH0RPlhUdmu5hsfq5bdIygMCGoID2gweB?=
 =?us-ascii?Q?puXRIku6CDUVl1ArswdGyyoPhKPdZRHnw7nce6U4DLrY8UftTN+YVHeEV4vh?=
 =?us-ascii?Q?rRZf5KUxcUQ9ICM8q4hisYDBKONiXy+w1hcebFrmxmxoVyV1ulmZRz5PHJQZ?=
 =?us-ascii?Q?Y41NEOIUDJhDj/Xqas6NFnA/6t4i6jPP3aiNTqlWZmJobOW4fXMiFE3nGmxI?=
 =?us-ascii?Q?POd8017pdJ0AtrvtXUm6YK/HPaUe6o6iQLeP4Ut+uDVC2ulj1ie2tmBXztgC?=
 =?us-ascii?Q?qMl/8Xff8j2asRRDMpB06u80COg9P0T8vExeORGbdOu6ET4ABVCaAvrmQEMQ?=
 =?us-ascii?Q?FtikCOxrWmngLO593ryOGwK3cVmdj7hOuMg6Fw4Uk5Gfm5Y2brutSFqdrAvP?=
 =?us-ascii?Q?e2m9OTO2rG5NxGeHQBXhrIaHcSJQR1hwAUAtLZrW/XWU+Jnz7zYLWrBzrDGh?=
 =?us-ascii?Q?LcKpZmJljXF1YDCoTH1OY6Vjk2O8LLnVgge7pxgDFfzBHqftymIgVkwtuS1f?=
 =?us-ascii?Q?UWYgEZgOg14ph2GB3hVd+SqZlOc+cOqeRmjFOEFay85CnaV8V1JUOfqplXsG?=
 =?us-ascii?Q?xlxRrtEYVDEq1al98QV3CzYbBV8u6zStlZMyFkb894NTqhdFV8R3avzxk4iW?=
 =?us-ascii?Q?JXhP4KH/eEBMT5F69CAkrpEjraBsAK9Gb1ER4mmC6bw3v50RNaA99ObloLJb?=
 =?us-ascii?Q?9SJP9yuyhf/rwy/It/4M2LJyeURR1Zy5w3/f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(366016)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6o70NNiPVlmb2nGJ6zSjVz1u5HYmqsqZyHcwTTQYzawsJ1mJ8HXlQiTHlia7?=
 =?us-ascii?Q?T1JB6fG2fRjDt6ZhwgIF5VIMECriBvZS/0sryMItwVDn56VIsDIig4iEO3/R?=
 =?us-ascii?Q?f28XQz2YJ+LG0Pvfzl1J0Fl7FLQ5Tn11lWY+ni5izhZ9NgfCKIyge7D9wHm1?=
 =?us-ascii?Q?SMW6X7VBgD8KG3kqwoYZqGj6mjvAYa4UBEE3IcMCuqFMVzRpM4ruacQDH8Ph?=
 =?us-ascii?Q?dkT8SJdxpOzGAER1pKtmszy3CWQejG2c1Qoj3tVmfz0qQZoZKVfoKF/FFu1s?=
 =?us-ascii?Q?+GFb5xWPYGKkMp/N+wGO/avg6dAmlSnJKtb2mTNYFz7DGHHoCJk/i2MS3qbJ?=
 =?us-ascii?Q?ggIkniCatWhZ0q8N2VMn/WZN+x7YasF6KrsVlyK0EnSaSorno0bv4DEUm/im?=
 =?us-ascii?Q?eLFJkVgUs8z10WItBEGKj+Euea4I8tyrgEnA5hop/zhtCks8zMNjtVy1b+Wl?=
 =?us-ascii?Q?heno7uewfiBA+R/rSQNBCUUjJlrz0/KH1EF28J1XWT6oa5mSJRtViUWRiQ1E?=
 =?us-ascii?Q?jZdUlOuqHtpCaT8hdTaFApX3tJw5Puvv5Z7efoxwTFIDbMk7+eXaAChmnnkK?=
 =?us-ascii?Q?DGsNryamcRBCLHW5GORvRfYqof4/dkk/2eyhEfVcJL/26h0DImt0eXVFUCkg?=
 =?us-ascii?Q?IQ2c7psPzQmD6fT148KPPkuNzyw5xNFGQNlo9956jT3EYeH79isf6Wm5X85b?=
 =?us-ascii?Q?CTXMG9aWHySXS4uHOQ/Ji0LPz5o/+wvVm05wr/zlaDbLRvN9rfg10gx5CAqU?=
 =?us-ascii?Q?lKa7JUL2KowRcke5jqKTt0h1lC+4yrTFe1sBrrL1KBi0+pPrmgAynx14A4yS?=
 =?us-ascii?Q?eGanFw3IFtTEbPHhtyH+gDYOqDNnRNeXCnTOC5jCP153o7GxJa2KjUNgcdFq?=
 =?us-ascii?Q?0/hUjbyG1wTZmArPYmzuTYB5p8E+M+JBdNXSNi6aTOua9yDRgTaPL8oxko3S?=
 =?us-ascii?Q?RKbbpVAKUQn3xEGufDsibYMTR56So5crwkMjqq5eseqkB13W07tKl+ZH9dZa?=
 =?us-ascii?Q?5VNOGG3EsfKymQhYDdc8hbj2z6HAfv3qSjaGJDcRoVJ9pDotkgEtrCkQXQQc?=
 =?us-ascii?Q?xo+s6pOmZ/BlIc8L33IvZ0JR2+r4bdzkO5jXEWCJjM+Eux0oDEmyNpGvJN2J?=
 =?us-ascii?Q?zFev9fWzriSQVXGWk1r6/ABMVA9+RIPotXbyawx39zWQf2rSXY1hjqiWUnv8?=
 =?us-ascii?Q?PW5lWcGTKauv10QPFP85eRdccbIchO+BlqMBt7oPtehzKCelrb1sINwsyHgn?=
 =?us-ascii?Q?dIHW8Rqd4/EWFKY9EWv2Hxs4L4Pk3Fw8BTvfywXfgINZ2lUJTWh97lK6Hqu0?=
 =?us-ascii?Q?HSDX+RCHh0HulscVCXJf1+J6D4Bp/D/CCep/e0Rq7GsjOFAeeCxxMfwjiWyq?=
 =?us-ascii?Q?7xLH3redH1vwsTJ1NNw2ScyiZrA++HlUlbhqNlbnZTge/MWKAeaGDoUtuYZs?=
 =?us-ascii?Q?HzjMG42C69ogJDDgASIhxeFnOJOKACnhXMjwLZLB6evdZsynykwPvtWFLyXa?=
 =?us-ascii?Q?bgdu/KqTEgMacIaq2wfZDzh2Sgm3s4vJIXF0c1aca8rUqu+2JraJh+YtrPNe?=
 =?us-ascii?Q?tHB3tleTXk8GAAC49hSppu6Ebmu5IvRAp8XKH9nd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5ee0f5-b6ad-4fc9-da98-08de1c900974
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:23:29.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkfA3bzEpg/MQDpphwGpwGaLrGsk+4QuRrg+ejR3gwM8ZMyobE7UGowI8Xt1OgdqH1ULTQVWJrl+p+J4IQKtsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520

On Wed, Nov 05, 2025 at 02:45:52PM +0530, Manivannan Sadhasivam wrote:
> This driver is used to control the PCIe M.2 connectors of different
> Mechanical Keys attached to the host machines and supporting different
> interfaces like PCIe/SATA, USB/UART etc...
>
> Currently, this driver supports only the Mechanical Key M connectors with
> PCIe interface. The driver also only supports driving the mandatory 3.3v
> and optional 1.8v power supplies. The optional signals of the Key M
> connectors are not currently supported.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  MAINTAINERS                               |   7 ++
>  drivers/power/sequencing/Kconfig          |   8 ++
>  drivers/power/sequencing/Makefile         |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c6802f99a98ac2de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20474,6 +20474,13 @@ F:	Documentation/driver-api/pwrseq.rst
>  F:	drivers/power/sequencing/
>  F:	include/linux/pwrseq/
>
> +PCIE M.2 POWER SEQUENCING
> +M:	Manivannan Sadhasivam <mani@kernel.org>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> +F:	drivers/power/sequencing/pwrseq-pcie-m2.c
> +
>  POWER STATE COORDINATION INTERFACE (PSCI)
>  M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c07db34c82f9f1e31 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
>  	  GPU. This driver handles the complex clock and reset sequence
>  	  required to power on the Imagination BXM GPU on this platform.
>
> +config POWER_SEQUENCING_PCIE_M2
> +	tristate "PCIe M.2 connector power sequencing driver"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say Y here to enable the power sequencing driver for PCIe M.2
> +	  connectors. This driver handles the power sequencing for the M.2
> +	  connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
> +
>  endif
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> index 96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1..0911d461829897c5018e26dbe475b28f6fb6914c 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -5,3 +5,4 @@ pwrseq-core-y				:= core.o
>
>  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
>  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
> +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b9f68ee9c5a377ce900a88de86a3e269f9c99e51
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
...
> +
> +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwrseq_pcie_m2_ctx *ctx;
> +	struct pwrseq_config config;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->pdata = of_device_get_match_data(dev);
> +	if (!ctx->pdata)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to obtain platform data\n");
> +
> +	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get all regulators\n");
> +
> +	ctx->num_vregs = ret;
> +
> +	memset(&config, 0, sizeof(config));
> +
> +	config.parent = dev;
> +	config.owner = THIS_MODULE;
> +	config.drvdata = ctx;
> +	config.match = pwrseq_pcie_m2_match;
> +	config.targets = ctx->pdata->targets;
> +
> +	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> +	if (IS_ERR(ctx->pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +				     "Failed to register the power sequencer\n");

Does need free resources allocated by of_regulator_bulk_get_all() here?

Frank

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
> +	{
> +		.compatible = "pcie-m2-m-connector",
> +		.data = &pwrseq_pcie_m2_m_of_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
> +
> +static struct platform_driver pwrseq_pcie_m2_driver = {
> +	.driver = {
> +		.name = "pwrseq-pcie-m2",
> +		.of_match_table = pwrseq_pcie_m2_of_match,
> +	},
> +	.probe = pwrseq_pcie_m2_probe,
> +};
> +module_platform_driver(pwrseq_pcie_m2_driver);
> +
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>");
> +MODULE_DESCRIPTION("Power Sequencing driver for PCIe M.2 connector");
> +MODULE_LICENSE("GPL");
>
> --
> 2.48.1
>

