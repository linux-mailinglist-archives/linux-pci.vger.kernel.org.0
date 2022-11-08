Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76962110F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiKHMlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 07:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiKHMk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 07:40:59 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC064C27E;
        Tue,  8 Nov 2022 04:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwBYiW8ew6Gv6CkVclZAptYy/CCYQnv9+3DxLE3xCaKXNvYU5tG2aZiNC8bxZPyYOpZdxVcgFwiCo6Q/fg7dMV/Y6unEwdEi3NeIITJaOc+fciDLRKY5Lt2+PZa0KH0FrZxy3POI+lv4fUkjAL+a9yQDgpBJIuWW4pC5lxc2kbeZCawCaHR3Pj7fx+WvoOwdwinM+pYlpq7d06wbxI0LEm6WAyq7rfm5bCfOtwsy0dCsYOflFPWy8hYkIBE+2X8tpNLbVkA3/jzNnaXfgPEC8JhVItqv509XTcWvgRqRzKj2r8DAHLgvhgYb9cDh04fnP88S5bFDzsNXc3xte/ZnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCN2ckt8vr4PqynI4gcvOBOqqWGZwdIiupCozjufB1g=;
 b=lz6j8T1rxCVHJUGaOGu+WsL5hGFkyP5yM8tDnFcH6wHaxLt3DODsDHf9+u/h151Bmmh7v5GXRjDvBDdUyT15nji/QeVCdUgljPBTkWsONTz5c05GQS+PBPahf6Z2A5uRSklf8G9OvmbYX935o8eFwwpqnOBdhtanlJIv4d91ivTL9Xr/CjFr3gFwwTrZes6iDV/H51IYCOAcjKX+6oNNd3PeKInvfNdU18kULb0SZaK4QX0WdJL+53r6jAzgR5rjx9S2CEIzLtSmZcC3EXE77jPjUV02/imox4sUnALR5BNmKQTvSwFYEeGCXc4KApYVUOBrHyUr/U5mQtxc6+UeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCN2ckt8vr4PqynI4gcvOBOqqWGZwdIiupCozjufB1g=;
 b=mNbg7f84c8Jjg4r2a6CrQreFxtV0ctDCZLYprNWdfHEFXVfK5Cq2sEi2XvuX2Tsvq9z5saZnnu1a5NxJEZwDsRW1JkBMdDLtflLyiyKNI+0t21ACcLyNU2G1LIXqD2I/HAjlgWQ4DHcA2dj2ehPW3dBs361Lf9mlRntR3Jfuv5E=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB10233.jpnprd01.prod.outlook.com
 (2603:1096:604:1e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 12:40:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 12:40:54 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Thread-Topic: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Thread-Index: AQHY8u1sdYpqnOjUK0yDEEaYwhbbba408rYA
Date:   Tue, 8 Nov 2022 12:40:54 +0000
Message-ID: <TYBPR01MB5341E18D15BF78FFD6FA9782D83F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB10233:EE_
x-ms-office365-filtering-correlation-id: f48be0bf-dae4-48ed-cede-08dac1867a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukqLH0TWhEtZrfdoN7CXxLztwNmbPP8g9FtD81nE7d4dPe1hdYtdOBK/IdogeXYDg1u39mrwHEJ7p698SSxxek3QpZ2bTJR5vpD15Q0HMJr1p+FYVpVY7kqN6KrWtlURvfVUyEdYE5yDtjGZJSo/QqNT85LlpbAZ18jR/cFGf6zOgsIpR74lp2JBHPUiU0GG7WE0xIAxwgTfNzV3fM2V41wK1uvKfg4VCtSOcDV4qNhrBmkAFT9MwShMrI7aYmj1qn/Gxd5yrAk5Z4xt2T/dtAa4ii1rS7GJxDd9j1GY7RK+fil/wJgEMsQOIW2uOHdXAlaxgQaf8JUXuLQs8RjyxavEk3CAHuSa5CLh4dgJWwdAGHa98BmDA8vwUg/108SiuJq5fyEpbkZS7gKhqckfRaY1PM4G1J+9zytlHALLqS9pnLwy40Gbwl4cvSOnENanNQMP0lhiqR/sJYnYPi5hsLz/UbZNDKoPU4OWZTHk6l70TyxX4qCWIxVg9hnuNWXLNzq9CY/mfESdooQ2THRkpSGY4c9/da8oMy7/wXV3hm/DbIzH2JjmJotVEBJv8ckMs5l7bC7q+QnlfKL3mCXdqo/BOmiPcGVrpGmtmkUAnuMMC8NKy21IIxv0+lC8TAytWVNCDtbdY2UbvkK0QqnOYj5TS07nYjuJUo7htf23PcEufwLuwOrgJvTHgk0r1zHnLrjcAodzRunZh1tB3QXIbt5IMlS+uCyDID/zvoalTUzeUGrwYzPkiDtUltFZDVptyllcwBbWLTox2gmXIryM3V92q1uCpVK1k3rg0+S5FN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(83380400001)(7416002)(6506007)(186003)(4326008)(122000001)(7696005)(9686003)(38100700002)(5660300002)(2906002)(55016003)(71200400001)(110136005)(478600001)(8936002)(54906003)(8676002)(66476007)(316002)(64756008)(76116006)(66946007)(41300700001)(66556008)(66446008)(52536014)(33656002)(921005)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?VtLQXbT8QFUZt27tWPJkPaP987fgmRlx4zPXUSohxJm/0Z5szWD5/EIYrh?=
 =?iso-8859-2?Q?0foZsyhHv+3FlbGKfoeQNkCtyeAnYVeggFS5B3tTp5U6ALPoAuI6dfke/X?=
 =?iso-8859-2?Q?6Hj4L0dt8XhTdIIrEq3c35Qdw3W7wQ4LnB+6IqrjUxZj9CIklDJ6bxdi/C?=
 =?iso-8859-2?Q?/ytnu+rW627Vn/5sAtffm7+WiCwYm6BF8rPXgsAJN/ySO9Oc2gCL4LltMd?=
 =?iso-8859-2?Q?cCkWmxYLJJgMP21j+c/tOewCypNYQEqLdAihYN7m7Zh3Hax4U8uy7NFZ2U?=
 =?iso-8859-2?Q?t38VpaYdlGB8U/Lwluk+wC3IIy1pv4fsSm1WtvBGdG5U7b7aEuupyhZvyd?=
 =?iso-8859-2?Q?qMndQgLHOtVZ2vn08nb7iAstSrE59nt6gAcu/tNZz1OmrupEYccIIlcIUY?=
 =?iso-8859-2?Q?8+lCnNDhKjwROouyRSVmfc3now73BqLd/qvnI1VkHCR607vuD9VZTNw1Uy?=
 =?iso-8859-2?Q?B1ruOM4Zm/bxvQAAW4nHgTwA6ogh5KSE9Bqa9lly9M6kJJ39h5t8iAcnnr?=
 =?iso-8859-2?Q?3VrMzJti048uWIH1FpiMr7co5wzvXL1OlTvkFFxRzAabtRTM+fO4/7i8D0?=
 =?iso-8859-2?Q?9w9TbcRD24InBe+TConqJbDlWU8e0vxjpMogLIN7kS+HI+jipbMvnnfOCS?=
 =?iso-8859-2?Q?DSvbZJRythCD4rswywbCBXsNUz8iqrapEDMIvfYnxcWko3asbExeQO6xxL?=
 =?iso-8859-2?Q?wktsLd/OFzEEb36vs+/Ntwyye4J0/VzfxfnUxhheqH6dkKpRXj7vz79/pF?=
 =?iso-8859-2?Q?FpywDYrFRDztcFOODzovnJhtcdc8wAvMT+MRoC9Q3Jq0Vx2guZM+icdj+W?=
 =?iso-8859-2?Q?TGvTQ/OSQSibHk4UV3UBXD324ei1q/dURo4Zx+01SZ/owbf2vG0fyWK+8T?=
 =?iso-8859-2?Q?Ehrfwmm1BfKXOuYLTnTwGsK4Li0zXokAlV9+31+O9oEZnGI81NcKQTjasu?=
 =?iso-8859-2?Q?qj/8j1ZCGavv+1CQU1TsLS1Cb/LxjH0+x9cEAw3V3SdA3Pw5Hn+BxaYwoL?=
 =?iso-8859-2?Q?SGOnXfQpMksvQ+xEGHbFS+PgTvFHVrtIbZlU2B2LiVslJRQhATH9DpT3xx?=
 =?iso-8859-2?Q?epfmXrI4lRhH0v6DLMv/Jja/OXbbrePEGJTTNBDhVptljNCUfU8BtGUw0S?=
 =?iso-8859-2?Q?/H05gwDR4f/AHaM6cinzJ/sOaWFVqcjgFQRAOq+R1h/kvWLjiQehN8OzM4?=
 =?iso-8859-2?Q?V4UmqNdeuI4G3Mjww/xWw3gtQmv6pNKbXzJCD2vKCDZUUh5Ev32Svo5EME?=
 =?iso-8859-2?Q?65f9bCFIZi2nqQSiYOPl9bOXgN0xiqqzEyG/NXZ0oEuzzGAyOdL3WHVAry?=
 =?iso-8859-2?Q?Nx1iZnKJ5vMN9wjAykbTrDQIcY+2mz2NZoH0SsKJLonYSn0amLTbKh+l+S?=
 =?iso-8859-2?Q?mZHonk0Mt3or0pWDXFhH0xsOM09DnNt4cArwxaBQ5wwv0au67QvDonCozO?=
 =?iso-8859-2?Q?f2CMm3I36RdVlUFxP7iD+NaBsWgc5alulNJmvag5gUiUU8EiqOVqhOOPIu?=
 =?iso-8859-2?Q?DtaYbq5y15AFHtEUu5vuBMeSXWrJonaXwhtlbYUR9+PVsR/0T/6lyv2jS/?=
 =?iso-8859-2?Q?ZyEEAMziQQYXKqALTJkfRZTnX3/O7GUYb4IiP/xial83+H+zHh+p6LDPwl?=
 =?iso-8859-2?Q?jdDZxX0yP7PC94ZayYOy0IP5m61FAa3C9Xvnzv3TzdywZF6naGF4HWl6KJ?=
 =?iso-8859-2?Q?JFJ82pNVI7pb92sHVOR2U679vVzlxDE0+FY+3lIguyKivr4THGq30dc0xV?=
 =?iso-8859-2?Q?jXoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48be0bf-dae4-48ed-cede-08dac1867a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 12:40:54.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peNFFikGJn4E1D389zaEZNvmEx5h7zsesSEbb4UrsmYOIa7eE0p0Y3xvKxNL8peaPnX5ApB4xkKdE1ZaC5T62vlQ78vENbuE8I8iOpVUX6CahBRC56fY67ALRTLziw/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, November 8, 2022 5:49 AM
>=20
> Currently the 'interrupts' and 'interrupt-names' properties are defined
> being too generic to really describe any actual IRQ interface. Moreover
> the DW PCIe End-point devices are left with no IRQ signals. All of that
> can be fixed by adding the IRQ-related properties to the common DW PCIe
> DT-schemas in accordance with the hardware reference manual. The DW PCIe
> common DT-schema will contain the generic properties definitions with jus=
t
> a number of entries per property, while the DW PCIe RP/EP-specific schema=
s
> will have the particular number of items and the generic resource names
> listed.
>=20
> Note since there are DW PCI-based vendor-specific DT-bindings with the
> custom names assigned to the same IRQ resources we have no much choice bu=
t
> to add them to the generic DT-schemas in order to have the schemas being
> applicable for such devices. These names are marked as vendor-specific an=
d
> should be avoided being used in new bindings in favor of the generic
> names.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> ---
>=20
> Note without the next dtschema tool fix
>=20
> --- a/lib.py 2022-09-29 15:17:13.100033810 +0300
> +++ b/lib.py     2022-09-29 15:19:54.886172794 +0300

JFYI.

git am command could not work correctly by this lib.py file:
---
Applying: dt-bindings: PCI: dwc: Add interrupts/interrupt-names common prop=
erties
error: lib.py: does not exist in index
Patch failed at 0001 dt-bindings: PCI: dwc: Add interrupts/interrupt-names =
common properties
---

If I used patch command and skipped the lib.py, it could apply this patch c=
orrectly.

Best regards,
Yoshihiro Shimoda

