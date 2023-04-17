Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E96E3D21
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 03:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDQBLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 21:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQBLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 21:11:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DA1BF8;
        Sun, 16 Apr 2023 18:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfQ3syRekaVtmeVW/7n7XOKhPH85x30iVuzV7XwMKXnQDhrg8afirBUEASMNnp59N25+sXawMceH6ymavwuimVju5skdjka+x664SxbNO5n28qTPGb2VyrDAuXOmVOb5+cyWsiiHM+OOYXtZ5Npke6twEYSfrv0zeiQ3+3Z2n2nqbWzHRb3vLsFUcjk2YviEDb7eszZ+CCC+ry5K3z6ip+IgnzclxFi/73Z4gTV42Nc4dxz6aiz8HU50PKNwxdw/63UdZtEY/dcd9HirCwmXLe+Xvq1rODJ7aVrZWQWa3pWCqLt2rMag9ulljl+9eDA7jhDZcxJeS130z6qi9ZqNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=400wn8eXPgz7/CtKs4p+ccTDB00DIFw47gJm5toW/GQ=;
 b=Kw8LymgIec27/q8n5eaxP0HoiAo0lKanEGx9OuTtzWbociIsjXr0qAhDTFeI3Is5uH8UwtD/SYi8/0FwcNbRDryNkQRjavsP9p8nHP0lxVjwJI/78joOfPyHDVCqcfxQCG2PDPfMy4hk7QhjNTcVBA+4vBSIWf5RSXCMrHX6C5fNfYWRN30jZksUAtNpAMJO9bA8kkq7vOOoodIdtJcUSiOFu9HHnZxNlBiuvTw4ecUT3qeuT9m8sXfP8tQPGz4sljwJS19wv8wbNveDadNUtoBSnoOTrFEUxQ0fjptMcyKSLpeuXJQucErE22waU3TKMDbyFphmgbrYO0X6I2u1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=400wn8eXPgz7/CtKs4p+ccTDB00DIFw47gJm5toW/GQ=;
 b=acaqJCuOfsH05NDPBhfRjCpLTyJqjdwaEd31pczNxGl6UVeKku5gSrG0KM1yg6Bj4O1Nt/RgOTVg3iCKa57TWI5HnMYiluA2ucmkLNJiyVTvEih9ZVq7WCjvhekDnOzjZY3aKE5ZaZZSzpf6qqVIoTNuX6U1346AwtGKoOyg7Ao=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11127.jpnprd01.prod.outlook.com
 (2603:1096:400:362::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:11:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:11:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>
Subject: RE: [PATCH v12 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH v12 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHZbpiqlMBZkApUfUyMJo3pZUKscq8qvnKAgAP3GXA=
Date:   Mon, 17 Apr 2023 01:11:33 +0000
Message-ID: <TYBPR01MB53411ADEE8CE417DB208FA5DD89C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230414061622.2930995-16-yoshihiro.shimoda.uh@renesas.com>
 <168147485020.3576451.4333163339018554395.robh@kernel.org>
In-Reply-To: <168147485020.3576451.4333163339018554395.robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11127:EE_
x-ms-office365-filtering-correlation-id: 9b66a386-0a97-41b4-464a-08db3ee0af75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aB40cscfmclOuPZjj72dSSInGywKNwAFm28nKigLwSuzzGG65UPpmLzEqWsI2Z6MtDyPjswakTH7lawbVYGlg875CNa0IubzuZeQhC/ebF6Lwdul3t/nm7K2/y1BoXWpfZCYGzRpQAYxcNLEvfaGHjfaAM0hmckHwmRgur36Xexm2Gxbhr4q0248VZCSfI76SZKgSAD1UIPq+nn9oYrtEYwFEaHWGWIEnmz5uGidz2SuCINwwyMoF2BUJ2psr9i42pkJPzve3azkmCFZCJBHdaDRPNWOHLxbterLRLLNkp3Cjg6xIDrjq85oDk7CvsBaV06mYx6BiuL3tE6qvb36LOGkGqstmhw/aFfFmVaGJ5nMP/rLSXqDbbS+9+y6wU6KWROEMP5OQraTgc7/lPgtlTGdB7ZF2v+QwlQlIGeZcMD6VfBZJZhS6ettPjSVF3gh9SUQiU++cbDwBBjqmUvELKL6SOJsfx/iMvLSv2TA7ZbhwfEOOpAIWVhsQaXgvnhiYS1sJX/GLGo+8iPsbBKuUxWnJxONHZwzoxFdajK6VztcJx5lAA5uzhMC5zq9l/0VbX58Za6BiyEtc8mKIhFPt7OE3GbeWERtMFvj7b4IxNO0qIKOKtZMzuYBTMhss+uN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(7416002)(52536014)(5660300002)(86362001)(83380400001)(186003)(6506007)(9686003)(122000001)(38100700002)(38070700005)(8676002)(8936002)(54906003)(33656002)(478600001)(71200400001)(7696005)(55016003)(41300700001)(316002)(76116006)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Du9/2+64AqXbPi5op6xJGENXnaA9nlcMx1j1L3VIsWdEDw7iFzVjTpN/fY4?=
 =?us-ascii?Q?XXZ89OPgwMk85t8jqFr7Uw3SkNoVeHk0bOZWljulpU9X/RZQwEj1S7mibcxq?=
 =?us-ascii?Q?eCCCVgKuvXu7ODD7vU5Ur/g8jJ8zxXSPa/F2uqSQMZ4CdbQoqIRGioZ2XJYd?=
 =?us-ascii?Q?3cCPSXQ3211ZWCm2elZMPhGEM8ve0b2o8xKFpL253oAj3BOvZhqS+p1y/o8q?=
 =?us-ascii?Q?X0td/OFjoNwSCn0FhLKg3l9A7zbffG3nwMGwk2QXXZM3BA0SxAo0n5DrmeTq?=
 =?us-ascii?Q?D9MTXrG41aX1kFdKkmH89vrJgBDMCS2EwDI7wvfy52tP2K8EnWpUkOziiLCq?=
 =?us-ascii?Q?WyMUf+YEWcHiUB77Y/wIBNn1IjaMyTtpjVs9S4REtFwTR2Jiimm+ccsSqYYC?=
 =?us-ascii?Q?imli98KVV9J9UZoaS8bvx/AsCQmhA+OruMibf3NJWIohSlYu5NTFs8sM9Kzu?=
 =?us-ascii?Q?RY8A5BHg061zWqlUmjLwpMnJJA7et1xTwqPhiV9Acgsp5ua0qJfJLmiKjQY/?=
 =?us-ascii?Q?SYaqUNXab7gxyKkrkpwrZ1+9B5B6WrhILn8iMD/+F3y8PuyzJHyF/v1WJi/r?=
 =?us-ascii?Q?dNxQY2yLKbnwgLzhVvIwXXJUTj/H4khnOmUxgHBwyZHe+RvYuiLX++Ss/nIX?=
 =?us-ascii?Q?NYbr77+qlgGfcwXBE3KCvPjietAudCIVv/eAT+cdEdQKnqEgA4iFBHkBvlKQ?=
 =?us-ascii?Q?0BC1qn6uHUk5oRnfNDY8CI3f0EgqHAmroF9vNsoMwQe0QU6afy+nCc4uyaRV?=
 =?us-ascii?Q?zCLf/jHyyUPMk+ZA5QB/c+8eZpJvxQJcbUTeJzUcRsoKuijCOoDpeq3uOh/p?=
 =?us-ascii?Q?XPUtEROKL52dZBBuJRHAnJ0n0wsE9UVpligoUgEl/JDuDwx8iHW4dYDa/vcR?=
 =?us-ascii?Q?90EwllmQoH7BUdV2Q12Ngb5HUPB+UJnQdeBSlSZvUIztdZB9yVyT1X3Xzmq2?=
 =?us-ascii?Q?PdIUxOWuW2gozsalhHPkAu/h6dc2QwtM9zooWT3T5uGr7naqZqboLgCbivxB?=
 =?us-ascii?Q?mF+fPmABSatFEB2olY6txLzeChYrghcEDbvDmRYV9kQF7skscefjx0Qn3daL?=
 =?us-ascii?Q?UkiaaG6yJ/LyI4adtNhdt3dTioTLzlZSKFe5aZ4tHhaQLkhprpEkXghACSGy?=
 =?us-ascii?Q?IHmcUXvWg6c6+72ulgn78EesuIJ57Tj0KpCsYQ0Xz5zalL1kKjUGNZ9Bkvhl?=
 =?us-ascii?Q?CAsMnqI0aFK8lZmx9qDkNn5AKzln7JT46YL+WutnF5kKRv1V0OIMS0DjFNHj?=
 =?us-ascii?Q?s+0RpzeuNh/NRAC+RyNBIBgaVcFijZQ/lcQEg3stA7UAu9V4G1oVWIiDG0Xx?=
 =?us-ascii?Q?nC6KBjjmsAt6tkdd5R+0w5SjuzJO+8TEcm4YeYOI98GYPrgojICo6+WYmaTK?=
 =?us-ascii?Q?hclXr5fpP6ro6wx3qv+LB56PAhhKZnJIP8TUh4783XAB8q6oYJIPY+AUIk3p?=
 =?us-ascii?Q?HDbeUO1sDIgKyi/3WIhz2yS8Z0bSneTLZFBoPwFMTFwoakjjJgVEI9k9uMsg?=
 =?us-ascii?Q?xNRBgCCCfPOcIPnC+Bp8ZgVxKmYoR2oicQxnD7Mlt2L/Rve1bR/lg61E0JLr?=
 =?us-ascii?Q?g+s3pP8tJomRv1H/BaxOLlalDKm4E0/dcuNvrzXLK/1ZXerPDX8vxuikgflR?=
 =?us-ascii?Q?2EONVmIFzuu/hbPbdIkJv7FwzYBbZKgIPXyYPJnmlce63ICO6Yr1z+PTA0HD?=
 =?us-ascii?Q?7mkslg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b66a386-0a97-41b4-464a-08db3ee0af75
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:11:33.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DOfrk7NvaPkW5QuHiMeo4ncPcX7WHWnU+qYWLxjM9249YvK9ep6QW6/xHh/G6dIF+F9AS/ZPywhXGw4+Iggq7qei963OchOgpukvAVER88q546uxIDgG5O1uXcIwnaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Rob Herring, Sent: Friday, April 14, 2023 9:37 PM
>=20
> On Fri, 14 Apr 2023 15:16:18 +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe endpoint module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-ep.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.example.dtb:
> pcie-ep@e65d0000: reg: [[0, 3864854528, 0, 8192], [0, 3864864768, 0, 2048=
], [0, 3864866816, 0, 8192], [0, 3864875008,
> 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too l=
ong
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.example.dtb:
> pcie-ep@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'addr_s=
pace'] is too long
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.yaml

I should have tested this before sending this patch...
I'll revise Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml abou=
t maxItems of regs and reg-names
on v13.

Best regards,
Yoshihiro Shimoda

