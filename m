Return-Path: <linux-pci+bounces-15085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D949ABB61
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 04:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEC1B2226D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 02:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297513BBE5;
	Wed, 23 Oct 2024 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCflDy+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5788825;
	Wed, 23 Oct 2024 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649814; cv=fail; b=nsJcx58bbq1H29tyspvgF80Kt8EpZruHyvXPi3KCWyRtsE7YH3/j8rLN/RDrCbwHPlhKOUOtRYy97HMCKZphgH6NoMjxnVhTcl1Axx0Uuqf9PHoQBbOJ0K40StNYI2q+21Eu3v92rT+8hBC4CHvDwCUpozup1WRQ6m17/56rGrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649814; c=relaxed/simple;
	bh=wdUgHjrKit3JLUjhWsYR23RfnPorTIL9kFMM4GorevE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qPMKakzjbYHC3ucEJzd6rkZFEzhbXz+NezGArmO1xORQcDDJmqWiCwenQCLtn1MuNvp5opf/uY94AZJCetdj+9YVyfZsry872mhKjfe1qJYIp6BfTM3Fkocg4dcHRtWH3tyfoaWEh5GH9EVv0Ekcll7hhrxKLBbzlrr05e179Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCflDy+S; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ealoFh4OwxKn6jO40tZsAprpRh1jOuEjGGN9uTGD5+KVro2gThTxWm98yEyZNdVH1IkgvMwDwcCnqQ4UvUVdGgRnjhYUv3ZJ0YV3w+Ibn+rvtHha2SuUpMlO151E1LvzP+1TEfprqtC5n9k8RYtqSko2BXeeVo9GbcBUdZoC4MHeadCJi8KT+P7T2MvzdQ07xem5lUbrS8Cn/B+4uq93K2Ok8/UgHEj0aSyLKYPR6ek9SlmuXQ/BoZR7NUhOMUm2r1e1dRFIwI9fkajK5OiKNc68xA+H8pAzqiijlclcSfoaNkEtIuElQe7TDcYvi8ZD8GBZ1aYCE75H1KO/R3ndUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Key1gzbBQBE3oAUDr79jobe6bzLpb7Ku2Q8gdqvVrk0=;
 b=qSyHOMBIUCa6wzYT+p18trjiBDUT8Yo+8XeeX2g4WtZg4opTSp7hntech+ElUYWWdj5A2B2Y1TuX2q48YeeFeZ4Q+3ONczU7ybYPCzXbUemZntlx0h3vopwDOYkNXAQj/0na5pSXmzfAgoWCurHFzUVto73jxGfU9H74nmgOSHc8oRO7SHKKeW5KjRkx0gpAHWgcgvzRdLiwdxUarVaY8pWUUNMIk4b8QjdWNYVTWk4VP9noV5j/Noa76C47V78G2PyW/21PnvUCHOXZjuCnrBK8jXoNWCH77bJhcWHfcIsqWkRkOfmELIPoTCjcVGy9fbll9nvpFCe4dk/FQP0PXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Key1gzbBQBE3oAUDr79jobe6bzLpb7Ku2Q8gdqvVrk0=;
 b=CCflDy+SOq/u/JwECRUgDmGSnw7o51H6uLGuq5pfqVoeYj8CFN8lCRhGUcJqOtGvCDz/8HxIqGZs54/OpmOfFFjC6gxs/5aT5vjYfiFv724ETkRkvlVK4TZTuLwjFovm4Tcbxb4cakocas0iEltEnO4K/VydFKi7keIhynEbFICOiBvS3Seq7xQgL6pOjkF5AqKiVPvOzulGULnl87TiZF9srQ1uMNGOEdHP1CnX34KxxQYixFHSiNu7ZaEAEwnQ5IF2RQM9ZSNSmfI+U3OBevTjt1Rnbq5ezY+/XvDlfuLa4Mz+Ud7jX2qB+2fQ1oTpTzgmbhaOz/WcTyWm8xtLeg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9232.eurprd04.prod.outlook.com (2603:10a6:102:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:16:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:16:47 +0000
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
Thread-Index: AQHbJEjYfNgOwG+okkGlTPeDYifZPbKTKC+AgABqV/CAAAYOoA==
Date: Wed, 23 Oct 2024 02:16:47 +0000
Message-ID:
 <PAXPR04MB8510FE4766ADC9DAA0A465D4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-13-wei.fang@nxp.com>
 <Zxf8iSl1jodJzSIf@lizhi-Precision-Tower-5810>
 <PAXPR04MB851033EAFED9B2AB2A4CDBBB884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB851033EAFED9B2AB2A4CDBBB884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9232:EE_
x-ms-office365-filtering-correlation-id: cd519ffe-b79a-4fbd-9ad3-08dcf308bf8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iulDVQ9kwLBz8JDcPOH/vxZHU1b9ZHjCYa3ILamSeIg41QePv58nzpoDZVv+?=
 =?us-ascii?Q?qtGZWrVqv9Io59j3XpbSzZHglKKP2hQDQksuVJRyJ48rZo7FUTf3+1yeuTyy?=
 =?us-ascii?Q?aKtfJSRVwH9KmTwcq7up+4X1CUXTLeUG3Y6h7T5uTU+ABJsT52ncr5x+CsNo?=
 =?us-ascii?Q?/KUEILUcWbQ5HijBcbONAibUGHOkjX+JP39hs5uzoyOySUFbUF8C8OR/sHCV?=
 =?us-ascii?Q?vwqPRgff96dGr+w980efHXs/fg/Gr/WWaGcZa8QO4q1PuomZOM/oMISlYCX5?=
 =?us-ascii?Q?IR5R9XFLxtkmElvLIpLBwrcYYD05GUDx2l2d3AIzxYwu3utuhgEB/xerNkGh?=
 =?us-ascii?Q?tMsm7T7iAnkjv9TzwtHqO3YyuGRdPnLr20Mwq8UME0O6VdkBt9E3fu1BmHoE?=
 =?us-ascii?Q?IrLNZLdXovQYwv1/4+kerYNdLsnLbukvSDBnHePejFdCbtXENrpnnq/aXeER?=
 =?us-ascii?Q?5EG6FlvU5gy6hLAoCReCYzGCF2CuB/3CugsNqN9bRgEmeghkepcyhnfwttyP?=
 =?us-ascii?Q?Wz792ryG85oe0k5iVQbTwLyBnSPcg37o3YQMqOGOmjvvM4QFMJ6tBbGg1lzU?=
 =?us-ascii?Q?CuShfXejnsF+SI5AUpTI6bICkFbUCRMVlzPdO44HCu6gbzY+7ZkJJoB6k0OO?=
 =?us-ascii?Q?jiHhS66TFPydhs4N7Z329QY+VNhyK+Lvs9ZZg7Tz6zTSOh5vYUjV1sAOtui+?=
 =?us-ascii?Q?7o4f9U1Hcz1tlYav0ee1UFGMvmTYREYTGNGWH6Jxm6WkyCKlp9nYiPcTMsia?=
 =?us-ascii?Q?s/MlGS1m2hQCBAuBZwhhYJM8EGiQ9SkvJEpOR23LJYf9LIeWOLv9FT1lwtUr?=
 =?us-ascii?Q?GV7TES9CLMW43M74HsgtDN65tl/wwLtZRX4liUaPFdCVSkyEOH/Uf++MivG+?=
 =?us-ascii?Q?VAbV5iTT/Bokg6U77KIX1Vd4cdh2AZq1LGOmabKufYWJvEVyr8yceFbOjVit?=
 =?us-ascii?Q?hHplG6WMaWrw+urd1X1hF/cD7NYGGCSn4mVnLEMM1Z8FOd8jW18mTak+7j08?=
 =?us-ascii?Q?XXJQ8CR0u7uxWmq1g5NogMKltMZW35mSyiVAZIkkLYN3OlIr59aACkOv+ji/?=
 =?us-ascii?Q?vA8hJZCOkWvwsJ/j9J203Y4VIn/cLoril8c5zsFM7bV4QHnbcW0BveMjkEk2?=
 =?us-ascii?Q?ZZSn6GKFMbnUS65POCcj9Km49+cinTg7gg44va3a9lnF6on2VoF/+XXU0CK9?=
 =?us-ascii?Q?wRGC3RPkSqsmHaMwyunmYgVj7MGeAyikw5DpAXteSsIGdDeYGxNd7yvSoK4K?=
 =?us-ascii?Q?IISoamhQphB1QOFYNQ7xlpVnGLxyT65BkkXwvLbm7sqn/7b3JhSuK867StwC?=
 =?us-ascii?Q?KsI1g+gn1ZhU8CS16ZT9wbu0R1t5935EfxkGmQHbSTmeM/QJHW7GtMsAGWaw?=
 =?us-ascii?Q?pmVXk2w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oUUTMM6E4gB7qf0XzbbGf1Bvrr7SjBuAaMqbz226XYrQNC5uvCvnT9IIanpH?=
 =?us-ascii?Q?BbYeLWemg+sxBrwoNYLORUjIcn/4PqTny7i82vRQxde78WhuBQWjtoBfQSNj?=
 =?us-ascii?Q?7cE/D999K/gOv5Qmlu+0Ca5CWMbHp+i+qiS7gi7I7yBqVisr9g/mNwghZbxc?=
 =?us-ascii?Q?rRaOVeucxoHLKPT2Yj6pMgPBkNpaC4ZYA2BVc8E6nu21CKKq15C2a+Af5/rB?=
 =?us-ascii?Q?0ZZ/xCSqYsFAHXjiHvd8bMrzC9aS38gGwLh/1ZfOz2pPVaNmyABk4RyftZNL?=
 =?us-ascii?Q?mGUP/9FCYuGq7pf3uMZN0x3MvJyBlPcL4kiF/RH3fiZlM0r1tNK6zhO+fnkH?=
 =?us-ascii?Q?N+X3nS1nWaWb77c0zHBZ8iW/EEDAtRpahmNUppzszVVkMNYTrJTLxHmxefV4?=
 =?us-ascii?Q?E6rGWA1cSB16Jb9uryfUndNzUH5p2SVF4+W12ZXcBb69Ed5yjbvTgqJnfZEl?=
 =?us-ascii?Q?1HHW/eB1ZGx7/zrpVBjHzgYYkrqFHmqnhcg9UgOOlX87EDECT7sJxJzkRUZ3?=
 =?us-ascii?Q?s74yGCWtI4pUR8j4KvMCKDIOf8aOf9l/7ShuyOoNa+udf6efqntn49YLHjxr?=
 =?us-ascii?Q?y90GDBPu1oConglrJYmmjmnFxE7tbVC9NYcgP+LJ53mfFzth8uRgMufn99DK?=
 =?us-ascii?Q?7hr3fLI6Rx2ZglkUwOOuGgcazj35bxG0R7bXDS3w+e7a2DeK6pPb9CGT9H4A?=
 =?us-ascii?Q?liRJY/2fEzhwqI/Xy9IN/3cRTaMeaofJ8pRZuIqMzWX5w4ZTnYnR719Mtx5+?=
 =?us-ascii?Q?fVbZ8p+OqBmjvzxUyHNY5YR5/dZ47WBd1Evbqmnk4ziCRuGvYRhvYxQ1r6ir?=
 =?us-ascii?Q?iEEHOxofe9Jr/CsPNMIT2JDwFlvG7GEO+WvYfpQ1R8Cme9usak3Mxune0AG9?=
 =?us-ascii?Q?n6MF48y4g4Ryzb7s23NXsS+RpE3wWVcfSKhXEtLgEY4CTDKQh6FCX842UBDt?=
 =?us-ascii?Q?kHgStJTM9o/6eh5e8oD3uuU7f41KjqePRzcqI0A0S0PRyaqc+mZ4dV9u0yof?=
 =?us-ascii?Q?ytemH++21Ki0kaXNNXzXhnmcnwtpaoYf3P0+OEjkka0FEjEsxJU/By2tvdwR?=
 =?us-ascii?Q?y7W1pI9sm1Z29nbjvb/f+NwMwXGKYL61LHm3soRSCutr+mj6pGj6EwR4N9q7?=
 =?us-ascii?Q?IXyl1gnDyWyyi/DcdkMe66n/clBQccEMhsGUrtFhGGIvmHjiSLItF3iRmWy4?=
 =?us-ascii?Q?brUMz0AFRMxgKquGAt1ZqA84oqulNhmnwWEYUvquVuqPCG15Uysr+7wKasLz?=
 =?us-ascii?Q?axzufMuCCdSecWaPF3//c7oeuQktpr6EJ7FzHh3Y6QEXA/n0L7CMOayUQAd7?=
 =?us-ascii?Q?bUxaMgFQzaYPgg9BpsVjP9OVis3MhdxiXoKHgwQ3rbVxRAP+Y1xvq/DLp8w1?=
 =?us-ascii?Q?vwQTQM0gsvxSptf4TwbjxSYJNWf0dghVmw/LCNfi2MymPI2AXfzy6Dq+Auni?=
 =?us-ascii?Q?ohoYeWhZFTwbjuy8f/ZlHyvZVrs3S3xYX6OFCIXbA3pv8sHr1ablOVEhBSBY?=
 =?us-ascii?Q?tKCr3FKrnESJMZdUUYchoCo3dH4DBWi22ad1dfpLB7I85CQeNZKr+Y91j8gG?=
 =?us-ascii?Q?MFCCk+LMPuQ8s7+gBL0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd519ffe-b79a-4fbd-9ad3-08dcf308bf8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:16:47.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XinSo7ss1LW/l5WO7fKdemnSdBl1bFsWdIyHkn2NVRHTFL3DDpBiq1dMn6O2whjuuBbBmCoGiOptK5jluCVv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9232

> > > @@ -1726,9 +1728,15 @@ void enetc_get_si_caps(struct enetc_si *si)
> > >  	si->num_rx_rings =3D (val >> 16) & 0xff;
> > >  	si->num_tx_rings =3D val & 0xff;
> > >
> > > -	val =3D enetc_rd(hw, ENETC_SIRFSCAPR);
> > > -	si->num_fs_entries =3D ENETC_SIRFSCAPR_GET_NUM_RFS(val);
> > > -	si->num_fs_entries =3D min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
> > > +	val =3D enetc_rd(hw, ENETC_SIPCAPR0);
> > > +	if (val & ENETC_SIPCAPR0_RFS) {
> > > +		val =3D enetc_rd(hw, ENETC_SIRFSCAPR);
> > > +		si->num_fs_entries =3D ENETC_SIRFSCAPR_GET_NUM_RFS(val);
> > > +		si->num_fs_entries =3D min(si->num_fs_entries,
> ENETC_MAX_RFS_SIZE);
> > > +	} else {
> > > +		/* ENETC which not supports RFS */
> > > +		si->num_fs_entries =3D 0;
> > > +	}
> > >
> > >  	si->num_rss =3D 0;
> > >  	val =3D enetc_rd(hw, ENETC_SIPCAPR0); @@ -1742,8 +1750,11 @@
> void
> > > enetc_get_si_caps(struct enetc_si *si)
> > >  	if (val & ENETC_SIPCAPR0_QBV)
> > >  		si->hw_features |=3D ENETC_SI_F_QBV;
> > >
> > > -	if (val & ENETC_SIPCAPR0_QBU)
> > > +	if (val & ENETC_SIPCAPR0_QBU) {
> > >  		si->hw_features |=3D ENETC_SI_F_QBU;
> > > +		si->pmac_offset =3D is_enetc_rev1(si) ? ENETC_PMAC_OFFSET :
> > > +						      ENETC4_PMAC_OFFSET;
> >
> > pmac_offset should not relate with ENETC_SIPCAPR0_QBU.
> > such data should be in drvdata generally.
> >
> > pmac_offset always be ENETC_PMAC_OFFSET at ver1 and
> ENETC4_PMAC_OFFSET
> > at rev4 regardless if support ENETC_SIPCAPR0_QBU.
> >
>=20

Sorry, I missed this comment.

pmac_offset is related with 802.1 Qbu (preemption), the ENETC has two MACs =
if
it supports 802.1 Qbu, one is the express MAC (eMAC), the other is the pree=
mptive
MAC (pMAC). If the ENETC does not support 802.1 Qbu, it only has eMAC.

>=20
> > > +	}
> > >
> > >  	if (val & ENETC_SIPCAPR0_PSFP)
> > >  		si->hw_features |=3D ENETC_SI_F_PSFP; @@ -2056,7 +2067,7 @@
> int
> > > enetc_configure_si(struct enetc_ndev_priv *priv)
> > >  	/* enable SI */
> > >  	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
> > >
> > > -	if (si->num_rss) {
> > > +	if (si->num_rss && is_enetc_rev1(si)) {
> > >  		err =3D enetc_setup_default_rss_table(si, priv->num_rx_rings);
> > >  		if (err)
> > >  			return err;
> > > @@ -2080,9 +2091,9 @@ void enetc_init_si_rings_params(struct
> > enetc_ndev_priv *priv)
> > >  	 */
> > >  	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);
> > >  	priv->num_tx_rings =3D si->num_tx_rings;
> > > -	priv->bdr_int_num =3D cpus;
> > > +	priv->bdr_int_num =3D priv->num_rx_rings;
> > >  	priv->ic_mode =3D ENETC_IC_RX_ADAPTIVE | ENETC_IC_TX_MANUAL;
> > > -	priv->tx_ictt =3D ENETC_TXIC_TIMETHR;
> > > +	priv->tx_ictt =3D enetc_usecs_to_cycles(600, priv->sysclk_freq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(enetc_init_si_rings_params);
> > >
> > > @@ -2475,10 +2486,14 @@ int enetc_open(struct net_device *ndev)
> > >
> > >  	extended =3D !!(priv->active_offloads & ENETC_F_RX_TSTAMP);
> > >
> > > -	err =3D enetc_setup_irqs(priv);
> > > +	err =3D clk_prepare_enable(priv->ref_clk);
> > >  	if (err)
> > >  		return err;
> > >
> > > +	err =3D enetc_setup_irqs(priv);
> > > +	if (err)
> > > +		goto err_setup_irqs;
> > > +
> > >  	err =3D enetc_phylink_connect(ndev);
> > >  	if (err)
> > >  		goto err_phy_connect;
> > > @@ -2510,6 +2525,8 @@ int enetc_open(struct net_device *ndev)
> > >  		phylink_disconnect_phy(priv->phylink);
> > >  err_phy_connect:
> > >  	enetc_free_irqs(priv);
> > > +err_setup_irqs:
> > > +	clk_disable_unprepare(priv->ref_clk);
> > >
> > >  	return err;
> > >  }
> > > @@ -2559,6 +2576,7 @@ int enetc_close(struct net_device *ndev)
> > >  	enetc_assign_tx_resources(priv, NULL);
> > >
> > >  	enetc_free_irqs(priv);
> > > +	clk_disable_unprepare(priv->ref_clk);
> > >
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > index 97524dfa234c..fe4bc082b3cf 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > @@ -14,6 +14,7 @@
> > >  #include <net/xdp.h>
> > >
> > >  #include "enetc_hw.h"
> > > +#include "enetc4_hw.h"
> > >
> > >  #define ENETC_MAC_MAXFRM_SIZE	9600
> > >  #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
> > > @@ -247,10 +248,16 @@ struct enetc_si {
> > >  	int num_rss; /* number of RSS buckets */
> > >  	unsigned short pad;
> > >  	int hw_features;
> > > +	int pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> > >  };
> > >
> > >  #define ENETC_SI_ALIGN	32
> > >
> > > +static inline bool is_enetc_rev1(struct enetc_si *si) {
> > > +	return si->pdev->revision =3D=3D ENETC_REV1; }
> > > +
> > >  static inline void *enetc_si_priv(const struct enetc_si *si)  {
> > >  	return (char *)si + ALIGN(sizeof(struct enetc_si),
> > > ENETC_SI_ALIGN); @@ -302,7 +309,7 @@ struct enetc_cls_rule {
> > >  	int used;
> > >  };
> > >
> > > -#define ENETC_MAX_BDR_INT	2 /* fixed to max # of available cpus */
> > > +#define ENETC_MAX_BDR_INT	6 /* fixed to max # of available cpus */
> > >  struct psfp_cap {
> > >  	u32 max_streamid;
> > >  	u32 max_psfp_filter;
> > > @@ -340,7 +347,6 @@ enum enetc_ic_mode {
> > >
> > >  #define ENETC_RXIC_PKTTHR	min_t(u32, 256,
> > ENETC_RX_RING_DEFAULT_SIZE / 2)
> > >  #define ENETC_TXIC_PKTTHR	min_t(u32, 128,
> > ENETC_TX_RING_DEFAULT_SIZE / 2)
> > > -#define ENETC_TXIC_TIMETHR	enetc_usecs_to_cycles(600)
> > >
> > >  struct enetc_ndev_priv {
> > >  	struct net_device *ndev;
> > > @@ -388,6 +394,9 @@ struct enetc_ndev_priv {
> > >  	 * and link state updates
> > >  	 */
> > >  	struct mutex		mm_lock;
> > > +
> > > +	struct clk *ref_clk; /* RGMII/RMII reference clock */
> > > +	u64 sysclk_freq; /* NETC system clock frequency */
> >
> > You can get ref_clk from dt, why not get sysclk from dt also and fetch
> > frequency from clock provider instead of hardcode in driver.
> >
>=20
> I explained it in the v3 patch, maybe you missed the reply.
>=20
> There are two reasons are as follows.
> The first reason is that ENETC VF does not have a DT node, so VF cannot g=
et the
> system clock from DT.
>=20
> The second reason is that S32 platform also not use the clocks property i=
n DT, so
> this solution is not suitable for S32 platform. In addition, for i.MX pla=
tforms,
> there is a 1/2 divider inside the NETCMIX, the clock rate we get from
> clk_get_rate() is 666MHz, and we need to divide by 2 to get the correct s=
ystem
> clock rate. But S32 does not have a NETCMIX so there may not have a 1/2
> divider or may have other dividers, even if it supports the clocks proper=
ty, the
> calculation of getting the system clock rate is different.
> Therefore, the hardcode based on the IP revision is simpler and clearer, =
and can
> be shared by both PF and VFs.
>=20
> > >  };
> > > +static void enetc4_pf_reset_tc_msdu(struct enetc_hw *hw) {
> > > +	u32 val =3D ENETC_MAC_MAXFRM_SIZE;
> > > +	int tc;
> > > +
> > > +	val =3D u32_replace_bits(val, SDU_TYPE_MPDU,
> PTCTMSDUR_SDU_TYPE);
> > > +
> > > +	for (tc =3D 0; tc < 8; tc++)
> >
> > hard code 8? can you macro for it?
> >
>=20
> Okay, I will add a macro for the TC number.
>=20
> > > +		enetc_port_wr(hw, ENETC4_PTCTMSDUR(tc), val); }
> > > +
> > > a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > > b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > > index dfcaac302e24..2295742b7090 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> > > @@ -133,6 +133,8 @@ static void enetc_vf_netdev_setup(struct
> > > enetc_si *si,
> > struct net_device *ndev,
> > >  	ndev->watchdog_timeo =3D 5 * HZ;
> > >  	ndev->max_mtu =3D ENETC_MAX_MTU;
> > >
> > > +	priv->sysclk_freq =3D ENETC_CLK_400M;
> > > +
> >
> > why vf is fixed at 400M?
> >
>=20
> Because I have not added the VF support for i.MX95 ENETC, so the current =
VF
> driver is still only available for LS1028A ENETC. I can add a comment her=
e, so as
> not to confuse others.

