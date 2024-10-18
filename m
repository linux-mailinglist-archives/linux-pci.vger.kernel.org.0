Return-Path: <linux-pci+bounces-14839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601D9A3262
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 04:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532852831C9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C313B59B;
	Fri, 18 Oct 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yd8QJh1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6851C4A;
	Fri, 18 Oct 2024 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217053; cv=fail; b=QdlnVDWAntAsqDiemc5uuKmqWv2kZXOG4Nk3Fntc/1VzA+Qx0X1rRNtH7YUN5/wDVAIe+F2glHl0x248vPZyhE25vNFMstjMxemRtSqi27ncMCoYrZRxhIuGdJS8sCZG31R98sBQOtv6KdOTL0Zd2xNpqVxjaOfo4EC78HbVU88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217053; c=relaxed/simple;
	bh=W9Z6U1ygjcZswcfqwLh0gkaJd7sSyVVdixhbDr/CQ6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZleCaKWxyMS1CxGa2RcT+PkfHqgMu+3HMaqG6se5v/Ew9zUCem8kZ/EK3MHh4puxhMr7iAKPbrMI/cOg2L5OUP/uwENt5Ll70TYwNCdk3cOJMM7XZXCeqMVJl4ZcHqFmznz7SQwso+KvP4Jh+ODd31ndr6AXr2n5fnD+1haDRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yd8QJh1y; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwhOGJHh1KZgXP2hTLe6gAda+FcOF7j+E4nub+0RRdlUVRl0ahGNaOBVAqx4wIfXehk1lV5CsqrioT3FtWY2Dy4jxsJCK9AwhyrFA8/6tQDCb3XAukPmXXFsyKvj3Y+sDCXQEPLk02/qNSCJRsRpmPGxSbxBqgPYlq9bGfXtJZ6kC5QUg3Xax3L+8u4o7eyNejL/0yY0054BCdgO26ZijVf1R57GX4U7M/fdcvVwu3/Yfin6+XHdKmvyk9svrivp7nnu7IdNzghmIwG+3B+VFQR9ky+nN+5hCDnvWHPNcq8Nmh7lejNmpidq6Gl1cuTpmUDNsOsLppDZmqif0pegXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6KLHgSqUm3FROe/zfI0Vzq4ilcXO9tJr1RifOkbtCc=;
 b=lj2FPgHNP6DZHsgIwIOxdR8Ij2K5qLghGMUuIUoxR1muSz+r8Y/FhGRipGxGTDCOYRzRvVl21u449+q1+YA7IgA0/CzdWkcQgEZUf7j1CnTO8qdiZAhcptvLvN93WS8lDp8sBxn4oyHogxTpEvbId6AzBrazXwA1tx/xUxnpNoPgtkOcJSIPdtf4gy7eBe7fKhvZqi2WPOuku7CCOHDgKExPbi3Tf1ZSG/TSBOdcjzxXP/U+5m8UDbEBkcofvvPORp54AU6L9TZ9KlAc9GI0lIz5+ml3+JjGIoFSWm6p1Om8dNAUkJUFKEnsXrxnRCjNp7Z35WQwGriHSIee/aQ1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6KLHgSqUm3FROe/zfI0Vzq4ilcXO9tJr1RifOkbtCc=;
 b=Yd8QJh1yFQWYHOGD3CWJCXImvoy48z4nc1Fcn7f5EELM+QKg8W7NJhQFSY7gZVI5kuOT35sV6uuofXDQUFEU9wa53ifD4Y/MvnBW0yh+KSjb6piPlFTnMjcVIXKDbyrWu9+2DD0jhqk3eHepVSdUyGFrKP7W13Q5Rbr+tGP3S+YirhkNRVTgUrqGaO0S5qrHTUru4hILKvDpclupffdojQ98gKnoGyplaOF07gF7eZLBf8zDrkQ60qdGgs6XMxhbuSm02lQANgJnRP7ZKu1AfMRA9WhhDVFmO+Iny5zC8wKhz7p6b5WOZLadVh0FO6QT14EM4FVCKZ3D3au8fG0pPQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9855.eurprd04.prod.outlook.com (2603:10a6:20b:652::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:04:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 02:04:06 +0000
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
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v3 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbIGsGfwE9ZCz3ZEi++6XhhsicXLKLKwWAgACQAXA=
Date: Fri, 18 Oct 2024 02:04:06 +0000
Message-ID:
 <PAXPR04MB8510E7AD1EEAFD9332DAE29788402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
 <ZxFCcbDqXHdkW18c@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxFCcbDqXHdkW18c@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS5PR04MB9855:EE_
x-ms-office365-filtering-correlation-id: 2f135662-1dbd-48ce-3597-08dcef1925cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GUVh2pZXrjEiWGduZOipLB8VQYwKkTcIA2KiDtB60BDzJuSAUOUpSaxCIfa5?=
 =?us-ascii?Q?v8Spo586B/BDrSTlAhigrSJdYjtOBwrdoqHxVPbptOPEtVntZbKjXQlIeQw4?=
 =?us-ascii?Q?gTJo4fzp/8pep2LHsDTDuz0OQPShqEjM4YwbA4bX+hMg1uvttMPbV5uXHq+l?=
 =?us-ascii?Q?QsE/D2RwzmU/8Wya8PSHq9pe7nBtom1yYvWMPtJzBs0eZkCKH7PGGXPNe3iX?=
 =?us-ascii?Q?/UEWGYvRtumXAxUcF8HyLmZkaHdx1hTSLuqK2GNjs8VfbewITk4RU3HJ5IXT?=
 =?us-ascii?Q?606k5j8DVkQsAJr2FmjYXE2vcORsMdSmSFtIdpeVqbwtNO5qE7NrG7C5J1yr?=
 =?us-ascii?Q?SpLdjCsuJt0MImsgODJzmUnWuBYYfDDjAwgbhRdXgZs8nTkED0Os6JBQjs45?=
 =?us-ascii?Q?IhFctNbb6fjKW27zP8ET55LHvWMgq/O56o+lXEeOyGPr65LXMG5EJ0KnkNFn?=
 =?us-ascii?Q?wgsJf+miTjXXwA4de4PAoYabypMxUFyhz+ycp0ye0FkE/u/WZoFirJtZlbuG?=
 =?us-ascii?Q?AMkxL394HiCzV57RYR69dUcasGzCyW2cMkPfgDAS3XHP+wPJQPlRwwOQNmRO?=
 =?us-ascii?Q?XoYOVEYHYk/g6o2oB3HwrJitCDNT4vFaCMJoJg1iVJsNKHSx4b0CPd4IQQil?=
 =?us-ascii?Q?IFsuwe270Tf49RfXKAPSXaNq2X9lDOtKnETk4QghcT7XJJPJoh8QWlK4RQe4?=
 =?us-ascii?Q?aVCiCbth8VoJbBuAAZoJpusOTXT3nWBbK2j2k3nXUxpUXlUeJI4W0Wgtl1CG?=
 =?us-ascii?Q?sUdQwlSFMIa8NQ+7C+iSLsmVtGnrLEjgYEBvhNFn/nK8sjVLD3+V+QuXunoa?=
 =?us-ascii?Q?kb9yfC9GMtzc7EgaHJCEPwv/bxDquWEJtPQr5mYvkvCDv5vjR3S9DeK8Gv8G?=
 =?us-ascii?Q?F5Zl6KQcc7+YSPtd0go5fJK1E0eUyCI6j4gO16tFF3mtTYa7c+VDMwajbV9B?=
 =?us-ascii?Q?AWRjTcSY/XnYyHvmoXj4G/ZlQNNqjvEGZ6VBm+xZ1yMY79D7L8B8T0OuT+/a?=
 =?us-ascii?Q?HWUJ4utGWA89ZY0NgepXfff+vv5dmrC4CxOIKDyMNnkzbJ+a2EftIbCVFOM8?=
 =?us-ascii?Q?Dd8oTiA6X5Ob4QYigH/QXe05vkJpvf/Kmjtrv2letlP6wvwrySaNAA0FSql2?=
 =?us-ascii?Q?0NU9kuUxoBTOXGyGBoWcCN5lKnVYDwEN1QlVyQq0F13Z2wCbhZZKeK8dPu4q?=
 =?us-ascii?Q?2s7Ik2Hz6/WOAOfBnd/q/n95TowOTcHEEobSGcihZuKm7m9RIUjFaJC3rfdt?=
 =?us-ascii?Q?eG4pY/l4YQEM+ZcxJWLaGRiPpjoY4gxjwzBfhJskFNfD1SqcsXt8hwkrhIRH?=
 =?us-ascii?Q?xsUaCTFiKr/bhwhok+MnRqO+cahNx+MYq0YPgQcrQVSYrAv5nQcTpYwe5n2V?=
 =?us-ascii?Q?xChd0tw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mcIcAkVtPqjwGJ31+iodZ54cDM4rEBwAHPokXAksHYFTt1ERAFIg2GL+GnLr?=
 =?us-ascii?Q?Qay6hEmvkWzdK7eQPyhtDGTSWrSHZFdMoMxmnny57sDDeq56daiz9t4FtVzS?=
 =?us-ascii?Q?an4RmaphAnmOhHag8J8d9FAhcOq49Z+r1jv7HDzSg0G+AFi9GQxJTtKfzJvV?=
 =?us-ascii?Q?M0/nWjXX7hdPtZQIzrxpVgk56KrsADRriLmnT/i07XbFPFA5uCnj7YdsrvH2?=
 =?us-ascii?Q?V6JyYUSO/qfEM7L35DPnq7Lb+GGJnK+Cf4EmiRY44AuaiacYguXPRy9uR6G9?=
 =?us-ascii?Q?mkYOUl5e2ZUSJ/E22cP3WqXGIbGkokWNa07ZTYzHtvHVMRosN5QvIYjVKGC3?=
 =?us-ascii?Q?ZoYmhEWvod3S5GB2kM3c7uQayQ4UGAE91vEiVjOOcNv9whLgzhp58ZRK5Rfd?=
 =?us-ascii?Q?TbbKw0rVOP+Shy+keqrxgC/PhEdacuon+9oHFhVUsKjJv6Ud1eEzUbB+29sr?=
 =?us-ascii?Q?NT0pmlWSgxGl7QO1cauDTUYse9TXGXreYyCLRoK+b08drcICSeJgSDk9OLad?=
 =?us-ascii?Q?TKj537cWLBVkoulocwQ4HxnianedSCHkW+hNJXJl0JrAXYOchj/G6M5cVzgq?=
 =?us-ascii?Q?etXbgIPlGiPOwsgUsbKPT+Op5jiw/pRmorgh4Fbwj9pIjugRJxrp+qZb9TGu?=
 =?us-ascii?Q?PLGNx503AYn5drfXuTSXmC3Xj8cxrU1VgxhkmuJXdJ5aigwFswN1eM1G72XC?=
 =?us-ascii?Q?tCLRof0dgsPfWYHyYoy6i4i/nGQRjOUmkGu0LkfjEuMj8vyxVsiZ2Jht+T8L?=
 =?us-ascii?Q?r8dUucu95kXKcYAendNRCmAPrlvSc/gDUz4Zd4viQv2XoDydoqDPJit+GYsN?=
 =?us-ascii?Q?hZWCiEk5EeLCQjEmQJ9Sz26brV2VZPLjHRrxqRWoAPiE01hnKV/dn9zWvWzl?=
 =?us-ascii?Q?Qs29p6yByK3RkrdBSZKx+SVDsoYPNgyTBoe+Q4433dSI0gQguIqY0c9/wqMZ?=
 =?us-ascii?Q?axEEMWgC+ht6+4HuKN6zPcL0H2cyBHu+DxOIl1bjO+K1JHqIyALrYVdEgCRW?=
 =?us-ascii?Q?kaj64uhfOol7DrH8J1+622EFBpJF2mXmNu6WQ7d2Y18I+w7byJQ3HJfNirVX?=
 =?us-ascii?Q?WlPDCeQ7S+tG1hR85GRRNkFfN80/nql3RrWnV2+zOoc+laXsWh1YLYHWACie?=
 =?us-ascii?Q?MZSfckpdAGoOxgCN0vG6NtP9wq32YHYic750Fb0zeMZaAwjQfJqYz0FGJidr?=
 =?us-ascii?Q?0pO1iFGT2HjQVU7F4OjfcfEnsyjtdJUm/kN0EMnrmj6W6sIHV/pHnzYgZYkp?=
 =?us-ascii?Q?UkdGU+AwkAvN+wiJarhE0a8LGuS2n0xjab86vmQAcNpsaTiIqzHyMJig+A5y?=
 =?us-ascii?Q?dektvEWdRFAF3kfNBuv3DToKPrWoKkGzwLPmmxNcwCYcFvn8E4xRS9ulle9e?=
 =?us-ascii?Q?N2D3ZkXLgYzZxd0aLjqyj50Bvis+h5UXoSIj0mdUQKJlWhbP0HH2PMMwldRx?=
 =?us-ascii?Q?qgQFd1qmtce74r30ICRjOrqATqcdz3K3ce/aFc2vDsmCDxIToYSyLI8j4qsj?=
 =?us-ascii?Q?Idkw9Qs0BSE201+TKsQwhgnz4kJasrkoB6UCqJ2omwHy0vHYCA0zlz0TgJck?=
 =?us-ascii?Q?r+O5KnQFQefwNm4eeus=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f135662-1dbd-48ce-3597-08dcef1925cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 02:04:06.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7rfUJVckU1wDiBl7nxPsh9yCw8O1+3ZatRxEdtIs4zyLqpn4lG2GlfM7iGQ+pBJuVtpqklqFONadaiIThbeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9855

[...]
> > @@ -1721,14 +1724,25 @@ void enetc_get_si_caps(struct enetc_si *si)
> >  	struct enetc_hw *hw =3D &si->hw;
> >  	u32 val;
> >
> > +	if (is_enetc_rev1(si))
> > +		si->clk_freq =3D ENETC_CLK;
> > +	else
> > +		si->clk_freq =3D ENETC_CLK_333M;
>=20
> can you use clk_gate_rate() to get frequency instead of hardcode here.

clk_gate_rate() is not possible to be used here, enetc_get_si_caps() is sha=
red
by PF and VFs, but VF does not have DT node. Second, LS1028A and S32
platform do not use the clocks property.

> Or you should use standard PCIe version information.
>=20

What do you mean standard PCIe version? is_enetc_rev1() gets the revision
from struct pci_dev:: revision, my understanding is that this is the revisi=
on
provided by PCIe.

[...]
> > +
> > @@ -593,6 +620,9 @@ static int enetc_get_rxnfc(struct net_device *ndev,
> struct ethtool_rxnfc *rxnfc,
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int i, j;
> >
> > +	if (is_enetc_rev4(priv->si))
> > +		return -EOPNOTSUPP;
> > +
> >  	switch (rxnfc->cmd) {
> >  	case ETHTOOL_GRXRINGS:
> >  		rxnfc->data =3D priv->num_rx_rings;
> > @@ -643,6 +673,9 @@ static int enetc_set_rxnfc(struct net_device *ndev,
> struct ethtool_rxnfc *rxnfc)
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int err;
> >
> > +	if (is_enetc_rev4(priv->si))
> > +		return -EOPNOTSUPP;
> > +
> >  	switch (rxnfc->cmd) {
> >  	case ETHTOOL_SRXCLSRLINS:
> >  		if (rxnfc->fs.location >=3D priv->si->num_fs_entries) @@ -678,6
> > +711,9 @@ static u32 enetc_get_rxfh_key_size(struct net_device *ndev)
> > {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> > @@ -843,8 +890,12 @@ static int enetc_set_coalesce(struct net_device
> > *ndev,  static int enetc_get_ts_info(struct net_device *ndev,
> >  			     struct kernel_ethtool_ts_info *info)  {
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int *phc_idx;
> >
> > +	if (is_enetc_rev4(priv->si))
> > +		return -EOPNOTSUPP;
> > +
>=20
> Can you just not set enetc_pf_ethtool_ops if it is imx95 instead of check=
 each
> ethtools function? or use difference enetc_pf_ethtool_ops for imx95?
>=20

For the first question, in the current patch, i.MX95 already supports some
ethtool interfaces, so there is no need to remove them.

For the second question, for LS1028A and i.MX95, the logic of these ethtool
interfaces is basically the same, the difference is the hardware operation =
part.
It's just that support for i.MX95 has not yet been added. Both the current
approach and the approach you suggested will eventually merge into using th=
e
same enetc_pf_ethtool_ops, so I don't think there is much practical point i=
n
switching to the approach you mentioned.


