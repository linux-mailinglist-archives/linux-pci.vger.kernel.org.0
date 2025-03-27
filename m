Return-Path: <linux-pci+bounces-24858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869EA735BB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0CB3B3CB1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39589190692;
	Thu, 27 Mar 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C92qyCSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F0140E30;
	Thu, 27 Mar 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089766; cv=fail; b=VXOLeBVcJT3HFilnHAtOWw9pBRPFWqvA9No68S8V2vzZZLaQe1ujP2kupvSsjgRTxzMx8Az1+hzbruuTCb5NnTDc5BbOfwp7Z60P7Ov5dMtxXYQzmgywQm92MIkKFUJKk7B1pD9SqjWAEksh6uzhcmzVXhZtzrw2h6UkRYLKTVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089766; c=relaxed/simple;
	bh=w0eEp+IRklFNB5t56CMrp8NAevN3B9bHK7kozic8PNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OHO2p7/gHnTzh0gLIwx5ErWGF+8eKrSzDqcuDFfUn15IVqViw+MpH1G2O6I4AE4iy7/FW5rSMN6mTUhzY6ZV+6/Y+hogczZ4JjgVuPKB4HIYQyd0Shw40lFlXfwGGgaNzS7HDwN05apNhnGX2IGoyXqTVanZnjiTiptZeoAJe2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C92qyCSK; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6T/zPV5v07cMhZhLna7Mcs74bA2G9HXIT+yeGYCabmF1lbkQkLg7lR6/0tnkupWdfxZz94g8y7xUHLbKb4E6VLm71+p3MTdK8HCPwJW46skxOuOnY8DlALYi2bQn8VMPmjg9koBuBZWiv9tmjCxW/f9xTBZzxB6GBv6STsUh3fnDPbu3GyJ5aOjBGqTVdA+BCF3lzpuU4fDxe9MZ4BQFPXYQLLSa/Z79dHJ9gY+uubVhPaOxHAYwsj/Kz4siQbuurezh+PQwx4BdN6DHoO/ixYhzmUp+6a4NBTdGyttpm598UXaV/orbkFSvOGNrmoDCQxsrYIyxwyqTjdMS9NbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QualKuC++MMZqc/QVTygHCWYi3XpWFZFsfAavvBhhmg=;
 b=ITC3qPHuHKD7fCxrSjADTmQMeokXwN3nTcZg3l18mwpjJO5PR/Bfv0jyRuRgad6VR5sBlVxjpP2WaSKR9PKyv3vFL9JuX3n/bYPfGk7krFWLkK1F/OS0PBdkKJV5mXwwtjtnZwjTHkOLgwHnA2mmQQ4v3HvkFCCFjnYV0b/u2KVptJSGmtF7y4CGUW5IbN4OXygSdWkXar9yCYZ+RyopShXFVVAXnZoCQ5IrAp1fawK4IIFaXPFSyFSzmNighdptIf0zAxoqjzyPFPenHdsoWAp2eCIM40IeXQ//icP7KgE65eH6nMFr7/+sMhXylDLi4aY2NPbExHTNGkayJsIePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QualKuC++MMZqc/QVTygHCWYi3XpWFZFsfAavvBhhmg=;
 b=C92qyCSKy2YJe/1d352CxObGdQAZg/v6T4vZZ7jV//lSxscxVnKIlf4D8IikWB63i5qR+vdrCXY/EUgMDGp1YpQbqzCa+ROOwE+VAd8CJURo6UmGKRlTaRbHnTDEAA48MsPIlRAEsU8Xv/PPi+3IQS1B/mOnRFAQ4gk+alSxz/ClQYWxlmgkRcHpet41BS0Oa81Khz6O8ov8FsD33vUvG1rzRpOKsSpu/N44emzS+Ki8Hk8rnlRa9rXozLSx1v3ruEM6l8Do92IEktl6ap2htTRy2FBShdmjUAr5TN1zFxCizWG6/wPxuZmkRLiymr1405N+iyyvrTBkg+BQC8No8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 27 Mar
 2025 15:36:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 15:36:01 +0000
Date: Thu, 27 Mar 2025 11:35:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, bhelgaas@google.com
Cc: Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
Message-ID: <Z+VwWRWh3mn8bJqE@lizhi-Precision-Tower-5810>
References: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe2c103-6f75-4098-9ebb-08dd6d4513de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfF4i/8XQK2jvDy+HhM7Ip2OT0AIYD90KMBFGS2NV7OSimqcnXs0cR1PQRV4?=
 =?us-ascii?Q?yBo0LXQvIyrH/5+93kaYNRQyctFhpw4gYazVc2qtxm0XfzKJwxawrdVYM/el?=
 =?us-ascii?Q?iXXNf+Ec5uZqaPdvZ8BRKdbvOYCdct/v0OOOGrLsFQBnuktKR4tnqlPb9yr4?=
 =?us-ascii?Q?eDBcXMj28tx3YJpNkufoG3NNkeIigtNWS3n52tQCeigzFay/7CpoTz+pO8AY?=
 =?us-ascii?Q?2cDFj/PQ0orGXvCoyut907yX6sNvPqpYPZ8aPZNssmt7rjL9O/dY3xf81tja?=
 =?us-ascii?Q?5RP/gmXpA1mIGuRfygGBKLT7/ihfucgi9YQEBjqW8I++7Pg+r1YqMwMHquBs?=
 =?us-ascii?Q?VuzAh+a+9iB7jb4SoUnb46TRrQt5eTBiVpxDv3QoV/+zBhDfxbkHa5pigXB/?=
 =?us-ascii?Q?wFmTYIBIaECQJ5YbC/GjIL9sZ0A18N3a1L8c6ahq3Lx1S/yWgxAAF8uLm1pf?=
 =?us-ascii?Q?3eq8uaWIT+/0yHwJS4yWq76Uj3GuL2UiMbYdqFJA7olnmvJgfXonGCN2gGNh?=
 =?us-ascii?Q?7arUWwfefHafWpMYi83edcOJQ2fV6fuV3D/3ZHA+YfyD53nF+cHLCzkDgzqq?=
 =?us-ascii?Q?8LPS1U4aSXITTjfShRbFcdJ5IFrOHMfTDd/SQ8AZKifEeD6vJOQjIqrN2ObY?=
 =?us-ascii?Q?Kx1BuwjFqbKF+s4zSUYv02p7PwwKB4aaWcuh22mdISAexjvgwyIaSaQmcwno?=
 =?us-ascii?Q?HnlQDidNESH1ZEVslYt1UxJ09dNOL78O7Uj5bR/FvSmx7gvwu/zmXnUppvEP?=
 =?us-ascii?Q?GFAXBQ4RsPEcQ5iHQFSPWMdqjMO5pRYkEUfs28iiIaNUSKUPI4Ntio05Q3aW?=
 =?us-ascii?Q?fMVWMoucoCt+/oqPtFCEih2PUXkQArPi49wQibmhYK/b5fm+mI0M0f8uvMv5?=
 =?us-ascii?Q?O8pyg9tbY9S8AeGLJWR87T0SjxzMoPWNyVTBAk/539oXKYD4ejYf8ctCsYRn?=
 =?us-ascii?Q?94RnTD4HUrSpr9byUxz0wsnStBN8fy8Oiqt0Or4zupwGCYjN0ZAJieYM5h/Q?=
 =?us-ascii?Q?30vXVMwmEQ+SOyCcC98KqtNeFrhXqXwG7WJHXo3nY24kW2ruvRUX0O0eTvyV?=
 =?us-ascii?Q?QDh6nlq5gYZ7EK8YwpuPFVNWdaiy0C+VAUrIvEDFpoXSA08g/ICcyG88ytPX?=
 =?us-ascii?Q?UuxAIio5fmW2iKO20BEcKbAN8gTw5PrYGe1yZOXy8OI4B/83OB6Qjv3k/5Yg?=
 =?us-ascii?Q?GYJChcEp8SaUY1SFKEYMXm1IgSIk3koYrMm1G7doUb+uDoh0ORQTxfvFRdF2?=
 =?us-ascii?Q?zlwNWvNlFk+bmJtzeYpHaMswvW2TRhpQorBfTufVnw6HfS056RLHILac92oq?=
 =?us-ascii?Q?73v5hiZNSArfgMlwU0cuVaIDrzouP1pDIGbPsMHVuBJp19mmt9fjgJgS8GOU?=
 =?us-ascii?Q?mwHCVoLm981EzZJLEXHqEcYB9lIevhv7vYXWZvtqs3PleQRrU02X5Y8Fzh54?=
 =?us-ascii?Q?V/qpUp8bFm8+pdgQwg1pkw0AdpHH2Ckd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0ClYjUYy05yjfJ79k56TCdjoEA0ZcQVtoseB8txe1PGvqP4AFXlWaTfH6C8?=
 =?us-ascii?Q?BKb1COF5OvLQi0PzwHYM9AfUKImezaQkZr7SaUoJcWHgQjMFLoAsZtpzLC3i?=
 =?us-ascii?Q?5M5a+1blBC52fpqj4tyCJNaYtfIMi0rjCgOjxgcDAr7U5MQjRXi7n4QFiPzx?=
 =?us-ascii?Q?xmsEe2nw8NKpcJbOG/DjVhjUZJTCWaJpWbBlG00okeWIuSi8QDt38Ek4s8YK?=
 =?us-ascii?Q?xnJW+xbrpIiz9Xvjn7reCEJF/LC1GsmLrMD9w9d5tYqRcnjluMLwvtUE9EQH?=
 =?us-ascii?Q?6qDzuNSVcjd7TAT/e2dTw9lHGonGM0y6m/wtdm+TeBiWEVdtirEhs/8RHcSX?=
 =?us-ascii?Q?MtHje9tmNoX1r4iMzwyZhalPtBeKVowTgsuj/LuXo4Rf7z54bcIjW9uFwQQg?=
 =?us-ascii?Q?3kfpNBh1D9L9/KXbe89vUrbsu6d8tdisL5lIDyTCiTT4a2mmZ4HCeUtUq/cn?=
 =?us-ascii?Q?nvvS/GlQt4r0KiGbFtP/5hj3dlGlU9H4CwesjnVApRq+2wvG71luf4O3p8Rq?=
 =?us-ascii?Q?TbfpL+uLIGrU6FHSVaGLv0RfWBLrtOfcLwJJCCxspzE+mvuJGCOpgV36AE0k?=
 =?us-ascii?Q?cKVJRYcl4TpWDbuQNNxWYO8k636NV7KNCIZOHdBrBH4qJVpGyXmNKEsez0nm?=
 =?us-ascii?Q?Fq2RIh0rtDshapUacLP2fS5xCHMmlMG72iMLuvBMunfgdFISJDiGMNT8NkgR?=
 =?us-ascii?Q?K1lJVWhhTpgxFLWLlWESVfGmE2AEpwUrY9Zpe6dLFRun8pIAwJ+R4zixpkbx?=
 =?us-ascii?Q?SREz8EssDrKEKA90dpDZgkukA5QkytGjdnQxK6KirvyZvbXMq686nxLq1vg5?=
 =?us-ascii?Q?LS59JygPhHbHinwvMYfII+KJZsGSAxhlGo7tBMYCnyQ3prD4LQiyvN2nqmnH?=
 =?us-ascii?Q?1ljSqwTKOVm5MRYRcQ6QqyC6lBbjjfp4JIiMH7BX16bXTNVWLOK97GSCkFuP?=
 =?us-ascii?Q?xtriFvYErpl4Dud8M/dSza7bMWpSRhVS8rDiTiI9K04U5S8qZePqV452kWWr?=
 =?us-ascii?Q?PIyKq6hzqmmqFWRyN62hcXcyOo430AWRY0k8gl8aseHePQ/+JeOwrVy4HGHh?=
 =?us-ascii?Q?QvKRROS5URDl8VRfWQsJDNOaa+HntJ/TbaRJgiiU1QILp1Oy4H6Yx88a5hms?=
 =?us-ascii?Q?eFq/FVI3uc1wUfi36dQ9fADHYPnaII8C9c2B2MHk3dOy2fRNRgrPejbCSDWb?=
 =?us-ascii?Q?1wSnbTNPW+D2eiIxzrTazfNecXKIMOxgjiNpWkzqBzGdh8FKjCCWnLpi3eHA?=
 =?us-ascii?Q?+7nfV7XzTbFvpZg9Wo+hQp2zIFQZCQrFn60b7OcPRCullYQ67+szhbWOASsm?=
 =?us-ascii?Q?tqEZDfLUisx0KwsNfNMdaIFZGsUtGzonxmdTRsPuibjCvtFCXs7pqg6d3B2G?=
 =?us-ascii?Q?WUgcNs+e3JCNGyR8EW43w1JR8G7ATBo1FEZcopnELwhXXYAsFLVggC8yrWeX?=
 =?us-ascii?Q?u54VGU2ucfa7lIEHBrOLWdw+uuRi7Q1UXAgv6SV1BnTpIdNqldNkuooH2JYX?=
 =?us-ascii?Q?gAaUMkX7uuhlqfyNZzY1mxVA6gempB8cuP1Sv4U0ISsJw93iO8yQ2uJPQsVK?=
 =?us-ascii?Q?Wz04meUntni9yqadIXl65qR61YcsDtiE7E+qugzE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe2c103-6f75-4098-9ebb-08dd6d4513de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:36:01.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rxg8sX2b4DEl8ZtiNrERr1W1Q9NHXibUT2suG2Ryu7WvR8yH/KWEpwp+5SjiSUEkoqYQwDsmx4wr83Pdp30mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377

On Thu, Mar 27, 2025 at 05:19:49PM +0200, Ioana Ciornei wrote:
> The arg_count variable passed to the
> syscon_regmap_lookup_by_phandle_args() function represents the number of
> argument cells following the phandle. In this case, the number of
> arguments should be 1 instead of 2 since the dt property looks like
> below.
> 	fsl,pcie-scfg = <&scfg 0>;
>
> Without this fix, layerscape-pcie fails with the following message on
> LS1043A:
>
> [    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2, found 1
> [    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
> [    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-pcie failed with error -22
>
> Fixes: 149fc35734e5 ("PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

Bjorn:
	This is hot fix for some layerscape platform, which block pcie
functions. 149fc35734e5 still in v6.14 next.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 239a05b36e8e..a44b5c256d6e 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -356,7 +356,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (pcie->drvdata->scfg_support) {
>  		pcie->scfg =
>  			syscon_regmap_lookup_by_phandle_args(dev->of_node,
> -							     "fsl,pcie-scfg", 2,
> +							     "fsl,pcie-scfg", 1,
>  							     index);
>  		if (IS_ERR(pcie->scfg)) {
>  			dev_err(dev, "No syscfg phandle specified\n");
> --
> 2.34.1
>

