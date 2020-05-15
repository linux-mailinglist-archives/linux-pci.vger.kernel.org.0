Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A21D4553
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 07:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOFiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 01:38:51 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:6070
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgEOFiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 01:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSWENNiNiy9fkUN5r578pMqtwG+WgS0XsMs897cnbGOJmdN2q3E0L07ETQYlYWWObY2I+10M9HLhbkzgu5IrarAPxPjgLGJSqE0/JXGbmhBlbldc27SthkOXoQsQf20m8zE1DpOmDFx/qARsCMX5m8ou2QuqQycWM/4zzb4syhzCFktZhDSFM0tNzKjr9UHfDdcQBeH+VaKQxuCUnekyF345TWbQ6p/JROKA3jGTkGBlsJlxe7H7s054IoshGAOhMmVsYleQsTTXL0t2J0b7dfzAyWlmbK+iVTytXfQ32I2h1v0SJN+1s0iLmd1MhhC0Nq4UpRDEKKFXxqoTUBDagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1UcjGVSTDIcpY1rJFpubfKeReA5EnTohsughm+63Nc=;
 b=ZTN1byjO4C6leFLgE9BZ1Jw7nQKJ8INR9FpafnnkMAUOTGy5JzPZEGmv+/+xE9CER0snW8ukyFHtUo2moSYZX0s1Ro1o+7bT5hpLGXQ4a5q5PukWD6Hwn308PU8Kujg6jxMYBwZ+IqGOJyRxIFtQcnkFB06Fq4gMYCToH3bL37trUSFKBF2+p90K9qQ0zQZ/fGu1uwmmR6GNcjZfYkTk0ZGp8PIhkOShjcpS+LcNTYmOicO6Fiss2WQmbYl+q9N6de9Ubi3pt7HpILicC8EuneCDacnTZNb2sEmrYPxEJG+Mv3ADLGv6oYowoFzTCxEGF/mRG+lj8RoLZyndrzUlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1UcjGVSTDIcpY1rJFpubfKeReA5EnTohsughm+63Nc=;
 b=McbP3oCVQFtUIFVTs3PD7UzeWYJXi7gIPXOt67kLqAxqkk4CtiyCBJmVZxGL8d/mXFdQrrYlg2q6SyUIBFCXhp3aUZnA4+XD6C5lWJW2Y87p+Q2CBzL12PKYDugi9p61WPODJZhYxaYLqYXrRjl3ppY4RvnWTAtydbkDC84SsX8=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4694.namprd02.prod.outlook.com (2603:10b6:a03:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 05:38:47 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 05:38:47 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
Thread-Topic: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
Thread-Index: AQHWJGb/NJjMqJD1V0CRUShbSGSEjKiorUMQ
Date:   Fri, 15 May 2020 05:38:47 +0000
Message-ID: <BYAPR02MB555924C79777E16E7F97BA0FA5BD0@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eeb03b8-df35-41cc-c2cc-08d7f8923d7c
x-ms-traffictypediagnostic: BYAPR02MB4694:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB46946F40D53525FAD0E4F7EFA5BD0@BYAPR02MB4694.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RqJLx9f0P8eUp5EC8C5KiAdfFOUNCrZpr2gpNdYFZkD8z0Ygg8vxJ6iYbOUKPeVmP9I8KA9zGmzge0l3wu+5CfhCy67I1K7/ZcmtCNsfTfAd2ywBmw/2YvsSWim2rHOgwi3DPFHLPsqp/vjgh7UsoXF9TbPiDx3twCbDifd+2pR7d+C97P3+Z0tNkpLPi3e9C34lme1erVRhDuxxtYhjVCRmJUwRbBvxJBWTG4NLz+pR+w0SqO+quHa/iZ5DDkmW1Y+2owXgX9LvlAfapaMzXb1SqN0wzc7IZniktwYrLhgzIrihTEDPpyZcdE2/5hBSRc1cFIjhWK99Yp3smYMdpV9bzeY7ejP+2z45fUjmE24m/ulkLDYe88skkkon3ywgYD9qzUSy/sysM9dPvV6fYUZSRftgvwQ9gdnzUm1jBtB+JaQpIAt4fVXpVM8V70R9Y8XU2ryNgl8i61Iw7TZ+xk4EyJQQbRTOaATazW+NCSS3rP6GvH1A1W5lerLPnIA8wKA7Fscv0AcdR3NSD7Luw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(346002)(396003)(39850400004)(966005)(6506007)(53546011)(478600001)(2906002)(76116006)(52536014)(110136005)(186003)(26005)(66556008)(64756008)(66446008)(66946007)(316002)(66476007)(54906003)(71200400001)(7696005)(107886003)(4326008)(9686003)(55016002)(5660300002)(8676002)(8936002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c0+3RBcAkjgxU5Txl6kfXMcRbLcjW+Nxc9laZjOF9lqcDoT8vyCN88HFZPWRHlJ5RYUOoPLnHEf8BxptLwzTdykauAF1IxliMYOcjGdGa0Kd0BHc72NJIJJaIq8++Rp9c9vwvSWSaUE5H9G2QaOq1di9Jfwd8hXUe2xm1k41OHz31w3kgZow4L+W0JvcuAo/HRzW26MScYIoZzeqrnCmEYLZ63+gQiov2qw2m5p7kWfhogYAjp6AMOfGk02BWFfD3LVPCoUkOgqQCWGVhxg82JEZtiflm0E/J4pd4JTzKace80GYlQ0JtDkjQ8vuvCmoDv/Us4mzs9Dzq0meUJnFvgtvfsDkOx6Kjn4XPVLcOLMORT2+eRF0Br4qli5mbUTZ/dqncCej+32XWLVDs31dWwCrx4mzfH2OAFjMi+M/Yh88vV99/TjTYHARr1J6q+KuLCmVYV/j1B9qbU2RKy4k1BfWS9QyYxNXv6LVvOJrWgdcwTgHauKE8z1w+N2k9X1T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeb03b8-df35-41cc-c2cc-08d7f8923d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 05:38:47.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TR02vMPgIwALsOKt0dDKfoYSaQGzjSWwJP8g5pPsFHXAefcCUUhKLY3T0ve6F6CKynTl09YpI5YJc8STyD689w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4694
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Can you please let us know if you have any inputs on this.

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Thursday, May 7, 2020 5:29 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: lorenzo.pieralisi@arm.com; bhelgaas@google.com; robh@kernel.org;
> Ravikiran Gummaluri <rgummal@xilinx.com>; Bharat Kumar Gogada
> <bharatku@xilinx.com>
> Subject: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
> Root Port
>=20
> Add YAML schemas documentation for Versal CPM Root Port driver.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 105
> +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-
> cpm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> new file mode 100644
> index 0000000..5fc5c3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xilinx-versal-cpm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CPM Host Controller device tree for Xilinx Versal SoCs
> +
> +maintainers:
> +  - Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-cpm-host-1.00
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Configuration space region and bridge registers.
> +      - description: CPM system level control and status registers.
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: cpm_slcr
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  msi-map:
> +    description:
> +      Maps a Requester ID to an MSI controller and associated MSI sideba=
nd
> data.
> +
> +  ranges:
> +    maxItems: 2
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt_controller:
> +    description: Interrupt controller child node.
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-parent
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - ranges
> +  - bus-range
> +  - msi-map
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    versal {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               cpm_pcie: pci@fca10000 {
> +                       compatible =3D "xlnx,versal-cpm-host-1.00";
> +                       #address-cells =3D <3>;
> +                       #interrupt-cells =3D <1>;
> +                       #size-cells =3D <2>;
> +                       interrupts =3D <0 72 4>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupt-map-mask =3D <0 0 0 7>;
> +                       interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> +                                       <0 0 0 2 &pcie_intc_0 1>,
> +                                       <0 0 0 3 &pcie_intc_0 2>,
> +                                       <0 0 0 4 &pcie_intc_0 3>;
> +                       bus-range =3D <0x00 0xff>;
> +                       ranges =3D <0x02000000 0x0 0xe0000000 0x0 0xe0000=
000 0x0
> 0x10000000>,
> +                                <0x43000000 0x80 0x00000000 0x80 0x00000=
000 0x0
> 0x80000000>;
> +                       msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> +                       reg =3D <0x6 0x00000000 0x0 0x10000000>,
> +                             <0x0 0xfca10000 0x0 0x1000>;
> +                       reg-names =3D "cfg", "cpm_slcr";
> +                       pcie_intc_0: interrupt_controller {
> +                               #address-cells =3D <0>;
> +                               #interrupt-cells =3D <1>;
> +                               interrupt-controller ;
> +                       };
> +                };
> +    };
> --
> 2.7.4

