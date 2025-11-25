Return-Path: <linux-pci+bounces-42071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81216C86462
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D243A34B208
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263532AAC8;
	Tue, 25 Nov 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N5LknAgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1B32AABE;
	Tue, 25 Nov 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092638; cv=fail; b=fyUFyktLzqrVN5vmhvFs9Yjr73ALtepOPvg/f/1HHmZl/qTkgJ+73fuJuHQvq/fBTLCy5PXaCDW7ga/PabwCfhy39tNQTo5kP11T6deKdeMva5YJ7p19Niu5tLTuyjo3mPrpvpJimFF0Ln6hodNx2C+G/UTFNZ/mfam6Go3bhT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092638; c=relaxed/simple;
	bh=Xj45UwRQ3k1MbHowg/ta0TdhZoILbdKQKzTNlr0aqF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tdtIFuj9q+S44+WQylhsDP88qqzERfckBCAGc2xqKS1hkrTEy0QfIblBtWgBb992LCMPnqCQi/6BjrUJwxVgfQYfimgmAeVPRcrZ/3ofzW8PXAbzdjdAS19t46HbMSsb2d8ktZvrI+v+DBt9NpTEiSU5guUCmTIgK+lwqgu/rmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N5LknAgR; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKSooyalAjxAhjxvEpRt3RVoW3Z3IbqpCpIq+VPQNs8MxzAGjTuFmFwX7tItjtjzmaKzVivpcdjv4d8CnU3FMt/ce0JXszS9mNuKhqgBYKWhyuMx0vKBCfrDAutdTCiwvYva3XWU9rjfpxL2Ayth1MUU6f3UdOcqoW51b38pfzgGPido7Blvc8YVc57GI6/KOcI2k5Gms+6cwZAy6jfIoXv1ToMVPHkW3vbB9aQT4yD6TxhXem2aaOzMmrlUqK9TqrL/HFf8PO8jmTBJgS+33rVcl+OKav0vtGD8RpvTFBVXC8W0n5zXXQwbd1nr3AM9ZoV1IUfCvjcNF7IO0leLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j54Ke4Mu6xu6mMghX5EYyCpFV7uSvfxyQY2csSQn190=;
 b=keAA2nZ+KdArb71Wz2Nog9MP9+CE6ISpjez1Q7d4x/Hm+9iOpdUPNMcQlGYJnNWUnYsVFcdWZWUpqpKd2pRSzF7JW2yiDyIkGlzCVk5hZh7Ld1wDe8aZHS7dK6d3NlGjIsTIfaXTZg7oHZg3MsjI5XFFiSw+Rq4wUPPhLv1k9F+fBgvWDK5OJh+a1z9z1gWsOMca2stH0/Ju0/klR4Y/WG50ySePQCAgG+fEci9oHKKTAr1vP3+yZ5FQVnBxSw2lHi2h919mg/8h3QHAT+CcjJTDlL2WUlIXW6u7LN6fuP4mVAhfVtMC8QkefMWNfeOI8mcWEAFvk7W+LuOmdZi3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j54Ke4Mu6xu6mMghX5EYyCpFV7uSvfxyQY2csSQn190=;
 b=N5LknAgRyRNZ6PUlIFOmWzMLVvjQ3/E36BdNNzilzmqqiEd+lQk6y13UavtcF97m1v2kHv+PQOIJEvzQ9ohdkbywvwnt2S3kLY0UI/CTGm87WKL1eO6vws1Cen7b5eVlD9F3jYwNJCTwG9DS4ueDYNjj/8TRaKtN8LqpDyus0FfRilFNb4e4qnkMGsvKag8QrVfjzNNsbzvHjbYGuWkFYXThSwcJrMjDOh0nEUUnP1gVUpLY12yGjH4r+q4+AS++Jah9NK4Mml2K1htWPJ1mGmiH6FWTm2xALDKkSnwBzHUvYMjiVvzKvcN7dt/zLyIkvT3UKZimViuJqCl/W0qQhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DUZPR04MB9870.eurprd04.prod.outlook.com (2603:10a6:10:4d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 17:43:49 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 17:43:48 +0000
Date: Tue, 25 Nov 2025 12:43:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <aSXqy2ZUpuAupv9U@lizhi-Precision-Tower-5810>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
 <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::30) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DUZPR04MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2410a773-8cf4-4b37-cbd1-08de2c4a309b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mi3NDTKI6zJFJATattUWJGtc/2Xc22C0tJADxaA7Mn1SciRIKFYeGZft01ZF?=
 =?us-ascii?Q?3Drt0QPmeGF9RQhrld11Np9gvLT2r1/lMrOdiXmPxoqomBjLozWiTo/LtYUP?=
 =?us-ascii?Q?/4NJsZ3+F5zYfu1s2Xe+pnulBjhk6NYE+jKEfRj5MVl0pqGkghbVXj65oPAu?=
 =?us-ascii?Q?vGWa54OCcFIrge+5KY2RrMhY/qF99XmBTx0hcmY/mqtXP7fmGK/Ni2WpnkE+?=
 =?us-ascii?Q?yOUNnLJ99sLiRNy4dhPwfOuRtcGcemSZ7u8cGLV7gx8Noo11cTsaP2jTi0pr?=
 =?us-ascii?Q?729z+XNjWdnRCXlA5A3hA82ZK1mQzTaxB27XnJZ/PMtGxso4JruENrE4nH+z?=
 =?us-ascii?Q?Qfoc2ex/x3TVYbiCqB2H+shNLTIlKJSCJcdl0Q5INImClG7eGpx3kaHk5FJP?=
 =?us-ascii?Q?mKMpcSDuBqe7WSTCv9qQ9V1MuPeA4vMcbJlJdPnkVKDZ+fgkr/Imff61sWWT?=
 =?us-ascii?Q?/yf11Q5xlUyu48bmM8Ex4EVLu4IM7rxmTKvV7c7bWl1+/nlPSNvjS2fjrf0t?=
 =?us-ascii?Q?lSUd1vAqvbFbTO9w3jY43Y3SgVN5UHaWaDJ7E3PNhMRFer9UBG+aJJi8Axre?=
 =?us-ascii?Q?vOmOmeHNmYr/1EQ3e0TfplQSoBE3Vy6gklx6hMda8Td1QjikdULRbi6nD0CP?=
 =?us-ascii?Q?8lXFqtovpkoi4+NZX/O5lDoOknNRnGFQbbskMIENKHmjQNGRv7TckSaV9TOI?=
 =?us-ascii?Q?senVmTx91AemPS1XRFX5NFxyfSVue4+yrzY+ry8YfAT/ATh+nfm131e/Ns77?=
 =?us-ascii?Q?AaM39UiySXmsGAO/gCIEyEY1hxBC8rm6Ejfp79DmPO8XYlSSk4izkDgVn1XT?=
 =?us-ascii?Q?LSq53deHB2tfz0q5WJzFnRsfT4DQae580ptW1unxAgKKqe1gM+bO3ygyNT5i?=
 =?us-ascii?Q?jBmZwmMHITL6vd6qQ0k6oo1+cxZMLtgbDI+anwyebC5BAcCQf/AO39aDFPLd?=
 =?us-ascii?Q?BEVbue04d96399HVnJT0fJoW8EDrSEZ2UL/v9vgr5a8gmSRIygYqYbEMJMfw?=
 =?us-ascii?Q?d6rZpbH2AQcsKOaaLDDY2HzSj/vv+Khy0fRhcugtqbQXZp+LnBG2X/mjGeYF?=
 =?us-ascii?Q?5rG2d8vxCtEmgMH2rYR3TOew1XZcd6DUAeZr0RMHaAbrCtXYBmscSQkuMyMN?=
 =?us-ascii?Q?X/aQVRk1WGqmn35uMO8DnSYndJooeHUznZBbanBl76TX7Puf2w3oBuQNc6D/?=
 =?us-ascii?Q?KBmX5roiJHKMmBIgRFMeMRGguOzgCZ1fDJ8+F2dlZU/GV33yPP3pe+NiZsr1?=
 =?us-ascii?Q?nbkdraEiZE+a36D0VAAW8/rt/Pjv1U+BVLewnFo4Tnxk8GqoRWkswlNB9QnX?=
 =?us-ascii?Q?kSMQs4KehxCOeHE6CJhlQjCrdiAWTsbQOYZYIYBL0LCNCvkuEvmKoZw4HSV0?=
 =?us-ascii?Q?7C7f3BurCa+ttmoBGzFUvwFsVlgb2nit2F0DnIaEpOIxxA67+2qz467XNAWF?=
 =?us-ascii?Q?zyHarX+Dl72s9FfDPBXcFTlcarenOmOPJJUgdxKGosAJfn8Cc1Xrxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/iRTRgBQ5PkrvYt621AOI8cbnJEt+my9zduj6qsY/pMCp0vMQGCOj+l7g1e?=
 =?us-ascii?Q?A3G//5S8joyJn9cPaA7I/pmFtfjhuMPMqksj1ktAfsayT1gk/Koay7kur57i?=
 =?us-ascii?Q?4FTe1OfFvMY6/zzW5+o1EJg0NvftoNf1Chr1c+1q/lZjKHkjMA99QqB27/U2?=
 =?us-ascii?Q?aQjDaOCNMptURa5eiO99x1tn09/m+v8EotOxdKSUoDZIM0+XvSM7/WiMpBXm?=
 =?us-ascii?Q?qVaF+bJTfdpEGvGpYJSZ4ImBFgNcIViAX5NOm8ziT2ZJ/bwqCvTg5nxB7K2g?=
 =?us-ascii?Q?VTAomFeBC7SS9gBTUxMTgPRbXNWpOvd8cms0+Tvte9rS2TCVJCq0HD6IGIzN?=
 =?us-ascii?Q?sdGFQ1UCWMwSPEhOmX/ohfKxIzomh/GAwyng1DAQFzkdO5OMg08f9ub4V5BD?=
 =?us-ascii?Q?tOB91U4XX7fs86yXuLLd06r/SZjk/kqcCaTYo4emB6yPxFMpIZ0fnr/pspg+?=
 =?us-ascii?Q?LfnDRQu8htu7re10xxF2//ZOvOWXKvfS07xAD0ZNvioOIGybFY7K4PbxE5rB?=
 =?us-ascii?Q?r8OEo2mOsI2s+hXmHuUvbOwKq+AHDdwm2dLGc5KTyvtWZmtJbqHRywGB1QHB?=
 =?us-ascii?Q?/YruUcvRku7xgEgHw26iGQMropDsHbndW+GTht86XlayhHFCwHZQySX+96P+?=
 =?us-ascii?Q?ExxizaBv+yjS0u297JtC/ZyE0GZ8T/1CSPWjYMpT3fCIw62zyJ411/lspO6i?=
 =?us-ascii?Q?eDyrqNQOJo3mqxUBAcg6j1bGNKX/8LWE5JkTV3a3KG0IzgisQKN3wlr3hmom?=
 =?us-ascii?Q?jsFP2ibyDvrVxXqRaXqqk9yWKliM1nbx/idJGuFwja1liRWVjloB0vKEfNyN?=
 =?us-ascii?Q?rpPrFly40ZwI28XEUMt/sKqoq0JKSFwFPl4woCYfbXoIRuhRwKkMBXqKunVm?=
 =?us-ascii?Q?rU6ZwcodgauWHXbzbDgpS09nPkSKUATIRopUgO/0n/vl1X981zaVkLHnvaZA?=
 =?us-ascii?Q?PtMLSnrbzydu31v7UgnSErahHLn5Kbbw0z1cYu5xSZBSzvkSwkAKjAdV9kJI?=
 =?us-ascii?Q?KgAu10gw8G8eK7y2uoayn+iPMyh4AvXnD5E0UKVD3oQr9rlSuciIJoFNw4A1?=
 =?us-ascii?Q?BP1/+aJRgIyYnHUt9GH+tGDHevEv/IsrHrWQE7xTiVcV43Mg6G/osyxau1wc?=
 =?us-ascii?Q?Jw6MBKuSQjRkFvOk/N14QToTzwANf5UULctGe4NU1AMrfnpUQ/L7E+BslGLH?=
 =?us-ascii?Q?A1bejcWLUX2fp2al7qLG3UYz8+rH4VEZ167Jb5yErreHbuIdDDMPccIEtWcP?=
 =?us-ascii?Q?YCnCfmcMkotL/4naT3AqOsJbJ7MtiO2YYnPaEJgdqAmTVBd1SuxhrfTeh0NL?=
 =?us-ascii?Q?F03lN5XX9EvaoG1xYfVbE0UOMp6AIPeLdQI0MKmDHhjjA8TdXJpYGbmz4Kdc?=
 =?us-ascii?Q?xAfn+HeS42NSMfdtp7L9o8DsdBur3FhY3omhxEvZ1Do+3V9L9LV3I7mseOFR?=
 =?us-ascii?Q?sfvk3L0L3k6gATmXs1CfzWiiKrT3p0UWBNMMI3xhyo5deL31KBAw3CDheneS?=
 =?us-ascii?Q?t4r+A1hH4OU8laLcRGjMDOGJFvrrzaSvh95sVcDhr2jjLm1HVhU7np7TuKsm?=
 =?us-ascii?Q?/HWGanIJajWLeyP1k6aX+MpZ8X1UymaKxVcUz4wZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2410a773-8cf4-4b37-cbd1-08de2c4a309b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:43:48.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pts8zzZlJtOycP+hTgjA+LJlHUipDsPvpsaCZ0ipyRLEnBXmYXd8sggP6H8rfj8c9aht97U0Io56TWvcRDmcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9870

On Tue, Nov 25, 2025 at 08:15:12PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices along with additional interfaces like I2C for NFC solution. At any
> point of time, the connector can only support either PCIe or SDIO as the
> WiFi interface and USB or UART as the BT interface.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 178 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 179 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> new file mode 100644
> index 000000000000..fe2c9a943a21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
...
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply

I think need ports

> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key E connector for Wi-Fi/BT with PCIe/UART interfaces
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    connector {
> +        compatible = "pcie-m2-e-connector";
> +        vpcie3v3-supply = <&vreg_wcn_3p3>;
> +        vpcie1v8-supply = <&vreg_l15b_1p8>;
> +        w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
> +        w-disable2-gpios = <&tlmm 116 GPIO_ACTIVE_LOW>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                reg = <0>;

reg should be before #address-cells = <1>; and no empty line between
these.

Frank
> +
> +                endpoint@0 {
> +                    reg = <0>;
> +                    remote-endpoint = <&pcie4_port0_ep>;
> +                };
> +            };
> +
> +            port@1 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                reg = <1>;
> +
> +                endpoint@1 {
> +                    reg = <1>;
> +                    remote-endpoint = <&uart14_ep>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b3f689d1f50..f707f29d0a37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20478,6 +20478,7 @@ PCIE M.2 POWER SEQUENCING
>  M:	Manivannan Sadhasivam <mani@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
>  F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
>  F:	drivers/power/sequencing/pwrseq-pcie-m2.c
>
>
> --
> 2.48.1
>

