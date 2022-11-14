Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611C76275CF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiKNGMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiKNGMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:12:33 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C6B03;
        Sun, 13 Nov 2022 22:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb2x3KWNDCt2uWCYPNC6HApyjWavpD3+YCl+ACRnP8oMW3HzPC3a2W06dVFRhZDI6gUw77TMGfqyX6gZneSdh96xA9WGv/s/1cG0NzlNG6+gJPO5qCdoGwwP45y5jXxv+p+mYknnewUvYu2CmdZW3GblwM1UimgIWZoy7rHrlgf6Bx385Npe9gKTbgbQ0svI+dC69/Qwwn1IIAeuD+sS3ubKFLYyrItVAFtgIcODMUQLYZb33q8DMfzR31OAO2y+FOjDRXsUi+zyIWLQFREppBXKMt3HeBCUz+MAwbXsmc6HLrGoc+dCt52dw0gDG1HhuV+1yBwj0mXlZfqEGfzU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQf8Kudh/xqaRpjJLp3BMLE31k/vKvlV+g9JLDTQJ9Y=;
 b=VydWl5lCvpO6X0rvbuGtGTrEeFzeBNySCjsa4anaE+D0XSpdpWFaWxAmBvEf9ubTv3HDL7cb84rUZ0V8E8fXZAiTGO1V/bnrDKLojX4SxPbLLn+wtUgiEfXbkqqEhQStMN+lUeFjFeqorZAnNA0+cuQCv1m6ChvxwDyF1LYYpp+3ioe1A7WYSLogfj3NNxGdLLf2R+niD1igA2OL6ABGurO578OtiionWctfmn0pfKPkLDYXGhDJpjiTbDaXO2Jf6+ezm7vqYwf48B8GdxgnG0Vhyr51445pVUjqmGUajsRUP79gU9AtZr2vJ7NTEJ5DlEnhOhGzdcbUtJvE9OiYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQf8Kudh/xqaRpjJLp3BMLE31k/vKvlV+g9JLDTQJ9Y=;
 b=hn4L0DUBVkuJKNkxBRCunsHNJbumeJlKPGW6vcR3qaLhlcMMZw2M8rm8dfbnnfyTKXB2eORz8GmxUFxmkRofOdVHThJMUkeY2LVu5eJP8qQMkbMpmMrkciyU5JDrBlG2aKDPIGzAr2TbcMgatcRC6yFnghQJo5H3W9WCyShJHn4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB5726.jpnprd01.prod.outlook.com
 (2603:1096:400:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 06:12:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:12:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 05/10] PCI: designware-ep: Add ep_pre_init() callback
 to dw_pcie_ep_ops
Thread-Topic: [PATCH v6 05/10] PCI: designware-ep: Add ep_pre_init() callback
 to dw_pcie_ep_ops
Thread-Index: AQHYzlpQUJ21KOXhlUKflbqzh0jt2a457bgAgARVdVA=
Date:   Mon, 14 Nov 2022 06:12:28 +0000
Message-ID: <TYBPR01MB5341D169F9C98321F815D085D8059@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
 <20220922080647.3489791-6-yoshihiro.shimoda.uh@renesas.com>
 <Y245ZtqqqelXif+Y@lpieralisi>
In-Reply-To: <Y245ZtqqqelXif+Y@lpieralisi>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB5726:EE_
x-ms-office365-filtering-correlation-id: 1e7e3731-0938-4135-402b-08dac60734f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9X5YgilgZF3zaKBZFl13aWIP76JBoQipnMMoE8nrF7GSeywxTzPeq9xBAjLsYnvdvj2/Sy8Vs7umTsLeGo1ZWanXYcY4+6k6I91lxm8ECLkjlaPCuzjrj4HUdEmyrDZpWtIrkqB68n8G+K5k0yn2Ioz2hOvvX151aETOz4lTJ5Gl+URu/Pkg4htw593WscyX9qTmkutSSJXC8BnWskw1pWOkCvO5u+gUsI+LF2lpGFXZoF0eKlJgfKp818EEDH8n7VQvX+P/xnJlp/+SgVyXbRSZCcjaRPcwgsf0Plk+l9zEGluA2s9JjTF6ZOy75WMJtETwEX68i1uIZ1FGofbYjiyLwcZF+wH8bavD+4oSNP01F2gRxI/+YxeZkC2Fzo9FNba1nBUabS3U5699TxQ8ZKOSMTbDqtTmaGfz70Tn1QVbZf6f8QQyjzOr7ZDdKrMEV6L4QxEC9rMEKpYuZC8RQFrQ96KnWBUtdDUxZg06CuYyH9I9WlY3VsCw9QeesBjj5LHCIZU0s9Iyh25Nl5NZBazuVHhyliPMn/dAtzyZpYVTPMpZOZY/WuM85Wk0Y9u6/yc+xOX8f7+mOt+AXYDmaKQS568YMBeKoxgphaZMB/jFECpEnFdmcMWzynb+EjG8eOntdT2x+kbtxhcDdSTBg2JwaR4h1/Qbc5SuCbIQA7/Cj3Uu1393Xtk1VdB/O4s/+Jema/AXHeIGsB8vIpXamCleXkIMsExeU0e3IJy6ZgdOFXMiJKcD0jpeiWGe8J6BEt6L2wt8rNtEz8QIz/l4Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(55016003)(54906003)(7696005)(6506007)(186003)(38070700005)(478600001)(64756008)(86362001)(2906002)(66556008)(66476007)(66446008)(71200400001)(9686003)(4326008)(8676002)(66946007)(122000001)(33656002)(76116006)(38100700002)(110136005)(5660300002)(316002)(7416002)(52536014)(8936002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4M0DreIf0jnxrAdakBsJgdy+oA/fGIVzwdiumU5lfdy62SvOqyJS+k79mi7i?=
 =?us-ascii?Q?69+T4PjBaOVnZ1RytlHxYldzWnVJP8QbMnNq9jgXI6nKKKpXG00b+2sPl4fo?=
 =?us-ascii?Q?ca8jlwKQbuSrRYmDmSJADiyEwP6X8STCVt72O6d/wpprndL56g2I/DprMLxM?=
 =?us-ascii?Q?FspsQI0sCXQu6JdTHCGCPWVrja0VS785/MAw4U9E68OSD52+uWVPpvxh+/Mf?=
 =?us-ascii?Q?vmB0JKCbbR574SAoPHDCDSLMJ0xdNDix+gurNJjVUzo/a9UWPgkGJoi4+RLH?=
 =?us-ascii?Q?2BTvUjcWpmf4ycgLZzOnBro1eO9LplajKM62bbfgkgRgHHQGQDtgU7Gte2cZ?=
 =?us-ascii?Q?7+11U+IYyxLYL+NUsEW1ZE0ETwKaXfmOQ9uBfzuRCUjZnFuiuJfrO6oeyX4N?=
 =?us-ascii?Q?lyv3pzR9yuxkta8J/IFr0gqAUaG29HrAcDb2Ibmb+uMApRqmmWxYsAnxtJgA?=
 =?us-ascii?Q?MaZVCUiOdVFv1TkMyjtrZsaUvhdJAjwoal6d4HQXJXO6lSgYDrA9KvJdPe3O?=
 =?us-ascii?Q?WxkM5n4Syr9vvLRpdTTLpZepdcgj/GtmeVUIjC9JW7SELD6S+HS8Fo7EvMEg?=
 =?us-ascii?Q?QRZ73MzCWQ+6F6wzOvPfEogvCASHOVZ1jYnNRdsyGoCxlAk86TbuHNFRC91B?=
 =?us-ascii?Q?ucsuEuaWNPapEIm9yuohvOih9zNVF8zKaaDXh2awggNrF3b84z4bfUiWAZU8?=
 =?us-ascii?Q?zh35ZcJDqZcog6WoY8YqsVEPj2kitvzzA/Ss13pXGB+zEJ2lbFdGZIKa7Vmk?=
 =?us-ascii?Q?M1FVyF7tg3kz3VQNdYdYdkVP3MNki8Qe530QoyJRG5+czuwon3uE/pNMMEj2?=
 =?us-ascii?Q?B3ontYRGW5+ElNQnLNvmSlRk5czmHC9eCCc1fWxycTBYl/0KnSjiCDpbB/Aa?=
 =?us-ascii?Q?wo2vlspVLYQZEU0RBsrDDqHuftgZDRAGqd14zf2Lbf8v5NtNiOvAKPEGLc0b?=
 =?us-ascii?Q?jeiCO0mMK9aDQgZ/flp9PJVPXsCW14c2Bqhnt/dcy0jET7qM3KYC1sDPrUvU?=
 =?us-ascii?Q?RZsXW+5Iy7+rcKbZylSowOPzGE5Tjz1vatMlTMiM3ws5jzW6gqy+pQcNtIY5?=
 =?us-ascii?Q?qtkADvTh99f7FExDjgqRcV9qWrsrustUQBSzza9OjwTKbnI0o9zFtX+3spm+?=
 =?us-ascii?Q?un1Y12EUf9j2ou8fTQ4w2/2lpUuVS0DppmrPIhzKEnTLwiw1HzZ350381ZPk?=
 =?us-ascii?Q?3R+uKRrQwQL0Olom23VgR1maQXPAK40x/ypTurgumBs7SpecXRfCfBR+kH+e?=
 =?us-ascii?Q?1L7mw51UWS4sRGOianJw+ssWYRoH/OVs+miyqkCkfZ7X6ByzvrbYlf/OUKrK?=
 =?us-ascii?Q?O7KEF5++Iv3e6HTHcElcl5k4ijbZ9OD2HOLFTxD4Q8vlYRFBOIoB/yJoC7lr?=
 =?us-ascii?Q?97kCf6VSTdRrM8aLXGOjzSp7RUbY6Eh7ZNCoUjj0zB4w0UbAdH6by7Aix1g1?=
 =?us-ascii?Q?yr47Jo4IGZ5A3A6p7x6ZJuWZMAM1n1RWd5VmNA58C629SZfXXNDmCUZ230jw?=
 =?us-ascii?Q?r4vlA4fFgJGfD0Vs7MiXdtjqR+NEC8r0GT2oaBry2OB/m/M8Yh1fPfj2+cvq?=
 =?us-ascii?Q?6AtZPFJGrtygbYf9tj0Gfvzs95MK9criA5S5dwIS7D4SBxBq/JxsdDjjO2NH?=
 =?us-ascii?Q?Uk/tv+Y9WHssRug5NCr63780WFvb5LwofLCxIQYdiCbwTwgoPqN58Wh7rFF9?=
 =?us-ascii?Q?W7H8VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e3731-0938-4135-402b-08dac60734f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:12:28.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCDGGS9ZqxQvvbZsC0lhluv5h2KRCGrJz1BNw2eZtkPQomxV1o+uv9yeqvNBdlXadYwwxaCVt0C/qJhAe62qfxY9s6Ek29bq+teizpt+l/Z0aviiUtZk6eXP9/vaKiAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5726
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> From: Lorenzo Pieralisi, Sent: Friday, November 11, 2022 9:01 PM
>=20
> [+Kishon]
>=20
> On Thu, Sep 22, 2022 at 05:06:42PM +0900, Yoshihiro Shimoda wrote:
> > Some PCIe endpoint controllers need vendor-specific initialization
> > before the common code initialization. Add a new callback function
> > ep_pre_init() for it.
>=20
> It would be better to add code where it is used.

I got it. I'll fix this patch on v7.

Best regards,
Yoshihiro Shimoda

> Kishon, please review if/when possible.
>=20
> Thanks,
> Lorenzo
>=20
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
> >  drivers/pci/controller/dwc/pcie-designware.h    | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index ca8f1804ee10..1b7e9e1b8d52 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -709,6 +709,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >
> >  	dw_pcie_version_detect(pci);
> >
> > +	if (ep->ops->ep_pre_init)
> > +		ep->ops->ep_pre_init(ep);
> > +
> >  	dw_pcie_iatu_detect(pci);
> >
> >  	ep->ib_window_map =3D devm_bitmap_zalloc(dev, pci->num_ib_windows,
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index b541f653c209..9ed9621a12e4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -317,6 +317,7 @@ struct dw_pcie_rp {
> >  };
> >
> >  struct dw_pcie_ep_ops {
> > +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
> >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> > --
> > 2.25.1
> >
