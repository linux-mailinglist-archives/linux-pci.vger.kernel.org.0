Return-Path: <linux-pci+bounces-3840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8285E964
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 22:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303291F245AF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97986653;
	Wed, 21 Feb 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mp9+iKBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8523613B;
	Wed, 21 Feb 2024 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549267; cv=fail; b=Ohq+V21rbn7k49SuMEPXM2hpg+3lUJ8BjYA/Vaa7JXDvUUvhJVcRTDmbHoE7J/7FCXVR70uAJq9xqVTI07ekEUt2QEZavQeB4CuxBm4UktfcytZKsKj9ORHzKYWqZ0961wjOLA7exWnuaAPxdTz/uQwKetaeJ04MIYloRPdJac4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549267; c=relaxed/simple;
	bh=q0Y8IZtUDRbQpvDQiq9hKj+dti+jKRypjwuu6xNuvHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j4MmX5lHG0uo80FNn7zGFKmmUMwEyL1jF1pr1w/rjKMrCEG0WWVk18fLw9MLNocdgiTx84EDXoWjBsTvUODBSLscE6db3XCgcHsQbZ/zV9e0ZU3VvH2JSj0NapBHuHz/9v4SgJbaXRylOx7go5NOz/tbb4dHauJMT89DqoC2i8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mp9+iKBJ; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcskL0YAfRh5NCiDnWUyzb8L9sb57EttdRGcn0/+dpZetd1DVeK8nP4ixwcOnv8eUM6rgzwJ8meKp7dH0j8Lk04gIbvh+Uq9XIOe7tPFuvvwmADboCEX+9yXCpFXooyC4eON0usUAGkq15XPmBD74FwiPYtkB+ceEqDMNKzIbTu09tpPBWOMYq5euDvUFBfIm4V/Z+ICActhOlODCVcYiCXtQJ9S83R7sWk9ldVEw16r9U8mYrIyfOU/USlL/axfaAbcySLpK47qWmL3sZTYTVVGneGwX9El/H3qtEfid5e8d0SUZMkHPjYAS52EmS6U8ar5kVQkazvWisi9q6fuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB0xfxKOUt0oL40JcOlRuak9YnceA0G9KZwV/LSwJ+I=;
 b=WD9YNG3lLqALpQWq+IKEQAGDBxZRl/u5ClEMwDDN97MIBinEI8IpNB8Ardf+UF8uDfuCtdikcs3Fj+fqMe7p353MBaJ6NwfUDGx0woCnBPEPg7UVQLPM4N3DrYWqEGDiBpTuYSZlkhdlWmtK1xvMxEDsObC/yhacv6/43qNJOHXXhVzDztAiEFImjYe94JE0hobnzfAjR8k0nGeuZ0sCLZSj3Hzm60sgxxK2vAB95VOzi3C5+umirdkYsP29JW4CQQa9a10BCQ1z2NJvQs801FaNIkPyDdLIZdX5E8F6iglQWX84wBm9ZeJGUQn8tthkIN3yKGuRQTafPJ736yMu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB0xfxKOUt0oL40JcOlRuak9YnceA0G9KZwV/LSwJ+I=;
 b=Mp9+iKBJitPo5LRZQLbhvYM6kIkxWujOzY5uRVm7yaTzPVgyvFMBdcw+k0XbT3MT3qxoKNdgc7TLN6HGs8KOfdLAKF6mEGQlDBP/p0ICLDyVuUKEYkHhL+lFQdXwD4n3xP1KE8uTO2+epiK4eee+PZcOu8mkUWweIUtZ08O+UgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9311.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 21 Feb
 2024 21:00:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 21:00:59 +0000
Date: Wed, 21 Feb 2024 16:00:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: root <root@hu-msarkar-hyd.qualcomm.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, quic_nitegupt@quicinc.com,
	quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Message-ID: <ZdZkgJjpkG3chDsg@lizhi-Precision-Tower-5810>
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 188edfd9-1df1-4b5f-2d39-08dc33203439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Jdqpul7GzcEeXeX/Lg5MxaLwm5+h03lV0yxgsf+NNqlWjynpth2PN5TLdd77VHF1OPb6r6pnDSLw8R37wWkAAocW23+hjZ0F7Ge8sCg2Bdxd0LBOG6pBaA9y2rvQ1hqMHwVxpQ+ONXhemacA+IqOImW7oyw+49V7VIV6TcbGnFoRN1UILOYZgcCPpkOZJR4SwliEL267Wu3yjYTtVLt36mnmny62ger2QN+XbHQi1k+4X8XkewtbkCwdhma/U6/yK9yyaGz1gOl8dn1nATrByZid9JJfkuctRyEW1OoKq2TVvw/vFP5l2azokcEdOtBHxVEs67Vu8jzIFXWG3ISyBQQimUe457Y8REEPaxVt4ubPhvQa899GWuYlqJm6dP0ZQhUtyU0/tqpJ8q/ml69NdBgSvtazGwpy1h75aGojXAEDe0iR7AdqyHfkRKubqBUkW91uPX9kBJwwJ8M4/ugGjyvBgASZJuBKgfTjdCaLm2z20Wv+K3RLlG/l8pKCoBhPNdt2h756afdICfe0swgg9qiSorTKlH3/mFesYv0C2N1dY18RoQXh80HMltTYnk+hngTj8FIJMMJMrVgCNs8CBBAwR5cQVZ4rVbf4AtlTi21HVoKw9m4CBBZ7Bzaf+8W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JkMS0XO/qbg0H0Lhesy7YVO80mVFdq8YPW5c+wwq8YgFSIJF5m0TDKAegB+?=
 =?us-ascii?Q?TjnER8MayHGKo2lzwVqe5cJXwZI6IcqxxYRLOf2kEVqxdsr/vAcGbpPo9SeC?=
 =?us-ascii?Q?Cj0eG1RvceXBG4iQle4/y9jDcobZ8qFIMICXLX1gLdq1xYzipm9f3T02NOST?=
 =?us-ascii?Q?hJmXxiMW/3iGrzCD2FfpuNEOVWVOBjByf5Ln5X+gluo19O4ZjKymAWBD7MOP?=
 =?us-ascii?Q?ZsX7lWfjgHD25yT9TaF592NKKnLs/MlBx/q3FpRRBCpLuiaFejK7Gn4+rqvB?=
 =?us-ascii?Q?RNLlqlToECAC65N6AqJd6GJCeiNPv2R5Iwebit08WUYggKUyTW0INAMRa7Gj?=
 =?us-ascii?Q?03j7oXVf8U2ymLqRu+Re8uOM/1X8D0x6C8FNHQ3GhgbecwHv3rJ32zltVPeq?=
 =?us-ascii?Q?18q2lfuHhfH+1DBHEQ63GN0fUzY9tj09nOv6G9MjOoCCkRb5LUG66OsLs8BW?=
 =?us-ascii?Q?sVfmdq3EPWwDx3Kyj0kl8PnhCjHMZeqSrYvixEeZdwj64Js3hmRDwkgd69F4?=
 =?us-ascii?Q?5m/pXlffV9xs8jGaZXMxmvlUNAT6BBjTiEep5wXKQlekzFOeHlS0tya5ijqN?=
 =?us-ascii?Q?GH2SbC0+OylO59HLgvwHmskrokBpa8g0kQ4IoMGw5CXdumegtBp/QS3qg5kY?=
 =?us-ascii?Q?Vx7X+c7uJOQyrbyb5Q4/p5JGpEAW1qhPonPJc8+sJsCTVVvkfAz8APeA5mY6?=
 =?us-ascii?Q?PkENI3sWEjGCWCN/8pojcVZWuXJKu64bfOBbFJsgyz94H+TnnQO6ODzQ0A1P?=
 =?us-ascii?Q?FKOAeXyEXxLRLl/PGqgVUScOwDpStz8oJhuQ2x3Tl/T1o+OCgrr5G1fo5ml0?=
 =?us-ascii?Q?OdBL7HSbTpS4pHhlOzglbvAwhf8qxjFW4ASzDPlFd9ZmHrAj2VPnlGlyVV6r?=
 =?us-ascii?Q?2RH0CdvidDc5LIYxrpR/K0jGjT5d7rpmHItR5dgmllLK9Up7MU6ZLrio0yrx?=
 =?us-ascii?Q?Cdmjjlj2RLbS/Ve431GJ60wte+9wxgfpNa93esfcTDl2wpsZQNyoKQJLNQ/D?=
 =?us-ascii?Q?fJ83rX5RHWgudPBxGd6EvgtzPKrjZGcOovhPuhcj/vEttyWPmNIM/2p5PEn2?=
 =?us-ascii?Q?LjkyVJECktikvU7xBnxu9hwAcuQHvjSDk05lm9HRLJ33ii/jzPJ+YObC9PMt?=
 =?us-ascii?Q?GQJ8QxLk9oHbMJoqscs5D47b4nOp5AB9Fo8CG1gacLJfHzz5jNDW1sSAseVL?=
 =?us-ascii?Q?ESZkZoggtZ0xgpwnImspuQWhks3y1io7jAHfixp3K3wX5hexTcCfMyA8WW5h?=
 =?us-ascii?Q?ySbgIf2umduurAiG/X3pgL+3dguU6UQt86H7yxpVs7UOzkAt0ed+Q3NIFpou?=
 =?us-ascii?Q?iIQzUWE3MZweOnK/1XFtaTefFTBgaEfkISIPz99yQIpW7i6n3OLVuQTZTtKO?=
 =?us-ascii?Q?D0hY6pp48sjJgdUIlthsIFWCaXqjd6xVXqTenVb19lDokwdB/vhVGGXQdRh3?=
 =?us-ascii?Q?wpxSYW9P8UK1PGq+KHJu9QUjnZD7ySmm8mMYgDxnebdGhMAkKvAEbJUtchli?=
 =?us-ascii?Q?Z9a5iduq0JEYKnHNSlCrAVk6QHxaEqEsIaExhHl4iUYNuvue+h2Efs2u7A1C?=
 =?us-ascii?Q?JpZAKc2Y3XY20p0p9Nk+U9vK3C7rj74xE06zXzNM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188edfd9-1df1-4b5f-2d39-08dc33203439
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:00:59.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRDryNgY47stddMX6/pZ/NItLLPMrDjxHToFj72DEYid2WDTEPA/ZU4xH7A/G3wgYrGt2wSxhuzk+yzuUmC5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9311

On Wed, Feb 21, 2024 at 07:34:04PM +0530, root wrote:
> From: Nitesh Gupta <nitegupt@quicinc.com>
> 
> Synopsys Controllers provide capabilities to detect various controller
> level errors. These can range from controller interface error to random
> PCIe configuration errors. This patch intends to add support to detect
> these errors and report it to userspace entity via sysfs, which can take
> appropriate actions to mitigate the errors.
> 
> Signed-off-by: Nitesh Gupta <nitegupt@quicinc.com>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |  26 ++
>  drivers/pci/controller/dwc/pcie-qcom.c       | 350 +++++++++++++++++++
>  2 files changed, 376 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..cd45f9a2f9bc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -223,6 +223,32 @@
>  
>  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
>  
> +
> +/*
> + * Error Reporting DBI register
> + */
> +#define DBI_DEVICE_CONTROL_DEVICE_STATUS	0x78
> +#define DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG	0x8c
> +#define DBI_INTERFACE_TIMER_STATUS		0x938
> +#define DBI_SAFETY_MASK_OFF			0x960
> +#define DBI_SAFETY_STATUS			0x964
> +
> +#define DBI_ADV_ERR_CAP_CTRL_OFF		0x18
> +#define DBI_ROOT_ERR_CMD_OFF			0x2c
> +
> +/*
> + * RAS-DP register
> + */
> +#define PCIE_RASDP_ERROR_MODE_EN_REG		0x28
> +#define RASDP_ERROR_MODE_EN			BIT(0)
> +
> +/*
> + * Interface Timer register
> + */
> +#define PCIE_INTERFACE_TIMER_CONTROL		0x930
> +#define INTERFACE_TIMER_EN			BIT(0)
> +#define INTERFACE_TIMER_AER_EN			BIT(1)
> +
>  /*
>   * The default address offset between dbi_base and atu_base. Root controller
>   * drivers are not required to initialize atu_base if the offset matches this
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..138e3b08d4b9 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> +#include <linux/device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
> @@ -68,6 +69,73 @@
>  #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
>  #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
>  
> +/* Error Reporting Parf Registers */
> +#define PARF_INT_ALL_STATUS			0x224
> +#define PARF_INT_ALL_CLEAR			0x228
> +#define PARF_INT_CLEAR				0x21c
> +#define PARF_INT_STATUS			0x220
> +#define PARF_INT_ALL_MASK			0x22c
> +#define PARF_INT_ALL_2_CLEAR			0x504
> +#define PARF_INT_ALL_2_STATUS			0x500
> +#define PARF_INT_ALL_3_CLEAR			0x2e14
> +#define PARF_INT_ALL_3_STATUS			0x2e10
> +#define PARF_INT_ALL_4_CLEAR			0x2dd8
> +#define PARF_INT_ALL_4_STATUS			0x2dd0
> +#define PARF_INT_ALL_5_CLEAR			0x2ddc
> +#define PARF_INT_ALL_5_STATUS			0x2dd4
> +#define PARF_CFG_SAFETY_INT_MASK_CTRL		0x2c60
> +
> +
> +#define PCIE_AER_EXT_CAP_ID			0x01
> +#define PCI_EXT_CAP_RASDP_ID			0x0b
> +
> +/* Interrupt Masks */
> +#define CFGPCIE_INT_ALL_STATUS_MASK		0x3ff3e
> +#define CFGPCIE_PARF_INT_STATUS_MASK		0x1b
> +#define CFGPCIE_INTERFACE_TIMER_STATUS_MASK	0xe7b
> +#define CFGPCIE_INT_ALL_2_STATUS_MASK		GENMASK(24, 0)
> +#define CFGPCIE_INT_ALL_3_STATUS_MASK		GENMASK(31, 0)
> +#define CFGPCIE_INT_ALL_4_STATUS_MASK		GENMASK(31, 0)
> +#define CFGPCIE_INT_ALL_5_STATUS_MASK		GENMASK(31, 0)
> +
> +/* PCI_INTERRUPT_LINE register field */
> +#define SERR_EN					BIT(17)
> +
> +/* DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG register fields */
> +#define PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN		BIT(0)
> +#define PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN	BIT(1)
> +#define PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN	BIT(2)
> +
> +/* DBI_DEVICE_CONTROL_DEVICE_STATUS register fields */
> +#define PCIE_CAP_UNSUPPORT_REQ_REP_EN		BIT(3)
> +#define PCIE_CAP_FATAL_ERR_REPORT_EN		BIT(2)
> +#define PCIE_CAP_NON_FATAL_ERR_REPORT_EN	BIT(1)
> +#define PCIE_CAP_CORR_ERR_REPORT_EN		BIT(0)
> +
> +/* PARF_CFG_SAFETY_INT_MASK_CTRL register fields */
> +#define CFG_SAFETY_UNCORR_INT_MASK		BIT(0)
> +#define CFG_SAFETY_CORR_INT_MASK		BIT(1)
> +
> +/* DBI_ADV_ERR_CAP_CTRL_OFF register fields */
> +#define ECRC_GEN_EN				BIT(6)
> +#define ECRC_CHECK_EN				BIT(8)
> +
> +/* DBI_ROOT_ERR_CMD_OFF register fields */
> +#define CORR_ERR_REPORTING_EN			BIT(0)
> +#define NON_FATAL_ERR_REPORTING_EN		BIT(1)
> +#define FATAL_ERR_REPORTING_EN			BIT(2)
> +
> +/* DBI_SAFETY_MASK_OFF register fields */
> +#define SAFETY_INT_MASK			GENMASK(5, 0)
> +
> +/* DBI_SAFETY_STATUS register fields */
> +#define PCIE_RASDP_UNCORR_ERR			BIT(0)
> +#define PCIE_IFACE_TMR_ERR			BIT(1)
> +#define PCIE_CDM_CHK_ERR			BIT(2)
> +#define PCIE_AER_UNCORR_ERR			BIT(3)
> +#define PCIE_AER_CORR_ERR			BIT(4)
> +#define PCIE_RASDP_CORR_ERR			BIT(5)
> +
>  /* PARF_SYS_CTRL register fields */
>  #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>  #define MST_WAKEUP_EN				BIT(13)
> @@ -231,6 +299,24 @@ struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  };
>  
> +enum qcom_pcie_fault_code {
> +	RASDP_UNCORR_ERROR,	/* RASDP uncorrectable error */
> +	RASDP_CORR_ERROR,	/* RASDP correctable error */
> +	CDM_REG_CHK_ERROR,	/* CDM register check error */
> +	INTERFACE_TIMER_ERROR,	/* PCIe local bus interface timer error */
> +	PCIE_SPURIOUS_INT,	/* Spurious Interrupt received */
> +	MAX_PCIE_SAFETY_FAULT	/* Maximum PCIe fault source code supported */
> +};
> +
> +static const char * const pcie_fault_string[] = {
> +	"RASDP_Uncorr_Error",
> +	"RASDP_Corr_Error",
> +	"CDM_Reg_Chk_Error",
> +	"Interface_Timer_Error",
> +	"PCIe_Spurious_Interrupt",
> +	"TOTAL_PCIE_FAULTS",
> +};
> +
>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -243,6 +329,10 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	int global_irq;
> +	spinlock_t safety_lock;
> +	u32 pcie_fault[MAX_PCIE_SAFETY_FAULT];
> +	u32 pcie_fault_total;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -959,9 +1049,94 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static void qcom_pcie_enable_error_reporting_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val, offset;
> +
> +	/* Clear all the interrupts before we enable it */
> +	writel(0, pci->dbi_base + DBI_SAFETY_STATUS);
> +	writel(0, pci->dbi_base + DBI_INTERFACE_TIMER_STATUS);
> +
> +	/* Enable interrupts which are aggregated using GLOBAL_INT */
> +	writel(CFGPCIE_INT_ALL_STATUS_MASK, pcie->parf + PARF_INT_ALL_CLEAR);
> +	writel(CFGPCIE_PARF_INT_STATUS_MASK, pcie->parf + PARF_INT_CLEAR);
> +	writel(CFGPCIE_INT_ALL_2_STATUS_MASK, pcie->parf + PARF_INT_ALL_2_CLEAR);
> +	writel(CFGPCIE_INT_ALL_3_STATUS_MASK, pcie->parf + PARF_INT_ALL_3_CLEAR);
> +	writel(CFGPCIE_INT_ALL_4_STATUS_MASK, pcie->parf + PARF_INT_ALL_4_CLEAR);
> +	writel(CFGPCIE_INT_ALL_5_STATUS_MASK, pcie->parf + PARF_INT_ALL_5_CLEAR);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = readl(pci->dbi_base + PCI_INTERRUPT_LINE);
> +	val |= SERR_EN;
> +	writel(val, pci->dbi_base + PCI_INTERRUPT_LINE);
> +
> +	val = readl(pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
> +	val |= (PCIE_CAP_CORR_ERR_REPORT_EN | PCIE_CAP_NON_FATAL_ERR_REPORT_EN |
> +			PCIE_CAP_FATAL_ERR_REPORT_EN | PCIE_CAP_UNSUPPORT_REQ_REP_EN);
> +	writel(val, pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
> +
> +	val = readl(pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
> +	val |= (PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN | PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN |
> +			PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN);
> +	writel(val, pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	/* Enable RAS-DP Interrupts */
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_RASDP_ID);
> +	val = readl(pci->dbi_base + offset + PCIE_RASDP_ERROR_MODE_EN_REG);
> +	val |= RASDP_ERROR_MODE_EN;
> +	writel(val, pci->dbi_base + PCIE_RASDP_ERROR_MODE_EN_REG);
> +
> +	/* Enable CDM Check */
> +	val = readl(pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
> +	/* Enable continuous CMD register check mode */
> +	val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS;
> +	/* Start the CDM register check */
> +	val |= PCIE_PL_CHK_REG_CHK_REG_START;
> +	/* Enable comparison CDM register check mode */
> +	val |= PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR;
> +	/* Enable logic CDM register check mode */
> +	val |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
> +	writel(val, pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
> +
> +	/* Interface Timer Enable */
> +	val = readl(pci->dbi_base + PCIE_INTERFACE_TIMER_CONTROL);
> +	val |=  (INTERFACE_TIMER_EN | INTERFACE_TIMER_AER_EN);
> +	writel(val, pci->dbi_base + PCIE_INTERFACE_TIMER_CONTROL);

You defined DBI_* at pcie-designware.h. Supposed it should be same for
all chips that use dwc controller. So I think you should put common code
into pcie-designware.c to avoid duplicate the same logic at every chip
vendor's driver.

Frank


> +
> +	/* Enable safety correctable and uncorrectable error reporting */
> +	val = readl(pcie->parf + PARF_CFG_SAFETY_INT_MASK_CTRL);
> +	val |= (CFG_SAFETY_UNCORR_INT_MASK | CFG_SAFETY_CORR_INT_MASK);
> +	writel(val, pcie->parf + PARF_CFG_SAFETY_INT_MASK_CTRL);
> +
> +	/* Enable CRC check and generation */
> +	offset = dw_pcie_find_ext_capability(pci, PCIE_AER_EXT_CAP_ID);
> +	val = readl(pci->dbi_base + offset + DBI_ADV_ERR_CAP_CTRL_OFF);
> +	val |= (ECRC_GEN_EN | ECRC_CHECK_EN);
> +	writel(val, pci->dbi_base + offset + DBI_ADV_ERR_CAP_CTRL_OFF);
> +
> +	/* Enable AER */
> +	val = readl(pci->dbi_base + offset + DBI_ROOT_ERR_CMD_OFF);
> +	val |= (CORR_ERR_REPORTING_EN | NON_FATAL_ERR_REPORTING_EN
> +		| FATAL_ERR_REPORTING_EN);
> +	writel(val, pci->dbi_base + offset + DBI_ROOT_ERR_CMD_OFF);
> +
> +	/* Enable interrupts */
> +	val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +	val &= ~(SAFETY_INT_MASK);
> +	writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +
> +	/* Disable Legacy Interrupts */
> +	writel(0, pcie->parf + PARF_INT_ALL_MASK);
> +}
> +
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	qcom_pcie_clear_hpc(pcie->pci);
> +	qcom_pcie_enable_error_reporting_2_7_0(pcie);
>  
>  	return 0;
>  }
> @@ -1416,6 +1591,130 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	}
>  }
>  
> +static void qcom_pcie_check_spurious_int(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 *pcie_fault = pcie->pcie_fault;
> +	struct device *dev = pci->dev;
> +	struct kobject *kobj_ref = &dev->kobj;
> +	u32 val;
> +
> +	val = readl(pci->dbi_base + DBI_INTERFACE_TIMER_STATUS);
> +	if (val & CFGPCIE_INTERFACE_TIMER_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_ALL_STATUS);
> +	if (val & CFGPCIE_INT_ALL_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_STATUS);
> +	if (val & CFGPCIE_PARF_INT_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_ALL_2_STATUS);
> +	if (val & CFGPCIE_INT_ALL_2_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_ALL_3_STATUS);
> +	if (val & CFGPCIE_INT_ALL_3_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_ALL_4_STATUS);
> +	if (val & CFGPCIE_INT_ALL_4_STATUS_MASK)
> +		return;
> +
> +	val = readl(pcie->parf + PARF_INT_ALL_5_STATUS);
> +	if (val & CFGPCIE_INT_ALL_5_STATUS_MASK)
> +		return;
> +
> +	dev_err(pci->dev, "PCIe Spurious Interrupt");
> +	pcie_fault[PCIE_SPURIOUS_INT]++;
> +	pcie->pcie_fault_total++;
> +	sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
> +}
> +
> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> +{
> +	struct qcom_pcie *pcie = data;
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 *pcie_fault = pcie->pcie_fault;
> +	struct device *dev = pci->dev;
> +	struct kobject *kobj_ref = &dev->kobj;
> +	unsigned long irqsave_flags;
> +	u32 val, int_status;
> +
> +	spin_lock_irqsave(&pcie->safety_lock, irqsave_flags);
> +
> +	int_status = readl(pci->dbi_base + DBI_SAFETY_STATUS);
> +	writel(0, pci->dbi_base + DBI_SAFETY_STATUS);
> +
> +	if (int_status) {
> +		dev_err(pci->dev, "global interrupt fired status: %u", int_status);
> +
> +		if (int_status & PCIE_RASDP_UNCORR_ERR) {
> +			dev_err(pci->dev, "RASDP uncorrectable error triggered");
> +			pcie_fault[RASDP_UNCORR_ERROR]++;
> +			pcie->pcie_fault_total++;
> +			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
> +
> +			/*
> +			 * rasdp_uncorr_err ends up triggering a
> +			 * pcie_uncorr error continuously. So masking
> +			 * pcie_uncorr interrupts .
> +			 */
> +			val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +			val |= PCIE_AER_UNCORR_ERR;
> +			writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +		}
> +
> +		if (int_status & PCIE_CDM_CHK_ERR) {
> +			dev_err(pci->dev, "CDM error triggered");
> +			val = readl(pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
> +
> +			if (val & PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR) {
> +				pcie_fault[CDM_REG_CHK_ERROR]++;
> +				pcie->pcie_fault_total++;
> +				sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
> +
> +				/*
> +				 * cdm_chk_err injection results in a continuous
> +				 * interrupt storm on certain targets, so masking it.
> +				 */
> +				val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +				val |= (PCIE_CDM_CHK_ERR | PCIE_AER_UNCORR_ERR);
> +				writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +			}
> +		}
> +
> +		if (int_status & PCIE_IFACE_TMR_ERR) {
> +			dev_err(pci->dev, "Iface Timeout error triggered");
> +			pcie_fault[INTERFACE_TIMER_ERROR]++;
> +			pcie->pcie_fault_total++;
> +			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
> +
> +			/*
> +			 * interface_timer_err injection results in a continuous
> +			 * interrupt storm on certain targets, so masking it.
> +			 */
> +			val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +			val |= (PCIE_IFACE_TMR_ERR | PCIE_AER_UNCORR_ERR);
> +			writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
> +		}
> +
> +		if (int_status & PCIE_RASDP_CORR_ERR) {
> +			dev_err(pci->dev, "RASDP correctable error triggered");
> +			pcie_fault[RASDP_CORR_ERROR]++;
> +			pcie->pcie_fault_total++;
> +			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
> +		}
> +	} else {
> +		qcom_pcie_check_spurious_int(pcie);
> +	}
> +
> +	spin_unlock_irqrestore(&pcie->safety_lock, irqsave_flags);
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>  {
>  	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
> @@ -1438,6 +1737,40 @@ static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>  	return 0;
>  }
>  
> +static ssize_t qcom_pcie_error_report_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	unsigned int i;
> +	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(dev);
> +	u32 *pcie_fault = pcie->pcie_fault;
> +	size_t len = 0;
> +
> +	for (i = 0; i < MAX_PCIE_SAFETY_FAULT; i++) {
> +		if (pcie_fault_string[i])
> +			len += sysfs_emit_at(buf, len, "%s: %lu\n",
> +					pcie_fault_string[i],
> +					pcie_fault[i]);
> +	}
> +
> +	len += sysfs_emit_at(buf, len, "%s: %lu\n",
> +					pcie_fault_string[i],
> +					pcie->pcie_fault_total);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(qcom_pcie_error_report);
> +
> +static struct attribute *qcom_pcie_attrs[] = {
> +	&dev_attr_qcom_pcie_error_report.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group qcom_pcie_attribute_group = {
> +	.attrs = qcom_pcie_attrs,
> +	.name = "qcom_pcie"
> +};
> +
>  static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -1496,6 +1829,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->global_irq = platform_get_irq_byname(pdev, "global");
> +	if (pcie->global_irq < 0) {
> +		ret = pcie->global_irq;
> +		goto err_pm_runtime_put;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, pcie->global_irq, NULL,
> +				qcom_pcie_global_irq_thread,
> +				IRQF_ONESHOT,
> +				"global_irq", pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to request Global IRQ\n");
> +		goto err_pm_runtime_put;
> +	}
> +
>  	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
>  	if (IS_ERR(pcie->parf)) {
>  		ret = PTR_ERR(pcie->parf);
> @@ -1551,6 +1899,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
>  
> +	sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
> +
>  	return 0;
>  
>  err_phy_exit:
> -- 
> 2.40.1
> 

