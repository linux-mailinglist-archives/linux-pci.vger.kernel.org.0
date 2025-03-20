Return-Path: <linux-pci+bounces-24196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A0A69E6C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE218902A3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260652F5E;
	Thu, 20 Mar 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="eFeLCMeW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F041CAA8A;
	Thu, 20 Mar 2025 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438662; cv=fail; b=P7hu0PVBld7NyQXEK3LLXTYZ0GKuK13BKmwgE6qkT+ChJfJEpE5tiwGh/G/9X4zYUMmaktpdeEcueRcuVd3CAehDaVctuZQbcC5e4V/vJKtSdjS6jaS4aEJifVR++fan78Thv7HXcfe85zFfJzPsgJYFw/Hoz/T8G9S2sLyYiM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438662; c=relaxed/simple;
	bh=0FuwfgQVX1gc9uLtVLEZzs+QDzMMUEt9lR69KPcnYks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sIu7iWS2u0PlDvSokPiiLm2WrRH0kVqccqpzt8ZEw6GAA03/iPaCp8/DQ+XXJvVgSVlIvhubMROSxRCiMd8v5RR9lZ2uWGvEU1yKdYnSzlH/n7E6pD4al09A/fk0t8FBdsenwH8BwXVl2+RLrraimJRWRfE0XBzliaofYv/bJOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=eFeLCMeW; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gki9D7lrXGTZpMKMHvc8OfJgTfl6L316nBJ539zoL6976RoUBx8tWdSRP2MoMrneIFy2PGKZnsvTgaCgIpcTE3g+a+XSPtC2szrXQNxngFeaO6FQM7RsrHIAcjbFkURAb0hr8IoTXmeRl3U2SK5LyybgFF6yOlcAT+mJygaELQVJ6V9KJCUWVWo8WswJbwipUrtaOJ0/EbVUF1R7wRvSMbdQBxTexQyKLrSYDb6lK5Q299MRCWKA+VnBcEsa4dCk2MdmloeHUFcjAYqM8tKSNvl4C+ZiGnu6dl6ybcacQ+lipX5qpOTWe8TsY19A5PayXQCQDJo1z520gEsnLjt63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayNvYunQCDVZL2QbFcQ1eC5pP/qtmyXg0CEIzpr7vUo=;
 b=TM4DDS3CMVk9jrYyISxlGcKg4sfEz2Rlc9TrUUeBEYgdjVqAgJSGxQLapd+fj7zAWW4DUBzj/dT/9CC6OIFvdrDNV5Hxq0DiDcB7qiktiZSs08zrvwIbCSDSJ9/5ArvTVpqeObnfrBaH49hR5wcBQuIXZOCH7shaYWgTvQL4JwWq1GV9VKRvh+JwW1SLC15sH5nysK7o76xdKse9MUFhUSeZ7I4lijH6/2FJsHczYa2UqrMSDevCf9BIrUE2fRrJbTt8tHiK5dVcCIHVxxqM/xayjQv7ATmA26PdvYo3YCI7+HC0D3tDOpPm9Fg0kSfSmnlrs7DcpFmflzOqDpJe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayNvYunQCDVZL2QbFcQ1eC5pP/qtmyXg0CEIzpr7vUo=;
 b=eFeLCMeWlsBD9cHp4U2P5mfI+G3KQtuldjX58+OzytuX7iswwC0ZjUERHE3Oqxn2BaUPj6KWkenZjo0p0H+MvgPOT35GXNlsL+6c++qeliKavmUosPHG+NVcXGb6xtb63aWopAspTyCqShPcQKT4hSMH2Ib3ILw8c36Uaa+JtmA=
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by SN4PR19MB5373.namprd19.prod.outlook.com (2603:10b6:806:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:44:16 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:44:16 +0000
From: Lei Chuan Hua <lchuanhua@maxlinear.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Thread-Topic: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Thread-Index:
 AQHbjfEyD/mpI4A5j0GKiUa0Y1kJFLN3sKUAgACC+EyAAOY6AIAA8srAgADgEACAAHpu0A==
Date: Thu, 20 Mar 2025 02:44:15 +0000
Message-ID:
 <BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR19MB5076.namprd19.prod.outlook.com>
References:
 <BY3PR19MB5076ADD0AC135D455D10B5CEBDD92@BY3PR19MB5076.namprd19.prod.outlook.com>
 <20250319192244.GA1053712@bhelgaas>
In-Reply-To: <20250319192244.GA1053712@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|SN4PR19MB5373:EE_
x-ms-office365-filtering-correlation-id: 7ce7de5f-b0d2-4c27-38ed-08dd67591aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?6CKR7oHP62Fn4gkTZGLjlah+b/V2M6qxifJBmeum/NverrmAw96rzT7Bzm?=
 =?iso-8859-2?Q?DnytyXR23nuM1mLTGHmh5QS6qPmAXrtYi15qRaPtzVcZsiwGvPmPbF59Ez?=
 =?iso-8859-2?Q?M+tmYTaYEOaSeUI0ozad6RAkFCiyZWEIuWVfn4UEAqSuW/lGF7lin9oZcw?=
 =?iso-8859-2?Q?BK8rWDhvKT2EK4ruC1+DEUKnMAELdQaOHWottaLUcLenn8wvRLiBwxg2vL?=
 =?iso-8859-2?Q?fhoKjQB2JvycdkMnjfTTJ+yveC92g1bufeIUA8A3kW3fd/bD3xyzTafxQL?=
 =?iso-8859-2?Q?tBB0ikbwNNOWqeZBzKIaajpSxAzTePaK1tBIXC4Lt0dNgX44BrJOHmKcBf?=
 =?iso-8859-2?Q?8kZ25AX5MwN0K6+9YWx/7t0FBzGLJ0HDLnuThqChlgH3TFi2exchwCDbbX?=
 =?iso-8859-2?Q?6QEA8VUZSiBueYmcvyDJebtPWnsww1C4Cw2ON9HQmqtkan9KNTGDVlX3WG?=
 =?iso-8859-2?Q?rTYeAg8CMP6p1oVIAHPdczwE4I9LHxqYBu2IpWfQGP4cMm52WXL/3/VcKR?=
 =?iso-8859-2?Q?8LgN1EYuQUewGMm38xJN1jy8Zw4PJMDxeQFObrOjmhOw+cQffRDQnz3ViK?=
 =?iso-8859-2?Q?xrUcjOyCFR4GIGOVwIBm6t92LrDs/6zDv8yqDl4IRuna3+LkH38lvxyy3h?=
 =?iso-8859-2?Q?84AbHzT7WOzk/UfHVEpdnM3WGXqzarNGi4g6wykAFbIJMuUBGVhK7VRPvK?=
 =?iso-8859-2?Q?awInji7abUJY0xRx4QnIFOl2c8JTuZo8TJT0pf0EZtV//w4egRVSjUH7hO?=
 =?iso-8859-2?Q?s364/okQWoT7Xahq4nf0N9iHfeopBX+HpwlftrvDsKZ9TGQXy4aYWDvlV3?=
 =?iso-8859-2?Q?05BQ+H+q3rjSPDMwHIWzbLyg20Uy5Y7RCrR9JgNzGIElz5fuPINH4NwhpU?=
 =?iso-8859-2?Q?sXBOpersTx+XLYTMZ0j6LduF0RC2VgaHPbwDmvuGZToIBMFvXsuOoHqoyr?=
 =?iso-8859-2?Q?8R7BQ3yOrOs4Bwmv86HgthmSiJOOXTvoXjyDbPuUKtI3npK0NHMPTuxmqI?=
 =?iso-8859-2?Q?I4tCoq67CCMe80nDqBRFjQrgN12KdslctdUfpNPhUnNI8XItCXpC1TihE+?=
 =?iso-8859-2?Q?tI0bh2hayZSqeKx2URwiYE5OW1haOn/6JuVrmYCYYG3ZedInn5GwqY1rTz?=
 =?iso-8859-2?Q?rTu/6F0msO879WlQ216Uffji401aAiz4USat2elK50FoU6Ohb4Th8MXcQj?=
 =?iso-8859-2?Q?GbBKUi9v0yRkjinYq2r0nWq+iyN73zvYlXv67IPfI03kD0CHNewxNAogFR?=
 =?iso-8859-2?Q?eGWnKFYHn9QuNtZ8aHob2cejXLp7oo99MJEMoVS/7jr+wSl9vdHsua2EQg?=
 =?iso-8859-2?Q?f6rf+gWm217dYzPLgU8T7eO+qHGZAf6cwaOoEyNU4l/5j9RiG5VPPPhRfJ?=
 =?iso-8859-2?Q?/Zrb49QluB4BPTjFpykZ1Cu6gMW860k+++D7gNPVwolFTaaTnJ6rO1zrLJ?=
 =?iso-8859-2?Q?MEj5WYPb/v1bB7EuI0bOMAgTPwJtWgzH5bSS3w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?7s/w8P5axzgTUJMbbfyGE+ICgu21Cj7YEbARhN9q196cS2AfHg5jTzwIvk?=
 =?iso-8859-2?Q?xI/tOHElTkJ2enJyIBBc4F+dcViinkXtjVtyuEfGAexP+eenyg+Beq/LjG?=
 =?iso-8859-2?Q?+tRNW65Aid/IZ2TroE4OtLvZNSTodNFmskiwc5hdAVqE/GFusUtiFo5xJq?=
 =?iso-8859-2?Q?4pX/zPh6U20o4gXOhUYwGM/woGqzRjyptKBOR164rDpDOtQFp5mZOx7oyw?=
 =?iso-8859-2?Q?KFpP5rbcCGgQm1OeGsod5ZUvsCVkVtyKflcvedqF1UMKHO9EWAKiIhpuim?=
 =?iso-8859-2?Q?Qd2MchpOomfGart3pOXT59Ub4Lb+B7XbY3LSuMrx8/Ut4I37cSKzdQPdaW?=
 =?iso-8859-2?Q?0x/BDVVrtIWA+PB86gx4wHgrbeuFhA4Cdwssmw4Rm1aZPk+JHalFyXxMx6?=
 =?iso-8859-2?Q?m0O2XYKaF8/ZyX2NUthldb+JrUaTafuU/7Hv6+13ImLIX1/FPXyl+ZaMIo?=
 =?iso-8859-2?Q?gJzzqKXklcEvVPsKVTzxm9SuPeLS8Yz9Z5tiH6p8mAx217OLYWLHXXqJNi?=
 =?iso-8859-2?Q?H4zWsKT0/q7hKXkpJFGEJdgbzRFbqFaed89IYGLvK76/TajM31w0m5wCrv?=
 =?iso-8859-2?Q?r/XSMtQ4ZSnFrMebo9lvjzbYH2xuUsEU7gzMmfzrLJnEXO8bmaXq0rJj/T?=
 =?iso-8859-2?Q?tjWgKtJW+HmKemsRdQfuCiEaTikJtCTNqkKIojDNs5P6B9+YcQywlhSYjo?=
 =?iso-8859-2?Q?wak4Hf1TV2G0J2kM335wfvzrYjtu5nDBxw8GSH19a2x/XGQS2hy3IJSLsZ?=
 =?iso-8859-2?Q?4qg/sA8AobK1+O4WR5pRYTdUOZmN1ymn27ihZXN+dKga3B+ijryNMel7xa?=
 =?iso-8859-2?Q?DojQayLqjEF3OAJOHr2NmHBD6QHL/5wFX3m7fFQA0eiudWcrWRf2iUOP8Z?=
 =?iso-8859-2?Q?aZm2t1WSoinNy7PSSlp9pHbyu/HN8JYuRLbopzgF63Df2jH3P/3nTT9uac?=
 =?iso-8859-2?Q?vLicQAzvJARsyljshNPZ0eHKsjOFiriol6a1COGyRi034OdRmphssyp+97?=
 =?iso-8859-2?Q?tPNxlAYzYeeeTNxGpTQNU8+HhYsFNCIHeey3a6DTX0b92gnT0Cm+jD1gbh?=
 =?iso-8859-2?Q?krnULePnAH/4FgWTFamgYNbnD7ro4CmuXUbyBSCHuYQDYExotNUENuTfRf?=
 =?iso-8859-2?Q?VNDfPPpQ0vtu0jtbOWrgJSQLmgBO6kU9ayEvw/oUUk5AZffvHc7FcK0mL7?=
 =?iso-8859-2?Q?Fdts/DchvrSfNBTNQLZwD0gukhlZqhgJUmEXnKs7BIsZIlsbx5iVB/5Tda?=
 =?iso-8859-2?Q?luggc/Yb5fEssJzYUtTP8i46hLDXLpST0qyUvx7fa8nij/s52RMWvLXr1c?=
 =?iso-8859-2?Q?ZaRtO7iolU+Tyq2Hbm3OwksGG9SBpvOs58zS0zSSgBJjj3yKPPJjWKGIL+?=
 =?iso-8859-2?Q?4t0vKU8G0+LEHdUfalEYBLsY/D+Y9UxccQg5SRY2Ke+MJbCTMHOqXcLH6W?=
 =?iso-8859-2?Q?oIUqjwwDuSnoHiMvPwJ38Xg9TDnmT4LoeWZJVDmIso7jk6F2/kyLAk+0Dp?=
 =?iso-8859-2?Q?6jWACDrA0OJqdF4qSSQxBJsvS2XmD1G1tKOa9CKdXf/vworeIfREcG8d1i?=
 =?iso-8859-2?Q?MN9LxN81T44XyvvAK28LQMNp5VfwudXj2kQJ2mV+PEGWOoTMuM4bBG7P3E?=
 =?iso-8859-2?Q?CewPDhK8TMl2bHl2QmwP4xLvdmhbOqRUw9?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB5076.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce7de5f-b0d2-4c27-38ed-08dd67591aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 02:44:15.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZVZXXQQ6VLioHLgRKiiiT+WyoyTUlB/U66hQEhzfOX41lKsOT7vPpCo5osU4nl0zPny7yGIgjgruFkKqPnVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5373



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, 20 March 2025 3:23 am
> To: Lei Chuan Hua <lchuanhua@maxlinear.com>
> Cc: Frank Li <Frank.Li@nxp.com>; Lorenzo Pieralisi
> <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Manivanna=
n
> Sadhasivam <manivannan.sadhasivam@linaro.org>; Rob Herring
> <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> =20
>=20
> On Wed, Mar 19, 2025 at 06:10:57AM +0000, Lei Chuan Hua wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Tuesday, 18 March 2025 11:32 pm
> > > To: Lei Chuan Hua <lchuanhua@maxlinear.com>
> > > Cc: Frank Li <Frank.Li@nxp.com>; Lorenzo Pieralisi
> > > <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>;
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Rob
> > > Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > > linux- pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> > > use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> > >
> > > This email was sent from outside of MaxLinear.
> > >
> > > On Tue, Mar 18, 2025 at 01:49:46AM +0000, Lei Chuan Hua wrote:
> > > > Hi Bjorn,
> > > >
> > > > I did a quick test with necessary change in dts. It worked, please
> > > > move on.
> > >
> > > What does this mean?  By "move on", do you mean that I should merge
> > > the patch below (the removal of intel_pcie_cpu_addr())?
> >
> >   I mean you can merge the patch with removal of intel_pcie_cpu_addr()
> >
> > > I do not want to merge a change that will break any existing
> > > intel-gw platform.  When you say "with necessary change in dts", it
> > > makes me think the removal of intel_pcie_cpu_addr() forces a change
> > > to dts, which would not be acceptable.  We can't force users to
> > > upgrade the dts just to run a newer kernel.
> >
> >   Actually, intel_pcie_cpu_addr() did the address translation, so in
> our case,
> >   Dts has to adapt to this change.
> >
> > > I assume 250318 linux-next, which includes Frank's v12 series,
> > > should work with no change to dts required.  (It would be awesome if
> > > you can verify that.)
> >
> >   I will try 250318 linux-next and let you know the result once it is
> done.
> >
> > > If you apply this patch to remove intel_pcie_cpu_addr() on top of
> > > 250318 linux-next, does it still work with no changes to dts?
> >
> >   I think we need to adapt dts change. Even this series patch has dts
> >   adaption part.
> >
> > > If you have to make a dts change for it to work after removing
> > > intel_pcie_cpu_addr(), then we have a problem.
> >
> >   We can update the dts yaml file.
> >
> > > I do not see a .dts file in the upstream tree that contains
> > > "intel,lgm- pcie", so I don't know what the .dts contains or how it
> is distributed.
> > >
> > > I do see the binding at
> > > Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml,
> > > but the example there does not include anything about address
> > > translation between the CPU and the PCI controller, so my guess is
> > > that there are .dts files in the field that will not work if we
> > > remove intel_pcie_cpu_addr().
> >
> >   This driver is for x86 atom platform, no upstream dts file even in
> >   arch/x86/boot Since upstream x86 platforms use acpi, even several
> >   platforms use dts, but never create dts directory in
> >   arch/x86/boot.
> >
> >   As I mentioned earlier, dts needs a minor change.
>=20
> If there are end users that have a dts that must be changed before
> intel_pcie_cpu_addr() can be removed, we can't remove it because we
> can't force those users to upgrade their dts.
>=20
> If this driver is only used internally to Intel, or if the hardware has
> never been shipped to end users, it's OK to remove
> intel_pcie_cpu_addr() and assume those internal users will update dts.

This driver is only used for internally to Maxlinear. Internal users will u=
pdate dts
Accordingly. Anyway, we will take linux-next-20250318 to run the test with =
dts adaptation
Internally on the hardware board.
>=20
> > > > ________________________________________
> > > > From: Bjorn Helgaas <mailto:helgaas@kernel.org>
> > > > Sent: Tuesday, March 18, 2025 1:59 AM
> > > > To: Frank Li <mailto:Frank.Li@nxp.com>
> > > > Cc: Lei Chuan Hua <mailto:lchuanhua@maxlinear.com>; Lorenzo
> > > > Pieralisi <mailto:lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski
> > > > <mailto:kw@linux.com>; Manivannan Sadhasivam
> > > > <mailto:manivannan.sadhasivam@linaro.org>; Rob Herring
> > > > <mailto:robh@kernel.org>; Bjorn Helgaas
> > > > <mailto:bhelgaas@google.com>; mailto:linux-pci@vger.kernel.org
> > > > <mailto:linux-pci@vger.kernel.org>;
> > > > mailto:linux-kernel@vger.kernel.org
> > > > <mailto:linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> > > > use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> > > >
> > > >
> > > >
> > > > On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> > > > > Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should
> > > > > provide correct address translation. Set use_parent_dt_ranges to
> > > > > allow the DWC core driver to fetch address translation from the
> > > device tree.
> > > > >
> > > > > Signed-off-by: Frank Li <mailto:Frank.Li@nxp.com>
> > > >
> > > > Any update on this, Chuanhua?
> > > >
> > > > I plan to merge v12 of Frank's series [1] for v6.15.  We need to
> > > > know ASAP if that would break intel-gw.
> > > >
> > > > If we knew that it was safe to also apply this patch to remove
> > > > intel_pcie_cpu_addr(), that would be even better.
> > > >
> > > > I will plan to apply the patch below on top of Frank's series [1]
> > > > for
> > > > v6.15 unless I hear that it would break something.
> > > >
> > > > Bjorn
> > > >
> > > > [1]
> > > > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > lore%2F&data=3D05%7C02%7Clchuanhua%40maxlinear.com%7C1c7a4180ddc340=
f
> > > > 2399308dd671b6e6a%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638
> > > > 780089712963723%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIl
> > > > YiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D
> > > > %7C0%7C%7C%7C&sdata=3DESUTIdyb342xMYwUhzwj%2BXsKoNQzth86rV3dfis5dn0=
%
> > > > 3D&reserved=3D0
> > > > .kernel.org%2Fr%2F20250315201548.858189-1-helgaas%40kernel.org&dat
> > > > a=3D05
> > > > %7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5741bbd37508dd663201
> > > > 00%7
> > > > Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638779087153570342%7CU
> > > > nkno
> > > > wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO
> > > > iJXa
> > > > W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DaIuZWz=
w
> > > > Fy2r
> > > > rzsJ5KfbxWKMx%2BPn1WHx2KvpSR0nxsl8%3D&reserved=3D0
> > > >
> > > > > ---
> > > > > This patches basic on
> > > > > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Flo%2F&data=3D05%7C02%7Clchuanhua%40maxlinear.com%7C1c7a4180ddc3=
4
> > > > > 0f2399308dd671b6e6a%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7
> > > > > C638780089712987168%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> > > > > dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > > > > fQ%3D%3D%7C0%7C%7C%7C&sdata=3DPguxNdlqlw4e%2FqmgY4aM67UarmNDwx7RC=
V
> > > > > 69x0myXJc%3D&reserved=3D0
> > > > > re.kernel.org%2Fimx%2F20250128-pci_fixup_addr-v9-0-3c4bb506f665%
> > > > > 40nx
> > > > > p.com%2F&data=3D05%7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5=
7
> > > > > 41bb
> > > > > d37508dd66320100%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C63
> > > > > 8779
> > > > > 087153596851%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlY
> > > > > iOiI
> > > > > wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> > > > > 0%7C
> > > > > %7C%7C&sdata=3Dmht19VSB24Znpvtz1pOlmtHYec%2BDBDH70zuLOZmwlSI%3D&r=
e
> > > > > serv
> > > > > ed=3D0
> > > > >
> > > > > I have not hardware to test and there are not intel,lgm-pcie in
> > > > > kernel tree.
> > > > >
> > > > > Your dts should correct reflect hardware behavor, ref:
> > > > > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Flo%2F&data=3D05%7C02%7Clchuanhua%40maxlinear.com%7C1c7a4180ddc3=
4
> > > > > 0f2399308dd671b6e6a%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7
> > > > > C638780089713001616%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> > > > > dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > > > > fQ%3D%3D%7C0%7C%7C%7C&sdata=3DDyXeezC8qsW2cdRg37sKVq2AH82vCV7L7YJ=
%
> > > > > 2FtgH6jU0%3D&reserved=3D0
> > > > > re.kernel.org%2Flinux-pci%2FZ8huvkENIBxyPKJv%40axis.com%2FT%2F%2
> > > > > 3mb7
> > > > > ae78c3a22324b37567d24ecc1c810c1b3f55c5&data=3D05%7C02%7Clchuanhua=
%
> > > > > 40ma
> > > > > xlinear.com%7C1612d73ded5741bbd37508dd66320100%7Cdac2800513e041b
> > > > > 8828
> > > > > 07663835f2b1d%7C0%7C0%7C638779087153612764%7CUnknown%7CTWFpbGZsb
> > > > > 3d8e
> > > > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> > > > > joiT
> > > > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DDUsGCW%2FZpvx4whLteo=
I
> > > > > jYqw
> > > > > d6oOk9rXks%2BV40i5sovI%3D&reserved=3D0
> > > > >
> > > > > According to your intel_pcie_cpu_addr_fixup()
> > > > >
> > > > > Basically, config space/io/mem space need minus SZ_256. parent
> > > > > bus range convert it to original value.
> > > > >
> > > > > Look for driver owner, who help test this and start move forward
> > > > > to remove
> > > > > cpu_addr_fixup() work.
> > > > > ---
> > > > > Frank Li <mailto:Frank.Li@nxp.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > > index 9b53b8f6f268e..c21906eced618 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > > > @@ -57,7 +57,6 @@
> > > > >       PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> > > > >       PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> > > > >
> > > > > -#define BUS_IATU_OFFSET                      SZ_256M
> > > > >  #define RESET_INTERVAL_MS            100
> > > > >
> > > > >  struct intel_pcie {
> > > > > @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct
> > > > > dw_pcie_rp
> > > *pp)
> > > > >       return intel_pcie_host_setup(pcie);  }
> > > > >
> > > > > -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64
> > > > > cpu_addr) -{
> > > > > -     return cpu_addr + BUS_IATU_OFFSET;
> > > > > -}
> > > > > -
> > > > >  static const struct dw_pcie_ops intel_pcie_ops =3D {
> > > > > -     .cpu_addr_fixup =3D intel_pcie_cpu_addr,
> > > > >  };
> > > > >
> > > > >  static const struct dw_pcie_host_ops intel_pcie_dw_ops =3D { @@
> > > > > -409,6 +402,7 @@ static int intel_pcie_probe(struct
> > > > > platform_device
> > > *pdev)
> > > > >       platform_set_drvdata(pdev, pcie);
> > > > >       pci =3D &pcie->pci;
> > > > >       pci->dev =3D dev;
> > > > > +     pci->use_parent_dt_ranges =3D true;
> > > > >       pp =3D &pci->pp;
> > > > >
> > > > >       ret =3D intel_pcie_get_resources(pdev);
> > > > >
> > > > > ---
> > > > > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > > > > change-id: 20250305-intel-7c25bfb498b1
> > > > >
> > > > > Best regards,
> > > > >

