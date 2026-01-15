Return-Path: <linux-pci+bounces-44920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C47D23B9E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C23930C99D0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655335E54D;
	Thu, 15 Jan 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mTIwjcWV"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7B35B136;
	Thu, 15 Jan 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470195; cv=fail; b=guuikb/Wkw5AF7ntBe89zxO1mC382WRCHfnMX23b05fRo4Bs7EWhz31RX4Jqhj8kYay4wWJjV/XH6yPamx7iiWYMo/ol8ALhrU94d3n+79YRj7G03Pz/ZP3Z5/1ImB6JPILheGyWtDq0KtfY0n0gqkinXwFjc+97Kg3inM5Gb38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470195; c=relaxed/simple;
	bh=ZDnkisSkU107pIHPn4enUjh6ZciIxskpGtv/qseJiEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0Fvfq8WdluBb8yqoCBWoppCa930coW2FMhcEl0LYYQC4fbEbunhNvG8sZuZ8pukp0qtjuiX8oHhBpf/m72MLv103PavbPS8GpDG47CHoCBG0AJjlGBI8S1n++Fm3Fc29oVlCkQBwJNJ8Pgg0c+irrLXB7pwIxZ6pmWwEGVssq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mTIwjcWV; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd2IJ4C2IKlj3mQwJLuOkEhDj31W0lDaiinDXXzcPNLRJfVvJEvDqD4vfwC8qxcpIKCGM9YmAKVL6sGW8HD9yU0A/JSksupjqylaHUa3EuQeDB9DcNfIT/x5wtzwMxQWADXADoQtZGaqewA7BXNhSWh/sYhmkZnYLvtaEBBsa9HCn/V8HREFIRsd/RWBWbXYoKZ9hAlmdJ8EU3bS+i+h5Hd5r5ytbyoBDjgfmaLqV3HHIbp3BOjpcjB6H0bjc7uh3tRJRUC07GGjueakOYZ2UjfN7PUCYYjaQPWT7imGZgETD3HAMFt4RDCOYp2Z6JC6+ND943zbMmNrDqRKESCaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tfCp6fQIl5qsA9guA57Y6O4ghQZjSIAmB71h7xeeN4=;
 b=OzTZTE5MaAIfvNFyedIhikQcyOOB4r/2uu0Er9OtXAZW7BpmDUb9fp/MIDokTV/BYjSyNGnqCV/AlJ0UrS3ICBLISsBRVLTlJxovVxOpvi1R4iDwnS8aw3lJZcTGbb/rH24GrvfMmnW13UkIpIVpF1Zfl63KJYmPRT6ZQ3mecKudQvwtXQX2E4H9rpCOiBpJwPpjbrzVub4DcUjNXQ13haEhMOs6WlbKo4+Gk0/e3cgH1BOWb4SEXzxqhamag78R+vd9LAhyegMDOoENowSuII86MAqJrWqN3+GK6b0JkkafdgbVAf3J4t09BQ7tZb+RUnvh9B9LLxIUTAmGiVlaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tfCp6fQIl5qsA9guA57Y6O4ghQZjSIAmB71h7xeeN4=;
 b=mTIwjcWVGsg/fvFi4yZCYhscLRqwjNLx4GX3zeBGJ/2gyNc+UdW3yHa0ABrlrw/JKX730CLHKw46NGHI667cuY8RbbwZw39h4HLjo+U9erKKA0MXuznbqF0bCPomIF4EL5cAeLIZF3LJr3hWlM/InKEC47f/NrYcnB9MYXS78UQ=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYYPR01MB8149.jpnprd01.prod.outlook.com (2603:1096:400:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:43:08 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:43:08 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuration and
 initialization callbacks
Thread-Topic: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuration
 and initialization callbacks
Thread-Index: AQHchWuS6V52aQDV9kOofoy2QJlKB7VSQsiAgAC4vEA=
Date: Thu, 15 Jan 2026 09:43:08 +0000
Message-ID:
 <TY6PR01MB17377C696B031168FEBC56C33FF8CA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-10-john.madieu.xa@bp.renesas.com>
 <20260114224041.GA838614@bhelgaas>
In-Reply-To: <20260114224041.GA838614@bhelgaas>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYYPR01MB8149:EE_
x-ms-office365-filtering-correlation-id: ab21b5fb-2e80-46f2-5cbd-08de541a7d88
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F07RsR69KrKq4QOH4UXh/1mLZNAX6kfpLe1J9WPco8RNPhvPzh0ymehljXyC?=
 =?us-ascii?Q?231FWm4pvaFYGzzgQkrxAbLrqJieWmO5CsQy7RtLsfWFg18fqzybD4TWmaNK?=
 =?us-ascii?Q?wsBPL5FiHu1UYi+sNS1PbypB+jLOtjipJ/u2g70csEKpwSGXt6+ge9bUk5It?=
 =?us-ascii?Q?J7JuHfThtsYTI8ffzHIocRgzIG0D17CO9DFQ+YQX8sPMBJFNPFUeGhYQkgot?=
 =?us-ascii?Q?GdYt0cyOsalsBtEQfQs20BdaGojsdKVLjpqcSCIcWW8biRRhXtvg0tP4sBZO?=
 =?us-ascii?Q?/5p60nW4qDGsMZV06do/JF2emLG/NAVC0NYRnSDm7h6b2xMEffsoN6QgFWPe?=
 =?us-ascii?Q?qNUYvVRR+aokouiZepZqV+buEzqOSY+Mn1fbhqsT+5EFEB0zEnIenajWokqD?=
 =?us-ascii?Q?lfK8LjTbPeXzkcoS3yBg7TSaJXDSLm3JYpKvnokPW8NKlrXaF7DvhZHkNL3F?=
 =?us-ascii?Q?45tL/xmIzaY5drai7AKcqAMZDAkeRzoKh18QYWlMTbUt+2zm6m4KO0qxk1YJ?=
 =?us-ascii?Q?RZ60Kmm7UV+vKT8ti4H39BGxSMSkHTvnZomEbMx8a65SOcSC9l2lWAzGgeCC?=
 =?us-ascii?Q?I3FMMJbobt2a6Scvi59A9XJp5lHugNpEqIij2S2GFsqeKQahcH9fTnGAprBW?=
 =?us-ascii?Q?Jic7w0TKzMeEeuxVTbAVm/bhn3bSdxikL0hhq5N+6OOcx32ZtT2vxL4GcUL3?=
 =?us-ascii?Q?2Nx+zb9PeaVeHT80BS83W6qwRZXuXEZZM6pHotGl1OCltioxDFhHLPMLYRoM?=
 =?us-ascii?Q?Yy1zfFlvdEaa8xzs4wP9wzXLYymmyt+xUy7fs98V51ZNmkX+fElI+5X3hx/N?=
 =?us-ascii?Q?6sKO8o0HY2gWdE7RPCNOSsvM3sV1JAgGES7Zc4Zr4zZDjHBg1dhV4jI28jL4?=
 =?us-ascii?Q?r82WND/F/8x8/u1YwhtHkZtXTuVvzhgGdZa4y6q7cnSF3eSpQ/qVjtAO7pwb?=
 =?us-ascii?Q?7um4CAUjumXk0khnEUR99mLw6kcu7MgkwgUxayEHDE/240OW/RdZp1QBLGKo?=
 =?us-ascii?Q?1SXNUMI4aI/S88+b+QEWri8YuHZs8GSXLK13m3e/DfCLq3Tiz2EXJOu5QKe7?=
 =?us-ascii?Q?UJkx+a0kd/+uYdhIC4D3RF42m+iKVrmMTRqftbtzwXs6zPyRGNgeQ8JlDN4B?=
 =?us-ascii?Q?gM0s50zakWnjilNcrc1bQvfeHRWceuLuFC35MQzkUcDsvPygkMMSXq6DtDxH?=
 =?us-ascii?Q?yosWnegWLt62aPA5QHtRtDOfDdObQZqIFDXNbtp9eTFCsBLBtRSUUBa9i1zx?=
 =?us-ascii?Q?/19b+D277GTzV4w/wUNLvmBmCXDlvSAHN8Da0c5D0QL1awZKkgNxD+W3xy0h?=
 =?us-ascii?Q?JbP//cGuYHCWKCM0en6Js3GKisl3ibxDHP822/Ftd6CsclTNo5fOXIpwddh9?=
 =?us-ascii?Q?QLE6YYO1FoTX8WWAGWjk9AZrAJdW9b+aKfMzdExizU7D5MqQOFQ7Dux37Yl2?=
 =?us-ascii?Q?K1ccXD00Z8uLFXZem6AuEcZMawHefMJZL9alOU71cTbPM+nQAuuHJYHhkG+x?=
 =?us-ascii?Q?SUESIv14GAEK6g9ah9xc8SsrRfat6M7IpeW5/1Yq+EVpm7+c4DD6hDkloBq6?=
 =?us-ascii?Q?yYJxnSX5qUp0bK2oh4yhYGDAPhY+uNjPhPiWl1Vu3w/gfLcXx56zvBaMDQK0?=
 =?us-ascii?Q?e6uZCG8KbO+q0hKwis/Pjs8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Fs2WXpLaUWiETH1iXLBnK62DVbt+2BXbU/qviMiq+I8Tjnf5YhM7CT2fuOa?=
 =?us-ascii?Q?EOaLfk/8z6tp7TEtZOekDrLi/bb/3LHaWqXXmnYP05ctpFFjIEuWEdlxPPpB?=
 =?us-ascii?Q?K2vkcazo4w4OSUeQHt/2rH4EAAraPSEXt03ZZT8Qp2D5XzmM8+n1RNJRFat/?=
 =?us-ascii?Q?nyA+Cx+jsOvlbGIsvSxjmu31Xc/6MY0Lf1/fGjj6Ld67X8gOVMIixq7Bokaj?=
 =?us-ascii?Q?Dsk0OVVqV/FG9ZV4FyLm8hExJgEOa+rvspbV44fqM/UDx1rU3Ka6hjxs6mZm?=
 =?us-ascii?Q?z6tz0C7Sws1NUdpPLj1AFFyEVHw/dNiLunSGB1EYc00UH5j27RuFgiJH9pvs?=
 =?us-ascii?Q?F4mgdziZS1yG5oy7frXaKhf3u2TwVuciM7Xxt40dUJDeWDvKaomzAFNzqQ2N?=
 =?us-ascii?Q?ToCsl1+mvA+LelZHyRp37avjjJmu4FNzEnzrPtYl7cC0oc8aZ0D3v30mE/Iq?=
 =?us-ascii?Q?+/arCTuLgnCVY1QTI1l3Ju+4vqVLH7cP0nwWM2OY5bGHX6bd3KBO2kvJqWd3?=
 =?us-ascii?Q?GLC3aGamfMiwRksJgATbhyylGZIqnqbQx3LjcV1h79MR48lW5gLbHXerx3uv?=
 =?us-ascii?Q?NxohjzteWAyuXmRnytNUH9wD9QG/kPOC8P5n95a60GkvIvwnYS95OxzqbASX?=
 =?us-ascii?Q?qRy/gkxQwH9Kg3sielD/isyEiVbauxQ9quhXRLsJvK0A9WNyEHaG268dyYBa?=
 =?us-ascii?Q?1H/3miJPjWqmI4UaUbv6RUGJjiAoy84lh/kLJBhWAruEmpFPGW/F5zxF0Qro?=
 =?us-ascii?Q?gRHjPWmQXae0JZ35K8pEoc7s+AMf8PrrU7r2xdLdxEB861TCGVcI8g2R75eH?=
 =?us-ascii?Q?Ch3Am+2tqbm4JglmIBaq8kI4cx6MPHuz9TCh1vFNp8Fg8VK0JoRqKvEGNnOk?=
 =?us-ascii?Q?IuztUWRgKKswiiDYaMHL9sK0lEMEDOt+aIGa1P4qy5s0c530b5+7o6khw2kR?=
 =?us-ascii?Q?WQN/8iR4b38vl9S05j0G+MF+hsYYPFMljT9kGW724XeOn0xM3uPPkjIiARWd?=
 =?us-ascii?Q?p05cvd1pywPUS8cyWkeF/+++rbv5Ees54rsv4yxAo3S15XNFYz5R1z3L1Hxn?=
 =?us-ascii?Q?vkKYOTzKCzkOPy+bL/ycTa6Swua9bnrl8Ykt+nkbvM7yESNsMaxuvNKD1v1V?=
 =?us-ascii?Q?Pwkm+AX+V/9BgBU8QcXryCJcbStgrl8TiC8yyqKUTlgLrbkZBHh25qI6Pa45?=
 =?us-ascii?Q?LxeeCBrxzIn7eEKME9Y/quFDg1iJCLCpetxC0DnZ3AV45psuQE/Uao+F4cm6?=
 =?us-ascii?Q?iVA1icKfKUquxhcasbt3rNGbN2TSMAjSxcc2oWYgzIICMBEe0cWb5s9GWmQA?=
 =?us-ascii?Q?wMsD8cc9JVaZhFyVUzabjiz9RjQ75oTahCMWW6EXZT4J6g3vA107+47+1r5u?=
 =?us-ascii?Q?xcai2jefGm12+DucbVchHOM3OE21FytVtMk7E+btZzzEfSxU+UaCDB3qfjaz?=
 =?us-ascii?Q?GE9gOQAWB4NcCVOArH3W+L3z6sljdFfAO7Qk/GZdl10HSFCrLAeFpzxP0+6S?=
 =?us-ascii?Q?q9TSP6+vVMcFOPXia+UXRXMy7HtzOFz1hPfdjU3/NqSIxYmlkxyoquRm5K5z?=
 =?us-ascii?Q?2XzeWgYA4MMsoDTiZMq+SePtvaoXWmVpDegYtaIs0IQu31EYY41c9q1wk9u4?=
 =?us-ascii?Q?rq8j9f448dNTBe+GNdOiBaE9y12+XjZb1QWG8TRERtQHAYaVy6mFxsLMsA1T?=
 =?us-ascii?Q?gzjgjwGKGMoGsbMQ127BdAGZZIk80X7B+B6uV6vMyRzPtnUGDxbRoorIWPfp?=
 =?us-ascii?Q?yjoVWrScV0LuDgT5cXmdyxLfkoFF3R8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab21b5fb-2e80-46f2-5cbd-08de541a7d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 09:43:08.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMjxArJFP/hfVWJf55S53rM3aABayGOvrVdnu71+a6iHEufmbzhWhrvhnenRfiFa9crJ5vzI+tPIt5SHZUdfJ3xF+JHoV8VxPAFfw7IvNSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8149

Hi Bjorn,

Thanks for the feedback.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, January 14, 2026 11:41 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuratio=
n
> and initialization callbacks
>=20
> On Wed, Jan 14, 2026 at 04:33:30PM +0100, John Madieu wrote:
> > Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks to
> > handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> > reset framework with dedicated reset lines, other SoC variants like
> > RZ/G3E control configuration resets through PCIe AXI registers.
> >
> > As Linux reset bulk API gracefully handles optional NULL reset lines
> > (num_cfg_resets =3D 0 for RZ/G3E), the driver continues to use the
> > standard reset framework when reset lines are available, while custom
> > callbacks are only invoked when provided.
> >
> > This provides a balanced pattern where:
> > - RZ/G3S: Uses reset framework only, no callbacks needed
> > - RZ/G3E: Sets num_cfg_resets=3D0, provides
> > cfg_pre_init/cfg_post_init/cfg_deinit
> > - In addition to that, RZ/G3E requires explicit cfg reset and clok
> turned off
> >   to put the PCIe IP in a known state.
>=20
> s/clok/clock/

Noted for v2.

Regards,
John

