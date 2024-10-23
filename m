Return-Path: <linux-pci+bounces-15084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCB59ABB31
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 03:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8BF1C2250B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540233A8F7;
	Wed, 23 Oct 2024 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTqmLNSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6B288B1;
	Wed, 23 Oct 2024 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648638; cv=fail; b=jDk2VN/OlNH8E+zf9f7H7jVLSNmZFN5WfhG1UcZvYvbeQqZrNmsbWPM380RGj/GVYDhobOLczftI+Tlr7HQXmPYE3cjInyllv6YJTQw93a7noA2Lg19RsOuPvUCMy7NqZmvhwKbfwjYFYOYGsICwLsv657C4FgwWNDGNwQTG774=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648638; c=relaxed/simple;
	bh=fzinJaAYbzTQXvX64FXiE47sNtUhJ0Mka9ulCoFvIbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8ZRMmsr/B8pprWEG30Vm3e1uqIwqjiY+tywxgies6cOZr2DEynMPDMapiIMdwbGSQhKFKKua5uvCfJ/EcGiT6kjG+M5sIiwkhkJAm5/W4LUzsoFY7nRdAubvw9CmejM+KNB+XJLO8SX6CWh9BoVck41/1q/PXJZkE9oFPLmSU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTqmLNSs; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnqLcxjwBb98b3i1pQYcmW3NrsrJizc1jP5CPs0E3Y1Vp6sEXg5nZXDS9zAvGWVuvEOsFtgwJtXnUaVgbICeMBZxRiYhgwCBhFgO7ZO00mxBbxy5Rr7oapWiM++PUhUQeQyTn5IlfSo4YcciTT6OWTyb2IIp3QB0E35W9hzYKD1BtLFejooK1YmXw/PWzHQnQVm7t7XtiBrKzsToPYW1U+xMNNJTFnvd7aV5ka3YSFCNVo9kWVfQD3JI3VGKSKCAnlbDKInMV3e//l1r7ppSjK21JjAzEXdfr/FVP/gFbMr66oKMHfj6WyqQrpR0tbNcbSOiJB4VjLbHCLUxAwPeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqbi6/HRjF4Vi6eRnof3xqHvQcaROZE26bQ5ytysB+E=;
 b=vyKBhBnTjMaxJvimqziGyT1/j/8VrvwPyhxCgGSwo98Df6XLGJPlEZShlr9jejHrM2xzCCbzH59jS3TBjKvgSOeSLpf4sXlh3MdfejZzIOzAUwXBZsdigStICvGIuaIMVNicDG4AXyR+SJZD+hdCUd0na68P0SmKQD0RCYfwKLTWde0X6mj4Lfe0wSFPY9L3+QXrasi+TqQWV6uOnm41Tu6i8oCfCuCluVfBpOXXfHusi+C5JMkilD/3Y4AmQOqF5U5gWdjEsgbPRWEiWBxf8jym5TaY0b5RsDcu58Pqb/itMMgrWqR7tjbI9WGULf+U7LotHvK2lHQ4RlpKY3n6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqbi6/HRjF4Vi6eRnof3xqHvQcaROZE26bQ5ytysB+E=;
 b=OTqmLNSsVY9TILMwz/ujR7xAoszWjZ75iRslA0EskjdKoSqjNBE4ICpqTIm25tjSsmpzE9ICBSDPsebo+UFM/yCQGn+IQoBb+TMCnWlTawlqPKGG2m7b8yOGMmcsITvNGSxZxN3UTBvwth9jJLP0q/SUnZU3ccRCj6wMFUcmW4DuS/cZZ2Qn8gHzgvq71qkGl0+Hj1uRiJLDo5OMHtsDQZi6unsCBlJq36BYe36+R7BUBh/VD6v/oDOSq/jRrh10oHjHvUwzEsq4hVfjUP4h7EpJNCkI/XklDqKSm5Xn0h3GbmxP1E48k4kNDbWIcIVCdL3XIsUvQqhbQiNJau+kOQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10538.eurprd04.prod.outlook.com (2603:10a6:150:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 01:57:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 01:57:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v4 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbJEjYfNgOwG+okkGlTPeDYifZPbKTKC+AgABqV/A=
Date: Wed, 23 Oct 2024 01:57:10 +0000
Message-ID:
 <PAXPR04MB851033EAFED9B2AB2A4CDBBB884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-13-wei.fang@nxp.com>
 <Zxf8iSl1jodJzSIf@lizhi-Precision-Tower-5810>
In-Reply-To: <Zxf8iSl1jodJzSIf@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10538:EE_
x-ms-office365-filtering-correlation-id: adf4cdfd-406b-42b7-bed3-08dcf30601ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zxFYY+xVD16ah/HJlSqpfvsTZ23bjLxPZ7eNVAqJuqjexrYqatr3x0c28Ube?=
 =?us-ascii?Q?8Kn4CpVvwgVQUWFBqmv2ovhfoI0axPWFShOVFQJTK92lT1TaIzAKHVIAPA8d?=
 =?us-ascii?Q?VaxuTWUPYLbHmfow5jMwSU4Bn4xyZVWo6KA76+Jtb9I0I+OokSvxHSRrWW0J?=
 =?us-ascii?Q?Gc37HQWhF3Iwrb2HzKoUKFJqWxXZ9Hyx0F1KQ7VJ45jCot1dXpKb2tdlqfrz?=
 =?us-ascii?Q?6fStyxWmdKiZTqNF7XyrkCkUucDS9YE8cfnn2PdSkxQ/fdU3jdjQqQAV1MvA?=
 =?us-ascii?Q?4m2i7vjAibT+h9vak4fjUvYdL5i+eSn8Jim+/aAPUKVjosaTWsz1XZq6ofij?=
 =?us-ascii?Q?cJtp8YXI1RyBqCx9WK2oU3hX4dG+m69iCqAM8DRBBAtMujG1UzYUexrCFVt6?=
 =?us-ascii?Q?M0h8AGpbGj4/BNulluE1IVFADmjzrbh1xqDR8zyP2deBfXNcC1yHINAI6kYA?=
 =?us-ascii?Q?ipwzN5NJ4wl8I/5F58lg7I8f9vx0YL0vqj26zh06BR7EJ+zAG67xiSRaK7Gq?=
 =?us-ascii?Q?sazucI2WJcETCGz9hsepaQZs5HE4vGUf+u4yd9+J8fPIvnDe9OIs0mx2IaFi?=
 =?us-ascii?Q?e5phvFuXk7IFzkSOKFIOqbOA74YKkqA3cRwy24miOUpfa0L5E6TM5a39BWLz?=
 =?us-ascii?Q?oPIBwAiML/ebdCPKatAwPkpqZ7AB+547WWbpO/QN/25S4yb+s0gOMvX7ngOm?=
 =?us-ascii?Q?I3n3LV4ZR4HbEpfBIvUW4KQk43VxpUqMfFa261oh9Kjng45rz4nMiZtCWLP+?=
 =?us-ascii?Q?hCGVXD8vGn+uhi5L2sJyavA+ZCENgUIn9NjU2UVmYSJwKWKeQ+z5IeU3mkjk?=
 =?us-ascii?Q?29OMfcXi2zGvUW4J5b3BPdT1zBUVZ7ABK5OyjjQ96PMMeSN3kulb4AJMPL58?=
 =?us-ascii?Q?bLyjVBP6tHSTd4R33nGiGHV/ey2adC90X4lBMs68I77pGPqrCYZDVDz5vusF?=
 =?us-ascii?Q?8itW/iBPH8RLIiXH4fHgLO8/ZV9a+nbbwSzcETYRCzUWbqhaA/s+/j56b/ar?=
 =?us-ascii?Q?7yPAJv60ZogIsqnKjON0rOcS1m8fMaze1NAPD5fxMbF7JYAxbjo4PnI4jjrd?=
 =?us-ascii?Q?Erk7kJRmGXbOPNvaiL2WPdQRlyVT9LEg3JTJA3Bpqj7mccDFZVXGmkD8x0XN?=
 =?us-ascii?Q?Hu/PLVroz0UyeOzSvIMH+Cw6fb/SXXNAl1kbumB1NQkt2BFKrwPqU1ziItpg?=
 =?us-ascii?Q?MV8Z21k36SmyYasPZ1qM53zPJMTv85SWVEy6/5Vtan7L6UapHr6pj/f0n/qB?=
 =?us-ascii?Q?aHrOXKxMAP/B0LZMfqbBuiHwl7gKXvCEU4yuXOjC6HGXJenFCt7UBofoAEB9?=
 =?us-ascii?Q?nBOnKj0fRO2voQGLUYkpZ39qtR76xuxs9dJRAEAszK0HRrwYCYO13jKjZdYZ?=
 =?us-ascii?Q?5BMar1k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XWyaeZWDZeS3jMz88mNgC4qIEqAGusHZLGkuXbUn3OSZVu9if8whHPsTAIPH?=
 =?us-ascii?Q?0jZzIQCfFCb8QSLdisa6BihB0zMT/UjWWmEa9lXox1Fnr6I9CUxS+Npaz00B?=
 =?us-ascii?Q?yxOF9QSnkYbAOEvoG2lbHNRG4AsJlcajWdP/hdKMerLAUEjxjSrJ9XfECn4o?=
 =?us-ascii?Q?GCmgJGWNAAuhXFvJrCLUbu0JFDKH0onFRCRR+e7h360xNIJCgWxN/9Hx4S5u?=
 =?us-ascii?Q?LNEJH0d/70vRV+ZGkbFAbc879oMkhsgtkNzDtqujqfd8awBUjShfEf4TNbNX?=
 =?us-ascii?Q?x5a0zPgp0qe+OJbXY68SiTTcGr2Mw/7ul5TN/X5til1nQxTKEghH/07sPMk+?=
 =?us-ascii?Q?zsrBA6BgKGPYW0SpZi6TOGR0tAK8XG5uDbglXwlOArEu+nSOADnG7jxJ5TR1?=
 =?us-ascii?Q?iDX7MczGzeJu++Rrq6qQiflErYyyNJ+eeImpPfPqcCaRnTse44F56lUW7QGw?=
 =?us-ascii?Q?fIsf0DtCs3IXHxeW1UEaZOjwiC4TCABc+c33ZirKRXPoCwrhxc3wLoS4v8lp?=
 =?us-ascii?Q?Ng8STn/hJJWtwkeEA0dGG4KK6kuPS60hNNPtD1eMXv1+mGYECRLRSb55pleN?=
 =?us-ascii?Q?Thv3pcMQ9c79bcKn6jlPogLAiit8B/PyTUa89/uFTeU04vTeax5T2ga4j7sj?=
 =?us-ascii?Q?gvfVd2wszTtVfRDCqIzt/B3YTzAvR5Yexs9WEDOPLuuxrzF920I/AzLKEPje?=
 =?us-ascii?Q?xJQKwS3wQVg5xP6TvuPil9SMwbtwc/AF91MTcueuV5CAU5mMyHhm+99vLzHr?=
 =?us-ascii?Q?ByjfmLpuJ8uJc74qZlmwvbFK8TSidMseEjj/Tj5mOXd6D+yrbC5qWt3TKYJq?=
 =?us-ascii?Q?VAEsQ84lvjCYIl5s/NjqU2elDwco8Ez1MW3Lkl4pgPSDMI56r8Lbtfw+R/K9?=
 =?us-ascii?Q?zPdJzf0bSRh78FSdYr1yuCQdnSB+XJ/Q66i9z36pQLCNta6AfLXrFQ+XvzIL?=
 =?us-ascii?Q?FbwfjUdZjNCzkCl5SzeDa0pMfd3yVUtHIx57HC/b1iFZ3QmtSaS6fYA0efdB?=
 =?us-ascii?Q?DjSw5RJJYvbHnOljy9m964kPJ0YIYAIikbApXsnX5FEW+LS1pBhXga28TXDO?=
 =?us-ascii?Q?uaDqe95esrOOlQQyISQSVxZzrbzKYIU2hvd6+UrORH3dwofxZat25YpQwkw7?=
 =?us-ascii?Q?ZUWYK+jKn2C3BP9EEYKEYPNoa1fpdhUHK9mH2zX1z76z956BzJGUPMx/joeR?=
 =?us-ascii?Q?0EDyYgbZIL5KuWwtoHOYA7XMeFqHuixs7D2ueqOzcBmkAybXnZSesRiHgJiN?=
 =?us-ascii?Q?1uON3MRUS0PwSCya858ntc2rZDDNMuZP9Cm4L/6K4AM0J5btbuoC+0RrPvBi?=
 =?us-ascii?Q?V8iWt+CcbLNPnQDbTdhNXLeRDiQSLhuA08aNpmkG84PPMqtK3PgkF1B650aY?=
 =?us-ascii?Q?/ZfG8pn8nkVwiMoEgXRYwfdRQmbaiZdxg6+zfaQMv5OEiGZihRLcYJ0VHvRM?=
 =?us-ascii?Q?PLS2zzfzL+yHUfNFFqRm3ZgHvuB81ad7o84PKBferM4IEN0SY56S+QOynEGG?=
 =?us-ascii?Q?kQPu7Z63M5S6Zliffb4vWfB/1FznUvIYwycuVhjktVjPtyGBEatA9rrKGTci?=
 =?us-ascii?Q?l+ZJsMhnVdwIxm6BCS0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adf4cdfd-406b-42b7-bed3-08dcf30601ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:57:10.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwSXsmTvjpNmbo+rBF+MWrJHA5NkO+wW5ydvUuC/Zu6KDyNBKaIcVl2Q4ebQIrbGWCLqjA2S5S8YPLoExuZQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10538

> > @@ -1726,9 +1728,15 @@ void enetc_get_si_caps(struct enetc_si *si)
> >  	si->num_rx_rings =3D (val >> 16) & 0xff;
> >  	si->num_tx_rings =3D val & 0xff;
> >
> > -	val =3D enetc_rd(hw, ENETC_SIRFSCAPR);
> > -	si->num_fs_entries =3D ENETC_SIRFSCAPR_GET_NUM_RFS(val);
> > -	si->num_fs_entries =3D min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
> > +	val =3D enetc_rd(hw, ENETC_SIPCAPR0);
> > +	if (val & ENETC_SIPCAPR0_RFS) {
> > +		val =3D enetc_rd(hw, ENETC_SIRFSCAPR);
> > +		si->num_fs_entries =3D ENETC_SIRFSCAPR_GET_NUM_RFS(val);
> > +		si->num_fs_entries =3D min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
> > +	} else {
> > +		/* ENETC which not supports RFS */
> > +		si->num_fs_entries =3D 0;
> > +	}
> >
> >  	si->num_rss =3D 0;
> >  	val =3D enetc_rd(hw, ENETC_SIPCAPR0);
> > @@ -1742,8 +1750,11 @@ void enetc_get_si_caps(struct enetc_si *si)
> >  	if (val & ENETC_SIPCAPR0_QBV)
> >  		si->hw_features |=3D ENETC_SI_F_QBV;
> >
> > -	if (val & ENETC_SIPCAPR0_QBU)
> > +	if (val & ENETC_SIPCAPR0_QBU) {
> >  		si->hw_features |=3D ENETC_SI_F_QBU;
> > +		si->pmac_offset =3D is_enetc_rev1(si) ? ENETC_PMAC_OFFSET :
> > +						      ENETC4_PMAC_OFFSET;
>=20
> pmac_offset should not relate with ENETC_SIPCAPR0_QBU.
> such data should be in drvdata generally.
>=20
> pmac_offset always be ENETC_PMAC_OFFSET at ver1 and
> ENETC4_PMAC_OFFSET at rev4 regardless if support ENETC_SIPCAPR0_QBU.
>=20


> > +	}
> >
> >  	if (val & ENETC_SIPCAPR0_PSFP)
> >  		si->hw_features |=3D ENETC_SI_F_PSFP; @@ -2056,7 +2067,7 @@ int
> > enetc_configure_si(struct enetc_ndev_priv *priv)
> >  	/* enable SI */
> >  	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
> >
> > -	if (si->num_rss) {
> > +	if (si->num_rss && is_enetc_rev1(si)) {
> >  		err =3D enetc_setup_default_rss_table(si, priv->num_rx_rings);
> >  		if (err)
> >  			return err;
> > @@ -2080,9 +2091,9 @@ void enetc_init_si_rings_params(struct
> enetc_ndev_priv *priv)
> >  	 */
> >  	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);
> >  	priv->num_tx_rings =3D si->num_tx_rings;
> > -	priv->bdr_int_num =3D cpus;
> > +	priv->bdr_int_num =3D priv->num_rx_rings;
> >  	priv->ic_mode =3D ENETC_IC_RX_ADAPTIVE | ENETC_IC_TX_MANUAL;
> > -	priv->tx_ictt =3D ENETC_TXIC_TIMETHR;
> > +	priv->tx_ictt =3D enetc_usecs_to_cycles(600, priv->sysclk_freq);
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_init_si_rings_params);
> >
> > @@ -2475,10 +2486,14 @@ int enetc_open(struct net_device *ndev)
> >
> >  	extended =3D !!(priv->active_offloads & ENETC_F_RX_TSTAMP);
> >
> > -	err =3D enetc_setup_irqs(priv);
> > +	err =3D clk_prepare_enable(priv->ref_clk);
> >  	if (err)
> >  		return err;
> >
> > +	err =3D enetc_setup_irqs(priv);
> > +	if (err)
> > +		goto err_setup_irqs;
> > +
> >  	err =3D enetc_phylink_connect(ndev);
> >  	if (err)
> >  		goto err_phy_connect;
> > @@ -2510,6 +2525,8 @@ int enetc_open(struct net_device *ndev)
> >  		phylink_disconnect_phy(priv->phylink);
> >  err_phy_connect:
> >  	enetc_free_irqs(priv);
> > +err_setup_irqs:
> > +	clk_disable_unprepare(priv->ref_clk);
> >
> >  	return err;
> >  }
> > @@ -2559,6 +2576,7 @@ int enetc_close(struct net_device *ndev)
> >  	enetc_assign_tx_resources(priv, NULL);
> >
> >  	enetc_free_irqs(priv);
> > +	clk_disable_unprepare(priv->ref_clk);
> >
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index 97524dfa234c..fe4bc082b3cf 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -14,6 +14,7 @@
> >  #include <net/xdp.h>
> >
> >  #include "enetc_hw.h"
> > +#include "enetc4_hw.h"
> >
> >  #define ENETC_MAC_MAXFRM_SIZE	9600
> >  #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
> > @@ -247,10 +248,16 @@ struct enetc_si {
> >  	int num_rss; /* number of RSS buckets */
> >  	unsigned short pad;
> >  	int hw_features;
> > +	int pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> >  };
> >
> >  #define ENETC_SI_ALIGN	32
> >
> > +static inline bool is_enetc_rev1(struct enetc_si *si) {
> > +	return si->pdev->revision =3D=3D ENETC_REV1; }
> > +
> >  static inline void *enetc_si_priv(const struct enetc_si *si)  {
> >  	return (char *)si + ALIGN(sizeof(struct enetc_si), ENETC_SI_ALIGN);
> > @@ -302,7 +309,7 @@ struct enetc_cls_rule {
> >  	int used;
> >  };
> >
> > -#define ENETC_MAX_BDR_INT	2 /* fixed to max # of available cpus */
> > +#define ENETC_MAX_BDR_INT	6 /* fixed to max # of available cpus */
> >  struct psfp_cap {
> >  	u32 max_streamid;
> >  	u32 max_psfp_filter;
> > @@ -340,7 +347,6 @@ enum enetc_ic_mode {
> >
> >  #define ENETC_RXIC_PKTTHR	min_t(u32, 256,
> ENETC_RX_RING_DEFAULT_SIZE / 2)
> >  #define ENETC_TXIC_PKTTHR	min_t(u32, 128,
> ENETC_TX_RING_DEFAULT_SIZE / 2)
> > -#define ENETC_TXIC_TIMETHR	enetc_usecs_to_cycles(600)
> >
> >  struct enetc_ndev_priv {
> >  	struct net_device *ndev;
> > @@ -388,6 +394,9 @@ struct enetc_ndev_priv {
> >  	 * and link state updates
> >  	 */
> >  	struct mutex		mm_lock;
> > +
> > +	struct clk *ref_clk; /* RGMII/RMII reference clock */
> > +	u64 sysclk_freq; /* NETC system clock frequency */
>=20
> You can get ref_clk from dt, why not get sysclk from dt also and fetch fr=
equency
> from clock provider instead of hardcode in driver.
>=20

I explained it in the v3 patch, maybe you missed the reply.

There are two reasons are as follows.
The first reason is that ENETC VF does not have a DT node, so VF cannot get=
 the system
clock from DT.

The second reason is that S32 platform also not use the clocks property in =
DT, so this
solution is not suitable for S32 platform. In addition, for i.MX platforms,=
 there is a 1/2
divider inside the NETCMIX, the clock rate we get from clk_get_rate() is 66=
6MHz, and
we need to divide by 2 to get the correct system clock rate. But S32 does n=
ot have a
NETCMIX so there may not have a 1/2 divider or may have other dividers, eve=
n if it
supports the clocks property, the calculation of getting the system clock r=
ate is different.
Therefore, the hardcode based on the IP revision is simpler and clearer, an=
d can be
shared by both PF and VFs.

> >  };
> > +static void enetc4_pf_reset_tc_msdu(struct enetc_hw *hw) {
> > +	u32 val =3D ENETC_MAC_MAXFRM_SIZE;
> > +	int tc;
> > +
> > +	val =3D u32_replace_bits(val, SDU_TYPE_MPDU, PTCTMSDUR_SDU_TYPE);
> > +
> > +	for (tc =3D 0; tc < 8; tc++)
>=20
> hard code 8? can you macro for it?
>=20

Okay, I will add a macro for the TC number.

> > +		enetc_port_wr(hw, ENETC4_PTCTMSDUR(tc), val); }
> > +
> > a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > index dfcaac302e24..2295742b7090 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > @@ -133,6 +133,8 @@ static void enetc_vf_netdev_setup(struct enetc_si *=
si,
> struct net_device *ndev,
> >  	ndev->watchdog_timeo =3D 5 * HZ;
> >  	ndev->max_mtu =3D ENETC_MAX_MTU;
> >
> > +	priv->sysclk_freq =3D ENETC_CLK_400M;
> > +
>=20
> why vf is fixed at 400M?
>=20

Because I have not added the VF support for i.MX95 ENETC, so the current VF
driver is still only available for LS1028A ENETC. I can add a comment here,=
 so
as not to confuse others.

