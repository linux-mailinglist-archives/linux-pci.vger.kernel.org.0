Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9E6275DA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKNGSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiKNGSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:18:54 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04220DF36;
        Sun, 13 Nov 2022 22:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXIKYCNUFk6AtKURg13x+SQApBAUdgr3JDWH68Ipbe1PCa8AE273HQ8jzCZqjsLH4eKQpBp3Xfun1Hjxhirx6VzN/xv2cpzYcL/6/CrqNHAfpY98C82WZWIsJiJLqtO7h/FZya8piHQgFY6r27o8MxCgC/UXU+mcVBds/B954sSxwBmAQpoUyRNmGCbBZKyMtj5ZgIRL7GPe90M+KsHn/z6CO13TZCz2xgFH6WNEOA8S0lD25YtWjR9ElsExXXy0YQ7hRNL4K5t3i7vvzU3ccJgzjh8288DHUe9ZI+Auc8gignMgusWATH0wfAhjA9lq2KTaK/juRkwpmbx6GDbM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aptn7jjNYJ3oSi9b9vHIheXN8sFcVvVJpNOcc6Xv6R8=;
 b=ZCOB2a6MpqmM6fiT6vbCFm6U9dU6zC5cBPDb1vZe2V/bbVvOvN8vbmsLdwdZ79TqK1CzWSc4/0soWALBliZxr12Xty01M068n1Wj3D4cFzvR0WrIikpsGf51WnXonnd3CgTkg3KLsaDbrz6cDG76NbiWF7XUcTM1Vnjx70HKtdiNwS03mTIhPv1Hg3FLEWVlniTluSHSMQYvyqCkOkMb/HiuUjyJ5VGg1n2FNgMue2j401oBqAGJwnn5z3vpTEdlIsTtKtxJOteK84vhDhDtIsYCONgkct4IEB/NiKy/XikE5cpfj/EXUlt/WFbqgSQrcHromq1R4bOVn9ukiBLE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aptn7jjNYJ3oSi9b9vHIheXN8sFcVvVJpNOcc6Xv6R8=;
 b=EXg2j42hHlpoJloNfdz4qU22vOdOSy9oGYnEgpky4iWTAVZnlwTPxQ305XGYpjV6CTxhAJzGWhQBsxBeq3iDz4WpIpIhcJ3zGCAx8cEBMoE6liJX1UlC8YfcDowe5HCDokmb/+AiXpWnEzMUZb+qvtb9QAG0kZLFj4SXnvL74/s=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB7703.jpnprd01.prod.outlook.com
 (2603:1096:400:180::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 06:18:49 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:18:49 +0000
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
Subject: RE: [PATCH v6 06/10] PCI: dwc: Add reset_all_bars flag
Thread-Topic: [PATCH v6 06/10] PCI: dwc: Add reset_all_bars flag
Thread-Index: AQHYzlpQ+P5/JxeBq0O53Aus+cSsJa459xWAgARMXmA=
Date:   Mon, 14 Nov 2022 06:18:49 +0000
Message-ID: <TYBPR01MB5341EAF314C0B3366EB8122BD8059@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
 <20220922080647.3489791-7-yoshihiro.shimoda.uh@renesas.com>
 <Y25BQS3GZkzbz8OL@lpieralisi>
In-Reply-To: <Y25BQS3GZkzbz8OL@lpieralisi>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB7703:EE_
x-ms-office365-filtering-correlation-id: 52191493-7751-46f8-0bf0-08dac6081858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsM7J+EMqYNQIgWPRon7ZEZidyYb1dwAaUeB7Y5bOh2ngsjAUON22l9xQ0Uz378hqghomY64u5bZUFygB2PHceEh0e9Lii51zngNylvXGmm+FcBNl3HusuZ5iHt+WmEMtNUfOGCDkpZ3JorJZQ4XLxnI+id+PctkQaWJPpM5t8f0zUkOtphXdTsYU6jlvEffKJ6dptH5oWNRHCCLbdQqdMwnbrakiOhYZCz+qD8vzxQ8jIYwFQYz+3xPuoyb1GrvNS9zzvshdgAm7oz1PLVN9lnWSyH5naCSCCql91WEKTJazDbKmhhkgGMoU3hQ9xGZ4L4d4OUFOcsRdYDppcYz3y6+ERT/zjA/3QPx5s4uIYv8BZHEakbI35mUkZAI004gEYdSy3m+cxMhz9nKWlK5sW/TikQzjiseOov5mKlqBFmFDz47Te4E56pTD6aUwyrwyfWFvNhwLdtRtHyZ+phIimwAW4gHdnZBIHlZRQFE44juSIwaDj1MvmAklWQmB+6BmG9bqtLYzr0QO2GZ+OZTWbScnkBxdW7gzp1Pv6ZXK2PzzaDbvCCIxdaAcDeOYud+CfodeFT4kDxyu85SaO75Vnvu2gfsByiehFrHipMkS5feULXDI+2e/6c8aG2+yIJbMiF/5fl2rTL3mf3Aoo4sIsdQhrkeKhSWYFr1NW06SmuJzd4KQDLh5+pqf/k8zXsrWLP8oReRpMLrINOJO8Rj9Sqfor20N0YZ0jU+GTKZw5RckIauko+WrW+Oi9SN//hHsCzYRYzzobFizmqnfl/KKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(478600001)(38070700005)(71200400001)(110136005)(54906003)(122000001)(38100700002)(7696005)(6506007)(86362001)(64756008)(76116006)(66476007)(66556008)(66946007)(66446008)(316002)(4326008)(9686003)(8676002)(7416002)(52536014)(41300700001)(8936002)(186003)(5660300002)(33656002)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJIpAC63Bt1jrMnxuvn6+HYfOhp9QLE6bewbfhsBEhgBwjIz5DzNRgicacyE?=
 =?us-ascii?Q?rxCkSl4E6dshlgzdh18vBNdNsrtQLUUndG3d5ny5uOo6QgUN27FiqEGgfi0D?=
 =?us-ascii?Q?NWfRStdZ/zYOpXjHP65qcU+gMi1npS9mvdZZG9cMCvPiG2tsiT+nG3B6vFcY?=
 =?us-ascii?Q?EVDOOGAO8y9FXh+pUZ7k78V3UFsGdYn813a7XygRIllfgXDmc6/0H0sy2vTN?=
 =?us-ascii?Q?c2O2HDhZR6ZO2Vc/Lg40BhmmkohgU5XFgJYM1lgxBhsnnRep3LuCfOG07TjX?=
 =?us-ascii?Q?MDIvQrxeuGyoSzer2b4+hHM1F6gTX7SJGuSbi9v83/QTpVHT9dolMhJ6sOFR?=
 =?us-ascii?Q?/iol3ni6BZmHY745iJuciYsBP3saBfgx2DYpv45GSNNmddJVmHec6CvxwfOH?=
 =?us-ascii?Q?l/E8ze4zUwWPvqX0zknQJzKRBPgfvYlf6lJszghvVPU38ZViFh4D2Xcb1tML?=
 =?us-ascii?Q?XIGmZ87nC4KXmdEZ3hUXOfD+oNSNpXmy9k7Yck9FPKLRuvKRdc7mmCBDThVz?=
 =?us-ascii?Q?Jb6GQKkkUm1v1sDWeWq7r/0LGHqK0uyKHqmH2DLZ37kgc8SGZNtlyfLL9Axz?=
 =?us-ascii?Q?AHl2envnGaqI1TtqjAa1+Ts0HOHMAqrbdAv3t26dM1EaHpO5l4fU3JjDIdoW?=
 =?us-ascii?Q?aZ6GNBDDQXF+sGS2tpDsriCAHoIWVACkxrLmdzS5pb+YMHZ+GsVYtUa9TmLw?=
 =?us-ascii?Q?m+gMLZmGZsJx6o5ny/HyQ/fgrpuzBfSDKnyr+Y7aZAK4H8It8h1r6h0rn34a?=
 =?us-ascii?Q?ayQr9gBHfXs3mXyaHZ6ZlZwPN56aTLHsDsIWKQijE+OLQbrnKYPq5wIwk3XH?=
 =?us-ascii?Q?qh2HQF6UOAydleaCIKY13Fpsigx1piSZRNDUQZ1btugnWi6F/T1ZwnnWOzUr?=
 =?us-ascii?Q?/NIOzLWVhZKxLvfPDqvi+m9AoFS2w51/xDRHiZmn6dPn3pl9vKpOCkRj5cDn?=
 =?us-ascii?Q?vySaPKkqSlD9Xm57ioCtz00NOxVUmSOQF+vk6whVlhX2FDqQl60RhuMceQmn?=
 =?us-ascii?Q?B5JPKcfqzrdnCT9EBqdBY2Ib8SFoaUMDQyApUoJFqhLYcHAXtQAyNjCrHeO/?=
 =?us-ascii?Q?aCG2uwA0EcJpGM0MqM4rznS/yZZGSSQog+0x01zzcrXZB/Ye3XOKV4+oKSGS?=
 =?us-ascii?Q?vvM3VmKXnI3kIHddWEDGmc5uVUKqL9vNYqkgai2n1IqHQ6VQrgOg6PXwdrIX?=
 =?us-ascii?Q?xyXjsP0OS3FOWB5juWMLc4Y/TQZnRbupSroqt2WlommwrLCieY+1X3QGOx6+?=
 =?us-ascii?Q?AjhfoXInpnvFr6+ozgIpFlyh+xFmen56sZnzdcRpWy9DznV819lrOfZdwkGH?=
 =?us-ascii?Q?KNPx80HBF2T54AA10Q2EDYcHU53KBrM5MpN02XYatMFsy2yIrsQfZf5J5KE7?=
 =?us-ascii?Q?iMshphhqUbCebliCdXhqTR2g0VAMeSSx2HudpTVZgr6uHaFrJAk6qbINu2gp?=
 =?us-ascii?Q?f+uW7My1wy9UH1BgUh+b4xc9YG9YVq8285zK7h3i7VuTd6FwVsZACjlR42VE?=
 =?us-ascii?Q?F817WV4Vpn7m9crL2qCD3xXxlzFa/8+TFEqTgEgmJ2mF7pO3SvxsSu3OwHJ2?=
 =?us-ascii?Q?+vdHJAx+2tdyOVbxMyVApFD0eCvnYiuI5gVfh5CAjdR8zQnFhGYZN3ih9X01?=
 =?us-ascii?Q?SdkM7fKx1ABdZ6fj6RN5HoQHw9SIRxOchoO6xUmw73cRXbPzmeT0+pu9SVpO?=
 =?us-ascii?Q?iobSlg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52191493-7751-46f8-0bf0-08dac6081858
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:18:49.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYZ52C/wXVJTN5+Fn7lSkMO1ULTWOaGjSWmGHDV5sAI3sQxSDJrJYn8fQ5g2JdIGkm4RLWUmVHjDtoQI1h3S25bx1IS9xc+zwWOKwyGAXZHUkXL9tVW/8Xsh1GcjeYHC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7703
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

> From: Lorenzo Pieralisi, Sent: Friday, November 11, 2022 9:34 PM
>=20
> On Thu, Sep 22, 2022 at 05:06:43PM +0900, Yoshihiro Shimoda wrote:
> > Some PCIe endpoint drivers reset all BARs in each ep_init() ops.
> > So, we can reset the BARs into the common code if the flag is set.
>=20
> Is there a reason why only some drivers do it ? What I am really asking
> is whether instead of a flag we could reset them unconditionally in all
> drivers.
>=20
> It would be good to come up with a set of guidelines on kernel
> expectations rather than adding them per EP.

Thank you very much for your comments! I realized that this is
completely unnecessary code because a PCIe endpoint function driver
will call pci_epc_set_bar() to prepare BAR(s). So, I'll drop this patch
on v7.

Best regards,
Yoshihiro Shimoda

> Lorenzo
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 1b7e9e1b8d52..a79482824e74 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -83,6 +83,14 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum =
pci_barno bar)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
> >
> > +static void dw_pcie_ep_reset_all_bars(struct dw_pcie *pci)
> > +{
> > +	enum pci_barno bar;
> > +
> > +	for (bar =3D BAR_0; bar < PCI_STD_NUM_BARS; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +}
> > +
> >  static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no=
,
> >  		u8 cap_ptr, u8 cap)
> >  {
> > @@ -759,6 +767,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >
> >  	if (ep->ops->ep_init)
> >  		ep->ops->ep_init(ep);
> > +	if (ep->reset_all_bars)
> > +		dw_pcie_ep_reset_all_bars(pci);
> >
> >  	ret =3D pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> >  			       ep->page_size);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 9ed9621a12e4..0ad9ed77affb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -353,6 +353,7 @@ struct dw_pcie_ep {
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > +	bool			reset_all_bars;
> >  };
> >
> >  struct dw_pcie_ops {
> > --
> > 2.25.1
> >
