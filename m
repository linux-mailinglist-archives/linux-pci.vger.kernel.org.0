Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4BB7CD12C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 02:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjJRAQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 20:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRAQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 20:16:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1019F;
        Tue, 17 Oct 2023 17:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnYPuwqiIS4aoqppKGxEulD9Sxv7xfPHbbfLLbfObIaCCD7gc4p7UlyCY/JRMCxwimXloeUPiankve2e0W7Ys2/yAwb8BOgtb2BohBgZm0VdQFYHXEDpL0I43D7sLlzg1L3tyuiwJuTzfC3d8XmPjmH7w1n51mglcPt2hNWtXwr5DOOaLHZ9/icfLXfwtGs+rI8dMd39HIQPRL+rcqb1a//4O9noJbxJ+AKA8BHWfEyH65GSC7GK8WVVdRcj6fbdf7d+mGPP07ODwZRSOEr1rtQUNfQwTxYJ8YiFI5DhePvfoUt3YHp61w8f9pTNlYge3MsNPRPCsHNF+wlzTIP0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTeoz2WdknRninISThb6HEdU1RKcA2fL5H139zE0icw=;
 b=gojX6s0GlmEJSX2JtquaC0novHLVB4H8UMfDSqbhUgazaSOq3Xi0EW8itF+FefSOTz3vPY2PKKsO0066NzwnAUidh5DCjD04811znnebmzLPySznzHe2U4HPPxnPKIGFu+DQLE5cfpJt/Hm3P+HCo4006W0LLnJzguQ8SkNKoQGGhn3tFvOgS9F+rvIcdjdkfBEkYZk2FiQvqUpmd9fumJFYOwndoBGpOgWgvmwqFtQk0RaTFPytqX7Zp/mQYqFoRcRRn1weaVRXVO5pBPfUv9B0WyDAIpWunNcXtvIV3o3eKHjU5DWM4P+1JwXERjzyFjhPRBvTqt8mmKUBNdlItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTeoz2WdknRninISThb6HEdU1RKcA2fL5H139zE0icw=;
 b=YXkYkjHxw8Im7+NAFAfNKPPvQRHhDwr2IxJO9Q95rSc3h/8TA6mMkYEai5BzrJ3Q8x2cHg23lVfjBuXtyQ9x269b8zYFpvLk8+uFvHqEq+JhrnHuCqmo7SIvPJnwx9NopP/F3LV5korilJiETLFwzDPMHzwaP/XG+rz0a6qmnPk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11188.jpnprd01.prod.outlook.com
 (2603:1096:400:3d7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 00:16:24 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 00:16:24 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] PCI: rcar-gen4: Fix type of type parameter in
 rcar_gen4_pcie_ep_raise_irq()
Thread-Topic: [PATCH] PCI: rcar-gen4: Fix type of type parameter in
 rcar_gen4_pcie_ep_raise_irq()
Thread-Index: AQHaASmkpnPNsAO5wEiJrokjJ6MdbrBOU4GAgABZlGA=
Date:   Wed, 18 Oct 2023 00:16:24 +0000
Message-ID: <TYBPR01MB53410A9FC80204414692264FD8D5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231017-pcie-rcar-wifpts-v1-1-ab1f42bf9386@kernel.org>
 <20231017185119.GA1315341@bhelgaas>
In-Reply-To: <20231017185119.GA1315341@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11188:EE_
x-ms-office365-filtering-correlation-id: 2b9fe5a7-c0e2-4624-f659-08dbcf6f76a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDF/mAYuTYRqFenShcSqv0DvO3FcES1W7+B2viy3UvIfiIcXyUK2VtJu4isUv5h2tvp2pycIOneXvSwzhUsYnV5PXK9P/yvoLoJowiD9eXZY23t+RE3kOkTp8Io5nlEKaM3Ep7o8qzyE/cX+Gm4Jy6T5WmPQJD5fppSd3bZoC7wVTC4Qn96iJnT5/hGgW8NxXUq9IF9LWz+4qkb5V1ILFrxJDHIW3dCHc9QtL7IH2Hmz1Hg+s4oZuWKQeYeUW70VX2Xjs4OxD9pW25pHDp3mt4yYAgiTiTRwpz/YwR6b8pPPDggcegWm1AmPr6WcrE5NJJf9mI4jyfeKxjxtzfwFQRJqQoIxb/zrUhCe1GyE2VOHbUAyUqRBKAsOJRgvVejXb0xXoG9GRqSHlxuGsrdC0lAL1VGIRaSDYmA/BiF20LPMtSY0dMNe/Oaw1ypMY6UGHHNvFAApHRtv7rg5x9cTD3flctW9OgzikyY4U0vHRsf1aVgRflR4lPmWwYUMM2u3rNJphV7enYM7rZhxprnigPBKoRhVX/8AOPRSBzE4PXmlztZIqvFxGAfsBJv3GmCc5FYmgnJf18bEjcGncGvYpt9EknnYtGdXhD4+lCsVL5+2cIZjLNgCNBBEkODCmF62
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(122000001)(38100700002)(7696005)(6506007)(33656002)(83380400001)(38070700005)(9686003)(71200400001)(52536014)(5660300002)(4326008)(55016003)(8936002)(8676002)(316002)(66476007)(66946007)(54906003)(76116006)(86362001)(2906002)(110136005)(66556008)(66446008)(7416002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1pZ1xgu5vpwjD/33kt+iPoewqGboXoql1KJact3bc3k39nDzCcit/bBJ9a6T?=
 =?us-ascii?Q?YLNXgQe6hGjPWtD545tJMILVGs0BVRvGqeUYGhdH8c95tF6D8qJSTSz1Ti2l?=
 =?us-ascii?Q?qwdv3HuDMqwZx0BK17/v44QeOCRoWzUHdo93CWj3o2h+42zA15SmzCNN3xaN?=
 =?us-ascii?Q?9roCZQC91WY4/od4DR2GluAmRVyOMu4PT35PiLeGbbbo5CgEJvDkEi6Os0Nt?=
 =?us-ascii?Q?b33BoEACghToF2gyKrVVIyZad+VLGaPD6GYV5mh0eXAw7SJdOQREMT5WesUy?=
 =?us-ascii?Q?CNBZThRiBi3e0RYesm1VjhyQwMmZjWC+tjN2oEhyzJ/w2+XZP74igsrR8GaX?=
 =?us-ascii?Q?FdgOIUJ74CzX7+fYNjjlCxkukvysDgDpCK1W3UHX8Jpu80TMIqiAyTXuFywx?=
 =?us-ascii?Q?SUgr08SHyhhjfXZHcd84PsQfCxBz1o1YC1t/p6xQtLqyPl2gJYYJvm62vhRH?=
 =?us-ascii?Q?3fpESDEDl/K1NQo+/hkG8Md/mgplfQxrlOEVA5zxB00X2d0YQVAidwzP23Gk?=
 =?us-ascii?Q?T3ktN0l+AknXdTxb7iobPhpDyd8wm0LGZwi0VCIkWibAujhPC/dFUXQ/EXvQ?=
 =?us-ascii?Q?o2c09UXJUPEZJPcFpG25TSHlGzw+IvO8rnDustaGwJMIRkrPvvtCfUj3ZG8l?=
 =?us-ascii?Q?E9q0tC28D/4GQ1ebv2xrh4S+p/t9Cbh/V2j3B7FOslogNoojJStLz2Ot39Sb?=
 =?us-ascii?Q?J7ozGlwu3SypII14zWQMJb7okfXzHkDqXIYDpSpYwy8U6unM7rt0H5WD3Cdc?=
 =?us-ascii?Q?bNQFPX6K3nJgTzdXuzTIM2BrgNgUKz/BsVsnvkf/bkmd/v/oyy3/wBtbLoxh?=
 =?us-ascii?Q?bf45wACmEPaXRq4YwjoEhwIeV0LR4u87spAsC4tdSXf47tJ3cqZP5J3aQ54n?=
 =?us-ascii?Q?bjwS86SZctZU1MA67OMyFU8YWx4EwdebEIpkJyjcVBVuDOiTFMv1vV/4ngFd?=
 =?us-ascii?Q?Hsk/YpVs+ZhW/GUKj+58MlKj1uHm9Err25wNd6SY1WzKBcuPGJHHnWAdQYWS?=
 =?us-ascii?Q?2eBtHF9X3u4HQ7sFOyTcmInhw5aqnbt2OrgyqQHf/LAnTsU3wBC4ueIPF5H6?=
 =?us-ascii?Q?Tzq2pEPYsnScr9siCH38SqAW2g/2BiTZ+lhRA3YTB3Tui3etCn+wyPa4q5vj?=
 =?us-ascii?Q?CmyrKNHhi7w7Z1F94Iuatw/vFioCpf5B5/7Zd3mAtaDSL7t49djC3IO8P8IS?=
 =?us-ascii?Q?JMbrk0hCHgqvpKUhSwbHfeh4+jqQGdqUZM1tBe/atYGexhmQXpM7zww1FgRf?=
 =?us-ascii?Q?JDO0nmsX/1G9z5v1wtwZN8n5J5A4ByHEwLy+byuOj9PRlm6o4pLJZIVBUlee?=
 =?us-ascii?Q?U0WKEpRYxOAiOGcOeYHwrY4UDoTOvW25cbG+Oa0Wn8TrZ04LX1292LBSBBLN?=
 =?us-ascii?Q?5PecdKX1Wipky52lISgaGum2fZc3LvvNrYeoaiV4UgLnobiXJjV+k7v1LJBi?=
 =?us-ascii?Q?8Dk8CAQPRy4yg0ypmVV5UbhetYbUliF3wOV6phzbX47SCaM8YaAD1YveR/dw?=
 =?us-ascii?Q?A97Vry3yQkzr+n9RhZjp+gGbrG5NL2POdXVj2O7a08P9p3MgTXVvRywKSDv6?=
 =?us-ascii?Q?TS7mHeHviDJET5LNCdsopcAMA+IA8JIZonBWFpyZG3v9/gQ/chp125zLkKQZ?=
 =?us-ascii?Q?0AaljDLOCmVZWCKAKlfy7OsT1KSO7eyoZaNG/LF0j/Ud2fwl5QY2gK9QpDCm?=
 =?us-ascii?Q?IdCGwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9fe5a7-c0e2-4624-f659-08dbcf6f76a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 00:16:24.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZXaPK6xTDm72vfrv0HgB+ycvY2y1mB2GYrQ6tB20ZqXgqkXcwDop2Eu18VXJHjGjDCi6eMbRmUKZ8k6wV+AgmnrN8wx1rcqqp2753D6gfPcvZw7pCItvHfzCFXoxiBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn, Nathan,

> From: Bjorn Helgaas, Sent: Wednesday, October 18, 2023 3:51 AM
>=20
> On Tue, Oct 17, 2023 at 11:41:58AM -0700, Nathan Chancellor wrote:
> > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > indirect call targets are validated against the expected function
> > pointer prototype to make sure the call target is valid to help mitigat=
e
> > ROP attacks. If they are not identical, there is a failure at run time,
> > which manifests as either a kernel panic or thread getting killed. A
> > warning in clang aims to catch these at compile time, which reveals:
> >
> >   drivers/pci/controller/dwc/pcie-rcar-gen4.c:403:15: error: incompatib=
le function pointer types initializing 'int
> (*)(struct dw_pcie_ep *, u8, enum pci_epc_irq_type, u16)' (aka 'int (*)(s=
truct dw_pcie_ep *, unsigned char, enum
> pci_epc_irq_type, unsigned sort)') with an expression of type 'int (struc=
t dw_pcie_ep *, u8, unsigned int, u16)' (aka
> 'int (struct dw_pcie_ep *, unsigned char, unsigned int, unsigned short)')
> [-Werror,-Wincompatible-function-pointer-types-strict]
> >     403 |         .raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> >         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   1 error generated.
> >
> > '->raise_irq()' in 'struct dw_pcie_ep_ops' expects a type parameter of
> > type 'enum pci_epc_irq_type', not 'unsigned int'. Adjust the type to
> > match and use the proper enum values in the switch. The underlying valu=
e
> > of both the enum and the macro is the same, so there is no functional
> > change while clearing up the warning and avoiding a CFI failure at run
> > time.
> >
> > Fixes: 32b83c68d634 ("PCI: rcar-gen4: Add endpoint mode support")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Thanks, Nathan.

Thank you for the patch!

> Yoshihiro, can you fold this in on the next rev of your rcar-gen4
> series?
>=20
> I dropped the rcar-gen4 branch for today since it broke Marek's system
> (Samsung Exynos5433-based TM2e board), so when we fix that we should
> be able to fold in this fix at the same time.

I got it. I'll fix this code and send patch-set as v25.

Best regards,
Yoshihiro Shimoda

> > ---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index 619262d32f4e..0c0f5c257b14 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -353,14 +353,15 @@ static void rcar_gen4_pcie_ep_deinit(struct dw_pc=
ie_ep *ep)
> >  }
> >
> >  static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > -				       unsigned int type, u16 interrupt_num)
> > +				       enum pci_epc_irq_type type,
> > +				       u16 interrupt_num)
> >  {
> >  	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_LEGACY:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > -	case PCI_IRQ_MSI:
> > +	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >  	default:
> >  		dev_err(dw->dev, "Unknown IRQ type\n");
> >
> > ---
> > base-commit: de45624e69e14ccd6b4b2886155578bb218925de
> > change-id: 20231017-pcie-rcar-wifpts-6c65df6f8c8b
> >
> > Best regards,
> > --
> > Nathan Chancellor <nathan@kernel.org>
> >
