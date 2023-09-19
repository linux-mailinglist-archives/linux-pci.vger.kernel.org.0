Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C87A61C8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjISL4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISL4J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 07:56:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905FE3;
        Tue, 19 Sep 2023 04:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqWn3kNVhrUK5PQcQtnFbFXaHdB6Bed53qm/n1kOUwZM6d/MwC6dLF3qJNYzPj9sIdhqiiGyCkqENYGWOwd007eofUMxlJWjJ+z9aI+dmoHzXd5wfo6jX4cCB5LQ4M+NwKzu4gD8/84ngHbYD7vQqKCXlm5vPvGQfITxEkz1wO5GrceV0PkeTVQYVoQA8ethew2WXfdaJUdlNK+gME8QOVscb/hqbcL48ffrzLgFYnIqYVePnbG8rbN/c+IbbT9Af/JRwdg7mBVTZpD1flpgR/xAQXrGHbKIsPjXGPSCE4WF5Bq54+eAd6QKh7NkdeXlRIdXlXiYgS+oV9b5CizkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRIa5sF/etZklbPUmUv6K3lBDJFiyP0ARx3tKLYXmZA=;
 b=K8bI8k/EaTO/N8mnYQr2OHImAcDGIfOlMcZWrzFZvNwMckJw4KNU2ubJ2CnhVPSpGgJh4qpTloLzMH6UfzUx48YK0kebnv3Za1650P+f3pcKuFW9z3nKgHn4MLhhqBrHy74J0LbXzwLm7nqrtQgg+m1fhrKr+qpbQeFZIXN27Yue6kfiIup3+j1ykKZUCyHIwy4MSNg6LC6MjibkSmcdMlJzCLkDYYv7yWpCVEuMgaGaVeHvXtuevLzS3bxlNpcrlewct2VuvXeZ2caxVBytAg9ksFK+rwWWoBBhJLjsPnYXtnAvGCFhiCpwz71KM6rPW/g4QUHY+bZyWhxwifKohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIa5sF/etZklbPUmUv6K3lBDJFiyP0ARx3tKLYXmZA=;
 b=K/pICyrgDm+qsBxOJn87boyBFJlbeR5Uw6UHsdT8rQRlT2uB4O1IhFThY/HeorVUKyLEYSzdVmYWrjAFiVaNHkRcVdn5jckz6YifkMuwR9LVl3nls4c4jCK1La6tQ+WljHNhOWtiI8RD7EuIbtWn9zZbPW5XCs0OHdvIBSzOOdo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB5700.jpnprd01.prod.outlook.com
 (2603:1096:604:bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 11:55:56 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:55:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Index: AQHZ1zcOdRSM/H58w0WCrYWL3XR2drAZhliAgACMtyCAAnRgAIAFWa0wgAA7nYCAABUF4A==
Date:   Tue, 19 Sep 2023 11:55:56 +0000
Message-ID: <TYBPR01MB534141F4F7B419BFE473D9B5D8FAA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB5341FBF030A8A4F35CA74B62D8FAA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230919103933.GA226055@bhelgaas>
In-Reply-To: <20230919103933.GA226055@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS0PR01MB5700:EE_
x-ms-office365-filtering-correlation-id: 61bebe7b-e05a-4df5-9284-08dbb9076218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0h15TPlpL5gLTGF6lCGJuGFTLeD5H18UStqJSWArCQlyek7Qf8f5BnETknm3d343f291vh1Joo1K5vXDzwYcIv7+MdBx6qEtFWrtOaxFrqrFdt6YaY4RLs4Lt9AxBuuQGnzUbOx8/iwxTNk0JSPQ6D2A+Udb1eGbdjMDbGJz0jrj+cQNQFAPKI9jfZhfNQO4jd3pfWmh2EDG4UFpvbBydQF+CJ4O0fvpYKdq9bZkLuciyjot3BXe7hSVkkGqL9HemUMlMjsjEcRixF6d0Pg1nE02GRpREe1wiJTjqim6OYGj5pZlzVTE5ATSBljCEWCjaTRmsjCfFBO2BNs9VDu318G95chUPEZ1qpwGcKaHvg1q/jwICOjskVDTjAa9joWGF3POd5RjKO7cPdpWGf9l/XIG+3CCAI+KGA6lD2z3ybp1w7XBSYDKWphp1Zw6VSpZpcbYfrkgpv3LUADNgtTLj8flEwUY1Bbt9HSO4dPojXBBpPWKC9/0z8FPEiFgaQ3gUCx3ZLkl6uL2rsAuey4l3AfQZJYXE+4+yLpGWsbbWu80VJlnlDsifZ9kkJagTjcmj2kV5n4Prxg9qS1i5ZMPy3FYaDM62sjO0pB1GL4aybRJ6G1vBGxFWNF7jAV6O+/Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(478600001)(71200400001)(83380400001)(26005)(2906002)(7416002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(6916009)(4326008)(8676002)(52536014)(5660300002)(8936002)(41300700001)(86362001)(33656002)(122000001)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ha2Ci6+qDKZBiTAhHiUO2YBzFpo/I73TkFeqvP65m8TmqHKFpaSeSqeR6Mno?=
 =?us-ascii?Q?w18vy1ISJEk3SqoMNFtk82FVEs5tSn8E0SWnSswiAbMyQniTns+kdSY5K6HJ?=
 =?us-ascii?Q?wPwHxLOfJ0MY3ZBi1JDl7jOLbD0GBp0eFPYEFsqnyS5EG6U9p8+oUydEb2oS?=
 =?us-ascii?Q?33bdL42yLvwxXar1EG4wc+nN4dVscXrIyI8E09miUwLCfIwU1I0fAUR8+Oen?=
 =?us-ascii?Q?g1HpHze6f5et9VxZF4ng/58eop0ok+1DhtD3NMJW420xrj+uZK2Pu3bQBJBx?=
 =?us-ascii?Q?aevT6kTckvOAyVTByuzvUfHDD4FOltspE42uoQhbVLVuQhpViqIpOpdEoP8w?=
 =?us-ascii?Q?fX/FRA6KRRvr6FZsqGEmDx6c5IfVtjkiLWTtdsqa5AjqIuHgDBWkI3KkRqax?=
 =?us-ascii?Q?TIgfgY7j2/z7lP+EJR4A6yasX48e3O1Egx1P/8c1inV9KfFWn9FslTVMCBs1?=
 =?us-ascii?Q?Mpr8xl5EVuHbKw9dG30h2/GoxjlYSn1BgR/WC+wxQ3J632fzKwYgKgQWhSjr?=
 =?us-ascii?Q?zeTte8P6BmzRyDGZySpZ8EmsroCO/Yoy6scQKi6ia3rM9QIcNWamCqs9dK7Y?=
 =?us-ascii?Q?7Bw8WAxT/MK3D1jPW2p7GLMWCZBHwMTqqTpYMmOiQFYAqHPi0+89RjF7bd4u?=
 =?us-ascii?Q?UoHtEbwDtYeA5AIMHaZbT661mBciybT0Ia78M4AF024dGqipNmNWMTPFM2xJ?=
 =?us-ascii?Q?/Ffl5n7KyP7xjiKFa6+6/yycpcVoVqVRFxeC8OC9plA+SPDqH/Nar/el4hnB?=
 =?us-ascii?Q?/YUjEo1loB+l9Nemze2s3XP+efmcK5WviZCaQzbFp1s8550Nq8Yqpzk95WtC?=
 =?us-ascii?Q?w622LfPqGZ+69AP6JXhhll78QR8t1UVyoh8w4fjyAdH8KjiVzdapfSZANrYf?=
 =?us-ascii?Q?nIFHFUQp0/pkizaHkrDvrpM1TgbeAfEJ9mqLKoO6K0DOIx5D4IiETuogKXcE?=
 =?us-ascii?Q?ilryGs5CUpm0e++U1jsak3WStLAvHnjGwfNURx2/X2n82OUk9oArxGAB++Cc?=
 =?us-ascii?Q?c8+QM0KGZPuya47e0h8HvRNe5dlChhJcI5jwIqQwmeCCMlD3jxovHxKkzGYI?=
 =?us-ascii?Q?TIkEqtu3GXTsignUuds8BZBn84/si0APid/sW6e/INL5zjnxVjyvF8hs+K+O?=
 =?us-ascii?Q?2GklIuQZ7z+foPcQD93mTGPbIRpeIIAvFbpEIMMa7r2v2meqoOU1NnwTkAhC?=
 =?us-ascii?Q?ruqK2BgxJWc5WhiTI8jXDTwAJPNXT5BWCWMr40fJScYA4fO57C5lSzYp7PCV?=
 =?us-ascii?Q?OuUEDlCBuvKCrzfZdjPU+5rovlV/D0Z+nKZoN0f6L6hNs56Ut4rMVxvlJYRZ?=
 =?us-ascii?Q?A1viHG6FfujCejLG3iJMb9iCy9ULZ9vRHEBd2v4QV2vNZoCR06zYfQmC7y9i?=
 =?us-ascii?Q?t7HfRqYtxL9dyvOtc4gBleIioNw4SBP/jWVgqYPak1uyPGQAsWrzt6ko3Ysj?=
 =?us-ascii?Q?TT3rZQrU7+8A/dfHV+rDOg5GjGKhFEA+yXko/z8WC4uvWD0TqjOpDCUYMd8o?=
 =?us-ascii?Q?yVo8yFVcx1GxBm54QfIwu/a0ZbUeDhfk9ThaywtidLAKTDBxKs4PrYqjkBn+?=
 =?us-ascii?Q?4Dm+2Jdt7YxhG4QsJrXlLLHI7DFGkvSJxxmtSJtsTuWxktX9/bIReofcNCU5?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bebe7b-e05a-4df5-9284-08dbb9076218
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:55:56.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjUeYT7WlEb1selCLm4D/Dm2nBTisdFsRLORnAibJ5pviV12634j+loLnfkM5ba/mDElfqRHaz6vFTG7p17lvp7xZ6DC6kjEC1/IPeGd9R/zsN0kDDdoGX07GKXTG0FV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

> From: Bjorn Helgaas, Sent: Tuesday, September 19, 2023 7:40 PM
>=20
> On Tue, Sep 19, 2023 at 07:22:48AM +0000, Yoshihiro Shimoda wrote:
> > > From: Bjorn Helgaas, Sent: Saturday, September 16, 2023 6:24 AM
> > > On Thu, Sep 14, 2023 at 07:56:21AM +0000, Yoshihiro Shimoda wrote:
> > > ...
>=20
> > > > The following patches are not needed if INTx support should be drop=
ped:
> > > >
> > > > eb185e1e628a PCI: designware-ep: Add INTx IRQs support
> > > > 5d0e51f85b23 PCI: dwc: Add outbound MSG TLPs support
> > > > 4758bef61cc2 PCI: dwc: Change arguments of dw_pcie_prog_outbound_at=
u()
> > > > 44938b13046b PCI: Add INTx Mechanism Messages macros
> > >
> > > Since INTx support isn't mandatory at this time, I think we should
> > > drop these patches for now.  If/when somebody definitely needs INTx
> > > support, we can resurrect them, and then we'll have more clarity on
> > > how it should work and we'll be better able to test it.
> >
> > I got it.
> >
> > In this case, should I submit the patch series as v21?
>=20
> I think it will be simpler if you post a v21 that includes squashing
> the R-Car drivers together as well as dropping these INTx patches.

Thank you for your reply! I'll make such a patch series.

Best regards,
Yoshihiro Shimoda

> Bjorn
