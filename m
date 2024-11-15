Return-Path: <linux-pci+bounces-16905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045019CF1F8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EA81F21CFA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AC1D5165;
	Fri, 15 Nov 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ekf0NRnx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F31D79B6;
	Fri, 15 Nov 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689017; cv=fail; b=m/aCRHnjNsbwAPI9rJvYL0GrmeFil0xC2AqyPsBoeTMDF7jR3erzpd1fx6e1lweV8IDNai8iwSopafVgdrhwSNa7Oe1XoLxfkMDlpilhbo6HpfQm8INcD76pdPd5RW+uh3auvRS+fqDfpRQ6HydMhTZpbWslyttWifdWg6Ya4t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689017; c=relaxed/simple;
	bh=F++goONjy4NViG0oxUFINinqH4g43UKsAH0DsHhEoao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jgYdRepVzjz5MNbn8YnxcT6ARdohNQ/hjdYoQHhanhgceO710Z5JEtap+10G3mAnOcZ5OQI4nSaE40TnkgqB+1eP2ESOakno7144cr6t02sbmaJ1NQklvQDvnkkqZZxRKsjg3727FXeRHoDt8Vue9uBkh68H+FfgODv0Qc4pelU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ekf0NRnx; arc=fail smtp.client-ip=40.107.247.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aumRkjGRlUnUL2SCwEojPLmbUgp39Z166qBextI3B4Nrfvy4ezo6E513jHTxii7WTly5YR12S46dgf73RXpc1YO3zoFq891OOwztQc5p9o0ZyPJMglnP5auxhYSPGN6ioyDELuMq8yYAvtQRjEaPZYV13vsMB3CI8UnPFh/KdKDcrp7jePcmylQEzRUlmsoHLqojn+45T9XoHqk9r8Ji+QNggkglQoIyRdCJaXCyBdB1PH/s/SuglSt6dSc9Q16u5uBxz9tarjs4lfGIjagOBwiuDSajRpSvohwxHQ4FxyPquR8VmWmPiLtQqD6zvBZdhCPPlqf9JjnijESkA8G3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u10Oeo9qCfNweg88P4S2oBZf5GChn1ilQZoVWilvMA=;
 b=Z+LQn4VE/90uppOSTTJghDuxsR1gd8P8AAmAjfIkG/pElK3zNtcBhc1zG5iuE7funEyj/pvfW5Ynt2IsWHyjirzrifsQ8qhIyCpjbhngiEDLJFqyw+NU9hjYs1hft+WurzoYQ542Bbbv5qTORTFNCpSRGy5Md/T6aYb6Ke1oJkmnc5lQdnhm24LT3V9OuduJmxT7vyA2NOwf9eNLXECuOeB+mxfHUZdYeahnnRMnF5SwOY8WuUIRhgP9cbnYxL68P73kErLAM5v6NG/t4hXsYJ2CoJdsHARoySpMrTPHuYT7NSPCYsz5BzorTL1qOpcQm3Z+bopn+i0lSP0pj3MJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u10Oeo9qCfNweg88P4S2oBZf5GChn1ilQZoVWilvMA=;
 b=Ekf0NRnxhcGoT1FV4pc5WohKQJN6x+ktBEW4IXXm66Z/3iCLRzQ5B+dCMkpMD2yAxOzLb+TP2071t/3GN8SwsXEWZstxL4gy+P3KGjhhjSqgdDoM0tKaF7hjHDTkYMqXxDeF2N9z5lwKYGGF/xj87kZXBMoadh/IVkRAYREWrC65TqI7mIsyo0f7q03RN8E7RUhijEfxmqEG07R7m1GPrFd2UjqtQtBT6LHTFQ4hgHSPtJ7KYXKBt7dkHNgCxOo+4Xef9DrR3NEWwYkWPb4nQkvvAbAQHX4oRYv00wkk2dr75pDS/vc7HeH9pc1j8fNzyC9O4AVDsgKT7AVtz2QVHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 16:43:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:43:29 +0000
Date: Fri, 15 Nov 2024 11:43:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v7 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <Zzd6Kp1mliKGW2m0@lizhi-Precision-Tower-5810>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
 <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>
 <ZzcaA4PMHRcsEaDt@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzcaA4PMHRcsEaDt@ryzen>
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3bba28-ca15-4fe3-3d86-08dd0594a261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VM4nmSHhmkgRn5DhjMNnhv62/qxaCylAnu3BwEM2IlqV0gk7ZWWLrw7l8ULG?=
 =?us-ascii?Q?Iw1v3UA2Y58um8cqt6hV4Os3kxQxSds1pT/KUO3DziFpMXP+HzyNAlJMrgGa?=
 =?us-ascii?Q?lGVZAXjjOmVmZNgJN2uST62f0fgqU5LkyhtjyaiBvXWgLNNjPomDXSSFQStJ?=
 =?us-ascii?Q?RLzG9FzFX4t4oPq45KaaWfVlweveee0vQGsxEhcKycbzsHjWiGb2CTD9usUV?=
 =?us-ascii?Q?+8IYLPJC74On4uOC3thWGfq7n0UvjiBJu70Gsjv+taxz0F9JVMcIgb90Apb3?=
 =?us-ascii?Q?DwxcZXXP9m0ZcOXXKIKjF/Tyc/K8hqueAUipZ62f2FCDhB1//sD+egt4H2Cr?=
 =?us-ascii?Q?oQ8ZJSppNaf7IWYui+XuMLZINaIKgSv/5JV64uHZD31cZOxdfOJKnNGp+u6q?=
 =?us-ascii?Q?k+M3+ooWQOYB/jzNrVQVw0rwyYn8/5NYW2n92vqoMXIIrW0kWOKD6TH8jLlo?=
 =?us-ascii?Q?B9VsBzvM8A309O1Zj4o5bQOnyvYKHsTgTsQNN9FDmWm1i3pqNRP1LhF3UgIy?=
 =?us-ascii?Q?LQaiGaWv0/R29014gqCfdoLdstW8iSoZYDPB9sDqCE94+b0jDJy/eGuixAbB?=
 =?us-ascii?Q?yPW5th9TBDhfdKCGSrlIe0mvjEzmEWB+eJXN/eew/n0XG5V6xDX6lBpTjNbR?=
 =?us-ascii?Q?bU7vpSiP7V8R7XijF/Gze2N5Du9dKGv/eFG+G/Aqg4Ffny+rG89khsb4eyN4?=
 =?us-ascii?Q?VJJjlQYLFk2ddG/0g/gcwPlJOhXemJ07dDU3Zkvu2GT5G/WEBZyEKsYzJzIV?=
 =?us-ascii?Q?En8ub4/GKSTLE01qlNxm0SIiwyyo2iIJuG72Qsho9u9wvi6Tp5cmASrN0K6I?=
 =?us-ascii?Q?wugUe2ZHbHtwlTghFuaUidx9z6X1rGoJTZvV+6dsbX8oQ3Ry0bgqOYc26CGY?=
 =?us-ascii?Q?1DUxTUjxwROu7Y/EqrAsD0hjakI2mNZ2TUKK6PKYKzSrZt9CmiEiNzpX1qDW?=
 =?us-ascii?Q?aeG0NBRuVxt1qdbha2q/yr+ZCZEDrSo4CivNo67yFoSQYW5oqkXbOgZGzJOV?=
 =?us-ascii?Q?zPkZG7kpzUZ/S/rV86dYcjU/65jwq95NxOXZIuVeFACGLKPjlchvrEo0Il2z?=
 =?us-ascii?Q?r/+2hvJnXL2tNgorSa4mnUZj2XHqZAw/FkSe3iSWIoBeR0lyYfzv3m6OVc9l?=
 =?us-ascii?Q?jdo+vgFZMJCptN02M29KwnqoX5NPZrLUpOoLZ28KdTu5Op+Ru1Y5RLokEBV5?=
 =?us-ascii?Q?vHSq7SqJAZy9Xtw1Xz88C3Qigb1xdz7DOtxurpOSWKiTMGnCZOwpcV+JEwA6?=
 =?us-ascii?Q?cxXxSdFm2fpCh1OSZRih9e0h19oJ/bGmxwFA6XuA+GuD9gPX2r0HuJroNAI0?=
 =?us-ascii?Q?7ZBx1k4uTIXeNVTG2xdBNEDpPS2QlkEut9940qZpCpploSrGNIaTdZJ35R4P?=
 =?us-ascii?Q?h9a0DOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5Wl8FDOL9rGLFX1pjmPfPFxeaxZaIKGhjmda8/O7+tdlsw4DkrZ6ZVvzNen?=
 =?us-ascii?Q?XjBaow2EuTAiVPyEmCU4r59nm5eUfl+posWGPEJSjCfE4QSltfE8jL4eBMvr?=
 =?us-ascii?Q?CF4x34tO7yWz7DboMFwk9SvhHzmvBYPBFNpGmIzz54ESrI8cjfbuI4qA6NU8?=
 =?us-ascii?Q?l/yJNKh4ahXHSa8bAeD0lDITMtzHJB8UAiPzfELgwOBfuHiDTj1daXZlPmmL?=
 =?us-ascii?Q?6rC3olLBu0t3Upw8YGocoegxaz6/5dPQWtvCv9Yy1f/hhNM89aDj4EeNyOZY?=
 =?us-ascii?Q?9gYoCklLvEMIjFb5t+uU1AtdeJUOq6oFm+MMVtkvN+SApBVrddW3CE6j15s6?=
 =?us-ascii?Q?fKo/zt24yXZ1/OrbxiB+Nj5G47MtYWAwF6mhyTx9MkOkB9TLJmgiDYUMJV3p?=
 =?us-ascii?Q?DS7k2Vmw++e1CjOJnV5neRsiYV8r8kT67Il5fzlNS4SggJIfe31sxYI7JZmL?=
 =?us-ascii?Q?On2qH1ItxoRyitirsdqDBkMo59vDN1VmtsIzDDg2TWCE7u+d0XdHvSn9s1k/?=
 =?us-ascii?Q?J5WP7dvSDimWA0LHBWDflOLvYYCpzx5OFU0C1EyqNIuAzemaAxRX8DbKaGlz?=
 =?us-ascii?Q?S+hDJ2IME9AHTmJxWR/CFuIDelIrRsUJzR+W+KgR3RmAnZOA5UWMNka/o+Od?=
 =?us-ascii?Q?jBWTav/SoXR54t4Xtg5TC+4RNMkzUiJ18nC1cJ59VuIf2pcNLFjvlPyAjolJ?=
 =?us-ascii?Q?KKHX0UjOXdMLUdoV1kF8NiMmaHhyefTw+P3ivj5EyxL3wXoi/5AkUfkaB2mV?=
 =?us-ascii?Q?r+MvSPiHGzuWMx2qcpaqAj4oFkuhs/EIZdQ2Cp3oVKbCj/gDtUKXFCmM25DU?=
 =?us-ascii?Q?oPbhFfEQBXOxIkruSO2nBm1+LlF1fsYutSuPePHa29Vi9gDDrzcbLtH10+R0?=
 =?us-ascii?Q?kZBUECY/YapuI2KcUq5XvMnMNRMt5TgkH2+iSNp5JCuAgzr9F91FC4d6f2ry?=
 =?us-ascii?Q?O4oYqNGzEq7MvuWBORGUPS0B/PAZoPBzwGTDQfLO4WgZhMPLWru0v3C9AZxf?=
 =?us-ascii?Q?HpNTavL0G/2zfl9qycUF6TEFk/SWw+cKWksTCtUNLn1LEsoNr6P0tilKixu6?=
 =?us-ascii?Q?MQAS3KuMtYvjIcXe1MUC4k3Qy7Wp/GhMuyXJPfu+BBhT3P9UkrLeKpCfigxT?=
 =?us-ascii?Q?EtwACDY95quoxcubnURBJNuCNWfb2vpEss435/yS0t0xpMU5tXq3BVfzhfM2?=
 =?us-ascii?Q?pFlisAVMNO2lcoWLbjryoS8M3zhKx6S5HsD3rBpiWH0xHRIfgI3zoDJKNFk8?=
 =?us-ascii?Q?3xfjc30sc2TK5D4nUVOlJOfTwzyaurtRtT40H+FP3iGXI9K9/vFlE7JqvVqz?=
 =?us-ascii?Q?5LCNtKGNFyAlXO1zVM3iEYKhcvkXBQbIeTrM8+MXwpBwwsYC5l/tvzRUoa02?=
 =?us-ascii?Q?T1sceAqZdZ+usKvGSoyIP+B+C6E49KmQjajeKCVV2XnK9G2m3WSCHofSKpek?=
 =?us-ascii?Q?uU4rCJaCg6iWC7fjF4w7GEXqF7BrH0rPBdb2cLMbydiiJ927UkYn0odS34jM?=
 =?us-ascii?Q?Qjt9JOKo3SmmHS5iv9ozkCfLEaxxZw4SnYyYFGbgxvp5vpUMiFel5U71UhU6?=
 =?us-ascii?Q?mpvgoMCyodg7/zpx2/g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3bba28-ca15-4fe3-3d86-08dd0594a261
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:43:29.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tL9JmNsaQ0TgvXnJ3GISkpZR48cRfIU0wRpYZ/2sSr7/3spsWmNU7j5L8TQ6evqmkZ4NjAuGwtDuGp5VEFtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

On Fri, Nov 15, 2024 at 10:53:07AM +0100, Niklas Cassel wrote:
> On Thu, Nov 14, 2024 at 05:52:39PM -0500, Frank Li wrote:
> > Introduce the helper function pci_epf_align_addr() to adjust addresses
> > according to PCI BAR alignment requirements, converting addresses into base
> > and offset values.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v6 to v7
> > - new patch
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h             | 13 +++++++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 8fa2797d4169a..a3f172cc786e9 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -464,6 +464,45 @@ struct pci_epf *pci_epf_create(const char *name)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_create);
> >
> > +/**
> > + * pci_epf_align_addr() - Get base address and offset that match bar's
> > + *			  alignment requirement
> > + * @epf: the EPF device
> > + * @addr: the address of the memory
> > + * @bar: the BAR number corresponding to map addr
> > + * @base: return base address, which match BAR's alignment requirement, nothing
> > + *	  return if NULL
> > + * @off: return offset, nothing return if NULL
> > + *
> > + * Helper function to convert input 'addr' to base and offset, which match
> > + * BAR's alignment requirement.
> > + */
> > +int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off)
>
> Nit: perhaps rename this function to:
> pci_epf_align_ib_addr()
> or
> pci_epf_align_inbound_addr()
>
> to more clearly not confuse this with:
> if (epc->ops->align_addr)
> .align_addr()
> (Ideally those functions should have been named align_ob_addr(),
> or align_outbound_addr())
>
>
> > +{
> > +	const struct pci_epc_features *epc_features;
> > +	u64 align;
> > +
> > +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> > +	if (!epc_features) {
> > +		dev_err(&epf->dev, "epc_features not implemented\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	align = epc_features->align;
> > +	align = align ? align : 128;
> > +	if (epc_features->bar[bar].type == BAR_FIXED)
> > +		align = max(epc_features->bar[bar].fixed_size, align);
> > +
> > +	if (base)
> > +		*base = round_down(addr, align);
> > +
> > +	if (off)
> > +		*off = addr & (align - 1);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_align_addr);
> > +
> >  static void pci_epf_dev_release(struct device *dev)
> >  {
> >  	struct pci_epf *epf = to_pci_epf(dev);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 5374e6515ffa0..20f4f31ba9b36 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -238,6 +238,19 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  			  enum pci_epc_interface_type type);
> >  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >  			enum pci_epc_interface_type type);
> > +
> > +int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off);
> > +static inline int pci_epf_align_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> > +					   u32 low, u32 high, u64 *base, size_t *off)
> > +{
> > +	u64 addr = high;
> > +
> > +	addr <<= 32;
> > +	addr |= low;
> > +
> > +	return pci_epf_align_addr(epf, bar, addr, base, off);
> > +}
>
> I'm not sure if this function deserves to live :)
> Can't the caller just do this before calling pci_epf_align_addr() ?

Ideally, kernel should have macro to combine 32bit macro to a 64bit, but
I have not found it.

It is quite easy to make error or warning by simple
(high << 32 | low)

It needs ((u64) high << 32 | low) at least. I just want to avoid everyone
to struggle simple issue.

And msi_msg use lo and hi. pci_function_test actually just demostrate how
to use doorbell. if other function driver use doorbell in future, avoid
"(u64) high << 32 | low" copy to everywhere.

Maybe like upper_32_bits(), add global helper macro

#define low32_high32_to_64bit(l, h) ((u64)(h) << 32 | low)

Frank
>
>
> Kind regards,
> Niklas

