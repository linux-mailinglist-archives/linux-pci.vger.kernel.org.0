Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6E6FE89D
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 02:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjEKA1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 20:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEKA1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 20:27:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF1135;
        Wed, 10 May 2023 17:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoKjOOwujNYKJ+ecgAz4iHN5XOvYd1OD7ghg0lgErfC1LTZ6JDKfTJDZYAATWX215NKm1nF54gkizM+K5G8y4a2Ui4YolGojJH9niFjcy7593sc3VtjzXyVb+KmVCU16fmhDNsTj3M2j9iF9Nrbh1od9+2yAxT67PGl6MjDRad6Dd8AkoEP5dUR+Pqo9S4kYCiPzoeJ3SMRN2YJYnaPJYzw0Zqb2ni1CHwi1xJCvt0o28ZabG7oWvGraTGofRE42LAfFql82P2RZ2RPPenHz40o9L4IdxJk30v9ToI0vjKyWl6w9HqOB9tPtyIEdR5I1gxka4I11ifX+HEh4z0QnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRDQcQH88MxPe35AKfr3/cDKO+vMUmC4kggARlQEsCM=;
 b=FQHKi3diOFwFAFGhmBbRRjLEeBP3wIveStQvbeOhvvf/HV3dSOcOy8j/GTvo/ZkvFBPc4s8E8NPFKOrBt8ohhQ0ozc0NO5Bf4MPZHshgTSCU9X6gyKSAQWim8sLaRj8GV3wB5uj8t8clFrLEvsZOaSLe5TOX0zOXdjUR0ZnEtYt7xAimy1bBMBYVi1QRwYFQN89e2Fj72acS3pQwyr3lCtj9bzKV/nJ8CqWBJe0ke2tKmxvvI805ADdp7nMY4RgiweadeA96E7b5YWS2YvVNZ958neR8Aw3yXzH8lLvKYR34LFUssrUu66rdYWP2Dl+fUWTOigs+j1AfZaddpMY0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRDQcQH88MxPe35AKfr3/cDKO+vMUmC4kggARlQEsCM=;
 b=LuwgR+p14v4i8W/lgOIOk7HbrD2mJnpkhAGY/5Q/QehbOawhcQEHwRLgd6vKqRC3Vl/6B/j84syFiK42PtvjinGW2nWm+dApT5Y6k5aHGeGmrJdrNhLjP8qHmcgWRLlkzAA2qo044BTkRchJYMytTEgphM7YpyJNu79mT3MPqAs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB7902.jpnprd01.prod.outlook.com
 (2603:1096:400:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 00:27:31 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 00:27:31 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Subject: RE: [PATCH v16 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Topic: [PATCH v16 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Index: AQHZgwfSyX33Kzo88kSxBqaYEg4B6q9TR1WAgADwZxA=
Date:   Thu, 11 May 2023 00:27:31 +0000
Message-ID: <TYBPR01MB5341EAD636929C5D7DB8C1F6D8749@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-18-yoshihiro.shimoda.uh@renesas.com>
 <20230510100341.euimwx7jezgthsuk@krzk-bin>
In-Reply-To: <20230510100341.euimwx7jezgthsuk@krzk-bin>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB7902:EE_
x-ms-office365-filtering-correlation-id: d458045f-d44d-4f89-9c99-08db51b68282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8gZ7dAxuaLnDTcZknG8dzU2Zy7qbfbfDfPKkvxvJdFdJ9tyVp6RUB6HYcX1QGvQODvmTQfvJOHm3wP7A2uxcNrcfo/+hVbBymUBx+bnwNJIR2IkMyIFvq0eJ93n52DAbjOt6kBO0vVQQ2pw7CO4kwez+ehZUF5NBnsfa8ISBRIusL2m5kXFPQz356ngbbr6CdjiJOCkqIjYvLS1A22W5sSkY+GRPCQzx19caZmN3h6Qx1BGoshDbCYLoqQDttdmNo+byuxtq7FP7CKjuZdXuCowCaSife/SEbnAUwN9IagjiMp/yA3sqy9ZwQw9Jf6jbCpAyJ4wHMhLkh2jSH8jJPGMiHsHtis7TQcEmNLqq5uCQKXiL3DbeNuJJWRV/7YX5/Uv0aUgFjyXBp19caaBFJSj9DuKaHx6Z64uesINrH94RFcrJTd+TXNbDyEanrmuxseL6AX9oToA6WL9WmWmF1D4wI1hJpzgog3Nw07AcIps6I3mDm9Q/eL832mSsmIAuaEStZSpWNiZMxr7VAt//n1QVW9+o+3QfatvO6XQUEsw0yDjPUNpC2Hs1zXxNm2DG+jr4LYlyBsaehyBR1mnNvzzrjVSWKxXvbF6QBtiP1Tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(966005)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(478600001)(7696005)(45080400002)(316002)(54906003)(33656002)(86362001)(186003)(9686003)(6506007)(83380400001)(5660300002)(52536014)(8676002)(8936002)(7416002)(2906002)(71200400001)(41300700001)(55016003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+Ek1WZT7+PZZLSFmSDq4pDwgijstXtGcH4atUSV/UYfuMNfGcBJrnOKB3pG?=
 =?us-ascii?Q?E+PFJu9N3R976o/uaiLonGPdpIH3245oizk5L8TVeekjf1PzyeUq8dYX0wY/?=
 =?us-ascii?Q?LKLjPmDNR5RIhYZ9VOqQJhCGlhAkqsu+a8ep4TfZ5dkZBkGdKxeksp7T9buC?=
 =?us-ascii?Q?L+U9G1KhFlbl8TmhON1CZrxEpGhZPVu5UnqWODoH/hU9yJyGaCakiU4r/AAb?=
 =?us-ascii?Q?LBJAbQW9ScrCOzg+At31Jnvn2xus/N28by+31bVAYkg46y0t+1oSD4HUQ9DM?=
 =?us-ascii?Q?IcdBEWXAU2sdbWTzXCVbm5gYKEI97gCV3SoyH4rc6w7RQKDcfg0Uu8CKDFTt?=
 =?us-ascii?Q?iDvWDqJkTfJ2IsVqGfFbPLq7swQTReKUHDzc53RUYWKrcAxe1Af6wRCIOehy?=
 =?us-ascii?Q?kRxK72YeDUPSRD4eBCuGjBE44INwqRTw7wF1tBwK3bMvEHf4y1aDzy4Mdlr2?=
 =?us-ascii?Q?4qVARr0MtHu8StG3v0VzcvnMtRDNb4Dx4igCH0ChR9G+CFco03MD1NR5yeYj?=
 =?us-ascii?Q?/263CU2qwSCwbct+E7Tw9rY77KHovocPYRUNTPbFRY08BIZHEcwKc8ouYh4F?=
 =?us-ascii?Q?535AjFUZzpKT3Z9oCURqWymEdEzfI9ZtH7XeF9+g4lMatg+CHDQeG+5fI1UJ?=
 =?us-ascii?Q?4yzk/ktou7Begim/UCcBQetuOQH4giguTZqq1rZJanjEAF74IfDMbi00Xu3J?=
 =?us-ascii?Q?iS4cFhLuzxRhsz8xaE53389wKs3L75HkESfpzTyvoEAn0LI0WbQ/l6DLLL9I?=
 =?us-ascii?Q?QdRgHx3AJE3VUwOzgRbtrjpMqajrxOhtEEHe/ObgNGeQkx9HCWXT9x0M9Eyu?=
 =?us-ascii?Q?R203lj810RZ8w2NpjauTTf8VPO9bvBtuUEy6qYc2A4x0ARKNAEwSn4jIsCiW?=
 =?us-ascii?Q?nW07mBnuiX6Xo1lBx8AFoFNjkJNyedhVZMIByMnHiVuVUL/WQ9T0Mk3q3Kz+?=
 =?us-ascii?Q?5TehDKDg0jsyeOsPBLDTY4oI9v+NJLy4XC57W4SOYS/a3Xx5DV+3z8g13mcU?=
 =?us-ascii?Q?4p+yMfJqe9bL/4NMhDrx56mSZ8lJaQQjIlM7D+yXgTBD92QQzmv//5fh+UrK?=
 =?us-ascii?Q?BVatShMrZYBtIVlYMNhmhUPq/Lsx2qgFWba+RvWOf+slL7UJLpi/Y/j9Z2kq?=
 =?us-ascii?Q?wX8n3JkOyRe/MaG+aLjguLQ4bEItcaDQJl962sr7UdtGAw+vsL08A2NLZcAg?=
 =?us-ascii?Q?ZDFt4j31hyb6BO8eSbQlr8sCCmULQcOt1ivG3wIMl39kOUkjv/JoaAFocqJM?=
 =?us-ascii?Q?KYYmGqH4+iCNmxM+olDSVD75/bDppNttk/jFdgsLj47kvjfuETj4MSgYD35D?=
 =?us-ascii?Q?YYXhrC6q7Su838dGpiYCfnZaZ/DYODBNlBqlrerbbhm97SDhCHBVyyr/awny?=
 =?us-ascii?Q?J0jnAFSz4FOuq6OzH4Q9Ev37+RjBbdqhJ3mOk1gtcLmYI/NSwoNNT96n9l7r?=
 =?us-ascii?Q?yRBEsDgrYC1QhMbDL8VROmlXA8usmXlh0QkAvg+9IqKefsdwjJwdaXrKpIJM?=
 =?us-ascii?Q?ESafWzYI9I3/xYI5wAmlCrPaYj+xTehaqrzopbW110mA/I2weCY9dqL1N2DL?=
 =?us-ascii?Q?AYtW8waBdlRLtIKvWg+STkTsLpxE7He3uCqhpN+UrcVmvIUUyE2DBdqka7tF?=
 =?us-ascii?Q?NWssFI7XmNiicT1xZ9k1rImIwBOyt5QkE/EIxHJkMdw8bSC9eWc3AEWpJPTF?=
 =?us-ascii?Q?qXcvTA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d458045f-d44d-4f89-9c99-08db51b68282
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 00:27:31.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVVrIC0QW/7dy0L23FElkeIrSAcQBc9G/1SYH9IzGjFci3FxbzTFhCb0BxewS7I/fJMWNwJ5oYpgb07nloKldUbTnsvfEDUfKpmuu2GpE4wtIbChNUpy+r20m2Utvx/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

> From: Krzysztof Kozlowski, Sent: Wednesday, May 10, 2023 7:04 PM
>
> On Wed, 10 May 2023 15:22:29 +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe host module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-host.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: reg: [[0, 3864854528, 0, 4096], [0, 3864862720, 0, 2048], =
[0, 3864866816, 0, 8192], [0, 3864875008, 0,
> 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
>       From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'config'] =
is too long
>       From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: Unevaluated properties are not allowed ('#address-cells', =
'#interrupt-cells', '#size-cells', 'bus-range',
> 'device_type', 'dma-ranges', 'interrupt-map', 'interrupt-map-mask', 'rang=
es', 'snps,enable-cdm-check' were unexpected)
>       From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml

I'm sorry. This is my bad. My using script for sending PCI patches didn't d=
escribe
your email address and I didn't realize that until now. Today I added your =
email
address and Conor's email address into my script.

Best regards,
Yoshihiro Shimoda

>
> See
> https://patchwork.ozlabs.org/patch/1779258
> 1%7Cyoshihiro.shimoda.uh%40renesas.com%7Ccce74f6aab8246aafb3408db513dd82d=
%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0
> %7C638193098276177092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%7C%7C%7C&sdata=3Drr5rnbZBGfOK87p1dv8T4pEEXyzHuOiKktG9SQZrVrs%3D&reser=
ved=3D0
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
