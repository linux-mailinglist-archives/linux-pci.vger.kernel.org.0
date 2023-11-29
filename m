Return-Path: <linux-pci+bounces-241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC07FD5E7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D201C20D0C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3212B72;
	Wed, 29 Nov 2023 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Udz496Iy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ErUWD/sP"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F010DF
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 03:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701257921; x=1732793921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rI3kLBXpaEZCufpWGb2bsMrgorCz3CQ8ZnKMe7aERAw=;
  b=Udz496IyDMn1nI0SrUkMqMf2EQJXmAU1HwBZgaQ5cJgrznbFlv/+Yd78
   fIhi/AG/nCO6Qsw3gdrOpVZnuPbzozgTjfm8kxsVCvTjh1j+QcCnDwtYX
   f4XRCrBIr2nbQKXB7v1bwDccWYFdXplPeRw2ZHOTRLIBe+qvj0OE2EYmQ
   BxsoPzAL4h+S0c3V9KOy3zsONxl+MIpq9viIV2l/W262biyJkS9yQSd5x
   1nXLa7RTOiNwy2PUfcb4jDSFLkBAjqqLaFp/aaOi79dZMwsQZAqWpLs0q
   +zZ+KUTZWSyUJ+B7bQOpWnSnCgWtp7OjcbA+Dwnw1lvdhDWv0knpH4/9F
   A==;
X-CSE-ConnectionGUID: Ifch5VlvTfavChC2xOaPmw==
X-CSE-MsgGUID: jnkK/Qy+SbW+Op1LYSyrOw==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3584280"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 19:38:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It3w0h4pv7YdLW6TgGPJKYVuqoTMYG3U9UpnEBPK7pAUG0NdB3NSzrwy+2MhxIOMDvXY7s6UZZMj3ZnHM9HBeGjYimSKU5itz7CXu06+yd+FvwuAIW+1O05GDSqZXgA4eKivBJPG64IfF6axb8975uElnR4YXJP1P3vdWEnzsqrwK6kwf7FrtvRL4CIo9EWOALpVrvkDAniubwYMuy3Yx2oIfhnoR5mz+wHxRydhwBkqyNkGogMXeL7IECKaaJzUt6AYE2neDCFox+6gDsizWboiWpcd1JrK+JvrHZBhke3UaCmM9eybFBe8C0AdKrW6IHtgR+hFOu2SPb5VtZKdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98UhGtQMD4JLhk8FtDIqRfzNf0TvcFwpQd+Unof5kDM=;
 b=bDFxsdiV3L1qoc0+FpGZLVKBWWBERPOmcZpOJNblEhrE3N/H98XDJEUVWL9ct2ug4dMznIGqNe5zk6YII+91yoQCrGKKjYy+2tOFOg6GASYkeoKWmQkuygokakb3cJVUGVZrHr+8VBJ5HvoqWKElflpyiUfcnaTtqRBd+W7/Tx9sQ/vA2lfTiZlAe2dPwjNwNBczKbxdeqlgOWlM/9ww6FNiRCL7tT+0Orzt/p5DNjNrla7VXfIGQjNmB7SaRqhPVMmwHU3PdCTbISf1JHSqxV9emticHCaHl9rvBiYBQL53of1uY7EJhFVbZvU1tUEK3kGu/8kdB/LQVFS2WXAmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98UhGtQMD4JLhk8FtDIqRfzNf0TvcFwpQd+Unof5kDM=;
 b=ErUWD/sPmgJDjXqDwpTQXjC/T5YT1jja2x2EXMOJ7V73WgZale/k673BsLf+1szcryKGfp8zLzJ7A4HpOV9kabFPp4nYFzbQT/I38op07kGLDJ51uRxJESZdgU1GZJSFdLqkdnTOUiBLJPQUi4ll8vtUjT3DRzE4iQyfQOEfTKI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB8421.namprd04.prod.outlook.com (2603:10b6:a03:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 11:38:34 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 11:38:34 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCA
Date: Wed, 29 Nov 2023 11:38:34 +0000
Message-ID: <ZWcitTbK/wW4VY+K@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
In-Reply-To: <ZWYmX8Y/7Q9WMxES@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB8421:EE_
x-ms-office365-filtering-correlation-id: 2da24a30-2db5-481e-83c8-08dbf0cfb843
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b654UMDDBqbns4FHD4YtyWijY6qzoxZ7MzaLYA5SQIIH8Sbnrp9U2Gt9U6mXkSbfVU6ttbHYN4ktr6w7JEJo2fvqHDEDXUzcKDcrTSI1au0ikC7VrLGxxcIaveeDR+F+zaJuTyt8pQKxDnqZuH0cvcKsY9+h5V7KYj5ntHJzIQrbGJ1Ih5Qf+CcuzXP41bfDzqDyI9dWPRyD4aZ5f+JU31HzkA/NfwhkS9KawLZhOxhQ0CMCcZq49BVzVuRE12W0MQtI3l1UjZEJpuYJT+aII3FOHFU5t4XX5OHOsPSL0AogPTVxcA85pnXnswRoDa9JKTK1PajgPruZ7DQND4mDq+EJkHMw0gGx7vP5RB70X6rX0fsxL9UnR04TenURK/1TR4cF94giOZII1zjoN8IIydwj/oV/EJBERvgvPu+8Nj32QORwA41UTDoiTb+OWWTKh9taZ2Twqvb7/mS7C3YxqZUkNWPsMcgYxuLmAVhjS20Z/5cQ3jqjZr0g94CpmBN1tEYaGwaUYvsDolJsUbt3LqlgvE/0/HxvsixklcjfdA/SdvHxUSXxMSIDC72cSDr+QIHhk5fdf2KJQcueULUQLpBsD6cHSdwN8duwHfLjNaV7LnfaOKzhg4OfW2mn7Jdj3DDe+uDZmN29bZiv8oEXtvj7kybAwisv3b4+c+rTsII=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(83380400001)(38070700009)(33716001)(86362001)(82960400001)(122000001)(316002)(6916009)(41300700001)(91956017)(66556008)(66446008)(66946007)(54906003)(66476007)(64756008)(8936002)(8676002)(4326008)(76116006)(5660300002)(2906002)(6512007)(9686003)(26005)(6506007)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IDnHtv7sWj6WXmW3B4v5l9S5ZBFK6hvRYxsUH+kjwPzUNSoQQQjO33RTsPOE?=
 =?us-ascii?Q?w7kJVkYFFWIY1oyaTfZN9gcu/gEI8qYbL4CNsGSf4X45ZsHP368flg1ILHFW?=
 =?us-ascii?Q?55EYirdIiTKhZDS4xnqc6HpimbNlfmkohnn1N8CAcXVsXnK59JhVuQnX9/xu?=
 =?us-ascii?Q?NacZdneBMBD0lDENaqV1BOMCmpYK8+kHoJRf00X4bBNl2qMSnstRgnMFor0C?=
 =?us-ascii?Q?R4cbt9J9SXEpupCb5klir9+KUQeXzvqxRMYFMh79qsSID6l7fJmPd7U6lIwu?=
 =?us-ascii?Q?ys0kOSf5VFENJaCNBvA22xV5EwaxwplSib6Za2Jn19JgWXnBTIAkCBIGgQl7?=
 =?us-ascii?Q?jfurvm/3nMrjXHNc8OnAiWPTCqTZgXgtB0nF8xngjMn7aYmtHkRHykJZyXum?=
 =?us-ascii?Q?EmQhHLEau7jcg/Y2Z2yeWtigkj+Zt3vZB0mtuMW5zxIb9e2KSN8P2RU7jrUC?=
 =?us-ascii?Q?vuKiA21Yh1ToypacNHGuVkedQvz7y3UyS7loFlHhdT7f1ELHI2M89I7IqLNZ?=
 =?us-ascii?Q?OmIi1q0sImntGKjdlynF8pVuzq+U/7FBCXB/T8+JWFrzi8oQLtdHqJVmVKjK?=
 =?us-ascii?Q?8AiJ6Lza+ZP8vX3hoz3+XFu4HzF/ThZoydQC/fElv9zDWb9TiCaHf27pjL9W?=
 =?us-ascii?Q?3d2w2h3Tw4AImHB9dQ5g5yYqGynxXCunAd2eSyIKLcI5My58aL2OU/inTkDv?=
 =?us-ascii?Q?57tQyXCUET+cJS7RRDsTkM/MUgnj9a1LfArzVIqV2NRGww9aH3d08Lgnr85D?=
 =?us-ascii?Q?BM/dGno7pq29Dx1EyJBYDmgKTdtaeCONcCnMRZGFFvLdJ4VbXHYjMvLLubHk?=
 =?us-ascii?Q?tUz2AWioIWnDN3oZsqnSXOnQf2Dt3g3MoTxZccaNRB6P5h2rcf5tUi3kjpcI?=
 =?us-ascii?Q?tXqbhFIY2+5wNt93e/LE9dqNVfQhzjielCRWQusC3m7XXvipBPEKVubOUH9v?=
 =?us-ascii?Q?a2Y9Fa6M7PszhCkyPACSNivAJW5DhKh/WbErNKfxnqhNbKxUGRg48pwCsBNO?=
 =?us-ascii?Q?WxU6QSvciLYPv8wbL1ex1VHyVnEkaMjh1807pIboJu+t42veNlR9tbTAeVHD?=
 =?us-ascii?Q?RgHHdFcZsTflkoxaRomeOQgLkS8J0QpRFM53Z/hiGZG9dFDmBw+GY0WQlhMc?=
 =?us-ascii?Q?rPUZaon7Tz0z/hgmuZRVUkujn0kPaHj5NwzFS3M2zVu3V+0BPwrfjBQ9s6Rt?=
 =?us-ascii?Q?l0MSZq8Nbv3uZuS6C0cx6eTnCgSGiEhasznxaj4uHwli0Fl8koaGJQuXf3Xb?=
 =?us-ascii?Q?l65t5MMo29Or6e7eRm+mPJ+UDdfWZloaviVuKYV1I0TPz664lq07L88nFSSw?=
 =?us-ascii?Q?B8RrJEgoqP3QdlPpyjCI9ZUw+c2kedF9f2CIB/YtQRxuqr18Qn2oHZ+ptevp?=
 =?us-ascii?Q?bDlqcDhCGjPsHv8MXC8ZFoMpbweYgxQkBJ2IPxNhxYlTaj8rNN0PdBvPXa2m?=
 =?us-ascii?Q?hIbaeRTp12X4Z8UIgVW859VF5vZIZVJRyt8wd5sizVGFgm4/Sn1KeFFly/r5?=
 =?us-ascii?Q?DiOr7cWu25ztFJnAmj0X+afOy6DrElOi/tWJkJgdI5cxJAUa9pbPgo4QlJe7?=
 =?us-ascii?Q?UCc9nBQjUt4g6N65QWye8yPtbdxQnOk5j60eF8NEN6MwlgFzAmcdyMOejYei?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CA9E7B73CF97944A5BCE770641B870A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zn79cdQaT1WpehMxfxm11FJR1epb/7McCeXAt2PwxYya9uYtjptPoKGomGr5d59wVPjlgmes/yJc4kfn+5ow9xTaryoTy8vgNPqrRHf2Dn8Tb9aLJJWsHjE0WRlhRqBhrmloSmYfO33GF7irMGhqm8yk5rLa2ZsRvQopu6Cnw3t0jw8TCVAzp5vnZSP8WgmM5dgHaVKKRohXtd2xRid4MJ5bT9yO7NHJxIrw5yypKaTyHi3m8dV3Me6/7i5vpSt9V9IpSWE2hJEPqzUXdkQ5n5g3fH94TQkko9ObpOCv995RHm4MLaCKPYQbznOc/zZb/QOGL7wfAuCsKNZAh2QP3zIeDegEGV/wVAgW4e2JUJmorFOvH7hRANBnTrh6arF2GXVzTefO2Tap66gRoXmNBXoeBpTdevaykewHHZdvEGd4lw3YVIGxvGtSYEN79kXdUH4d3KCKBCKK9BXGPGWgHIabYVFG3+7341RlWKZfWpGymMGiXAO1noLuY8tq569zv/3m6gQ87lpJdK4wvpHZ3Ch+y7p5yNZBvy077kdoDRHCkACvcxu3YfHgxnaSD0lsTTOpsZX3refYzmIO8m95YuCqMKL0XPmRCwV/CuErxv9ATu42/n2J/wy1p3q62pefbIExfHtgw8YpmYDgwHxtsVYpoFmA9FRl68N7jS7JQAqjUcmomNiQqK/nL6KWrOzITDAMCrP+ShR0x8UciQYZWhuCKoOGNJiWieubWzVh7YYBt98djZ+sRYv3c/mPyiAR3JwGdn3IcOW+jIBRhqx1EL6nhSy9i54jMpjjn6fannbT7fby7AuUl9Q7/gcX+pXK1kwoVne8t2OZdGt+UorOOGj+sUPq8Iq+7XWoV268AMb1TeVkdT2jP0Z6W0R3k27t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da24a30-2db5-481e-83c8-08dbf0cfb843
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 11:38:34.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLAm6bPyWChPAXRu+ugnoIdQNZXMeRcEX+tyfH7Gz3bKVn+HvMpReFE09Seezswa3BPu4D0e+gWSaLD59aA86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8421

On Tue, Nov 28, 2023 at 06:41:51PM +0100, Niklas Cassel wrote:
> On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> > The drivers for platforms requiring reference clock from the PCIe host =
for
> > initializing their PCIe EP core, make use of the 'core_init_notifier'
> > feature exposed by the DWC common code. On these platforms, access to t=
he
> > hw registers like DBI before completing the core initialization will re=
sult
> > in a whole system hang. But the current DWC EP driver tries to access D=
BI
> > registers during dw_pcie_ep_init() without waiting for core initializat=
ion
> > and it results in system hang on platforms making use of
> > 'core_init_notifier' such as Tegra194 and Qcom SM8450.
> >=20
> > To workaround this issue, users of the above mentioned platforms have t=
o
> > maintain the dependency with the PCIe host by booting the PCIe EP after
> > host boot. But this won't provide a good user experience, since PCIe EP=
 is
> > _one_ of the features of those platforms and it doesn't make sense to
> > delay the whole platform booting due to the PCIe dependency.
> >=20
> > So to fix this issue, let's move all the DBI access during
> > dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete(=
)
> > API that gets called only after core initialization on these platforms.
> > This makes sure that the DBI register accesses are skipped during
> > dw_pcie_ep_init() and accessed later once the core initialization happe=
ns.
> >=20
> > For the rest of the platforms, DBI access happens as usual.
> >=20
> > Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
>=20
> Hello Mani,
>=20
> I tried this patch on top of a work in progress EP driver,
> which, similar to pcie-qcom-ep.c has a perst gpio as input,
> and a .core_init_notifier.
>=20
> What I noticed is the following every time I reboot the RC, I get:
>=20
> [  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaeng=
ine' already present!
> [ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaeng=
ine' already present!
> [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present=
!
> [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present=
!
> [ 1000.716061] debugfs: Directory 'registers' with parent '/' already pre=
sent!
>=20
>=20
> Also:
>=20
> # ls -al /sys/class/dma/dma*/device | grep pcie
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma3chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma3chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma3chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma3chan3/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma4chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma4chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma4chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/d=
ma4chan3/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/d=
ma5chan0/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/d=
ma5chan1/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/d=
ma5chan2/device -> ../../../a40000000.pcie_ep
> lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/d=
ma5chan3/device -> ../../../a40000000.pcie_ep
>=20
> Adds another dmaX entry for each reboot.
>=20
>=20
> I'm quite sure that you will see the same with pcie-qcom-ep.
>=20
> I think that either the DWC drivers using core_init (only tegra and qcom)
> need to deinit the eDMA in their assert_perst() function, or this patch
> needs to deinit the eDMA before initializing it.
>=20
>=20
> A problem with the current code, if you do NOT have this patch, which I a=
ssume
> is also problem on pcie-qcom-ep, is that since assert_perst() function pe=
rforms
> a core reset, all the eDMA setting written in the dbi by the eDMA driver =
will be
> cleared, so a PERST assert + deassert by the RC will wipe the eDMA settin=
gs.
> Hopefully, this will no longer be a problem after this patch has been mer=
ged.
>=20
>=20
> Kind regards,
> Niklas

I'm sorry that I'm just looking at this patch now (it's v7 already).
But I did notice that the DWC code is inconsistent for drivers having
a .core_init_notifier and drivers not having a .core_init_notifier.

When receiving a hot reset or link-down reset, the DWC core gets reset,
which means that most DBI settings get reset to their reset value.


Both tegra and qcom-ep does have a start_link() that is basically a no-op.
Instead, ep_init_complete() (and LTSSM enable) is called when PERST is
deasserted, so settings written by ep_init_complete() will always get set
after PERST is asserted + deasserted.

However, for a driver without a .core_init_notifier, a pci-epf-test unbind
+ bind, will currently NOT write the DBI settings written by
ep_init_complete() when starting the link the second time.

If you unbind + bind pci-epf-test (which requires stopping and starting the
link), I think that you should write all the DBI settings. Unbinding + bind=
ing
will allocate memory for all the BARs, write all the iATU settings etc.
It doesn't make sense that some DBI writes (those made by ep_init_complete(=
))
are not redone.

The problem is that if you do not have a .core_init_notifier,
ep_init_complete() (which does DBI writes) is only called by ep_init(),
and never ever again.


Considering that .start_link() is a no-op for DWC drivers with a
.core_init_notifier (they instead call ep_init_complete() when perst is
deasserted), I think the most logical thing would be for .start_link() to
call ep_init_complete() (for drivers without a .core_init_notifier), that w=
ay,
all DBI settings (and not just some) will be written on an unbind + bind.


Something like this:

--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -465,6 +465,16 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 {
        struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
        struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
+       const struct pci_epc_features *epc_features;
+
+       if (ep->ops->get_features) {
+               epc_features =3D ep->ops->get_features(ep);
+               if (!epc_features->core_init_notifier) {
+                       ret =3D dw_pcie_ep_init_complete(ep);
+                       if (ret)
+                               return ret;
+               }
+       }
=20
        return dw_pcie_start_link(pci);
 }
@@ -729,7 +739,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
        struct device *dev =3D pci->dev;
        struct platform_device *pdev =3D to_platform_device(dev);
        struct device_node *np =3D dev->of_node;
-       const struct pci_epc_features *epc_features;
        struct dw_pcie_ep_func *ep_func;
=20
        INIT_LIST_HEAD(&ep->func_list);
@@ -817,16 +826,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
        if (ret)
                goto err_free_epc_mem;
=20
-       if (ep->ops->get_features) {
-               epc_features =3D ep->ops->get_features(ep);
-               if (epc_features->core_init_notifier)
-                       return 0;
-       }
-
-       ret =3D dw_pcie_ep_init_complete(ep);
-       if (ret)
-               goto err_remove_edma;
-
        return 0;
=20
 err_remove_edma:


I could send a patch, but it would be conflicting with your patch.
And you also need to handle deiniting + initing the eDMA in a nice way,
but that seems to be a problem that also needs to be addressed with the
patch in $subject.

What do you think?


Kind regards,
Niklas=

