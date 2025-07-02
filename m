Return-Path: <linux-pci+bounces-31321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF76FAF6612
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 01:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660CA4E0AA1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E723497B;
	Wed,  2 Jul 2025 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvpKWsLO"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE72EBDF8
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497793; cv=fail; b=t1Dvp7i78UaDI/LzLBUCvZmy1EbbJh5MbDftzN4burWV11baYTvEWjZEUVsQ19+YIB26ByNmtuZO0AYI+nOchvTMQDJ6/NMpUjR7+Eicl3Sb0Gjd+nZJuEtU551EdrwNEavbjRkyiHQt0uTRSBb2p7s1mRHN3KNZRAh+PI/8Yk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497793; c=relaxed/simple;
	bh=oMVJd+bqG3cj9kJnfxg1vh89sj3+WlxSvAPpPVUMnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lE70mmBHrCcGyPLFi42vdZMXhc4Og9EGms6ciptO+zPqT2/w2CNGY5sU3icx5r9t0Fwrl0hhSYol3An0870regxSIRVNlMlFOywLnmPZ2CW/PZVTWT+xLs7D/Pyh8J8UcnySCd+HCMJfNZUqXjXlHCJcdWhsTf8P+bevwaD71W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvpKWsLO; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL3AyDmozEEjITI23CUZOcqez8gb6ZYts9VsrAzTqY7yBWeCesO2MzmhtS2IG+omLGgoIpSx8GUfpaOShDMEsGqkhTrTqxPXQBdSQXUCOrgw/gJfw51E4zQdZ+uxAD4xfY13Hm6V34gtIaNBD72VoT3Dr7838hp+dbMwlrEUnAaREq16oRSdkA//+sB0uq/BeXZGpSeRZoY4s26Iz9z8nCcRkwbylupNQiJsThgcAgY5uRQbcoQKyqCyRjlMbNmJ5UrkSpexcAlk5cpyzr1tmnY+Tc13r6M2xOQ9SLI78iGFDE96ITN1s2F9VFimBVAljwdxjL0CnjyIMeBJUzycGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a1rqG+FVj4ozBrSrmQSn4RHvlZ12TPh1W4KMDwbavk=;
 b=deO4lqqDr3eJzzZlFIMnNaE/Ea6azBsvORK6xYkOwFX4DATAZb//HVQFZmXSRN3pAqeS8gLEfqwlfWVcEj+uWSoY6m1hb30hElpTEHVHDNsMayzOOMlgjvvlx/Fwk5Cva/jmXA/mJhIwTVwww+rJhoY7c/NQ8MvAAOuAJdfLVTh6CTJLtize1XdvZMEo9w/KRTvuAwQ2Oky4Y8A26EYvZhvtKR4rEGUWiCd1os52tACyD1tCQYFwrUG2BzmRHSWgq2aptUDZ1mziJ2mUb4Aazt+cKdLAJfGvS3+3nM31DvrC9QCkT4JORah3iLI9n12VgsfHP4PoPb4OF7oQcMqX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a1rqG+FVj4ozBrSrmQSn4RHvlZ12TPh1W4KMDwbavk=;
 b=JvpKWsLOZmV/1ifo7KwENzVjLwZeBb49h6+HsWK1kiBcZcYwR5qvMrJnKEGOP/tKndcmo78Bhzr19ssiCUf0p0FTMw5aGOKoLNjqkSV/4Cg6VDfXDvvf952T5GoXjTlbCJL8yWUf1cuuLCpANtSEl/ZMCSiz5JJNfYXHcgfuvKZSkombOqRKS6QNCGpBTkOu+WQ2lHctFbRbe6V0XtcaS+nqNtJjmtsURww1/YWrW8NGE89doy8eqknON/Fc6t0xRaGAQfbH8jnc0GDWfi4AQrCC4KDoGhl4f9veTVx7izpujWgIFEMdRrgDcYXtWpktRJ+K210qyFDGi/PfDTWo3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8009.eurprd04.prod.outlook.com (2603:10a6:10:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:09:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:09:47 +0000
Date: Wed, 2 Jul 2025 19:09:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
References: <20250702223841.GA1905230@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702223841.GA1905230@bhelgaas>
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: fd78097c-8c4a-4f85-37fb-08ddb9bd8a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adv2k9eVW6/ZZJLWLx0sezI6A0pTWVwc0SEK4Gb2ng5Sye3Cusnu2a5PGZIa?=
 =?us-ascii?Q?TTpe4i54tzTm4+viylODHvSgPZA0QA4OEvguj96BvNEsyU3N7CkhJaZ0YDDh?=
 =?us-ascii?Q?wCjiF3LjwyNdtRctTwFRGSJTwksBxsbSGY2o0AlYXgtcB8S/NvVCDhn7axYn?=
 =?us-ascii?Q?TngP3R2Lzd4tnWynb4zARR49NkZjuElXpdjC0yMeZnZPv40ENDbg2lIWp+cS?=
 =?us-ascii?Q?IOvCo0e0sCmZQ+h4YKC3rHmfG51tLpa45Ysyg/+v2kVhGnGqv5Sr/RuagnvG?=
 =?us-ascii?Q?PzoMf56kjkfjM9tsfql73k5EntL6EVqS55vGzGKZ930yhJsJoECwux0xdx1X?=
 =?us-ascii?Q?p5KGQK2If7ZjpvPhZ29oiDKqrFpnCe/lhp4GVCTy4WVS4xKGMQh4WRQeV1u0?=
 =?us-ascii?Q?2+Vh9HhL8rRv7gq+MqO/kn7iVqqlj8Q7KPuK/YqRMObGyOd+wXP5ZvDWTBAf?=
 =?us-ascii?Q?feOvMgitx0JP4woE7iP/pQ6uLbsBkNQPVZUITQQtv6itZNuRdUzqnX28SVt4?=
 =?us-ascii?Q?TDCTHUukLz1dn1t2l5GXMk1+0UTZZ6hbe9PzwK48PAfLO8B/RrckgzDoediD?=
 =?us-ascii?Q?sz8ds6tNGPSBLOIJwcrauPeGzc2WDe+q+c0duN94X9VYcv1J6efFuXkGl0vk?=
 =?us-ascii?Q?L2NhcsnI4r3q1GOiQr8L6qHm2WW2dZEqHC4HAlv1AjQqekychPUgyBEb0Q4N?=
 =?us-ascii?Q?st2sJXhseVjAMj8AC1m53biDQzbl+/D7rf6692mcSBYh+pOnvOzSBkLRqLTV?=
 =?us-ascii?Q?reiEvI9gzLpibSXnNQi5vh3tQkA8oHtJgtjJYC2z+RZMfvbiz3HMBexqnVsu?=
 =?us-ascii?Q?KbznW5XmIrdLcoPB1g1EX73SRePGRs1Psj20Cz7/eBLYcWjqTKvT/oshWD7f?=
 =?us-ascii?Q?DXtheJAWMDwbRSatHamY+fPh5m8pfk5Zdp+cmuEiMSOFRa/wvqQzJBflQ0op?=
 =?us-ascii?Q?Mwd1kXsJR+H7m0+G6rc9WR2hDL5sooxfM5rHFCNnXGdpitGb/5eA4qxQZucx?=
 =?us-ascii?Q?5unJSXmXd8Zqh4Oz6h5RqzbVVEP6KnUiNx1rXPFJvZjEpqZVJJFbqM+9laM+?=
 =?us-ascii?Q?DeU3g6BAxMQ/jHFzIP4fnRisNExWAGYA5g8xnjGLO3xU/qT1/LRu05B++1jT?=
 =?us-ascii?Q?S40qHylYqrIZ5bNWVEg7Pj4h+7Qj/OFDeXspjDX0p/EokBsklkwXYOmgDG2J?=
 =?us-ascii?Q?slGyqpasiqgtsi3C50oQv5ZZQGfkudIwwufR7Im+LtPwTFNr8aJHHEzw/Fnv?=
 =?us-ascii?Q?iECDtxXL+UlfNbSYwLTqeBE7IsFafdEyHOFoRHG2uTvKOFxI5MfvwCDwpgY0?=
 =?us-ascii?Q?gLVIdYjErSKydWGlp96BI8B13M8IHh+0EdNpoMLMXuW0Hb0Sgdm4ZySiTG53?=
 =?us-ascii?Q?/cv7VLZjDb5ZaLinSUXsYtbox68nf9uE2i16fVA8CNp6lM8x/vUepT8Rxmn1?=
 =?us-ascii?Q?HVMbjj8+B5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgjf1LmfkU8RZFQjqxW1pt4r3NdFAwE5LAWsN2IJ+XxRBvnmiL0s4vH/MSKv?=
 =?us-ascii?Q?ATeEZaMgRuYBoaykff5E1V1gdIYoBOTjqZej8R1gamZijMGXIyZ3yGb9quaE?=
 =?us-ascii?Q?l2JhwZg56tb2REeJ8v/CXHWs1cWkW0o/zkMzk238F0Gucidoboo6A+37oCtp?=
 =?us-ascii?Q?/VTL1GDgJUJUxHM0ZbVWGqcO9WDF3X5UzGmuNOHGCS46wEoCrBlphO8r7fGA?=
 =?us-ascii?Q?WBDzWmM4MY9xdW9S7koym8djInkNA+RtUxgXLMGfOu+8sCLM6fURbzKv37rs?=
 =?us-ascii?Q?N8i/iZAVEf95YQoh+d/gPfYf7jANaQroLAf0M+Y0x7RoKQFKUG9r50S4XeKg?=
 =?us-ascii?Q?+XgYRky/RfIAC1HNUfp8aH/uB8vneGnoRwn58XBlcKfBXvoYxK5S2vVM3pYq?=
 =?us-ascii?Q?TNeGLZyqGz7xyc6Z8M5T+XXJ0Wfwyu6uoPWoehzQ0RswGev9r9Y2AMtCQG85?=
 =?us-ascii?Q?S/b7cRqwzR3seY3Cf09znmwd1mhJtj7QOjWcnDNf2TdcgegRsCMmhJPBm/7M?=
 =?us-ascii?Q?nK0ZjQF+jH8mpUtr8octgDOdx4OR3xxSmA1LLcahAKUlgZ4sKz7/O9IpkCWm?=
 =?us-ascii?Q?+vrANumKYI7rhI61d1DQKrxvsgiPZksAtdVLZnWMWKva4ZkPdGXTmRizYkXr?=
 =?us-ascii?Q?lBn1hPI79HoTNu7XehsiPZDGij5lz6lA/TKs7yBTzbOHQcodf9A//Xr7Fh1H?=
 =?us-ascii?Q?EyqcQXOvyuMbgE/AyaI4B5t2El7UXlhEogbSunHXsO0a9SKA+5lKIFrIHq7Z?=
 =?us-ascii?Q?MLd7xm+wmbv+vPrcE4j8eYOxiIwfcMzwHW6DN19HTUAlUFJQrRdAzksYd3wH?=
 =?us-ascii?Q?SAWZcgwadyznHKw+BvD/IeDmcrMl3LvcKJ6Rjzmf8/aW9oS0IQx+tF9Wk027?=
 =?us-ascii?Q?f5hf9DZKC7tFgTT8vkosINjJ6RH9QmqJ/OzsYCIxv0rc+Ip9rYTC11tCoDV8?=
 =?us-ascii?Q?Q/wrVEtD1GIjLrTHwBO31S2JckwiTbW4OD7k2EZJqRRfvEtg7vGF8VXl4y7p?=
 =?us-ascii?Q?kpt6Mds0NapeDN002t3sl4EiUgcNofd6IVW1V1J+5zQaP8aA/GPz/DzTQEyu?=
 =?us-ascii?Q?gl8HA8ORLf0gWX9qmHQV1Q/oqponwfDtPptHBEvAhoi+fF6IbPgKV84cQoaU?=
 =?us-ascii?Q?TFGaOJFMZIyazvxRZJj3GKaI3YLt1X6OwDS8JKN3LbUJqoSgjrNSAL6QqVB6?=
 =?us-ascii?Q?u0RpgoWlVOM8I4q/xch25u1NpqvMopsrFUsaC6fMjUYdagpYxKQheEPvFpfE?=
 =?us-ascii?Q?7JWsh9fHh+McoJtFaeVRP8UYoCmdewzHz3kLBThJH7pQQRHEFauBamN2va47?=
 =?us-ascii?Q?GvVNzPf5/pCyPZDmi31c/wAP+rQZM8OnoxGiGANTigIMgfk7rYpkpfwbizk/?=
 =?us-ascii?Q?zNPCMPuLRHe+6s03a0tF6bxj42YB+HklhcL4TK3VUMNil4n4GLlG79vIsLmT?=
 =?us-ascii?Q?oyXJnv25Ieo8FXdTL3TYfFROXWKyAQySBBexxIgsa15xf1M0pC/a/c2WYeNT?=
 =?us-ascii?Q?ZeBGWJZUWKDMvptXk65HXB3J9on4xMNld+9b30W0O7syuYpmrBNqgTRwhAbD?=
 =?us-ascii?Q?F4TjuA0laMdtDz3J535BMOuVEKP5CDggHMexC4vu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd78097c-8c4a-4f85-37fb-08ddb9bd8a18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:09:47.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtlTCuEdcNb2/87IOHn8q2hCKRyf41epjShpwbhJs/IzcQTVBby9cSKPPrLq1RDDaAa3K/cUMr3EGLqr6tXSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8009

On Wed, Jul 02, 2025 at 05:38:41PM -0500, Bjorn Helgaas wrote:
> I see "aer" mentioned in layerscape DT 'interrupt-names':
>
>   $ git grep "interrupt-names.*aer" Documentation/devicetree/bindings/pci/ arch
>   Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml: interrupt-names = "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi: interrupt-names = "pme", "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
>   ...
>
> But I don't know whether or how these are connected to the AER driver
> (drivers/pci/pcie/aer.c).
>
> Does the AER driver actually work on these platforms?
>
> Is there some magic that connects the 'interrupt-names'/'interrupts'
> DT properties to the pcie_device.irq that aer_probe() requests and
> hooks up with the aer_irq() handler?
>
> The pcie_device.irq for AER was assigned by portdrv in this path:
>
>   pcie_portdrv_probe
>     pcie_port_device_register(pci_dev *dev)
>       int irqs[PCIE_PORT_DEVICE_MAXSERVICES]
>       pcie_init_service_irqs(dev, irqs, ...)
>         # try MSI/MSI-X first:
>         pcie_port_enable_irq_vec(dev, irqs, ...)
>           pci_alloc_irq_vectors(PCI_IRQ_MSIX | PCI_IRQ_MSI)
>           pcie_message_numbers(dev, mask, &pme, &aer, &dpc)
>           irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer)
>         # fall back to INTx if no MSI/MSI-X
>         pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
>       for (i = 0; ...; i++)
>         pcie_device_init(pdev, irqs[i])
>           pcie = kzalloc()            # struct pcie_device
>           pcie->irq = irq             # <-- pcie_device.irq
>
> but I only see attempts to use MSI/MSI-X/INTx, which we discover and
> configure based on the MSI or MSI-X Capability or the INTx pin
> advertised at PCI_INTERRUPT_PIN.
>
> I don't see anything related to DT or platform IRQs that I can connect
> with the DT 'interrupts' property.

There are several attempts to upstream customer Aer irq support in past years.

For example:
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1161848.html

some change port drivers.

If you think it is valuable to support customer AER IRQ support, I can restart
this work.

Frank

>
> Bjorn

