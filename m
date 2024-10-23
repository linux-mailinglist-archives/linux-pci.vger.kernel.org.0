Return-Path: <linux-pci+bounces-15091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C79ABE80
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C171F22D4F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5D149C57;
	Wed, 23 Oct 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PMqNxbcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1071494A5;
	Wed, 23 Oct 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664110; cv=fail; b=LtLhPr2l3fnashK4b6g51DY15ePaSSVJzFRPuwb3ckzIFDJEukUQncbM13sbt/2g0m8ZWig6Tff305gvS12C1BL09RsXbgis9ieTq4SVPgOWQHhR4aoGox368o9SH1s5hPEkzZ3tQoLb4NymFEW0Y/f110G+l4lVw8Lza6Sxjw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664110; c=relaxed/simple;
	bh=ltQ2jgZxPmiCXUSSi5yTWy73QJhGS9yPMVe6tbQp2mc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5XqOpHjz7or35EAnzBsWlyp6+90+Gwv3+XaexkEd3fFsZrRZVxSNFPeajbJ7JSgNRNWDElITfQI66HFC3R3U2Iezq6V9SyyEt/QFheYIOHwqfRnBtKQYIVOcViSl15U2NqeBa7jxEWnpqKRDfmatHraBCVUaKSjZXUJwQ4/i3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PMqNxbcu; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MehQ9il21rhuyvoTBOt+MxOUqgVd01Vrf3buKBzNzXs7pvmo/TQGOOifPJP1Nkm/n94Jfj472TGOSaaAdVE49CjVI3vS2fqGFM7kkRMuy8vGihzf2jmjSVNumD/n2FUCi9nCa5c/R9tXRTimzzvV6nEacDgAs6VZSpxxpSFGrNkS9ll3NwDbAoIpGqOPPlIZgAc3ddLQTI7Cqv0XRjqNB0fQFWWJREgAfcPW2pWFiMGfuwCt4fiwGnJxXu87lXuleri6s5tDFY8Tewrxc7eqhb7oNfhhjQWuGtLalF6eAWCDkjty7KJVN/vvlHUmfmTg9oNYj9lL7I5cG0XuxA8dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltQ2jgZxPmiCXUSSi5yTWy73QJhGS9yPMVe6tbQp2mc=;
 b=x9/VacP47ClgIzM+jcZ8r+MpgtmShEFfdJCkaC0kj5SmlzKeZC+auz7VebK5+gIIvRzSzj3oYb3+cRbeYR28uQx7Vc+MbDvIi6GKdVj3Pylx6/hhmG8kzvEzFbWsJdhLBmS1Rlwqz5wlOOXTTi9zObR5dcqLnchBD3s7SYztFr/0kDXzoVs1ZJ2IZ8TpsGf13860SV4u4p3Q89dBnukjd4UGWl47Syb1i9h+UnWIdwRv42JmrIDGPitfPGZu9oNydr4zBiFGbnD2GjosCVREbazuJ94OKQJApfwRh3IeaaWW63y7s17x8eGITA0qgPw7Cho2dRyVfG/Eul6OosL4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltQ2jgZxPmiCXUSSi5yTWy73QJhGS9yPMVe6tbQp2mc=;
 b=PMqNxbcucUisj5eRSb1zcQSAVufWk62YfGGQswWQr73TuitcGXgKKoVgbLTP7dEZnAineQgtJ/XA1jFVcuP4fvf3iAv3SGjUxT+hqk+s82pNP6hmidLPkmP53//p98TMm6Jb8VeAKu1F+3bO0mZjxZn/Q7BUI9PD2JZ0k2msMdUq/ev3HZFXu/l9WszonJxDXUC3P1jjYtzxftwKqBWlZqAWYJUBbAkWIYoTlkDlzM/12BF5X87hBvYVPIIsqrtQG+QHiwIhQUvMWYU76qOoE5r+w85sw+IV0mqn/6GYSFgEKhm0BCYmpPLVXIsGOz7oraTf1r4ohJaoGmozo5zyug==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by GVXPR04MB10588.eurprd04.prod.outlook.com (2603:10a6:150:21a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 06:15:02 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:15:02 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v4 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbJEjZiJnCgXZfMUm6a4pEg4y/p7KT3N1g
Date: Wed, 23 Oct 2024 06:15:01 +0000
Message-ID:
 <AS8PR04MB8849916BA8D8F951305B2466964D2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-13-wei.fang@nxp.com>
In-Reply-To: <20241022055223.382277-13-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|GVXPR04MB10588:EE_
x-ms-office365-filtering-correlation-id: cb6e34a8-6aaa-4646-394f-08dcf32a0781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+/y5pDkok0Baz1DsgR8ghF8oscfb5KOZvDWTtVvGlkMwPfNUjW674YLNPUAz?=
 =?us-ascii?Q?wpVho1G1lVg5DSwtHDAOD54tkn0OG3FbBxxVKldLjrmCcRiB9vPu3mFuZjEA?=
 =?us-ascii?Q?RIPFWx3N2qEhUEF+wmncEHv5LXFOj3qi6sk1Rps8W3CtvoCIno76YuhzUc6d?=
 =?us-ascii?Q?ITl9wMMYevwKpXX9zNtt4jFzKluGuiIZ7VebD2smgyvdVhtGYTT9y2Nfm7bT?=
 =?us-ascii?Q?5eVzsD1TOLkASn3Hyy6cL9neT6NOuTpHgT7EFun77DznZM1/CynPQQGUzDSM?=
 =?us-ascii?Q?R72xA0cCvhZJYHjD5xMzPS+JlTb6Bi4G6MnjPIjo3qIDUQMfz77dOkD62F78?=
 =?us-ascii?Q?/x7djASk1q0pNZIy8Ls+8ZL4JJVTkyYcv/XY20AYUFQ+x5hWWNGJE5kBBOFo?=
 =?us-ascii?Q?o/hd3RhSoVLfKNaCbgLGmEvJEEAxbIXPG1SfEpg46vtGkiODVCFpbr3l2L1k?=
 =?us-ascii?Q?4pQE9AyUcpkjsHcz8k3drJteo+8+7u7kJRiihRU0fGZGzt7AWMcedUo+f/9H?=
 =?us-ascii?Q?wiEoye2fwwh16k1mDKGkZ9/h7IMq08ZdEoebesy8vg0OV7IxbaTVrU/M3BUV?=
 =?us-ascii?Q?8CdkFeAgB8PDw7tuJ7gEbujNPy/4vY1nEoNx0ynaoZ5qE3gwZ1RE5h9RkWU2?=
 =?us-ascii?Q?CI4NQMAdjj5Usoj5vyGy8rDlE5lfNjc1NGdq6WGrWBSM0yE/oPquM5dcAq+g?=
 =?us-ascii?Q?q6wd71e0OO2elW3xdBJXUYwqK1G7Is7PlQZhET/ADeHHVq6WfxVfURD6jZcr?=
 =?us-ascii?Q?qYtr0lzSOrav7MCnnRq2T42ywCNDj0Mjgfjtg41gYQeucsKdDVNZzTbRRQPN?=
 =?us-ascii?Q?h3O4bOCZm838ZFVj0agVFFtWNyIIhLMbnaBSp7j6kDmBXv8zKluRwo52fhcn?=
 =?us-ascii?Q?O31NM7UOpQj9TxSg1aWNjfafVvvLjj1QGU537XYe8uOwuT0DjmpFZr8Nmeaq?=
 =?us-ascii?Q?J1ycG4CSj0meEW27+fUUUdyyzuFf53oGmo+HerCj3e+Pccl18a4oEea8ayiv?=
 =?us-ascii?Q?gJysxMpqySNkPC8St6aHNdVZrAKdFX5Z8X/YFZpjam1V42zq5gmPqjArHeDe?=
 =?us-ascii?Q?j80z18JByCpRmFaMNnS0eQq/0Ss9oM6JevGQNUQCIcDbFGEAq+vAx9jbebNl?=
 =?us-ascii?Q?GipS8xGeUTv0/FaiMAPtY7J9slvwF/+IN2ijkbaBibosjGT2pZ9+Ida1emhx?=
 =?us-ascii?Q?S3osHCtRKFc5MEzBV+1IUiVGCPZFxfFnssG9oxzcukuXENkdkI2nZ+H3kOTY?=
 =?us-ascii?Q?OBSKjrww3jwiWRsjsCNx/h5qn3+vpOrbF98Oc9djeAItjIFdAwCXiY64CSOu?=
 =?us-ascii?Q?SWT/0OXBNlE/5Cvsp+V+9vd6FAcEPtbfbuiTQEffI9Bpgftg/CiOtgbwfYTw?=
 =?us-ascii?Q?rlKB9RvYM70GRBgB9dhB9/eBUwms?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+ceZuCGUVY7IL+AARqUh6OioqNZDiG2xRY+WpfcnThagQsng6KGcen63KA/d?=
 =?us-ascii?Q?uRCg7w0yi9cDhIZYPqMkar2tBhqdA7kOAP1AvzphqQeWH9lFR1eLlZzN8GYf?=
 =?us-ascii?Q?XomLUDFZkse99OAmkS++F2G4Fn3qsmr95vjQR11m9IblMemTySv9CPgmC8T9?=
 =?us-ascii?Q?13XcDjl1RImi49eOA+HEY4kblWZrbXwXVMORa9e/0fTdrTrlTRxNBt3Ab7ay?=
 =?us-ascii?Q?Az62zytTzry1iEokLeWhyt7r8V8FWbLNd72OWa4yJyHAL2IXy5b8OV7fZhJ+?=
 =?us-ascii?Q?7Ckfh48dfT3XOR6HmTEu0zcRjk92VdO94RyExLrY1BgApCTOa/QtS56rYCY2?=
 =?us-ascii?Q?EOtR6I7zRYPVCK6w1KthK4wxW27L8z+0oJ6b62VfD2hiUPByV6hPcoCZp6fZ?=
 =?us-ascii?Q?Z2iB9QrnJgaeZ8H7Dn5RSUQISEU0o9IaK0IGZem8wWFhpOXmRVUa5a/27UIg?=
 =?us-ascii?Q?uQccT8HPbb8/Iuy3mjWBsV+csS5CAmEpfpGcGf1DekIMbcbCdnz8cwO87OJt?=
 =?us-ascii?Q?IBQ3HWAemxTFqKnKuQLmjmywtlFD5N35w29FvFyrjrsFEt/W+HIHll7cpoCy?=
 =?us-ascii?Q?JSFXhRArzdrwQw9FK9w3IhtXwnyT7ws0nZkiHq37EUXDT2KLvOSPLVs5nrMv?=
 =?us-ascii?Q?q6yBm2V110khG8oUHJq92UE/bdpLL6C3OBG8li2evtSXBJhujrFN569ZZZAQ?=
 =?us-ascii?Q?Ez4TUKlYrKKTUqVKzvY9PwVCiTHimqG9PbQyCOYfJwMi4qCl0xqkl2KKz+V7?=
 =?us-ascii?Q?D2Y8wCDOMEMdUuplBEvkRh+B1JjLpzLcjMFcElaAXOjF5l7QUOkuFjFp7eXl?=
 =?us-ascii?Q?em5UPdz/eXV7yfbCnnUbwd+LWZCy2adgaYGs9a8LqLAHdRHqBK40f/NgzIwa?=
 =?us-ascii?Q?MyxREwUoox+fBYIXTEvMvS3McO73RPHY7761FavKtaww0O5rgkVgGCj5re3/?=
 =?us-ascii?Q?oPkLhGG9iw0TvH0sTDPGOoI+yp5WZgo6W0wf75UEdjqDE0KONdobqW1z3azj?=
 =?us-ascii?Q?3ScGqhn34DDuJPnzegigbH8E6r8PTEVg0zjdCrLcA99Ozd0WEuhbawVtvAK9?=
 =?us-ascii?Q?pDz4xB70ZeFGm/Rc2yQSRAILBv6g4RbfasMq8oIVnus5aEamkhjGUxYYA/04?=
 =?us-ascii?Q?+O4JfXJQ2HEpqouz7ZLmTwnUdxrvXUfuZo8RW93dV+IBMnQkpAIiGLFYLv9I?=
 =?us-ascii?Q?NMBsFgRcnUrIE2Dl523Vd9sFFOkfE3E1/b9kKuOJypuGYc2Qm2XrEAIJxHc7?=
 =?us-ascii?Q?rLtKC9hjF7LRS7WTVBJvgUeJRL/k7B+mwTOMMKSiaFQIFOxUcG2boqPR76p4?=
 =?us-ascii?Q?X7DEossbHj7BJ/BidE1SWrT7Z7x6lOVnyiGh3yjtZ1U4+rMw1/hFhPrxDEGa?=
 =?us-ascii?Q?6HuSDwIVNIyut94uXOAxFDZMGzHREJLvpGG7PLu6k5a2obkMtsappNeZwnlM?=
 =?us-ascii?Q?mXpi36imNEw+eeyH30wVl3jAcdp6un99v6cSEPOdfNjWC8PpK1Trkmkgjec2?=
 =?us-ascii?Q?azilzYtjc/hOmAlJ1aGegrV4FUZJbAc8t21SDtgpGaknplf/DaCyvfeA98v7?=
 =?us-ascii?Q?8Nj6RMmmdBqqX5ZckdlyIow7MuRflftUdbMHG4Fx?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e34a8-6aaa-4646-394f-08dcf32a0781
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 06:15:01.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxCZTNCMDH3VipOZNoCL0eDyp+8MM3D/yjNEmzh/YV52WchwQstIovx2yKHACL76RsOsmkgbQzJ5E1hdxt4Xhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10588

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 22, 2024 8:52 AM
[...]
> Subject: [PATCH v4 net-next 12/13] net: enetc: add preliminary support fo=
r
> i.MX95 ENETC PF
>=20
> The i.MX95 ENETC has been upgraded to revision 4.1, which is different
> from the LS1028A ENETC (revision 1.0) except for the SI part. Therefore,
> the fsl-enetc driver is incompatible with i.MX95 ENETC PF. So add new
> nxp-enetc4 driver to support i.MX95 ENETC PF, and this driver will be
> used to support the ENETC PF with major revision 4 for other SoCs in the
> future.
>=20
> Currently, the nxp-enetc4 driver only supports basic transmission feature
> for i.MX95 ENETC PF, the more basic and advanced features will be added
> in the subsequent patches.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

