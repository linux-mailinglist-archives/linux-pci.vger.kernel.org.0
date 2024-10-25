Return-Path: <linux-pci+bounces-15257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7A9AF7C8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15D1283011
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF8175D56;
	Fri, 25 Oct 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4qMCQOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D322B644;
	Fri, 25 Oct 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825249; cv=fail; b=XxeY4RoA1E/OeD8TkaJWKWf8xahgNRbYsgj0ru4AKPduwrymsc5a71oC06URAFd3NRFQ13E6XvKxFGkvWJvtMsHyLpaO/8LHs7E0613J0s1ApKl14QLI0e/qkxUQQP2V+IgOqrQRV6g+7zko0f26lLrK3T6KH+czU4YEY7P5PZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825249; c=relaxed/simple;
	bh=atQ+eQFrAjxcOgD789EMyGrS4Aeq8/xnHEYDL8q4bMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qeQzDuIcQ+SHwCmbZ+yExB/3JTzsw2Cp7r+VuaZjqJ6LOP73eJ3P+/+2bN8QCkzgFCp02FwbrgIACGOpMdkuXwqsqT8ZnqHl1997pTd7Sd7fugwTqhtJhN49oN3Q1eBmcvshmo/p2U+iKlmfg+Sfhjuc1IRQqP/fop7mu1g47hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V4qMCQOw; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlTH2aUjheSgml6o5lzYWGIxWlYOkr4pBmPoW8hcboeSq4uy9PyQHi+bh96htsB07lAn8dy8zQBP6LONMr5H+XE21VegyT7zhQA4K6kt35pnGnkisI5jvqyUX0WY7xsjFW2OoEOsEbpsYuvroeT55L0/xjXfYgOpTAP9+ZUUFKVvFXhfFY9qKMIhkYBLVedCoCrJmYYmVoNq7FsXf/slxp2GmeKoqNdxLKZhXN1e3d89AusoMUkWmFq7g7SB0G9pAt9yp1qIyhe8w1O5u4SqibfRWCAafEyDditIGceAG2RS6rWTDzd+fHiAlYPrYOz7HwgAu8sBiaunPfiVTd50SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkL3HM3zyrWWmZbBUFt0F05aXSJ0CbfjaF5W0Q9GsQU=;
 b=b1w2ryybvwetUi+J8dFngJ4+3G+qcLK0zGEQ9lcelmBd/kV/5icctjof7syIp3miCsghxl5dy0R8OesH4Ciu3yfC4J9210GRX8J6SH1vFH9vOojB9GN8knNxIOw5IV8w+aS/nvj4t51phNOAaAYqoLn7AvzKk53evTJxKkGzyATZnUoBsUpAj205O5BhRYCKIpCKqGvKv62shYtnIKxsFYbVzwVh8XUcUl04mhrQJldfWmbSqUU95AXN8WTJiPV8a4Bjq/w2rMUA/V1u3PP/EMvhLdXjK9xJiRlA2ZyO3XwBYvQTTTgqkC3QDHMm16nYFYBFGUnaq45hipFuFUe4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkL3HM3zyrWWmZbBUFt0F05aXSJ0CbfjaF5W0Q9GsQU=;
 b=V4qMCQOwEZ6gDDDE9+8YQ7XN2e1m6AE1F+lyIqBM347ZwXUjUwpzZwodwXMOpCtZ347aC3IgsLj+lDUBw8slcmvWeJZMvUVL+4SxVmJDsiY0TUzSjVLW6jJOq2pkQu2G/w7yTw6aDSVL4fVF+I/CtUlkc+NlM10ItuhuyCv3voy8y3kctuo89YLbV+pg2+fQXGpMFkkpupqAr8QnoL4UPnG8W7OMBNZnxiJ1MXIZLCmorzfdEvg4ayHyObgZKLVppeJnxElSiy1A5VSlGTVuPYh7lNVBNnxVmHtCPY6UeErsgzWCJvFLUufiuQQL37BYXlc5UYSuhOEm++Cg8bJ0bQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 03:00:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 03:00:42 +0000
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
Thread-Index: AQHbJeOiAKVhVEw2KE+bV6Spcx71NLKWKk+sgACUqlA=
Date: Fri, 25 Oct 2024 03:00:42 +0000
Message-ID:
 <PAXPR04MB8510468F88A236EA7ABB76D8884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024173451.wsdhghmz4vyboelu@skbuf>
In-Reply-To: <20241024173451.wsdhghmz4vyboelu@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: b7d72da6-8ca5-4d6f-0b0d-08dcf4a1367d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JNQ7uAiW9UMoB1r62y81K6HfVAG8aKwvs6dLN538ES26V8/wLhbmjFbGIJ6W?=
 =?us-ascii?Q?Fjm1TZ+sLMJG3tf8v1DhID6HNpyy5aQzp3jy6tmKYHnEhR62C7ORTS30L+dm?=
 =?us-ascii?Q?hAHAr9kK1DHZPkYBldy3vsiW72J7ksMibaOEV8rguvdBQ42aWzWHUIFtLwV7?=
 =?us-ascii?Q?tvisfw4podmTkekV+m7ef9yATNs4pv9BMN1xVnwgvF68PNibM+hKqws6+Qnp?=
 =?us-ascii?Q?/y5F27S45TGSzsWdd2dHU7rGS4xRYDrxXUzMFvNpC4Dj8e2uPnIlH/Z5WCh/?=
 =?us-ascii?Q?d6JO9UYtZz7DAtB3K6h6lbh4PDYyRqanzLa7JBIbeIDSHPCYBG6ClTs5VCqu?=
 =?us-ascii?Q?azpk57KdKo+r2LGa48eKefaJvSXPdcb5SXaXD/ykpoH6Z1ws/yKH+iI4JH5m?=
 =?us-ascii?Q?RB11bxT+BNCuuGOdwAHm25yxDXU09qApc2AvL7RFibh5x+c+iFBWRp9zUHOa?=
 =?us-ascii?Q?uPpsyLtUVcs79icoVQobYbEbQz8LIvY0JQHBrWzwerB05scFdAirI1tzdY9A?=
 =?us-ascii?Q?5VMrepCT6+r5ZEHcrL6k/pO0Cg35pP2aCJ/t4c56f+gMLBiKortdnayDSfIH?=
 =?us-ascii?Q?4QYcXYBR15jZhMG/Ogwc2NVU7UDtJw87Viwu2aMxEhhTti//dl1VoAM82maT?=
 =?us-ascii?Q?RXYBkyMi0MKs1rbbc0ql1DuM1F07a92QDxXeHHedE5ds+274uOzL2fzbadiR?=
 =?us-ascii?Q?RE06d7L68SecYBhF8h8hpkb2PCQN1S4WBpzQeIo1uG/cU/yQkbd/3MMlbl0E?=
 =?us-ascii?Q?4C72pNajc7C6dr2sReAZxHBD6SRO8f2snU+E4AqTE1+R+AKefHaxTUY7UPaf?=
 =?us-ascii?Q?7OKJdAeHNz7bunHvtWWTiX2+jmFD6rwq7VPtOnKxFqZNNhSFWIrWqp/A4v8G?=
 =?us-ascii?Q?adb3vMuJWzJshYLAeF/Mdme61pZJnkHEtpWTimZNXjVxwpfOUJPwK2b+2lih?=
 =?us-ascii?Q?CmDrVA8bDUB8I+Gl/DzfarbAD4YN/OtVfKn0g2Cau3q5AAbC+/g/hHrCiX9k?=
 =?us-ascii?Q?vcusxsqoYbhHnejIdltS3kMcdwSfvyiiylUz0SHbGrGpBBZe5IjFiUBB9Tc+?=
 =?us-ascii?Q?pLaJnTtzNMCY6uJEW6cNQAf/MMpmbnaIRkYpteJc70lujXNVfXgtNHT73EPZ?=
 =?us-ascii?Q?k7rfc3tQIlqKLsmgYV/514m/u42d7JIaGrwFNxaqqhbjfuzVV09vAQgPHXXx?=
 =?us-ascii?Q?3Ptm0P8sAEG0jWvnLUfsI6TTM6pHwOKWbsIFP0txyTCSq/2cSxEGN9jaaMaR?=
 =?us-ascii?Q?Wes3DHazEDKeUgFVMvHvvA8lgOvA2DCZITKHNyaUxGa/DnFUBkJyQyCZZARA?=
 =?us-ascii?Q?4WmQNI9CFiMqW7FPb4UP969Ily+WWxLpv1Knbgf+oKIRmWDIXqlRDfqzeLJB?=
 =?us-ascii?Q?AwijQKQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DcBCMtptxGZZjvHXswXqSu+mjEqCCJn1mbGhGj1CJejroSjxzzjB4wz+fUcM?=
 =?us-ascii?Q?isvoAl9hUAdBhzEELFjfpnc9L5cTAL9JKaVUFf0bEzA3gq1HsoN1n5Nwnvhj?=
 =?us-ascii?Q?NvoUN82IPEhcuwoT6jhjTUK8Tjbw5yLwqKbRE8chNM0HxfF/kONIr+XzvC7d?=
 =?us-ascii?Q?sTHt5Xe4vN4Knku9OSF3QjJOmSondry2wt96ifMf13lZVePwfLUU5G5nUZg9?=
 =?us-ascii?Q?9Qex7ObMly/5PUXTTDxFSkj9zl/U9M49uup4v4NjnNTBAYwZ0t1n5fQKuxnA?=
 =?us-ascii?Q?byz/xfhNu82FbiPwe9SbagCmdMoKHTb2eGioalZsT33WkfjrS3V2QMHorgIm?=
 =?us-ascii?Q?8g6PPWOtC8YH5uOruKHpT9rlkLJvkANTrEPEBw/ym9gyKjQ7jv7IBhqYwUIY?=
 =?us-ascii?Q?9DBq/qATKBaDx52gSJaYA+WMg4BcztPuNJOgQMtAGk4uIkcgZyWLNoGs1aDX?=
 =?us-ascii?Q?UaMp1U7aK6kMRluUWM4X2Z3vjFfsqGud3lz+yk0whB3wRjnWzg9jJw1Dzxxj?=
 =?us-ascii?Q?6EpB7MIAPIuDi0ZAFPjvq+0BEHIlWCAsPsjEZFXm7HpoXtdelMmbYWeQ1be0?=
 =?us-ascii?Q?DcGUfPkhn11nXEwAu4sj/wIgSJtROjdXfZEqrC148KUa2GEM1bYHk8WeQjLX?=
 =?us-ascii?Q?uPbDUaXIDYor7E8EP3OWePOl7+d8gLGvN/9g9qdi0shOE2hN8SFhBfOjhRmb?=
 =?us-ascii?Q?wwvhr08IdteTUXmvFIXcFFSw34+M/y1G6XJvHAfJj9Hiqn/wlJjXuBOYyPxI?=
 =?us-ascii?Q?w34RuHdMjNwUHPxbZnnwu3/KzU/GEH10Cut39dSvgZRS4jCdMiCSjd9e66KO?=
 =?us-ascii?Q?kwuk4mLmXgNuEa3R8wh2ma3v5hxRCiJsL6/ziDoCewGTySMz66CMutIIAkTi?=
 =?us-ascii?Q?fIxDt+Hs+l6RvK2XnFVml9cOO+cgj3TF+hRF+wJLSf7Vks+th6yN9LjRWRob?=
 =?us-ascii?Q?nErqn2EriDOuxibUojfXm+oGxGalT73VtW4tI68SM2TrHKYST9uK0kXuQXoE?=
 =?us-ascii?Q?EcIffLDT2jlaE++5ETfx0GRKqenx7ouv7tTAKOSAeATTg+UCNuCsc5nWX4mD?=
 =?us-ascii?Q?8ao1avje/3lsnRzih/uqxVo9wv41Fas15DActErItUNXncJHIzwJUDxTycCV?=
 =?us-ascii?Q?VbEBcguAF6hHXqKAjqY1cE8lt0vH9DQIHlQm+0EnpSN9j81+ZuF6bIM2fUBh?=
 =?us-ascii?Q?5Nes07xBe8AhjWX/Q3VZBEyy/dx69pkBpe3KDYg77keQI9vwriJ37DUNpx6I?=
 =?us-ascii?Q?oZoXbXfBFKIPTZmmK0GpDe1xtNLyH8K5A3hS50mo/Yc5STJ2++JR4h7K2fqK?=
 =?us-ascii?Q?IAQZMkxv1u85KLLNwY9p3nIsVRsKxIv9w2xKeFKJSXGkM2oWgGKbFExvdeSN?=
 =?us-ascii?Q?nPR/OkUpzbWiUwEHMeNCXdK09ISHWulmJLL4CZeGhuXoLKS+7IGkyGw4sYKA?=
 =?us-ascii?Q?qFZyvUtoTa83xBkodRxnlGwkIrn6krmh4ZdOuO3DpQoi6N/AG7Tcq4GH9PVF?=
 =?us-ascii?Q?3mtkqqis9x52p66Qx+HkfhP0UeROJWKBDjM862MQtbtPEv9I9AEbp3TvVXzV?=
 =?us-ascii?Q?XNDDRpfVQczztFlzu/A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d72da6-8ca5-4d6f-0b0d-08dcf4a1367d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:00:42.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHIeAlFREpJRXCG5G3L7u1h4KXGgobHRiIFuKG3RwNxhIzMcFrlvBDxu0DDgylAwkAaS39rUEZUINg0otAk7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

> > +struct enetc_pf;
> > +
> > +struct enetc_pf_ops {
> > +	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *add=
r);
> > +	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
> > +	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus=
 *bus);
> > +	void (*destroy_pcs)(struct phylink_pcs *pcs);
> > +	int (*enable_psfp)(struct enetc_ndev_priv *priv);
> > +};
> > +
> >  struct enetc_pf {
> >  	struct enetc_si *si;
> >  	int num_vfs; /* number of active VFs, after sriov_init */
> > @@ -50,6 +60,8 @@ struct enetc_pf {
> >
> >  	phy_interface_t if_mode;
> >  	struct phylink_config phylink_config;
> > +
> > +	const struct enetc_pf_ops *ops;
> >  };
> >
> >  #define phylink_to_enetc_pf(config) \
> > @@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
> >  void enetc_msg_psi_free(struct enetc_pf *pf);
> >  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16
> *status);
> >
> > -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *ad=
dr);
> > -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> > -				   const u8 *addr);
> >  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> >  int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf
> *pf);
> >  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *nde=
v,
> > @@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
> >  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_n=
ode
> *node,
> >  			 const struct phylink_mac_ops *ops);
> >  void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> > +
> > +static inline void enetc_pf_ops_register(struct enetc_pf *pf,
> > +					 const struct enetc_pf_ops *ops)
> > +{
> > +	pf->ops =3D ops;
> > +}
>=20
> I think this is more confusing than helpful? "register" suggests there
> should also be an "unregister" coming. Either "set" or just open-code
> the assignment?

Okay, I can remove this helper function, just use open-code.

>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > index bce81a4f6f88..94690ed92e3f 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > @@ -8,19 +8,37 @@
> >
> >  #include "enetc_pf.h"
> >
> > +static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_a=
ddr)
> > +{
> > +	struct enetc_hw *hw =3D &pf->si->hw;
> > +
> > +	if (pf->ops->set_si_primary_mac)
> > +		pf->ops->set_si_primary_mac(hw, si, mac_addr);
> > +	else
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
>=20
> Don't artificially create errors when there are really no errors to handl=
e.
> Both enetc_pf_ops and enetc4_pf_ops provide .set_si_primary_mac(), so it
> is unnecessary to handle the case where it isn't present. Those functions
> return void, and void can be propagated to enetc_set_si_hw_addr() as well=
.
>=20

I thought checking the pointer is safer, so you mean that pointers that are
definitely present in the current driver do not need to be checked?

> > +}
> > +
> >  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> >  {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> >  	struct sockaddr *saddr =3D addr;
> > +	int err;
> >
> >  	if (!is_valid_ether_addr(saddr->sa_data))
> >  		return -EADDRNOTAVAIL;
> >
> > +	err =3D enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
> > +	if (err)
> > +		return err;
> > +
> >  	eth_hw_addr_set(ndev, saddr->sa_data);
> > -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
>=20
> This isn't one for one replacement, it also moves the function call
> relative to eth_hw_addr_set() without making any mention about that
> movement being safe. And even if safe, it is logically a separate change
> which deserves its own merit analysis in another patch (if there's no
> merit, leave it where it is).
>=20
> I believe the merit was: enetc_set_si_hw_addr() can return error, thus
> we simplify the control flow if we call it prior to eth_hw_addr_set() -
> nothing to unroll. But as explained above, enetc_set_si_hw_addr() cannot
> actually fail, so there is no real merit.
>=20
> >
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
> >
> >  static int enetc_setup_mac_address(struct device_node *np, struct
> enetc_pf *pf,
> >  				   int si)
> > @@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node
> *np, struct enetc_pf *pf,
> >  	}
> >
> >  	/* (2) bootloader supplied MAC address */
> > -	if (is_zero_ether_addr(mac_addr))
> > -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> > +	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
> > +		pf->ops->get_si_primary_mac(hw, si, mac_addr);
>=20
> Again, if there's no reason for the method to be optional (both PF
> drivers support it), don't make it optional.
>=20
> A bit inconsistent that pf->ops->set_si_primary_mac() goes through a
> wrapper function but this doesn't.
>=20

If we really do not need to check these callback pointers, then I think I c=
an
remove the wrapper.

> >
> >  	/* (3) choose a random one */
> >  	if (is_zero_ether_addr(mac_addr)) {
> > @@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node
> *np, struct enetc_pf *pf,
> >  			 si, mac_addr);
> >  	}
> >
> > -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> > +	err =3D enetc_set_si_hw_addr(pf, si, mac_addr);
> > +	if (err)
> > +		return err;
>=20
> This should go back to normal (no "err =3D ...; if (err) return err") onc=
e
> the function is made void.
>=20
> >
> >  	return 0;
> >  }
> > @@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si,
> struct net_device *ndev,
> >  			     NETDEV_XDP_ACT_NDO_XMIT |
> NETDEV_XDP_ACT_RX_SG |
> >  			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> >
> > -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> > +	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
> > +	    !pf->ops->enable_psfp(priv)) {
>=20
> This one looks extremely weird in the existing code, but I suppose I'm
> too late to the party to request you to clean up any of the PSFP code,
> so I'll make a note to do it myself after your work. I haven't spotted
> any actual bug, just weird coding patterns.
>=20
> No change request here. I see the netc4_pf doesn't implement enable_psfp(=
),
> so making it optional here is fine.

Yes, PSFP is not supported in this patch set, I will remove it in future.

>=20
> >  		priv->active_offloads |=3D ENETC_F_QCI;
> >  		ndev->features |=3D NETIF_F_HW_TC;
> >  		ndev->hw_features |=3D NETIF_F_HW_TC;
> > @@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si,
> struct net_device *ndev,
> >  	/* pick up primary MAC address from SI */
> >  	enetc_load_primary_mac_addr(&si->hw, ndev);
> >  }
> > +EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
> >
> >  static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *n=
p)
> >  {
> > @@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
> >  	struct mii_bus *bus;
> >  	int err;
> >
> > +	if (!pf->ops->create_pcs)
> > +		return -EOPNOTSUPP;
> > +
>=20
> I don't understand how this works. You don't implement create_pcs() for
> netc4_pf until the very end of the series. Probing will fail for SerDes
> interfaces (enetc_port_has_pcs() returns true) and that's fine?
>=20

Currently, we have not add the PCS support, so the 10G ENETC is not support=
ed
yet. And we also disable the 10G ENETC in DTS. Only the 1G ENETCs (without =
PCS)
are supported for i.MX95.

> A message maybe, stating what's the deal? Just that users figure out
> quickly that it's an expected behavior, and not spend hours debugging
> until they find out it's not their fault?

I will explain in the commit message that i.MX95 10G ENETC is not currently
supported.

>=20
> >  	bus =3D mdiobus_alloc_size(sizeof(*mdio_priv));
> >  	if (!bus)
> >  		return -ENOMEM;

