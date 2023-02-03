Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B068A5EB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBCWQW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 17:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjBCWP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 17:15:57 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289869030;
        Fri,  3 Feb 2023 14:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiWMTfPmLtZwULlfIgK2xRaTU7gTBjwi2Gr0kjHuYIicHKqaYQntKDlZk4gJ6dEeLZagg8EAyIiu2MrDwP6dphbME42ztpR3aLZIShSmb8n2VU1CFr8rMMS4n7OTj55whnYgowbRlMZlKF+o3tXJdK/fMljg46Hvtb+9ezkuV4IdDtm69Sx1hD1r3FJtVbG6uCjWtK876Syrrld0Bmv+fDUq8QELSKZs70Mco2padh+g42OSH8uL1aSAaFTQ6EDdBoOcE+r5nwY+5MSXc6hGBfSYguEaz+tVXLARuy1k3wdkWUUTxX/oqdI6Y/BNgWVFo8UzPTxk+4PQzrdRrwNv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkwnQV31fbNCB0UKM+tpk7gowj+sB5R32IYL9tSxt1s=;
 b=FPZJSlicCZ7k97CypCNX8QSZUUjsyr8CMYeSQyv3aM6V+h5HcSmVu0acHE0NVZTbXamOb/4DbPSqfKYLZfaavE7LOSFIYfR6PZroikUjnVeMtuIlwdEDuIQ5v4aXTIisZZv56Nhb+fkdudlxHz421t5cXSGaSCTsSYcgKMWHvLurDome/xHBX96sUs/8jr0u94NP1BT94sACFSLBjSV1x8i8OeG3/CVV4PG04J6+OAbeVmckCU3l9ffMp7QUPTZoYbEy69Cgx/RrzlCNdEOpQgx+dPMDPfDj14l1bArWsqFuB17p1zuj8o0TNuJ7HGUleKiRaX+t/mi36XJbPkJ7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkwnQV31fbNCB0UKM+tpk7gowj+sB5R32IYL9tSxt1s=;
 b=JanE8j+wUgXqIPNgfUbcaXwPXiUOJEVWb31c10Letb1ohQgm71YdZek/RTukCknOCLkfNwJxz78+iQ2vAZSqOgIZjnBYGvL6UeZT6qzlrgUUbgkQxnlrkPJq8Uh/fe2SWkPeWqqjYSrHgTuYmGUu5TBxRnXoLvaW3wQD16IQ+zU=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 22:15:51 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 22:15:50 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Thread-Topic: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Thread-Index: AQHZN7liQTou1LlKIkegIEQy1N8nRq69xHgw
Date:   Fri, 3 Feb 2023 22:15:50 +0000
Message-ID: <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203052114-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PR3PR04MB7385:EE_
x-ms-office365-filtering-correlation-id: 89c3c316-d0a6-4820-432b-08db06343583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0THi6SoHgnwGd7HcXm1MzB7aU9mgzwArTjvxv2476wFfQHJLehNpRn17NDrZkFZKB8dVmMVC9DElbcFfSGUw4D2W/UBknWaxgM4Nsa56Bn/tqICCrs1gaWKKXiXQYjl4c7zSnX3dqULsflswjKQ361s5mkTgIfYmudRIZjhqNs2iEDoXdIE/6e7p4gjKq+VgkAEfxrJQPzchzA+oT3ztGTzbd9bCEcdTCVBPczWA6T39+EqIfGyqxm9bOqHAaZ0dfPwYbGpl5kfkECxbZ7xuOX8gcDe6IxgF2uTxCoNGjUZdIakkYjiT06tQnTKLko3ZLjYl+9HBWok7nSLMV3E5a3fpL425rOZQnW6QRNSIwKX8JG849bNKEM1I3Vi6QpcjMmBjrgXDHQXFGieNsJxxddSpMib/b3q19NJRQXMqZ0eKf/003DNWvT7rqQr9Z0BfjJMADMfgnGdouyP7qG7baGW5H1W6LfSgPFv4QxeLf/i6MAS/yNDCiOwCpPQt2zrBkcZhRZ/Cyz72XgqjmAvr5Fp+Pja7bNnPXVNvzazwf0ZoDXhRWlnw1fnFOEyABGIzC6Z+U2Z0pAI7XQzxckP7093rhOA4wXGcVqi3h5olDye5EBYcSRKdFyCiyjD2SBVE4SGa3tQyqnEE4T3UJB7FaXCxTObrQM3V2M7aE5CO08iEH5q+AyayKSEublSK1HI1PBvae3U9Mb5eas2uJfchNDRHLqatEC61adK4sFRIa0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(110136005)(64756008)(66946007)(66476007)(66556008)(7696005)(66446008)(71200400001)(76116006)(38100700002)(86362001)(33656002)(38070700005)(8676002)(122000001)(83380400001)(966005)(6506007)(55236004)(9686003)(26005)(186003)(5660300002)(52536014)(316002)(8936002)(44832011)(54906003)(4326008)(41300700001)(2906002)(478600001)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?+cvAjRxd3WVDFawH0Ffd+yizhHHGaM2R7nJeNT4nW4RxtbCjwFoNkwcD32?=
 =?iso-8859-2?Q?1RIZ9ZQdqvUoxcZzrtlhxP+mtX048vpOyTGzxlsX+7RhNIf9qKTLC4sO/6?=
 =?iso-8859-2?Q?NLJDcNbnYGadHFq5By4fS+cetcm1xifwsYPi+E2/Me4F8mIeyjO/prUHxZ?=
 =?iso-8859-2?Q?EV4EUWlimg8Oo8/CiN6IUlbmbLfo1yyeZtY5wsNvryh6wqTs/5P2S7fdgO?=
 =?iso-8859-2?Q?acouSXU4w9l2T0o/bKqp5MF6kIPhCA34/oot6mTh23zaIA4F/y/OX5BVMX?=
 =?iso-8859-2?Q?ZnJcx5r68d3YQihvhIkIgcfB7xp75jdmXRNxx+bpR35nErjqUJ1s3UwJD6?=
 =?iso-8859-2?Q?eclEPJpahaeuy/iN5yFgRffWCYO6wdzrAJz5fg4WhgcXzdN/0OXQyW0s68?=
 =?iso-8859-2?Q?w5S4eTxpkNafSbwu7erB9kqphR9vZRs0hqBSkYRZ3gJV+WeoTxDma/zX9z?=
 =?iso-8859-2?Q?ZuGefeKYrqOKaeG0xpURLQdVyNH8NdzVPqP4P2aTaUPAfajvuL71BJ/fwe?=
 =?iso-8859-2?Q?/IADkze8KkQ6ZNfOXkzjvsNW7OzOXWQcLKmHqiqBWxIfu4Ze+YtLq6bO/v?=
 =?iso-8859-2?Q?A+4ANiJWnotmB2pLvf9zQ9Qaz9Aka1R9iJxg/iy9O5C3a0K12I5+bfdt7P?=
 =?iso-8859-2?Q?T0Qp/iM4Un9fUk2WufG5uRjHbn6cVQd+UEFMbrvvvDFUIsvnrngDfgIhQF?=
 =?iso-8859-2?Q?BzCx/PILIZCgQAkBldtLhJFGzsRzIoeH7WotMkqqiMsLiEHeYLdeYinJR2?=
 =?iso-8859-2?Q?+KlYWukzVyCZZUFHGNpCj1riUVCcp7BOaB7yAlLAz7ToaW3L4WlpxIsdiV?=
 =?iso-8859-2?Q?gfTr3WafmEpon0TFE+3BI+T2mv6Sgh4Z2iS/3YhzB73eSXv+/R7fGtAS2y?=
 =?iso-8859-2?Q?waP9OI7wI+oWp/jZWuCPhaKq0PG4Qlv6/wBaT6gANGyCEkAhVci/w4516Y?=
 =?iso-8859-2?Q?Wh4K8d7Y2MnkrS+K65zTnkljor/DQTMlTNpdkGNZAbagKZirJyfrEMMu2p?=
 =?iso-8859-2?Q?4R97pVXtlI1qCgR5sO4lG6GpGWc2tY4cWkpDRDY8L0TxZHie6l6pYG6/Wo?=
 =?iso-8859-2?Q?9QJc8cBqma9qy6k+D7DOFSjK7sQDj32aU6h1ebPBE03olXyORnx6FuVvwm?=
 =?iso-8859-2?Q?gRUMQfdqObpS7H8IvVJyzCtQTzUhgCone9O+Zf4qH2wBAanxL3zReC0Y5U?=
 =?iso-8859-2?Q?gU+6mWBxqYRpq9EXrWN1S2KYyXEmmvg8Lt7cC4zgqaaJOoYkF8nGweJfoL?=
 =?iso-8859-2?Q?dg251OGr7Y7QJnBSv8KC6GzmdVdjIG/AMXVn7A9FljY7W/dNev//34H8SY?=
 =?iso-8859-2?Q?1sWp/cRCFsJ+2I/G8wOlhLULohJsQBJZUcQ5WtrFhbWk68jMLoECfCAEn3?=
 =?iso-8859-2?Q?kfoylSR4dsqXsNw67YhLlBimXgGNSkmLT2YtNTIYWCLT1DLxAHeSNIf4yo?=
 =?iso-8859-2?Q?NMy0wTt4AYUnL8sWBXL+fean1hswnZYCC96CahPMCxLLfdfDXUUnILrAMJ?=
 =?iso-8859-2?Q?trHkR/LsfAzumKmkj4NckHRBFDZPlTQWCWgkXex1ZOeMSP+P5JM3hZwsC9?=
 =?iso-8859-2?Q?BqvZEh4LKwZzPJDn8ZP0e521RzlaaphUamIFrLjqKKP0PrzdOQG5DaNJqG?=
 =?iso-8859-2?Q?eTkHDm/9YzGO4=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c3c316-d0a6-4820-432b-08db06343583
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 22:15:50.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vp5sW0cIJemHOCaH/ETMmXF3Nl5cl9SjH0OejWVJr4bGn62H2mHOGCpPAastHYw50gsI0iLE2N3JnEWMh+qt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> Caution: EXT Email
>=20
> On Fri, Feb 03, 2023 at 07:04:18PM +0900, Shunsuke Mie wrote:
> > Add a new endpoint(EP) function driver to provide virtio-net device. Th=
is
> > function not only shows virtio-net device for PCIe host system, but als=
o
> > provides virtio-net device to EP side(local) system. Virtualy those net=
work
> > devices are connected, so we can use to communicate over IP like a simp=
le
> > NIC.
> >
> > Architecture overview is following:
> >
> > to Host       |                       to Endpoint
> > network stack |                 network stack
> >       |       |                       |
> > +-----------+ |       +-----------+   +-----------+
> > |virtio-net | |       |virtio-net |   |virtio-net |
> > |driver     | |       |EP function|---|driver     |
> > +-----------+ |       +-----------+   +-----------+
> >       |       |             |
> > +-----------+ | +-----------+
> > |PCIeC      | | |PCIeC      |
> > |Rootcomplex|-|-|Endpoint   |
> > +-----------+ | +-----------+
> >   Host side   |          Endpoint side
> >
> > This driver uses PCIe EP framework to show virtio-net (pci) device Host
> > side, and generate virtual virtio-net device and register to EP side.
> > A communication date
>=20
> data?
>=20
> > is diractly
>=20
> directly?
>=20
> > transported between virtqueue level
> > with each other using PCIe embedded DMA controller.
> >
> > by a limitation of the hardware and Linux EP framework, this function
> > follows a virtio legacy specification.
>=20
> what exactly is the limitation and why does it force legacy?
>=20
> > This function driver has beed tested on S4 Rcar (r8a779fa-spider) board=
 but
> > just use the PCIe EP framework and depends on the PCIe EDMA.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> >  drivers/pci/endpoint/functions/Makefile       |   1 +
> >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++

It is actually that not related vnet. Just virtio.=20
I think pci-epf-virtio.c is better.=20

> >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++

It is epf driver. rc is quite confused. =20
Maybe you can combine pci-epf-vnet-ep.c and pci-epf-vnet-rc.c to one file.

> >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++

This file setup dma transfer according virtio-ring.
How about pci-epf-virtio-dma.c ?

> > +
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_ISR,
> VIRTIO_PCI_ISR_QUEUE);
> > +     /*
> > +      * Initialize the queue notify and selector to outside of the app=
ropriate
> > +      * virtqueue index. It is used to detect change with polling. The=
re is no
> > +      * other ways to detect host side driver updateing those values
> > +      */

I am try to use gic-its or other msi controller as doorbell.=20
https://lore.kernel.org/imx/20221125192729.1722913-1-Frank.Li@nxp.com/T/#u

but it may need update host side pci virtio driver.=20

> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_NOTIFY,
> default_qindex);
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_SEL,
> default_qindex);
> > +     /* This pfn is also set to 0 for the polling as well */
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_PFN, 0);
> > +
> --
> > 2.25.1

