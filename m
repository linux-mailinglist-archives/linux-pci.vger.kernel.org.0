Return-Path: <linux-pci+bounces-40720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD1C47F22
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F6154E59CA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357927E07E;
	Mon, 10 Nov 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtABqJCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693E274671;
	Mon, 10 Nov 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792036; cv=fail; b=m1afCLCc24zkLbAKE1Qq394FQxDfV+uFVsYs8i4YK2it7Wn8FEKoIEqY0kFZ+eJin/NcJNyvExIdI14Cn6bhgF/dJLjLltnGjYTuNCl3jmzNTUDnPyNi4CtupK/iS6vH3MRZDMB+RdS3/o15l0e5o7Wbg0bMNu2FOmfOE5ed+4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792036; c=relaxed/simple;
	bh=Tv/nCIoAwCIqU3LguKoIp0Mb7NgqqIrR00SPd+kufnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MTEXYorVIL5yPpN+UqBpqeWLLB7S8aT8F7gwBua3hq2Ucq3JdEGenNUG9EiBa4XwdTpx8PwiwxhsW7O9VaBweITEwgmK2ALaDgettrm9TlYWUpILrv5Yf+1J8am7+/78T2qJSydFlOc1UuVht9B1OCvPNBunV0mPLLLfI0bKKoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mtABqJCs; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhNa+QU0X9rPlg+cphY8Dz3yHXmDuCWl72K6sw0Cy+0aXk9Yja18qs6bqPRE+i0IMdoBiWYXitrQ5jXKP1MGMoJb1k4XTH4XBn77hM7kLalF4PSSeckw82FbQEbQNDFzkxpm0hINQC1uSjqsDIUdAKu4S4T/0F7cKm7QB+ggnEMlRLlH+9OXG8Iz6AQEsce5pLDYt6Z+2WISUnJJkkPXauvhMOjycytp6jTiVet+gKzzgg4s25QLRHzJoJZU38kYr9MtbWUpxk/bCbrDD2aWuHjyPS9YkhXd53nCVcCpOuZ5pCEM5692QEujBBuIcZM/TXw3d073ROskxXYCkfP/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anBFiJMctS90AYsqE+32Edb+67ZL9mpFR18YNhgJC4c=;
 b=vJaHSESE/9pomPqemKmuur48D4fP/I9/azAPO1OwSmmU91C2x8EoHMtFrsA6ghesDVZk2wQf50fEDnaA0lgIR1FmY9BBY5Xab1CP9plkyv+qix2FqQ59H/nfYCFENOIkXgrSpMPfpqGghVp1rMOuhVM4IcnkdgtkAxmFMiii81N04zAtAXZqiyGn0gHe/eTCTtLwLUCqUSmFOnGtHESsVfKi+iKMSNG/I3WTZGOkcTDkUdSHeCd+Bg3Y87+fCwBeU8hEUryrlwuYVpZGSMNsnT9r/ejJt3s/jKlwuXbOl3GcDPDc3X3PYzoJH9h5fGbNcU/hYLvQCDfWI7Jph1g06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anBFiJMctS90AYsqE+32Edb+67ZL9mpFR18YNhgJC4c=;
 b=mtABqJCs8qyURVhg9BeDpeDZiql2jvYzg2Lxtd26hQRWMoPQNCqj7WHPZkZT57I9dN/l2Mca3kmg5XonwGE/ZkpHni2Npp168qWqirZO7omN6ZmyAoo3K8Mi0zmAPlzN0PtIknV+yT2iBjuaJwUQUXy12kVBIHSFf0lRwAwx+Zz8s3OtZGbmepvnJryM5O1Ub4W5b6j3t63zxuvTxQ1mUiwRCaM309+IDyumt6Z8VnXCEIImA+3N6yR9Q8h8qcgQ8P83jmS/aRCuIS7AZYkJiCamRL2uL2RrGGnsIg6RvT54kOWmc/KOxQnRSqbGxTEMgeuMm7DKEPeMUEph/Ux4IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:26:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:26:46 +0000
Date: Mon, 10 Nov 2025 11:26:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v2 3/3] PCI: dwc: Check for the device presence during
 suspend and resume
Message-ID: <aRISPgCZyEZxStIN@lizhi-Precision-Tower-5810>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>
X-ClientProxiedBy: PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6e3a6b-6159-4bd6-cad1-08de2075f0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Y45Af8Q7xKKgQu65dLgiH49SxD9ETsvuvFRik10tB5hqPi7vbRqP1WdkdC/?=
 =?us-ascii?Q?ZnpNS4YSXKMb8NYBSEk75nEJIxBVugWzLNHotpcDuqa8tlm92IigvUBAxxm0?=
 =?us-ascii?Q?ZxveHoT8jGhDyqCbAIzcpjws+ejzZIIqe2otaGfVelQivoMAnxUJJQ3nKg1/?=
 =?us-ascii?Q?+0V8NIyIXNKCCBaJuLFRwUb09Sfb12ycThMxf5zweg2Lqs49sZxg6IB0LMI6?=
 =?us-ascii?Q?GjwrVnjeAX9gFdm5Z+uDbHaKyNKTUdNdO9wzTopOw9QExVEpy74ja2FZ7Y0B?=
 =?us-ascii?Q?vErIQujxhApJeIRN/XvFT5hP23M3tEOHZ1ALi5dLnUnZUStZx3YgEhsfle49?=
 =?us-ascii?Q?EYO4AZfz27/v0e0BlgNv5BvesY1Oo3M690B63UMxQEsgnOqHmbDDNBxZvab5?=
 =?us-ascii?Q?UgDmwR6u2ClgwAbJ1E/iuLS6v3TYXZ8gq7ymthrrR3+uhmo90IALDSc2+uPt?=
 =?us-ascii?Q?P4zwl3/qld2arXLZHSJXuFstyFxH858Atuufu2tTrlF+oijDHxPKl1yiCO6w?=
 =?us-ascii?Q?5pgXRPYadUiRvF4FFDUcP5TZ20gXEpiQSh76805uY2CnTcTX7l3bGE9x9Pqu?=
 =?us-ascii?Q?Pjeh1nrPcj5k08zxXFhtIthPuny8Oq/QChUNXGxvsHKr1E8vd/uKbvz7J++w?=
 =?us-ascii?Q?UiG8+hLN6Z5h9Mjiitftfu6weKSxgiG9sHSLIR8vi4CvGLGRFNeRc4tssooH?=
 =?us-ascii?Q?jO5Y062fDjN6E4DKHS95Jyhc2V7cogTEZNmFiFu8WhBLDW2PkjZhy8neupRe?=
 =?us-ascii?Q?5gLBIsXmiD3CNGzHoahRSAfMPiSUWI01YfIolzsg0mO3yZ/Z7ykWEf3yKcnI?=
 =?us-ascii?Q?yOPDaaxTJ12c2I+YzG549f92B546rIg5RD/pdsIwgpDyuDIUljrtsLzb/qMd?=
 =?us-ascii?Q?o2Sc+NU91MezsVCtmZ3ehnsjwq5r1ZWluqMT3baUfGcX9qAJucp02Jd/pEHb?=
 =?us-ascii?Q?MYPNUAgrdMO7dOcUIvRfvQnGmOQieCOj3Q9gf4YuzzpG5h7oPruoQQzjGPN8?=
 =?us-ascii?Q?/HvgyuychUZfqIva23l9HEhuhwOi3WRWtcsUhgt20vYG4IYHvRfsx2zwdmOa?=
 =?us-ascii?Q?CaCq8Q81pz9DvBqiJ2P8zJx+kNkpKXLrTlkQ47AeHZVqn8t7HMTQwf+GSJBU?=
 =?us-ascii?Q?B/gGtCCUYuD40tWBkkaWE/xi9G/BPGp7DaWev3uKI7rroqQAictCMegwd+ed?=
 =?us-ascii?Q?Ss23/o3StC/D5+alULPN8Lq962OsssapSn9Qpq2mbxmkW3yLWbOlkVUidoDD?=
 =?us-ascii?Q?QJquSKjXA0ouBlNWdC2ls7+Ls6GJojWuXWEwk+GlSWTzZS8rP8SBc+8e3CKO?=
 =?us-ascii?Q?nlGPAJ4gxPXmr7Ng2Kowk7LDhDJC/FfSEyE/hY9o9zRTXepp59vLvdY1KLg1?=
 =?us-ascii?Q?RgB+1pAv0JXSQC1bAkE7QpOGX8KkCgrh577QM/HJ4TorYSiHlpgjfrz1stku?=
 =?us-ascii?Q?xxMPDZ9sT7GzAUso2OYydHVnzBGDl+96ZTeyoI0QeaXSYoSAdjw2r7Cbbuu3?=
 =?us-ascii?Q?GrDEyPZgKoVmcc7pFXewBMQJld5mrWIdkiPv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4AfCzpXF3ow80d3VvTPAZ4aIcErcRgU1UFCk81yTWtyTLCEYt0NTEpSEI4g?=
 =?us-ascii?Q?FngUeVCtM5MJ7qZMGlcFAvWTkO7wK2FTzRH2/6uuyaF3y4bq17PYQazhK4QE?=
 =?us-ascii?Q?rc7/D5SsDDomAVZkFmPT2qhAVeG0JihurwfVna7p2J93yuQw1bHaNPOQkNG7?=
 =?us-ascii?Q?sU7Qlt5yjnA7RtMMdXZOantamAES0Hm/oiS6pm7ZDLNR8CI8nYbAp5bH/Uzw?=
 =?us-ascii?Q?jfqUUoHziI9vP7R/pQ+/+9geibeNTbxbJrwad1QxpMiZgvR1aiGW0E5MZ2Gy?=
 =?us-ascii?Q?L5COrMarktRLmQkdXrmx/Nge6XDSCd++FmNRQM9ro7IKQsdVP2DhvxQx24OR?=
 =?us-ascii?Q?W1td2PtSGPz+azlFkuKmD2+Gb/Bu+zvk1QLXnn32AKdFcXYPrhemJZw/E+TC?=
 =?us-ascii?Q?dK1ohTeHKsOBApn+oIrr4hqNY+2uyg8MAlZ9D28piims2+5Pjnz6Cd+8ZQej?=
 =?us-ascii?Q?JiwG6qGFRUnV9yiID0SQYrP966rzwQvJ+l+3UoUEFTuUQI0prvuNUY1Oi+xO?=
 =?us-ascii?Q?V3U3XBKhuQIZT4Cr+BiCOJXiK9UHEA5GjIHt9XTr7Ehqc03X8RjAW3EdAPGq?=
 =?us-ascii?Q?R9NpxVWPyt3/HM5VGSJiXCwf/NIDIoGp40sdfhgVBv11zZQvNC/OUO3y5Ebx?=
 =?us-ascii?Q?Gw4xlDkpyE8+yPHuMCNUtequqvT+JOn7NHT1iN95GcfmTvxrVDcp+f6z3/UE?=
 =?us-ascii?Q?6SOlpQlZyruY/ojYnIvlTpfBQKKnG3fBZFJ7Gm7qWtB0WaztNKjqZ86eDU4T?=
 =?us-ascii?Q?nfw+hOU3egf3kxZ79EjcZScGKPWMm5TwEW0JlspKnJuHPe9qhdNxXM3xyjuy?=
 =?us-ascii?Q?QSMjNIIg5JF3XwTFp3+e2rsBj466nhU+uB+4rj9LDnyvxaRZNuRtYE5H+HzG?=
 =?us-ascii?Q?t0qXxwiUClOowF/lkH8VP7MlTFMM9NH4x4ecAfVRzOHyS9WYhON9lcZRY8wn?=
 =?us-ascii?Q?ZoFDzuaMdCzEi0vLm5FLuZ/AwZCwc892nRhvxlOehA+md+SYG6J9fTqLlt5T?=
 =?us-ascii?Q?rU7n/qr+EvAFjQ+1/tAKLbXk3iGfKS2Y53vrfZGKk6haypbUQuMq4eMmPpAr?=
 =?us-ascii?Q?HgngmY6HYqD0mNURDaFAUd2Prq3TF1ANoSsYeSQg5Lc7r9o+z6E6tiYuZjy8?=
 =?us-ascii?Q?63x3UKrZb9VDeKUNyNrxuTCEh7UHdpNK3rN2D5UX5pPVzTmofPAksuU3q/mM?=
 =?us-ascii?Q?ml6TN7f0P4LUcG2NFQnIkE/qgTRbVPnLgNfJEzZfHLHCPJVzoYclT6sNz/Vc?=
 =?us-ascii?Q?Bx4GaPCuztJFxOJPB5l1OAXr6sV9I/buNIsZNQWA/0yGRJEHIIT3f2ZfUAOF?=
 =?us-ascii?Q?5KkkLRr3NXDBQHJoRrV9QhhgzyLydmqq2G1mD3WrUe+71SYoKhC8z5B1BRac?=
 =?us-ascii?Q?9oYF2e4WX0w+F6gSDCIthfzNEbWYz9wRHVM2K/8RFBzf4GWhgXS5/GW04Uhh?=
 =?us-ascii?Q?jSS8Zi0MzaJMOmm5jCDnkBYQUyHCPhzVVxlBIxC0Y+5dIQPrD2HSsPFxJg+8?=
 =?us-ascii?Q?koiJdgz/vzbKn7yfslF+PtUVZ8h+KH2ShpB9UAZeRPVoHjnmWOioB2OQ7RhP?=
 =?us-ascii?Q?0EeaYrzw7fRdC5bNA3wrko89vJivXXXOlt3nII62?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6e3a6b-6159-4bd6-cad1-08de2075f0cc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:26:45.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmlprQrey1CJUCbHBgK9ZAv4IG420aXJIInUGXPmc7EphzyGaYUAH0w1aTdrZao765VmI1qHt82U60c5j2z0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967

On Fri, Nov 07, 2025 at 10:13:19AM +0530, Manivannan Sadhasivam wrote:
> If there is no device available under the Root Ports, there is no point in
> sending PME_Turn_Off and waiting for L2/L3 transition during suspend, it
> will result in a timeout. Hence, skip those steps if no device is available
> during suspend.
>
> During resume, do not wait for the link up if there was no device connected
> before suspend. It is very unlikely that a device will get connected while
> the host system was suspended.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..5a39e7139ec9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>
>  static struct pci_ops dw_pcie_ops;
> @@ -1129,6 +1130,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	u32 val;
>  	int ret;
>
> +	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
> +		goto stop_link;
> +
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
>  	 * devices such as NVMe expect low resume latency.
> @@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	 */
>  	udelay(1);

I think move pme_turn_off() to helper funciton will make code look better

	if (pci_root_ports_have_device()) {
		ret = dwc_pme_turn_off();
		if (ret)
			return ret;
	};


>
> +stop_link:
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
> @@ -1195,6 +1200,14 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * If there was no device before suspend, skip waiting for link up as
> +	 * it is bound to fail. It is very unlikely that a device will get
> +	 * connected *during* suspend.

I think it should use certern term. the a device will not get linkup during
suspend, if this happen, it is a new hotjoin device after system resume.

Frank

> +	 */
> +	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
> +		return 0;
> +
>  	ret = dw_pcie_wait_for_link(pci);
>  	if (ret)
>  		return ret;
> --
> 2.48.1
>

