Return-Path: <linux-pci+bounces-6198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCE8A37AC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC431C20E3D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA721514F6;
	Fri, 12 Apr 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJCHYCpv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402511514EF;
	Fri, 12 Apr 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956130; cv=fail; b=BZBARIBjWDnYgVZOIpihgNlUTlGCi1r0HOiR9Fnl+xZ8p/eWwJgS5WVSZRoj4H/zw06VIQEXv5ErETciBVHQwwHjp3XtChJMc4amdkzj+lxIE92Bcid+RFBUpBBy3/MI+XnhOXxX6aWVAZ/sybgr61FW2De9TXPtxh9RGm/50XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956130; c=relaxed/simple;
	bh=GlZ5fmhIb53K91zNLegnAbi+hD9J5Krzvh4iUkpSjuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhUCJ+MmQRLWHLSHhSdL1owvDvmlakUSqvF+WepEQgR68BRY91UNZ41wIw0XCQGQWfJx9tqzdRrS1IT0JdJq5oHlfTNBY3ogiWaOb8IL83cPe36zLZRdJfEnsRd79pxG4h8mtY6ERMc+oV7C2lpaidOFZuHjZDfn63NNDGXx1Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MJCHYCpv; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgtR7Sz/GKW4XLYGPZLIKdEBdF2xWms3BM+17i6KlRlB2H3nkn7j2aobb+Zt19/I9Rp8VcDkfM22znZ0x/y/X5GG89CpMKHGbr6Tam7VX5wLwm06cm9pjsjDDXsEGkGA4l2pDdlptuGpjar8+o9BBm1OJIXZ6sStp8qVpJbc75fNeiVJq/Dq0bvPF8JDyXHOJb3XY3nzGR6C2FNLrsxWf6CTGtn11imRTxCsrrvCwIfmjLr0ZSdW2Ff47Jxiq5k6n0taPTJnIDDU2+vYWmsgqGCG+qIxyPsvfAEKesPSM77IucPhuh6GNCgMqRN0n45DiK+EUQIB7wYVbLf+Y4uh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sct3W+OQh6YHyoPlzce2KedkwkCmmQ6Qe7W0p3HaeOw=;
 b=WAu0ZDO7YfM5Zn++as+nEeg9DsflMtyl0Svh+ZFTXxWMTekggXZ4fipmiiscneZKWutj4iXsqLnuhLxM60GgqgzKldO6QmFVf8dT6jPzpRhvaMjXwq+7dlrn8eAfRFcBXjgYUnQHRMg7893v8TTNDEWHikiiPVMZV+JmuUKw4/bzOxZVCB0U8D8/cIcBLZyedmH/c74gBuvBCG1Not6dr+iZHPek9WgGzNWhWgLhwyxjY0RKneFznEyUfhwWIDUX5ERX1/NYH3ajyRYu2HZXPYr4yTem/F64jcGvdx6hh7X+LYjFMt4E69hV8/NpPg2/9ni944aUkOj2rphe6NpLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sct3W+OQh6YHyoPlzce2KedkwkCmmQ6Qe7W0p3HaeOw=;
 b=MJCHYCpvFAJ8WhJi8LVTTZUxaSe6liObbqtothFgkSb/IbgngceuyyvwGXnS8pl8Ue/Uk49/vwgObIq7IlcRTRbK4GrioxoAcmGXov3rt28atAck+VXbectuerqFSnewwhj6zE1BGoH1LoT3V1XXVmQj0z5o8O4TSAhRlokJXRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 21:08:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 21:08:43 +0000
Date: Fri, 12 Apr 2024 17:08:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <Zhmi0XEUFMIO9OLx@lizhi-Precision-Tower-5810>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
 <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
 <20240405062426.GB2953@thinkpad>
 <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>
 <20240406040131.GC2678@thinkpad>
 <ZhQJD7GjRpDwa6jI@lizhi-Precision-Tower-5810>
 <20240412170548.GB19020@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412170548.GB19020@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 809bdefb-e727-4eab-d4f1-08dc5b34bbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYvAv4qgMCsCUDxbKN0m0f1Y+nFKy/Yf8xRfrmgaxD24sJMN+sd6eqbledO0TKkMxzRY7QjbX4maty5iCk66o4CQsP+UKsk054ksdW9ueO3mYrkY8V2PJrCELA8VhPbkCuV7s/L9nGNgfnj0vy+TBmgclM0Lut52WtkHgG7SXXvS6LnxPO81ohi/a+ZF+0jQEZ/uWh1kVgaAbiKccTdH0/gCTWdKaI96wGzMcg5dqxMeyQVcfIGkqAwPeAhcaL4PUCW2SR58mD6s97uRzfWlq0qdZMiJkfDVVwg546PBbJfF4eLXFz+EhfceokoaD7SZKU3rjt17QLb4jQpEKQdWsHNOgDPVzxsn1YxMMAA6KaRua5RqTJL19Jn1i8wKwIxAzrDylCH4B3a1RWX/MHWZI19cNILtdYI3yaBh5IMfRAuXq+wedBKNZzWReOax9RQKpWZYalaBu5cjM0AFkEAmdAOyKAU4gzcx4WlLe+Rngc9CxNDXKqYvkl7KF6rDxZdpienb0lXezJzEoEIe/wyU4Z3hPyZcX4/xdTjGhd1yesd2kTR7AGOoNZ6cmOq1G5443Cqdy+owawKzwywzcMtKj4O5q26/BYROdZoTlNdAtxipBEkz/uw2TBeLLTEBCLEj0YCat3rHhlmFcvcq8y3/qBAWRq8fHwnuel/W7dWnvoe0bNKk0PrOTOV1dEyO2Z0+m/tEYh3+LWOukBNrmgvn8XDAgu5XJ4wW4YelvSEByYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGh3VExwQUpUWWxsVU1lQUpqZXcyODlPZUdNVzYwNWRqZ29HWFUxWEtQNkFR?=
 =?utf-8?B?QnRVWG1PZjdZLzZRa3dMVExMSXV2YmNSKy9YaFJwV0RGMFJ1NWNic2VDWENJ?=
 =?utf-8?B?RC9sb1RDMFRQc2I0dm5aUmFXbm8yOUVoTFpTbE9GSWs0Z2dXOW5zMjBqSnp1?=
 =?utf-8?B?bkdGZG9yK05VcERSOXdRZ3U5cDVkL1JuTk1MQnBhVzN4MGZwMy9CODRXYVJj?=
 =?utf-8?B?M2RWMlp5ejZtQ013Y01iSTludEVKVmI2QkNpOWlJQm1HdFlxU2xKYURRYnNh?=
 =?utf-8?B?M3pkS243NU5qMDk1Uks1TmRMNjJMdWRjdEJ0KzZOdkpyTDhMNS9zUkVCWW5X?=
 =?utf-8?B?RUo0ajliVVY1NmdvdUlwWUFQT0cxTW1NZDVOdDhlQ1pYcmNpRjJhVldBNUR4?=
 =?utf-8?B?emF1YXJwMVlzZHREVjBLOEdVOEE3TjRQbnhYV3BMV2k0SG40Y0FTZWZSRFVI?=
 =?utf-8?B?Y1JvQ1U5dVprTk4vRk9jVEVSc3NDTE9IMEZ2MDY4RzA5RnBjL0djRkNZbHkz?=
 =?utf-8?B?Y3pHenc1OTJscTB6dWZySVR3ZzJncGdPYmRGQncxWjA4RnNDbHBLREtJVUR2?=
 =?utf-8?B?UWpFcVRoSHFnTENkRHdLa05Cb3lqalBiVFVudk8rNTJXQjNhNTkweGU0UnZL?=
 =?utf-8?B?WnJva1h3UnVMUnpTUm9yMHd0V0c3YTBmRGpZTU1XOG16QjdMcnNoQldWclhU?=
 =?utf-8?B?c202bFk3QmFZUHVRbFNPMXNlak5zS0YwRWdRdmtvdVNrbFBLMXdtaCs2SlVN?=
 =?utf-8?B?R2R3S1hNQ0dXRC9idy8vUnRrcXJmOVVVem5LRkV0cStBV0h6VVR4V0hTS3Ar?=
 =?utf-8?B?dnNRbDd0UWpTUUx6Z2dMaS8yMjkxUktlQjBzRzlrazFob1B5TExESXpLVXVa?=
 =?utf-8?B?YWNWbzVxQzdGWXpCaTZ5eDBNQTNwbk9zKzRpWGhvSEVOV0dQOUtFN0RCbW8w?=
 =?utf-8?B?ZEVwVG02NFZ5WDVpcTN5ZDRKb3ZtRVBFS2JVR1hUL0FSRmx0RU1uVmxjOUZL?=
 =?utf-8?B?QW5qS3BOZlpLMVZJbVV1VGhBZTdxUmZka2RPUDVmdytSNGFzclhiRytSNyto?=
 =?utf-8?B?R3Z4dVBYZDBoeEVFVHlOMnU2TzlaQlhCaWlJUE8rMHFYQlAzVjc4SWwrc25n?=
 =?utf-8?B?SmVwdW1XZEczSnpuQnBlQTBJR3V0cFVvVGM3ajZrQ0x5aDByR0dzS2pRcUhS?=
 =?utf-8?B?SzdIM2FpWU5GdEhWTXNqOGhoOXNuU09UWUVVSEhvQ1Z1WUwxZ1FmanA3ZDV3?=
 =?utf-8?B?SUd6aGdaOFR6a0c5WjFzTWk4cDAwdytYMFhLdGxRZjJBa2VlNUR2L0NxaHhr?=
 =?utf-8?B?czhSdkVSclRnK2lGcU9sVFNSZVBmckU4U2JUcTNCSjZva1A1R2s2dzZ2dHhG?=
 =?utf-8?B?ZDVkRWM2VVIrYm52eWM4K1ZOTE81d1pIbGZoeXQ5cDZwZXg1K25MZXRtSjZ3?=
 =?utf-8?B?WlUrMk5uQytrRVBIUDNBYjUrTjJJYlF3SkpwbDYrZUswOTE1bEdhSGQ4Z1pU?=
 =?utf-8?B?QU12Ly9QYVZRUTBCYlJON2J3emtISnRJMEtEOExHeWRzbGZGTm9YRDR3Rno3?=
 =?utf-8?B?bzFoVE11bFdXZmoyVEtQd1JHUDQ5aStjcWN6TnFtdDNkZVBPbzFEdjRZUmJw?=
 =?utf-8?B?RXVtamtWWU5HRGxaZjlkWHhpRHM4UTdNemFhMjVOS2UrQTMycVVzRFlYTldW?=
 =?utf-8?B?dENVR01SMUVXSWVFL21pbEpGakcrOGxZMFZocGlrR2l1eThIQzA0U2Zadkhj?=
 =?utf-8?B?T0d6OHhPU3QwUFl6VngrTStQVzNqR1NDNmxubXdpRTBVcWdXRHB1NHk5Ykp3?=
 =?utf-8?B?OHUzV0JXZlJnbE9jcFpnSUF1eklja3MvK2p2R3AxeGFTZE5QV3psY1I3L2xv?=
 =?utf-8?B?b3BhR0puZmdsUWx1dzhQbFRzZzJkbzZWOGVWYklzU1lZVE9HWXQ0ZnJDYjV2?=
 =?utf-8?B?M3N5VEhQY29TcEZoYmdqRXpzTmJqM1h6eWNvSHZoSUh4QTNLOWlLMlc3S1U4?=
 =?utf-8?B?eitZeDJ4eWZ2WDJMS2lJWmc3YTVrZ2I2RTZuRDdUVnFnMDFLeUtjbWlYTFpx?=
 =?utf-8?B?dGFtYW9sN0RZZDlhRm91dXBSNUdpem1EczdhTmJyMElrakYvdFRCamZackwz?=
 =?utf-8?Q?4orPIh1MFLbd4jtGiap5/YYeP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809bdefb-e727-4eab-d4f1-08dc5b34bbfa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 21:08:43.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMIzFk8k2cGwOzLN9x+buH8UENPLj2TfNf/XZKS7ia0v40Jg1Fx9hMLd2aL5LqpyDq2eGL1akpPNEwBldVwNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690

On Fri, Apr 12, 2024 at 10:35:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 08, 2024 at 11:11:11AM -0400, Frank Li wrote:
> > On Sat, Apr 06, 2024 at 09:31:31AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Apr 05, 2024 at 10:31:16AM -0400, Frank Li wrote:
> > > > On Fri, Apr 05, 2024 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Mar 19, 2024 at 12:07:15PM -0400, Frank Li wrote:
> > > > > 
> > > > > PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off during system suspend
> > > > > 
> > > > > > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > > > > > window. This space's size is 'region_align'.
> > > > > > 
> > > > > > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > > > > > can trigger a PCI message, such as PME_Turn_Off.
> > > > > > 
> > > > > > Add common dwc_pme_turn_off() function.
> > > > > > 
> > > > > > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > > > > > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > > > > > exist.
> > > > > > 
> > > > > 
> > > > > How about:
> > > > > 
> > > > > "Instead of relying on the vendor specific implementations to send the
> > > > > PME_Turn_Off message, let's introduce a generic way of sending the message using
> > > > > the MSG TLP.
> > > > > 
> > > > > This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> > > > > at the end of the first IORESOURCE_MEM window of the host bridge. And then
> > > > > sending the PME_Turn_Off message during system suspend with the help of iATU.
> > > > > 
> > > > > It should be noted that this generic implementation is optional for the glue
> > > > > drivers and can be overridden by a custom 'pme_turn_off' callback."
> > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > > > > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 267687ab33cbc..d5723fce7a894 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  
> > > > > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > > > > +{
> > > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > +	struct resource_entry *win;
> > > > > > +	struct resource *res;
> > > > > > +
> > > > > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > > > > +	if (win) {
> > > > > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > > > > +		if (!res)
> > > > > > +			return;
> > > > > > +
> > > > > > +		/* Reserve last region_align block as message TLP space */
> > > > > > +		res->start = win->res->end - pci->region_align + 1;
> > > > > > +		res->end = win->res->end;
> > > > > 
> > > > > Don't you need to adjust the host bridge window size and end address?
> > > > 
> > > > Needn't. request_resource will reserve it from bridge window. Like malloc,
> > > > if you malloc to get a region of memory, which will never get by malloc
> > > > again utill you call free.
> > > > 
> > > 
> > > Hmm, will that modify the window->res->end address and size?
> > 
> > No. This windows already reported to pci system before this function. It is
> > not good to modify window-res-end. It just add child resource like below.
> > 
> > windows is root resource, which will create may child when call
> > request_resource.
> >           bridge -> windows
> > 		child1 -> msg
> > 		child2 -> pci ep1
> > 		child3 -> pci_ep2.
> > 		...
> > 
> > Although you see whole bridge window, 'msg' already used and put under root
> > resource,  new pci devices will never use 'msg' resource. 
> > 
> > If change windows->res->end here, I worry about it may broken resource
> > tree.
> > 
> 
> Hmm, I think your argument is fair. I was worrying that if someone try to
> map separately by referencing win->res->end, then they will see access
> violation.

It should be wrong if use it without request resource.

> 
> But why can't you just allocate the resource using 'alloc_resource()' API
> instead of always allocating at the end?

Alloc will start from windows (for example: 0x8000_0000). 
0x8000_0000 -> 0x8001_0000 will be allocated to 'msg'.

If ep1 want to get 1MB windows, 0x8010_0000 will return. There is a big
hole between 0x8001_0000 to 0x8010_0000.

I just want to reduce impact to existed system. So PCIe memory layout will
be kept the same w/o this patch.

There are not big difference between allocate resource and reserve resource
for 'msg'. Just little better friendly for exist system.

Frank

> 
> - Mani
> 
> > > 
> > > > > 
> > > > > > +		res->name = "msg";
> > > > > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > > > > +
> > > > > 
> > > > > Shouldn't this resource be added back to the host bridge?
> > > > 
> > > > No, this resource will reserver for msg only for whole bridge life cycle.
> > > > Genenally alloc resource only happen at PCI devices probe. All pci space
> > > > will be fixed after system probe.
> > > > 
> > > 
> > > I don't think so. This resource still belongs to the host bridge, so we should
> > > add it back.
> > 
> > When add back?  It was reserved at bridge probe. When bridge remove, all
> > resource will released. 
> > 
> > > 
> > > - Mani
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

