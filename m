Return-Path: <linux-pci+bounces-15388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F69B144C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D5282B01
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A8433A4;
	Sat, 26 Oct 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hkmpdoFL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8941A94D;
	Sat, 26 Oct 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729913031; cv=fail; b=CDW6/OnYooi4954zJLNqTgobl/u4Qw8SgmjWzvs5CnJUaMSpYGDETLTNyBOm+EEvNbVbx4mc/A5AI+uRy16B9BBA/OFqkQ23dnNVE0yeESkYReAqngS9X8EfSqCA+7HpLt7mEnn0hWg9SQSXnOafc8SJXScC/lY9ju3w1B0LaYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729913031; c=relaxed/simple;
	bh=dTM/+zj65Q9fwj7iawVRVO4WW2F7udK+gqJbQ0iIt0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HGTEQ621Wdszzko1TH/eHjUxQCKT1jJkEKBFo07DwDuAu8XKbRVWw8XWJw6de+JGPm9dHUGj8xRZKg2gfz23XzpIAMm6/aQ3lfbX6UeTXwBU2L5lTTu9D67G5SLTf7pKhaQ36WuWhtmRc3qPi+7WUnY/o1fXP8KKw1vCqu4EAK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hkmpdoFL; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfKnPtlMr7GXN9CPLDC750MZ0ywSyd94smAzdeXjzWSG+o3GkaXHyG/nOpvcBnYw+SNWYYWJfCVZv2TfjhHDYuPzhLsKLAr79RQUztE/QiNeBrvAQz9jdrfQi19mKAlADhjmFGHWp87tAy+APT0KGudlfwNulBCH6WhUGPOlBOPHec3XpIxiPp2HQSI8t88henvQXZ0VLBolH44X1FGWsMWGYRUE9h0933RzHkwX28g+2a1DjwWaDg2UQFFGd5VWgwj/Lnp7GoUlKriR5CfPo2mOFN0GqkSVlu7SB2sRmxVFu9Gmy6no1VvbfJJYphnQc5oLQD1EohDHDwAFTb9hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTM/+zj65Q9fwj7iawVRVO4WW2F7udK+gqJbQ0iIt0U=;
 b=tMa037MTWEjsobvc1G94fKxl6P1TFpF0L6xC8kS27DJCF4GNTWX+QsECPcb0RtwCPoZxmu0lva/kAECWEEjIBOy5CYco3+oN1ssl65x3GlboNVI18XUgTx7knYWTZyFWqygsoPaG/NCWG9XHhy+md7Q9zd/vY6za81Ey/5+/iH9MzD6JCgOsJ6oxXXmikMRKZiJ6axoX5M+2GwkcG5EJRR/b/MK0XRDIX84fixtEaQDoAhlzzlw86fjzHjArmI6xjUrl4EzFpw42/C2Www6j0IfI+Bj5d5NtjdIanRRBXTO4QSEQK/Doj9/egjoExVYekrIYQEy+lfSyErHu7R/kmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTM/+zj65Q9fwj7iawVRVO4WW2F7udK+gqJbQ0iIt0U=;
 b=hkmpdoFLV3hTrJi0qPAqSXIW5kmIkwVBL95XGaz5XzFJtr6+UGD1fhPTyxqrufF+pOSUzI8zfCZrkIJ5kREdIPquS+PzCQy9QWZQKbwYKA5bovLBhSErdcVXq0LvbiZKpUA1ZbSUFAkhbyOIuWQLdIE+JEpwO6oi+sh4UDOdDOVsFS4A4HdZWzQbQPCE0RM8s4irhWws3/EhDiMM9o+rfKrPLNijbS/IQ6VQsfokniM8xR6If5wNKMjkqtCou+b7zw7k4g0ZpazgpqrOzaT4KIqP9rAdQKliD/LNDCbgRf1feL6YQq5RuEEnkxQLWKZk/BuY0whzV2Hg3Cm5vBIJLw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8111.eurprd04.prod.outlook.com (2603:10a6:102:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 03:23:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Sat, 26 Oct 2024
 03:23:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Thread-Topic: [PATCH v5 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Thread-Index: AQHbJeOiAKVhVEw2KE+bV6Spcx71NLKWKk+sgACUqlCAALdZAIAA54gw
Date: Sat, 26 Oct 2024 03:23:44 +0000
Message-ID:
 <PAXPR04MB8510D0548F3C5AD3101D5BAA88482@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024173451.wsdhghmz4vyboelu@skbuf>
 <PAXPR04MB8510468F88A236EA7ABB76D8884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241025132316.6pyamwivaupzwo6j@skbuf>
In-Reply-To: <20241025132316.6pyamwivaupzwo6j@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8111:EE_
x-ms-office365-filtering-correlation-id: 71868e8e-ae13-40e9-913b-08dcf56d98cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m+x74vz/cnHRWLr+hdkWYuvfervbkdD3gtFvuP0zXRwewwxE0Fm6Q8RX9d4/?=
 =?us-ascii?Q?7LcERO5eRlst1+lTXfN+7TG7valJ4BOhjhdPzcUF/ewH/CsPvOKESRLFvw8l?=
 =?us-ascii?Q?3QrM/pLueWUkxE55hKKUU7rU6062UrRLwOhL97K9oj4R5gFMR+mwPcIbEpr0?=
 =?us-ascii?Q?Ss5ozXvGssMElvvKY6tlZ23llcBOtkcxacpxR8b8mQoYNkpl58XgLOU52tcA?=
 =?us-ascii?Q?W8mCefhyebuf2rq4dbELXbIRUO4bUC+ITLo31tdGqS/7spDj7K6x2YbIzU/T?=
 =?us-ascii?Q?aTpY5ORp58mWcrBBPPXNX3e/z+dwgbrUUq32UGIlqnSWuyPy6JZzA7OqHbsC?=
 =?us-ascii?Q?seb7No1I4ohi4PECrBAItna6MO+gO2qY7mzsd0iN7Li75Szr2vSHnZP3b7zP?=
 =?us-ascii?Q?7QnG5OJheVEDtU6CUHdt3Za9pXg4+9qnlMg2SBm9wfetTMVCsrDMTPlt9IQY?=
 =?us-ascii?Q?eDxwyq0cv1iYfqIcfgUH1mfLZ06meMpTisUb9QQ5tVId4MVkQcdORY/HRpy/?=
 =?us-ascii?Q?NKmxqWimSRvY/ihMSedCuirsSfSwu4MfsyzkLWdvd0sXbRoXf7ShwmKBxDOd?=
 =?us-ascii?Q?SptNpV/8gxeeY93kMPx5xEAWBRT37eANYS/XC0NGkRNfL8azBUb5+j+zzgjD?=
 =?us-ascii?Q?9qZAMJ5cOuDGgJw2iNNTB3cLwQRT9OP3oQ/OXNKzfMUk8nV0hzt0r101jWu0?=
 =?us-ascii?Q?hvezlAwA64lw2ZWpU2oySQI4SQU5kQMHFQ0HAfy4IaQaFpfu2I5g8HEHJoVx?=
 =?us-ascii?Q?AIMMHBG6dBjLRN33khXjq8hTyYARcBrXOR8yWrQH6JW8MxkrWQXwAaoFzehL?=
 =?us-ascii?Q?grza4/gvyqlOeiBvzciaA5o8W8Mvz98NcRbEjRLHVJjgDH0Stl4rFLc1LUZ7?=
 =?us-ascii?Q?G3/+UxJHk9tY0ORHxRkOPacTTI9x/9R4pgCRD9qdi7PLIo2jL5L+Uoc1zLn7?=
 =?us-ascii?Q?1RK3UtAQtfbrqP+7umQQXX/Vx6eR4T1zwsu2b55tGWuLRApQEpupE5z4DkaX?=
 =?us-ascii?Q?IqimtYNWzf2Cq+s5YK/sK/CWkcboaP15X2Z6C1zGE2DVZncbsJExZxBx34vj?=
 =?us-ascii?Q?jlwIh7NxBsLEktBJtBlfCfkHzXACEuUsMM4nM9+8o74jiNnTpfCHqe4EFIcZ?=
 =?us-ascii?Q?CBPeEMe6rf1elD2opTU/kGdu3Z7lYQuj4H1Oetn0b8zlkjTWy0jnRmLFsTqR?=
 =?us-ascii?Q?SwEQ85yHmT+fFgy4ksQgDjy4VAFNfA07hpf6MdlOW2G01GRsqDRIf0u3OMxB?=
 =?us-ascii?Q?3Rb72M9oHDuhp3RTOq2IUKQ9T3YlHxTsuA5Cp6gu6FHBHyUTY4QzxI93MK8k?=
 =?us-ascii?Q?wCkFY/0C/zNwREDpsoI5CEOAtABInQDWLCwmbPDQpatMPMikDl0kozMQmVDy?=
 =?us-ascii?Q?qT4Q0Hc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fs55Idb/5qva1NBvTpg1aXHZUWNihHN5+OFOt3Z4nOn/w9gLxYR5AorRAUdr?=
 =?us-ascii?Q?LkcKhYL6JXa3UwMiM22qO3+Fw7Cn+vnm6Fz9hTphu6rXX5quzmal6m3i77+x?=
 =?us-ascii?Q?bM/yJGo9HCppgg/OlqkPV+aakAPXhP9x4PVlqHCnD27Ubpet5bcyrH9G3W3w?=
 =?us-ascii?Q?5xb4stDVQgbLObUegKQ94vk8ZIJ3vroMcKPhVoKcFY3wIPt8J64dbqnEV1W6?=
 =?us-ascii?Q?7GN9wfFv8AmhPoyLrX+i3O0xC/cej4a57sfDPOTJ7KV+z0udfGifVQlv4WZC?=
 =?us-ascii?Q?KOj6HCZHaG9mxfUajb3JuNGKIZSHZ93iT3x9bPzJwbPw4jVLFRXosp+R5QiW?=
 =?us-ascii?Q?l2H6Xi2KnK+x+QDZCW4mRiuZUn9FoopbupBSC5r3JkvGVPcppqDaUQApQAyZ?=
 =?us-ascii?Q?lK80Pnqe6m0CQEGa6Bg4xsP6UCbSjTqn+cFEgDPrxNNMCGmrHSvK8Zez+m1Y?=
 =?us-ascii?Q?CWFFKglzRIzxZ+0OWu5IMSPrTcTauTZL5Bgv+x71Z2hazCfjAqwyAWlBaghm?=
 =?us-ascii?Q?3tkM6fA6Hyu1aBwKHI7aKOxq8hfjlRAINDywOAiafA6BgNQH5fwehb+T9Z8u?=
 =?us-ascii?Q?YXs9fk+YEiT3br7bK4LgnL0L0h/aFUMVdntk5cwXoI2a6a1/ooehJ7JFK390?=
 =?us-ascii?Q?p32zRa8n0T+zwTfLuGEAHgIVLVScb2SYpwLdzMIp98KFDNB8ds9aNNQHNGVU?=
 =?us-ascii?Q?IJ5c3D0tOo1JlZLsyxwpWsX0LXF8sgSd3oojC0NUhBKUjBe29gYP+GMz34p+?=
 =?us-ascii?Q?E01Nr+H2UP5PmZUNuW0gpTmMyRaQhOi5ckRufiQZk2R/9K9zutJ0ZVfXuCtq?=
 =?us-ascii?Q?/OUaqEkmaHduCitGPfZj2YRIV6c3HYitQB5b9BQ5H6MoqEn8kwoHRgPNpNz7?=
 =?us-ascii?Q?fFRukXyJBFCUp8AlWjRmo2Jy+FeYQB1nxi926ki0U54rzMGIfErUkJT9wRLy?=
 =?us-ascii?Q?24+7VEIpdQWABU8jiO3FISnHbUQZ15E5Bme7ohrGwJ5XitGIouSy+JQhLiSq?=
 =?us-ascii?Q?6idq8M11Nc7LaoiAR9toKA7V6KWe5tG9v3y2eRle7vRvCcO+Csb8d1XBrQzi?=
 =?us-ascii?Q?a9L4on7LYOqWH8PY0fPd9NHOFGl8FgD+XmRvw/93hRk5JnHET0CO9iWvo2wE?=
 =?us-ascii?Q?piKxFwMEMGhd9adYyId+VFr999E7b89DM+s43ekdfHWIlN9i9JUon8N10BYP?=
 =?us-ascii?Q?BrRTZTKl0WbAVZFmVCGdgqW6+O/sLLR88Tjq5UXb18J/jRZVmoT7H7mW+20D?=
 =?us-ascii?Q?t36Cdb/WzXMTPYvOQGJONDyh4HY6lXEurdjWHFFrLV9ohmDX9KXsoPaDcGED?=
 =?us-ascii?Q?sMP/CRAnGQGq6Y8aFi85mpmWoCvcNFCq5O7gsO3hzXf0AFj1PTfoUOT0FXwP?=
 =?us-ascii?Q?Z9UI59i5vj0cMyCMTVEKkn6BDwDaWwcLb1FyIMod04b5OZWcLrUmmjbE9oe0?=
 =?us-ascii?Q?+EV26hsTT3hihPRsjomHLfC5QJTMePB/E2ncavC8b30FhFGICkMOhh0NsRsa?=
 =?us-ascii?Q?GVtrEIo3w77A1Rs2Woxq6yIwYoZLFEmRCH1QQcv8phP7E9yx5TkEZP23okXk?=
 =?us-ascii?Q?ZqdmpFQd2Gb8ndnytvE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71868e8e-ae13-40e9-913b-08dcf56d98cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 03:23:44.3017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7dYIOplxeR7r1IIFTAOSvjFphfQvZipQAa3xIpFZIRp4TCNF1pDwB/QLgr35eHh3viFRveAYnYOqVXnOMnTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8111

> On Fri, Oct 25, 2024 at 06:00:42AM +0300, Wei Fang wrote:
> > > Don't artificially create errors when there are really no errors to h=
andle.
> > > Both enetc_pf_ops and enetc4_pf_ops provide .set_si_primary_mac(), so=
 it
> > > is unnecessary to handle the case where it isn't present. Those funct=
ions
> > > return void, and void can be propagated to enetc_set_si_hw_addr() as =
well.
> >
> > I thought checking the pointer is safer, so you mean that pointers that=
 are
> > definitely present in the current driver do not need to be checked?
>=20
> Yes, there is no point to check for a condition which is impossible
> to trigger in the current code. The callee and the caller are tightly
> coupled (in the same driver), it's not a rigid API, so if the function
> pointers should be made optional for some future hardware IP, the error
> handling will be added when necessary. Ideally any change passes through
> review, and any inconsistency should be spotted when added.
>=20
> > > A bit inconsistent that pf->ops->set_si_primary_mac() goes through a
> > > wrapper function but this doesn't.
> > >
> >
> > If we really do not need to check these callback pointers, then I think=
 I can
> > remove the wrapper.
>=20
> Fine without wrapping throughout, my comment was first and foremost
> about consistency.
>=20
> > > This one looks extremely weird in the existing code, but I suppose I'=
m
> > > too late to the party to request you to clean up any of the PSFP code=
,
> > > so I'll make a note to do it myself after your work. I haven't spotte=
d
> > > any actual bug, just weird coding patterns.
> > >
> > > No change request here. I see the netc4_pf doesn't implement
> enable_psfp(),
> > > so making it optional here is fine.
> >
> > Yes, PSFP is not supported in this patch set, I will remove it in futur=
e.
>=20
> If by "I will remove it in future" you mean "once NETC4 gains PSFP
> support, I will make enable_psfp() non-optional", then ok, great.
>=20
> > Currently, we have not add the PCS support, so the 10G ENETC is not
> supported
> > yet. And we also disable the 10G ENETC in DTS. Only the 1G ENETCs (with=
out
> PCS)
> > are supported for i.MX95.
>=20
> Also think about the case where the current version of the kernel
> will boot on a newer version of the device tree, which does not have
> 'status =3D "disabled";' for those ports. It should do something reasonab=
le.
> In any case, "they're now disabled in the device tree" is not an argument=
.
>=20

For this case where the kernel is lower but the device tree is newer, I thi=
nk
there is no problem. It just fails in probe() and does not affect other fun=
ctions.
The old kernel does not support PCS, it is reasonable to return a '- EOPNOT=
SUPP'
error.

> My anecdotal and vague understanding of the Arm SystemReady (IR I think)
> requirements is that the device tree is provided by the platform,
> separately from the kernel/rootfs. It relies on the device tree ABI
> being stable, backwards-compatible and forwards-compatible.
>=20
> > > A message maybe, stating what's the deal? Just that users figure out
> > > quickly that it's an expected behavior, and not spend hours debugging
> > > until they find out it's not their fault?
> >
> > I will explain in the commit message that i.MX95 10G ENETC is not curre=
ntly
> > supported.
>=20
> By "a message, maybe" I actually meant dev_err("Message here\n"); rather
> than silent/imprecise failure.

Okay, I'll add an explicit error message.


