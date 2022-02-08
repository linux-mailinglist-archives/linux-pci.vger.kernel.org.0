Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E274AD320
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 09:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349535AbiBHIVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 03:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiBHIUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 03:20:52 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6CBC03E909;
        Tue,  8 Feb 2022 00:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar6rQ+NfXVhVxlHyUK9RTpFE0/SyPS1HSC5wVSWCF+ta3LgkYAzh7/JiS0uojD4I4TZZUSYqjC7t95oqM+44y7GekzegwRQssw/FPKRsC0QZ2PTngpiWS+PAZYShHSZlnKVIEgOULueoE9NcJbkWUYrADg0YwUuijPsPb8hfGta1iP8tw3J4ACKLTvvjT42GsJNs0uBK+OFjTILBLPDgxPbIh8WkFYXmib5F/3if7zSyNwr8EQzPOaCWzDx6t7zplrRSCjsCkZjYs9CmS4Yihb87e1467T3pHrK7FZEs6Y7WD9Ogb5tu02ef6U9Z0h9vEgxCzDMn4JRHFKZ0WNgLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbT4h+5k/NObLmhCfW8T/QRYumfuC5GUOVniSmQq25I=;
 b=VAAbkv4UK95DHjbJCZBFV1cAQbvRyyrHjm/jO1a8v+8qvC8Uju/kySmvxmZvtWaaEoOWkpiiYfezCNS2shTcFxocvBnT6fNr41CgATDs5MjApnGnSANM5M5c0bs6H5VGJQxTkl/m0wbrz+3zS5p6+QjdRNi8rxZvzOANCWe2Pw2Y2TCe/K0addvtPyYB01UI5BYpeodmmj3X1FZnUbqEgTS6avPVc5owwLXQ27U1HcrzVpOjIpiB6Ook15Aih+IzPuR2LmnEhk7i4DLTnv+LG0eKZMW40ifUaOGk5PNEF1G78JqzAF4CqdOe+wf2mEQPVKl/O/B9nzK1NbjvvY9yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbT4h+5k/NObLmhCfW8T/QRYumfuC5GUOVniSmQq25I=;
 b=YeILRRb08WdbWfQszSksYRL1/y4ynghB6fJ3TDPYl16PAdeT8C1hRxExLWqC+liyZ7Ve/wTpsHgxkf3s0VnWNs9VBdpDpwewM4DVH1tdYV/piTURRxrJm3lxoRam1DMGliCvKTJeY72JKnpBFP5NJOYRXvDwTG+oKPAxe6L/HJk25L+fBE2//R9Bx1O9a9yIQrsduhN8y0k9UJ6G9o8MdqeAQXC2pFwbh9clHJwQ17jJM8x7nnh4pTXEQG3wkYqFnNUDf7rgpiuxA7wi5RiObwbc9GgchgV+t9WhNri308AKmVtdfkJLT9iSIDLJKSHbS/iqIFCPHlH4KcjGZkx3sQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB2512.apcprd06.prod.outlook.com (2603:1096:404:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:20:08 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::d069:2ca1:99cb:b937]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::d069:2ca1:99cb:b937%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:20:07 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Thread-Topic: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Thread-Index: AQHYHLU/wak6DMtWCU2KemAPJzVaSayJRCQAgAALm1A=
Date:   Tue, 8 Feb 2022 08:20:07 +0000
Message-ID: <HK0PR06MB32026A17E53EB76DB898A399802D9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220208062927.3527137-1-neal_liu@aspeedtech.com>
 <YgId0AhvRAmIcEA0@kroah.com>
In-Reply-To: <YgId0AhvRAmIcEA0@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e43b5d9-f6c3-450b-64ac-08d9eadbd125
x-ms-traffictypediagnostic: TY2PR06MB2512:EE_
x-microsoft-antispam-prvs: <TY2PR06MB25126D0B2BF607A952AFF7B6802D9@TY2PR06MB2512.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8sKQaXva0gXPtXlspjXX8NPgXLNsQx9RFJylQbe6bTcDEx6j2aviV95Ty4YqN8xB3Jvlupm/7qY9eLGRE9pQ38bniILflfBLc3+niO3CDE0+a4f0cWXn1WgnYuPzNKZiIE9Tiu9sK1BTItRQsIZhDCUgR6yTmyzfgtj3eoGH+xNWQaEeYbPh7AhzE2ntdip/f3xucnw/1x32WH5fySp0trxTq7pDIfPfEMtA1dJ7yCpflux6mEQpte6CQ2XNLqyi9pX3ICZEYqA/ihZbsrNZLBLlJruc2Nzi3NVJJaiDmSsFWMLNe/QUYg6EMmJGN9pnd64vtb6a6rJGopSCUcfNkoKWdPEEAejciRQkNhLvZZPmeLaoeCrlUGcNTWSdBGuP3HcWD3E1IeDDmlrR7/HyctyGUKnaPn8xn+MFc94eqaO0KHDx+d3BwCE6Zcn4OYrS1zXQ5UusXR4Bvh59v/8jxFhhhC8jarc9NcBbXhndgrQSjCPBnCMst/uiaY8zzSVJOAxC752xsDk46Xwg5loc1k8rhBuzE/X/bqmWv2Ygbh1m3xwHPZ6clT8VDdaeXwt+Cw+cOzv741jdgh/VARHLI+YJL2Oj/Uv2gDtAOyCP7LBL04lRMZIuk3KT7xLuiqkgKHHFCMM4VdDYPCyZtxtJdlIyQfn/k2fr8RYpAQ/uIADwQ0JOQmuiI3WayboioWtSSbAhL20JRRn5dhAyW3BFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(136003)(396003)(366004)(39840400004)(4326008)(6506007)(7696005)(53546011)(2906002)(38070700005)(83380400001)(508600001)(66556008)(38100700002)(122000001)(64756008)(5660300002)(33656002)(6916009)(76116006)(66946007)(8676002)(8936002)(54906003)(71200400001)(66476007)(66446008)(316002)(186003)(52536014)(26005)(107886003)(9686003)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rTJbzwO9b8r6qqrwuWrXBu1yJA5+2f7KICkpFwBB+1Qd19nqiiuQ8gx1KE/H?=
 =?us-ascii?Q?GcgjU9uLaYWXEBMYQQp6Tu8dFY90dPCqrh2lf5Rjwm7nklq2IRsul2q2CqPT?=
 =?us-ascii?Q?HpTJfFgt1QOud5Zqwpkm1cgd7a2p/xMFF6eVvg/ZpbhbksAzL+A0eu7hGcCR?=
 =?us-ascii?Q?0axHbvzHcoUL1SltttbSrLaABmVr10exRVjFP33Cl9iDBN1I1SYq9DTJ8i3v?=
 =?us-ascii?Q?axoIcAqv84JDvcHaXe22pRE32AooILUFxlTBfOFXa0hq5rl+x2litv7+NBHh?=
 =?us-ascii?Q?KZ+A0YpdSeKoLKJJeKqOG+AGIZKgAeAE0dxb5Ux3DNjfRakCet73NxFjsxfu?=
 =?us-ascii?Q?kuYAKaDBggAtKxB3nStQi2AmJB/OngoEib9sI6t0Vr1Ns0xsHbokSZ2N0PWU?=
 =?us-ascii?Q?aUsjw02FA+k17EQ7rPfX2uQkzOmVm9wvUqGWPqdUSoGsC58/EtlV4S3Urs+V?=
 =?us-ascii?Q?Dy8AGAPDNnNsOhWdVO2MCCBbxgyMVQUW7v69D20upOyUqgyFDTUAIHBcTTMi?=
 =?us-ascii?Q?1bd2+PBTm3ApdBnQxylPp03uAswgF2lVMa1/B1696w2EJu/WwtBTFs3lbIQZ?=
 =?us-ascii?Q?TYGRfNMJJugl7h53aPRkVb7KQd4Ofdfb5m1r8EVEDR1VJ4h0YopyoEFfV94j?=
 =?us-ascii?Q?YEydZcDCia7omJGWHm2h4hDoR+colGke4xIwNeN3VmYlAa/7ORs3Hc+5Oq4I?=
 =?us-ascii?Q?BfVDcs/RsHu4+u5lXizj7IhtJ+/UILDwveqXQWYt1G99XG43IrqTo8XrnkRc?=
 =?us-ascii?Q?koHWLfRfE1Zmi6o4JxqRUixM3PtajCOK2+UM/wWrZhFqYPB5WDbDzV0EuruL?=
 =?us-ascii?Q?TxCEabnHpQ4J+djTvKyCVnsQVvyyRwJMl9ir7EGd8WDNvrUmd6K5ngpZQYVl?=
 =?us-ascii?Q?D0cvwCFbBl6+zxiu+qDEW+4RH5u9hXCmjxC+uuOu9RH0/j+BmnLRa2ajE4RH?=
 =?us-ascii?Q?ORN782nvqc82X5f5aQQE/ep6rbz6b23yhOTxtV0qp+1VbCMvFDXBPeeTDChW?=
 =?us-ascii?Q?ClP/OAu4AV+u2rTfuR5woQ/mfuYNMGc8wIov/lCpgxcDU4fivev8WHQND8Ih?=
 =?us-ascii?Q?gWBps/CmASksLZ+3IteRA2Yq4FftPFLN4o5Qa6aTa1JMm64g8vIOqvFoSsyc?=
 =?us-ascii?Q?2CpHBkkqrJJ9Brn0F0NSyn5JVCXDR7ckR2nm2dExodOdiIwQcGle0BBhay90?=
 =?us-ascii?Q?5+fsaLevJq+6Y5yx8I+3J0sDk11kG0Dh5CqZvXQm3aKaqjyRJ9yrhI0/qdMn?=
 =?us-ascii?Q?HWWwHrEn5/5RGwiRhSZq1Cjpu6B+1Qs3uvvjo53EkdxvxMpWgwV9RUc08oG+?=
 =?us-ascii?Q?348ZJfeCy5DzE2N9DOPL27uAfxJfPBTc3WHyZaMmR5PWXcIfJbUmgqIb6N2e?=
 =?us-ascii?Q?g2NDlnuU4vl0VJs5numT8M+bxYQtQR1MUsfIeJuZyw1Kt5LrHZEA5a21UxTd?=
 =?us-ascii?Q?yLdh1egguu2s457nox1GFGU/t3qRiQjWGvtvltxwrAyXLeefyGPE5OgktXbW?=
 =?us-ascii?Q?8lBub9MHMcYB1bgmw9W2sE27kiC9GkVW3FP62Ws95mDmN53CHDRsdTFjO31q?=
 =?us-ascii?Q?2eM5RWTtNJ04+zW/9UtIYTdRWY77Obo9g14PKWt895v7msjmGyIGwsUooE7v?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e43b5d9-f6c3-450b-64ac-08d9eadbd125
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 08:20:07.4449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rsZpcKhtGF4N+QtAEJYtG1KQX17ZPNnJeoCshm4yKYDJa+PdfzRgwKSo438Fp26ygpCTgdZDn9ffVLS0HTHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, February 8, 2022 3:38 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; Tao Ren
> <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] usb: ehci: add pci device support for Aspeed platfor=
ms
>=20
> On Tue, Feb 08, 2022 at 02:29:27PM +0800, Neal Liu wrote:
> > Enable Aspeed quirks in commit 7f2d73788d90 ("usb: ehci:
> > handshake CMD_RUN instead of STS_HALT") to support Aspeed ehci-pci
> > device.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/host/ehci-pci.c | 6 ++++++
> >  include/linux/pci_ids.h     | 3 +++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> > index e87cf3a00fa4..a91b25d216ae 100644
> > --- a/drivers/usb/host/ehci-pci.c
> > +++ b/drivers/usb/host/ehci-pci.c
> > @@ -222,6 +222,12 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
> >  			ehci->has_synopsys_hc_bug =3D 1;
> >  		}
> >  		break;
> > +	case PCI_VENDOR_ID_ASPEED:
> > +		if (pdev->device =3D=3D PCI_DEVICE_ID_ASPEED_EHCI) {
> > +			ehci_info(ehci, "applying Aspeed HC workaround\n");
> > +			ehci->is_aspeed =3D 1;
> > +		}
> > +		break;
> >  	}
> >
> >  	/* optional debug port, normally in the first BAR */ diff --git
> > a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> > aad54c666407..410b395fe56c 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -3096,4 +3096,7 @@
> >
> >  #define PCI_VENDOR_ID_NCUBE		0x10ff
> >
> > +#define PCI_VENDOR_ID_ASPEED		0x1a03
> > +#define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
>=20
> Please read the top of this file, this does not need to be added here.
>=20
> thanks,
>=20
> greg k-h

Are you suggesting to hard code vendor/device ID in driver instead?
Thanks

-Neal
