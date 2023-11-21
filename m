Return-Path: <linux-pci+bounces-15-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4F7F25CD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A821C218BA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF31FA9;
	Tue, 21 Nov 2023 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="Uy1ESFiN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2110.outbound.protection.outlook.com [40.107.96.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786490;
	Mon, 20 Nov 2023 22:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUBPqI4z63WEPNGelBXgUneMdoFf4b+LevCxiIrLxyiCr43hvLpA0wLiReHbg6dMeDd9LCXHbhK855WGVI5e4mJxDPvx931mBqtXIa7vCeP/CAcPZxbOANXk6HJvVrcJi9Iw+izO7ajvvmF1Hy7FsPJLsvrv1fqwEssFq+Akw8jNpAOXXMrCRmkawIMhKyVGU92fJu1d2+N1vYH7KG1rn5e7MLG1Y2J7Kni3jteyTtJpbYK6F36y3trQExjms1RrFk9B5N1BGGvFVUE0915rBPZ61lcvGgsCh6+O2EMDNOBk+0AftVbSSS2V2/zLVvEz5+fTMwL9ayyGNx1F009r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2hbh+SjJ0ofqGsNUXf0cUHR7czt3TvxSjlBXYDy5g0=;
 b=TP2+cUiwa8krY6jmF+ZiICacAL6jKqhROxMTRUAXsjNkm/Dm6lJq1H98LwDCp7+6hmyjqOrn6dGPTgyIKx+kV19ZYD0mZ2d7UMj+tu+zNkJDEBdrBJiYMCPD/HPmc/swrlgMmxDz3vNN2v7o4QkJAQhJPcG/BkxTsttIUUiMbdX/8jjczRF153TkWxLeuqe7DnQXg1cvU+ezRf/wnncO5F3pD6VkO9GkYCbRp5+BFjz+5/6vTZV4uiZmG7CFFO4fdv8ykdD18rCHZsGOHwis6SyKlOFHu5ee5wdLf54Op6JkSLsU2tTEKIP2cb1FdWxGlgQrENYw8Fwm9TSgk/9ZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2hbh+SjJ0ofqGsNUXf0cUHR7czt3TvxSjlBXYDy5g0=;
 b=Uy1ESFiN+xhl3FidQ4vqoYLJsPkeAAV8G/C2j034aTnFkHBjDLlE3Ao9yGIrhUX8CJJbk0hOhpMRuEeWO8eY0sI+6tXr679FeUlza35d7phb6JLSEk/P2+OqlXIPORdab5eu6CKwTs7kTAOYMZFrDi44/cB73SPr0eV7OV0JKkQ=
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by PH8PR19MB6761.namprd19.prod.outlook.com (2603:10b6:510:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 06:34:20 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::c4fb:2b16:ecaf:428f]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::c4fb:2b16:ecaf:428f%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:34:20 +0000
From: Lei Chuan Hua <lchuanhua@maxlinear.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai
 Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Yue Wang
	<yue.wang@Amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin
 Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Jonathan Chocron
	<jonnyc@amazon.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jesper
 Nilsson <jesper.nilsson@axis.com>, Heiko Stuebner <heiko@sntech.de>, Paul
 Walmsley <paul.walmsley@sifive.com>, Greentime Hu <greentime.hu@sifive.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
	<wangbinghui@hisilicon.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Thread-Topic: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Thread-Index: AQHaFr8f0Y80+p6Br0qxlEy4EMGG+7CEW99f
Date: Tue, 21 Nov 2023 06:34:20 +0000
Message-ID:
 <BY3PR19MB5076F22A00390B4B2DE25D5CBDBBA@BY3PR19MB5076.namprd19.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|PH8PR19MB6761:EE_
x-ms-office365-filtering-correlation-id: 543d1a01-794d-491a-ec78-08dbea5be4e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CqPirgu5hV/bxFlXZ/QJXHixEx5ZCXybYKNh85bJp1ksW3Dma++r1OIvwG38wPGq5viuRiZXOXK+zZyuF+Palaa3Zm8VAcphUmGtlbzKqLk03LEDhHRpD8GTaw4DTZ92nrCH8ZHpdOWjxOUi+bkFhFfbLT4GLMfBgoIVeYIcOG8wn5dWKEWnhCaJwM6i3HATGO3pHDyjUiXtK0G62wLjKeBfHbo7s9ibH+lsqsSp80hw3lJwR9KAvdD80+rZEuSBHER1zGCnec2hYVKtpTX+Gg7oSyneq0pU39xJcO2hcnEa5/d7if4TZxgA0EsbC3r75sH3lC0K6aLAqS+FkHoXSdtFDidtfQlHQEjV5K2cTTvm5IeWcjoNlcPeZZ4edCzgVZUVyBjelWKCAllfD3BdMnI62BnQnJbw8vnrUGGOo0X3M37qHvRJ6lNaxdWfnIQyaOQNeen9mWPlFI3tAajxcImK5YNCUQXv0RPh6JBBkb7WgcLjbVfac2w5crrABTWizO3RT52UQy0UsCQfDe6OqCceKdbCt2xX7uPFo3LcD6CondoGuUaku2pu3vZAEmf5BmcKgfVPUe0w9iF6AZGyBFukjs3yG/finCLjZp2rWu28Kq0gK3GCbqka8VRMpd/A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39850400004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(7406005)(7416002)(52536014)(5660300002)(558084003)(33656002)(2906002)(38070700009)(9686003)(6506007)(478600001)(7696005)(71200400001)(55016003)(26005)(38100700002)(91956017)(66946007)(110136005)(76116006)(316002)(64756008)(66556008)(66476007)(66446008)(54906003)(122000001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?01ji1sAgU/Imy3Jtt+3HuFmfWtZp2eadM1fGlbVSqn+VRi/KbTUnEat1r7?=
 =?iso-8859-1?Q?9+j4EV8YIYsX4Hxx1ex81pBcTsQozi1wcdZigeT5eCuxtgVfq0jDT5lSNG?=
 =?iso-8859-1?Q?3j6yLmFQJpg3KVGChsv2G9V666Yn1C1XmrMW3s3FGQ39ui99IWzLaHgHw/?=
 =?iso-8859-1?Q?8nRjfJdJGKIWodcvskfkcMJw4deLhk6O11vwvcB8exkY6xh3h6Puxrra0r?=
 =?iso-8859-1?Q?WzT5YPqxJsAT0pOxG31NvsPsgMn6PTdOpFuWfGbts1f1WJzg7tZxYCHbEB?=
 =?iso-8859-1?Q?ZzNIP7pl6Su0baeuP9HM5ctE/7piUJ0qnAOPIVRGcqTSTUPSiG84Ds2mNC?=
 =?iso-8859-1?Q?4V9Sk0u1FohcI7hluoWX3DrTWWsT7mqffpS5w/5W9p0E6SRq5FOj7nbzWT?=
 =?iso-8859-1?Q?C8NVAtVuKLuWDxuTdi70Jajz2kaHF+f/raQ3Pu2PrRtk83EpaTIDbcHANu?=
 =?iso-8859-1?Q?hKvrOjhNDaxKkorBYiiZOYp7dyEoSiWAxllcsSdQIvD3fg7nRCLcqDRPW1?=
 =?iso-8859-1?Q?yBa8KDWo7afKQyEn3ABuGtTfLcKRTwXGzH4o+7ajF4K1FyYcWGKXUmUPP1?=
 =?iso-8859-1?Q?h+t0MVpTWGMP615U1DoEVtvhAgKtT2K7Yd/xFcJW/G+ApVFlqQ7qJOgMI2?=
 =?iso-8859-1?Q?MYYUHbwfglRtmHqeIYe1mu+7Dv5u0U0hTqK04ZYhr0iS26Rz/R3EoR0hY0?=
 =?iso-8859-1?Q?mrcuXRInnbLbkKL0PmCua2IfbhKWxcgriSEN3qcKoYoCfMJ4sqYW6ofl3O?=
 =?iso-8859-1?Q?a1BLVLCWcBXg8t9tdUFkCZ2w48QTT13HL59qSfQweXKztnVaeeGcCrj+/k?=
 =?iso-8859-1?Q?lkAPOcWSS2I/alqn8IouoUJmRl0mb4Vd+Y5HTdzufbC/SLeD/eh/56ydCY?=
 =?iso-8859-1?Q?dXlRauN2fFjCjxZJNXZNIVTr0OF1h6WqnOioH3LyuKfghFjBK0NHx+s1It?=
 =?iso-8859-1?Q?zrVwvKpXjpASMBXhmD2zhT7RjxWGIyXHhjREvOeCvCU8Kpa94hgNcQ+Wwl?=
 =?iso-8859-1?Q?VWME8wiMT6YihK87kfl/iPw/C3w7fg7mxYg9/dKbTPm7wckPZ5Ej3uCsu7?=
 =?iso-8859-1?Q?3b9+d2gXmeGYGE5EwvgCo79oBTXqGinTYfOkI5El9WQ7qXjafvUlGB2jIQ?=
 =?iso-8859-1?Q?3s+spzZTcY1HiF13D271reR1/EiiCnD8HOQIVGw0aJp/ReAU+fUp3rnVr7?=
 =?iso-8859-1?Q?ORk0gmXtfapa/8tEvh9vT0l1Xl3jbDgvMdOxnoPDv6EUvjuR1ILSG3Be12?=
 =?iso-8859-1?Q?YkSmQut/NvwQ6hLzGa3yrkLwJ+Q8uii2yTXJdNPUIB8Hatx77oRYZFW8q1?=
 =?iso-8859-1?Q?ZKctGAL2XnA4IrUiE0bjhnFIqkJ9D9kp4wIq4TRleb/vQv01SUuoaDq+cs?=
 =?iso-8859-1?Q?AR98ESMIRSFiYQlsUBwzYTw8AlJRXaF9sO/Z3/WLBvi30UCzEwdpWRiAxR?=
 =?iso-8859-1?Q?YtQyrT8Sc44de76Vk6SpIXVNQFqPNWtjy1U+A0/WirkUEmx/HbU0G/1Rjv?=
 =?iso-8859-1?Q?vD1APpIkby1sUxndWB4nOCuBrY6KSB1Z1+CjKCnhzV48dosFWXBu/5qa5s?=
 =?iso-8859-1?Q?uUVXMlKdDmiguxfLKcXx3hhLAcR7e5PrFz5i8YVqEaVVzsqMxe3XILRVTR?=
 =?iso-8859-1?Q?wN0UT3Klrj+1R3sKxJwFoIRDngxjG8WjsH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB5076.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543d1a01-794d-491a-ec78-08dbea5be4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 06:34:20.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmxrCS1Jek+IcpPak9uI2sY2nLc3EzSakYibYdSeAEDfu2RQO+GB5Z0/+OzPryNSRr3Kk/uRYnAPKf/jtQGS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6761

> Since the name of dw_pcie_host_ops indicates that it's for host=0A=
> obviously, drop host prefix from the struct.=0A=
=0A=
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>=0A=
=0A=
=0A=
 > drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-=0A=
 =0A=
For intel-gw:=0A=
Acked-by: Lei Chuanhua <lchuanhua@maxlinear.com>=0A=

