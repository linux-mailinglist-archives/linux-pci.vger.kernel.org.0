Return-Path: <linux-pci+bounces-23872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4226A63314
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981393AFA07
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4C18024;
	Sun, 16 Mar 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daZEOC4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0ECD517;
	Sun, 16 Mar 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088058; cv=fail; b=D8YCK1U1LLJaqM6uoddRTbtrvmdCGqju3gJlVDdkq8Pp5F9hN00Zi9ndxyCXc7VajF0Ln6ZLAJBxdYnoNmDJjoiyXMW3fVhfMPZEUvebrL/qSoHRoMAH6uLK+LV+LZLyiQpTcI2u6Ms7zhkFtscg0MpVGnZqKROXtQwfDt45Pro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088058; c=relaxed/simple;
	bh=CpkX7RHXVTkTKk4lXQT7oRkpBQY3xrxRvV6P11ZzHdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LysjgByBzjwizoqMPrxvW5PCcYRnYr+GJI4ItUY9226ze4IBl3KLuLRbG/eGv+m3iME7T9YZ1HxJiz8TE2RC2JZMnqWiq02rHhx3kJH36OpI2Q/iT7j0xo/MADSmDVopNgYcDdKeiRUCAjivVRuwBInpVd8F/7WgTVH6BcZ4Uas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daZEOC4v; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNCX7L5flk1JqFf/4Ox+s2JqQbuCu5Nk/lgrfYJXCqTKq/LeEL9fqmtX0VDZbm/XAhNRsHSZCJiF+DMXh6TtzYmFqUfmh2COAkIkP8e1BqtuEb5yCPqRItfGIKeIlgHp4i9KS+Hs/1Sz+lgNzmrHaI5DLbVO7IoqT9NR524l7wrskdcYqAbGw3vrEdbVuzUWXRPK8BayMAsqaJ7VJjMV9nblIhD8uROFKW5K7WcuaZuH89ibr2h1geD5WIw3W6Yp615pVFkb9wgch5yFjueblyMWfe/vvyjaQfJMJraejJrXXSyD55yM1rdlgDnr1pIKO67dH58twe9blQGlB3Dfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU2BU/m+gg/7SnQNAFBVGJwC/Skp0+6Fhqe3NKjxVE4=;
 b=ZgHDdbpXdCz2B22zwMGi+Lv57hu0Uz1CfvBUI5+jD+v26N0co4iQquf3w83I7uNbqRiBGD+AGDFtkN/sLMyba5QynPPGztXckrP3fqgf443o2LSymZvypSenX3NOyAay9dsWbDJ4d3c78EStInMDn6OMv/9GsQUMD/ahPO0c1vom5TFK5v0sf5iH2HiDdRvRaY9T2FNzJiL2tf1E8iNJFPj7oqdGmV7+wotvhK1b0J1s3KUdVkyhZQHqRsn/gbZ6IVDz6PPYwtqoMXrqQfqYwVaIinIe5BVnJP6wKNqXzDOgFUF+n4tWaohUgou48gewum+IbhjQ/alLOMJpKrKRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU2BU/m+gg/7SnQNAFBVGJwC/Skp0+6Fhqe3NKjxVE4=;
 b=daZEOC4vLEvGwcE2slGn9C9c7o3FbCNTaHzRIOswfndAyrYYYwPUiao9jy+k6yl5OT3hF1iYIzPTZtFUFPg0SCx8AMfMytZ0aQHGioYPguzUPsf6wWKc8Y1I21y3j4BND9x7k3lB3rxQUsUqK2wEA9ELSq+25mikf2fd6YAXmDXPYOJDvJfxOyV48sfPdviuSdCwvloYayj1aN2uCUCvWfUHdAxFrwBAbA/ft19zF6l5m++U8w5LUv+uVncD95sIh1pNQkiuPyIjJdDJa5l5bmJi7vMvchSSrthOfxaUB1zF8+VptWp+DXP0BU3sjrF2gpPb5YPa4qAp8tFQCS3GsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 01:20:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:20:52 +0000
Date: Sat, 15 Mar 2025 21:20:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Message-ID: <Z9YnajnFGpULuTKf@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-6-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-6-helgaas@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 20219d4b-de29-4817-7a59-08dd6428cafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/jObtWL6gvk/IKvTUHS5AFYcBzG4yJG/sAcswYlR5EiwnrhSNS3GoAuXs5/?=
 =?us-ascii?Q?HuxgUZEFIwdBRscsXshgMdK7SPoT+m8tksUgIl7m5csdNkv7ZMhEZsO8xTu3?=
 =?us-ascii?Q?ZD6fEEQf+jaWA/VzqUPuQ1Nc6/yo5M6+uJ27ZgKIpsXQaZeqbuC+jqsCNDAH?=
 =?us-ascii?Q?1pn05540cS5GRt+34RoUQzr9IdyvfLROs3EKAZIvaQ3UYojv/xcuJ+o9Hoer?=
 =?us-ascii?Q?1S83Z8iaw1uX0bsyiUwVyO2nzgccghJ7RnTgv757u+Ffhahy0I7TC9UdyEIJ?=
 =?us-ascii?Q?uUx//BgOW8BAXiPFPb9uqD/7YJwKrIqgf8ID9MAPGgi6uH4Im7IVuNBJw8Nb?=
 =?us-ascii?Q?pkJo6/Qbf2l31nSZ2la71Np9TPfnADZf6XLFkGyPwZ5W3SFH5fa2/RHBP9fv?=
 =?us-ascii?Q?33NXyT0rSlj1RVXQahBr0izqnNcVcql2510SnXJaEY1MocTxqAZdWJBGwY2X?=
 =?us-ascii?Q?C7ZOGCiN2VW9qfOMK+/0PDA9chC6kaCtfEQiflz76svOZVEKu8eJRZ+Fopia?=
 =?us-ascii?Q?oBT9U7zIp9q789O/13nE4AEAEM24ICYKHiUY5qcBMLSXWg5K20UDB97im0oe?=
 =?us-ascii?Q?gIpzHVykOczhuesf36xy3sa6ZKxlTF7vzRkeHmJFps7T/Bpd2hC9WaEmwtzw?=
 =?us-ascii?Q?Ela5w+vfSVfV9ilQc9WgtRJ0+bJiRxZxtDjmDWMmRF0+iy0uhKzn0XLY4vlW?=
 =?us-ascii?Q?Sie7J1Ke8NkhUQM63u5Aa6frp5Z/gPcuzXMyRPxv7xe4yE/Km96DDdPngiZ3?=
 =?us-ascii?Q?u1Dd+HHffyMI2gTAoeK+259sQaUpifZgsaW2q+Dz5zqYY8CUdICT4IYmPr9R?=
 =?us-ascii?Q?uvL94TzCkxzK+W2DsgvIdKRv6qMqKxlh8aKkziMthgpelx+opgwwpoEfk3PF?=
 =?us-ascii?Q?fmU19PcBok8OEo/mfHQV8nmMPHQLvqUi2jYNLW74VPap9URF2URXjU24m6T0?=
 =?us-ascii?Q?GWxpVAbx85W9Gc0fCb/7lXORpf2QpyoiIGSHY0rzdeHPVqdizTHO8Jo2zBwl?=
 =?us-ascii?Q?z1t2X75MY4I6O1/Ko7Qjm+Dpu0b+iudeXRstBAMHezVeaX9pf+yvrk66N04S?=
 =?us-ascii?Q?YIzslOIiTDEI/jgTVIh91CQvHr0QeGkaqScKmveh/Ct1moCo03BZSSQXSvBz?=
 =?us-ascii?Q?30J/S8EaiKjf9nrZCDSvUtuzaVrKSmzU14sUzNEDrHgEYZDfJBkh8LXYzC3u?=
 =?us-ascii?Q?Y6soOtvFsoq4pu/weMrLACG8rBH1vVbijSlmTQOM2s3ycngSd8E9H2EswAlq?=
 =?us-ascii?Q?s1/Q2fnao+G/clIOr6bVO5r5Hc7Q1GvMv18mFCTOXLGj669XtoEgu0JMxKi0?=
 =?us-ascii?Q?sHf7Sr0jMc6DRNr/pcAttvAohtXfZMQw+znHYkwVQVv0TwoeHOTVkldSnr9S?=
 =?us-ascii?Q?F4G6bxmqvcqCSTAEsH00pG5LEIHm3sa0PdRkGwV3WvBF3cbzTBTzqPahKYD+?=
 =?us-ascii?Q?OWF1km7VgtfOJriVA5P0v6XoFZxY2tz4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5tX6lfX57/jDM1WSjM5b1eedngTCOFspbtqcJUbwWXNc1mQhPQDWHuBhABr?=
 =?us-ascii?Q?bfl4vuWmBThBW/ugpGCXFC/5pBwygOO9Sthrnx3SfY7f6P8ZJMZtKt1Zndna?=
 =?us-ascii?Q?coEETLcnObW8ib9b7IAeftYcGKdrBF8e+3RQDuM6jcyHRdViKQg7peSQquvd?=
 =?us-ascii?Q?6gNvSPYvIdLqrdMz4XDsm/+PpQjzi3v/pIVmsSbnESbQBjVzHUUx6UY0gGVl?=
 =?us-ascii?Q?jvrUAqRaSaGzcXZIdCF3Tb5xhphqr0FTX9qdmUHOdn2fxf48vdXpkQ1s5ZMc?=
 =?us-ascii?Q?Gq+RUHOMNPUhphH5MAxVlvlF9/xKaOEltdrt6YnrnLWe9KjKLyGhYdond1D4?=
 =?us-ascii?Q?5XBuLyDgFUeZ/qK2Ui8+yaRPlRgFYUP93kGKDpzYS/UQAYwOsN4sCzxrgyua?=
 =?us-ascii?Q?qLfrcoHMvrhL4PCO1qL/TUN3elAmp0sG3wEdVFa6T3lZUjyyQ0PpgJeXzIbP?=
 =?us-ascii?Q?7B1/O6iWqOBZqQk+qG1k6IsdQbUKEWfz5ffqldQEkPF+0dskt9gwY5tM3t6G?=
 =?us-ascii?Q?c6ihaancQZjuNWOMvnMcA/ujUZDLZvpWcBiz2Ho5KSdoQWkIW9g/eQnm/8ar?=
 =?us-ascii?Q?rj4PUm3LzE84l8GMsASyxdFHKfc7GTQs+e9j/AOhKyr75Z0uSAsWAHeOXdhS?=
 =?us-ascii?Q?JMzB5HbeWrDDqIXvdFogwns9B8IV7C4qe5EoVGkdeuwHqQUs2zWSFIANFYR2?=
 =?us-ascii?Q?8lyUXLdmDQf1rvRS7ClEiYrJ6DZBk2yWxpCd7HjDYK5U4e+D6lFFq2ZHta0a?=
 =?us-ascii?Q?Gv934DwrcCmIzTKE2MzpBSJl6AP5bkAX8DBAJ2EdXVF5qjSNN6X3rqed5FP/?=
 =?us-ascii?Q?NEMrE08Lu6lCzedFWGdgW+qwJ+W1g8/7MSUgJ55pOilodywynMzlCpUQOPAc?=
 =?us-ascii?Q?JS7q9SUTJwFPH34JE/T6x3qmKtzDoS47TYxjcNjvDDvjFZ2dmPyKzaUx0hpd?=
 =?us-ascii?Q?jzFZ552O0SkpWvWxuwPwiEuXiN/7bvo8rN1bGvu5G/2DRcDyzK/K9uwsO7+Y?=
 =?us-ascii?Q?Jicxo6oUjFWZvVbibFJtUZDioJ33eAbff5Qj17G471WWZv81OpYKsb9fDgMJ?=
 =?us-ascii?Q?VFRaT1M9sd9uS7HqzopaohoT0lpPsbYhLAKin5ifsZHKw6rCjwIwAzkVat3t?=
 =?us-ascii?Q?1ExmvBy6zNHn3l+sHDDR3ZkM2Nxoah9cOYvYt9QBT1dZKUPfVEqXRMo7AFcu?=
 =?us-ascii?Q?V9Yw8QkHgvKNECLJ2KZioDiZJZ5utxhoZFqR2tx8q65KYmyg2Fbyxh8EgGiJ?=
 =?us-ascii?Q?5LxzwCtErl2wVXbLYff13/11k9w0uXJZkkczHm7azzaq5D0KINyN20vZYq6s?=
 =?us-ascii?Q?zA2bn4Hfo188Bw6+MYSY8QR3lbiXyZySj8kQ7h3x4g1ukrwF380tmD88xNia?=
 =?us-ascii?Q?OUbrWg1j8fBygRmNTnfr0QDMzkz+mwGb72PqS3tUtZQHRpE6wGwxnPRHBVD/?=
 =?us-ascii?Q?fJK3vLxluK8fSJtdCOfddVV0NylXqW9T4EiWYu6gBL5QB120pL8OM6D2vDRa?=
 =?us-ascii?Q?A7DUEWMlZ0LZcuRk/lCLlfIcXaNndY2CEdMGRjhgx5nCtRWbX3LPzrR5v4w1?=
 =?us-ascii?Q?m257mHeEVQVCvFn0tI0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20219d4b-de29-4817-7a59-08dd6428cafc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:20:52.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO2x3ZHVoBuleuk7cSFWmm65VAwixOKfYw3PWAbgF5HkHOGpVJbCBMrBg/EBza73k3Zb2RX/0yu8EXSa7cmEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Sat, Mar 15, 2025 at 03:15:40PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Return the offset from CPU physical address to the parent bus address of
> the specified element of the devicetree 'reg' property.
>
> [bhelgaas: return offset, split .cpu_addr_fixup() checking and debug to
> separate patch]
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

look good!

>  drivers/pci/controller/dwc/pcie-designware.c | 23 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9d0a5f75effc..0a35e36da703 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> @@ -1105,3 +1106,25 @@ void dw_pcie_setup(struct dw_pcie *pci)
>
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> +
> +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> +					  const char *reg_name,
> +					  resource_size_t cpu_phy_addr)
> +{
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	int index;
> +	u64 reg_addr;
> +
> +	/* Look up reg_name address on parent bus */
> +	index = of_property_match_string(np, "reg-names", reg_name);
> +
> +	if (index < 0) {
> +		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
> +		return 0;
> +	}
> +
> +	of_property_read_reg(np, index, &reg_addr, NULL);
> +
> +	return cpu_phy_addr - reg_addr;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index d0d8c622a6e8..16548b01347d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -500,6 +500,9 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
> +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> +					  const char *reg_name,
> +					  resource_size_t cpu_phy_addr);
>
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> --
> 2.34.1
>

