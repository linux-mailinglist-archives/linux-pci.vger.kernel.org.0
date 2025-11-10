Return-Path: <linux-pci+bounces-40761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6DC491FF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609A13B25A6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF83054C3;
	Mon, 10 Nov 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KH9sw1QF"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27233A01C;
	Mon, 10 Nov 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804004; cv=fail; b=hDKges8kvc17c+DJmrxNYyiA12nmEfYksjXdbp/bExMTFh5nCwok9pPp2svM3ekeCqeH/K/IfdaOFjCWVjTs4HtZc5cN23Jw1t/MDVwJV4sIjN7NBYEfdbN3MfOk31cr8w9/SSAb5hg3MelnTjE0jn7siUcrTRturx4hgt1akFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804004; c=relaxed/simple;
	bh=QTdHW1yuSQ5v8fsvNfuDqnBWkdpTrlug3KQy3zxpvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZJR4v/mERdYU8K5pSGwN/YlUBMX/jjDvjans/Y/GQGjoru90nbWDgpl+3UcMaFGosiBjBUOFbYhLh2d9n5rhXJPn09KcTl4guiSfX20sXEkCC4OcpucihrJDUPGZn3NemqsK3AQnPNSL5kjy1Mvi28DDkF+7G4g+JaYTsjpDhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KH9sw1QF; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkUnQhVeZpZZtKYxU8TNu8Vz9wxd9rzi24r1iqe/eEfkakVqrOyEIYgPU1Td0s3pnMKo+44UBzsd1jOuUUQojDOH3BhX5rLDScFetbHSqi8r39Fnn4mTUpvneubzvHbFEVaKsNiszA2Xe4pH+fu+3RqTVm/hPN15Kn0nikYiOxTWpFnBs7UilSVpE+YEzFzh7RC2u2bF49PDW2//xVpxdBozFyr/8hTDa+ppaCFK5TyHH8tylH7TsGWzFMVehMLtldAoU2E+VXJgSx87UngsoWsGoRvjSkunbibgAWaPlMlJ3/21avfM69BbRgoXT9Hwrl5MGPYCiOd6p3amTRizJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nujJ2FchbhfH+tZ5141kYBAfZaVdC47kScOU5zW17hM=;
 b=s0PaMlpUWRiIRg3OqnpaMl3nTquPx2VbVYoKvc7SAILsPcf7Bz614T4e9+zDOf7hSmQua8UX/lgWljAw82Rz4mV8nOHIJ4RJHzrxfiu4v4lYPeKK8OrPwqw5PLWcsQzS8T26iO3azYPc/lSRJpa/nug5kJ8eVix/fxvhQwq8sDqEQQwVnvmi4SLvkvS1Vbh/BrLCvZTlXyE+Wa8W0qQ9jCvHDsBoXLoCGRpwxUfKeIEiiVMTKdFkBZhz9zNatrdSvBcVcXSjPgKd1kYOZ+kfCeAURCe7TkgI74LfXqnG12mKaIvulg7NNniY58bpynpkx6Azu6Pk0eSFmDAf27hBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nujJ2FchbhfH+tZ5141kYBAfZaVdC47kScOU5zW17hM=;
 b=KH9sw1QF6SS2pLGyhXWT8e/uMHml2kNXjXkfVI/Id+2qMJxFJtSxpFK1V8ZoJLjuqJtK5LO1s4jjBjtN7bsuVIfYod/TNuNR52aYr3glUn5JswpsQrYZU4wWrrVsXhdTFSkn3RKcVVLnG9Q4v7dovoE7YY2NoP8mJ7w2eK353H0bPdzmwHyuOdXUf6CjI2A5rVQ8bL9JizVaJc1HmnGGa1FNBHlS3Q169qWRp9IhuX31A6s43ew6aHG1PatCP81ueIdCLNdzQOOQvv1GU1ES2t/jpuXNZCjTjdfJYssSRC3nAUy8iCObCJ7nJVW7X6jcimHkVBd2t6FBtlhVNPpsVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Mon, 10 Nov
 2025 19:46:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:46:39 +0000
Date: Mon, 10 Nov 2025 14:46:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v5 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <aRJBFoRC5rm+5rHa@lizhi-Precision-Tower-5810>
References: <20251110090716.1392-1-zhangsenchuan@eswincomputing.com>
 <20251110090953.1429-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110090953.1429-1-zhangsenchuan@eswincomputing.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: f4cc5f3d-4b25-4f87-67c4-08de2091ddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zVs5dpgwvALiuLvR/ep5JKWhxKZiqfwoflsSMgQqcALllNmBVk+LIxRbuKkg?=
 =?us-ascii?Q?8t35VxyogHr6k/oQ/ghCte4TDphkl/vHdxVPbGciUiW26iv1z+6g4rBELX1v?=
 =?us-ascii?Q?BTRjYNmrapskAMNv1Rc2nlSjcjgAcdUdDFvO+2ax0ZNs7WFkcqIdMBqIKCC0?=
 =?us-ascii?Q?yzwFBOxRSrkH+PAvTTCW46ZtBm+mQjQd7jmQZjNi5twAFBENzdn7HvdFuZbi?=
 =?us-ascii?Q?yy+eQL4YuzA+MNJv3/xJqkTDP3vfr3LKbb6NaAkVLlg8/RC6bLbJm/qZAkxY?=
 =?us-ascii?Q?JvTYGgrP/23YSdLAPQ5UmKRfrWroJvpvNz9M6O2OqNFfopGzrHDU5j3qp22Y?=
 =?us-ascii?Q?0RE0ok1JE6qulkiBa3VFJvXDoc69hRYH3OgsRyaxmSv6ua7mpjILIhVGxomX?=
 =?us-ascii?Q?E6JngY91JXO8cFm01sgBBKs9h7W76r2arpq3/CVobd+srMG5jgnGB+VqYu14?=
 =?us-ascii?Q?Gayt0UoEFt+LNtQWH2whmTjspDnQTA44N725IzIB3YhbIgyn3dF8ZgKoRaei?=
 =?us-ascii?Q?mt6hAXhnMzZME13md9SmeQKDUuW9tkKoECdNG1dKgFmYYlbId4n0IcYomCXZ?=
 =?us-ascii?Q?S04FeK7VPPra3nmzw2AU3xSNx6uw81R6snCIVXKm8IyjJQ92bDq25T72a7Ah?=
 =?us-ascii?Q?bhs5gTedrjw5P6xguyO+zPSBjo/fO01NJS+5obgrYBluQSBqedcVFhn1xzW9?=
 =?us-ascii?Q?/EovmeAPJoO/ARjwBCjdv/nuNDEIbKJ08dJy8TINsCSWdFQ7z+mF3yXODB+o?=
 =?us-ascii?Q?gHo3xHC0pbDZSEPWk8uhBTJWqH6+JoOKLJ/014C3hUspZbFQSlZQTKqe3aeG?=
 =?us-ascii?Q?1KD+AQIlOBurKxn0hmV4tdtfKt4qJRsGMmaKt+Y3i7aPvzzhAiPWBiOcw58V?=
 =?us-ascii?Q?lEQgplQIlgphwO2gPuy03K8mX9ER/GKZIT5jA2qgXWAile0OMuoruRq0rKgx?=
 =?us-ascii?Q?jFwfeorU5nJKM/415UaXSU3OTboirzrN9/h6wFMRaSnOZOpJqhIDvZTaKG4r?=
 =?us-ascii?Q?XqsjftsnIS6XdlBJ1PtKPP1yjT9V5C/+viJumddvqapzurz8E0vFbh8FYnvp?=
 =?us-ascii?Q?die3UNdVAEfVjlMBP+plzD6pq0zKBAFAJcDwKgIqqkCe26XvK9rRixhhp8H8?=
 =?us-ascii?Q?+suXjpPVCoYzjb9GQ4IQgNMBhKYddCF0ELKND0k9wjoRUPDnexhFbDA8H663?=
 =?us-ascii?Q?CGmqHZJIukeNX1L1mcxmm+k9htF4AWIdZnKGFZcdBv6qJTs46eDOr4hLBxrc?=
 =?us-ascii?Q?HQFcqSjrJQ1x9fNJ7OzvcnHrxrQTDy90p+JvBUfWFih8RkLwn8Mq65j0CCgX?=
 =?us-ascii?Q?FJQU7Zl0mJm0lvQtSj0HzkdsKd13RggsfcLt2eCEXPvBFdcvyW9MrEilc1kM?=
 =?us-ascii?Q?KylwkL06K2WMWgfSh86L9oIhkUq6n1/b7+2a4+TLNYjdqOtSMqMuKxTRbZ4G?=
 =?us-ascii?Q?TH+/3FGPVHzolCTweH1l6ku10WdVzLgulTdKCGpOYBT1izmEkBZ8oM37Viml?=
 =?us-ascii?Q?yLLyTic6dmgR1IbN98mPu45ykkD3bdgN7rMz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ohIIofLQOJ4a9VilNBQFxkF4ipES7jFVk6nSrBs+zyVeMg5p2WtfIDMV2vR?=
 =?us-ascii?Q?GkLMZABJb4s2Q5Wm3RtFOW/TKKYOXgLXnMkEHBnaeT7gVOgH2jCqSeHxFwVu?=
 =?us-ascii?Q?5ATpDzhf9+hjQm2kY3WpNx83ISIKuOT0CaXyuamSd28sCNEghdmRWgH0nRNy?=
 =?us-ascii?Q?rPvbuN6YP76PQFh/d+Dzw+U+k6SQMGorgHzqVlPo1ZPDsUTrIzqbG+PjGgHx?=
 =?us-ascii?Q?8trMgDvqPKO5VgMoqByxywGLaNI6C9v0ohrqsO8pBD5PP8QAMu8FPEhtW2mH?=
 =?us-ascii?Q?ZP2JTf+f2SrQeFpa5VJVwqZgPd3MoUx/L9nrqiv5mCtWP4tedDzWdbzTkoXR?=
 =?us-ascii?Q?Afm0F+cQj+lNc9mrE0qoc0zRPXcMaMyaPSeNMgdtxY/Rh5DimdHT0usvZuKA?=
 =?us-ascii?Q?JpEWT/V+ebgtSLkPjO1efE+5TAGwsJRc8mtKX301J/SoYFywGJZ09TQHFqRy?=
 =?us-ascii?Q?+rZMthhjYze8l8T9eF9uCKXlLHKoSKkVsTKCo/YIEQtbDSQlxfDhXf2w6uw4?=
 =?us-ascii?Q?2iSScb4M7u/LFQlRvcI5I340Rx1ipf9kuoOTkyxSb1ADwUYJNlxGFFxid3HA?=
 =?us-ascii?Q?h0vMKQB2qgINdBANdv0J5HEz/EX77NC760R1VzYdINN2W2UfKj4F2M6yOiOR?=
 =?us-ascii?Q?qTE7p4zznfBnIKUBTj8uuMO1BglTFm2aiSA2FzNlCrNnBnLlD2n+T2jRwYRn?=
 =?us-ascii?Q?OZ4nehU0XN/ThFddpymw1jCWfVkOfkIVGSQKOYra7a015O2bx0r0Z8b6GTxu?=
 =?us-ascii?Q?jroNUzRuN6yvg+PNRi9Ry0/uL14oh+oiEpwzRxaHayoztd7tMDirj0DJ7pgc?=
 =?us-ascii?Q?9SRbG2UcSrQF1l2z6GHqo58rf0tObvxf1/tN+nLRFQ5Fk2IVPxqjTed/A861?=
 =?us-ascii?Q?NR+8SjdAO+n7G6Wd4C436h2zJH6gwejNCX8I/k7ha0G06O7xkxw23QulK9+Q?=
 =?us-ascii?Q?RH02eXctXY0r+x2VCJ6sd0j/W07NqVxFEcVc7PRgGxI7zIHsuFZDxUBpFG6f?=
 =?us-ascii?Q?Misgdklb7b0+fON4cnT/wZkZxcFwrhe6AYS9Q9/S6p7CPpTjiQIfBpRdYjAb?=
 =?us-ascii?Q?8qQLV4KGRtQl3V0ff/8zjyITDVclBhSL+N8AdS8aDDurPF4au/hBuWqXoh3V?=
 =?us-ascii?Q?tGKdObmYRTqqd8BKKACE49Ng/dqB0Y7E428OBJcop+TrEKgOQ1qHsxbUFbjy?=
 =?us-ascii?Q?QJ3hMvzwkIDmCyaCz5ktSFYB8/ME6YkUm601lSef/PHR1jVprUBRimlgjJqm?=
 =?us-ascii?Q?fmcyo8Fec6bO4A4lnCKGb+UReuZK2bCmma7r1Pi2OiwxgYLgnmYaJI4V/svx?=
 =?us-ascii?Q?+dzzYZwBAIscyJYYsF6ulqFfb9s1OYFKooNEL0uEsPH1Vj+o5edAUgGfx/E3?=
 =?us-ascii?Q?Hz99pUqmMV1jhUegH7QLMijccGklpgFGDwxgHGOUzlZKCvedTpx94Frac+Wq?=
 =?us-ascii?Q?plgLavbjzKzEbBLTu6sVdzK+QO9eNtuLjtSRaIa3l1qR/1Tpj/eaxbbc0+cM?=
 =?us-ascii?Q?5U4rzc9alX3rTq2dlAFu7B3lRXvF+c5BDvI2O4rVBmy7WG3xvjFVJorLh0wn?=
 =?us-ascii?Q?7vA9oax4xlZz2dEnZM4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cc5f3d-4b25-4f87-67c4-08de2091ddbc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:46:39.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQnESCt14VxCVa2o6wORe7YvcOpmLykQTlfiKfTUeCaFopOLFS8vAzjQc2uE/dvJHzL3XMciBo36Mnw/5aI+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

On Mon, Nov 10, 2025 at 05:09:53PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.
>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c | 420 ++++++++++++++++++++++
>  3 files changed, 432 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..66568efb324f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -93,6 +93,17 @@ config PCIE_BT1
>  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>  	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>
...
> +
> +static void eic7700_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/*
> +	 * Hardware doesn't support enter the D3code and L2/L3 states, send
> +	 * PME_Turn_Off message, which will then cause Vmain to be removed and
> +	 * controller stop working.
> +	 */
> +	dev_info(pci->dev, "Can't send PME_Turn_Off message\n");
> +}

Define a quirk to let dw_pcie_suspend_noirq() skip call pme_turn_off()
instead do nothing here. So other driver can reuse this quirk if meet the
similar situation.

And use quirk to know hardware limistion easily.

Do you know why controller stop working if vmain be removed. Suppose resume
will reinit host controller at resume.

Frank

> +
> +static const struct dw_pcie_host_ops eic7700_pcie_host_ops = {
> +	.init = eic7700_pcie_host_init,
> +	.deinit = eic7700_pcie_host_deinit,
> +	.pme_turn_off = eic7700_pcie_pme_turn_off,
> +};
> +
...
> 2.25.1
>

