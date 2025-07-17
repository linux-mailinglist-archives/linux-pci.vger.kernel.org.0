Return-Path: <linux-pci+bounces-32361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFDB087FB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B884A4DF8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01223B0;
	Thu, 17 Jul 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ECFYOz91"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9C1FAC4E
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741221; cv=fail; b=Wa40RLndoFbMpbp0H/QVobmBLzgsrsf0LDqKU0PoCIY85BUPDU2R75HSXOeJPCIR13GvBcjtmjObvIuhMVtg6gO4IQB8Ugi7C33W6FvkiF7mAhh56p/P7Jnhb3ykxieX8ff+wdi3uYXUmmAhm3RnbJwC1cLydFIcSZ6qMUiuAS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741221; c=relaxed/simple;
	bh=HSOBPSkDUes+1NezoG4L/kwlj+mxY0lAfGgjPn03mvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlCl7olMdUtXdGnnQ38BRRIWf0a25em85gGOJGwsHz8UhMggsS4XlN1L8E3fOYGy9drjll3jHtgCFrM4Bop6BfJWwbof9STCruZQlBRAz86j/ZOHfkzktVoXpA+TMI1EeX/bNVPUMM0PWpMEKDcyto8ZURu+FhXKSz7zBwM92Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ECFYOz91; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Thu7DHq5x5ndoNs50HSKSIzKDrqwtSCeCTKWNr6N8xilLY43xsHAVQFhW+UoOonnl9b8MzgAoZI3zO6ZNUeX0Iy4crQrHsVLH/MpBPFyuE748MBuRV3ReBG43gW50t3NwfPWEP95BiH6UAYMkk5TRolxj7aLO+PI+3OFWjb9RYKIB5KTpNkZhrrfv+z6/7fza6ekh4IIwLYg3XuteRHeTrFQnplVyaTp5HpV4PcwWN4+3saU/Xe2aIdIbFaaiJbA6/wcPU4gDmNqENfNw4AeJEdxtWaYcoLk6ISZhKQGStTpGzHzSg42oDln0UCagTxehTKOljqVPCDSikl4xgMWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHve4q+qt6TFDgoLIMxIjlllXqAzGnUS51G+4/nRcNQ=;
 b=b3EzizQ2flnv4F1utPBqKRnArDFl8jbnAXTRTZFlt6JhNCFiqhmP8jZkknvpG+20zylvqVFtl29Z+H16YdaoAu6sl6KtxLZwnfZrMX9eYpOiXwL0J8PcsXFyp5AWQdCIDbMac7XbmoDUjrgJP+huhF/TYREoqOA7XMaWEKEUg1wDOk1xOhEPL27SJfb8F97sls3Nd3T7oMKkTQTxawbDzaUbV9EAtN1AgBk7XT2g51mVPscpL8LCyZWHi5mOD+LtC/19anvPHuIf7j2/hXUYEgN6RB4xUgIsSmhow8Z4J9cfJuueExKzWuIinD/tAf0Y4jjEN+ZQdUe4wXrCTTeCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHve4q+qt6TFDgoLIMxIjlllXqAzGnUS51G+4/nRcNQ=;
 b=ECFYOz91EGeYMMU60pzBw4TnWrRbo+8oukseOaWSZY3RGLYe7MV02782p0tSc3EWEEKxI1V5DZEuJon4hR3w08r927bCSIBRB/xTR4Tbovq+gBhMS8hrVbFAAeYg8s/UwbS/UUmRCPKP3OYWNEd3FgE5j0RkT1ypTHtnSNX1IOmonS9QoK9GaQy2umT2ewEAyOUK02QHHVThoQytpPjGjXvaaGlMcsxo1qs6h9z+NDbiOhPsK3jKfTuQmId6+2N1UPcd0EZ6uJGdFttLQpOXZghvlA7KHcabFCi1DtgvAycJtoHfSCn3A5XGEgXstDxeWVNhF3vlj+l735Awo8+rIQ==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by AM7PR07MB6900.eurprd07.prod.outlook.com (2603:10a6:20b:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:33:36 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 08:33:35 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address range
 check.
Thread-Topic: [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Thread-Index: AdvhxgLgWgpdWuT/RTeY5PDrhwzrawUCgdKAAEhIp0A=
Date: Thu, 17 Jul 2025 08:33:35 +0000
Message-ID:
 <PA4PR07MB8838F2B719D6F1917BAA9291FD51A@PA4PR07MB8838.eurprd07.prod.outlook.com>
References:
 <PA4PR07MB883887374D2E7B59E33A0861FD7CA@PA4PR07MB8838.eurprd07.prod.outlook.com>
 <20250715213301.GA2500492@bhelgaas>
In-Reply-To: <20250715213301.GA2500492@bhelgaas>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|AM7PR07MB6900:EE_
x-ms-office365-filtering-correlation-id: 76c0a1b0-f1e9-4ef9-8bdb-08ddc50c9f43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tZDWrz50WWPVQIcRBSDXLd/4QAje96y6dywy6Mc5bwp9cZ8s4pDtHoxvdPPF?=
 =?us-ascii?Q?kcca0XXDQanddsdtyvTnLCa++vRYWHvGc1KOcO+60LMPT7u3iW4h2DRON+nK?=
 =?us-ascii?Q?8zz8pEou0XDV1yRhP5N4nAU7/QzSXTopWMXS6TOQsfT73bTppdMKXKMVpRAJ?=
 =?us-ascii?Q?orW/7iNx5bvChVVrPGo+nPnuigNGtQRGHMjR8i6lrQMyJIhnAV6EhHqtYYx9?=
 =?us-ascii?Q?8m98SD5O+wwtfj5AzeSqgnBbbb7+iEwN+l3AI8yUwlIcmop2t91TwxM6kG5D?=
 =?us-ascii?Q?eeyoXJc5i+vM6g4XdQ/3eZPG0oHjEk8BOgkFELzhZ/MNVt1wzRYHvMd6BtEG?=
 =?us-ascii?Q?s6jHBasXO/QBlLeMakpn+iqjPeLC2BnQaSnPcSd6IACD3LfvQAPJDyqVckj1?=
 =?us-ascii?Q?sPbhy32v3rb4egEOLJzWHRr2Rr81ukJjaxgKB9wPSPoqmLR6QBOHuJiAsiGl?=
 =?us-ascii?Q?YAH0bPdYfTFBveQM/vSQbJkK2rPjBv87qmJYCHvQsPmeIpuKMAH/lP5IwEI/?=
 =?us-ascii?Q?w4YK0DVC49YdnIUV1CvhYmZvMCNQUDnEtchmcPWhe1swCgT2xSn7++D0dHH4?=
 =?us-ascii?Q?poFTJ0TX76ztHTzS83x3P8OTgJqhS0wAksUPKLAPDSR2OhRu9gnj/NSZIuqB?=
 =?us-ascii?Q?84OzfBcK/BiTtzRqhhsZ39Ej56kbnJIJMkmvi8UxvT4VQgpZB6gKfPM3OwL6?=
 =?us-ascii?Q?T1s7b2hIfS/u7q1iMZkppLjD26HdxT4A43CzSP4myXSzM5j0sFDNc4d44Z/m?=
 =?us-ascii?Q?vY7c8jvhtON2aH97+qUmhFI7ayHCyPht2QHs20cAAInv5yWluaPf4sEdmpqx?=
 =?us-ascii?Q?AxPZROzkpLuZ0j7bj79oLf9vAysmZIN9Z2zhChwsG1ZpMOgKCT1oMVxPwb2g?=
 =?us-ascii?Q?zENy0AHazvR9VM0PZToJa7xk0LmhEvWcmCg8MjFsfY06ybNU09ERoNYHyWmC?=
 =?us-ascii?Q?rRQFBHkBBRd0g5noj54qpf9EEIBi7KYhRO4O5tw1GE97rlqV9je/RHeEqzFa?=
 =?us-ascii?Q?a2jHBAL8fvXl5usUQAMPo61nG6/wm3zpoEGJrtK3sXk9hmnrJhF0luH45jdI?=
 =?us-ascii?Q?VwPna1hEqbEM6Ts2/0kXkBH7RalsjdN2KvFmhuFoISJegIUT7LTR6owjIuss?=
 =?us-ascii?Q?XpDSC7F7QoM7XRCPLiq+XCO9zVllQT3Hal+tkOWYWZUpOxMgXlZ3aBEEOTwH?=
 =?us-ascii?Q?knERr60N+WtzrMzrMJKYnOG503adDdeshcgapo1ooqbieNihMt0LYTr6juoo?=
 =?us-ascii?Q?7ifpfgWST5xizKt9XIYqvHV7o8MpTJiODgKT4nRE1ZaimOqGvKbGvjMXNcl1?=
 =?us-ascii?Q?wWoi10YTQtlO3julbKVFYc4UREEqo81QA560CEDHx/bPhiMZVtEyWdqrGozA?=
 =?us-ascii?Q?/3ZD8k4bUUJh3R/vZORvV3C6GL8u3xh63K0FIMML57WHJRfEZUEiE057v4rG?=
 =?us-ascii?Q?lnvI6X9Bl/jtKJvUyUD06ACYFPOStz9tURxghmGxNWp08XacRP2BgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BY/ZKU5fFSx5ZioCjJlxq8AzQv8LF/f3F+5ZkjVg+XxbpkrxDoUfUoVernTy?=
 =?us-ascii?Q?3r5/I2ZgVKCqCkMisj6LX/3ameYShcgq0ZSKa6bS1Zm3+dKauY9zMrnioNNy?=
 =?us-ascii?Q?47WMQwJyB86DMY6Tjq/BtKyOo6g/3xY32eah6vhuMHxlf7+7w7BU40CJpqAH?=
 =?us-ascii?Q?8wviDQZMEfcfSrgLna2CvSKyEF8Q4V5fmGHe0OpbOQr1Jid0vKC3tBjFzEwQ?=
 =?us-ascii?Q?VZO23I/+HyMaAM9xts6kKoxqqvgW8RlI+yyVa8g7dEziMcpuzKPQjKdxwtO8?=
 =?us-ascii?Q?seMROM4H4AZ91vdDfUX+7YqHTvcYRknzQExlVwLVX3QoP8mfGe6Kf20GB+1i?=
 =?us-ascii?Q?PLxkfbaPmgb7s8VmSQNHeQ05A2QjlkGwlbmBYSPKclhA0dDzeOHPmYDgz01a?=
 =?us-ascii?Q?dzCKCTVJJIEeOchARZ/RTn/kb2DxYZUN07Q5iuaaG6zKG9YoYULUOUClRkIm?=
 =?us-ascii?Q?eaeT32CebFyZoI8j+oF08JMmcXsuNx+Myu3Jil4i2+b912lFKC77v19nMqKC?=
 =?us-ascii?Q?WgLsMftIZPB0slEMfFdO7q3qTKGAIIabvQsIHOvWgZmxjILX11aZ1gzDiONt?=
 =?us-ascii?Q?BlyDtChdBq++jhpyg/WW4QyqxBWkdJRAHVAKk5YnN8x9FxEKUrM/UOu/UD/y?=
 =?us-ascii?Q?+pirvJp0F44qfp/Vmfr0oB4jAOvsEP+xxzCDImDgPKPutgTg9bRFAAPqSjhj?=
 =?us-ascii?Q?Ouk4BHR4Q68/RZNNP1M5xozy4lwWrMzGDgGL2Z8wQ/RjZDbz6l6nVaH6rwUc?=
 =?us-ascii?Q?lOwAi/6oaVkWBNLGjCzAt1hsCHCBv3J5ixLdEB6x38T1QlXP7F7QaltpWCNt?=
 =?us-ascii?Q?VK7/0cciPhvdoz6/DKfShWDo0QuHNPSpArWZYpLN+dOcyS0hpQzUHU5HeLW7?=
 =?us-ascii?Q?Zd7i7yO1OA9PUEPY46uGhZWD85pHyZ4F7yjWYvo6OMKsiRK5+HutOTRV/1oP?=
 =?us-ascii?Q?kPNT3bTjDax0aOw+hAtcYhMaoOmxC8yuse5q2GdvS8+BhtgiNOm4xivnbdmq?=
 =?us-ascii?Q?lsHrcBpTljGb3l7ALw2snX+eXldIkCRAsGL5rgBpfvjWkIkDq++SRMdilyYT?=
 =?us-ascii?Q?cZe4s+1skfoGumdug0f4cNibjKajZWTZUJLGi790C2FEYaBzNYXQk65t4Cun?=
 =?us-ascii?Q?W22zCvNpQw3Fwn8quEc0jcY0AxaqlitClN8vflGOD9Fhs7nDcKrGo8ceOOcr?=
 =?us-ascii?Q?Mmtim8dJotyK+cVufbHvsrlUu2teMPpMwgxCmMLf4ofLR0dVpCT+iqfQUieM?=
 =?us-ascii?Q?eaGfakuOi0S3MFHL0aGxc6Dn5H+2W0OJ3VEAPSzqk25/vnzqG9UiyKXzJKSK?=
 =?us-ascii?Q?7KvfKpJZYNAYnxUNpSrbBHAULNtySekuNqCk7RVr3MQdFlHkIfsADll+Vm4P?=
 =?us-ascii?Q?kmUOIzKgoKsPj2UIiPJ+eS5+c0SWUaeoCJVqhkh6KAJRs7CNtGOmMdF7qrOZ?=
 =?us-ascii?Q?PmuM3z64TM2TpfMesYXiTitVY59FUxtO3lg28UGWyOqdzj6JnBcB2Yf9/+Cn?=
 =?us-ascii?Q?tPbeV9IWOf9yNK0WMDlJ99tezCPHn0ffudXQEaXIJhzKAMrTQxe7W3ivqwUU?=
 =?us-ascii?Q?h4z+HEHad7g9+JfAvilPUbbtp8insdhXbgjtNesw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c0a1b0-f1e9-4ef9-8bdb-08ddc50c9f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:33:35.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wgjpp7QfF2LxOWS/E4Gm7IZg+XNIUvADIZlziU9ZXH8JuE/YxcM+XiqUJH2iTDA0A49pxwMl/+nrnjr21ReUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6900


> In subject, capitalize "Fix" and drop period at end.
>=20
Okay.

> On Fri, Jun 20, 2025 at 09:32:35AM +0000, Wannes Bouwen (Nokia) wrote:
> >
> > [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address range check=
.
>=20
> Drop this.
>=20
Ok, will drop.

> > According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8),
> > non-prefetchable memory supports only 32-bit host bridge windows (both
> > base address as limit address).
>=20
> 7.5.1.3.8 is about PCI-to-PCI bridge windows, not host bridge windows.
>=20
How I understand it:
- Section 7.5.1.3 Type 1 Configuration Space Header is applicable for PCIe =
Switch and Root Ports. Logically a PCIe port acts as a PCI-PCI bridge.
- The term host bridge windows is indeed maybe not fully correct here. It h=
as to do with the limitation on the memory address / memory range in the PC=
Ie Switch / Root ports to 32 bits.
- The host bridge windows are used to configure the Type 1 Configuration Sp=
ace in the end.
 =20
> I'm confused about what's going on here.  The word "prefetch" doesn't eve=
n
> appear in PCIe r7.0, but historically, issue was that we have to be caref=
ul about
> putting a non-prefetchable BAR in a prefetchable window because a read
> (which might be a prefetch) in a non-prefetchable BAR is allowed to have =
side
> effects.
>=20
> But if we put a prefetchable BAR in a non-prefetchable window, nothing ba=
d
> happens other than performance might be bad.
>=20
> Are we trying to warn about a potential performance problem?  Or is there
> some functional problem here?
>=20
The warning here is just about the size of the 32 bit window in the Type 1 =
Configuration Space Header. It has in principle nothing to do with how we m=
ap the BARs on these windows.

> > In the kernel there is a check that prints a warning if a
> > non-prefetchable resource's size exceeds the 32-bit limit.
> >
> > The check currently checks the size of the resource, while actually
> > the check should be done on the PCIe end address of the
> > non-prefetchable window.
> >
> > Move the check to devm_of_pci_get_host_bridge_resources() where the
> > PCIe addresses are available and use the end address instead of the
> > size of the window.
>=20
> Are you seeing an issue here?  Can we include a dmesg snippet that illust=
rates
> it?
>=20
We see below warning because we define a 4 GiB non-prefetchable host bridge=
 window.

[  341.213850] armada8k-pcie f2620000.pcie: host bridge /cp0/pcie@f2620000 =
ranges:
[  341.213883] armada8k-pcie f2620000.pcie:      MEM 0x0400000000..0x04ffff=
ffff -> 0x0000000000
[  341.213894] armada8k-pcie f2620000.pcie:      MEM 0x0500000000..0x05ffff=
ffff -> 0x0100000000
[  341.213903] armada8k-pcie f2620000.pcie: Memory resource size exceeds ma=
x for 32 bits

> > Fixes: fede8526cc48 (PCI: of: Warn if non-prefetchable memory aperture
> > size is > 32-bit)
> > Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> > ---
> >
> > v4:
> >   - Update warning text
> >
> > v3:
> >   - Update subject and description + add changelog
> >
> > v2:
> >   - Use PCI address range instead of window size to check that window i=
s
> >     within a 32bit boundary.
> >
> > ---
> >  drivers/pci/of.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c index
> > 3579265f1198..16405985a53a 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -400,6 +400,13 @@ static int
> devm_of_pci_get_host_bridge_resources(struct device *dev,
> >                       *io_base =3D range.cpu_addr;
> >               } else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
> >                       res->flags &=3D ~IORESOURCE_MEM_64;
> > +
> > +                     if (!(res->flags & IORESOURCE_PREFETCH))
> > +                             if (upper_32_bits(range.pci_addr + range.=
size - 1))
> > +                                     dev_warn(dev,
> > +                                             "host bridge non-prefetch=
able window: pci range
> end address exceeds 32 bit boundary %pR"
> > +                                             " (pci address range [%#0=
12llx-%#012llx])\n",
> > +                                             res, range.pci_addr,
> > + range.pci_addr + range.size - 1);
>=20
> I gave you bad advice because I hadn't looked earlier in this function.
> devm_of_pci_get_host_bridge_resources() printed this
> earlier:
>=20
>   MEM  %#012llx..%#012llx -> %#012llx
>=20
> where the first part is basically the %pR information in a different form=
at and
> the last part is the bus address, and I think a warning here should look =
similar,
> e.g.,
>=20
>   dev_warn(dev, "Bus address %#012llx..%#012llx end is past 32-bit
> boundary\n",
>=20
I will update the warning.

> >               }
> >
> >               pci_add_resource_offset(resources, res, res->start -
> > range.pci_addr); @@ -622,10 +629,6 @@ static int
> pci_parse_request_of_pci_ranges(struct device *dev,
> >               case IORESOURCE_MEM:
> >                       res_valid |=3D !(res->flags &
> > IORESOURCE_PREFETCH);
> >
> > -                     if (!(res->flags & IORESOURCE_PREFETCH))
> > -                             if (upper_32_bits(resource_size(res)))
> > -                                     dev_warn(dev, "Memory resource si=
ze exceeds max for
> 32 bits\n");
> > -
> >                       break;
> >               }
> >       }
> > --
> > 2.43.5

