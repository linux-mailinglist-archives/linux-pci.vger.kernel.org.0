Return-Path: <linux-pci+bounces-17973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D59EA297
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 00:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7260F282288
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10B1F63EB;
	Mon,  9 Dec 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcSY48Rz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3D1A3A8A;
	Mon,  9 Dec 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786363; cv=fail; b=Gv6gO/sHZlBTsR5dVfTWdCnDt3oKB2E8ct4YAd6UjVek6DdKUmucqfoTSqXqvNQeB/fFlu/M5PuRtk12p2UlXN1Ee2PpSG/SYQf93Am7ORjJTAUU9WGtAYPmhvgwPxWlGpgytFvakAbeeAJkqfZzM8Mjpzi5K+4mV17Ky4t2pBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786363; c=relaxed/simple;
	bh=kEr9GS+TiJ5eg4UQaO+dAvL26iVg2BpNn16mieG4dgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OogFcEZrMGMxYS9J2LX9TwaDfH+rHxkqaQTdnyv/D1w8dGi47SFAtsgiHh7b7sWhcgpKlJaqQmxtWPAmPA/P034Uzqh0ZH1Xib6CxYbMliwdKgvlzf30WCBulGw5HH2Cgb3iqQ/dJFzO30bkfYxvo9bmg8DbYWqcEpNXjM4aW3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OcSY48Rz; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w972ZR8PWuRLFggXcsuelGlUjNNiYw0rH0ibBiiGPDxZR+Q8hVmPA2EkT3f6UDk1vI5FCV+WBof8x7XD6QJmNknwNgWtXsRwidimIj/uwhZDqsAkjl8LAnDmSeN/SGY82uxiq9FXYipMHKDZy1vKXiK2YycrPPvrVSdPVe6rPk33jXM1zHCbQMnNomdZK940ISUf6z0LlI+j5zwWVtgoq8TwO448Ol8xHyGXbLqgl9YlPlPh9XkwICxOMMjchwJuNY4IeqzCQyQbz3mJefuskBMOrTPOLgvQc6pOU+sdQagJaHe341TkjLX5lATMarYLgsbocQFXmt/KRhBRNVewHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEbAHb4BD9Blu3WE1YEKJoaQV69sHshNmgXKVpuA1Qg=;
 b=pvhaT41nU8DLKiV8utrjpvMKsqlst/CHZzWa1Xw7Yt2v3cqCCe+JzaAiEuXp/3C1jOiuCVJbSK2rtCEQm+6jGPhhjS35fLUisZC0zdEXLR24CoVFL+WEyCyuIgsGpUCbUwLFvqZlZ2og3u6M3wssHXoDCuERmcHwU+2e1Qe0CUozwI+5gfirRvu+PaKBoJfhwtRS1sskVCTNQ4qs27WahiBmtzl1UycvTLTOP9ro/cjfSx/uESgOMsuMUAz084pSylHdZtyUJSjJaUfvZF0d+Y7M+0VQj7e3TLaf/asrrG3xPd6oUACBANEYm5RFjNaA1awbQRimC3/Uxu3WVHZp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEbAHb4BD9Blu3WE1YEKJoaQV69sHshNmgXKVpuA1Qg=;
 b=OcSY48Rzi3VIiS0wlUxQV/vIegGQpouqD0D8GiwsAsKRZwJ1KBzhDADGaedZP7ZCF4bLR8a2YvfhbQohpXHCZ51GkhdRTEoxzN7GxWDH2+/s9sLwQ+TW5s6uKnAwuYpUPpUbC/Xnlk5rr6/+Re+WUH9jezp5OrK21Ph2ujDZRN26qZsLFh7NeOucnFIPoA1b8H9pPVqqc3jDLPiKhH1y+1z5vsOIfAfyBk9QjWZiXI+Qvh3m6RvUK+8Zxs/MwV9wbgi/tcwvWGonSMKujw1t1pcS0CXTzgWQwxR6bOhdiprvoIcAxLeCs4KwziRNebL9HmYrLtDHAroykdkHezqIRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:19:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 23:19:17 +0000
Date: Mon, 9 Dec 2024 18:19:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Message-ID: <Z1d67E7y2MOZ5tTi@lizhi-Precision-Tower-5810>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
 <20241209-ep-msi-v11-3-7434fa8397bd@nxp.com>
 <87h67cprc7.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h67cprc7.ffs@tglx>
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce2edd1-35dd-4d9e-0807-08dd18a7e712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A3bqKCmdZsxYdvtjSMhJE/6PyoXKIoCshNcm1LmlpzdQn4ggN9tg1Kq5RVK5?=
 =?us-ascii?Q?DRWYZSsDORBYUjqsQ64g89uiOGamoAmu+5rq+RQjq3ctnpjbZgvopTaDa389?=
 =?us-ascii?Q?zMIQBj1f5gLP8H4ajPh6q12h2WYFx/R3fBUNeVBSS0nkAcoU0Amn/lvCeUIJ?=
 =?us-ascii?Q?V/gutIxsxs16sM2dqcLzWhrQ5M1SHfcIZ70mZT25MdUOMxw75aYv1ADJqtIo?=
 =?us-ascii?Q?Z2Xu9L4uQfOZo4AEy7TmTdAoTfFmDHDzMlQB0bd5NHFf7QJIolfie8GSA1ad?=
 =?us-ascii?Q?3ZoCrNoZzQXbfxLZwn54y7V5pdbMIdmInu67Hh0Nh0fM0VljNvPUtzVfqmC9?=
 =?us-ascii?Q?L9LUQ7WOuZvFPmX4F9RvaH2rjm9Jgw3JQlfX6jAINPM+kEn8bDH//KBYXu4s?=
 =?us-ascii?Q?26kmtMAvRlS1o8ZQshmY8TFdUMKIlyAc4RVSrnmpQ4ThNPOVuFd7TNAN1A9Q?=
 =?us-ascii?Q?AFyD9t4m5yHPC0wWmUcMQeXX1baxgbeCLf4MZC/PSYzbavsVD0ZripCoqnzm?=
 =?us-ascii?Q?xPAIPAtnyaVGqgEUyhfR6B6mYQuYOqKr/YLLEtFeHeTk5vIufI8MkXGfKZy0?=
 =?us-ascii?Q?1cC9O2TO0C4WJgIujoxru0dhOgxHo43oSorVegltykt6B1leKn0M9eTMt43X?=
 =?us-ascii?Q?mZAMsv/Q7J4E/2eviDgEf6EDDN4QfQiTch373LJzakhmaHQu1NxOc7GQ9snb?=
 =?us-ascii?Q?xs/WqYtN7IJrRuLRSaSl7inU3wkPo2HmS25lGHgby7PcOBq0Ji0B0/3aMK2M?=
 =?us-ascii?Q?g0ktTkyZWP385VE8+GlQiEtGj+9XrdoIfYybDlwHOigs7yzfm4hRFKDO4QHq?=
 =?us-ascii?Q?G5V5HI7exn5sxmcX4j6DhrR7v5OVUBz3zUyvHrxk9lGPr7ROGYC8NgE90Byg?=
 =?us-ascii?Q?Rgj56v2ShIWXfId/OYBHz3oui/boyP065hkRLZREhAAppQ4VAhnul/HKjMsX?=
 =?us-ascii?Q?tWtrxPhkv5QYLrkB23aUPlDGpUwVj20D9bpdTFd+NyAMj2gH4Ix6IDlw72WY?=
 =?us-ascii?Q?2oi3xgIVZgHsfDxabMhMIbyqvYxVQUeRepBfb67HAqgwBuZUsqbBu+wTxrbh?=
 =?us-ascii?Q?EmldM2LvobSkYPlAtkpdaD+AADpvvR3FWhKbgZJd9XdKG/uHfBybqBbGX4e6?=
 =?us-ascii?Q?LDkOob9WGfIOn8HdqzDO/dcy4WBmq9cO5oBIv5Guji1Tjag1dMhqv/IXip6f?=
 =?us-ascii?Q?32lYo4m9r7Unrp727P7nKQPiQwyipzBDjU1netlA1QcwqNILgjWVFGgp++j+?=
 =?us-ascii?Q?K2zsNSfrk4VFmKZ7uGaCjWefzNGrskKQitlR82lsZ0Dwb3x0qqHAnDMnW3RW?=
 =?us-ascii?Q?TT3OAnlUj6L+YO/KdpuSOdJXH3DeoLwNSiaWwlpfr2wkqHb+4rsWVeX/st0c?=
 =?us-ascii?Q?Wl6oMo6XN7axYRP3T3Wbcphfcr0oc9pD0D/7CJ5wxvOpB7OcCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bKOAeBl+n9bhdsgyUoDcnP/IB/FWg9hUxH8q6eTtomscHH04NCbERvsWeQoD?=
 =?us-ascii?Q?QLwJJQKWwY4IXUlplACOCN/LMu/463HzzF3D/dzXw1ddbPEmyTatxL8vZRSK?=
 =?us-ascii?Q?5z5r7uKCYyT4adgjZSxR3W2s+snlvRdD7kDzrSgWoIJAmhUdoOFKzeilQ5sr?=
 =?us-ascii?Q?Bft84PiXVOmCFb/3t6cH/s7Ymosi60O8APowqGfH1eOQP9whS4T8kabpLWJx?=
 =?us-ascii?Q?OhC5HD6tIm2CJgodm4qrETra85M7CgL0CLV0OX1LHQIGG3GM29a0VYsASPmh?=
 =?us-ascii?Q?DfN4OMzmEyNsvelRnStA/MIn/yXMHos7y2djlp+RtG7tbnuQDOJhwGaxTddw?=
 =?us-ascii?Q?UP+JciP8FGSBoTfPjSR9eVemd5Xv26mAS+Q9VdJkni285l/aIqQyv2LL9n3Z?=
 =?us-ascii?Q?BDhbQxe0K7ylYtQNQvB5+c24Pkvfb9jLk7g5wpkZqZMXbwg1qaBPn/gHu5fU?=
 =?us-ascii?Q?vKIZ+VDPFoDkhFO5dnBk0NkoZ+/6CvboatX+U7RmvktoEunQrDHFhfA4Glxd?=
 =?us-ascii?Q?TammLC9mn52dNhq+8dBbMK2DsjBl4p5u+FxbSP9ZZVnxLluMhlZPp7tAZ3dr?=
 =?us-ascii?Q?nJiQpYooEuGsnzMm3ZrIUyrRsqCOISyQAnwt1EgrWzJ7vNsmFXJ1tNsJpwZm?=
 =?us-ascii?Q?8ayoa6VXMvbUsziHUkolZPC95wMs39Es13mIJKwu6PMbm27fzGGgBvycRWee?=
 =?us-ascii?Q?vBzp+wpvGsxgRrHMFqwLyPpTbxlniMAhbfO/lmZ1iczFGg1heNC7dL0bNlC0?=
 =?us-ascii?Q?YXd/rVbGwCvdLOWUNx4saFT6oXG1RrgaIx7c0TI5zS+CHA24c85ZDjqt0IoO?=
 =?us-ascii?Q?DhYM4zJKYJp4WygDgWwopF8lFdbqWNP5/ffewR4sXUQfJXpP3Lh0XuzaScCQ?=
 =?us-ascii?Q?USzlpsKy7tNJTG38W/HvuFBGeWaheP4El3eTkmspYnJl0XAenn6zPDxGgIQ1?=
 =?us-ascii?Q?oQGovX9WZbr0k5EEz2UFLX+ZYF47wfkUAhd31HIUzsB93aQAA+k5iF4Qae1Z?=
 =?us-ascii?Q?gYt+A7dKoFc2EErDx2fjbmS+nI/ilZd348DRk5Q39nMGgHDG6XMrHbYrgbH2?=
 =?us-ascii?Q?LLWsksSEC+Z20bxYJ9tn/P1vgokzkJS7iZ8Q6aeQk1nzxo9G7pEmPudZMLmu?=
 =?us-ascii?Q?X/buJQOVSRkVEs4Dz6x6NI9YVKMZJ0/OnQ0z7oVVyweP0IpjiUFQyurS2k04?=
 =?us-ascii?Q?PyhMza6147tdFfZZZcvqjsKnEtD45eQPcZRBUOG74Q0Ato2+Iqu6o+sx9Tfo?=
 =?us-ascii?Q?m+Go4pNx8NoWhFbEnxmhuVsffW1ZVMcW4ypJT3Ke7eAqQjfE8D50VAHAaPxx?=
 =?us-ascii?Q?DoQ/WdkaAdPu5uTqXBonstNsch406tOm+g5Aixh0TAYaLSiXfXFpP4t9eQJX?=
 =?us-ascii?Q?ikcaoRBLqw6Ae3u8/S+YxOHbMyP36lbDE4ckesRa66OBeeFRReH+9StwUaif?=
 =?us-ascii?Q?lBGgsmO9ouqg7AvJb+53sl64oK3B8tB+UW88lvd7Ud50rBSM/Vp4hBwqKCRq?=
 =?us-ascii?Q?4+/jjI8eEN0zrS4e2VXs4nUwbVQp5Cn8UddHa/BeFAjZQYQrx9zErGHZgdzY?=
 =?us-ascii?Q?rLSUw9nWlihpbpX00ss=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce2edd1-35dd-4d9e-0807-08dd18a7e712
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:19:17.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC8AYvzvk80nv4ybJvEzSHzShyUS5mZ07ehJwyRlsFiLllVLJp/zdevnTD5LN0X01fqqZMatQbE/sAgRGbnJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

On Mon, Dec 09, 2024 at 08:51:52PM +0100, Thomas Gleixner wrote:
> Frank!
>
> On Mon, Dec 09 2024 at 12:48, Frank Li wrote:
>
> > Some MSI controller change address/data pair when irq_set_affinity().
> > Current PCI endpoint can't support this type MSI controller. So add flag
> > MSI_FLAG_MSG_IMMUTABLE in include/linux/msi.h, set this flags in ARM GIC
> > ITS MSI controller and check it when allocate doorbell.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v9 to v11
> > - new patch
> > ---
> >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 1 +
> >  drivers/pci/endpoint/pci-ep-msi.c           | 8 ++++++++
> >  include/linux/msi.h                         | 2 ++
>
> This is not how it works and I explained that you to more than once in
> the past.
>
> The change to the interrupt code is standalone and has nothing to do
> with PCI endpoint. The latter is just a user of this.
>
> So this want's to be split into several patches:
>
>    1) add the new flag and a helper function which checks for the flag.

msi.h have not included irqdomain.h. It needs a API in msi.c

+bool msi_domain_is_immutable(struct irq_domain *domain)
+{
+        if (!irq_domain_is_msi_parent(domain))
+                return false;
+
+        return domain->msi_parent_ops->supported_flags & MSI_FLAG_MSG_IMMUTABLE;
+}
+EXPORT_SYMBOL_GPL(msi_domain_is_immutable);

Is it okay?

Frank

>
>    2) add the flag to GICv3 ITS with a proper explanation
>
>    3) Check for it in the PCI endpoint code
>
> >
> > +	if (!dom->msi_parent_ops)
> > +		return -EINVAL;
>
> irq_domain_is_msi_parent()
>
> > +	if (!(dom->msi_parent_ops->supported_flags & MSI_FLAG_MSG_IMMUTABLE)) {
>
> Want's a helper.
>
> Thanks,
>
>         tglx

