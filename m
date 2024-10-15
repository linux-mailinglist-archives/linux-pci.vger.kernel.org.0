Return-Path: <linux-pci+bounces-14557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495899F2C9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B161F24288
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A41F6677;
	Tue, 15 Oct 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLx2j4tp"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013039.outbound.protection.outlook.com [52.101.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DA1B395E;
	Tue, 15 Oct 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010039; cv=fail; b=WFxOfRPSVm+5a8bUaefWuzsoL9P13eKfLT9dhwzV0sYfGJZ9Pj8BtaOvoXPSFsBZthfRO3mNC9xdeEOApeFkgLIff3lC6JtV2mv8q3cmeIjbzjsZ91WG8w9MT9vVMZ0sK9x7bNnLlXxwwwLNfq9dkMNUUH2itfnYmWjphpz5tLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010039; c=relaxed/simple;
	bh=MW/ITCXNsFiPn0vlY9j5HepzDjLQgyu9j+mURA4Y01o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H2BhknigS26jVRBynkpWAS1OB2ZRBY3K1a0PNEjfcoCIsKkHcVA7Cq2e/iWShXQg5AbdwQ743yprJgcI04d2juppFpvXrfRl9emtWbcZrbI/XVfCLdFQ0cdPTLKfkThNHSwlhvu3oRpNxhxQHZoNalQFgt6e2uaIaQgGudJs2Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLx2j4tp; arc=fail smtp.client-ip=52.101.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os1qWm9HGVzv1RnrveKI+LhYWfpn3bCpgWrEa/JpuPlPVMVUh1g3IPt6B6Kk40F5ckoq8ViEx1lcwb02k4euCEeci4wg4rb7yuwjiFxnaNktlqEElRV9DHLITmxnwnIUo2i8VQs9hfuly4Hm7yKNjj+nBhh2/2FV+WQPXwOGG15RYN+M99l45BYvEuDOqLcQnBpTH6pysZrgwrFMpU79hNJUUCf6LKZ6o/YvlSxc16Ty4a92oU/4qva11joPTpbhTZW4UGpy6Pu4dUKhLgixXGZfS4kqRorjkL38XL+dGD4Cgl6FGIpLedbRqg4EUv2tPQvn74PIxhPYP/L9hmyz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAHFXR8KOTm8soFSJ1voS3z78tuu+hhmAT/Rplbl9Xs=;
 b=aVmWLDC22/om3t4WeAi8dtjfy8gH8xJslliV9A9LTkLfAseaZEVxmzdGylam/1mAf/yup+yA5uK3uU9nkA91Jo5B3VpaT9T7OKbnXQBpWJsB2bp+6M5VzemOPkdXdpfxaG3dVovM4hi9t/lRQ0tMtjsTZgPAoUfAJhwcJxXZSmILXf7sIb387GVkAoFDRVyWAFwgcD6Tx557PiGOfPD4rzqdVz3Vn1D1lBR6cH74GgABjCRW3jFQnbnI+Jhhstuh8RMtsYpDe++dfV76V+Jr1od6R9NVx7VcX0lHVoJx+m0jYLhBnhSQ8cwkg/6NYxcqk4lRq9qT1n4czl2ljYguBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAHFXR8KOTm8soFSJ1voS3z78tuu+hhmAT/Rplbl9Xs=;
 b=ZLx2j4tprWCVO3U5Q/l6/9+vwrgGa6+ATgZY7cUEmJMf3Pt9mQmQCpSDE++laFooZgH91kysr302dDUIKEwoalY/IkaZJN6Qhlns+wHoi+01g2KPJrGCtnAJDKt9gy3FhOb7xbwC3jb89XsWw1tEsT2xoDZIkPNMcjYnB5PcNn/g8EPFV99K9hgJDqtCJjTBt6a8cHLGHwhegYn+YgaZqdDuuVPPzvwyl+apWx1ayjwEVulROMTbAjZrK1Ts2kVR9/Do5S+4As5TCwycvdwGmf47AjvZVgQIBHr6Th3AYf4IeA9DJnxLV8RriySqfLLB2OXjkaWEbUyNxrz9VagUWg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:33:50 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:33:50 +0000
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
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbHwQsf5vmrEaZEEimWn51Itsn0LKH/3Vw
Date: Tue, 15 Oct 2024 16:33:49 +0000
Message-ID:
 <AS8PR04MB88494082BF14B480936F6DA996452@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
In-Reply-To: <20241015125841.1075560-11-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|VI0PR04MB10568:EE_
x-ms-office365-filtering-correlation-id: c0e87707-5b40-4d80-4b47-08dced37263b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rNtV8tk/miFfYr1gsZor+4qttTaDRcXYxmM/EZeVqnrMRUEBigLpdw8pzVWF?=
 =?us-ascii?Q?AqSnfsI9qaC46UYuUH+MIozZjcYdK2rewyicRXPW/LkgVcrYeTmHxiTTecv+?=
 =?us-ascii?Q?Jf4t9kmjkDN3X5za/84gTZCnIvDryjPR0moijCyl3aNf7HUeojJbFmJ7mjlq?=
 =?us-ascii?Q?4hTQqiUZWfOIHHtP9N/RTGiG847VEGfvigSm7Q1BmGYvvHp5QDL3ZNkFnI6n?=
 =?us-ascii?Q?6mMm0hnUwpIAARepmzSNUOxoswfPgUBe+MekQVplLo+x+Izv0Z06158wy+/J?=
 =?us-ascii?Q?uHzZ8/0wMzke3kpv3h8EPDhQpqVpnT53VDSf49Bk4620PZceLe8hth/6fD9G?=
 =?us-ascii?Q?WEHYGH5xQGcHUoGtD8L6bFvyGi67LNsmuWTcStXFEq54m4vo3QDs/I22kYGp?=
 =?us-ascii?Q?h+/K2GG6IZEM28QzQAMwhNgyincy9/a7Gt0hY5MlaWAQ/W4yrf2BocpHg9/F?=
 =?us-ascii?Q?aJdfy3c4cgMIbk7mqElMLwoM5k022DGwuaMAZMxNQKn7Kv8CP2F9lD+8kjWA?=
 =?us-ascii?Q?gZzXbVujQb1uWnv//57ltBLJrex+1BHvL5kt5zTEO2pjHrGRHITzRuegIkje?=
 =?us-ascii?Q?Luyd2w1OA5C+YeHDZ1cBvZUBWiCmJpQtjW9s+oNPzySWMawvCTE9DSLopi6D?=
 =?us-ascii?Q?FqAPFwIB7+X2tUvKYSSemxb5DAE+EMNxd+Ftw+PSotkhaj23KyQaA2LHeH+Z?=
 =?us-ascii?Q?91/PXDRW9dOaCQnyShATPHX7MuXqGTRZGEzJuYb8Ab70CYeADr6MduzqoQly?=
 =?us-ascii?Q?TQkMRdgdwYp0kOCy0nAVknN0MsSz41xBdDVGgNH7+4fTWq/y569B/AWputSK?=
 =?us-ascii?Q?TV5FD7jBeSUtGYjEwqgPtj2F4E2w6EsQRjBKJz/IkVZ+WhRL9jwP7A1uol/e?=
 =?us-ascii?Q?s9SdkqeidczB8qbrtSs6BIZi5KZgGQ9lVLaB0zzpvnS0z3cYms82Is6WDMb5?=
 =?us-ascii?Q?jrSbCeeIYlYpADjh2cEiys+mKelG7TePpug4C77qegIt0zsD19r3r/zCphby?=
 =?us-ascii?Q?nxOsU7vu6Nj/6ZwAEYsewT9ZYEdiRZ4TqAod5w46155bDgtJH+fxBPPU9oC3?=
 =?us-ascii?Q?aN/PsyvCfNm9dQ4zmX5P2YCmNMSJdFj1kUUmPu5S1Cxq4rchLiy42skxUOKd?=
 =?us-ascii?Q?bIUigpWEsrtqZ4es0ASioq+oUGQqc0P7RsTAoBq8SQT4Bsmj+PdI2VPvxmyF?=
 =?us-ascii?Q?eAkYvBdGlO49Wj/Kq9VfIb+pVCSKeSErP891vVTHnacVWRHj+wCM7fzK7j54?=
 =?us-ascii?Q?iuJHuFY9JmbahMcodSn7uEJWzGNcYaVzNEPdz+lov/sVAaQuTt98MbOky7S1?=
 =?us-ascii?Q?ffVUOquRLHB7e7SVMAmk1u3PNPwc5s7VfCMd5SiSMVXGHPdxXU64Lw0Xtd00?=
 =?us-ascii?Q?Xe0dsbw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c2eg7pReY/b50P5wBRYptUvmq2uCYbJkkYvIf8QFLjx3ZG4IxIWL/RHmllHU?=
 =?us-ascii?Q?83OicLySA3Ura48UinlsgNHKjLCBdSdMkNGVbDdHuJPd/9zdj8ZDHjVsS2LG?=
 =?us-ascii?Q?gZNRh2NM9EbXovGu2ixGF1QQmo9lJuSygQA4smLmlckGRTVN0RXA3xCK4Rvv?=
 =?us-ascii?Q?lSA/XfzIaMEBqiJvb+KpxTWusS65seSEpmUADIsnlXaxEgBAyVKo8Gvs98ni?=
 =?us-ascii?Q?6dDknAaLCfxBrjzKqGcp59L/s38a4d8ECzOuObz6h1RtWG5vk6rw+5m3DIdx?=
 =?us-ascii?Q?MVn3YbmA/bEQBcPNUMUKFRYBD1zBgRFUghwY9to+pOgig82sV3zl2ORVZ/cb?=
 =?us-ascii?Q?WUY1mCZ7yMCZB0c4wd+CvQ2BURZT9/TUS+rtN64oGmXXW6XmsaTWZODod95s?=
 =?us-ascii?Q?NhZTgprZUqOFn4Z6Qpel0ijgjTKFe0ztj7NkMPBQe2SUCLClZCNsj2hlpWcD?=
 =?us-ascii?Q?JPkzcaKZVttKLqno9ejVmNrKLLcNfeGKd7cYG2OzQoQaFlDakgTJBxkZKwlE?=
 =?us-ascii?Q?W66kIA131ZYm+svaWSi+xNPohOUbHnCkQd97hXnlPZ/XoVV0aBNxqdZAqmIt?=
 =?us-ascii?Q?YLLwx5lo2WBau52YFORgx4ZBfFnEYLdbgpeQBfVdMJRVvRtfMkqd73OxgvDc?=
 =?us-ascii?Q?VYZnbvQmFQEig5FtkJcVtbNNhpYv93GnyrTjXgjLKYEhOAAECppK9cpO/q56?=
 =?us-ascii?Q?EQ0JyVOsbD6pothqxqPHAbdItuYtQ80rE0sbf+M/h13HdJKWArpApKuwZ652?=
 =?us-ascii?Q?dWf+aPhf8XJg6NWLgW/WtpUlPXGV6gZXbQpazeTgU/V2Lgcgrt58xPXCkW1J?=
 =?us-ascii?Q?zS+WTl3RrdCFrbN5sn49XLBrJfGg6WU0TjkjYY2M4y4I/tJzZtReTs5/nDPl?=
 =?us-ascii?Q?ITDhr/tLMGqMtlhw3D0C2rowBq0/9dp1PRRvqqbcW/Xfj5UGTKpmwjc69wWZ?=
 =?us-ascii?Q?XbN0+YDxcRLIgxAHENZzTrXBIjyXvWGwJ31l+Ft9rDfQqfsrfCcKchuoR1d3?=
 =?us-ascii?Q?09iExgrPOl6Lf6pv5rlC150tmi7B5wSUBHIIKLCO2g9MlniM9q02GU/RMuML?=
 =?us-ascii?Q?PUpjxTgREjk/CRxqff9SooAVqCBCWxTv/wmHXUp+uVu5z7M/glrjuEe6I8fw?=
 =?us-ascii?Q?jBye+qA4VgxNAOHCMQdbv2+Qv09bP/12ZQcKpmraqJkfI72HyLkGkChH08UD?=
 =?us-ascii?Q?pkOqStTfl+VM29YW7cBl+VyvTdyDrJ3Di7y3hJhg0iqfon5w/NGxoNHPI3kd?=
 =?us-ascii?Q?oq2wP29v1pDYkjNh0z1Lz0g5ewzutlKF6VP8/Zbnu+5ycCURu5RmDKt33uIj?=
 =?us-ascii?Q?P/54Yz0sdVORVer7rFGCFIjHLDgNbBZ1TAl3Q5bj4EHjEI9ematEeA1Uw54B?=
 =?us-ascii?Q?Jn443p8K9AId6XHL/y9tZQzwH4+n4qDpSo0kUAVQbXAGqrKkofDyxAxsqO5i?=
 =?us-ascii?Q?z00225R8GGpbxjaZbSCIoAR2X3Pb/q0wg4WeovX4hCkezTokOUMiNaQucIm+?=
 =?us-ascii?Q?XGoGeCCcjKx5rl8c1IrwtLGygEwUOX2hc7UxqgzIZqeKQKd3RCpbxC05FWX/?=
 =?us-ascii?Q?2lNljIepAbbGtLgLSKekw6jniispliFwcmSCVa3+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e87707-5b40-4d80-4b47-08dced37263b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:33:49.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqmVoEPf8S4Jb7gRu/7wBA7LfmG9L2+kGAS2iEI2zMejUtMsy9XOxyvB6VaHSoNaUPdN9WTgwKlxcNEkibW+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 15, 2024 3:59 PM
[...]
> Subject: [PATCH v2 net-next 10/13] net: enetc: extract
> enetc_int_vector_init/destroy() from enetc_alloc_msix()
>=20
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Separate enetc_int_vector_init() from the
> original patch. In addition, add new help function
> enetc_int_vector_destroy().
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 174 +++++++++----------
>  1 file changed, 87 insertions(+), 87 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..d36af3f8ba31 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct
> ifreq *rq, int cmd)
>  }
>  EXPORT_SYMBOL_GPL(enetc_ioctl);
>=20
> +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> +				 int v_tx_rings)
> +{
> +	struct enetc_int_vector *v __free(kfree);
> +	struct enetc_bdr *bdr;
> +	int j, err;
> +
> +	v =3D kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> +	if (!v)
> +		return -ENOMEM;
> +
> +	bdr =3D &v->rx_ring;
> +	bdr->index =3D i;
> +	bdr->ndev =3D priv->ndev;
> +	bdr->dev =3D priv->dev;
> +	bdr->bd_count =3D priv->rx_bd_count;
> +	bdr->buffer_offset =3D ENETC_RXB_PAD;
> +	priv->rx_ring[i] =3D bdr;
> +
> +	err =3D xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> +	if (err)
> +		return err;
> +
> +	err =3D xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> +					 MEM_TYPE_PAGE_SHARED, NULL);
> +	if (err) {
> +		xdp_rxq_info_unreg(&bdr->xdp.rxq);
> +		return err;
> +	}
> +
> +	/* init defaults for adaptive IC */
> +	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> +		v->rx_ictt =3D 0x1;
> +		v->rx_dim_en =3D true;
> +	}
> +
> +	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> +	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> +	v->count_tx_rings =3D v_tx_rings;
> +
> +	for (j =3D 0; j < v_tx_rings; j++) {
> +		int idx;
> +
> +		/* default tx ring mapping policy */
> +		idx =3D priv->bdr_int_num * j + i;
> +		__set_bit(idx, &v->tx_rings_map);
> +		bdr =3D &v->tx_ring[j];
> +		bdr->index =3D idx;
> +		bdr->ndev =3D priv->ndev;
> +		bdr->dev =3D priv->dev;
> +		bdr->bd_count =3D priv->tx_bd_count;
> +		priv->tx_ring[idx] =3D bdr;
> +	}
> +
> +	priv->int_vector[i] =3D no_free_ptr(v);

This is new, and looks like it's a fix on its own. It's fixing a dangling r=
eference in int_vectror[i],
if I'm not wrong.

Other than that, like for the original patch:
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>


