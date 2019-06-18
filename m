Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3440B49E57
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfFRKi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 06:38:26 -0400
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:48590
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfFRKi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWUE79LtzrYBAdATtIG058Ea266tx7k6sPBODrY69Pw=;
 b=bsY49N5F+AlzGkba2JALZeZ94+oxEsBVscuCu6ueDnq4YJrsrtbErikF1MDlmFqjp+Vj5Qhi/cFprYPlzms40w58UfIVTNnqbiGXjgVY2ssIlxQoLF1RgGMer8KmKGIWo9u2cKEktdPNhzivx5/dtzqsOjug609CN1DlGwuucLU=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB2343.jpnprd01.prod.outlook.com (52.134.252.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 10:38:21 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::451a:14a0:aa81:1b54]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::451a:14a0:aa81:1b54%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 10:38:21 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms@verge.net.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774a1
Thread-Topic: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774a1
Thread-Index: AQHVHP/I/iv2mgFRykWCEYuyY80u+qabZALCgAXlAgA=
Date:   Tue, 18 Jun 2019 10:38:21 +0000
Message-ID: <OSBPR01MB2103F1D063171E45B4E5034DB8EA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
 <20190612114629.wpazihf5ea3g4wjn@verge.net.au>
 <20190614163351.GA30511@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190614163351.GA30511@e121166-lin.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff88d6b2-55ac-4f17-0aae-08d6f3d915d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB2343;
x-ms-traffictypediagnostic: OSBPR01MB2343:
x-microsoft-antispam-prvs: <OSBPR01MB234364B336B04FC747586774B8EA0@OSBPR01MB2343.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(51914003)(64756008)(66066001)(66946007)(66556008)(66476007)(6436002)(76116006)(66446008)(44832011)(5660300002)(73956011)(52536014)(229853002)(2906002)(102836004)(99286004)(71190400001)(7696005)(6506007)(9686003)(14454004)(55016002)(71200400001)(305945005)(74316002)(76176011)(68736007)(110136005)(26005)(486006)(11346002)(54906003)(478600001)(316002)(7736002)(25786009)(6246003)(186003)(53936002)(86362001)(446003)(4326008)(6116002)(81156014)(8936002)(33656002)(81166006)(476003)(3846002)(8676002)(256004)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2343;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BnSJdefGL8Oh7naX6/oXg3AONd/t91wTUW5sccuDSsbRy7e3HW9nGTiknyPMDupOOKOT93F18Rti6Mfv0OSYsM/hAIeDerA0L6VAVR84WW1SpY4Z3cEDQACUZwIsiLbnCF4qs9G0A1UGgDk0SJxA4OrrNeUSSS5quMlJ4/s59DaiGwfBJPqyIxLBiqpUM54V41In8/bj0cTcQm9FneO2PgnM9+9joF0P3unk/38+gt+9LUytuLF1qaa6y0zo1p0aIONSTLXCQmtasrI/qJfPxKuqqIyyOo+vPWOBMNQKaF3cY6UI2EQ1MuvVYVK6RFtFv+M5fWegvoya4F8QqlrNplu3FsxSRq4+f8YxzYsN0qg6pBz217P5nvfLxtWQKfSnlhOyA/Lua/SWxsigWvpp1azooIPgZZgaQtYwUwWwFdY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff88d6b2-55ac-4f17-0aae-08d6f3d915d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 10:38:21.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biju.das@bp.renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2343
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo and Simon,

Thanks for the feedback.

> Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
> r8a774a1
>=20
> On Wed, Jun 12, 2019 at 01:46:29PM +0200, Simon Horman wrote:
> > On Fri, Jun 07, 2019 at 08:03:36AM +0100, Biju Das wrote:
> > > Add PCIe support for the RZ/G2M (a.k.a. R8A774A1).
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> Should I pick this up and send it via the PCI tree ?
>=20
> Just let me know please, thanks.

Simon,=20
What do you think ?

Regards,
Biju

>=20
> > > ---
> > >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > index 6904882..45bba9f 100644
> > > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > @@ -3,6 +3,7 @@
> > >  Required properties:
> > >  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> > >  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> > > +	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> > >  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> > >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> > >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> > > --
> > > 2.7.4
> > >
