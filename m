Return-Path: <linux-pci+bounces-15095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0979ABEF5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649D2280FEF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF114D2AC;
	Wed, 23 Oct 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CvET/Cqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C914A609;
	Wed, 23 Oct 2024 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665495; cv=fail; b=kbDmCPHoI8add30/ooGDYJVPjGc/Dif2R9P3xopgPNw4j0N9gwY0Sg+AVQR+DYuPM3OHtOUSx9/S1igcWNggtrxZtWqsbjDHRYKHnB9dHbiwDZokXfENcA/L7wZO5pR6ufm9+03TVboxryOupZRPRlfFmt/QF5WbLyDeB96+2+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665495; c=relaxed/simple;
	bh=lOm918QLHMoCYL5xdMkBluZRdyVzyCqWB9i4yatX92U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWIjwU9TzuzPlbKnRxMu31+1PP7WnGH0jYOos2qbE+hJDRd2tfPMdmDm6KoD4p3yQdN1uqH8O36c8J6ar+CylxxLkyAIo15QHAdyHwMBy4ZS4TTrQ6joN4sGMoC4CYLtFKX06hcd+HqmEb8tMvV2iZ8Er8sThGFac8+iFSb6Pvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CvET/Cqe; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRMIGU9xb+dNUmSbNHYEL9180kDFWkQG+53bs2vUimWRIIygwQPXjtz0XcHnPFFz8uHv0ggz9tbq6IrQYuxlQw9/2NZYR9tHqjSCue34QTvhbg5c/5D8oIFXZp1GrSbiwszmxilqh9zPktiArhBzLLB+A59elRcVLlEK/mRlc6lV6wykdbfKyQ/pmAD1ovCTk/Ox6knKBF/8Vj9hyebZsunTPR2DKH6GGnK+GpSsMGR3KpKT4OiJfZWPRyBK739fN2ixJ5qtic/V42YsxbpTp410Nod34GHu1UTdCbmujDQQ6mEjNwb+fL0l3mCIm2XxOon/7AgTHSqwVO8xIzQ4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOm918QLHMoCYL5xdMkBluZRdyVzyCqWB9i4yatX92U=;
 b=dR1gw0Eoe5aPsK3B99vxVEGLfAShzEbZA/ehbctO4vdCAdlLzNf8ujgfQUhNPLzU4aQTxSJLwjJjKIdV+2JPDvlFO3JsqhjRwNo4c6ygmqWR/N2I6oPsjO7FpSMNyrsvKelzD6jYtidYi4tAnzMqa+AMqO6j3WsHRby9qXnTPqPxtn+tuDLUo5BAA5UY5oI7+xCNGYiytMr7UJok5qRCTGlnTNQ6RPj3pcyGScliBhw7jh6SJj7WqSQSLG33gjd6Fepcj871a+moh9YPTI1YQPoL14TwTdKm+rkda/N9PrkE7ZVXq1+Z2tQNccDmgX5+WSv0dD9TZbMs7lxDDehzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOm918QLHMoCYL5xdMkBluZRdyVzyCqWB9i4yatX92U=;
 b=CvET/CqeHSp3hveYyEu4vRKlCeFRijjRQpso94fnURQy0k+u6pYJCvX8uJkvv09/ItFYizdWdkMJKAoUwXFCfLQHaRjSjH+MQFJHBd5x4142ttNcz4cmAo3uj1U1fSYyO1WaaBoL69UCmAcvQog6YnQewdi5kBWsrQMNxdKtSzDhNkgv7sUx9BcrNMY5MT7q5iJpYJMcrcNhg1g+OZCuKPE95RL0cqBVUxW6MD1g+/kaSwDkjIapjlatW4WozIoXN9n6ZuE/yuPYrg27BfsGzEwV3C5fCilVMwmZ67UAm2JGvDcgrt/iYipBHf41rMr43nE3JCZ5xVyBLWZh4qOLvA==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 06:38:10 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:38:10 +0000
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
Subject: RE: [PATCH v4 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Thread-Topic: [PATCH v4 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Thread-Index: AQHbJEjD4d7XV+dQNEmGlpwr3OE4rLKT4rsg
Date: Wed, 23 Oct 2024 06:38:09 +0000
Message-ID:
 <AS8PR04MB88491C33CF940ED44BF685FE964D2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-7-wei.fang@nxp.com>
In-Reply-To: <20241022055223.382277-7-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM9PR04MB7489:EE_
x-ms-office365-filtering-correlation-id: 5a58a69a-4ca4-4583-149b-08dcf32d42dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0U8RbiAJ4RmbtCscbNQEi726bNIM/bZy2gIpPepGzgDmNO8QFu8Ca9Cl/YDY?=
 =?us-ascii?Q?JQLDIZiPDQ8WUwaXdZ8jD/ttH3BrJp8a/hFy/RHUCcW3055WcJu+WPI8gWai?=
 =?us-ascii?Q?AXeeP7T+s2DwB5At3utetPfuDQ9c9zDdyWf2A5tnG0cyxxGScBTceYEZcMGA?=
 =?us-ascii?Q?pdKJW4RakNxXzuu6s4+fgJbeX4WeWc3lfByF1dDVpCvT4dFthvtGfWoE6cc2?=
 =?us-ascii?Q?ghboArJ1W8+KFG+xzB0MrlWoNPr3udgFvAjh/FV7cgC1MbRvVvSIHm44vwZ+?=
 =?us-ascii?Q?PNxdP1WuxT091R63q1U/2j6qIvX/tquwbAQSbHVi3I3O9Af2OoL4+LHsonzO?=
 =?us-ascii?Q?iu13UslcLxzcUShzWXgUQYwlZra0jQRBxNHfsjEohiXi8oapL0mHmaUeSe5D?=
 =?us-ascii?Q?e69kMJcPSREzldK5C+GC2JZMxPkK+MqaKDtS8kKSvMyJwwnOCUYSKTwRddCc?=
 =?us-ascii?Q?D09df07ZeLDH7Dd4304nd9oZXMNLtUZobrJRpovTXFpg5XvWJ8T4nRENfNxC?=
 =?us-ascii?Q?RHMUWeKWgzmswfCoQ/0hsrb2+Wzq1y+vjWJsWA1W6vYhzL62VmlW5XclouVh?=
 =?us-ascii?Q?KFD6sYn3EZLanYYUH1hMZUWjCE/utV7ycni7cUvedFAaeLnqLoqM4ni8x0Om?=
 =?us-ascii?Q?GqY37+I+qUQDUwYgIJH2rZOE+IMJ3wwmQ8/Tjq5nI3Ltl1l8AW+6+nJhQ0ub?=
 =?us-ascii?Q?7dU0mvW3r0brk3fbc86dKNReeio1Eg8NgR5rNZGg8L9Jeop5L0gEFjBPDYzg?=
 =?us-ascii?Q?h2u1VHJwp+y7+bQq7LGqkWFTcEzYS4aRilGa3fM4JpXzLafXKyeStHyN2l72?=
 =?us-ascii?Q?JsFQnUElNEiH/CNrdFO43CrLHAzfESv8VnqS/NDaCcYZ1xEeTiSq+vSrCjb/?=
 =?us-ascii?Q?zCZ7ZOFaijRL+nwEuX5Qea8aj/WgiB1amuD/ICTWf2lCqdkZ708glbZABrOd?=
 =?us-ascii?Q?/10o0/t+2qXG2TquUKtsC5GjEXtlFNpg8JM3KQQRXxocJ6kzddGzVckAW8eD?=
 =?us-ascii?Q?g3U3OuW5oB7UNzV0EpoUaXz32/FovQwCcu8Drct0x0yw4GnHYWJ7+JXJ9mlS?=
 =?us-ascii?Q?N+V2XjBKdBbLLgRc2zxWTmRdhuCg+JktYYzODdhg38QPYjSc5ZGNLbCTnT5T?=
 =?us-ascii?Q?LHJTmqAIXupKmwwZt60lvTMK/HrnnWFNi4hD6flpvI3sPBdwxGmy8bAlxVwV?=
 =?us-ascii?Q?bkGlSH8ZRlHaryD7R6U2W7VHE+aW26mHM+MkiytuAoDBDgeCWZldklW7XBS4?=
 =?us-ascii?Q?kz4QYS8jcKFVgI7y2ei5D0Sk6cQhMzsmkuYEeDzN31giXelU1bQgxwqC8Y6S?=
 =?us-ascii?Q?7x1rBpZZ0J/IUM2lMIoCDgAtOAwdW0841nhgeDf4hd9BNDoerrkLlw9FoNdM?=
 =?us-ascii?Q?msoKzHv+waVujc0Bmo1wMyKD4mba?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rZ6TEpx+FlQaoB+xB+C/DXynKMBFAYXNWuRhYPQvpw14cTyFccb7cIKXvF4E?=
 =?us-ascii?Q?/lYLlWqIrbLnNs6yhQ188HaIzCScJ83IfMZMA55REZRoA++7HLLC3qpOOG0j?=
 =?us-ascii?Q?964dSDaPEGpA7mSy+gPD6WFPUaFf5RbTc3f71CLFxcJ/iMe5keMDV/0+351v?=
 =?us-ascii?Q?vcdf3YGyMK+XOtpgthoIvs1+ZIeHo4VoemStdLAyTF4k7rOfFAnpVOUkM7E9?=
 =?us-ascii?Q?1R9/YWs9Pm1W1NGh8ypmMunu8WwUPkXOrxGwXSIs/xWraz9vJfQhx1plicNu?=
 =?us-ascii?Q?JfrTnhY0osWpdyFdUDn6+nUPHLSF9Cs31DubH4fnuXeKLnDSmcJFzJNc+UfB?=
 =?us-ascii?Q?x+RtAL3/1/6ztYzKkyxMLiIW4nXOb9D1z819DrQhQrGmWTMrAUKNIvyKipNF?=
 =?us-ascii?Q?6D+4Xt2LbjVHJq+DuwLhJ4QIig2rlNzwjR0eDngENG4Bp+JjK9W9c8npPVDY?=
 =?us-ascii?Q?bOEGAxT1S4yIF2UjTRxQokGHe+JUtcIuzOFFHON7xkgX1+hwtSCzWP4ngrRx?=
 =?us-ascii?Q?GIIYQx5Dumki0JtOlDMpJQNq/PKbAt7gOMZOQVqd4uRQqhwkssNwmUmPv2pF?=
 =?us-ascii?Q?5GjBFBeEaO1da7NFd0lEcBXbinAipCE7oQx62GZeIlNTpe10J6lAwOU6vQU2?=
 =?us-ascii?Q?jupIJ1IpeAC+Tk48tF9htcOute0j9OXAQtps2nGP1tmVSLtvd0eoEbAJQM08?=
 =?us-ascii?Q?M940j0b9suWTDzE0uWDX4ZRzDUmIpTi0lIjmyp2JWGbfxN+GrbW6VEyTZmQO?=
 =?us-ascii?Q?Zd+WsNOuqdCkFBoF09zgSKMzrhlc4WB4xyVBTURFYHn9VFeMmqbLHS4jrmNF?=
 =?us-ascii?Q?4XkxT1mAHSKGV8s9Vyzg4YVPr8bXRADY2UJIZbd6dQiK2Sn7UFM/huIARkfQ?=
 =?us-ascii?Q?Yt5vmYjuUnFgHUxCvObXxcNcZvg/2huQ+WLs1WaVLfNHMdhHNDm9cx/I+9bf?=
 =?us-ascii?Q?H0dDF4ZLr6r/eomOH0ye8lsmOoNZROkCDv44vw+F2qsztrWXaK9BHvuPZGmo?=
 =?us-ascii?Q?Pe6iMrlcw4s7ODWCc6s9J3IZWlq1rpgAYUwj6dwVYai3nRzl5uczuxZoYZqz?=
 =?us-ascii?Q?qXskzgJbJpDLWoRQaH8EyZEZMEEf1qqqd4UQ6DDWhFhhzt90XgH+sCB2uX/1?=
 =?us-ascii?Q?CpTJOU1ZMDg1N6ZjCVFme778Br3zoyx6ZNyLfxTOvnCqRss0ktMkTd6fafuq?=
 =?us-ascii?Q?KU0Owr1qe/kCCwt8E0RARxmCr5AA2Xe3VWaJjrB8ELl3HkShEk0R85bzF9NI?=
 =?us-ascii?Q?yuSPT8DocjFbr/3BqMMj9H+UjMZBx+VjHTFXgp923/8Du6/9L+tQnF/a5gXJ?=
 =?us-ascii?Q?OtMk23i0H4AubyLeT7v2KB0xq2G61u1b5FEDp/hhXsCehTDo2Veqo9PnZ6Nh?=
 =?us-ascii?Q?N6ZJ2EaUtWuOL4ZM+mkFM7EwLygPp5VdTIlPiIOZXEWnWVKTYevwiDGeSyrE?=
 =?us-ascii?Q?QYcMeWHoHCHxkw2RV1saRB2VAcJ+DD6dz6Di8h/SPBtAYeDFWv5Zc304WHtH?=
 =?us-ascii?Q?xgJbIs5BPZUzoMQKFtXjX70nkdhaUeia6HUFx29rIh7UnO6j4BeSsm5zYouf?=
 =?us-ascii?Q?sQ/s19BtJ+Bm3uZOufZiv4+Zw5vTPuWQ0RpL+vsX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a58a69a-4ca4-4583-149b-08dcf32d42dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 06:38:10.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14tw1mlUIRr8bC3bkOv5V3QLFWr9qViGaqrN/WZSkCXWFPgGAaYjjHR+I/8JjqXiQrLwhTnBaxF/T7vAh0IEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 22, 2024 8:52 AM
[...]
> Subject: [PATCH v4 net-next 06/13] net: enetc: build enetc_pf_common.c as=
 a
> separate module
>=20
> Compile enetc_pf_common.c as a standalone module to allow shared usage
> between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
> different hardware operation interfaces for both ENETC v1 and v4 PF
> drivers.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

