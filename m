Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C555020C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383797AbiFRCiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiFRCiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:38:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFAE19E;
        Fri, 17 Jun 2022 19:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUbURKU0uoq53EER0LsXMWxBDXjYwQwk2c4fIFJMQ4aVhnUkIb/gLQBpeneRwNZTxzFazv7WSuHaLSVpzwNgHSbS5N4sS1Aq26Xib5uOk2hsbclw3k/1mCjHfzoKAwG5X/D1QcgOOTSKs8WLJXpU1seB/58s8/lCMZ9tWRZppMI8nYqipW8xGPPBq5MWlSasxnCexpunB7xaePDBhWhVGqJAcac6iG5O+rHjrNNY5MEjU3ufZ0TLYWM2JqvfUbXEbgBtzcOmw4/zMfk3WvZ5A2BOaBOXk5lsPplXQ5mSnewDnxTwEM+TYTey1IMHYktymVV+N1xEXgQAejc5T5bYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z7gnaItY6lYGVX2Fgb8ks73HK9zScwgEqdUtgZf0yo=;
 b=d8BD7XGYmYO0GXsnrn2RFJ6TJpHb1mfTLnT7rx5sOIgJJvZehZCJ13epZNT19XqEnR0TxGuYMQ381bnszGBZlBDthrHNu+p37XzrPwWHuNGyYUBVELLTSXuUBX0r+4RNzyLQs/7WEOwUDKW0PGPWn4341W4lUxbP+5Ae7lc68pK1ndos87KN2Rb5Ge2Lo0gZKFux389krtryF/bRaLj97FBDsYAlYiw1zdBC17xFFa9l6oiJA2GfOcIFF4lU499tEXbzBUMfw7BItMCQuaOR2d4KHkIPaDdImG5609FctvDRcnJotYEhYl2I/NvtiH3Y/vgwYNjXaJu0R4TGZaKgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z7gnaItY6lYGVX2Fgb8ks73HK9zScwgEqdUtgZf0yo=;
 b=jS0tdJ6b1vwUWRQuvOKplfokeQwGvTEfSokcBJcyhxA2+DsGJgf3cOw4aJnfFl+3GplOWMA+ebB24wykroZ/y4hlZgw/fMjDLK+RKGfG+I0Eyo1dCusFpZ/b7Z7IZjXK/OEZD36DSYzOcRvY5LRKs0CRY3JbEnfbLUfqnskiX2g=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by BN7PR12MB2739.namprd12.prod.outlook.com (2603:10b6:408:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 02:38:07 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b%6]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 02:38:07 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYgX7bYxdWl4rrRkiRHpo+Xgo3iq1UdX3w
Date:   Sat, 18 Jun 2022 02:38:07 +0000
Message-ID: <MW3PR12MB44114A211F3D6F0D77DA7364BAAE9@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
 <20220616124429.12917-2-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220616124429.12917-2-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22aaea17-3b92-4045-c671-08da50d393cc
x-ms-traffictypediagnostic: BN7PR12MB2739:EE_
x-microsoft-antispam-prvs: <BN7PR12MB273909027A2E0093A7E62089BAAE9@BN7PR12MB2739.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ju5mKW9D4Xoa1FVc4XYGcQAWWvX29Xq9gpRXNvYrHOG2I4ExRMv+OEeHj1k3Thp0zwVrnRjWZ5TYB3Ik3nczIfHoTRWca7jcZOaMi6dAdQo6vJyb61l5KyYuduMWbisVlUScADJlxrCe8VrgOUU91QFusefqO1uS11NEUzAElMMiR3KxEl3gJNoxvkEuS6tL2Ak7Oi+paUs56pw8HY+hwdjgcfbmQIQTLTqTnNStw2jXe22vTkZ9BsRMppGtQHANjkC2Sov5DlP+F8/OOQFslsuWxW0hqZlrlh9ROUyLQf5l/OcyiSI65tsR+Nk/On+lXPPtl4GeIs36TDglBkVbN4tbYc1jKnlcCBpivo5W6RrPcXKo0/OOVGF7HSxuupwFAaYVM+ktYkO6XsgXpFaCLEOHxxSizZYdsYoDhLdTvoQIFMdQMKksx0q7hYkgzFsG2B7FlJ96QdTjxRrBmZ1kARl4rIVk+ZF+Y7AzwQhYVyoLoGUGLd+B29T6XGt/Dchso5kDzNpnZgAGFk5waP7cMZ4rXEplRCeNGYqlgJ04CcmAHCqIsQ0QFYSmCIDEjkx3amoeuczAsVMpM44CeiyVLTxy4hRRS2KUogsewzj+FlsMyMM6oWTejmwlBwmnbWT7d//P3gvR9aDwIcMicQDlPjRlkMCKD3MN96SOK7axa1PYVrgvlIn9M9wwajgDm7OGwLvZAKWZekkwOeDfAZFDAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(33656002)(316002)(5660300002)(52536014)(64756008)(38070700005)(76116006)(55016003)(4326008)(498600001)(110136005)(2906002)(54906003)(8676002)(6506007)(66946007)(66476007)(71200400001)(66556008)(38100700002)(7696005)(186003)(66446008)(9686003)(122000001)(83380400001)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NCMTRkaHp7Vz6c9FCqSOWRZbp0YlDQ9IIazYhLhOngQJhqM8dSAcly5KlktU?=
 =?us-ascii?Q?EBwuAzBB3wyL3kk9wLc6wWOj/l5wOfKXxxstmV43gb/47F0aSBnyWTbAjOJs?=
 =?us-ascii?Q?J+CqQdgihH7YOc8+sEIhGs54tIcNzGjHX5MJmp+FcSe4bwAOIR7VT43Yjivf?=
 =?us-ascii?Q?m17wFnAU2bKivRLBWrW72nViDYXUKYv8BXXPtGnzmVfnKpz0WasRRpKxfQIn?=
 =?us-ascii?Q?9HraNvtBGEKg8VsvLKlRhi/pXFqK3L9AQEpxu7HVkTwbZXT9doX6SjYUrGS6?=
 =?us-ascii?Q?5ZzOOWRfeV+0VNjiQRDz91iFRryCy+71HI2R8KR/76692gxcwdRpsdYW2kwM?=
 =?us-ascii?Q?n8e9JzQ20/BVTvNLJ51hA2OApt/pl1BeEwGlHQZi/1wnAjQkHby8ZiEMpTbM?=
 =?us-ascii?Q?V5hFmZaGQpDzbPg/oWAuBhDKHYKXRD7834qXKRYti6XJK/URgr9z2L2zeyeR?=
 =?us-ascii?Q?PDW4+dazHKuYzp65iHd1d8MTFxr4KmVQBOnlrXFOxutDuTM1kWMJ7GsCxDBa?=
 =?us-ascii?Q?0uSWvipgXdEAGAynCtlJqbfqKad5hR92y+/AoMJ7vE7YLRmT87JjOtmds6Kg?=
 =?us-ascii?Q?KbTz5wnoaOGDqP7may25qaXUIUWB1QbXKLojuo5tL8zutzzRm2AqagDxYfp+?=
 =?us-ascii?Q?o/OZ5oHDOykM8WMSEtH4umuFgABpV57RwYoh6NEXstNJMjLDK/8U9rMAL8/S?=
 =?us-ascii?Q?DMaxOcCWCeH10gHENF9cglN2dYZDGOrwy0ZmeYxmllW0dQtwgtXSjFtIYwgY?=
 =?us-ascii?Q?Rh6gqxx4nHmOYitXpQvLxe0P2bVyXCwGGVSSOZ7oZhEG59PusicdzjMhhEsX?=
 =?us-ascii?Q?72Af6hSzA+J3yxxZ7K+iZ4tz1arKC5chOeKfLsGVNiDbS3obOzdc3SWzJZ0u?=
 =?us-ascii?Q?rNHS4h40eWDilTnDSasHanyradoMJz4po/+JjdyWU/ZdaR8P6JNDoDyDdNv3?=
 =?us-ascii?Q?Mm32smyCmTsPgmJsoHuklI0fJ0qZSVxyG7bMK40FjUSji/YNoEVwOCW81u/I?=
 =?us-ascii?Q?JiZoNuXSgYx7AsvtFhh34OCnnoS7lWAmRRrGI3aaHDnHHvu7zyLPoRdADoa4?=
 =?us-ascii?Q?DY5giG86n003M2RRjvtU55t0hOag89n2yCS4H7oe2dsc/A+odmqSwbayRwT4?=
 =?us-ascii?Q?BhQ2EKYOhIY847RrLajLXsf0nRCt5OYXfdp7IKO1k0ylwiJy+pVSU+doao+V?=
 =?us-ascii?Q?lf/VtAVslcLCcE8fLQpBn89hAs/T3ooS8tUi5fgak322H0OGdPX82a2wouyg?=
 =?us-ascii?Q?KI7fNCzsE4pUnAPOyYD1OZLab+nfJgDKWoE6IPo+O0nIdlueAsWbo1IQ1fhi?=
 =?us-ascii?Q?36eIcgzx2EfGQszbIyay5Ea5wZgG7rbG3TlPVR0/5p2ZIHh3hVqIWSZMVjEa?=
 =?us-ascii?Q?HHUOZ8w/sbcIznSTGm7F6LrTKoVeMm90KC/gUHrxFHq0t39q3XeD0VnbGGNY?=
 =?us-ascii?Q?VAerGYGmYVbipgiWeZwcjZOs3MoDW7vS1jWz7CMn3A6eke0fPj3/45td5IXi?=
 =?us-ascii?Q?ZAR+GnBmQvBv55ekl1LmSJg/Xvr+0KlaJrUqgfUKoQVhfYoqMl00wOKE3nJ1?=
 =?us-ascii?Q?6WPBajGwN10JDcyw9VbtpFxVZDtBo2rXNh1LLRDsUo2VfVRfCGc/4ntMcPLu?=
 =?us-ascii?Q?brjrz7RVb17PfbZBsx8pIBfYavKUuLeZwieEYK9lMVcb9sTTi390d64nsuD9?=
 =?us-ascii?Q?7A1YSIZ8jGQIUSXv0711iY3za0apmAnO625czAoNf+ssivY7aoi0wJQJBebr?=
 =?us-ascii?Q?tmEWhw1jeg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22aaea17-3b92-4045-c671-08da50d393cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 02:38:07.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWZkswwZlbxbfCO40MSCbUKwIyotPaTm4ZDiTvhCkY7bNcOt22m+Ktyu1wU/epGwrPit4U1EvbGCPCaFB3Bu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Please neglect this, i picked up old patch.
Will resend this series, with correct device tree patch.

Regards,
Bharat


>=20
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functionality at Gen5 speed.
>=20
> Add support for YAML schemas documentation for Versal CPM5 Root Port
> driver.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 48 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index cca395317a4c..80597f2974e5 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,27 @@ allOf:
>=20
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:
> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host
>=20
>    reg:
>      items:
>        - description: CPM system level control and status registers.
>        - description: Configuration space region and bridge registers.
> +      - description: CPM5 control and status registers.
> +    minItems: 2
>=20
>    reg-names:
> -    items:
> -      - const: cpm_slcr
> -      - const: cfg
> +    oneOf:
> +      - items:
> +          - const: cpm_slcr
> +          - const: cfg
> +      - items:
> +          - const: cpm_slcr
> +          - const: cfg
> +          - const: cpm_csr
>=20
>    interrupts:
>      maxItems: 1
> @@ -95,4 +105,34 @@ examples:
>                                 interrupt-controller;
>                         };
>                 };
> +
> +               cpm5_pcie: pcie@fcdd0000 {
> +                       compatible =3D "xlnx,versal-cpm5-host";
> +                       device_type =3D "pci";
> +                       #address-cells =3D <3>;
> +                       #interrupt-cells =3D <1>;
> +                       #size-cells =3D <2>;
> +                       interrupts =3D <0 72 4>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupt-map-mask =3D <0 0 0 7>;
> +                       interrupt-map =3D <0 0 0 1 &pcie_intc_1 0>,
> +                                       <0 0 0 2 &pcie_intc_1 1>,
> +                                       <0 0 0 3 &pcie_intc_1 2>,
> +                                       <0 0 0 4 &pcie_intc_1 3>;
> +                       bus-range =3D <0x00 0xff>;
> +                       ranges =3D <0x02000000 0x0 0xe0000000 0x0 0xe0000=
000 0x0
> 0x10000000>,
> +                                <0x43000000 0x80 0x00000000 0x80 0x00000=
000 0x0
> 0x80000000>;
> +                       msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> +                       reg =3D <0x00 0xfcdd0000 0x00 0x1000>,
> +                             <0x06 0x00000000 0x00 0x1000000>,
> +                             <0x00 0xfce20000 0x00 0x1000000>;
> +                       reg-names =3D "cpm_slcr", "cfg", "cpm_csr";
> +
> +                       pcie_intc_1: interrupt-controller {
> +                               #address-cells =3D <0>;
> +                               #interrupt-cells =3D <1>;
> +                               interrupt-controller;
> +                       };
> +               };
> +
>      };
> --
> 2.17.1

