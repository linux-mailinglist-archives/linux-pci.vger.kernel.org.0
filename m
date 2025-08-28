Return-Path: <linux-pci+bounces-34956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F17B39129
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 03:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11AA1C218DC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708721C195;
	Thu, 28 Aug 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aWdgj5p/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CA21CA02;
	Thu, 28 Aug 2025 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345062; cv=fail; b=UWyxej/DRd0EsyVJF46bG+XXgiQBgmFdNfIkE9IBiCk9tJRJQyzUQCBAay6d/EUprK8cs0xcx4wPupFIN0AjAJsfrx+WuF2LkfUKB5uDEPRs80UwNmToxXQpDL5N3zVsvVRvtqJ3eFVjryGlLIuLVKCCevRFDK7zra+X4+wlSCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345062; c=relaxed/simple;
	bh=fdC9WPmPdizVrKZbdDKHS8UmWTRD4hTjIQeIZ6Ad8vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WjIbU+cWjeFnFIqg8Zei1J+cOz3nnMUMqqWH4ACVNhXiBnimgAfi92eiNM+0R7gFxbwRgygii3QZ+m163yEd37XKDfu/dXkepC+87LQBjs9c6yKAzajbERbkqVN1yQMLbUTIlL19wvMxEQ7Y/TQw1LG8Dt1ODJG4l7ZlwBwyJDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aWdgj5p/; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYcHKgeo2LxolgIvdY3o55nAiZJtyZoXSFkWXnchF5Pa25GS+1D4lZLi2YYbVFqzu+d+9aJ095ImKI1gG/HGYN0BndJmrogBD2WON180VBFBWQtMP5TPM8k5kiLJgPZ1tCUGUgLFAYGhw0RPTF40dzqsdg3J2vg88jzvGw7INGXY1QNKcOpRtcj8XypauYCXmwIA3ta+a5JbVd89Y/WGLAujAHArhaE0F76lOVc5+qmEoHodB3uIb2G/6Z1Qik8akL2kdPPVmIWpzTgXuUsQcdGyMJQWV4m3XhJFabYeiIKXjx8ebprpWdapYem/hSfuDGwmfuhrjFDedLBayo9iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdC9WPmPdizVrKZbdDKHS8UmWTRD4hTjIQeIZ6Ad8vo=;
 b=TzINfznm6uKHs6Up2Ucw7Pu8D/CvNOvv5QrUjqxHOoKrw8koEbGzoMOpL5LbhgZ7HnQJUa8SKBmT4OWTTKXtxcxohxf2gp+J3d/NfAT8uCA3QWNNkwxAYHrXO6rgC0UYUDApyoznQaIPPQon8IQb/dXUL2kR6lcHliYP4qb9i0/DYnOquMoz7eD62xL1yxEq7vcdpSsnESmL4HNqdRfEvDl+k2aUQuL5h+rl7o16fij5nAlw6Xe0QOKqMui49HA3TmB+BF7M9ioy7LkiJ0T0IUuJvAjsNZqz/6OdZ5ryKl0H5GMsW9dpiWnjrXyaA7MYneHZwRv2utTiroVMnqn59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdC9WPmPdizVrKZbdDKHS8UmWTRD4hTjIQeIZ6Ad8vo=;
 b=aWdgj5p/n7j8PJ1nNWQ2pj0rxCJLyR6YSgPLOkDZMZrbT59R1WSrVqm2WtovqbS8TeG1jSEfV33ENTB9GWs9Rr8Yfsme4Q89ICOy01nyZf+jI/wS7GCNUM2HdNmwIKi9F5zNkyGPSdaIC05Ex7NzyFMuZL9SxdA6poXYHN1+nM6SKh2cdD/ZuRNAou/Rl6QJ+tblTfUShqQea2R7LTT2nMtVgrLuyQAgDuIY6PtZwY9cJvCb3aG31rxidmfIe0vE09aj/Phs4ZUZz56BRd4gs8nwJbA4LjvKMauvD8G4kJJnvH4v7RZTLfhw+WJLv5RxJhbH8gM1uwxPH9SqQ4BZuQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Thu, 28 Aug
 2025 01:37:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 01:37:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Inochi Amaoto <inochiama@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yixun Lan
	<dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Linux Kernel Functional
 Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Chen Wang <unicorn_wang@outlook.com>
Subject: RE: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Thread-Topic: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Thread-Index: AQHcF6fXkpXyvyKXE0mDMm4Q7Jv/O7R3SNQA
Date: Thu, 28 Aug 2025 01:37:36 +0000
Message-ID:
 <PAXPR04MB8510DDAA3226A19CC52D4C88883BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250827230943.17829-1-inochiama@gmail.com>
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9360:EE_
x-ms-office365-filtering-correlation-id: 76a55e69-e9ff-4ed3-1e29-08dde5d377e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RF7SFEek+bVXZrgjLrkzt5EVc/qOMeo2wDu4c94KI6zaxrKVDCKW3q0JzHXN?=
 =?us-ascii?Q?4hjKi5RoNJlTV7rriqhQ/6FY5/Y8bLW9Ln5BFxeZHussPjsbdU3uLR3YX633?=
 =?us-ascii?Q?hlm2+DUhsN+JyGy5sACcuyjDG7Ex49gbs0Zpunm4COB9FHun7LW4busAFIJF?=
 =?us-ascii?Q?H8HyEYwy2BxaV09rL4zS1dUbHndsNfPqNWQzi5RO+A8dUOQiRG4HwRD0i3e4?=
 =?us-ascii?Q?8UqadQILzR/Ff6i+LPa6sYfxlhb1EbOp+CbXlI7rgPCdYJ2sAeJXENF9LGp+?=
 =?us-ascii?Q?SONiP4M3VHZKXyWnZAkIxsbxkA7U+g275XHe2zw4kleDAZanv2Rgh6OLw0OU?=
 =?us-ascii?Q?4ZFlGYS1a3dtlFtSiPtKGEhY3XuUmhflpMbOcKu3R8A9/OBIz2hrqO4nL6nO?=
 =?us-ascii?Q?prRTM4gOyZbpT4LU+4YhDmRNhJAgPUkGtVEp3LDHhLOS5AXN0xAfSnQpwuF/?=
 =?us-ascii?Q?goOvT2op6AbgOVtHLRwge/AE081I5VGFqAXDb4TBH3zd+t/dAinL0Ae5b3uL?=
 =?us-ascii?Q?WfprDucoxz7Pje7MvwVagHyn7CXxoqcJZ1sZwMh4N08E3fitlEpaDcyFy1KJ?=
 =?us-ascii?Q?+q6uR1Ne5unGqG/ATtFlEyE2PYvGHZ/FYDzNef22yqjIV5onZjUi4wjwuBXv?=
 =?us-ascii?Q?M55IHE57oNndLk5O8SbRqWFsgopzF8CZMtVnFGJd6T7D7/OhGTkeSOdMO6wo?=
 =?us-ascii?Q?HiuHBuUwb4mqb5W601uZ21Gm+6Ll7+up65a8HNIw+XUuWzq8biNQJdoQt2vw?=
 =?us-ascii?Q?68Zv2DyaY9tndbZ8iAp2YodubYHLBwOiyO2/YXegUo9+K9945kGCHBmtDFUw?=
 =?us-ascii?Q?qD60fsT5OPZ2mQfR6TxgI2SRxqWU7bhOuNo/pjt7JDgWdV0XWbcD+JT3LFGs?=
 =?us-ascii?Q?V51plky8+nm75zfXs0yOInkApDVUoeadrRv/LoS9SaHA8uyzVKlTpZ6ll980?=
 =?us-ascii?Q?+TO9jPNJupHzJ+MC8sIMf7xF/DJOanzNiCOJqQt24kWREzB6iXFD+kHd8LgG?=
 =?us-ascii?Q?xi59mdXP9AtHTTs8mKpNRwh2j8k3TMcfIJpadbcaKgTt29nNwWv/txzVoqYN?=
 =?us-ascii?Q?svqrvUTHkOivCUHbSrriHS0Q5mIss1ceIcj3xkiZLfcT9ekjd4GmIbVXXV+U?=
 =?us-ascii?Q?PcY76ZDfNuldpv932umEWAJBoDbKhp4Pr9SzL2icCFnplh9mvDAirFpKVnq6?=
 =?us-ascii?Q?cj4J9UuylNmaA+suaKYS5M1vhkdfvoh21wUy+oMhAEZzmWC5bpQzR89495nL?=
 =?us-ascii?Q?at3aRCaPTRZmx/eYkkoquw9ej3APFSy0sUu+7/SFt6tAIIGBC/iCanCGL8wD?=
 =?us-ascii?Q?H5oVWhSTlZ5P5+PfAJmAG59T+csG97fVnu9yTbz6x6vaDgqRO08sgTcDTUDy?=
 =?us-ascii?Q?xugorAVuriiyXeitsPn0HVDjtXEW1q8bT7g2eG7z/Be+Nafa46rLSWyW+sN3?=
 =?us-ascii?Q?d03sCojScH6H85TC2ctG2/ylLP3goTxxlnwFvpHdLXaHFniJJPUwUw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bkBsiB2i1BAl+GJLzjrZJIsPwP2H1j1RiUbj1NnOlc7vhVh6P0K64gzv9Uv2?=
 =?us-ascii?Q?Zj6mPpv/VAO/v0ILRAUlrwzZF8reXOTgprdo5Pm1RQDlOXTdN3MwXNS00cLj?=
 =?us-ascii?Q?cVYSRK+JJJsbnAINeJDTRptZVAOkFzbHuKaY/JcGJzI/sWxpWcEAfIZY6giI?=
 =?us-ascii?Q?YXpGwO0m03fOQE+G8IhtuSqs/R+2DuMPLil93LjKW/Z7/fpivp9Dryq+Wrjb?=
 =?us-ascii?Q?BnpVszxVGmJ+XmfAqhJWYllAnlGnv1FVauvYMnSF53mk4Sv+IV9qru+Hvpep?=
 =?us-ascii?Q?cdfNaV3eMCA9lHyvI1FeL+Qjpn7L+xUxa46cMT4RheFkuHVVZWtPzEHTJq52?=
 =?us-ascii?Q?HyAK493H1mVQhzEVCcDghGACz/LTdViXGOD0LG3iAjNrzED6MN4qrnyIsVkG?=
 =?us-ascii?Q?mc/JZR2+z/ZpEK2yd4gAwYzgclSmiJTq2VuLBBj7ZhEnUi3OF3Jb7DJshFPd?=
 =?us-ascii?Q?LC2dbk96PoCcNJxBdp8JYBpjdzM0IDkPIKYpKMXdAULM4BL5R7svqINwdsra?=
 =?us-ascii?Q?radbGY1uFvb9fvtcUDZRmMFsjj8tojWOBm21QYH1e6TbG5ZXFFudc+nOdH2P?=
 =?us-ascii?Q?DIw9rrCjp22+VFQuAmG9Nkyq+wO3hJG2eLZrEBs3rc/5phD6pMmzABUH1w5J?=
 =?us-ascii?Q?w1QenHr0RrcfvtIfk3xZk3aUFozRqSxTjqfmFS1PcE+oAcP20ivpOG5LVK7y?=
 =?us-ascii?Q?R2B0W6QaRs9ZrVfKM4z5W2SS82Xn6SWmaHqyzX3Eodn7GRGF9C5Bm2Q7EFcp?=
 =?us-ascii?Q?bZXpQ99Bu0LUb1RNNU1h3J54D6P+J72LCjyaPYRFR/NvqO3tDkuT21KYINv3?=
 =?us-ascii?Q?a53QUpnOAIt6+l9Qew9divkhQFay64E7I4yoBuQVWMZWATRqKv/4Q2nMv2jc?=
 =?us-ascii?Q?yH22Tpf7jg5uwt+F5AqijbKT59Hs5UAz0MiWfZa1YGYyogwj47ST9hOyij8+?=
 =?us-ascii?Q?K7XU0ftgQv/a/rVj5r39IQf/tatQZ4T6DgDcx5WJfbGXKbUindC/6Yt3hVWy?=
 =?us-ascii?Q?xvKgaIhnj4+3rFmelIWt3x7MmUNIEvFwoeyytcU0WgcirNuLNlck9TkVSYhY?=
 =?us-ascii?Q?8+jtteS9h5GG9oJpM7qk9owm4zx+Kec8EVEX53EDHeG7+aSE6myHpr8oaZmE?=
 =?us-ascii?Q?C0dVPqRANw+n0t2AP7iZCRkckNzDwudQLTVXerydMCevrrXgjwz+Hq0LJRqO?=
 =?us-ascii?Q?Wt+8BqYIvN4hHETeylN5DxNcdSwpOM04XH+2aK4j8P+XUzo4fqBj53wUbL+L?=
 =?us-ascii?Q?hqHwFhoWnzR9hjYt/yeqgkVvosgXBZwuAd0u6xa+JCJYfxXK59K3fn24Rczw?=
 =?us-ascii?Q?IxdyKoTCQifwKEwU2fv0iNwFoE+Gk0Y+E/1PBhw6HQ/mJWcnYucCHO8V6Odf?=
 =?us-ascii?Q?uvayen5DAxQ8oqQSx7NLkUI1O1wYW1ze82BavfYkj5V92nn7AzvfoqK0yBD5?=
 =?us-ascii?Q?YkTHy6cZGYmOkk6srYbjpUbLa3uEcR0lBQwFVAj46QbVqBcvcvN3L4yNl0C8?=
 =?us-ascii?Q?vR5iG8lgoIqD/VVQLZVQRhznQW2BGlt33nLZ9EJcODWi+Tk1DphC3FN91rN1?=
 =?us-ascii?Q?mVqo67CwcyuRuAwtEkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a55e69-e9ff-4ed3-1e29-08dde5d377e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 01:37:36.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X9seYiz8DClDyTHeZKFJKEXjd90D90xGz32C1ManxM319KDQgbPlcTWUTrh1+SfsBJRaIEBTWwvW844D2zVfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_template will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
>=20
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
>=20
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device
> domains")

Thanks for fixing this issue.

Tested-by: Wei Fang <wei.fang@nxp.com>


