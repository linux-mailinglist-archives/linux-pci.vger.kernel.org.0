Return-Path: <linux-pci+bounces-15101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7209AC15F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985881F24E68
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A2158DD0;
	Wed, 23 Oct 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aVZREeso"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C3157476;
	Wed, 23 Oct 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671533; cv=fail; b=lXQzmkHkDXGoQaH5X9F/dxsNyCzUfasPERMSjbFO5q+Rdl8CgWid96b4Oa0sHqG8iKCHwuRGcKMZ2aex8xdp5vNkFgszpYbUjGrJUMiEq6sAX305yjKdYNUas3z/Gu6nBoXnEGdV1TAXgjkUXPIhMULzZwYu6j2gBEmnCELCjYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671533; c=relaxed/simple;
	bh=sOXHi80Wj3+R2DkQNjKOIgezdQMCQ3nX+JUCca/jXU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bnc1UVkFqE+gkXCJSDOeyq2ywAbRO4la38Lym35lnvoq/4xyTgWfN0qOcCh9s1C5a9IoGWXk8kPfGdinalQG+m4zc4Jc7oVl5BU/TJfNJ7kSOa3GFxAbnEPPpBOux0G0IyD7e2hx6jyYX0tIvHGZLA00fEyq79G45LdaBC86Op0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aVZREeso; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No7dGGTLiLxPW3uP7iv5FuILhDE5xYle6vIfsfYkarw23Nh+KRFY6smmU+kg9L03J/kMPgoGHdlBTELAHH2/tRrb2CmcOoRTkhcwTXYC4+cDkh5UIEQARvcpCKX3wl0tbFsjtnwMreIdi9N+RolDxlIQ3RIycoA+CEmLNK2VhfZHgVezH2vas0HwRhZlV7Ar8vyFjgrvvZ+ZsrBoC/aFk3K4ATBZbCd7jSIt5CTrjSfL+ljhEZ1fxjsiy5izt2g3XKAFmKR4n/rltkebr/2TLWbSq8M0Tb5Ll2JqITRxiGjw3NEjDPMw/kCN5MfYo+kF0AM5lU0YJBCoSZDd0TU7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBaKQcT1Cx0jrBSSkCevsGKVzSnzcBdEuJQAvm53few=;
 b=kWRpbCnkXraVDqi/yXu2AxMEvBxh6GniZNM0G4PLS8qvTS0DBc61V/E4eCx+ZeUkDl+pFWHimYNNpFGfkqXgKDw2Dd526ihG2SOj5Quuf2GgWq8FpMYhmLEXxHmtcIiNArpPsvkpWeyAFtbiYXqEBnxUe+WB8fWcAmTiZxfo+uQkTHH1ZUJchG5rzzOLMsd4vg+nD54Ns2JDhkGdiNF+RxGMKekB+Uz1kjtb2g+y+bvS57el/SMwW8abYfgb5ahjFkb2gmvB2lq1mJ18vV9l+/xQxkA/H68+o8474jaYD+GYyGzhODixVAUgEsKQxqe4YaHhKGxjop5pW9GgLObpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBaKQcT1Cx0jrBSSkCevsGKVzSnzcBdEuJQAvm53few=;
 b=aVZREesoEOTsQtWPbxMT8jqRs3/vrkLrTNJgA2KTiE7pC7qZN8GOWUaeLqp0XKiOfZHR6/M9zTSyQr2nRTvz+YSNEDqMa0r2XX41kXYZeG5usfXfyynt55YqIBJlw6DVmTV5vUX9wMdrXU4jZ/N92gR5FlpWAUuX6mdL7DnHkb/HAtohaKhxHPe8zG+ecyuvNSbt6h5EMaQAdAb4etc24OZQY9+TsnnP1A9vkHzcGDxuzlnfrMu89tB4At9b+krBE5v1ELmSHa4uLeWr++T70a6167N2C5IYORXA4gZWbh67dhFeUMK+7iKWcX0fzbnO8VCh+Mn7ukkQw4rl9ASS2A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10387.eurprd04.prod.outlook.com (2603:10a6:10:568::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 08:18:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 08:18:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObA=
Date: Wed, 23 Oct 2024 08:18:43 +0000
Message-ID:
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
In-Reply-To: <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10387:EE_
x-ms-office365-filtering-correlation-id: f9a1c7c9-a24a-45b7-d1e4-08dcf33b4f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GJ5Vg3BAGDKuPetWoctP3s6+urnlyB0MkgzPOqS8192Ymlaf6Zoc/9/GUvVe?=
 =?us-ascii?Q?PUjHwd6zGGGldh5iPHj7mPk6xsmPOgODtmzE2ozRjYCe0q/gfPkQexr63a8B?=
 =?us-ascii?Q?hjGeJb02Bke4IbrITfgebeqW1pkwf0uStUnbCvaojJc9R4DV/9Uumr2ngAln?=
 =?us-ascii?Q?e6fgU2WKlhOmo9poa6+Ig3o8mxBEYHy10VHrb38U2Ma+685TmZuKO7mPhe8h?=
 =?us-ascii?Q?PDEKrpyBMXuNSudEgxUfew8TXGtmbl3HsVQRH1Fp2F9DlZ91+jRsRaJQs+QQ?=
 =?us-ascii?Q?UAHrvzNxP0dpAKah3ehI/b38YWnFHhp0FFjTTxItd9YHFHxNvnfnKxwZkMV6?=
 =?us-ascii?Q?OfYMkkHkgP3LWhoBCkysMvnvMlFDAy+yePcv7W9ydpC6o0sKiibAcZAyJB4B?=
 =?us-ascii?Q?h0/FP5zDlGVXFiFOimYD/8/DKoW5O1Ny3t44xeg2u6zk6mxK+/LkopIlO+p8?=
 =?us-ascii?Q?HebTtHdWveRmIUYh+csgjh9GnrlAeDSyAgmoGBansSi7tkfvcUykYuSrDVUY?=
 =?us-ascii?Q?Baq2MsqvhC4ONMaL39Rfnm/FBz2eyJlU5cstirX3jGhlHCOj+WQgKaOKZhf1?=
 =?us-ascii?Q?KbsIWUL8Sji5cIMBhPO1IO1vf2xU/WdIMLBTiWKKojU2ZUBKA3gzKagHDgqb?=
 =?us-ascii?Q?BI+kD/grEVWIUAMpgjxgMRPLJGychFFwK2NQbIY9NNqPLv7UqmoG1RrQ3+7i?=
 =?us-ascii?Q?I5dOwrAXumaY1g49YRsD7Dc7pF3GDvqt2sJzVzgCxOwkpIK05CXooiSgGeMQ?=
 =?us-ascii?Q?v49cNWHLKUJLWZ4+Xis2HfgX1F5SO870RVrLYTLxli1xfPfLwSoyE5LRPYiR?=
 =?us-ascii?Q?HhwRncgfl2rmw5l+cmw0t7ZyzkggpaDsGA+DW/kv0ZeASOUtQbxAu/biR4QV?=
 =?us-ascii?Q?6eH3JLY0IvmYLQoRYIyevQyszz88V+HvjKM59nfThornh6QXSboGif1Ro9ah?=
 =?us-ascii?Q?R8YtAltwA7p3QdSR7lgKOszn2/fALj9z7NHAEKhrioiaOmE4KxIgggUMbsaX?=
 =?us-ascii?Q?n6HLal30pBJfT9e1F8cXmxueL955FTHlj9jv0m6OLgp+gU88joo9jvLIk/nC?=
 =?us-ascii?Q?e+MDJunjIQCOhfU7FT2lvM47j25hKqJXPK7uWRpeI7DCnzy9Y/QhtGQlJJPj?=
 =?us-ascii?Q?jiWeI62IOc7annlP7U3LzqdROBDz7UgQanWpdoSINvj2IMzi8XjkgBMA9iME?=
 =?us-ascii?Q?kPsCrZBP9+wI2YnsgDco9qgdCFuLSqr1+4gwb8yZcyqtAFg2YNQOAgmU7crs?=
 =?us-ascii?Q?hFw4Szp6lQpmMew2eF/wril6NbEm8+hxxqlawiEibpTmGKeGGa0wEjLjOBoD?=
 =?us-ascii?Q?EE06Ohk/9jnIIEpL875T+uXcSf4WTEEOYAjmRE5RLnfpDGAHiQgvA1oQRHBL?=
 =?us-ascii?Q?zJD8lD4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Q+F9W+jenTvUfLv0aaPvf/+ev2ar18PgYxRpTJ7cH2rnnzTyIYKTp47cdhi?=
 =?us-ascii?Q?Q1ruTqTXXoy4Yuaak8kJUPZzm1Ck4OmUKuTbQ/BvshvTnUVhqiF1JWDR6icI?=
 =?us-ascii?Q?X1TSAkUV2ZjoaIpRUsVI2VZys1hJZSGBA4ADe6EI+U5p2DZqm5IByiDZXPAf?=
 =?us-ascii?Q?TWh4Sdh66TE7Pgg/H1/76/t1qC7o6KjP7gEkVD7HvfzhVinGERlqMPOk7mch?=
 =?us-ascii?Q?WgYArq5WtbIYgv+lIQY0BvR/Ze0UunU7fDdThudpb3u4bl9W3anpBOX4p9M4?=
 =?us-ascii?Q?Uc9aOsBuryJgCAJZg4ooyg9aOPb8zFlb4QaXuhODA5C7BINSxSOLbP73rZyC?=
 =?us-ascii?Q?niDTdsAuiSqqPXvTIGk40Q21REq2+ihUEr+4Dki24mFo7RVlwzHE8K+lXM9G?=
 =?us-ascii?Q?kX81mKF2dxV+i5HQ4Gs2HMdKjHO6y9msDHh0swz2V5lqnBs5IpLx0j1DZeLT?=
 =?us-ascii?Q?v3nk9rpQEO0rRWtL1jWPN5TVTVVrxQzLFBwz49TMxrm6KvQm7BNGKjjcpOcl?=
 =?us-ascii?Q?GbRYR1QyUPxHI1USNi2NtDr/rHbw7SHMDodM00hwU9n8Si4ki9wGhIL1icg5?=
 =?us-ascii?Q?2XRUHu3TmAfzcU95E5wHlMGayvctBNXscXItuF8ixeyF0cgAJp8h639sB0FJ?=
 =?us-ascii?Q?VTNyJ6fwGvxQwtNLwttUyiCPOM15+ZUZIl5zltVlmKubCGzDJCBLQklJ8nSZ?=
 =?us-ascii?Q?NyTsNO2ith8bmdv0j6wIKSDGW6vOlhgYNt0XbruoHFWAR/P6pDUzc2A1TuSw?=
 =?us-ascii?Q?bMBXGhdt4Iox/pYHCGJ2Flo575191dzsE5boEKeq2N4OsAf+TXU73MMEuQKj?=
 =?us-ascii?Q?o0U5hF9VJLFeS+LRZtd/ag4wruESPotLles4L2SsFlkBMvERRft2B6A4WCUl?=
 =?us-ascii?Q?LDxC0BFFS2pKcB4aAjkT4scqtHGCaqM8CdeC50aH3TW1FO0wuxrG0PKfIkPt?=
 =?us-ascii?Q?j8YqGqmxvTWIKzs77jBpu3s1nhewBspJSHEwiwi+NMpwi9beKMODXlTXd38B?=
 =?us-ascii?Q?vEa173FA2yeYxadnWrmW8gIe2NCvmYQ3080lke72kPQSiqA4l/LcXbWzueCp?=
 =?us-ascii?Q?gSMqUzkXwUYVJPUaY+/lJO0SN13NPY5XHHNNoFc6SYjXjAYEiBCUcOk+wmLB?=
 =?us-ascii?Q?Fp818wIU34ZBnA6dAy/zxExv93x2ma2YcEqIcCLH1bDA7uORuhSw27hz1axm?=
 =?us-ascii?Q?fX+LZWTtIQKzlqqvfCAqWgqMQx8Z7DwOpexNnR6QsIjb52kk6SeECw77tf7i?=
 =?us-ascii?Q?4pVQp5UR2EEa2IHiIX4NEuRdvLbzExKLoq03LQeYLq9bplpxF0WNvaCHDHbB?=
 =?us-ascii?Q?EkfgCluSueN2JqVNwT4omcMZ805skub5GTs8dzzlAYggzCli+pBtJizrQB1F?=
 =?us-ascii?Q?LulTO5s0kSC4NsVeeQUEcYz0dBUADyXMZImjW3qLbgRCXLsdRFqybi0wCZH/?=
 =?us-ascii?Q?PfwA7XOwnLY9rH8t6avQcgLg+cu+9SrIRRyLya4UGhim+TEFPlrZ9OcfG7sP?=
 =?us-ascii?Q?+ueFBMvnJEw6fqAI4Qk4RLy5wzh7ArWVPKEDm2rswpOXAnpu3B2gT1nrTXT2?=
 =?us-ascii?Q?e7ytRKpzuVGr4LY/T68=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a1c7c9-a24a-45b7-d1e4-08dcf33b4f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 08:18:43.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+mVqgGvDJ0voceyqtPOuo7ID+AlJBqY63s3ocKOmG/fYJGcX9thBhSMoNmLn7wH/+5bbK1o5KRmTMWa5l6TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10387

> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +  - Clark Wang <xiaoning.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,imx95-netc-blk-ctrl
> > +
> > +  reg:
> > +    minItems: 2
> > +    maxItems: 3
>=20
> You have one device, why this is flexible? Device either has exactly 2
> or exactly 3 IO spaces, not both depending on the context.
>=20

There are three register blocks, IERB and PRB are inside NETC IP, but NETCM=
IX
is outside NETC. There are dependencies between these three blocks, so it i=
s
better to configure them in one driver. But for other platforms like S32, i=
t does
not have NETCMIX, so NETCMIX is optional.

> > +
> > +  reg-names:
> > +    minItems: 2
> > +    items:
> > +      - const: ierb
> > +      - const: prb
> > +      - const: netcmix
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  ranges: true
> > +  assigned-clocks: true
> > +  assigned-clock-parents: true
> > +  assigned-clock-rates: true
>=20
> Drop these three.
>=20

Okay, I will drop them. Thanks.

> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: ipg
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^pcie@[0-9a-f]+$":
> > +    $ref: /schemas/pci/host-generic-pci.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        netc-blk-ctrl@4cde0000 {
>=20
> system-controller? Don't use compatible as node name.
>=20

netc-blk-ctrl provides pre-configuration and warm reset services for the en=
tire NETC
IP, so system-controller sounds good.

> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdevic=
etr
> ee-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basic=
s.
> html%23generic-names-recommendation&data=3D05%7C02%7Cwei.fang%40nx
> p.com%7C35715ef05b824c5d479f08dcf32fd256%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638652633944352532%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C0%7C%7C%7C&sdata=3DunWcE1OaH2Id%2FEny9UFAUH%2F5Xablg
> PM0Yj4Br2jfQuI%3D&reserved=3D0
>=20
> Best regards,
> Krzysztof


