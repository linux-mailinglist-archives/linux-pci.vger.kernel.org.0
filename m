Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F071506C42
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352246AbiDSMZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbiDSMZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 08:25:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64722E9F7;
        Tue, 19 Apr 2022 05:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1WG96J93hnLew4dmshySGC3v20mqTnkmm8GKbrWDUSpRVqFuUIrXrXzbJOD0NYeEUDC9NAFoWvP+1euSh8b96GreOJNXLf/BMy7uonrxIVGzUBVHDOuU9G7mSqE9cTOO4VXxR9qepoHRQ04Ms8/kvSnZmX9wt2ZJWOmofjiXUniB+aya/YVOzvekHxJ6CpBHU/y5/0d5dy2/I0RB1o9ZnYTjcqHDQD95QTrNVZp9+mX8YoAXTSKKJ8AWGhw8rSCfe/uvZKnecT8tc8LhCzCq2s3Y0S2mMMvjVnwdmkxG9tC6ktdt4jXGrPQPaebMIHnKsawb2WAQXetQMQDdT0Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vShUJ2zbzD5Fl6c8xaZ+S2HBa+HBWjXio+bq4mJAP8E=;
 b=ar2sAa6NX9ScSz9Ixp0TbbcsXTOs3OJi3WJ/UolF98Ce9Sj7LsAuESNW2DD69ij8dtgnB99XFT0spE2yM9vlYz8xDsGX+HX3YA2RIzxcGbL/iyHIQdSUoPqB1RqqcAlG8qttmBt+zLQDYmvPSNDaT2UAhHogyWNcdvhd3M0UNsqboNFL1lvDDZnKVPEfhLN19SZguTFOFmzGdemE6pGfr3xmojfM72OL5qpMhrMgTh8oQwC+kg+DGKSxhSIPYDI2zbeQ0N6UZbaa1HBOrYNk+jRr23OI2I4hl6SqUIFkKxExp0hO4xQhlcPF2kjcfD9jiUnIPEPTCUexq1+BX83HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vShUJ2zbzD5Fl6c8xaZ+S2HBa+HBWjXio+bq4mJAP8E=;
 b=cORWJLRebYuChUNjZBYOIyNNH1P4JVCtjTat0EKiEaf2q8RnkRbF3NxKdqZJbdheuvT5pw3UNX+JCdsm+Eq1VDBu1STJKfEBBQLao83k9wpfLwMelDsXbQ4/kBwsXiEpuyuel58wG8z0Ukds4fQXefqyMaSSJb82W0oDzDh8C6o=
Received: from CH2PR02MB6952.namprd02.prod.outlook.com (2603:10b6:610:82::23)
 by MW2PR02MB3851.namprd02.prod.outlook.com (2603:10b6:907:9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:22:50 +0000
Received: from CH2PR02MB6952.namprd02.prod.outlook.com
 ([fe80::41e4:2d77:dc8c:4ec5]) by CH2PR02MB6952.namprd02.prod.outlook.com
 ([fe80::41e4:2d77:dc8c:4ec5%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 12:22:50 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Thread-Index: AQHYT+E9/sV+4/r6Vk6Qc10RFN72kqzvW4qAgABCswCABwmPgA==
Date:   Tue, 19 Apr 2022 12:22:50 +0000
Message-ID: <CH2PR02MB6952D1D0E6FA89ED25110AFFA5F29@CH2PR02MB6952.namprd02.prod.outlook.com>
References: <91ef84f9-4cac-c0aa-c717-7f1b3bc566fb@xilinx.com>
 <20220414164508.GA753109@bhelgaas>
In-Reply-To: <20220414164508.GA753109@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64e4806f-3eb7-4a7b-5cb0-08da21ff5216
x-ms-traffictypediagnostic: MW2PR02MB3851:EE_
x-microsoft-antispam-prvs: <MW2PR02MB38519EEA698B8E4AF6E7875AA5F29@MW2PR02MB3851.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLw6UKif2mpHVQLLHti/avN4SIArsm7Z7c77KkSfJJ2ibdyiCtyvQhonZI+siv9IIwRFICTAR2+/hJ0S/bUh22Nuyk/eomwSOjk9vn0vJKLyA9qimJFk4Ds52hdRzEZeIN9yP7HlORts6XxuqsIn3qaTSRyNkQuCtN5cUk3qrbEsk2bUqkWCdKo6OmgSKCuPJPPPB/dRyzTHvwA+7412+qnKUbNIWl0K4K0YFUvdr+HpZy9InRIMmNBXVdsyugR5rIyEnix0kyiE0jN7TO5ALE1nuiQohL/1Zg2aJbjjx6kjbVbQzko+pSvqD1iXaHVZHc/yHYYXK6IncNVUsz41JcR8vBN25TcBcYVlscgvgzVVBoDTiV9U3/CPNWMf6LyEOTETqfaaESL4fk0trZq9Osn80ePCIdMqHEHrweAs0wsvwFf5wchYuAdv+jIZw3ufNog/DdWKTI5M9Ieq+BHzvHw56UU3E/hqSW+YIk1jFG1++J4IgXEet+j/lUJ4n/4gOiRnXKHUhBYHYyGl5NHxRuV11d+/yZK8OJvu0ja2t26nUEGW15iel88wCTi6Kt+FjooFhwqKnS0UjH1K6q9+p8wl7JfUSPEiVJw7HdhJAPlGjrcGGEc4IfjyGTJnWb/OfM4C3kJo1GLGT6K0gXFxXOtWVL3o0Hy8LEedpRtHQMHDgMgqlXcIbTRBTnE7VIAkzHhwMO/FS7YU4lWN/KeSKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6952.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(64756008)(8676002)(4326008)(122000001)(38100700002)(2906002)(110136005)(38070700005)(186003)(33656002)(55016003)(66476007)(66946007)(66556008)(76116006)(83380400001)(5660300002)(86362001)(508600001)(66446008)(7696005)(71200400001)(8936002)(9686003)(54906003)(6636002)(26005)(53546011)(52536014)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QAVIk7CgdxKMRdaBhiO66Voghc+/SAL/GTS1NCQIe3CipVAiR3TITlYPG6k0?=
 =?us-ascii?Q?5DLJxzGHSsUvDcZFDE/8Vfen1XRfac9mTY83G5X4hDv/DrAtGiKRvT+JPxZT?=
 =?us-ascii?Q?nibtonFqaXTQgVDiSn2I7XAIk/E9/tpB8HKFFhhYFR1He6U3rZRKoB0SoDrN?=
 =?us-ascii?Q?jVydICYDJ23NVql/FMWeezTivK3I3rAMN+irtmJEvqc9zF6pJ2SEU8SCRYxc?=
 =?us-ascii?Q?cztDkhD2PVXEYwgr5865JT/2nwT+2JM1Yi6YufonzmoNNHIO3MYXF69WvbkB?=
 =?us-ascii?Q?N6am4vjCQmUnVxzuHniXSMeVuvz6Kk7IPkomFoHgfQ9lvsH0kerhV2uy+Qnl?=
 =?us-ascii?Q?3BwtLU7ZWj0OcvAwwTd4v4a9OUDcRYtl2XTopAPfSjnPlRdV8nMy0vn48uWY?=
 =?us-ascii?Q?HgNcdH3eKV5yIaOkJpOlMU3UP7CMGYIPSuouaVP6MvCkfYrBiAYWHYiIFubQ?=
 =?us-ascii?Q?1CwjwxvZa/RJpwgefg2uVDWfU8Nz45W/JdSperGu2sFPYdtVBuv7G0+NIgQV?=
 =?us-ascii?Q?3iZXnU+JeVCof33wkZwcHfnoxhDcKC8wnNdv5yq9sQ2bLSRKKllhtWeyALi2?=
 =?us-ascii?Q?2H4je9QPtUut/OSQPHjFeBs3GDd2G16vqWmiIS9rmL7J2/3PesWgmMY5Pd4r?=
 =?us-ascii?Q?YRwQTlmGlwOviJM+Z0JBoY28uP7I2wdb3EqgjJ2kETOftUGlami+k4BtJ63S?=
 =?us-ascii?Q?OF0ffbFSZja4Ii8UQ5BGEyEhEWMtvmz4+jR8K4FLFiI6ShWrzs6axPNlCuhs?=
 =?us-ascii?Q?2eGB9vemkTfCpxNmRYbpNGPGLYdFTuuvv+Yiki/7SNlljQ1Bop+VKxK4G/Dw?=
 =?us-ascii?Q?hDLXcj5x/ZLmGyOJz4ZoF3tXrqPok45tSAQTN8rNmEBFW06JTfjGkKVo/YEF?=
 =?us-ascii?Q?90QHVCgJJVPbx/8Rf99WsRXD9hDlfpcunSfNwctGm8nmVRSOe882E7XO8/XJ?=
 =?us-ascii?Q?ZIV6Q31cXWgryhmKVTPmgDSlmkBj//z3Oiu5jOx/0wr70FTaV2/gJtNqpSOF?=
 =?us-ascii?Q?3Jj0dXhenWcWQ4zE6RdgUtfX6P1GVMKYjzG3xBE4TFXDD56z7RJcuzhz1hk3?=
 =?us-ascii?Q?1p/jesgFXR+4Fm31JaWp3iYkAAmluiQX91ndPPr+RHN4CXI9J6N69GPV4Yw8?=
 =?us-ascii?Q?PUXN88B+TZmvssNXaCz7T+Y+PwGcRModacX9ECnQdag/CNMzMfUQBD59DeV0?=
 =?us-ascii?Q?eUJM2sfbGMHiHBUzh2+YGJoxhFC4cdwCCB1Nsewlex6hyPBwTpCgKT4v0wMr?=
 =?us-ascii?Q?oZU37QxpeRA9KIAjnrMXqX/oMzZ3rNLzwHIR5UOrSrguFVN/4JjbKu1LTiSl?=
 =?us-ascii?Q?EBq+4SbFPftWnBUqZF4mmVAcPNg06CU2kPxFz/9JR54SsrMzojIEnEZsmK0k?=
 =?us-ascii?Q?UCdUQhts04swTO0caX4lt6Fd1V6BbNux7anVDh6rX3Guyd1SM4Y8KUZyOM2v?=
 =?us-ascii?Q?qrdFVh1fwYW8z9K7utFc5esaoc9gHVNYEboDh49RTKMJLuePwFNpQrJwW4N1?=
 =?us-ascii?Q?u3lJca0Prp4I8Pwz0mejoLeoycC7ibNGycZgyUCUaYr04R+LT99pJpLu9UCM?=
 =?us-ascii?Q?dHsZlVPfkZlN+fLG66iYTFVwxIMru3QPzdXSAZWR0rc6YaHs2u/TbHQGku9w?=
 =?us-ascii?Q?0ztfjp3i2M7KZ2CESaqMrDkMcAlQFBSKVpkqxGBTPzFTKlWVCGWev+H+3kVj?=
 =?us-ascii?Q?++F5GIX/YGVrUN5FGqz64/bvFX8UQ2kw3t5BhR5z8DEGMrm1IhM3oJLXAGgQ?=
 =?us-ascii?Q?UKataq036A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6952.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e4806f-3eb7-4a7b-5cb0-08da21ff5216
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 12:22:50.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWas7WvXHx8OXalBThf9x0aOLdAr071FCa5prhCIO1bm+IPBK9hBySyWyDDyekczTMbAXuGhRKmvr9OlUMyfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Thu, Apr 14, 2022 at 02:46:25PM +0200, Michal Simek wrote:
> > On 4/14/22 11:22, Bharat Kumar Gogada wrote:
> > > Removing unnecessary version number in compatible string.
> >
> > I am missing reason for this in commit message.
>=20
> Agreed.  The commit log for the pcie-xilinx-cpm.c change also needs to
> explain why removing the version is useful and safe.

HI Bjorn, Michal,=20

The CPM block is hard block, Rob pointed out that versioning has no value h=
ere.
Will resend patch with this detail.

Regards,
Bharat

>=20
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ---
> > >   Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 4 ++=
--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > index 32f4641085bc..4ebcc838a1f6 100644
> > > --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > @@ -14,7 +14,7 @@ allOf:
> > >   properties:
> > >     compatible:
> > > -    const: xlnx,versal-cpm-host-1.00
> > > +    const: xlnx,versal-cpm-host
> >
> > And this is likely breaking compatibility for existing DTs.
> >
> > M
> >
> > >     reg:
> > >       items:
> > > @@ -70,7 +70,7 @@ examples:
> > >                  #address-cells =3D <2>;
> > >                  #size-cells =3D <2>;
> > >                  cpm_pcie: pcie@fca10000 {
> > > -                       compatible =3D "xlnx,versal-cpm-host-1.00";
> > > +                       compatible =3D "xlnx,versal-cpm-host";
> > >                          device_type =3D "pci";
> > >                          #address-cells =3D <3>;
> > >                          #interrupt-cells =3D <1>;
