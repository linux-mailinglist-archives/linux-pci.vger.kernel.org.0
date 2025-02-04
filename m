Return-Path: <linux-pci+bounces-20708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CACA27836
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 18:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E07E18809A2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90BF21577F;
	Tue,  4 Feb 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+PVV7kx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4592165F2;
	Tue,  4 Feb 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689604; cv=fail; b=H7Az9zbRxICil+jvdmkRiu7HdN1pOYQ/klaRWJK589T5GjQg0TvHFlk7Dl1bKNLh/plJciX7ywwWwwGhOZxcD55OwwZl1M2zrQIXXK6vyRKY2wCtqA3Pux+TLVRTMe5QqAzLh1G1dJDMk/3kssqPpn1dZj6m3nYYgqfALqm20+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689604; c=relaxed/simple;
	bh=Z1RXr3P2HHVy1oEqVUntDlzKKtUAuK8+DVcrG8jATjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+n6QpvydY4slOAdvYzltXBnArIip22wPMeYCOZJD+RecLCqDypOmVb6YWEWxiybb7i5H9ZIad9fbcu3rX8iKHSN+oGXzIyhtncEceYQ49iEmTlDA1NZlNClrJcRQsWGNR1YSEZt5BF0mPJpm3UvDWiA6MF8ijCiI4CQGJZZDWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+PVV7kx; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCXjNmeWmo+jpBCstYxBTEeoXUgHsgYYnd6An3+PKadAfvJQT4fBYqj3Cr4Ix2kTKhu8wr/H2VLbz9hJhWduODnxdq+0OCDIx8NCKMriQ1doF82CpKeTWz+QgjfsNDMjtStpS5rb2O1zbEwBJIJOoCQNwQAZWXXXaQ5gsAkDITUpf6Xu2WMrRXloHeqL6QEwHQbKZDsnurOzGL9zmMSHKB9REs4TExZqy4wq3gI6ZLfdN1BRsFKeZoWj+PW7LvxXb4WF9rWBo6nXG50KgzZwAQxqarZU1hVbjby7lrVT6InCn0FpfpYvlhJEVwlL7dYYI4qldkPHNSTEMnUOkBCQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1RXr3P2HHVy1oEqVUntDlzKKtUAuK8+DVcrG8jATjo=;
 b=WDczSiGuP1DYayhlFT8jnjj6014Xg941tBZopyiHR64Z/hEUmBhQtO+NFd9pBimjTUe2pKxz+m7OJq0aAgIRROfsPPTSY7rUZl1XURW/E7pfNDSWnOW65VO7YOeKYUyYxAULqGOvO0kHEzooswpFfUFVZEsGpzd+KHWq/+XSszln8MpZDabP/JG87PsW3aEsCLQ9mmpQPCR1o4pvNzmIFF2Xa2FHNxSKq/WQ1XkBomzaXXmu+ZtRPYQJ24EXcJx8+MAnPjwYC+a+7RRuIFAf4teIxHrY/glizNsbKDxPjqIxkEABAvnWFv+JLk6Y2bLkMlaYCm0jA2zCYlkfKi8PAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1RXr3P2HHVy1oEqVUntDlzKKtUAuK8+DVcrG8jATjo=;
 b=J+PVV7kx3jRUP+72/fjkxj4MBH+RIdPrEJilC0Qr9jA85/nj7wyRu9YtBaq8Y9L0F2Qez+yly0CssnA13OScB/BMjJAJWYc7y03xysMOUVdDbMdwwmTIls6vcuOotLX8SOscnKP/qM/TP0td7LO03YAe0OEuWmO5K6pvb4F0/C3T4SKj4Nnqci4I0xfTHLfpBWWqQH3kYVSfDR7itnn2C5xDxEfqEvlUkSjgmRcckQCOlj3njvMsdAeH6y7LVJzIg2EMXgxBrosBd5XYSVT1XQ5JNY0RKwCCvnPxr86W9me2vnUpQEHV1rQyIVCkJVvWx7/xMjWeZvO19c/o751rUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Tue, 4 Feb 2025 17:19:58 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%2]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:19:57 +0000
Date: Tue, 4 Feb 2025 18:19:51 +0100
From: Thierry Reding <treding@nvidia.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	quic_schintav@quicinc.com, johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com, 
	sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <zaj4vcbduaoceaueqq5hvbw5rvoksk5oz6via3jhfp7lyzlxnh@2umxfxphupgd>
X-NVConfidentiality: public
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
 <20250203165932.72kezmi3dtqpytvg@thinkpad>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgyvuwc6o7lddmji"
Content-Disposition: inline
In-Reply-To: <20250203165932.72kezmi3dtqpytvg@thinkpad>
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fb0dd3-6416-49ea-6702-08dd4540261c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GMMVnUxSj7PsdAUeP8IEn3Jui+Hg8PcL6Cytn+Y8C3VrIzzbo6i0eF11b2U?=
 =?us-ascii?Q?vX+nyft6vl75w3NFeYx/G810Vga7rGRAZ16ArJ/c0npVSc3On7QEc7nnLm3/?=
 =?us-ascii?Q?f2SOwAlz+qj3ank5CuYEVWXOK6NyJfp+tSygit0Lxqtk3M1oG5kylU/xNGR1?=
 =?us-ascii?Q?FcXNxl+Wycsy3I9Ve7gXLB/4TkRHPZKi+jXg3eNvWOVjigSlYV7RHCnwMOHJ?=
 =?us-ascii?Q?4f3y5k6q3S6+dZbinFGHCgcuWDtSujXUifxq2p6UKfD4LleIsw8EMThcUONw?=
 =?us-ascii?Q?LRmLBncforDYud5LxdhuZzDAZLnPqF3m2gnLKZsS8CBMt25udOv19D71WMw0?=
 =?us-ascii?Q?tEBJLPPaALheYDKI4y1lD9xCmc5wYhhSzyTm3IEElK+NB90dcXECNkuk74/F?=
 =?us-ascii?Q?HEORCNrgDD0QpI/eY8eumGV4H3mHLBvk344CK96fD9tLRTGw3LBvEb4j3bhv?=
 =?us-ascii?Q?srEdyO8b+nJ/13fd7VGfbJA2QXyIaSPEHwSTBeibd1rlRYRMZsfud5Rupekf?=
 =?us-ascii?Q?Dekpy3P8o6eKwYiRS1a+DXaUE55ba0sqO8X56xgZPjdX8P2D4kicM1NmE2QY?=
 =?us-ascii?Q?GpvuOlCFf7d2uewZGt6HCcNa1n3w52Yq/o40AfjtuUIUKPm2fEfpfWNkxa26?=
 =?us-ascii?Q?FjkfsX5+RFLP1akY7/3N+zT/yKV/8Xqqf0We/Li9AthrRYU/ZujgOERD10sb?=
 =?us-ascii?Q?+gJ5lAKdVGYmdbEXuu8xE5ZSGBWAU52vajq2B7sQm+PCMBhieLDB1sL5bFI2?=
 =?us-ascii?Q?B8g2+L53ZkVeIg9J94hqiO+37QmPqgL3YDyfSr7NpNIul2Mv/O8NrINP+XcT?=
 =?us-ascii?Q?FnCI4yE4e0CcKMky0LDDy/2GbsGGWH9L7qyj16rg16MJQ0VEG061drIh5oNk?=
 =?us-ascii?Q?G9K0+WCnDg7eo74JZy0EuMK4Tu+n7WmYJlyOegydwNe3OmEQJDj64B8heVMz?=
 =?us-ascii?Q?iU4P9ydpTZgEYcdOId6tfrXimvKlm0JRdDySpvKilQZrq49hV+IFJ7Zj5uvR?=
 =?us-ascii?Q?8ZO9NBvwzVpZwGAAKZXm5OF/E6aD+5TLxLzggqxIpSlXWTaVR3KM7oHbhlc7?=
 =?us-ascii?Q?MXzvp+9+5C9kaJWHUAR3IjkccMsRmZh2MJrhrzbT/AzyX787BaYkD4sLHdio?=
 =?us-ascii?Q?kmTJ4qSvg/UHz/IHb2akMUnLezApnde0nE8trBp3/LYqBiEcQrBR5YEA23bs?=
 =?us-ascii?Q?CXfT8qxYv8R8IlRtlLP4CoLOZ+Y1btFrQDdjr+9OeDZfWLB1JMW4FbBhh9E/?=
 =?us-ascii?Q?Pl1aZsZEbJImj6w/TCPyUJ0stcTDmnnvzZwS4EJAxNmZt040Ms6zz7vavICP?=
 =?us-ascii?Q?ee5X85u26K+uK0Gjp8Sx9caXStdY8PCFNbneYxTz4wnXnfiVd23PC5XrPGop?=
 =?us-ascii?Q?xvnVohbb+aJ+owKl8twb0DFmXBF0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wRNzrkghv7u7iDHisKO3D9ZtB0cXYz82oJ2DMcDa2A06oILQzun9w2ZYknR?=
 =?us-ascii?Q?5sN0muTa19k10Y59Ut8YfNgBrwLEoyro1jim6MXvIjwTDx7RE/ki6pikt9O3?=
 =?us-ascii?Q?N8VuEPcGHEfDCuSsG15cdmwHz4yQU72We41zn54/qiqpUikFVXDSwRrMYEzt?=
 =?us-ascii?Q?DddDiLTyIl6QpgI/F2eSFE7DXBHDKWW4DozN4R2PGI1GO84DUb63UzcaR03Z?=
 =?us-ascii?Q?yRSWSsOyQN7KaVuEqSjQ9AeYHSSl+eFuDPiuubKBe/3WvvvL9g9S31zCqIGi?=
 =?us-ascii?Q?gL4XA24Jj3OVZBhzQW+yRI+VDyXf1E/nZra09a3QKegVOkdfuz/0nrc9RplB?=
 =?us-ascii?Q?Wi0nObA7sb1xO5vX7xehfvwB81PXHlifFPiHxTfB+VvTEO19LTfcYua4yLXs?=
 =?us-ascii?Q?xFaOP0oZs7jlsZh7bFgaO4i+NB6QdOIaGqRs6O99xMTokN9xTX5n8mzD1yKC?=
 =?us-ascii?Q?gEO+OtsPtC/ulsN1CY4fEft39BtRb+jjCirBZL9PKfxpuncB5EJNJE9TuKkc?=
 =?us-ascii?Q?mfi1GPKjLr6MrwuIEthPqoPJsaj0kUXAotji6QW6f85m686FnYVB42DVxuX9?=
 =?us-ascii?Q?zBQVgEzhEx27GDfgKVfDHdVz4Gm5ITWGfbagV1Mw/qNpgV57O47obAjikbL+?=
 =?us-ascii?Q?/CVeI+Xa9sYg09+PkNdb7w3RhxWdRoH98ePluZaLP48jxjPIb6t8zfxZ8xRu?=
 =?us-ascii?Q?9VpE0w9mrjLiQIoxH6Y0MnTLZSVyx1z6YlqPvKxUPEmPj08PF7qSiqyaH0KS?=
 =?us-ascii?Q?p3F6dLhp788qgqprX1PhEt24U33hlBgW7wRkWRK/7JpSm41atnKcyyKfB8ZF?=
 =?us-ascii?Q?qwF/Zs9b1iTkWqSR9IwPx5cYFC85att3N9ffUADRTOuqWncmqdgf4ZfJUzC6?=
 =?us-ascii?Q?lFsE17/zZi32EBzGSb5GRb/k/3NhRX20R2MWeY2DK5FulZMDUOrBFfjpnhN9?=
 =?us-ascii?Q?QD8ZFtkpAAehSNFLO4DMKbxGsyocEnQ4ezDbLMfKb3hb1Ta/2S6d5NUIcsXo?=
 =?us-ascii?Q?TN6OC6mnbFb6eHLavyejFVC5hGfPeeo4FqnyAd2KCwOdADymkBjgs+yKLTEq?=
 =?us-ascii?Q?35y94QObSeo2kH8p5DuzulZIdVnjFoY6zzUfXKYxNZPT/yfV5QXFKItA4zbb?=
 =?us-ascii?Q?+UXB6NB4yYyMZSmuetzc2ClC1L6XPdhj3vjmClKiDuAD7JPRArrV+CCqpW3s?=
 =?us-ascii?Q?EI+yrOnTs9hG+R9Vt4v2ox+O61gf6d7QgpfeaUUzuoOkEzPmX8h88rOLwE1D?=
 =?us-ascii?Q?bn0+ejwEPr9wwLwxA3at8HtJmRMCiLlaHUvNR5MVoGbJfVirJbd55EC6uP9Y?=
 =?us-ascii?Q?lDnx7QQriK6vXVL3GRNVc+dqrNmph8/N3hL79VxkM8zzm7+FcANZci8tmoiT?=
 =?us-ascii?Q?3S64KcHAn4z6HucUcdoxauLIbRgMSSDIOy0OGEdVY9YoG1/elOWdYgEM3+yy?=
 =?us-ascii?Q?mGunsB10tc2Z6sIGpvrYh90jWYyLGr7RvWLcNT7t97JJKAoAYP+65aSYYuqE?=
 =?us-ascii?Q?apyUKVIO20Q/2ZoZSq2JtHdtdlOFqsQmk5EySINu5ZhESqT1SbGMiVE5AJaa?=
 =?us-ascii?Q?t5SDKSIY2dzq7WaxmyeREukJoizD5viwa/MbfrCVc1aSePFBV28eigqg7DVE?=
 =?us-ascii?Q?gRu7QTbEXXsrIsYxvho8MNRWoLezmfaXafltYaB1ndEg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb0dd3-6416-49ea-6702-08dd4540261c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:19:57.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsDXmuTKzDY4lSXT1sexevhTv9SRS8/smLWwMX8uxa88hq8QNjL3oYyr4tK54c1Qa0UZv/u0rkbjmHP3ng38ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

--bgyvuwc6o7lddmji
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
MIME-Version: 1.0

On Mon, Feb 03, 2025 at 10:29:32PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> > Hello Vidya,
> >=20
> > On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > > Add PCIe RC & EP support for Tegra234 Platforms.
> >=20
> > The commit log does leave quite a few questions unanswered.
> >=20
> > Since you are just updating the Kconfig and nothing else:
> > Does the DT binding already have support for the Tegra234 SoC?
> > Does the driver already have support for the Tegra234 SoC?
> >=20
> > Looking at the DT binding and driver, the answer to both questions
> > is yes. (This should have been in the commit message IMO.)
> >=20
> >=20
> > But that leads me to the question, since there is support for Tegra234
> > SoC in the driver, does this means that this fixes a regression, e.g.
> > the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> > this driver was added. In this case, you should have a Fixes: tag that
> > points to the commit that added ARCH_TEGRA_234_SOC.
> >=20
> > Or has the the driver support for Tegra234 been "dead-code" since it
> > was originally added? (Because without this patch, no one can have
> > tested it, at least not without COMPILE_TEST.)
> > In this case, you should add:
> > Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> >=20
>=20
> TBH, I don't like muddling with Kconfig like this. Ideally, the driver sh=
ould
> just depend on ARCH_TEGRA || COMPILE_TEST and the driver should be select=
ed by
> the relevant defconfig.

ARCH_TEGRA is a symbol that exists both on 32-bit and 64-bit ARM. This
driver is completely useless on 32-bit ARM and only used on a very small
subset of 64-bit ARM devices. It doesn't make sense to be able to enable
this if you want to build a kernel for say Tegra210.

The relevant defconfig in this case would be the arm64 defconfig, which
isn't very authoritative.

> And this is what all other rest of the platforms are doing. Why should Nv=
idia be
> different? It makes me feel that this Kconfig dependency is used as a wor=
karound
> for defconfig updates.

Well, it's certainly not used as a workaround for defconfig updates
because the change itself doesn't enable this symbol. You'd still need a
defconfig change to do that.

Also, we do this primarily because we've always done things this way on
Tegra. As I said, for a lot of drivers it doesn't make sense to include
them in a 32-bit build or 64-bit build because the hardware simply
doesn't exist. Having per-SoC generation Kconfig symbols allows this to
be modelled more accurately and if desired to build compact images.

Thierry

--bgyvuwc6o7lddmji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeiTDcACgkQ3SOs138+
s6FzCA//RcW9K/mVgeFeTgVx3HsZ0OestrM/FvJLRiGsxlF+7fW8Rwk8sQCwBobO
/KgKEaHQxXj5ln8RMt1YP4k0AnWJ0bWtoFLB+f+FHJn4wS0poctQfPQfcMAcOdA3
H0uqqVhIWIOSSL14HDIdfQCjRjStuETQms3Uu1NqMLlL3leMixifNO0h82gye3ue
hFanLwLg7M+b7HiARtVBEq0uC54FzjE4y05Z0/OA6Szh4X2G3XYzbv3/7Seljrva
yw9pk2eIMvJeiA6n4QKcwYbsJBLZDsoFpL+Z5L2nC5y/A7QOPZKs/sC0Yi85/uHS
+Nqe0m3p3Jn+V3fnmBKPi+z3rVwrbRvqziPPkLSEHhniwohmjUVReTK3bGcwaFv4
JxRuGb1X0rz6qGhxohR/bnGpfHdb5xLJy++yyPcawv/ocMvihQcrmT+XuZuc+j/x
4Nz+N5pskkn5IIztHphd4k0FHnrSnAaQKUsS2jPWGgV2vKiSXKl48cdODe2cejcM
GiatfvpmLury+JrS9rqIjS3EejpS+d7ZbkUuf+SKRP2BX2+So/KAHmtFsoQncGI2
XsQNaxkLiib3Vs47wqRRDJyz2RZ1Ghek7LbQJCqutmhtDVnYkbJeddXYsyjkBteV
3u8U5K5+1XqZrGeo6f/XmN6KUp4caK9aMf/vxPMlfn+il1HUgX8=
=ny3F
-----END PGP SIGNATURE-----

--bgyvuwc6o7lddmji--

