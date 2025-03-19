Return-Path: <linux-pci+bounces-24069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85703A684D0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 07:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB86019C3C7F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C31C173F;
	Wed, 19 Mar 2025 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="B9MI43sB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CD22094;
	Wed, 19 Mar 2025 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364665; cv=fail; b=Z/KLUo12SabGTNuTDs5fqF/8Rmq09K189UKN7O79ZAewD2sjxfiW4NuSlVyOrnWV+qvdehwHW59pPLNSMRR89PIu2BnvczZIcdQO314QrpZ4vkZGXkJ/CHYnw5DLgmh7VnVkUFPzWSo2opfY0I+Q6xWlouXqDeJFbkqnLQ/eE7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364665; c=relaxed/simple;
	bh=kbYCulGhanf9SrGA+R87spy83HHU5w8qtzcDDhSLr6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ql4AG0ldpZFWwVVYYV5otDW8WN3c//nVlR64fSp0WF9gPizuUp7XpuXnIWqpH1IHhHgSc7U7Q/2vq8vnsQtC4QilqeEfRCKNVxI//bSAE/JDwQ5IQuXDL6ep0a+Z3gk4bzLrqBQQFovtx/WWEU6MNfTvs4IvohB5mHyQCAnpriQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=B9MI43sB; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiZsP7iG5ZrggZiWagVUnv8cwFAm5hNMlZ9qCqO/VCn0Wd+E8dTDE09Sl4TwBXXdWWPkFLzO4Mh3jD9fzSuc2u/c00aph8dY4N9qn3TN5z/B+aqF1f1Iyh/D9edyXK2tB1RheQtKmDz1d6wp4PFYC773QgeF/SZTclb1vCn5WnlI0j32aszTnzob1ZAl9y55RRi2GRsOeWZwi87ZzWvaTlLvjGAjUv4+gWQU6Cr/rgJwbVhRixL0VAxzpok3pZDeXjoLxPzZt1koEcNA1NvyWFJ7EprWySz+O/ND7GeZEBI0y1KnBQry68hfML+jm6zXwUQnpzspD5eX4V3FERHjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I0qg5+qwME5a4Psb13IBS+fLMviSGN88NLji7KMOMQ=;
 b=AMCs8xBCn/BPBxB7sAblgHAcMoqMDTli72npJ01ihYA3q7EmVzqeYy48fcm7gVbAbzU8XhlNaPBSZaazHlO2+R8fP3SgZh+Zgoh9IMjvVh6bQH0VtEBk6OmO76UrLYlw+sXpaCDZ2WBbOUh/YvRcUGoNmUuVMa+L7jtPuB34HQyUZqBB9EwYeVBHz1pb1Vo+J1MzP446MR6YWYdeHzAF69YEsZQDL7LkabG482sMyJyOaQGrfeCYBcVQiSlPk77ugKwJDLRmwboM2iSsRW0DzzMbbRzjNtBuQlxPWNjL+iGxBbhdzSc7m+DWOpa3Tjr8GkoKaFExDiaw+y9hP2Xvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I0qg5+qwME5a4Psb13IBS+fLMviSGN88NLji7KMOMQ=;
 b=B9MI43sBPZJcKq1kJ5qAdnyHAvdxZBPvzeUTOCEoYpkOYISaw1Zde7YAwuYLUjtoULdiIzzBtGGlVV6AALH/kSLeJ801chV4RL/mh3/OTxHbLwFANDLuzmWsnFq/3JafKVQxG837Bm4xyEKoyNDPfXXjnk8JJlVT7HTwdjOlBng=
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by DM3PPF7D238A036.namprd19.prod.outlook.com (2603:10b6:f:fc00::73e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:10:58 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:10:57 +0000
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
Thread-Index: AQHbjfEyD/mpI4A5j0GKiUa0Y1kJFLN3sKUAgACC+EyAAOY6AIAA8srA
Date: Wed, 19 Mar 2025 06:10:57 +0000
Message-ID:
 <BY3PR19MB5076ADD0AC135D455D10B5CEBDD92@BY3PR19MB5076.namprd19.prod.outlook.com>
References:
 <BY3PR19MB5076A8D664FAA83E7C168300BDDE2@BY3PR19MB5076.namprd19.prod.outlook.com>
 <20250318153148.GA1000275@bhelgaas>
In-Reply-To: <20250318153148.GA1000275@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|DM3PPF7D238A036:EE_
x-ms-office365-filtering-correlation-id: 77707552-190a-4700-2244-08dd66acd098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?lxyPafCrtfmnAJwGCRCeULkPwhYL5o76zPzt7hShJlcNlknqLPU7kEzffJ?=
 =?iso-8859-2?Q?Ie8PzNuGwsIQPhQBkyb+44CwVqfGjOcNmqXe0cZgk33X4Mnb1zzecMHkMn?=
 =?iso-8859-2?Q?gio3qTv2II+BVl7gmNblBFesF38u/xrv1YAWc+ZriajY7xtbCKcC7S4ewB?=
 =?iso-8859-2?Q?1xh+dVZLcwSdH6jspBT4v//XllV1aL/ZzaGVJ+rQWgyhCFhnBYjcrAkWs3?=
 =?iso-8859-2?Q?nFPg5YbebhajNhHRgIawDa5U/1th+b+Kfl4Z6Ltq/rcIOvhN0KrBk3hd+z?=
 =?iso-8859-2?Q?MrHFROoV32+6yni4m8eIL8I1wMnEEGH8tsBWUTAJtHV+rc65SU0nG91cAk?=
 =?iso-8859-2?Q?KebEuD/hwH1r/qlEUnAdPsa86F5ORAsidaBrGT5Mz1qSOe9DV+Quip+Vnt?=
 =?iso-8859-2?Q?7ju6nTT/LyZmstWMkRX6HzWTJFVLXoAujzM7GjVDvDZtkMt2KvlOrKz+T9?=
 =?iso-8859-2?Q?CJo2DCq8P0NQFaodbSuOM6BkjjyRUuoOJEbySdblJpwrMhPsXrigAXz1qa?=
 =?iso-8859-2?Q?17/4ZZFIWa5XTjD0JTtufhZ/y4A7Ev51yJMS+syeBZsP/kDK9dJIl2L5DE?=
 =?iso-8859-2?Q?0G39o9kLcr98D64mmm1Oe3dtZAJBmVA2U34kJRaQI4hKBk74Zg9AzQYv3p?=
 =?iso-8859-2?Q?Li4GDmqy3g0yD2MkAswnkEjyIO7k7ZsmMiaouWBdzWPZswLvc7nrU9qxfh?=
 =?iso-8859-2?Q?9EwG6gYm7xK3ABEaRSsOjQseSkfTvME7L9AhjnucP3CiyGPoTtnPkljTXA?=
 =?iso-8859-2?Q?XwPD3pHo9nzTi4xftTOekWbXndBT+l5YWRGaBQLANqMh2mlKlHPFBX0+nA?=
 =?iso-8859-2?Q?s69mR4T9tx/qxV0S0REj+Hsxh6MrfBqarDjC/tXdnJ88XCXzqEEclg1znJ?=
 =?iso-8859-2?Q?FIC9BGzwyUqM3zqQssxEvN8G/S5H0tBF26AgVIz9YYzqXYpF9BAlHnNBtQ?=
 =?iso-8859-2?Q?GH5IfcDodidKIeRXUr1RoMp3o3A4GxDP8MRj1hp6quS7vaQ5fkCQ/x6mV1?=
 =?iso-8859-2?Q?wAYxozKjDGIvKEqrzrYmpojklulMgoBCyjyx95DgdhngXaPuxx7hb+JTbT?=
 =?iso-8859-2?Q?mlm3Bz/6ioBVzj4FOVfhQWr3LyyWfhPn/Hd2SNDkxFdHbDhjunGAR0jsA0?=
 =?iso-8859-2?Q?HRyhZ0DeCxdlKRWwuGJFCvTRm86Hov1fPQTs7qeOdeEPK5TVYc36MG7mWQ?=
 =?iso-8859-2?Q?maHAmrOB6NPdBc7T63/EG0Icp2ICZSfnbFv8ulMZHe+HTZcHXF/dq2FJIz?=
 =?iso-8859-2?Q?cxdbOA3sxhBdlqWBlFcYf5kdnsMh73RYMhY0uVoUtAEmf4BIQzxCs3WfQs?=
 =?iso-8859-2?Q?dmxDy/X0hdDoDcJ5NSZFFDJIG05VQ0uC1KX/i6Je2O8pvG5rX/vxpPlrhh?=
 =?iso-8859-2?Q?fpdem6O3RoFeGcJU1JZzz3lzHYRy9x4NyB9DlFkxj3WYuMFzFqz3laXEJe?=
 =?iso-8859-2?Q?AQkYTsZ32Se9qKJVsXRKjqmjxN4c+N6IbevxlENgQoMBdIbkRfBqQlwUbs?=
 =?iso-8859-2?Q?CGeJVhWwyvbgboBMI4SdBx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?SYLac1C7UQfMQuFx+VV0szrOX4sQ7O9q99E9MLxpZj+cXccJ9dGMfrx+mx?=
 =?iso-8859-2?Q?9f0ISN3ZoFtvSOyPyc1X380Mdg15GV5POPUSHNxk4BIMpbB+FwcxqdHnR7?=
 =?iso-8859-2?Q?v3s2qbAVFoR9mYEzmF11ogLk4JO0hq/wB/j2Fh7vUtIifdmrYe+FuXOn19?=
 =?iso-8859-2?Q?UVDabDN9fq4gXwnMZlyvGuVSh3Zh6sZ4JANTuYV3ZcYLnMS4HTdDA93jYU?=
 =?iso-8859-2?Q?2yNWacdzYroBl0fP1CIrHe2go70skAQo52A/a9Ftz3gOfJqu5NsmjvqRfQ?=
 =?iso-8859-2?Q?kgY8Wcnwb00ZmKmG8yyFrKDprqi1uAPPgNr3cy/LeK6dIIit/uQrPAW1Nl?=
 =?iso-8859-2?Q?jZDhVdTCeyIDcTIjjR66kT1mPjQFTq99qyh62KOjZXl8fo89GOm/2Lceos?=
 =?iso-8859-2?Q?a3J8Bg1NzOkpDn/IhDBsknSibvxpfUOWtSD6ZKMX3ERRaREzsetaFQNWUu?=
 =?iso-8859-2?Q?1UicBEHsQjXcrVagXh3LraCBFep6dY1zVUY2vK4nU9vT5CopEHylTlNs0b?=
 =?iso-8859-2?Q?a9KEpp1COGxczPUSQxbFtOvlpF7ZfjZr4OF3G7EBTXfSBHrlVie/8Rer1M?=
 =?iso-8859-2?Q?yblxCVW1jPmyBIx4Vax1qs6hsbs/cXjYB/VFJo7FjpoUsl6xqvw/rOfqX5?=
 =?iso-8859-2?Q?eiTfcFdgdh+Oo5ZK4PJN3yz0O+zUcoipSq0pIPBdn/6NKe6Nv6MhcGYkoP?=
 =?iso-8859-2?Q?D71aXFdlzgVXfqQ+8csWDoFhZhPVPAlBt1JULhhsox3igZmVSkpUonZL3F?=
 =?iso-8859-2?Q?X2m7UWmtTfoWVWH8R/t68y+Dg+D5HfqRI18QXSWRRBYdnZJ1WHwTQDWFwY?=
 =?iso-8859-2?Q?XYfUaw/W/gxtz4oBAiAa4ChR//5+3U46vdIBrKfVzEOWxqT6Ab98o87oNm?=
 =?iso-8859-2?Q?aZblBDWU20IrP/PoFNrgVc3aIsh3DoEQ3zRAgXn2vJ0lv1JF6DMS96MioU?=
 =?iso-8859-2?Q?LP7NoR6zJTi2CF65c7JLOuOktwSCP2f+NIrNnCyVd5rnooKyMSU6lZvfxC?=
 =?iso-8859-2?Q?KWZAhwCOTRBXfBxb0HYN9/4Wrv+2qSIHR9SboKkq6nyV/AwH4uKYrRTove?=
 =?iso-8859-2?Q?IA6waozbp5Gh0KITWNx2GjHrYF4AKm5KXOppnK9Kk++ulGn9y6ZGdBLvKr?=
 =?iso-8859-2?Q?srGpGrM+I2wzb6SCRzMZd96nfxAi7mvwBnSVXBwXab+kXYje7oH5vpqqlx?=
 =?iso-8859-2?Q?xzbl0s/ZpTIOeF3DtVo4wEnqt9qi+No4N9Nkw9qYax+FXBflCDl90aOvNN?=
 =?iso-8859-2?Q?tMn7s5Zd5FG5rAZOPXOUwl5tWUlGq8lhWXWdFRRROrymjOwn6fiVr6mUYN?=
 =?iso-8859-2?Q?iVceymmZ5rRRcNUB+lKVdhc+LKCuu1Xl70eHEjx9N9WOrCfyB4lWSzwAzI?=
 =?iso-8859-2?Q?2BX0RgpAdv+kEvcGjz7MAAjhOrqv7+TSv6qA6z1cP6xfyC9BFKiByZiFAg?=
 =?iso-8859-2?Q?MZRzMk77x8jH3YZiaqIvXo/XWKx2QmjBAk9LEPvr7HJFPHzCM1p02S6sLc?=
 =?iso-8859-2?Q?T+7SE3qocz5O7Y8fASNODCmnLo4BANphhr3Qmuhw6NW1s+8LkusjCBA6hY?=
 =?iso-8859-2?Q?cNwJZl7/VMDqWpyjQadAGbw+5n0M7fk5eYa9lwdqF4p78ZF7BVfKYVp7P/?=
 =?iso-8859-2?Q?FYx2bHxCG9ebg/HfXPaYFcJJS3hz3Gz0ih?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77707552-190a-4700-2244-08dd66acd098
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:10:57.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwwKAz75Cxehtingcq+WS9VdWq1macmgNf+sQ7Tn/PMJVBFnxUynGwgfq9MxVM67w5Z2xK2S5Xj3NEeS1xCPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D238A036



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, 18 March 2025 11:32 pm
> To: Lei Chuan Hua <lchuanhua@maxlinear.com>
> Cc: Frank Li <Frank.Li@nxp.com>; Lorenzo Pieralisi
> <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Manivanna=
n
> Sadhasivam <manivannan.sadhasivam@linaro.org>; Rob Herring
> <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
>=20
> This email was sent from outside of MaxLinear.
>=20
>=20
> On Tue, Mar 18, 2025 at 01:49:46AM +0000, Lei Chuan Hua wrote:
> > Hi Bjorn,
> >
> > I did a quick test with necessary change in dts. It worked, please
> move on.
>=20
> What does this mean?  By "move on", do you mean that I should merge the
> patch below (the removal of intel_pcie_cpu_addr())?
  I mean you can merge the patch with removal of intel_pcie_cpu_addr()

> I do not want to merge a change that will break any existing intel-gw
> platform.  When you say "with necessary change in dts", it makes me
> think the removal of intel_pcie_cpu_addr() forces a change to dts, which
> would not be acceptable.  We can't force users to upgrade the dts just
> to run a newer kernel.
>=20
  Actually, intel_pcie_cpu_addr() did the address translation, so in our ca=
se,
  Dts has to adapt to this change.
> I assume 250318 linux-next, which includes Frank's v12 series, should
> work with no change to dts required.  (It would be awesome if you can
> verify that.)
>=20

  I will try 250318 linux-next and let you know the result once it is done.

> If you apply this patch to remove intel_pcie_cpu_addr() on top of
> 250318 linux-next, does it still work with no changes to dts?
>=20
  I think we need to adapt dts change. Even this series patch has dts
  adaption part.

> If you have to make a dts change for it to work after removing
> intel_pcie_cpu_addr(), then we have a problem.
>=20
  We can update the dts yaml file.
> I do not see a .dts file in the upstream tree that contains "intel,lgm-
> pcie", so I don't know what the .dts contains or how it is distributed.
>=20
> I do see the binding at
> Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml,
> but the example there does not include anything about address
> translation between the CPU and the PCI controller, so my guess is that
> there are .dts files in the field that will not work if we remove
> intel_pcie_cpu_addr().
>=20
  This driver is for x86 atom platform, no upstream dts file even in arch/x=
86/boot
  Since upstream x86 platforms use acpi, even several platforms use dts, bu=
t
  never create dts directory in arch/x86/boot.

  As I mentioned earlier, dts needs a minor change.
> > ________________________________________
> > From: Bjorn Helgaas <mailto:helgaas@kernel.org>
> > Sent: Tuesday, March 18, 2025 1:59 AM
> > To: Frank Li <mailto:Frank.Li@nxp.com>
> > Cc: Lei Chuan Hua <mailto:lchuanhua@maxlinear.com>; Lorenzo Pieralisi
> > <mailto:lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <mailto:kw@linux=
.com>;
> > Manivannan Sadhasivam <mailto:manivannan.sadhasivam@linaro.org>; Rob He=
rring
> > <mailto:robh@kernel.org>; Bjorn Helgaas <mailto:bhelgaas@google.com>;
> > mailto:linux-pci@vger.kernel.org <mailto:linux-pci@vger.kernel.org>;
> > mailto:linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.or=
g>
> > Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use
> > use_parent_dt_ranges and clean up intel_pcie_cpu_addr_fixup()
> >
> >
> >
> > On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> > > Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should
> > > provide correct address translation. Set use_parent_dt_ranges to
> > > allow the DWC core driver to fetch address translation from the
> device tree.
> > >
> > > Signed-off-by: Frank Li <mailto:Frank.Li@nxp.com>
> >
> > Any update on this, Chuanhua?
> >
> > I plan to merge v12 of Frank's series [1] for v6.15.  We need to know
> > ASAP if that would break intel-gw.
> >
> > If we knew that it was safe to also apply this patch to remove
> > intel_pcie_cpu_addr(), that would be even better.
> >
> > I will plan to apply the patch below on top of Frank's series [1] for
> > v6.15 unless I hear that it would break something.
> >
> > Bjorn
> >
> > [1]
> > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20250315201548.858189-1-helgaas%40kernel.org&data=3D0=
5
> > %7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5741bbd37508dd66320100%7
> > Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638779087153570342%7CUnkno
> > wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> > W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DaIuZWzwFy2=
r
> > rzsJ5KfbxWKMx%2BPn1WHx2KvpSR0nxsl8%3D&reserved=3D0
> >
> > > ---
> > > This patches basic on
> > > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re.kernel.org%2Fimx%2F20250128-pci_fixup_addr-v9-0-3c4bb506f665%40nx
> > > p.com%2F&data=3D05%7C02%7Clchuanhua%40maxlinear.com%7C1612d73ded5741b=
b
> > > d37508dd66320100%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638779
> > > 087153596851%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiI
> > > wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
> > > %7C%7C&sdata=3Dmht19VSB24Znpvtz1pOlmtHYec%2BDBDH70zuLOZmwlSI%3D&reser=
v
> > > ed=3D0
> > >
> > > I have not hardware to test and there are not intel,lgm-pcie in
> > > kernel tree.
> > >
> > > Your dts should correct reflect hardware behavor, ref:
> > > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re.kernel.org%2Flinux-pci%2FZ8huvkENIBxyPKJv%40axis.com%2FT%2F%23mb7
> > > ae78c3a22324b37567d24ecc1c810c1b3f55c5&data=3D05%7C02%7Clchuanhua%40m=
a
> > > xlinear.com%7C1612d73ded5741bbd37508dd66320100%7Cdac2800513e041b8828
> > > 07663835f2b1d%7C0%7C0%7C638779087153612764%7CUnknown%7CTWFpbGZsb3d8e
> > > yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> > > WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DDUsGCW%2FZpvx4whLteoIjYq=
w
> > > d6oOk9rXks%2BV40i5sovI%3D&reserved=3D0
> > >
> > > According to your intel_pcie_cpu_addr_fixup()
> > >
> > > Basically, config space/io/mem space need minus SZ_256. parent bus
> > > range convert it to original value.
> > >
> > > Look for driver owner, who help test this and start move forward to
> > > remove
> > > cpu_addr_fixup() work.
> > > ---
> > > Frank Li <mailto:Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > index 9b53b8f6f268e..c21906eced618 100644
> > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > @@ -57,7 +57,6 @@
> > >       PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> > >       PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> > >
> > > -#define BUS_IATU_OFFSET                      SZ_256M
> > >  #define RESET_INTERVAL_MS            100
> > >
> > >  struct intel_pcie {
> > > @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp
> *pp)
> > >       return intel_pcie_host_setup(pcie);  }
> > >
> > > -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> > > -{
> > > -     return cpu_addr + BUS_IATU_OFFSET;
> > > -}
> > > -
> > >  static const struct dw_pcie_ops intel_pcie_ops =3D {
> > > -     .cpu_addr_fixup =3D intel_pcie_cpu_addr,
> > >  };
> > >
> > >  static const struct dw_pcie_host_ops intel_pcie_dw_ops =3D { @@
> > > -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device
> *pdev)
> > >       platform_set_drvdata(pdev, pcie);
> > >       pci =3D &pcie->pci;
> > >       pci->dev =3D dev;
> > > +     pci->use_parent_dt_ranges =3D true;
> > >       pp =3D &pci->pp;
> > >
> > >       ret =3D intel_pcie_get_resources(pdev);
> > >
> > > ---
> > > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > > change-id: 20250305-intel-7c25bfb498b1
> > >
> > > Best regards,
> > >

