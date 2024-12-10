Return-Path: <linux-pci+bounces-18037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2E9EB7BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5A282DFC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F8232398;
	Tue, 10 Dec 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EYUwJJJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681B214209;
	Tue, 10 Dec 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850644; cv=fail; b=Rq6SiPPsuFwkGOF6OeEZjzvAaRuI6NDSd1xhGJ0g19AWDEM2RfBlv06K7EhtbN977lY5Te4rLg8qyFPDNCgtuGcLRnBiTUG3KNgRHrWzmDughgPgWv+1HZCc/JlV/IljXco1D+E080+iRCZA7Ess8GNAXvT9+BTYNiup4zI56so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850644; c=relaxed/simple;
	bh=NuuzVd1xs1B13k9TarRy8rcoz28HKDejP7fpUIMGZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjjqlJYOsZjyl7mK4uCokVVMuUkGs+qCqKonXHW10HaUAJirKwtJV6Ndv5v6QyzNxnnjweMPBZ3okfSGMCFkcqXYCWdg7sFANElczDDL3QgfEb4SD+3ArpYTK02spGtB3zjwIEC7k/dTcsbCiplF8SwtBzje8jcN30PuWqYBsW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EYUwJJJ4; arc=fail smtp.client-ip=40.107.241.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDxsLWeCe3RSuleYHXtpCD5ej6l6IphDjztPJrTIYA2be5hODCS2c7OkegMqB0EJa+LE5MSCemhFTNWyCn/Y3NKHwtO6cBfu51WAMKUpHVmQ0UHwsKrY9b68PokhPzUD/B/CQRZXDmCJTYs6TrGxR8fTYwCVgd72uf+tcwieH3WkUsxlgZK/K0h+qemlqwUh9VWHDMqKv6GPq3dGy1HCFC50aVFg4DULPpbBnxl0PYwdFbgU8RLv73lC5GZPSZyfwQDC/Pm8SmjxbEiwmJ6c40GDE6c7ELPH9kID5n0qIpFYnCdgAqRo2RpkX9qW3yAy9mw2kSJEzwjmBNT29ahLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW4rOzvi3ynpm8ZgW5aifYL2R6oS5RzfUxq11nfGAKI=;
 b=B1F6z7uIUlHPuoND2mYTvEP/Jl/J+UGBelh5bSiiWc+bq/gEhnEctwqRj8hi2ISxxfGrpurH3Ax4Nt4fNX1ubYyWEQIPG57VmRb5I4WoXS30lq7R7EcR4+fStjAzA95XMg7zgONcQ22LYQHRuBGXNb9sykZkO2Yt6PZwTtNO8XI/hajLZDjk7m3zfQBaWNPyp+xgaU+76r//UslOKglwM9roxyxt9XkHJwOHybUNUGJ83EhehiYc7yTLXOzyfE2eFcxIbWaeUCunIrVmz8ls7GlUtvfcQUY+OaqVjngHWBil3l4E3StAYVeNBq1lknqLrzDmgO2crKO/EcFPUB5gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW4rOzvi3ynpm8ZgW5aifYL2R6oS5RzfUxq11nfGAKI=;
 b=EYUwJJJ4SD7bXpCMkjdKwgbLj1jzJC6ASruqG+fR1yFxwZlSSIEsjfCYg0hTC+5T6h5+4VkHfdvh5YMYWjpeFsRNDvFwzssVn7lzLstbPrDDccOMxEBqrRKpzIgwS2oBtDqcmR4DSUhBp94rjb1X+zdFsOgbPN4Befs/8Gk4/GhXkT66va9w1NmwcAVDHDXAitipLkaC9EZ0Qipq+b02AOgF7rCEhpsBhoDHXcAVcuBWicRY0es3EgmNyiTuXB2HGrbXymFN6Gid/4wE0/hsz7gbkf/yKDvbk8dusaL2VKXzF9OUzy7cZBuiL7yBET3+77MU2HwCoz4FbFWG7j+08A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 17:10:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 17:10:37 +0000
Date: Tue, 10 Dec 2024 12:10:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <Z1h2BDwcvbyroNx2@lizhi-Precision-Tower-5810>
References: <20241206222529.3706373-1-Frank.Li@nxp.com>
 <t3mrs7bap5fbiyxpth5r364al4ca2s72ddsoqgutbrlhrgwqae@qmcjeis2akwp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3mrs7bap5fbiyxpth5r364al4ca2s72ddsoqgutbrlhrgwqae@qmcjeis2akwp>
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ba3867-56ac-4e53-8392-08dd193d90d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7uKP40/LIzbNtZIHDk6sdZzFweC348VRe2R1eb+FRnKzVTQxmGcTTnGPrOY?=
 =?us-ascii?Q?REk9jkrzbre5rmy24nycNctbY3GBYjcePB3jK7KoYAbmX7BJM9JkvuAiSO3p?=
 =?us-ascii?Q?P7W//7sFTt9KddPyaljatS3wsuikW+ae17ToFY9d6jcl1X/7Sy9n8upgX7U5?=
 =?us-ascii?Q?jaRiqLOCDtjZI3uJ89Ah7q/Q66mZvtF51gKE6VTWDsvfLrB+pi/CyOnT8Dkw?=
 =?us-ascii?Q?7BIfdhHLjGsiKLwrc8JsMp8vCDBQqgNwxjykky2psuYTFI7vjBoq8UwY3Yu8?=
 =?us-ascii?Q?1iUTdVJTZ74aILAbAa8Ke8j+rW9EdCtXXojcGYqXGxyNbo/t/LW4ZJ7uHj90?=
 =?us-ascii?Q?UVihXRkoFbFhrJc8F/bNwoVzEwkEc9l4htDSrcAkD7yDHQhH0ebxmfyY07f1?=
 =?us-ascii?Q?OmpIsPEog6Tum8z4VRX2cSa979f8mapIXeY6NNCDNtJJh2Ts46I71oZngKsG?=
 =?us-ascii?Q?13Ab1LQdaIYZhRXZW4yAr60nlGHk7ANPSidg07Jjql7Y02yOjw4VYU8QzKd1?=
 =?us-ascii?Q?30hrRd8Qa8PYkhWT104m9ppLyywZpZ/ib2yWmhf7XTUvjaIenHsWs1Bfn4lT?=
 =?us-ascii?Q?OJ+X2lRZiVpppkFsUQSO0aBec/EO/jcD7zpx1mQW/Y0Id5sqFSLLBd1pSJoI?=
 =?us-ascii?Q?/8CfMQzHOgpOJLVmDZDFytZ7LRsPCXfsHwTx+QMOPjnF9XUDsmSr8C142SmF?=
 =?us-ascii?Q?Uh5wSMXe/pV+fBjBd+fE1z1sSyVr+J0rE00SM3FmBI0/qRj1pmbEzvuQ+l7x?=
 =?us-ascii?Q?y3dcfDJTR3JHyydjnyYzfTEjdA2jpE4Dk8HXO8RC0Frmh1uanfBw1ZtSaQsP?=
 =?us-ascii?Q?8DEMSI1vMmAKW7Vn8sFyGbT8/mR5txurd7dfC3YuuA8SoqeZ6H4DFffRjpMy?=
 =?us-ascii?Q?xk8QH8Ju35DMTQBcTI1P426RIvrSK+zvWgHS3liqzIbTraY55eYMlJw3GdK7?=
 =?us-ascii?Q?awmQAujH45Cm9rajg77QZyluKkMQM4F9uZaOvZlL70C2XK751Iam7prOSc8e?=
 =?us-ascii?Q?GoQIbEJ1cFrEds3TWFDosVTbyeQnvIKGMwZsVeUwaxDwhkZy0O2ioWRtIE/l?=
 =?us-ascii?Q?B7X9y1LNB7jgUe4rZdGiC3S1wSzyvTgJkFmyMcuqujyurAQ6MLppwViTAdFn?=
 =?us-ascii?Q?CjraU73x3u0NVtBUdTP+UkIWDgujHT2ce7t0sVygSH7Ogdh85moIuEVnFCmp?=
 =?us-ascii?Q?1U8QWrXqHyIRrUeLVJjMPr9oeBuFY8jG/JNv9BAwa3n3z0PtOhAn8qvSLjHM?=
 =?us-ascii?Q?HEgACvfkuh0uXh0Qdf8Ly4Zi5K4ZKQICyEI+/JVXu9xq6BU1HoivESY0EVEV?=
 =?us-ascii?Q?LyhNguCRWIpbZTeHZrba80o8kZf3BacLSSycB+EVKVcI9ubBrXogHTlZeBF4?=
 =?us-ascii?Q?MT1d0qc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XXY36CO0AWDR4JopQ4srSfRVPojI5i2zinE3m4zq1hdiirRumlRXiLdeZErW?=
 =?us-ascii?Q?THf4BgGuLdy3cRLqNx6EomgQzxirLMTa9aT/Qg3SzxbHlLYZ5NJBdlUsrbk+?=
 =?us-ascii?Q?ilflE3uTGGWx6YNWttDMEXZ6LMltVffME4e2zGWZNwrkz1oO02TKeiiHuoJl?=
 =?us-ascii?Q?tCsgNTG3Vyl5Um/sKAmOUMrmI4dUVGlBAKiXbPN+8jbdcxNMBfE2qc+suP7y?=
 =?us-ascii?Q?iLV6A7XHNky4Iicv8U4heFdAji+KKXANSGYk6FRgvLQEIrgjflwvzB5CPa+l?=
 =?us-ascii?Q?AyCJcD41iE/+zj2dgsK7Ynj3PLR926NN8KKA2LNI16a9Yf9yaa8CKhkSPOy+?=
 =?us-ascii?Q?0BJgmRUV799ckun5FIrv/wzOnHf0rb8EF28o4N9gWldGHlnv7k1mTDtWw9CL?=
 =?us-ascii?Q?leBIBtlXoP64HppKywgHR4YfU6Cr9p4/5gYny+RJ5Rkj3ww10Wu3+muVcXXQ?=
 =?us-ascii?Q?/yQND9XvYukYp9v4iNvMliMRBiiIRPFsFSSPHGMrAMSfeyb7UfLEioZlTL2v?=
 =?us-ascii?Q?4uUGzIfHNknpRFx5sFUp0dJFi8C9RJda7VJwb4nl1DoS1ZL8OGHM9N8UJsox?=
 =?us-ascii?Q?RKPB5T+uDUdhBe5pVzZZUxROcvOEw22L2thn7pJUu0zKnPP/e/QGvqT9z7go?=
 =?us-ascii?Q?2l4CwW18RqaJkvQelcZ73ByjSuBYZHHHgwnkkbkHkGjHCb67wKIWObs82Vji?=
 =?us-ascii?Q?bqc8n1F6YnZYk9rT6pDrWBbHbYrmyk2maDktiJNSzHNRaMSk6/EHlra0KdjL?=
 =?us-ascii?Q?J2sNymQS1Nkn+1GalGAXgVzReOPmhmTxcqijcAnZ/xSXEmi4zpvPPPH0twot?=
 =?us-ascii?Q?D1kjiWAwNUMvHgWpN9asolYuFWJ8PpjLEt3wQpfr+HbgN3SMjJNTmVy4xpM4?=
 =?us-ascii?Q?tjzp0dtc1Kx8OVGv4BB7ryWhbKIkvRaTkoj7qKIT2aTh7gY4tUdwSTpYzC32?=
 =?us-ascii?Q?MVJxVtFKtPCxQR04o3p9muDSBxvqH7uREOf1oYjc34BXlY94xxTnCtgPdJds?=
 =?us-ascii?Q?ap4CO1c2ezIlMReWEL4ZOIc17jnUnlcFVM7thQJZevWANy058OnVB6xCVT97?=
 =?us-ascii?Q?v/u/Qc7g4KVmHRhgFzcZozG2ehBnbBPXR1lyrKAyDiIMoTx3/KghPYKB6VhN?=
 =?us-ascii?Q?pzgm+QEBUej4k6Zlw60EGXZZjgHvHQT7W6ePH+PDEzMM0wVzUyA2YYgRWeSj?=
 =?us-ascii?Q?sAiCD+zT96BXk79IkvvSScQ8bMb8MbdkffYbFzCfKVZct9D8/y4FdKbYhnYJ?=
 =?us-ascii?Q?OyeBjjXSfmJBae13dMYN/IdBzfaM04MzdMb8/UD2I1AjwwnrN2NyPd9XoeFr?=
 =?us-ascii?Q?aArtyfymXMdnZwNw3PTadCs9vjsHbMfWJ73VF7yIbORzCMYHQaZLhI/kL8by?=
 =?us-ascii?Q?iTC/EOnpZwqSFv7EjWi2WymP+Ljq47FbaJQqtdsXa/iVq9pJE/2ROeZUUiXM?=
 =?us-ascii?Q?9daBlD5YfzgSHYZRjzMwe2MysKg2DYix2H0wbLT17OVLsLs9QoHP19A2/lxq?=
 =?us-ascii?Q?tvX3VOYD/fVv7c/EXtPbAlAjo6AZaW09Z+/C5IvTte8e+TnEJvfQm1dSgW6C?=
 =?us-ascii?Q?B7YHvC89118Pmym4TJ0eL2fN0Feoc5BDcwNte91r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ba3867-56ac-4e53-8392-08dd193d90d5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:10:37.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+vidNWKzhZcEyTXfLrqGGFq+LbVhfcBaBDVRxfQvvhyY/hyjTFYQTCvcRX2Yg5GKx8hxtOGXArSYnDfLwKAjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407

On Tue, Dec 10, 2024 at 09:52:47AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Dec 06, 2024 at 05:25:27PM -0500, Frank Li wrote:
> > Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> > layerscape-pcie-gen4.txt into this file.
> >
> > Additional change:
> > - interrupt-names: "aer", "pme", "intr", which align order in examples.
> > - reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.
>
> mobiveil-pcie.txt binding suggested reversed orders of above, so please
> mention that you unify the order to match layerscape-pcie-gen4 and
> existing Layerscape DTS users.
>
>
> ...
>
>
> > +++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > @@ -0,0 +1,167 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/mbvl,gpex40-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mobiveil AXI PCIe Root Port Bridge
> > +
> > +maintainers:
> > +  - Frank Li <Frank Li@nxp.com>
> > +
> > +description:
> > +  Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
> > +  has up to 8 outbound and inbound windows for the address translation.
> > +
> > +  NXP Layerscape PCIe Gen4 controller (Deprecated) base on Mobiveil's GPEX 4.0.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mbvl,gpex40-pcie
> > +      - fsl,lx2160a-pcie
>
> Please reverse them to keep alphabetical order.
>
> > +
> > +  reg:
> > +    items:
> > +      - description: PCIe controller registers
> > +      - description: Bridge config registers
> > +      - description: GPIO registers to control slot power
> > +      - description: MSI registers
> > +    minItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: csr_axi_slave
> > +      - const: config_axi_slave
> > +      - const: gpio_slave
> > +      - const: apb_csr
> > +    minItems: 2
> > +
> > +  apio-wins:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      numbers of requested apio outbound windows
> > +        1. Config window
> > +        2. Memory window
> > +    default: 2
> > +    maximum: 256
> > +
> > +  ppio-wins:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: number of requested ppio inbound windows
> > +    default: 1
> > +    maximum: 256
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  dma-coherent: true
> > +
> > +  msi-parent: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,lx2160a-pcie
> > +    then:
> > +      properties:
> > +        reg:
> > +          maxItems: 2
> > +
> > +        reg-names:
> > +          maxItems: 2
> > +
>
> interrupts:
>   minItems: 3
>
> > +        interrupt-names:
> > +          items:
> > +            - const: aer
> > +            - const: pme
> > +            - const: intr
> > +    else:
> > +      properties:
> > +        dma-coherent: false
> > +        msi-parent: false
>
> reg? interrupts? interrupt-names?

mbvl,gpex40-pcie text file descript reg as

Mandatory:
  "config_axi_slave": PCIe controller registers
  "csr_axi_slave"	  : Bridge config registers
Optional:
  "gpio_slave"	  : GPIO registers to control slot power
  "apb_csr"	  : MSI registers

reg have set minItems 2 and maxItems 4 at top. So needn't set it again.

I will add interrupts and interrupt-names.

Frank

>
>
>
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    pcie@b0000000 {
> > +        compatible = "mbvl,gpex40-pcie";
> > +        reg = <0xb0000000 0x00010000>,
> > +              <0xa0000000 0x00001000>,
> > +              <0xff000000 0x00200000>,
> > +              <0xb0010000 0x00001000>;
> > +        reg-names = "csr_axi_slave",
> > +                    "config_axi_slave",
> > +                    "gpio_slave",
> > +                    "apb_csr";
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        device_type = "pci";
> > +        apio-wins = <2>;
> > +        ppio-wins = <1>;
> > +        bus-range = <0x00000000 0x000000ff>;
> > +        interrupt-controller;
> > +        #interrupt-cells = <1>;
> > +        interrupt-parent = <&gic>;
> > +        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-map-mask = <0 0 0 7>;
> > +        interrupt-map = <0 0 0 0 &pci_express 0>,
> > +                        <0 0 0 1 &pci_express 1>,
> > +                        <0 0 0 2 &pci_express 2>,
> > +                        <0 0 0 3 &pci_express 3>;
> > +        ranges = <0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
>
> Please keep ranges after reg-names
>
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        pcie@3400000 {
> > +            compatible = "fsl,lx2160a-pcie";
> > +            reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> > +                   0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> > +            reg-names = "csr_axi_slave", "config_axi_slave";
> > +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> > +                         <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> > +                        <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> > +            interrupt-names = "aer", "pme", "intr";
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            apio-wins = <8>;
> > +            ppio-wins = <8>;
> > +            dma-coherent;
> > +            bus-range = <0x0 0xff>;
> > +            msi-parent = <&its>;
> > +            ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
>
> Ditto here
>
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 7>;
> > +            interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
>
> Best regards,
> Krzysztof
>

