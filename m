Return-Path: <linux-pci+bounces-30971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AAAEC0AD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15A63AF260
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E9C2EBDE5;
	Fri, 27 Jun 2025 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Syvlog81"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096C2EB5C5;
	Fri, 27 Jun 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055001; cv=fail; b=bONr2GRJqXrdPfo1fWQOJRc8l2IicoeuYd8OP9F1Wa42Y+46gVf/1YsD9lHENU4C8K1B9U0N2Z695bMS/wvPD1igfz0I/Z0Y27hMoRHmdtC8t97ezExInHFIlN4EUOcdiO15/blfzqyH2ejXOwCkPG3KRyTs9/stanCz3s+1hfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055001; c=relaxed/simple;
	bh=3HRf8VQgxw2sdHQjqPy5JiP9pYGjEY99WvrHsf9QoTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDJtyI8j/HRV6oav3osdulQbzP/rddGNw6VXY+KsC2fvowfqDFT+E87qfz2PV/f1lSvv7OJJ8dyrC1rDtkcWJ2ZdEl37RIWLPtuaB4Kcfnw2f63WPG6sthPrIZJSYDXC5+BpqUGg69ZA/8W7lmRC+Q+6dmtAn/NxPOBxsXSlvO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Syvlog81; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP4cPOtU6bIUKNHzDCxtc0xKcHXdx1aiQQrJfEuXdwy3icLmJb5P+vzUhaa1x775Opmgvbdlse0nExIJefuUpTFhUUh1NnAuGyU4BHiEaR2tUdrgvJnViVT01pDBPnCgcf7Ygd8nPlD1iFmiOGGy4foCxWQ5aKK/FXca6rlMBrnOWtw126EtNyRMThmiLrFNXgu/LmH9miAXLqhetizOfWoEc+w3MlK7cYvC/YIib3M7xKnyG+jTB0O4Sn9Qd6LuwpctKYwOD8oE+NIbSPn+WT5tyNZferrv4TFr7JvHooc0NWihi6EaDW642Zf2AtkOX2OOIweew1EFpIfXDY0PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+YqjNvr4gDd9aHBlm7kM3/xoGFKcX8bruFy+CUocGA=;
 b=icTdU1XxLOiyHbsXVIfdSYUfTKjOsGyXrWE8FDCmAyTlCpY2DaPZNwzRPI4HfMGUpTlLotHfyloIUvc/tREjOLlGRaqemMvX6+FaqxrRqIS8L2B2AccNY8CRQZgbBRbokxr4lfn0AsXIYZN3/qbQI417GzzFV+OChSnk8v+W4lyFQmhGJqIq/VtpBY2yifYtdosJ11cpGBlj2XFBlhoc+UQcWOWEwKlH94qlzZydMk98y7lO9dmpUBAJ2EDMUJO51AVORG86HeQH0Jd7RW4c9YXrMKmiYp0wfhI44dPcdwC/EqpE9Db7XkM0hq+O9M435NfuxynsxePSXdltQiBunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+YqjNvr4gDd9aHBlm7kM3/xoGFKcX8bruFy+CUocGA=;
 b=Syvlog81eQGnS0Y8PZyCaqQK8kZj+Oi1iD+ukFoLaUE/FDoTGluI4GC4IT8QkYdPWDNRKBEZIl25nqRXgX+PygPr7IKYmar+z4LOv8rKaSNmsFSgMJU9lyuhknppL1KAXwVRtOcY70TgfxNlID2BdsnjkPm+Tg23gRdjgDggretP4gvigNlu/hEc4iL8A4KJWeApATEEpguaW3NZi5eqnvLNx8IRaVgziKGXVuKBlcJ1448Ra8I/n5Juwi3P/BigftNRvitT90IiDI8g7u4YgwiZIGp68yKtKT54W4H7aE4WCVQItWx+waSg32tU6pIoN/vecUn0H38rRDyyZCtCGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 20:09:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 20:09:55 +0000
Date: Fri, 27 Jun 2025 16:09:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
 <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb14bb-b192-4d8f-6c66-08ddb5b69566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ph47SQ27WktI74YN+7Qv3ial/S2oD6k4KNqjbIH3+gmpW8hvo9Ve8/82FrT8?=
 =?us-ascii?Q?qAsxltnTCZCt/kmH+pw2DGk8k+vsvf0b9WaHhSadvnjwrsjeTK4pNwoTu/Ha?=
 =?us-ascii?Q?JEa7KwXiC/0PwmRnuD+jO2nSfe4L/1FTaabCnx7Yx2KBXVcuJeprchwUxvIs?=
 =?us-ascii?Q?VI36TpS9ItKa7/E18jm3VxIKHRnd6L/6vRJR7nJDOpLJaB7yCBZzd2ISRizg?=
 =?us-ascii?Q?FhvqeCFde068dkY8fH2yidaCIjiGR8EZXg08nxyZw+bpUQ+LNPNmOUd2ViKG?=
 =?us-ascii?Q?J1XgcI6YEj2proLJw9MjUnsl/mdhqK+7TeGYyMqIkq2aISdiuFN8yDrxJR5b?=
 =?us-ascii?Q?YJTN66Fxf6gHB2lf2WSFY5n0Sb1vlGpsqMrc4D1E309QvqlT8p+HCq6rT4XX?=
 =?us-ascii?Q?KW96wN5lGmT7tyRM83QN/kI3xPSVXKwxHM2IzoQDUyjXQ5z8P1i1Z0aEeV1v?=
 =?us-ascii?Q?rWfoRlUH+/YsmGhxGXtyUOM/+uy1pg4zipW+p2mq/ekuirDqYY3AzZdHP5af?=
 =?us-ascii?Q?rXYZPw6u9FdKFYe9WPX1XKrio0c1DovpIhhQ5CAI/lsphKk1O0C9AJ4N91cY?=
 =?us-ascii?Q?XSVV5Lc6tdOOLnWr4xI9Nd1a0v2CC+/KutrO4lIZ0mr9Jrm8ybUQ11NMtaK0?=
 =?us-ascii?Q?U0CaczuUVFvRlQRDMFHWENBPxlfM4kTuFdozfgb5ABhdTqM/nBJE2KveXfPT?=
 =?us-ascii?Q?y5LW5JkODLNGboPd9Z7mtNhyu3WoFvAViwNAEVTvAy9BnGeZRN+5iK1ssv2s?=
 =?us-ascii?Q?B8i7Na254vKylHGRb6mByYUJ3QCTpNi1l3MFIjw1rOd4UT3P37SH4HRpoDLf?=
 =?us-ascii?Q?I0UUeO0Ee/vTx5J7KQC9R0c5sadQsCE2NhqLX97adORdPaWE8cPKDeUgS/A3?=
 =?us-ascii?Q?rG3Y8aLLwGnL9wS8OdqcMa0y94KxWxvXltyMLG5A0AnNIG+urjKPFovGHjUY?=
 =?us-ascii?Q?+rim/vcX5/BCcc4MwIRYDUSxye4uPA2cmK4RjTJuvhgLuVDsyaq3RYtEYEa8?=
 =?us-ascii?Q?tJhTTDg3u5JTS/RYxqMDl5TpA2J9dF8vOYmfUoK0IV7xC02/ARs0jNYiW2wQ?=
 =?us-ascii?Q?a94f0IvtCfKLpWQ8uwKjfz4nEZBevxkeUe+v5A4xt0ky8ZjR/wmooYXUaH1o?=
 =?us-ascii?Q?T6PjDpCscB6aV7ZOY5XPMy2c5Ng9MO7l+7bgZLXXIYdBZW9prSyUlZX+BM6u?=
 =?us-ascii?Q?bRptFjHTQ27I5Zdbyoh2vQ0AlPZcES6gxJgzgm11WcZRXh8oweIS6K0OMTAw?=
 =?us-ascii?Q?JGka7+bkCEnBJ8geUwvhAgmK2brmTQlw8g8VUw3XKrg+Q8tQHaESzFrf2u6d?=
 =?us-ascii?Q?ByOdR6yeSGrvi8zbeVSWj0qtGaDxtoASdE8JEQO3Iwp9QxLWrENVIGEUfzeR?=
 =?us-ascii?Q?iCcAkMWqoqlEpjPvSr27gnHg6AdjnpETZyE6Qyrt3WM59DQlNY4q0AXyHMMG?=
 =?us-ascii?Q?DUkL8bq7ZUHY0OSrwuyrGNU4YFLqxQIhTmXM8Nzq4HQ6lTTrltDjdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02KZd3rhSLUVXUDHOLEhWg05jsEaiHBWOd7Afz0OGNjfVloTRUZHf6yezPN4?=
 =?us-ascii?Q?OMleW98HJC57Hd1/EX0tGJmKOTXmyu4RbhDW8z3H5yafLcgsoghOqejEhuWi?=
 =?us-ascii?Q?ETk7jKgTL4KDgvdXXLptreGhnKAaBeSgzkSpRxXsVXiIqaDQAEhfwx5JKqwK?=
 =?us-ascii?Q?/yLKXmUdUAoCI7Ce7HpCVCJCsPTioObUjyvJk5VDTXN2S8bMc37hd8D0aGXd?=
 =?us-ascii?Q?qnGk7mt1zh0V5qusSCIs65k0+c/qFrL7Xk/myHeTh9tIudzY2nK8yOCNsp05?=
 =?us-ascii?Q?TAX4BmYN6N3aN2qkJb+s12lGqMmxlQelTYss6wbOy0GVJ9jcaT7EE2+ZyMQl?=
 =?us-ascii?Q?eOR0SY8bpOT4ZMK0X+pEjNrkca1I1PNht+szPwbNRrVJDFVqU/aRsNw9Z2N+?=
 =?us-ascii?Q?5XVTJ1mcUM2sY01s3vGJ5CYjpAnFrskkYR8xVY3gMo6W58/cN0WEK44HJW0T?=
 =?us-ascii?Q?bM28m2+556JSw9UlRLzFPgqmdDobSjsic5sDmg8gU9XTSAeDY+VDvhgpGtR3?=
 =?us-ascii?Q?y/ukwfhYHostKqVie2SEDawm8qxvrlal45RLEsqHP1je0+SshjbLKDFL5tGX?=
 =?us-ascii?Q?ICxxVS7hbqP3XiBOMnPnRxc/5wKPwAyGNq9C21SU0Sccf/pZ+vwbMMO0tZYq?=
 =?us-ascii?Q?Ti+ZqEgsd5UqfoRwXg+9AUxksTlpEOzOI6SVuP8HBPT89BwLiac5MEuGR4eh?=
 =?us-ascii?Q?zJ+e4hVlty0RB9xV7USDImUEWRqdadHa4PW5Uya+PJoiMZw3jXFZrNtYO0g2?=
 =?us-ascii?Q?gP6CbFr2smTtmpZG8Xi2Mq3e37xpmzCZlt8LeJZe9eqmXmaaJWjv+sY9B6KL?=
 =?us-ascii?Q?iQCpifjiaVcNhBoDga36p2jWF33253vir78tDvsXCzGVOj9a1LVhDzwiz7W3?=
 =?us-ascii?Q?kVirD6iPb6JnOdHgdkLG7b5skMBMNlh8UmUVOUlsEMgTJ4Lmf6ONsOZnCsXp?=
 =?us-ascii?Q?NCIWwqmaNuBUkTfgDCt8iGa1FIRJq8TLjmAU0ojTI7yjrdfwYkGyNoaPLBwg?=
 =?us-ascii?Q?PKUgmXPxitZ/eXRabGsQr2uh1E6dthYKtU9GVbm7/QRBhJL9rl44w8PhtQan?=
 =?us-ascii?Q?AHUv9Hb2OQnZhKL5ggl+fulkqtVvyTvTMUzz2IcuPTvjkGlKT4iBhhJ9zUos?=
 =?us-ascii?Q?gPlswXDUKOsjGVqmxjxgWqidR4hDHYCHo6/ig8A4dtIILgTiRD0WdtHNo5AL?=
 =?us-ascii?Q?S5F8EhQLFQrBbBj4YYRQ4GSbRFARXofTf/riVYOIS+rmBOt9xRQFEBgutD3x?=
 =?us-ascii?Q?oY86Mxr07i4IuCkfvKbSdAcyXzHXBaMX7Y2aagn8pcanhV0hygTBLRaCC00o?=
 =?us-ascii?Q?di2LEdnqjFj5XZ4fAQ/TJ09rDHjQqCyYT6LVa2ccB3ssyT2+pIufs6BlAb17?=
 =?us-ascii?Q?cVuzq8oBlP2WcVeAcfPgD6uSiTXKjQIou1e9kVQ5rBABWKQIburlrUVM74el?=
 =?us-ascii?Q?y9vD3dKXVaP3btDKMEMTtdtYH23fbDwGWaEtMYdsvZ5CPEreL6qT7XLU5sQb?=
 =?us-ascii?Q?/M2RPlPZLreMSIehUgU0HJ2VdbyRmRc+Dv3Pm44TYz9qpKIaFjiDHQiMZKcR?=
 =?us-ascii?Q?2fMqRsGwUWw972d4APY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb14bb-b192-4d8f-6c66-08ddb5b69566
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 20:09:55.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw/lBuUy2Am1l9jTaH1tV+SV9q9e8Jvri4hVaIoobBV4Tz2fCvIqQ4OZvBvCAcE2eYUn/jvh1WreScGxyp5jkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390

On Fri, Jun 27, 2025 at 08:54:46AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> > Add one more reference clock "extref" to be onhalf the reference clock
> > that comes from external crystal oscillator.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > index 34594972d8db..ee09e0d3bbab 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > @@ -105,6 +105,12 @@ properties:
> >              define it with this name (for instance pipe, core and aux can
> >              be connected to a single source of the periodic signal).
> >            const: ref
> > +        - description:
> > +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> > +            inputs, one from internal PLL, the other from off chip crystal
> > +            oscillator. Use extref clock name to be onhalf of the reference
> > +            clock comes form external crystal oscillator.
>
> How internal PLL can be represented as 'ref' clock? Internal means it is
> not outside, so impossible to represent.

Internal means in side SoC, but outside PCIe controller.

>
> Where is the DTS so we can look at big picture?

imx94 pci's upstream is still on going, which quite similar with imx95.
Just board design choose external crystal.

pcie_ref_clk: clock-pcie-ref {
                compatible = "gpio-gate-clock";
                clocks = <&xtal25m>;
                #clock-cells = <0>;
                enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
};

&pcie0 {
        pinctrl-0 = <&pinctrl_pcie0>;
        pinctrl-names = "default";
        clocks = <&scmi_clk IMX94_CLK_HSIO>,
                 <&scmi_clk IMX94_CLK_HSIOPLL>,
                 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
                 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
                 <&pcie_ref_clk>;
        clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ext-ref";
        reset-gpio = <&pcal6416_i2c3_u46 3 GPIO_ACTIVE_LOW>;
        vpcie-supply = <&reg_pcie0>;
        status = "okay";
};

Frank
>
>
> Best regards,
> Krzysztof
>

