Return-Path: <linux-pci+bounces-4295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18186DB02
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 06:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA621C21D00
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5A5026A;
	Fri,  1 Mar 2024 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fisCGUDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720050255;
	Fri,  1 Mar 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270593; cv=fail; b=e2gYmWNvqRwCXBIUncFWwHi4GNkKAwcLO7nZNUlxTbiE/rEyBRtjqxvde0TNnNR+y7b8DFuMHOLatuGfSncZ8qvRCBxCcN9kp69tm96U+97AN7pkrvqafWugBJhwLv//PWALOxBtz7jfiGNHoBcfqm5pW1PEgrfkov6+ilr7HfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270593; c=relaxed/simple;
	bh=mrBur8oBuL4Cta2h6xPPkAtc5pvzSjiS8Xr/6JU8RgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oojyJ9KRtxvnFtdyz5GFr1kKsPHfxTYm97vJ37kODYt7jc/unHh2h6DhoGsgejR7H5vQfuqayTQtRWHVX8fqiQ25CFM01ZmnEsVjVqDeZ6C5UxABc7pcI3G31We78X90SGfub/fBpg26ctPLfJw3AUs0a10uGYiV/ZM1G9TS9VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fisCGUDw; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRrU/LylR1xk9w7s1vMZ9VUpYDd0iHIRsdmvFnpa5SmlUskoFsOQMJZdeDrZxZW4ocIGy1fvXvpiRZC8PwP+p8CT7YaHX48EsngNfWGh9WX/3RI8HM61qJeidhFz75Cn0e/47cCf7Ul60YImtzYToYYzBqPx4GhFnCgQS5It4OEbNpH1ZWU9vjKTmN15t6kkEMAnc6JD5LssBW78ALxlVjxas5ri6EVW+RLcMEz3747iBKpE14t6xJ+kNm8geIJ/+2NJP0mGzqGX5IkeveChpjFQthkAN1hZwbxreR7x3qwojOft6rNbVm3/DBaVzwHq500XImkAdSof67wRXHV4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oiU+emFMFvoo4KIGYbwf6/CE51dOs8CynZCIBbbpEA=;
 b=Jxw6cVq9LzrURN3wKhjl6qh886QnvsFAypS007jTdbzQC70AM9YtOTgeo1geGOcmwPCOiT1q4yVNwQkP7VO+Hng6H+/G/2HVUGNeP9AJfuxx0rXqfJznGzaDEk6L6Mr/6QjXhLGybNzunleQBPrspXS9rFLafdM9UinwM37sENdyXYUqARQY/7vUDq9nxcEcId8qHCLbQVFgCFRC51MGxInMM6NYjIACSszNiTk/LppaQc/o4C4lRlRErNKEnHaM7lkdo3nJogA+ZkU2y03ZOwHT3YWfPAzm31Uni8sgXCWh5CQ0Pb16s9QPolJRlU2fb6vO0o+o6912EcO603UCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oiU+emFMFvoo4KIGYbwf6/CE51dOs8CynZCIBbbpEA=;
 b=fisCGUDwei6Zq3wArNF7TRC1YBNwhbTjYghEzcAfr4q/mbEBV7XP6tEfssppA8AHTduANlY2WCzsxF95yrF4G900U9KsSzIxr2CQouLTQNdp1UQJcqLC1a2xrhJV+Wjozo+0BHh/ntru31pGMhh811VtXdLufsMHgfEuQ6g5EP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 05:23:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 05:23:08 +0000
Date: Fri, 1 Mar 2024 00:22:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: dwc: refactor common code
Message-ID: <ZeFmM+lV2xJgGkJK@lizhi-Precision-Tower-5810>
References: <20240301051220.20917-1-quic_schintav@quicinc.com>
 <20240301051220.20917-2-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301051220.20917-2-quic_schintav@quicinc.com>
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4b037f-af04-4218-41c1-08dc39afae0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMGMgsH1qxLU4DMV7oWXG6O6ujhHSCapn8kjMuOUCXrg/yytS8Iz+Psg6ExW9Im4/kcRxw677AQn2ZRnvkrTc4GSq0t/KvjykMD6WqlKLFnT+fIP+RkLtjQUgwom0LqR0or9Iyz6BAfqPVPy1/2t6JKMAjtTU8EZMIC4o+YEbJ4omZ+gA5yWqDMKL1RZp69r69292X1vDTGGhQcHJkg+Jx6nuB2EBaFBShTuR9rlr5+lonFAqJynq6nbnpOz7XOXIrUKOzbH90xoAba1aCXL0Oakaq2LAbpGRFsvWbo+saz+dgzRcQGdyN0uYDCnJ5lMwMUPzOzUYd7nyjPJYoSX2EhGOFlDCPo3N5iUUnR/OzQwYCHFMlT2atOVfiImj2ZkmSAsYGFIyZbkZES6ong8fyUCQxjr+3ynXa+9hv3oHEQmrdYSrLAiOqYik7OKOLe63EgG5c00MH7W8227XpzXZcEAyWpgZoUlb8EG4slkthRaPXDyCOkSXyMSE2MfXdD8t1gZ62alcmaXFWqb3QBUjONoCZdSqrEfFGVjvc4Ag5N+YGFjM4u8/oCH1iCbrLq6TzGvcuC/axBaGuNKaBz21fK62nvCv+xwNNUaA2Ij3C6tNNJq+Z+qrB1NmBZtbrE+MgdZkzKMqhEl139X22KvtL/d0vbEHnCgqOQSeqt9Wr+hcwpYRwcnJXWHZdULJy0H1LK4sBu3tclzJAFWBKjzfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BP3l4XJiqf7/AvXccNVhR710OKczb1d0XVsObw+MXOdKtYwprr9HTdxybSW/?=
 =?us-ascii?Q?B5E1BjU06EKZIlUpClA+Jpg/rpjfFqqpmELxgn23qEjBXol76wDzSuHcT1LI?=
 =?us-ascii?Q?AgF3MZ2qB3DdXtdCqB9YmsUNGomB1g5UEIaMrJIqsvZ8CzxGteXadjTSHeWR?=
 =?us-ascii?Q?p1lxGupH3EqjJwQasMgW0uFcs5STeqoNz0y9bQ/monGMj9yePLr693NHUhBO?=
 =?us-ascii?Q?/GwztMRgHM0YNrgLphJSZN4GQkdZh/dy9NuqdHKzDoCM0rXxPu3k+mOP/l2T?=
 =?us-ascii?Q?+eQolCAGtHwyRaxZGWL6MA9Qfzb8xSaUe0KcrlgS5NZnyiiLkQAlgFnscWs4?=
 =?us-ascii?Q?TvINfc15o974v1PZwv3FuCPvRabtFTczWT5uI5pT++uDpD4I4z80j1ymhDc1?=
 =?us-ascii?Q?4n054aZvqUOXsM/yXyZELaGNMeZs7Wuovjos8DR1cCFszKMaJ+/kiWvimJ93?=
 =?us-ascii?Q?3wlIwdnpk8rPiIbrsTYHTOYBBzQZyqse+wRfd9wXqxAEFgyjTHHxutGrxPif?=
 =?us-ascii?Q?VL8zZLTwyUFzaURXJKaNy6tEoCg5BAwNA/idwikCmlha7UXPd7oOoXr19M5Q?=
 =?us-ascii?Q?DCQo0As+YDPaonCpk64+M8ZFYzhomeh4KxLOyUa+4kLIzkyTUdk8yBe4m1Wj?=
 =?us-ascii?Q?hoWCoi5vq0K5w4M4GlDord5f7Sx0/oMisM+EkpXwjcs7Y+Rli+judNlLXvfk?=
 =?us-ascii?Q?7P8P1ySchDypLYnwpSir6PwGnqqg996HvV3QSdAJZeQ+u3lR0xrQUKlZGmUj?=
 =?us-ascii?Q?umDZmFFfyu7J5H5Hc5uEabSGI/C4/c+XGD0khiMIvhaISBvWSjRwZuguDWhn?=
 =?us-ascii?Q?xpGJQ5ImA5X2sB/2LvCxZfS129aYBoRfo6SoaRHulCUflP31+CFxEhj4kmhM?=
 =?us-ascii?Q?+7EeQdUClRpCVzGmbkKEwmxk29KxBcPi7Ro5nVo1UDDQDFw9/kHTqz4Pz0pm?=
 =?us-ascii?Q?Atm4VDWfa020ptf9WMbl48KnJDtK2OCJrWlGgekmmAEzaWbj8dtHMahnXqTp?=
 =?us-ascii?Q?selfr77fkfhO6jrcptbdoP6qxoVSBBm9RAr9GgnxsnynTOfZWpY9LmEr+pVK?=
 =?us-ascii?Q?biLDUmYeAmkt/dQJIvF0nnTSWwKRmXJ4zmPtgshc/WaPZDoa/TbN9fHsyrUG?=
 =?us-ascii?Q?Ip9BsWCNwhDXUb6kEeL22Aa6L4ZiwznSUqeoEBJ86SKEeMuipR2wczBxXuUN?=
 =?us-ascii?Q?O8Wk/nGx58JBLlxJASTOPumhkobHohAdJl3uYCK0rsitj6miy5WMGXKHwsXK?=
 =?us-ascii?Q?t61bUVlDYcKdNq111Drv/0rJmpXSc1CYpRJ8o2S6mXFV3qMzU0vjvL2mb1s3?=
 =?us-ascii?Q?5chJBBmJd2XJpvgwilKI3H/horaQT2CUiqF6TPGQ1ztpa0McuGlHdoW/GVig?=
 =?us-ascii?Q?EMDqiXjF2v3xyPzVPKVMCQ4pA6ZRFJ5yGpZXpHMAlo967LIZ3LQ/mMYhj72x?=
 =?us-ascii?Q?bgieHoK6dYE1ShbrGDEOiTmKvboir0twzB1BFwk/Vg5ICTqF+OnUwuzq1MRM?=
 =?us-ascii?Q?fwkKcytQSBpJMJydLOBppvgATOxWeYaYKw9pLSOxqynbVUXshYfKnH+cqLTK?=
 =?us-ascii?Q?ZLwg93QH8y0PpBKqraQwtfUKAZHOE7tk8WrgpKoy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4b037f-af04-4218-41c1-08dc39afae0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 05:23:08.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujk90Yz2wnpLKP38ZcxfJISevGuh9Qb+zNV3uoWtCTA/J6v/NHwM0pxQAY9NksG+lYtwxbf7jyEuVSh+XH9tgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860

tag should be  PCI: qcom:

Frank

On Thu, Feb 29, 2024 at 09:11:34PM -0800, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common repository. This acts as placeholder
> for common source code for both drivers avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  5 ++
>  drivers/pci/controller/dwc/Makefile        |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c | 85 ++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.h | 30 ++++++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 39 +---------
>  drivers/pci/controller/dwc/pcie-qcom.c     | 67 ++---------------
>  6 files changed, 133 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..41d2746edc5f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -265,12 +265,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
>  
> +config PCIE_QCOM_CMN
> +	bool
> +
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller (host mode)"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select CRC8
> +	select PCIE_QCOM_CMN
>  	help
>  	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> @@ -281,6 +285,7 @@ config PCIE_QCOM_EP
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCIE_QCOM_CMN
>  	help
>  	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
>  	  to work in endpoint mode. The PCIe controller uses the DesignWare core
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bac103faa523..022dc73c38a5 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> +obj-$(CONFIG_PCIE_QCOM_CMN) += pcie-qcom-cmn.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> new file mode 100644
> index 000000000000..0f8d004fbc79
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/pci.h>
> +#include <linux/interconnect.h>
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +#include "pcie-qcom-cmn.h"
> +
> +
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> +
> +
> +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	int ret = 0;
> +
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);
> +
> +	icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_get_resource);
> +
> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	int ret = 0;
> +
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);
> +
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_init);
> +
> +void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	u32 offset, status;
> +	int speed, width;
> +	int ret;
> +
> +	if (!icc_mem)
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	ret = icc_set_bw(icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +	if (ret)
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_update);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> new file mode 100644
> index 000000000000..8794dbd4775c
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/pci.h>
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +
> +#ifdef CONFIG_PCIE_QCOM_CMN
> +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
> +void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
> +#else
> +static inline int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	return 0;
> +}
> +
> +static inline int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	return 0;
> +}
> +
> +static inline void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +}
> +#endif
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 36e5e80cd22f..ce6343426de8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -25,6 +25,7 @@
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> +#include "pcie-qcom-cmn.h"
>  
>  /* PARF registers */
>  #define PARF_SYS_CTRL				0x00
> @@ -137,9 +138,6 @@
>  #define CORE_RESET_TIME_US_MAX			1005
>  #define WAKE_DELAY_US				2000 /* 2 ms */
>  
> -#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> -		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> -
>  #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
>  
>  enum qcom_pcie_ep_link_status {
> @@ -278,28 +276,6 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
>  	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
>  }
>  
> -static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> -{
> -	struct dw_pcie *pci = &pcie_ep->pci;
> -	u32 offset, status;
> -	int speed, width;
> -	int ret;
> -
> -	if (!pcie_ep->icc_mem)
> -		return;
> -
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> -
> -	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> -	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> -
> -	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret)
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> -}
> -
>  static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
>  	struct dw_pcie *pci = &pcie_ep->pci;
> @@ -325,14 +301,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_phy_exit;
>  
> -	/*
> -	 * Some Qualcomm platforms require interconnect bandwidth constraints
> -	 * to be set before enabling interconnect clocks.
> -	 *
> -	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> -	 * for the pcie-mem path.
> -	 */
> -	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	ret = qcom_pcie_cmn_icc_init(pci, pcie_ep->icc_mem);
>  	if (ret) {
>  		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>  			ret);
> @@ -616,7 +585,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> -	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> +	ret = qcom_pcie_cmn_icc_get_resource(&pcie_ep->pci, pcie_ep->icc_mem);
>  	if (IS_ERR(pcie_ep->icc_mem))
>  		ret = PTR_ERR(pcie_ep->icc_mem);
>  
> @@ -643,7 +612,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> -		qcom_pcie_ep_icc_update(pcie_ep);
> +		qcom_pcie_cmn_icc_update(pci, pcie_ep->icc_mem);
>  		pci_epc_bme_notify(pci->ep.epc);
>  	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>  		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ce2a3bd932b..57a08294c561 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -32,6 +32,7 @@
>  #include <linux/types.h>
>  
>  #include "../../pci.h"
> +#include "pcie-qcom-cmn.h"
>  #include "pcie-designware.h"
>  
>  /* PARF registers */
> @@ -147,9 +148,6 @@
>  
>  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>  
> -#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> -		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> -
>  #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
>  struct qcom_pcie_resources_1_0_0 {
>  	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
> @@ -1363,59 +1361,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = qcom_pcie_start_link,
>  };
>  
> -static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -	int ret;
> -
> -	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> -	if (IS_ERR(pcie->icc_mem))
> -		return PTR_ERR(pcie->icc_mem);
> -
> -	/*
> -	 * Some Qualcomm platforms require interconnect bandwidth constraints
> -	 * to be set before enabling interconnect clocks.
> -	 *
> -	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> -	 * for the pcie-mem path.
> -	 */
> -	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -	u32 offset, status;
> -	int speed, width;
> -	int ret;
> -
> -	if (!pcie->icc_mem)
> -		return;
> -
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> -
> -	/* Only update constraints if link is up. */
> -	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> -		return;
> -
> -	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> -	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> -
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> -	}
> -}
> -
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>  {
>  	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
> @@ -1524,7 +1469,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = qcom_pcie_icc_init(pcie);
> +	ret = qcom_pcie_cmn_icc_get_resource(pcie->pci, pcie->icc_mem);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
> +	ret = qcom_pcie_cmn_icc_init(pcie->pci, pcie->icc_mem);
>  	if (ret)
>  		goto err_pm_runtime_put;
>  
> @@ -1546,7 +1495,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_cmn_icc_update(pcie->pci, pcie->icc_mem);
>  
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
> @@ -1613,7 +1562,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		pcie->suspended = false;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_cmn_icc_update(pcie->pci, pcie->icc_mem);
>  
>  	return 0;
>  }
> -- 
> 2.43.2
> 

