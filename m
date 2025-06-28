Return-Path: <linux-pci+bounces-31002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63518AEC851
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BDE1BC1752
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690320125F;
	Sat, 28 Jun 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L7bAqvAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2A1E0DCB;
	Sat, 28 Jun 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124802; cv=fail; b=D3QfyT3Qtg5VPBFYNWn45uG3qVjXJZXTc/93MRgMpYcC3GLVE9HuDdzYhLmSCpkCTsh2JuRVzbIpYUQLeMjNHyrFO1wDaMusAbCL6wMiF5ZWCpcNQ98bsTlA1mT7HzJWFX9F4EVyIPIMKOJgB8ivFG9z5ReN5ImGUPbCD8qROL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124802; c=relaxed/simple;
	bh=+44swsE4mk2PVC6FpiGT8i5rJhyLQmEyOqbg+wRLzMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cuz2WzK+1fFwQ1pdIdV0eDWY65No/SUVxx6wSjn75JPryT0zpSXOdgWlWfMBpe0iWbebrVdH9oxO2DeO/xgW9z9LKYCRK+lkuq5aFKBbHVXfUT+8ECOn/f03UF0yGsJnADvrLSOhtzCmsacw1ZAnryO0hd0Zaq0AimBZjjEZ2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L7bAqvAr; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+8W/cZUXqQ9g9ON+m80g1Wm2woc87yxYyLUZVa7fFvbWQdbK6U5NfKA7Uyq6AVAXYiCOxjEgVCuLVU3Zi8Gxqmkz1vzfcCc8NqKOtksokllNggwi2aKZKAfmt5mQakyftB32+TirqCB8aJc0rxigglHsUZaQUA+2c59RRVS6T78Lkhnf4yYstdtvWEBYr9UA3OIo2Od3Nb95Hs9/0DAzItYFaKiEJx30a2q2LxF5Jk4p4RiqL5T0tBOrM5mK5r+Jn4EnPNTrazgcku2Rvpye36/B3Hj8xSbGh66Pb4xWkZz2e6uL0NmWOPcUiU89TMf3tySDLtCIDiBk8Gfjc2svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q9ra0j7ExksPjL9ADikbaa+PUlWGQ96x7BZPT7wQpY=;
 b=KhTKB//D5gmd9xp2/PxkjpYHVawGyPtnjzxKvKWGlGq30gnxjpDmJ9S0L7sllPatba2tfV2adh2vKRGFvJf2WeDVNYUzhKzB/AZJhr7BenxuN1nkT6gajeLHJaVBiEWHfH4NeVDS2yBBiCuFlpsOnAyLBUL1sNTk1kMByCGNRSniSZpv6p6pMTaD5Hkj73eHroh8QxUytwSf69eByw5m52acqCkV4qAS10FcDrrn8F7L6fVJPH6zk5pZqT7vA/99tJb3vXnPPjfHJ3JJd1LR350Y5BFaF6sJn2lqDloc7NuotPLbRLWG/Ub0XBONOCRLXo3rXT+rB7Brwa14AjW8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q9ra0j7ExksPjL9ADikbaa+PUlWGQ96x7BZPT7wQpY=;
 b=L7bAqvArAUFyg5vtWiggQEINsPFrdG+qqG2AL7xLwX7+nTpb7aluBd4p+y84vuvXst+V1ssJjFowpLkj1C9raNTzvkSDVe/pR4Rdxeuf+RRebw1yZOzfVbLgseA+LaFhkBXvj9bsIPVrII8t1jzYT79XBKy8tbYUGNkmnZWsw/uTRYLdUnTB7omw+dm1XI+gAbkb8L+6efCDY9314uXqw+RjP2BpQ2AjDJdd6V+ZafeB59UXJGT1UTIwte14UQt0NirwW6c57MmEnfBPMa1wc86lYJZxBSzoQ8t/+M4sSM/NIxJNi5xYnmx7yOi7MDS2ntlHlPdT2hCFD80i/OtzVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sat, 28 Jun
 2025 15:33:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Sat, 28 Jun 2025
 15:33:15 +0000
Date: Sat, 28 Jun 2025 11:33:09 -0400
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
Message-ID: <aGALNS0yyBR27tz4@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
 <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
 <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>
 <20250628-vigorous-benevolent-crayfish-bcbae5@krzk-bin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628-vigorous-benevolent-crayfish-bcbae5@krzk-bin>
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe67f74-8973-4dd9-8055-08ddb6591966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jrbeqKIzVfiSa7myf8CMj3Na9EUK0yqKsBjHqa7rmntauEUrvVv3FF3mYQE?=
 =?us-ascii?Q?KmvQ+TEXzEBCswOEqI1J+cndys3zD1DrS3kCEPAGURAMLOWwyRsVf0OMZUsP?=
 =?us-ascii?Q?WSwUjjvAgNrwGsOUQjJn+gisiwzHvU/9eRYcz2J4f/wqpt9S1opg3NlEed1W?=
 =?us-ascii?Q?sZTC8qYjuzYMwHREd6R5hX2I7y6t1/Eekm4DTm2eSmcqbQNrQh/1S6Y+cWkF?=
 =?us-ascii?Q?d9KO608pQ+QHO+wbgjib2HLDQRVheq75jNvRe4lzVt6vDKsfyhE1PRUwj0pm?=
 =?us-ascii?Q?hGcpOQ+bBEJU3WpNa6OXYUE/F2f6YEpXU+hOoCrDo09zgBu3Vf9yr09sHifl?=
 =?us-ascii?Q?02J7we2MuznELtIiaUhjAht313pF7ctZ9+aNtvbnlWLZjhxQawJC+qZ1mad2?=
 =?us-ascii?Q?COCZaWnDgkNIimNwhu8soJmWC9ehu9Q6CRkJjxS1yMcDXmV8byl41SZdvn1X?=
 =?us-ascii?Q?8oJAS1wFIuwlPsOxmFE7PZ7M/rQ6w+F+ldcLOyl1inU2fXrFRivm58ifTp0F?=
 =?us-ascii?Q?i4sDEAIFGDyqmpW3vNg32O+yWSE3IldzKLaN9K3nUz+kNUjHzyuhn4h6l/Tf?=
 =?us-ascii?Q?cB19lDyNChBSdZC9xRa/T8N7K5sjUpBAMXw0p4LwKXIQJYqOVw0jtEPfGN5Q?=
 =?us-ascii?Q?iBGcsZlebSiLOMWnViJLuh43+HFGRCpzFQA4XkXdozBco/q7Ge6bWfGVEyRk?=
 =?us-ascii?Q?uoE6+IgIFYZBe3+p5gBgRiTqipVNjYpFNKqrHVVXKPpRGWp5cBmo6GZAbpB3?=
 =?us-ascii?Q?woPwrz6meTePxPv25A4hfg/qk71G4vUcIPSSDO7Uf3XsV8YbFfjmG1X770af?=
 =?us-ascii?Q?e0araAO9e8rtAHAIkFJsVfBWdq7JlsojoJW+6Y44BnN3ImK6D5ElyE9RTAmL?=
 =?us-ascii?Q?jzDXiQ3olknP6+SfC6XTycJcqWGCAd6WS9deZJgL/Csj5DXB+PMO2Evyuhz0?=
 =?us-ascii?Q?J+CgLGBPWzXp0eLqjGRP7pd1K/Uod+65ZQW1MaFM5FycO7Dum9DtdkP68zaJ?=
 =?us-ascii?Q?/L3+ci1WaSxltotQDjXjMsxNRqFKi5f8sqJhI/E4SGvoVXRXoYI0VZFFktAl?=
 =?us-ascii?Q?leKDBCcfc1W++ScVb65oAVIO7oHoEcjkIy3zW5etHGAhgnu6hvpR5FoGqsOf?=
 =?us-ascii?Q?LX9i4+F6fNzVUCTcR8KylsIv+grkgdLXsIDJ3f+uisy1K+y1jONDop+X8f8U?=
 =?us-ascii?Q?8CiIPhfCuCiMysVPL+Cudv1iX7lH7OQkLcseuRRrdY4/vhLCi/1IGoeW/VtP?=
 =?us-ascii?Q?ZrH1sqFR/el1iMaXMQZh2l9eIwNSNIfoiuX9TvAwZ3ANRI2dEbV79HK4+y3L?=
 =?us-ascii?Q?VIwC/nr1w2fbNklgIxjMsQ7udkFo9RAFGwac2Htlwkoa74ZtUoJ2p1QxFInW?=
 =?us-ascii?Q?pIdXxAczsUB6ViOwU0YamkUp8KTra747KWAPoRy780HjSeXDc/Y4iJGf99r4?=
 =?us-ascii?Q?h+D7rvV5MM/QL0d6DoglxIcysDKu05MdDwy5zr8Zejhdytom82bI8JAMxk8G?=
 =?us-ascii?Q?x5ytCw+av7sQ4DE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96WrDL7HE11/WuPOJxaIwTg35jYCqR89HCqKK4JHNmXvFNJmmTnb5THLs61f?=
 =?us-ascii?Q?VjmApuEGDhB6PnAYX+20g8BNzpvKbdyL0XptkGOktltQ1x49B7qzKBY05kkZ?=
 =?us-ascii?Q?iqxtZ4k8NDR6nuKZ0XnMpqGpcC4LrvfW8BccyV9vogrerCr2UzdEBeulDLJR?=
 =?us-ascii?Q?F+2oWZcSCYv5VyTWcgtl849vbsCr6X46gChx1O4q9X/bjKbrR5prConNovFH?=
 =?us-ascii?Q?gdiIXY/kpuTYppjpUZmHGUHumeeAEamH+fmeMQ/BudhvgMr8GXDH+Z5c5J0n?=
 =?us-ascii?Q?gLC9RvqgwLOUPOzWyfUYbtS/xPmHP0q2flsERamxc70cSfQyhgjEZhwWN5YF?=
 =?us-ascii?Q?nkp2f0LXQlxOc9rVfb4mu46gXdRLQtvid/oYMFfWjUfFDn/Z+czdVYncQpUa?=
 =?us-ascii?Q?BXGOibnogYR5+5oky4lDvRXROtjT1dZfklz9diXAH91zceiC8up0MAoHjk1t?=
 =?us-ascii?Q?rX+nJ+J6Eab4dazYU3i3kTocHXyxmK44bEIe6X29S6YxxnApbq7pGOxmgeMm?=
 =?us-ascii?Q?ej3ngucTC5/U0+IAIvx0FBIhBEHpFlMEMgC6vrg1+9NLiRotrYp6Tu+ZUKIf?=
 =?us-ascii?Q?v7a4ON41hjA78JgKCA+nNScb4PzuGQBwDtmrTxvOhfNuHdTmt+8UwiLys/nQ?=
 =?us-ascii?Q?r7+bnTUEzUQHszGPnbl9V8b6W+W9po7vzoeofXRMafchyhYxSRYlkbgF7UH7?=
 =?us-ascii?Q?NPPe+b7aDc12Fbu5UmNYGJpTNVoQ9+z/vL/8cMqsLplnJ3bA1IVPSKZTKIMi?=
 =?us-ascii?Q?vFUkHzB2wOrqunF8+TZzUcBLJ09CSs/n6sSe0w5SVNp8gkhLLsh819yhuA4M?=
 =?us-ascii?Q?70dz17BFpXVH0lsUGl76E0srTaTe83i7ZSSILE8pAcstMiakSBNg/UiF0fP2?=
 =?us-ascii?Q?egbyxSnaoVV5F6yTuDmajmSLblDlcVAfP2n+A2giqMW+fLRF3vLYSnivMHKG?=
 =?us-ascii?Q?7mz4pksTWyrQlxHvselQsebCKYk4cUXkjd5Q9xwtGFWQKgrLDv4sF0qLTjsL?=
 =?us-ascii?Q?63TuRwWSWaEfn5zPqT5FVbDEMr3tnIdNoFu/gO67lnSF4bDoyA3MFRhhqet4?=
 =?us-ascii?Q?Vc623pXPaqPOkVdX3vVOqW9rjh84ozHTLse3kqpwQpp3eK9PJu92FkpGiUYf?=
 =?us-ascii?Q?rJ2nrC0YyQOnUYSKYS/cshVPJrLYeOr0B0F4lkKYmqEM3cPuj1tkv1wLIiAH?=
 =?us-ascii?Q?b6gmzoukRLKFYTCCWv/vB+/flDwl4wQ2VPF9o7aLJQHp74FPl9IjnJpjvbBS?=
 =?us-ascii?Q?+uQit+G8oj1fXfasEkCFLspcbGBm1vAzUq6Ey2VwGMQC9ET+pt3fv3iK7t/6?=
 =?us-ascii?Q?T8PtlVH51gH8z00hPcnjdkFBcpPk7olX8Sy77n+VV25QELq+rQuTeUnb9ZqJ?=
 =?us-ascii?Q?HOrjvkw+NUBx+inRsyB7YWC7aoBI24Azt1cARbO0skvzLwqdA030hr7aq6gV?=
 =?us-ascii?Q?JSR7Deds9ROCeeQ+f4rNJOPL8tfs8vMPNputhWQ1+s22RFa3rBbP7G+j/Z26?=
 =?us-ascii?Q?xjCKh+CN7sHPB+bAmemyWf5nuAClD85OCLGCquhexYs0PiAkPd5LACFnAlg/?=
 =?us-ascii?Q?ki7hfjAPgIBxtUpEHJ9w4lg6zJn0MWmRHyUeOmK3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe67f74-8973-4dd9-8055-08ddb6591966
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 15:33:15.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec+Wou3yMQ/ZuAOjuzsv4J5pqPRaPz7dC1WAlHYhUe8vB2cbaqgNxfEjMFA7blU7P0vb7gxctPX7qssataR1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

On Sat, Jun 28, 2025 at 02:34:12PM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jun 27, 2025 at 04:09:49PM -0400, Frank Li wrote:
> > On Fri, Jun 27, 2025 at 08:54:46AM +0200, Krzysztof Kozlowski wrote:
> > > On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> > > > Add one more reference clock "extref" to be onhalf the reference clock
> > > > that comes from external crystal oscillator.
> > > >
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > index 34594972d8db..ee09e0d3bbab 100644
> > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > @@ -105,6 +105,12 @@ properties:
> > > >              define it with this name (for instance pipe, core and aux can
> > > >              be connected to a single source of the periodic signal).
> > > >            const: ref
> > > > +        - description:
> > > > +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> > > > +            inputs, one from internal PLL, the other from off chip crystal
> > > > +            oscillator. Use extref clock name to be onhalf of the reference
> > > > +            clock comes form external crystal oscillator.
> > >
> > > How internal PLL can be represented as 'ref' clock? Internal means it is
> > > not outside, so impossible to represent.
> >
> > Internal means in side SoC, but outside PCIe controller.
>
> So external... It does not matter for PCIe controller whether clock is
> coming from SoC or from some crystal.  It is still input pin. Same input
> pin.

It is NOT the same pin. It is TWO pins, there are mux inside in PCI
controller.

There are similar cases in s32 rtc, there are 4 input source[0,1,2,3]
https://lore.kernel.org/imx/20241127144322.GA3454134-robh@kernel.org/
Only one provide.

>
> >
> > >
> > > Where is the DTS so we can look at big picture?
> >
> > imx94 pci's upstream is still on going, which quite similar with imx95.
> > Just board design choose external crystal.
> >
> > pcie_ref_clk: clock-pcie-ref {
> >                 compatible = "gpio-gate-clock";
> >                 clocks = <&xtal25m>;
> >                 #clock-cells = <0>;
> >                 enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
> > };
> >
> > &pcie0 {
> >         pinctrl-0 = <&pinctrl_pcie0>;
> >         pinctrl-names = "default";
> >         clocks = <&scmi_clk IMX94_CLK_HSIO>,
> >                  <&scmi_clk IMX94_CLK_HSIOPLL>,
> >                  <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> >                  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
> >                  <&pcie_ref_clk>;
> >         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ext-ref";
>
> So this is totally faked hardware property.
>
> No, it is the same clock signal, not different. You write bindings from
> this device point of view, not for your board.

No the same clock signal. There are two sources, "ext-ref" or "ref".
PCI controller need know which one provide clocks.

There are mux inside PCI controller, DT need provide information which on
provide.

Maybe my example dts miss-lead you. Altherate descript is
  clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref", "ext-ref";

  But we thinks if ext-ref provide, "ref" is not neccesary need be turn on.
  So remove it from the list.

Any suggestion?

Frank

>
> Best regards,
> Krzysztof
>

