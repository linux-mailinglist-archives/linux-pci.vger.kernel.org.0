Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923A7319154
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBKRnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 12:43:42 -0500
Received: from mail-eopbgr1410134.outbound.protection.outlook.com ([40.107.141.134]:35872
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232478AbhBKRlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB5jCOnNSTXknd59LOc1pjTPw5OT0nbepGx/zy/exYgQR8zBU9k6l3otdhNWy/UD+DcDVjIJ6alzvO0bsP1L0cYT0CEuXGXjh/bExb5FsRyIKE0C7MZjvW9TFsbQUxdmA7QjSdmbtwa36Q+3zxnrimcE6JnWArEegHtmv+NLVDkhguNewq0I0TrkqV9sFMTBe5kVagLTR6XoAIK5mDHPUR3BOyxUIFH039NMgTZJg6TN3CKaLCsL3npumobxWajM68sVf3outpbK6U3yDda9VqRSP6pkAZ8w4fVqivE8jwTaIluPhpd7iDUKcIdiX4/OtL2dZDhI8uCevv9ZByoIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7YZQYVIyh24t8bdjdCtmIfO/Azvg4xdjfdELiKyboA=;
 b=KPFlwwx942xwd2HxuC2dufyabj2VhAnSJZhFeFHZgaJYWkW2bldWAgLCR1dR61c7kXxRApvj5IsQnhbBcYMJqAkmdFTlGgzdHcC581S8uz2W+y8ZxrcIsa60WXIlppX86fdg5RLNkRU5ozLgLUxdP8Jlz7l0T+rCsgReFLCtd0bUm6ph7MW1WMTKHVVY/VvQwN+sTJ9aeQp29frpAQKtb46WRiJjdEKzeqPMqt5dw4JhZZ9F8uaJKzdj0Eoc4+uUTRPqZNsqFQukVYQQTPxKQ5cIDnGqwEnxcZ2rJxSrntAbTprUpqI9kUxnwgx3MFWa6Rahc6T2eQ5zeV6uV5Bzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7YZQYVIyh24t8bdjdCtmIfO/Azvg4xdjfdELiKyboA=;
 b=Te+mQ/Vrimf05WTOQij8Ge0VuvHL9Dh0KDt9IaeJ93gNFYgNk0IBUY9kqM74TsmAkefUmC8v8uuRNZKQECGWGukTWFiR3ZW6Q4UoZm9IL/Ow3h9let1qFpGU8rZMb99LtHH7H0n2W/tmIPQ3ce0VoMhtl32kSHNJpvgyWZgj5v4=
Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS3PR01MB5959.jpnprd01.prod.outlook.com (2603:1096:604:d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 17:40:34 +0000
Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 17:40:34 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [RESEND PATCH v2] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Thread-Topic: [RESEND PATCH v2] dt-bindings: pci: rcar-pci-ep: Document
 r8a7795
Thread-Index: AQHW/rgeFwFhkw21AEqr4tQ0wJriBapTO+Rg
Date:   Thu, 11 Feb 2021 17:40:33 +0000
Message-ID: <OSBPR01MB5048D7B1E77A84BE53EB3692AA8C9@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210209074840.21254-1-yuya.hamamachi.sx@renesas.com>
In-Reply-To: <20210209074840.21254-1-yuya.hamamachi.sx@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f4cbf74-8659-4e58-8b10-08d8ceb422a8
x-ms-traffictypediagnostic: OS3PR01MB5959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB59594954A36E28B998E78E8AAA8C9@OS3PR01MB5959.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTsZCxAVKbuU+XsD9Ez0O3XPnlO7m9JQVJXm+paF3zEXhZKl0DbUnZ3aWxj0shEHvmRZ4UeTASgPHBoRbSpdCwiCf8mMMrWolxPVYxDnYGZRjbmnVZpxDdsKHjpLmXM4n5fAgiU9RBce5GA5odziPWR3P1bYjB6td7E4vfTnEV91yHW+PXmpw4c0wFane+JcjQaQL3DSfVBsLnkinnzoLy5bhhmjwrOeXBEElNpRuStMXbAEwrQQFuBb43AUdCypex5/GJqbm65hT+sOImqNXNpkci72Q4g1EDQocNT8OFBYN6Md/2KEPfUnhVmrzWKU8ZSggmC25ZnkZt9xCLK3Qx7FSxaY8WlwA7Csaz44vs9RdZRhphyDxIeeHSyKT+L7thUbULEu810uUzbP+eIYakBM0NGGbbuGbUYOcU2OeOEJ6Ch724AA/8kvW8eQEG1vpiHlI/XK3iXdWUZmqsoQfoqizvenOqbyMvA/1/EIUdnbOmTqwxYNFxVe1yt0z61rqteTAdLNFWslTrYYBfNn5lv2yS4Ip0hqJ/1EfqHnSe+ys88ndGCjpPidaLs99U/WJ6rBEs/YIw+rRDobZt18R6W74CtAZBzGMKLFteojCyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB5048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(478600001)(45080400002)(66946007)(186003)(53546011)(7696005)(86362001)(6506007)(26005)(33656002)(8936002)(64756008)(71200400001)(8676002)(2906002)(83380400001)(66556008)(76116006)(66476007)(66446008)(110136005)(55016002)(9686003)(316002)(52536014)(966005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kY8qnnH90DieL5r9efa/Yg7Q8JfW9n8aOv2laLAL2bzGJ4N+lqsV94+fctRb?=
 =?us-ascii?Q?QTwENSeSleVcgb+zC/jyUyzXmDSldfBjS2n8DnOOGzrJ+mrS4LS+rZRTZ01w?=
 =?us-ascii?Q?BB09JsRT6jPY2wRBGCfZEWiPsmxFry1tfVZXUgkiBPbUHfQbEi5Bncm4A97a?=
 =?us-ascii?Q?LEja0MPkKhKEYbORKD3xNwCEjryuiExcbz6zhXgFZgWlBDGlspbYcJ4EBkwY?=
 =?us-ascii?Q?be7CqDvqErzEotQwtSQAIo0QUtKXpelD6Is20fTBim+rd6YVd5kn8WX97T1V?=
 =?us-ascii?Q?ZaZ8dVFCGkIT7dYiB5sfXNtzjVFqdMDWmodu0LIIywABZmg6SwE4YUXqEttN?=
 =?us-ascii?Q?Eq1T/4ZzNs3jqvOB49jADLi5QEy0zK3R0iAuMwDSvEKUvNtXk1g6BV3rrkP+?=
 =?us-ascii?Q?88nGtInnZCGdtBDGuKv1Dc7V9+7i1+CoVJVnZ1m8EaZGBfe37mIYAHUlehpQ?=
 =?us-ascii?Q?8lFk3JimCHbWjGDIgDBpq2Q9sMpfQLrYW8fWa4Y8BY89lXjSUcAHryAQTSJG?=
 =?us-ascii?Q?tD88T3O7+vvSSrJVCGAVcHRIU9F2rPECW71Cd4YBiam7mj5rVJfNyd1QSI2b?=
 =?us-ascii?Q?eq2prLiubVWkqYkl0rvB6n8PEDXjgT1L18qL8N/ndRoGdVLSyDWbOJnw7Ig+?=
 =?us-ascii?Q?ZvkBftQd50BFhoZmqO58xSHHZlssW9zeHdWfRfRQpcD4lC3WIOVLvK1l/b0c?=
 =?us-ascii?Q?kDWK8w1np071B8MRT8X/ABDj8N5qUrBE1lsEDo/ticnNhAfrnhMy5QdiHMQI?=
 =?us-ascii?Q?0NXkuFd22n2ReiT++8CynWdQH87rwZJPUVZLBJL9s0Inzd8Z9FXmgQtuPDKC?=
 =?us-ascii?Q?tcAbYSFlSeFRs8J1aBcip1mgYaEbXe1zAvRY6SuXS/qHsC8dynfgYJuyZzNy?=
 =?us-ascii?Q?j7oAPVW8rEglAXmImqDfUUdHqwGigssoEYhneFvjYDHSpP4p0eDO9hZRnHcY?=
 =?us-ascii?Q?nPZD3D6p7tahYjKh02GFSLIwUBDphvkCp3rqHl326ViNvpmHmGWKd87AFHot?=
 =?us-ascii?Q?35QfK4elMERcpfr6STpzWQLktn8beAC6knlthgG06BW8RgLSsMc5lSa3XgjT?=
 =?us-ascii?Q?/My2oSuPc+qHyFdMUi5sGULxn4lxp+zAsiKIhvLEbOYDvC/m4M48CBdr3Hvy?=
 =?us-ascii?Q?7AWVdUeBSzKSm/tUwkLVuF41h+OMqls2PqxL84qnZ/dobFbe40TQ+m0OsxCt?=
 =?us-ascii?Q?YQCUgLvGBI5tgmCZ9h6pMrpCC1y+faExHuB5xG6pRNrywoRq4oB0lqRimtJg?=
 =?us-ascii?Q?MzUaI93rTxEbyovzOI2W4bgSZYrKRNj5777uWutGL3LFVrUQXqKwzyoUjNjO?=
 =?us-ascii?Q?pmmzg6R2O6eBfo9rvXzKY8cI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4cbf74-8659-4e58-8b10-08d8ceb422a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 17:40:34.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mb9Bg2zeUuJV/PvdK1ahlvMCm90UQ8usg9FsqU5Ya9wb0bl12le9azktJpuaszX21tK5zNPa79JAFS93K4OXY7M938aSXR36iVjxREa8LQYnVORO285GC6AgMKIt13AM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5959
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hamamachi-san,

Thank you for the patch.

> -----Original Message-----
> From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Sent: 09 February 2021 07:49
> To: linux-pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicet=
ree@vger.kernel.org; linux-
> kernel@vger.kernel.org; marek.vasut+renesas@gmail.com; Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com>; bhelgaas@google.com; robh+dt@kernel.o=
rg; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [RESEND PATCH v2] dt-bindings: pci: rcar-pci-ep: Document r8a779=
5
>=20
> Document the support for R-Car PCIe EP on R8A7795 SoC device.
>=20
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Changes from v1:
> - Add Geert-san's Reviewed-by.
> -
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.kernel.org%2Fproject%2Flin
> ux-renesas-soc%2Fpatch%2F20201125073303.19057-2-
> yuya.hamamachi.sx%40renesas.com%2F&amp;data=3D04%7C01%7Cprabhakar.mahadev=
-
> lad.rj%40bp.renesas.com%7C11d21066f9f74148fef308d8cccf3fad%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C637484537803337191%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C1000&amp;sdata=3DP6YQgQkwjcVeRgJk3zST5ijphgyFw8iZsvwA2YOUpq0%=
3D&amp;reserved=3D0
>=20
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
Acked-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> index 84eeb7fe6e01..fb97f4ea0e63 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -19,6 +19,7 @@ properties:
>            - renesas,r8a774b1-pcie-ep     # RZ/G2N
>            - renesas,r8a774c0-pcie-ep     # RZ/G2E
>            - renesas,r8a774e1-pcie-ep     # RZ/G2H
> +          - renesas,r8a7795-pcie-ep      # R-Car H3
>        - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
>=20
>    reg:
> --
> 2.25.1

