Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2988627CEAE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgI2NMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:12:49 -0400
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:23808
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgI2NMt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 09:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5HfsvJ5BLOCF6EFw1ttYlpRguxGj4bcasJVLqVpM3pdtQ5CPij1mg3mt3LsrOuI87EHuzk8EswJRurE2Kg4x4lF7jBbggU8QwrVA/t9Shqv4bGoAajlEI95YYTiy/Y64QRD7tnYqpMfWxnapTDV0YoJh4rRNvf0AnzeJPPmfomssHU3vSojVGWD/CB1R/Bouu/lXtx8UhI1yT8kkw/jixGOJWAVBp9aghHqx2DRxYxqfPhW1vZuwJrL9tunrRBYF7nPy2dia2x09msFebci8qHYtSuHySVnNhh0O+ElfnsPbhd534inauiI0KGa/8c5HhibhDCLDibv1fiQQpf4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY/D5gTcoSgax5ODfWRhKPCyYaVgOq6e8SIgJrchnGE=;
 b=FvV8Cp7WdelFg7VtMSEzAYAds7maGyiK2N4YWnfIpnpnjhimCPCeYcqu1nQp4wm0ERFUVBHs4MWIR7cHq7SkdFUZcgtoLEbVJV0tQz2sZ7SlptrotyfPCIM8ExRC1puMbqehyOKgxXLDSYgF4vukI+HydFwqF13KmbsoH975wHyEdJR8HET2PFeox2TRJVjZ3Tn5s/19vh8b6ZOj7x2hklKaC8lCmHiJu4juXuYjg1zgklXLmuQbhxkeoDCruloSm37+DwSM2G5KeI5vX3tgb8ValQ+vAb+VwzA1NKpSt4Z68hklbC61LW+i8vzjF/bSjX1xEqEcc3KJ9VUF55plrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY/D5gTcoSgax5ODfWRhKPCyYaVgOq6e8SIgJrchnGE=;
 b=CYYPiBQlMNB5eo9ehfYg6vjrjrSMjHmMgMPx9gTVwTwgvOk6/86zgZfPGUYzEcyANLMgFqAK+kaelBsvsvVq+2G3d2X5uWm7lh2D3tcHa9cSEC66whyo3LqE3ZfCZyks1qc/Qz8HcV06kikIfaSZo0e0LYGd+43YkXk31uI++Ys=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4063.eurprd04.prod.outlook.com (2603:10a6:803:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 13:12:43 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:12:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Topic: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Index: AQHWljz7wk3xSbVt5k2cDIsd1UpdEql/ahaAgAAtWEA=
Date:   Tue, 29 Sep 2020 13:12:43 +0000
Message-ID: <VI1PR04MB4960D01FB5508589D586AE5792320@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-5-sherry.sun@nxp.com>
 <20200929102833.GD7784@infradead.org>
In-Reply-To: <20200929102833.GD7784@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.219.66.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50b1c87f-79ac-42e7-f987-08d864795a2e
x-ms-traffictypediagnostic: VI1PR04MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4063E15272D32B9FD58A376992320@VI1PR04MB4063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zanQg2Sk1ey7naOAo7n0pk7iEEM5kuKYHr60GpgjEHz18iQka5uJwNGu5Aod9lNjazJgCgO3yF+tk3/ydEa/hqaqd1YrvK7EkqTqduvy68+ptICdQpmfFHiivKoe/uc0vSokIu32AvoUuN0n4k+dBdBST3k9EDkOPhrAMBx5BMiPo7N0Ceu+fmtd4Df+/IJykW11ifWsuhYu0JlwZtEeDS3UP6C4VSFZV959Uaihi8AlTzYzv78a2b1n8Tz0J1TXv2Qb2qw7BptSuaZ0dOfpX9TGc/aHJufp9COdcEZ8bTpNMzcNR9ERLMoYZwxoYCz0OdcgSmb/mkP+7aqE1LTLhRjmoXICmiDYkebg39rClC7lMTC6PTt81YYuL/M7tzv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(5660300002)(66476007)(66946007)(76116006)(66446008)(64756008)(66556008)(44832011)(9686003)(71200400001)(55016002)(83380400001)(316002)(26005)(4326008)(33656002)(7696005)(54906003)(86362001)(52536014)(186003)(8936002)(2906002)(6916009)(8676002)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: f7oLq55zlLuuPAghZIuW44CV5hAH2gL/3a9z2SWjpUk39zayuVVcUuI47JDakrMXYPL0HDDlBa6bR3IC+DrWRtrFwYfXq0sTc3zpxdObZzwl7SIb2Mp9pDnJdaER5bkOzeM6iQhAenBmqgEJMIFRLYezAZ7QPL0biLBLy5bg/oOeV13PIvI8bBjcnPq6XS0YBuro9P1KZgEOru0nyzw466CdMSaiRjPqpq/B2eHoXRoOqkQ1W/A7+eRJbg/dgufM5gnPs5MSdZpL8fjdWIZjxHd9AlUoC1DksQz2105Pz1p3LaF4P1P8nwMl2Af6grFCo2ngnAG4Tnn++qEE73vTAWdeJer6JWfBzGst9dZlVO8tc1FYANgI0ktex9GW3YHm+E+rSWidci6JFRge0ic0yQZO0ujSc9Qj4wbyB75TIVPc2L1HhgIwCxGCYDWf3/XVNmylqSU97enxGCBIBBkqI3B9eh0rKOGDD6Avp3868Kbz0kU4Pvbd4Zl9Rzxp6GBdq27rsHqTHybPXFA/ZLL6OlXRJxohRTQ3ToOJ2+k8Nnta3Zl7DRQn0yQV3BFXZaj/sSE3BU2sF8pjS1f3+aLoQ+LCyMjx6WmVXKIwnDBxciMOmzpD46bpIlRxYYR15eY81UQ66zJ8TXY8iETzk8xZUA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b1c87f-79ac-42e7-f987-08d864795a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:12:43.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ts71XjfxozApD4gkTaqy79XAbv1Dwrc5U/qHKKGLSGW/ypdw5rCxYz5ZmKppAdPGx78Br+1QohG0GE7//uz4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4063
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> On Tue, Sep 29, 2020 at 04:44:25PM +0800, Sherry Sun wrote:
> > Mapping kernel space memory to user space as noncached, since user
> > space need check the updates of avail_idx and device page flags timely.
> >
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/misc/mic/vop/vop_vringh.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mic/vop/vop_vringh.c
> > b/drivers/misc/mic/vop/vop_vringh.c
> > index 4d5feb39aeb7..6e193bd64ef1 100644
> > --- a/drivers/misc/mic/vop/vop_vringh.c
> > +++ b/drivers/misc/mic/vop/vop_vringh.c
> > @@ -1057,7 +1057,7 @@ static int vop_mmap(struct file *f, struct
> vm_area_struct *vma)
> >  		}
> >  		err =3D remap_pfn_range(vma, vma->vm_start + offset,
> >  				      pa >> PAGE_SHIFT, size,
> > -				      vma->vm_page_prot);
> > +				      pgprot_noncached(vma->vm_page_prot));
>=20
> You can't call remap_pfn_range on memory returned from
> dma_alloc_coherent (which btw is not marked uncached on many platforms).
>=20
> You need to use the dma_mmap_coherent helper instead.  And this also
> needs to go into the first patch.

Okay, will try to use dma_mmap_coherent  api in V3. Thanks.

Regards
Sherry

