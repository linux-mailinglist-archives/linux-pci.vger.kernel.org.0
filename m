Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B04CB5EB
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 05:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiCCEhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 23:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCCEhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 23:37:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A31119F21;
        Wed,  2 Mar 2022 20:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2jub99Cfd4jrTQ0x75Xjy8cCU3P1ycIXC2j06AVCRSJWeYZrypLLmdhnM8cgTI7/mNuXdhzPGsEaKWRV503bb4TmwoLWBVBcaFU5UqGaOo7iXR5iTSOaQPYtsFe9/NKc+a7Fm3HVatrrpDwq6rxuDuZZb6dRJLsQbBqpZEn2zRctVFfTlN6JsLFhxXAPyuhkUWbBVETvW0roO6lEydx4jobc3DBlyF/dWmNm9lYVkb0C4nc+GnqctCdfCk2YFR51n2nr5XZCD0NwPz+lJCEeuJ7SHUcz948uJC0L7dAssrFnQ74TTobEI28RNUPF83e+k3YOK5UDg3xtLSgWan/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDZoenlV2g43knC6xd7p7SU0zNkAWrrPA5mn/Fx2/4g=;
 b=fsXQY8eSw0i2JdU68WPp0C3mIP7jNrTdyZO5USS1aaO8Yg1G12o6uAQh4scPIvXV8V/M75zGsXjVKoRmrTLHkG/vyzRKlNvw1rMdAylBZq4PuVHr27JtTCGrCWGp86Ri27T1xN+2bRyqT8GPxsovRjrvrGKqKuLnNFrjDC2kpUBw1aAeqvJEOJ4HuWhrNrfMdzatBYHAQSs6yidXTKOAcxefEBLKPntwBSF2KKNe06NWIGIS/2DHljvXPl39M9nnyukm3A2GYXTF0MyMPopQ/anvwuU1W9dzjRZ9TKvYSoWxcUy9xOvyp2HfUGJFizkrbToL2+FTYLfmteBVwJLPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDZoenlV2g43knC6xd7p7SU0zNkAWrrPA5mn/Fx2/4g=;
 b=JOpuHGxy8saDSTC9oZzSrbAP1AImNZ6y+iD082MCI+yeJO/WMeq/c0DALJ3O6SbCB4g8yzja14tF6Te4Q4zDK3GV7/6f+pqHYan/WYiTTG4pQz7be4H83wjl702WUt68ovSv/2iQB5R+tvYy1OwwSDU3H/iUcRKx5KN9LRWXbo8=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by BL0PR02MB3873.namprd02.prod.outlook.com (2603:10b6:207:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 04:36:45 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 04:36:44 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYImoJPPij8nnpzkK8c0Zef9GcHqysUgOAgADZKbA=
Date:   Thu, 3 Mar 2022 04:36:44 +0000
Message-ID: <BY5PR02MB694774FDF8E3AA9D3576BDFAA5049@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
 <20220215124606.28627-2-bharat.kumar.gogada@xilinx.com>
 <Yh+PN5ct8T87f6Ve@lpieralisi>
In-Reply-To: <Yh+PN5ct8T87f6Ve@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34b09f39-d2c3-4e9f-4ae6-08d9fccf6bdb
x-ms-traffictypediagnostic: BL0PR02MB3873:EE_
x-microsoft-antispam-prvs: <BL0PR02MB387319FAA7DD9DE7D1FBABCEA5049@BL0PR02MB3873.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+1+kJBrrEgtPCmj46QhpaSYvfkgFrpasXddzGp0NNqMc9eHwBEjYqmuClBkUwShytigVozAy4sDzeIr+Aih/dk6jMSGMAaQp2S8wQ3NbY0odEvr7BYz8KK5HKLyFSOWtebee8wHdIlmm/cJ7i4drgJqisDIwTVTAShRVdDRlpFgev5Vw3OfilGYkGfUxAmHTEWGsa4FNXqltGw6ByRbpICzJBROx7Y6ZROEPwIaKTMMq1Pm8ifQkf6TdPzrc27t4MhVsmU9Lq9HXdq52Rnbkb2IhP4mLYWhWtLO0qHW6NycPJJWPxjZjz9eJ4SaDXeJeSnKtc3MCzW/DJMoyltmu6w4UGoMFw+RUgAkbhqw8VR9XmLL32VPNNCW7G0WYj1U8akAPjuI3x4b9HvB0PfLAZ2dWAToz/E8AgnqntIU7MXc0sRKN9n1xQrL9J5Ov878XUEqhs4xuPxra3zSnbxaw67IIOd3XLWxPFXqDTUGKdQ8SpkT7m8gh2rizvn/NuStJlHKGYFZNjMdaBRDCqu+AbrK2IGmdhhq+7xm9xrLZtcxDFqi15xgx0LxQ3H3LlHDSkjQ/CQrOMViu+bjqOfqtYXyZF+ige2vrKg3GoQwE0fPT7EHMkmiDiljKrSMgQej+TlnsCu6v7c03YfpAtLPh8CQbMEVWw+yWuRwjsuT4krsewHuu/JCOIe2eQOpYIbuv0z2DU+JXYzkuEK26z8v0Q8ld3MLADTz+a3qOnmblFdR0jqg4XJ29qzUY8Mn/7C1tNQh5USriOaVyYhY77G7VBgGkd3iSOG+7M2N8uQc4BU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(5660300002)(2906002)(33656002)(66556008)(64756008)(52536014)(66446008)(8676002)(4326008)(26005)(508600001)(53546011)(7696005)(38100700002)(9686003)(66946007)(186003)(71200400001)(6506007)(55016003)(54906003)(76116006)(966005)(122000001)(316002)(83380400001)(6916009)(86362001)(38070700005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtoouE8v/W9w3KrrOby5APZlVbWTnH4CMRqhpSSxDJnlBrl+ocmYOMDdc9di?=
 =?us-ascii?Q?pIq1ahu+zU22hs8qesS6g+mfCWaMChCcpxJ2qcsgQn+6f5BzoauPU1jtljM0?=
 =?us-ascii?Q?Yx5B/wXGZGV+HrJI1OIzA8B/JSR8w4axQ69nHckqlvPP2CzS9AH9FuoqZOxa?=
 =?us-ascii?Q?7gxr2p63Vp/0FCq6UyxiYHLC0nu35J71Bm4QRToNhLivNOABufA/aiv2IUO0?=
 =?us-ascii?Q?cb8z6x2+6c7XHANZcrENrxkgKkLHBmjHh/fNk040nUU2ggE4osZzhQSKkIAI?=
 =?us-ascii?Q?WLHvzJHaiMirVUlVcHUW8uXyO1MawKk+d3sNprdduQ/Re2vMpR49vX5F1HpB?=
 =?us-ascii?Q?NvBjhyTG/sAIOIzTnENZYuugjaMcnvUxgTowiaMNiKj2T/lzg1qzwuuM+/4V?=
 =?us-ascii?Q?2zirICDQkJaGXStuSlahP1ItbswsGGliv27gO6FGBYAVsyaZINb+YimuDZEG?=
 =?us-ascii?Q?Ga93209aXLevWxavBJk8I5U0BC8uAJ01ftxgZ/aZ1Gt6ODIHjPfG+xwDviE7?=
 =?us-ascii?Q?Rq45HOyQhWIVqwtpltuoI9p70Wk2XccBM2VTMv5SjzL+4TK5osfEZa+2BJB/?=
 =?us-ascii?Q?vZeRJ6lXvXUXGQMMueW6D22VfebBfY1Hq5gQKwqEvZWtzQFcff581PTqcOUR?=
 =?us-ascii?Q?HamVXovnOpmhXgnx+Bpp6gCPmqScgzhqVVqjDRha/TheTjZKRQrX4zEeoosk?=
 =?us-ascii?Q?aMATCNtPGWk7djWydUq5XWMG1lEQZDHIdDC0y0YlhY4Ov5o54drlSs2dwN0f?=
 =?us-ascii?Q?m8EzRFpitN68OWiZI8k04N0zGxniOljO/hD9OyRjIlr8llozIEzi/XVXNZcQ?=
 =?us-ascii?Q?7x6Xgd2OErnzZx1arpKgAVmMFQVj6G/ilSi0S0Xq/qFB9ZE/pJpF+VnZYKsQ?=
 =?us-ascii?Q?+gCSVHojP0AyQrO9FAFnxvHeD3dewXBCghmd4qqP6HG1Fqn8eIyPHX8YncKO?=
 =?us-ascii?Q?zjk+Z5SCgsGPzb1hIAGSHWFsbK5lEkGADl1ME79IydwEEhlXonYl9LFmCdDp?=
 =?us-ascii?Q?AZJpgsNmUGmNSmhD27XVTENVMNzW4DQYYh5uTQBUwJ7g9Lz8s0Y9Whs9id17?=
 =?us-ascii?Q?nnjEdHpQcV4JH2hVZLr++n3RSqk9fXajOtaHdCrgbzdnN70aO8MhgsGPQ0W3?=
 =?us-ascii?Q?Lwe3FwgJfwHKxFYCi46juIkUxRKkDyWs/qw169E1GXXWTgeSP/iYG6g2HH/Z?=
 =?us-ascii?Q?GSljW1GoauZkkMdVSKOsRCz/F9/UNiaoUNEGLEjfKl5YW9ptM8I+KclSQxNF?=
 =?us-ascii?Q?3E0r6kP+zxGPKZP8BJXqbfcZhpOJrTQkA9J0RPrMn2X0hV4IaDtoswp6oIBb?=
 =?us-ascii?Q?0H1g7rpAiBG69G+TkkisdBnKp2m6m0gS2dA/KcHfp8VjyD1+/CAO2S2LKdgo?=
 =?us-ascii?Q?YvCl8CFbheP5x23JXN2DXqlpswf9a56eN6MvvpCwq2Xq388f7UFCeKMW+1rf?=
 =?us-ascii?Q?USQiYF0FNXE7iiUoQXvEbAUN79U07kvFw7VDFwRz6PF76qIyGPi5kSXFZham?=
 =?us-ascii?Q?mAfBB9OgZKpm4V3WlAm/1mrbsEB+RW6su5A/DX1Vy5F+ityeRh6QIbCNPaid?=
 =?us-ascii?Q?3+jww0RJwKkKQO3m+t5MCeWcV7J5gJ/WUPg2QHen7C2732ezclW8ipGerlnO?=
 =?us-ascii?Q?+55vn6a1OMJgV6J8Y17cygg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b09f39-d2c3-4e9f-4ae6-08d9fccf6bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 04:36:44.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKtcFxYXvlwlJ9PMDZuU6vmXL83OnEl65jMTs6jjPsHZMhE8ptMZ1oI7vrPm5AaAOp17v/a4mW+aawWYOFlo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Rob

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, March 2, 2022 9:07 PM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Michal Simek <michals@xilinx.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
> Root Port
>=20
> On Tue, Feb 15, 2022 at 06:16:05PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Add support for YAML schemas documentation for Versal CPM5 Root Port
> driver.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
> >  1 file changed, 40 insertions(+), 7 deletions(-)
>=20
> https://docs.kernel.org/devicetree/bindings/submitting-patches.html
>=20
> You have to CC the devicetree ML and DT maintainers.
>=20
> Thanks,
> Lorenzo
>=20
> > diff --git
> > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > index 32f4641085bc..97c7229d7f91 100644
> > --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > @@ -14,17 +14,21 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: xlnx,versal-cpm-host-1.00
> > +    contains:
> > +      enum:
> > +        - xlnx,versal-cpm-host-1.00
> > +        - xlnx,versal-cpm5-host-1.00
> >
> >    reg:
> > -    items:
> > -      - description: Configuration space region and bridge registers.
> > -      - description: CPM system level control and status registers.
> > +    description: |
> > +      Should contain cpm_slcr, cfg registers location and length.
> > +      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
> > +    minItems: 2
> > +    maxItems: 3
> >
> >    reg-names:
> > -    items:
> > -      - const: cfg
> > -      - const: cpm_slcr
> > +    minItems: 2
> > +    maxItems: 3
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -95,4 +99,33 @@ examples:
> >                                 interrupt-controller;
> >                         };
> >                 };
> > +
> > +              cpm5_pcie: pcie@fcdd0000 {
> > +                       compatible =3D "xlnx,versal-cpm5-host-1.00";
> > +                       device_type =3D "pci";
> > +                       #address-cells =3D <3>;
> > +                       #interrupt-cells =3D <1>;
> > +                       #size-cells =3D <2>;
> > +                       interrupts =3D <0 72 4>;
> > +                       interrupt-parent =3D <&gic>;
> > +                       interrupt-map-mask =3D <0 0 0 7>;
> > +                       interrupt-map =3D <0 0 0 1 &pcie_intc_1 0>,
> > +                                       <0 0 0 2 &pcie_intc_1 1>,
> > +                                       <0 0 0 3 &pcie_intc_1 2>,
> > +                                       <0 0 0 4 &pcie_intc_1 3>;
> > +                       bus-range =3D <0x00 0xff>;
> > +                       ranges =3D <0x02000000 0x0 0xe0000000 0x0 0xe00=
00000 0x0
> 0x10000000>,
> > +                                <0x43000000 0x80 0x00000000 0x80 0x000=
00000 0x0
> 0x80000000>;
> > +                       msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> > +                       reg =3D <0x00 0xfcdd0000 0x00 0x1000>,
> > +                             <0x06 0x00000000 0x00 0x1000000>,
> > +                             <0x00 0xfce20000 0x00 0x1000000>;
> > +                       reg-names =3D "cpm_slcr", "cfg", "cpm_csr";
> > +
> > +                       pcie_intc_1: interrupt-controller {
> > +                               #address-cells =3D <0>;
> > +                               #interrupt-cells =3D <1>;
> > +                               interrupt-controller;
> > +                       };
> > +               };
> >      };
> > --
> > 2.17.1
> >
