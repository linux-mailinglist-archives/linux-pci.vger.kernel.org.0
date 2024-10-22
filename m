Return-Path: <linux-pci+bounces-15016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666A9AB1D1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2682826A9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD719C547;
	Tue, 22 Oct 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MP7tDFF8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED434A18
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610315; cv=fail; b=J/Aq2AW88xmPGUDG4ZIQdvBjUDHl75SlQ13Vf8F9tF8Xd3RLU0zqqJiZWLthE+YO8yJZHMFnU0dPPMRVjJs2v9ihof4oabjEtvMRnwr8V5/8+EjUxQ14QVAol2HkZ4kxINMKFuhVQb/Dq9oltKMqropExy30eWmPgWtGjnSevOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610315; c=relaxed/simple;
	bh=+hj0iw3HlKJn0wdhsaLrek032lyutn5p49GNOohMKCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIy4rB4Dt4062lotKgn8YlTRU9T9V1bIo7p5kEF7eLkvqekCIjtwUGSsPLdxgqn7E46JQYbebGn8eeB9iNn6L6RTFeLgxK+wvmQ/LSTtDqlVA3BwdafZijLAkOGk2RfKy7ug6I7jWGgQeKc7h3Toqx0unzFZo+LgTJD3iJPVyRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MP7tDFF8; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q10kQXQnU19XSsCQmg0p1Cw85UeXUAEdD1ExzVvtPtGzANsnqxVHpFjI6Hm8hPPisVh5xdh2hEis2Tsw1VdfRZc81RIYpAiPsBqHm1hTC/GldLz2bBYEbWtgI6YUmJeE6uo4P/KyiIkg63sLFq0pESpDZCB7dKWwqIXbOkLeaZq9DM4mM1IB7YlZkg2QKC72MOX2+8mA5/ir9pLXlgTcE8sBM09fvJ1R9bEmwtLaRygkjHQ+aIKJyXA9qgh05ywttKYUma0xO3+rDbSzdgJMHmp7q1sc8Qmwi5hCgoD0I6m5rkHdB4GwGUEGH/IHYGCfrspW1ePmjfiJBcrxZvnCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM2W7vetnDkHCSR1aFwsQuxCWj/foUiF1+J5vUOQUcg=;
 b=t87YjPZr7+VRTD9F/KG33rRkm2FkkjHhKNHXTAbPm728CtN+Q51NhKw5Ld9m3h2PJYr0U9Uj+30MexXWCsZwg7w6spXTJg6vgKTg6jhnxmHXz4poL1DJG1i1oI6qN5M/VVkahRG1pRTZ7un8S3XXhpmGiJQ2zUkHKwNB6GpGtEKI3xcK3lVBJWZoE+bStFVTissJUhnqcqUa1EDwryk69y+aPpRkwdfHR35iHNOZHNqyWB+v55QNSMi80nKft8Li2itEoGgjwnyu2WSx4cXTkA/uRL32oTL96YJmSKwMHyUxlF8vRXnCl3TY0X3aBN2GQspYsk0h2nQSyg8TXIgX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM2W7vetnDkHCSR1aFwsQuxCWj/foUiF1+J5vUOQUcg=;
 b=MP7tDFF8542Ue4YwsxnMpIcMzuxLrsVHz7RFxGNv7hZy7eqIKC6/s3aT6B9jOn73UK5+0AbyhDWb3H9j3VqaNJrWGksHC88V1yWUJJx0wstQGao+6y4jPM15G2h33xbKGWUuilAjgxgX0F2sandv8n2LQdrJhgboZDxZba2NejmRYhMgZ9QSe2AalxbwRAnDbS/NOf3xxJYiy/kPMX/T/UzuErxvIpKea2wSCqZBfQoTSxGspveLDbOf0CFaFYIFW7oE34sdUU+mTOUVrVTTvWUCcrQIRM5XmBFsa3JaxPcQO2DoRv9e866Ftxy0Fw6f/kYFlIO1Ff3QRZt9q8APcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 22 Oct
 2024 15:18:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 15:18:30 +0000
Date: Tue, 22 Oct 2024 11:18:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <ZxfCPK66/CGWUIG+@lizhi-Precision-Tower-5810>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
 <20241022135631.a6ux4jzb47v7jvqr@thinkpad>
 <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: dd53c230-5bdd-48b9-8fd6-08dcf2acc8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IysGi/ToobAmSJY1LnVJ0VKgW73fBqlKW/5tVXoqysafJ1oTXYCV/mmdKE5W?=
 =?us-ascii?Q?KO30ZdQT7ECMpNO4mCGokQjanczOsO2lV8XmLMFQQBDKeDDEdXmeuc/5aOkN?=
 =?us-ascii?Q?gzTxsiyOrnPsf7TuCmuD+xq4f/JIBmRDHb9EXwmRBbOq5kc59zcY/4WhFp5V?=
 =?us-ascii?Q?nuoxuvAx3Dt232Xvgz+ggXCjHzbRRN5cNaPy28CNFWeumoeQ/vxZ57VlqOnL?=
 =?us-ascii?Q?siJ0y7DM/2dO86QdcloUXjfrEFazDkQrnWHYqqoMoJSE7DcQqI9I2qXhsHVC?=
 =?us-ascii?Q?TsCsB4HbN37ckxvVuVO9fPFksOmA267gTCJtBy/NB1V/QI1o+8v0Z01+31g6?=
 =?us-ascii?Q?8CY0AEcyBLnspm/gO/2EcKpemIWhbdNPl4gUnoKM7FBuPqIC5bpYhLzrSqgS?=
 =?us-ascii?Q?dmPPCddvI3gJK7zAc1yPkGMV3VvMKgmfPlUSMyQtdZ5FMUFyfhIzF1hilySO?=
 =?us-ascii?Q?X6j9Ye7KoAhZ4DTod/faJLijoRzdvkzlQmSL9s2RYngsW7vwcBUU/C0RoPrA?=
 =?us-ascii?Q?3FIvF+ucYmHv5ZGMK4mZOtkzh+4zb8qwurGRvMXkYVPYSOF1EqgcDaI4QOZB?=
 =?us-ascii?Q?S7pjYKztUtr64HS9/wV/3J45jyHiSyYK0te2LeFeufTMbXtoUsIw8KBTvcXP?=
 =?us-ascii?Q?38x/nGvZATFsWEsljfalg/20pi2cs/z+vZBB4eSH0eVJtcNL/F+/XVPmaUr0?=
 =?us-ascii?Q?OiTuCqPULtPAoyuVHAA/UMLYOElb7fjW2h0PQhAZ11piJzyNvNSvp6L4sO/U?=
 =?us-ascii?Q?Q6gZUvY0mNU3hrRySY6lUrj8ssVR7W0+IYu816LYshXEcv5IAKw0Bh9IXTq2?=
 =?us-ascii?Q?p76z6uHmXjf7rImbCm4+IGGsyPNSazrNUnawVXK265uv7ZAH4xMSMg0k7ohf?=
 =?us-ascii?Q?2JTh1jJJQxNBWKubGokFzIf20RGyaBhM8YifrTgFySM9RGowHfMc2CTfwM8w?=
 =?us-ascii?Q?6oO7wkHXpuXAUjnszQR2jg0g0GdGv8R/4779fnA3kEGkTmlzidH1lUBUsv0/?=
 =?us-ascii?Q?SSHQtCZEO/wPSOw3W0DQWTbkDdAYsYGjnMvJoa05JkCiqS7ZMUKDzSDYJrZ6?=
 =?us-ascii?Q?WuQ3B9O479ltGtMX4FLPyZPig2VyrcNnTc5lom4ehg+tjNrBOXIFdeyWbVNl?=
 =?us-ascii?Q?3tCaC0yc8xwXyaTJPuakZUhfAUSM2Dgu2soDK4LUl0Enu02OS/ynZl5HDZjW?=
 =?us-ascii?Q?8os1s+jFQS/PUaccDXaiXin3fr6GnJtCYt18J0739qgy8Ak7vpc9xBwODjo3?=
 =?us-ascii?Q?Jn5xKvAi35++j7ujL2uGpr/sOrQRgNpu7GmNZI3MN1MkllFt9zZDuERroV7S?=
 =?us-ascii?Q?Na4TgnOH1Yertq7KDneyxg0i3g6RBc13XXIro+atfBR/4P3JrjeyZTZ6WVPv?=
 =?us-ascii?Q?nLnu6m8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B12a3sifM2DBLqE7N3qcq8CkLYa+KfPBdQViSze0ELKHbDMxq6HKGQEeWHRR?=
 =?us-ascii?Q?Sg72wEatJEiCLSSD246JLowObC/jSUl+q/QYg/VeGj74KUbFz6h0KBSx7B7X?=
 =?us-ascii?Q?YuapC2Al9Rw7JqcgghGXco2W7QKdg/pEy0xUlZxqwJvXZaUF5/grnoIrOYIi?=
 =?us-ascii?Q?aae/65bQ5/f96cDirST4Qx2ZuXpxn2ZchdcNo3oFgpY1PXms096/bNA0b+6/?=
 =?us-ascii?Q?pxBPWcjQRPZeGwtoR9Twp6AkUPXnfdB8sTPOtix1xIR4ETlkDXMowusv+KyJ?=
 =?us-ascii?Q?h6cjHBIdmXdTlpuJFVjI5t7E258WiQiSSp06ZhGEl6N4gbrcZENHAiiD9cRu?=
 =?us-ascii?Q?0C7p2WHKxWZ/IuRy3c3jMRhUQeIhEAc4JrRCv/WG3N6JN4MsDQH9yuZBgasY?=
 =?us-ascii?Q?XNe+bmfMML1R5KTj5ZAb9v9lvyN8+gN5l9aO2QgAybH3cpXFd0BJDzB8EJza?=
 =?us-ascii?Q?+msRbPjZdgqg+A0p63oAHWpsHaqdWts5L/JrmYs87/nyy/mOkw7LFQ+N45UW?=
 =?us-ascii?Q?+QPqRlr/O2SMRnIu1lclNnlP3NRUlAN32ickYQSmCV7q5RrxZ7R1TVP9A9jj?=
 =?us-ascii?Q?V2V1SCKXimmdlgB0nNwQwN9zHhAfxV+Fgso8v+hqXwosxbCiFEhL1CHN5LxJ?=
 =?us-ascii?Q?7VwLJj/8NfoJmWJmEYouPou0Ou8gd21f3MclaxtX93uyoCvsxii6iHH14Mau?=
 =?us-ascii?Q?2M9YYVcxR//UD92pe37Yyhc80AjzearHZr/lev3uHU6R8+VLbDxmq6RVEBwP?=
 =?us-ascii?Q?PQLHP+TkjvznGhvLdabQE4Am6Cbvd5zfJGSdSOigyH/vfJw2XUddpC94nVVw?=
 =?us-ascii?Q?Qs5knx+3xSLi9J+oZODvFCxdr0ppNZey7fNHg7BnQnXf37spojYYNltcew0+?=
 =?us-ascii?Q?ILH5Q//H+UCO3dJ/ZB9t9yiCcwPvhRD0Zm18pybRznKGE8GcHs+VT/N+ps+X?=
 =?us-ascii?Q?7yiQ4LVnNFo4eMTaj+jwZREJZf5if3JuUIr050ljblnUOwMG8H6Dh17++2KT?=
 =?us-ascii?Q?eB6kB1o5OFWWY42XKBw9AnuGA6so1Jq+d3jVlyBb+XdzVIB0MG3TIy1RSUhs?=
 =?us-ascii?Q?6RzT13pOX7UV21dhO3xzxmy3UEPWgwG+9BH0TwzYM4H1ItlvztpgklI7JSNU?=
 =?us-ascii?Q?XAFjzEUChSTDBtVDMRaAtT81c/690puQOexfEvyv35eFbvgLr4wlEFbxZ5RM?=
 =?us-ascii?Q?RGDSEnRBnm1kMF9Pb7Ahj2LGZ/kYLu3cbBmh5ppCmkgq19fCfrr2kRy41uQC?=
 =?us-ascii?Q?zbDtghn9VWZUb1ups6yV/0TEMJWOdiLOEuz/QZtjPdI+T7eBsU40D4vVf1b6?=
 =?us-ascii?Q?2m2AbMYfcLrCzWe4kSTKRPo5Cn3kAX5f+KXTI/H9V8/hGWQBxFaTmywHbGwH?=
 =?us-ascii?Q?9Bn0GMJqkX0B0Ck5cWxtEU0Jz4W4rNBVKPateZKSaCBtb/u7G0+Cx1+3cvhr?=
 =?us-ascii?Q?j+592nX1Ly6L3EtdG8HA+c0nSWJneyqkjFtByKQI9+kAkzBH8RdyOeofOdGs?=
 =?us-ascii?Q?O85301gUEaYTJd2spnCfpxqInSMNcAnUIP4FmrEeST6QlPVsaIbijXsD8xYK?=
 =?us-ascii?Q?3HOnkPfNubgDssXkk0IIbzAl8prQjk2xDQOguen8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd53c230-5bdd-48b9-8fd6-08dcf2acc8f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:18:30.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+qHbmWAFn4dJr/oxs94ADtSyH4MDiHeKiTeVYuEQ1sOuim+sfC+41QO8XyUNwPW+vwvO7Oey9KhTaMYxHZ3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617

On Tue, Oct 22, 2024 at 04:16:24PM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 07:26:31PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 22, 2024 at 10:38:58AM +0200, Niklas Cassel wrote:
> > > On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> > > > On 10/22/24 07:19, Bjorn Helgaas wrote:
> > > > > On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> >
> > > However, if you think about a generic DMA controller, e.g. an ARM primecell
> > > pl330, I don't see how it that DMA controller will be able to perform
> > > transfers correctly if there is not an iATU mapping for the region that it
> > > is reading/writing to.
> > >
> >
> > I don't think the generic DMA controller can be used to read/write to remote
> > memory. It needs to be integrated with the PCIe IP so that it can issue PCIe
> > transactions.
>
> I'm not an expert, so I might of course be misunderstanding how things work.
>
> When the CPU performs an AXI read/write to a MMIO address within the PCIe
> controller (specifically the PCIe controller's outbound memory window),
> the PCIe controller translates that incoming read/write to a read/write on the
> PCIe bus.
>
> (The PCI address of the generated PCIe transaction will depend on how the iATU
> has been configured, which determines how reads/writes to the PCIe controller's
> outbound memory window should be translated to PCIe addresses.)
>
> If that is how it works when the CPU does the AXI read/write, why wouldn't
> things work the same if it is an generic DMA controller performing the AXI
> read/write to the MMIO address targeting the PCIe controller's outbound memory
> window?

generic DMA controller can preforming memory to memory (PCI map windows) to
do data transfer. But MMIO need map by iATU of pci controller.

for example: copy 0x4000_0000 to PCI host's 0xA_0000_0000

EP memory (0x4000_0000), -> DMA -> PCI map windows (iATU) (0x8000_0000)  ->
PCI bus (0xA_0000_0000-> Host memory (0xA_0000_0000).

But embedded DMA can bypass iATU. Directy send out TLP.

EP memory (0x4000_0000) -> PCI controller DMA -> PCI BUS (0xA_0000_0000)
-> Host memmory (0xA_0000_0000)

anthor words, eDMA can copy data to any place of PCI host memory.
generally DMA only copy data to EP PCI map window.

Frank


>
>
> Kind regards,
> Niklas

