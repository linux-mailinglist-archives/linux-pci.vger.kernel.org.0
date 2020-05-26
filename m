Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0396C1E223A
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgEZMuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 08:50:08 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:44000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgEZMuI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 08:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANdVCgZ2S2GbKmSExvhuVdWrTKlKQ383QB4c/vqvF5USt7k5FiwgAW42b7WQdmzapcPKviBfVesPJNck98B+5vNdoTRn6uUK8+e7CZBNP/uEhZSIMVs/iUH4Aj3gLgWsqmAK6KhehzvNDnmH0Ev32ysdQI6N/Y2BNRtUd7DL7EWit21RfClStRVndXeOF7lvrpmOGIqUQF1KdyyepkEayKkAoK7fGMrmmUSrA9JiqJ2xfyl/j+KhDpkKgUXnUq5Jp/Om24zq5aXBf52u6N6Z3UjV/AQv6gxNsr1vzmq+ELDb18VZN6u3OWqK1ozSLTCLPhwitrc7EKCUBjCXFtLAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ5WsKRo9Rdol0Yasuro8wuK0OOmz51gOif/gPbiKP4=;
 b=Eo9CLar54YoGj0qmTNn0EP/5Rp3WNruAjm5lluxOGWWHJh70+IZCOCgyq6jRpu2pxP2S1tW++u/8urvoWBXgOeFk83whcxYi3SbKvdaGVAnJoaqhhZQ9H7nEgh85LXKfJvjYWIoy0rSdNW/gcfGuTKGldVKFSZZuFcpjSLUo4fBo/PeEKGv1T8bTywbs88Ud7HqdmSyhYPeNgWuy12g+80A1F9HM+adFkMvgAtSBVWvRGQyLaoCthy6hWw1ldjpvjkgSbZRa5LZVhOXu2HMOqqxFpLC1ngNOAx/cZauKciEvqwEAak6Lc6rTwHspBuesprt/WC75CpI3uZQyqpA/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ5WsKRo9Rdol0Yasuro8wuK0OOmz51gOif/gPbiKP4=;
 b=nIhy7NhKbW+Ek/ZsaSTwtN+PkBVscPtWPptq4BV8BCvNkmatImJRT1RKPqJfoGhRI2WLQpoHNipBEGABKkkTm9/p1JcjisNR/ySIdQwR4z+FlYi2X26ClkNklexhQvoOQZr87+cMSo/8dg4/PAQKoxtsYpF2JJR7nJLWvt/dHc4=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4118.namprd02.prod.outlook.com (2603:10b6:a02:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 12:50:04 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3045.016; Tue, 26 May 2020
 12:50:04 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
Thread-Topic: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
Thread-Index: AQHWJGb/NJjMqJD1V0CRUShbSGSEjKixoPsAgAjDU4A=
Date:   Tue, 26 May 2020 12:50:04 +0000
Message-ID: <BYAPR02MB55594205C7B5C3AB415B5B0FA5B00@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200520222040.GA693614@bogus>
In-Reply-To: <20200520222040.GA693614@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a9f55ba-e419-4823-6473-08d801734fbe
x-ms-traffictypediagnostic: BYAPR02MB4118:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4118F48C0DF5893E54607A4FA5B00@BYAPR02MB4118.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8w9JBTCnhA4icfy9uZDiyvtIMSYGEXiArS89Vz3WymvEZi0J/YOcZKQSHiuDFFhZf8661TieAHFtde4wn3O+D4jyAccfHqJrnWFTUtI79qoCFcSWy7NfBWxtn5q8WKkfNrh7iMiSkm08oRvpQ2MCdddY5Q4iz+8IINHvMpC+E1OBuQfG8nKH48LNsdEOhy0RdtMuq2UiQbg51GTMf12/QN93Ld93OzYszZEOXjbuFNjGNxRlVmcRgALnrSYMyEfD5JzZUrqjT816UN+kQht767oxH4NeAUnJrwmrPQPmsqUCG6KUzN9a3l38wsywlKFWf6UhyAlvVMKuj2D0wp9DjPK6DXwY44mrjdRDjVnKnasTL+jzPlvjwoOCALlEcJ1sscoHEZOXw3gmMVEGdMiB2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(71200400001)(55016002)(9686003)(8676002)(26005)(6916009)(5660300002)(186003)(2906002)(8936002)(76116006)(316002)(33656002)(86362001)(6506007)(64756008)(66556008)(66446008)(66946007)(7696005)(66476007)(4326008)(478600001)(107886003)(54906003)(966005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Put9BtCUdoGBk+xdorIaoDnRaxN+ORbuF82SPAolS+R5jhpGEVR82fvfpJJ9uF1sL7C74IzRPWegzdcxr6oJA6FazCekJyWHVDUnyje0HqV8+fN/CQGo8IXovws7+tAvHDeQdLTyA+UutzJJk+VNhn4REo8f9A+2RGvq8xXUezOo+0J9JgjbOrp/tImztX0eP2vI4lKaAbxKY9N3h8ZSMozRu/GOxF9Q8eeddtwkjjX9C/g34VrcD7ASbtvwgH1wm695v1X0+30aK96yonkNWa3vmpiNtaOSDFscX5Cvja6gnqNTccYVGiv+Oya5QXT2rfgNekQC2o4/KQs70QNX+vcd0wa7YU6uO9p9UbOPOHJTgQ2VL2jZVQ0id/P8zoVE7fzXYuStHIyVDbYEgFjk/Wz1sdcRDyLkHDNqyCijLmocQvccOlNyNEP++aTWHZ6USwCNSReIVOTVv40NvbU53HHf0fTA4PYBNQfhPbv0OCCUFCmGgxEPdc0Ccy18AU6l
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9f55ba-e419-4823-6473-08d801734fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 12:50:04.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ywvb9gqhyfZg1LaxNixN+/3PEVso+jxVshA2cQBBCG7cbIl8mB1/+uphbUbOR0a0jVOSq2HjWk2g1l8r/irVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4118
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal
> CPM Root Port
>=20
> On Thu, May 07, 2020 at 05:28:35PM +0530, Bharat Kumar Gogada wrote:
> > Add YAML schemas documentation for Versal CPM Root Port driver.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 105
> > +++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > new file mode 100644
> > index 0000000..5fc5c3f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/xilinx-versal-cpm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: CPM Host Controller device tree for Xilinx Versal SoCs
> > +
> > +maintainers:
> > +  - Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > +
>=20
> allOf:
>   - $ref: /schemas/pci/pci-bus.yaml#
>=20
> > +properties:
> > +  compatible:
> > +    const: xlnx,versal-cpm-host-1.00
> > +
>=20
> > +  "#address-cells":
> > +    const: 3
> > +
> > +  "#size-cells":
> > +    const: 2
>=20
> Can drop.
>=20
> > +
> > +  reg:
> > +    items:
> > +      - description: Configuration space region and bridge registers.
> > +      - description: CPM system level control and status registers.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cfg
> > +      - const: cpm_slcr
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  msi-map:
> > +    description:
> > +      Maps a Requester ID to an MSI controller and associated MSI
> sideband data.
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
>=20
> > +  interrupt-map-mask:
> > +    description: Standard PCI IRQ mapping properties.
> > +
> > +  interrupt-map:
> > +    description: Standard PCI IRQ mapping properties.
>=20
> Can drop these 2.
>=20
> > +
> > +  interrupt_controller:
>=20
> s/_/-/
>=20
> > +    description: Interrupt controller child node.
>=20
> type: object
>=20
> And then need to describe all the properties under it too.
Agreed, will describe properties under this child node.
>=20
> > +
> > +  bus-range:
> > +    description: Range of bus numbers associated with this controller.
>=20
> Can drop.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - reg
> > +  - reg-names
> > +  - "#interrupt-cells"
> > +  - interrupts
> > +  - interrupt-parent
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - ranges
> > +  - bus-range
> > +  - msi-map
>=20
> interrupt-controller node not required?
Yes required, will add.
>=20
> You can drop all the standard properties required in pci-bus.yaml (it's i=
n
> dtschema repo).
Agreed, will drop.
>=20
> > +
> > +additionalProperties: false
>=20
> This will need to be 'unevaluatedProperties: false'
Thanks Rob, will fix these in next patch.
Regards,
Bharat
>=20
> > +
> > +examples:
> > +  - |
> > +
> > +    versal {
> > +               #address-cells =3D <2>;
> > +               #size-cells =3D <2>;
> > +               cpm_pcie: pci@fca10000 {
>=20
> pcie@...
>=20
> > +                       compatible =3D "xlnx,versal-cpm-host-1.00";
> > +                       #address-cells =3D <3>;
> > +                       #interrupt-cells =3D <1>;
> > +                       #size-cells =3D <2>;
> > +                       interrupts =3D <0 72 4>;
> > +                       interrupt-parent =3D <&gic>;
> > +                       interrupt-map-mask =3D <0 0 0 7>;
> > +                       interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > +                                       <0 0 0 2 &pcie_intc_0 1>,
> > +                                       <0 0 0 3 &pcie_intc_0 2>,
> > +                                       <0 0 0 4 &pcie_intc_0 3>;
> > +                       bus-range =3D <0x00 0xff>;
> > +                       ranges =3D <0x02000000 0x0 0xe0000000 0x0 0xe00=
00000 0x0
> 0x10000000>,
> > +                                <0x43000000 0x80 0x00000000 0x80 0x000=
00000 0x0
> 0x80000000>;
> > +                       msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> > +                       reg =3D <0x6 0x00000000 0x0 0x10000000>,
> > +                             <0x0 0xfca10000 0x0 0x1000>;
> > +                       reg-names =3D "cfg", "cpm_slcr";
> > +                       pcie_intc_0: interrupt_controller {
> > +                               #address-cells =3D <0>;
> > +                               #interrupt-cells =3D <1>;
> > +                               interrupt-controller ;
> > +                       };
> > +                };
> > +    };
> > --
> > 2.7.4
> >
