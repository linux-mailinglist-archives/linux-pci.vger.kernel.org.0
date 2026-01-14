Return-Path: <linux-pci+bounces-44776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2905D203D2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E799A302EF49
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D83A1E66;
	Wed, 14 Jan 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FgrTIg0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073224466D;
	Wed, 14 Jan 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408484; cv=fail; b=JZrfrRDjqZywW3NZgvUja61pjo3pDrlPG7q4TzETQQuPybic4Pf0r/rv9xUc0cTjQK98FId14V78HxU2kUmxSeP6qJgNFyawxaeguV4gEMUvhAFymv1f+IiKqCSbk0/0D92/3QrX2BbajmwWl2j08Ugt0bSAN6DQes4BVH4/5U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408484; c=relaxed/simple;
	bh=TyBmEWbLxTo7spKkB6jUMJJVwZSLCZbGrO4CWOKKeZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAOr9NrK5Pgv4tqtxuc9WsJ9OPMGiqyMEWAxNaeEymgDozzeA36qqwp0b2z+QE2UbYpz/Qja/DmNei99Klf3aijq8uciHhTcezEQH5NFyWmXV0Br7WdPvlLJREQJOIq2WbwW4hLjiWKnkCXkp2hXsC17OZhGVp081Qr6AXR6vPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FgrTIg0l; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+NJ7yZnnVyQzE+eBLxSU3WwY0/a9+NiEwEf/tqwOAkvGrPx2QV23OA6LFsH+8F/JtLkiGFdKpzOf95JPo+4n1TblU08qgB1uSSIpUQQ0FHGoCNSt9tMtqUB7mc+abOpiFycmxcPaAM+TU7R04YfeTjGLKIIAuZ9rdyfJ4RS8x2ijYgqlOcSAH9rCbDUOAGUlfOADN1owmYh4LbXamBMhNVVt8VkAmXzlHHxRahsLNWdxCyh7qXb8uhpT4kFqIIY7uOPC0fKhRDdat0NB331TfV6/u6fXMqNBvwoQPbh2Zsw4/S6YAbnFSeJ8BEH916TpUf9yWNJ7e/V3ejRdgmFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZK0wxfJ+oQhV7I33CcWJZUbebYfEZMlCwVyQKpaytI=;
 b=as7kee16uH16eU+kFrvh2VO2yN5/Q7lzA5oOCMFWaggS+arTfe08h1NmW/ksJ7v6Ixpj+l99rMAXw8A5C5J/LGQxGNd+9jl834aZG8scW7U6dpCDeLK1jKmDjBAONPHgf4AY1RKWGyPW6dDH7bMuOVaGcFzxXCx8kJwlMIXUkDWQDIDGf4vaAec2cedw3gWEGx7bJncAigDqZeWL0HF4D4Ab22LFqXtS1cTCaZ+jHSojwhjh3RsDxyrVRKNEH6YXjDU/RWzTvHXFs/sddevE/kGq7se0fWhcLMFbjLV4E5wpK4pKSGKF0W8R0rq90X5Yn1ZDs7T1oy8TXyMpPxTA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZK0wxfJ+oQhV7I33CcWJZUbebYfEZMlCwVyQKpaytI=;
 b=FgrTIg0lPfPQF7YijSy/kAZv/pdKGbAFCvDUqhZUDbI9eVTQmexX6qo8bDybAOwynVfPeCICRldW0dXngv2C9GjPXUL0AHJDXIXeeriqrtnnl5VEnf4jRx2rWAL4DEztH/OzkO+eTvYzKyabznLWs1ch6sGEwjzMLNERjvoDkT4=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS9PR01MB12279.jpnprd01.prod.outlook.com (2603:1096:604:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:34:37 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:34:33 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Topic: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Index: AQHchWur0QNnJZ0tzEqmzsYZqV6cE7VR2GYAgAAC0JA=
Date: Wed, 14 Jan 2026 16:34:33 +0000
Message-ID:
 <TY6PR01MB1737773DEF65ABEBEF11D2E96FF8FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-17-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB11346AE1205D35A8D8BC90B9B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346AE1205D35A8D8BC90B9B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS9PR01MB12279:EE_
x-ms-office365-filtering-correlation-id: 5cc2badc-cdd9-41ac-4ad6-08de538acc4d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?do1BLIDzvBmJAlygH9KDvrGiDhhhkdumzQ+tvpxjHIq2HwxHngB62x7hRGEh?=
 =?us-ascii?Q?HuDxCH2rrs+k9B7OMH4FZWl8Mx5nmov3XNcQqXDf1H44FCCwiHD3HXOV+X98?=
 =?us-ascii?Q?6J8nNYi/MFIN2EIjImq3lelElx4LaRWFdlRNHms+WoAFXYYLHLjvqvmQ2OJb?=
 =?us-ascii?Q?eQx8nDNw0pOaxA4mczVvWMf0zcMJOzDLLqbySSoVR7T/XeaO339yg5zl7jIE?=
 =?us-ascii?Q?Y6jv9O3b+QRKFGvGYPBhuTcWhshHUhaHcYFtuVF6Gdy0bK31/uI3vcD7NN88?=
 =?us-ascii?Q?+tvv19+/TuxDwyGsZSNaHl2mZfcl9uUICBiDv69rjM/iPXXrMsgaunVQ3ASd?=
 =?us-ascii?Q?+7IhMXsJqkQRjWzWbT/yfyVQFuXwr9LxDjV+j2mgOhPoyzDGw1npJmn/pzYD?=
 =?us-ascii?Q?9Mr6EVF1SktgL1+fl842GK8vF3r/HeuQdrnACuV/dYxucB4G4BnyG+nsn072?=
 =?us-ascii?Q?QX7HfW6GbA/8xVJ61HQKzoFrsE6CDtCdHhdHvMX76MT5/6DgqLffL4i4Wtem?=
 =?us-ascii?Q?sF+Iw+Z+eq2TLfHrEEEWM4pCX/LscWi0VM3woOKFc0fG8UkKfNAEKChb4XZ6?=
 =?us-ascii?Q?2vhNc4iGhyLwMr/9LB+pFg1DjwKqfOiHAMAdZOIX+NSnxM6SXHZ08WW4mIda?=
 =?us-ascii?Q?pSV+z53zry50aLzUh5cq2iKTDnPiAf+YPBoqi+LvoMr0IKUskPArv1OLetSZ?=
 =?us-ascii?Q?g/oFgLaLTBv1zRmUmYvnBuMNNzovT6m1NUYHocwjGV/ZB9wrW30BdIWvSu2I?=
 =?us-ascii?Q?ecKO5wbEf9UxXIPIzn6Io3gn2MQbCwBFMexfeaPoFkA+WnMURJSyDU/RjV46?=
 =?us-ascii?Q?Ny78nHEsavObcWUfSmvhDIHAcKbHDTsfeGeIZYrrh3bOrHPb0xPfKNHa0ETu?=
 =?us-ascii?Q?58F71Ko3mbl2o9Re/s8mGRf63FJUKxzFdSt4x7E35NpaJjdXevNyJXvRUQaG?=
 =?us-ascii?Q?9/UbIgaiucZjrT8HP523vIF3n+K98LoIoQSDj9UMeXDwPf201XdNxo9eMaa9?=
 =?us-ascii?Q?u5hnR0+nrsVoUZD67gqX0rra+SMa0B86LtP+KIajHeIn0IIWBp2yx80JNRJ0?=
 =?us-ascii?Q?Uk3caTmDtqKy7rYLlKlvHbfwwdO3+pDkKWjKahsC80WNJon52fjSCkvlmrrF?=
 =?us-ascii?Q?dTmFBu8ygiEypu12P4OiLqfqgsljGelkPwb2wLawMM7zMORo5/aAMal1Bb4L?=
 =?us-ascii?Q?Fim14PitJiCTnsm45gjktLtYdDCbnzgifLalfaOeGiKsm4i2wkfQ8mFdUynd?=
 =?us-ascii?Q?OxaSSGRvQ8xPAMINE1Gny0qbHTKh60PvPbGE/aiME56FBEIchz27SBtzWd6v?=
 =?us-ascii?Q?3e4AywTJzvcdzl7YpXw9CCmQ2LlUUgo/MsSHT9LNGoAoIQ4WROxhySUtwO/D?=
 =?us-ascii?Q?s5m9HfjPh2/0lfdR72QeCUYoq3q1Wxe/E0G/JwUjFhJqkIwNJkqtm5nutK6v?=
 =?us-ascii?Q?LO5cc1SSLjiMNZIUhcuet+mq5f1mLdVjRQGI1GbJPMEKnXkpjWRDxGw56E3w?=
 =?us-ascii?Q?AeYuvmFztECXqmNBmcIzhXktMlBovqVyDUCyFiU5GADkdAtZqs/AI6pDE+Vg?=
 =?us-ascii?Q?nZAmqK3e2pUUCeNjGX4KU2Ki2CbYgnxi2i6aYl8yMDdmHuqp8CEbv086Gqzb?=
 =?us-ascii?Q?AHJsiPpIFBFJGeYtNVw1RwE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UyXb8WgQv2wFTANvLvExjV/VO7vadGmXU1dsh4qDLwuShShnkz1weja2SZBO?=
 =?us-ascii?Q?4HCx8C0L7CeCYlGDhSTERgv6rqJdSENFWKG+d2FHedO9MyhqZnPYHrTD0w/L?=
 =?us-ascii?Q?0Ts8Z0Qop5CBdfbw9xY9GV659wLXbpi/nxcfmpVHWNthgK+oOklz4uPP3VOp?=
 =?us-ascii?Q?BislyODZs3sCftTN165nReL4oaupi2snsM0RN6yQnL/KwZEXhPNDQHKXBc67?=
 =?us-ascii?Q?Fhes6QGyltcoinstlL+DaEKXXKzlHS4xVDlYJbAG3tkAKGdaBlaP85TG6t6l?=
 =?us-ascii?Q?iZB083Vu5mDKX3aaHbaXr1VgzxymsvqQ+x20jIn1wZfE4h4X+GnI9d6QUqct?=
 =?us-ascii?Q?b9+fD4tF96PFNJzs/UMOKJzoV+6vzceLfaJFMLto0OT/n7poyvRNafA2noVO?=
 =?us-ascii?Q?iOsYEzY9rCNekvBZY5+U/RVwAKUuxZAEePHu4QQQX/jY0M95xYjHY630Opt4?=
 =?us-ascii?Q?IdIQdSLIO3ceey6kK+iXunz1HIVU7rUIhuEyrRdnCwrFJBwXX66cTN5en5Qg?=
 =?us-ascii?Q?DdZHSRqIpCUvVE2H8xyi+wlqz7f1XpJQTMVPjV00L6ScE56nwPBx39nDjbBT?=
 =?us-ascii?Q?PUsN6LbdBX0E+IP3rUgilG7+aORe++BCIarR2Jica/Dz0vhtV2CzlyJmRtWY?=
 =?us-ascii?Q?QUHqo6gR1IDxrmbYqKlNCOdjWiWffslNunaHLRVb3+VvPk7LcORZmPLDtZr7?=
 =?us-ascii?Q?asF45OHkEwOsg6+ftCYsb6VSXvKiUiWZ4MuEenuyYqgZov2XyBm5E3ilTv1o?=
 =?us-ascii?Q?wkV6LPBJwL0lOkX4tDorIzzejOxFx5i5I+3bjwDbLlRaX5WT7CXOCDHUBygF?=
 =?us-ascii?Q?x7KidfHosB4f9lCxzO2UMTTrqAgypf8ZPMGsTNwcGjNMKYbZNBbcFVtiE+Wy?=
 =?us-ascii?Q?9XwqyQ0OnjNzWU6on9Pklmsg0M69Naqmx+d8+vEB3nF0ZDJwXGWljI46GP2f?=
 =?us-ascii?Q?27TjT0ktVqQ4MDiYymFKLhpJ/s/uEc2DiMnXu6Rkbnp4r5HrwBFitcOK8kNC?=
 =?us-ascii?Q?dx0k2HRQxkfgXecAt0OMMEQL/TqL5I+8+8SLKDvFYU7jWGB0YhNeFqbu41MU?=
 =?us-ascii?Q?k/fa4CqlYurLVEOr/3eOwi6ZK8KRqaMPe4DOdterqz4h2FymPrZS9ASYd9VT?=
 =?us-ascii?Q?3iK8vCz6sQL7ig96Rwy4BvQa9BukkjsGp3XcuqG/f4kThh9plaJZ4AQlNapt?=
 =?us-ascii?Q?gI3zVta0n9678sGIw4/+invLeNQM8dRSfCx+UxNcs1+kCUn95xFonvtp3OoX?=
 =?us-ascii?Q?KSgsxUEGZt0AaBQM5Nios0h+9NRtJlx+SmloyEotlA/DANAClgSY4vugER2T?=
 =?us-ascii?Q?DwuKtYOpKQNTLuEpr4DWyKPXFFdVJC7BKSB1mhapXsywimbN57zSOuSHTeOG?=
 =?us-ascii?Q?GHAMU97zLWV3rH5hfc0K8BEhj5frGtNMlkHnyS/pTlzofTRfL5CpWyeGCX/k?=
 =?us-ascii?Q?0V/BMwOBfSSyBJkgAFnRWBmT7xTFwvez3Xy7ousHuydzW0/0WZQPGuY3vgvF?=
 =?us-ascii?Q?BHuHLKj8hB+/r5y0rx8jnmhQlsSZqcHdCvk1rtJwN/y59DSdIQjFWHhGIWAO?=
 =?us-ascii?Q?ALU49V7kkqvMPdHK26SvVeMZP377Ia7Ba1f3aq+QcMu+Q4UZOHpkweS2NhGO?=
 =?us-ascii?Q?ZLQgskAj5RKtn3A69p+xEXUwTeOJNsigZlG7kYZcBd3keVGELYBniAobQ7jV?=
 =?us-ascii?Q?rLNcUB3cJdV56OJCNP6+ju3FYweZJYM3VunWZ2iVfKXP40zSuxUjN8KpVMP4?=
 =?us-ascii?Q?piIVR0PctCsRE3NGeD/TOOQRUB71W80=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc2badc-cdd9-41ac-4ad6-08de538acc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 16:34:33.1062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7UOtlZ3wwJE+lzq34mSy+zrgp6Ay2KpibOYbztbmxWT5dLfYWEnOL0BNzUnovMqGHb2dHf3TIOfvlKPN+JXr3y3XYM9NsTP/oRL2NizPn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12279

Hi Biju,

Thanks for the feedback.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, January 14, 2026 5:20 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; geert+renesas@glider.be;
> krzk+dt@kernel.org
> Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enabl=
e
> PCIe
>=20
> Hi John Madieu,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > Sent: 14 January 2026 15:34
> > Subject: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
> > PCIe
> >
> > The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> > Enable PCIe support.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > b/arch/arm64/boot/dts/renesas/renesas-
> > smarc2.dtsi
> > index b607b5d6c259..3db7d31be2b2 100644
> > --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > @@ -96,6 +96,13 @@ &i2c0 {
> >  	clock-frequency =3D <400000>;
> >  };
> >
> > +&pcie {
> > +	dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
>=20
> This entry to be only in SoC dtsi like RZ/G3S.
>=20
> > +	pinctrl-0 =3D <&pcie_pins>;
> > +	pinctrl-names =3D "default";
>=20
> The pinctrl entries to be moved to board specific file as it will be used
> by RZ/G3S, RZ/G3E and Upcoming SoC in future.
>=20

To summarize, you suggest me to keep only the dma-ranges update in this
file and move pinctrl assignment into r9a09g047e57-smarc.dts right ?

> Cheers,
> Biju
>=20
Regards,
John

> > +	status =3D "okay";
> > +};
> > +
> >  &scif0 {
> >  	status =3D "okay";
> >  };
> > --
> > 2.25.1


