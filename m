Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF082A0627
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJ3NFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 09:05:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:54172 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJ3NFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 09:05:10 -0400
IronPort-SDR: +vQ2ARelE/f4A7zNNLVjbADN2ASCqy+44FxONENwsNkq1T1fGwrOGhICXXM86817qq2xszFt1H
 jIbAaC5+TJiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="232779792"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="232779792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:05:08 -0700
IronPort-SDR: KeJ4MWM6FeRwx51M9OwS6lEXD5MRAOUzvvr7oWK6LN5vdcm+faHBfpTzvuDQwr/IkAbliDJNli
 pme+zfxdHnfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="351856431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 06:05:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Oct 2020 06:05:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Oct 2020 06:05:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 30 Oct 2020 06:05:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 30 Oct 2020 06:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1j/fJew9lVq6AC5vPsCYKKj+PVnKYDRZlZsiIswD/mLVvJbHsXwmbcfjY+dDf5CUQD1LR06uKZc5O4fA9ZdHC768r1X7WZWzemSLz/KUhx579Q/Ib5KUO87o7YDrB75WpIrqsy8/Ce5MxnFbp6clxp8faDnaPQR3j2XAXsZhXYhEZTMR5bOdeHQWZliyzo/mtbSz0a3qLQFl9EsvCgRJVw3fRnW/tSZ04qYj+dFsdJjTJoksTlComeyQZv9/Krx/R8Iq/5aH9XYVVk4hU1G5soQzE+M9zXbWG9KIVReNvJQjf7C8Yil6VxrLWcIAiDE3Pm+or08+sCN2r82gfWR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy2AIaMkulp7F+DcYDPECJVjkmBX9EW/ffST4DoSSSw=;
 b=NjbejY+LnASMlP1WcMHH3KxU5aonLIEgncDPsFgptimV0RYgo/Wf9rxBwooaU9rXGcRVGc6r3wLlyEokOVk3h7Wm47onx/JBbq6b8b7XZwtY+tDaP422cDErEjFRzCPn61JDcPZqpWG7pPh6/ZCo4ScBIlI5Qr46wDXumgZ+lCEANy2fAXkW1CqvghgQR1B8YFMF/7OPQHMHztYVLp8mSq1j5Ak9jkZjqlwZ7n22xVSESxEmlpSdF0BOp8SDQe1yhkPeU89uAKBtVQLFReuCSS4WU2hZz+ckv3Iv1rmfdn4LBXK9SC4uBOTU1sqw6dCx4OZTztMlfZQc0bos7QZWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy2AIaMkulp7F+DcYDPECJVjkmBX9EW/ffST4DoSSSw=;
 b=RNwx/84K5mHG+a24CtRuXeuxPgg1YACHfPxteEIzOKGQMRZcXkV63Y4zsWrOBUo1OqSlbz+E9jzKIu27VXtNRwVeuQ2MIvuSe3cTsLwx6D25zmiN7x0Nz8U/eB4EIamMcEVJ5X5bOn6WG1ycQQ3rWEDBRAfG1WGaU+37NWAewFc=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 13:04:48 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4%6]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 13:04:48 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Thread-Index: AQHWrCaxhZj5grmS3kiKdr1Lx1u9aqmtGMWAgAL7nPA=
Date:   Fri, 30 Oct 2020 13:04:48 +0000
Message-ID: <DM6PR11MB3721FA210CD596C4C64306F8DD150@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201028144219.GA3966314@bogus>
In-Reply-To: <20201028144219.GA3966314@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.227.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1becb0-537e-414e-422b-08d87cd461b2
x-ms-traffictypediagnostic: DM6PR11MB4627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46276FD63D886D099EA2CE30DD150@DM6PR11MB4627.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNEmce+k7bCBwXhYUNT5gb/CGiA1vTHfWD9cnOS/X7Pl4iv/Vu65GFAFM+QywdQ0AV0eveDM4fYACZBYJ0evL1ItagUNwBs3qQQGPmk3E/WTzmb6m1U/E4jsBP8sqc4JELiDzl92feEHuHdLuDexQ3TDsW0w5em9fFj7byV19QxteLGBOO0QDS5chEC2xKoioURB7zj9KAZ6ZiLSfogK3PviuBkZ4ixdaI5icf4iZ73z4KImosJHe120GyFsCgaJ9H49ASKCDTquQI/uklLZbIrAXtJqKFvtWeJBefTHnP788N9u+tSi5MceRxCqAQjwSIW8V2XzGjA8QBBWMM+jEyJ+htk/fZSFZXHl1fK8CfnfeJFlRDqi7fWIPmlLxdfIptfO4YZue+4uNlohxC+8+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(55016002)(64756008)(316002)(2906002)(66556008)(66946007)(66476007)(76116006)(4326008)(6506007)(7696005)(53546011)(33656002)(54906003)(71200400001)(186003)(26005)(9686003)(66446008)(5660300002)(8676002)(86362001)(8936002)(83380400001)(52536014)(6916009)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E6Z5k9FivZk6fd9GAxyOIuu/SUi4tYMtFmMnVqgCZTgtw4K9c5tq+TtPInQYEhLKFtX5fd5YtvorngglKFj4aEtTAUM5JaMrBC2lI2GTDN9HstKrWgC4XyAeLbfIdcwCspGcc4UiWAXZXV2iY2sRsadtNiNnh9wN+1KLoPi0VCtjVJWxRgE7/vzekORwfecsyWjbmoWY1D0dqw1iJ5Z/cYfhuoi/IgjE3vI2Q8qTqK4RyhrVVklF6+W5OQPuYPbJLJdHtnSiWjtN2AarnXyMbhvuvcEM0lkoEXcHNZgFh5y5Q0xWnTJOhyRqBpjqOJqGDSFb1bu2Kvw1fcpMO/Nwvm8RixwaPdIFEmOEeWKqRPY3M5TjVXhozMkpTbj5b+8SCX+Wcxe4qOYxbl4IpAk6D+hJkDWgRyTJ9UpaqOkMMZEArYMmYeXzWb+6rHAv25kFezF8Vs4glxROBoQs0IwQF/3n+vuKdsM/03+u0bMlI6RZygpkvFwXzJZl5GLNeyzuvr8bzCpFmSh4sbzJ5tuKmNxV9cXC1B9NPeCHKrdUENEDzNuE4DQrXmf0cVsh7hckct4KG34mJ5+jsx2eJQ4E6RDbGd9LVsxSsAExuAf2mTdMxmM6e6+Mqc/Q/Sxu9jCF4PNIKchMl9DNT9PqAXxFXw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1becb0-537e-414e-422b-08d87cd461b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 13:04:48.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5IxxlZ+3kQIxv79/Z1+awEV1EFbEJxlZcU79bzk2zsdZttcDF7CGJEs+Lnr5BIgDFUfPZB33Fx22LteEUkY1s11YKFya8abdHYmRvu8qDfcro17JKwVgcBswJiWrz/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob.

Thanks for the review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, October 28, 2020 10:42 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe contro=
ller
>=20
> On Tue, Oct 27, 2020 at 02:00:10PM +0800, Wan Ahmad Zainie wrote:
> > Document DT bindings for PCIe controller found on Intel Keem Bay SoC.
> >
> > Signed-off-by: Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > ---
> >  .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++++++++++++
> >  .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++++++++++++++++
> >  2 files changed, 206 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> > b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> > new file mode 100644
> > index 000000000000..11962c205744
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-
> ep.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Intel Keem Bay PCIe EP controller
> > +
> > +maintainers:
> > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > +
> > +properties:
> > +  compatible:
> > +      const: intel,keembay-pcie-ep

Fixed in v2, wrong indentation as per report.

> > +
> > +  reg:
> > +    items:
> > +      - description: DesignWare PCIe registers
> > +      - description: PCIe configuration space
> > +      - description: Keem Bay specific registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: addr_space
> > +      - const: apb
> > +
> > +  interrupts:
> > +    items:
> > +      - description: PCIe interrupt
> > +      - description: PCIe event interrupt
> > +      - description: PCIe error interrupt
> > +      - description: PCIe memory access interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: intr
> > +      - const: ev_intr
> > +      - const: err_intr
> > +      - const: mem_access_intr
>=20
> '_intr' is redundant. Drop it. You'll need a better name for the first on=
e
> though.

I will drop _intr in v2.
I will send out once I get suitable name from Keem Bay data book.

>=20
> > +
> > +  num-ib-windows:
> > +    description: Number of inbound address translation windows
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  num-ob-windows:
> > +    description: Number of outbound address translation windows
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  num-lanes:
> > +    description: Number of lanes to use.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 1, 2, 4, 8 ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - num-ib-windows
> > +  - num-ob-windows
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +  - |
> > +    pcie-ep@37000000 {
> > +          compatible =3D "intel,keembay-pcie-ep";
> > +          reg =3D <0x37000000 0x00800000>,
> > +                <0x36000000 0x01000000>,
> > +                <0x37800000 0x00000200>;
> > +          reg-names =3D "dbi", "addr_space", "apb";
> > +          interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
> > +                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +          interrupt-names =3D "intr", "ev_intr", "err_intr",
> > +                       "mem_access_intr";
> > +          num-ib-windows =3D <4>;
> > +          num-ob-windows =3D <4>;
> > +          num-lanes =3D <2>;
> > +    };
> > diff --git
> > a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > new file mode 100644
> > index 000000000000..49e5d3d35bd4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > @@ -0,0 +1,120 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Intel Keem Bay PCIe RC controller
> > +
> > +maintainers:
> > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +      const: intel,keembay-pcie

Wrong indentation as per report.
I will fix in v2.

>=20
> > +
> > +  device_type:
> > +    const: pci
> > +
> > +  "#address-cells":
> > +    const: 3
> > +
> > +  "#size-cells":
> > +    const: 2
>=20
> Can drop these 3 as pci-bus.yaml defines them.

I will drop these 3 in v2.

>=20
> > +
> > +  ranges:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  reg:
> > +    items:
> > +      - description: DesignWare PCIe registers
> > +      - description: PCIe configuration space
> > +      - description: Keem Bay specific registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +      - const: apb
> > +
> > +  clocks:
> > +    items:
> > +      - description: bus clock
> > +      - description: auxiliary clock
>=20
> The EP doesn't have clocks? You should have roughly the same resources fo=
r
> RC and EP modes.

For Keem Bay, EP mode link initialization is done in boot firmware.
This include setup the clocks.
That's why I do not include clocks for EP.

>=20
> > +
> > +  clock-names:
> > +    items:
> > +      - const: master
> > +      - const: aux
> > +
> > +  interrupts:
> > +    items:
> > +      - description: PCIe interrupt
> > +      - description: PCIe event interrupt
> > +      - description: PCIe error interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: intr
> > +      - const: ev_intr
> > +      - const: err_intr
> > +
> > +  num-lanes:
> > +    description: Number of lanes to use.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 1, 2, 4, 8 ]
> > +
> > +  num-viewport:
> > +    description: Number of view ports configured in hardware.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 2
>=20
> Pretty sure it's not 2 if num-ib-windows and num-ob-windows are 4.

As per pcie-designware-host.c, default value is 2, if it is not set.
My example and the DT in my system is 4.
I will fix in v2, by using const: 4.
Should I drop default?

>=20
> > +
> > +required:
> > +  - compatible
>=20
> > +  - device_type
> > +  - "#address-cells"
> > +  - "#size-cells"
>=20
> Can drop these too.

I will drop them in v2.

>=20
> > +  - reg
> > +  - reg-names
> > +  - ranges
> > +  - clocks
> > +  - interrupts
> > +  - interrupt-names
> > +  - reset-gpios
> > +
> > +additionalProperties: false
>=20
> Use 'unevaluatedProperties: false' instead.

I will fix in v2.

>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #define KEEM_BAY_A53_PCIE
> > +    #define KEEM_BAY_A53_AUX_PCIE
> > +    pcie@37000000 {
> > +          compatible =3D "intel,keembay-pcie";
> > +          reg =3D <0x37000000 0x00800000>,
> > +                <0x36e00000 0x00200000>,
> > +                <0x37800000 0x00000200>;
> > +          reg-names =3D "dbi", "config", "apb";
> > +          #address-cells =3D <3>;
> > +          #size-cells =3D <2>;
> > +          device_type =3D "pci";
> > +          ranges =3D <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>=
;
> > +          interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> > +          interrupt-names =3D "intr", "ev_intr", "err_intr";
> > +          clocks =3D <&scmi_clk KEEM_BAY_A53_PCIE>,
> > +                   <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
> > +          clock-names =3D "master", "aux";
> > +          reset-gpios =3D <&pca2 9 GPIO_ACTIVE_LOW>;
> > +          num-viewport =3D <4>;
> > +          num-lanes =3D <2>;
> > +    };
> > --
> > 2.17.1
> >

Best regards,
Zainie
