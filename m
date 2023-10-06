Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C177BAF7C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjJFAHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 20:07:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E2C6;
        Thu,  5 Oct 2023 17:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R85E/6ZEtZ/O3XCrmhPusM7TT83sWfwLn7dfvaO7Dy0DNuZcc5dUx1hB9yRqVyhKP12u3BcIPHjtY4/PpkXVZT9gWGwm6sVtEakJC4Y9X/nViuC81QXdiU4PJmX1CO+eOW0zMnh8vEbCzuUBppMCrfdqw6klIDJ5RGXEnPpV5b5S59lne7+bha94s5hrdBa5WSuWFGvy8cVYQMfkW4rbFumI3rS8UKpae86OzEovrbW18yo71GISStLpcsiIiX+xrJx/wpGTMnfNNKRBrL45ywm+SHcl5tCLBnLbXIEun9IZJ7cC2dIAiYOvCltOr2gCg01R4OXSsxm9pGTG2Y+Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC7q7SC626A10MbM/8nT2uBlKIb9tm+GA7TTxxgW4uE=;
 b=QG7kkm9WhZNnmkH2bja0l4n9uw9C3Enkrawp88Rzfjp0EIfmIJQ2AofItpwSf/mxrnAHfWJpvBB7KyuK1ZFO+NPhwSyme0Wdw7o9xHv85cUwyYnhjrXSCd5dInXc3DIxuJ4AbPPPoEx0ohP/TFJfClEQYoPpBxIr/yd/SsrKMIiFFp5b9WZmA7uOvXSVD2kksWKQtbI+iav5OC4rcCCTiJ0rbdA34BIvqRNxp5HJwzqbadKcyqgDfLYQcT7trbwBgExB0ZHJGXHrtdwGUIlE1IDyEgY1aAyQPouyiWNgpmTOS+JKZYFpbRnoh3iyQ8Tbm9Ft+LgGt7zPlIM6h9oB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC7q7SC626A10MbM/8nT2uBlKIb9tm+GA7TTxxgW4uE=;
 b=azyyW80hFchC5pdbx7MjONH4sSV8yky3YJ+BKuVVrd2bXvL/vv61oummX+PPf8OjKW8/QiLryh6CkhkXIvKs9i4mmmwwMLe2UyHVSO9S0bcVk5Ktf2hOez/fHUE9uvrzPNkJi8auawdkZ/dXQ8ln6DoGdK7pMrjEQVDlQQMuo+o=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11951.jpnprd01.prod.outlook.com
 (2603:1096:400:405::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 00:07:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 00:07:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: RE: [PATCH v23 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support for host mode
Thread-Topic: [PATCH v23 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support for host mode
Thread-Index: AQHZ8HRsthoffNabyUqmvLc0YuNkzrA7WtyAgACUxoA=
Date:   Fri, 6 Oct 2023 00:07:34 +0000
Message-ID: <TYBPR01MB5341AA2E0292AE789F75222ED8C9A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230926122431.3974714-14-yoshihiro.shimoda.uh@renesas.com>
 <20231005150907.GA746291@bhelgaas>
In-Reply-To: <20231005150907.GA746291@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11951:EE_
x-ms-office365-filtering-correlation-id: 9879f16c-6127-423c-ab4e-08dbc6003dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ETCoZncmxtbLtE0nJO+kcaMcQuttfyykwbzUDSdg8eZowEuR/U86BZAbQIkJ+DcDHz3bYL7vExuzFVFAoRtiFAwvM40au+mOtvnQawPDn7hU47AscWQLDv3UGjVSDURgIqBZqGm6CGYOb2C0oYHFvb6W+dvHaec5X7EnuNnLcX88Bs/8cJF8OvTwMg4EiRDkOp2EUcomc6ctDDSVBIl5PSv7jXAe2LSt/PfnmxXSBmnpg7lgu2R6P9NoRZEQeM/I1u60pmdSBp2mF3e0NK6kpUkYf7yt7Q01rkgioXltLU/j/wbtZv8ZfyQlAFUW0ygcir+EhpjSoLJZUpSaLIZft4hz8EWyEcHssj+wC6gJU74g3Q078UJ5A2jqNkLnX93u7H9sf5B6itxXDCRslj25f8kO0Jo1ewRaYxp/3kG3wBj5zepbVJ4FGIpLibEaXunfYaYzUX2JNASygjIOUXr7WnWB6d/klTZY/K+Nr88yB7KLjYTGWdOxTNyZsrKiGAy5gLYfBRnklpbMQT6WfleBbPE/xuesJyu6oDSBgHW1i3ZQkpPSE8JmugYLSZnWnLXT5VcNOKhvvg0PiDv4pzEztwAoZS3G2CtIKohxhf1ogw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(8936002)(8676002)(5660300002)(52536014)(2906002)(4326008)(66556008)(41300700001)(66446008)(66476007)(316002)(64756008)(54906003)(6916009)(76116006)(66946007)(55016003)(71200400001)(66574015)(7696005)(6506007)(9686003)(33656002)(478600001)(83380400001)(86362001)(966005)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?7fY5Hjy45HKm106nGECh0o4ulxlPPLWxnA/M/JHuGEknfFk0hG2O+2xNBJ?=
 =?iso-8859-2?Q?Y9u8+l8dL44LUGOzi9Ype4vEpbibAu3LpQ0L/TgUBYvl3B4/mjxtayBmpv?=
 =?iso-8859-2?Q?pTz0qQ3HBLLO2QtpG0Iyiv8RbKrhgDO9aptBhTzcIyla8J/6SFZO6ELNOd?=
 =?iso-8859-2?Q?R2Syk7LQf1RNXSpYU7cfAu9bskVn1/uY2bWewaY+/fcXjIVuq0es/vinnR?=
 =?iso-8859-2?Q?Db3zYmuZRutMrHOrDGO1JM0fhjPzKiADBFn/W5bZ7vxG9e+qeHY426b0aw?=
 =?iso-8859-2?Q?QT0HfOdIuPXmLDsq0xO2/jsQ2NBlCzhAXKjFUEDc4A/WgorlYOZwaPC8pP?=
 =?iso-8859-2?Q?DxjfO8rnS74+EP6aHB9kOrNgXO+M1QPln3RFgZVybE/IVLdPiERMg8bKNz?=
 =?iso-8859-2?Q?D0Ctk43w/c1CvXHv35NxKZWipfvQiarXkflT7BJ6IArE6IQq2/zjyrk/Fz?=
 =?iso-8859-2?Q?SbvSzA8ZnNF4vURjbIDUqZS9MAiREQ18jtr0vY7xyOFYeP8b505uscMfp8?=
 =?iso-8859-2?Q?GPoou09bsOOW2iny3g0MnR0mtd5ctgaNCSKBiBslyPQE+EPx3o+8VZ0SUg?=
 =?iso-8859-2?Q?qLOIunnEQ5/sSD/H+FBnycKuiBG5fEymnaduLtYa75GYh9SzgwF7nKt7/3?=
 =?iso-8859-2?Q?oQFzZJYjmaqkf5X6Nmvpsf8gDvAjGNbWv4VayVOMk/BHO06lFbxOhTSH43?=
 =?iso-8859-2?Q?8gKhJN8nlROnkFlpcFXQAeqHRtIBXa1zY1rcSns+9YIkW4MsjGkhAq2D8p?=
 =?iso-8859-2?Q?eYXoAHWJh44TSnMyBsWvcCl4BQbhPRZgWglHbG2cWjyEElx5GfrVGQrLiI?=
 =?iso-8859-2?Q?ZiSu6jOAugIYN2PYUhpDHC7q+yqnFZxmXPDdk4MJYVNUKXzu2lZLauPvZr?=
 =?iso-8859-2?Q?oXdniZjyI0psTXdKMLbF6BwEqnspgoVPItqWCCqopaHQP+8cIF1FsCDBCz?=
 =?iso-8859-2?Q?57zluhMxjcslu442eq2u/VcV6hWei8MtAbg/QZ0zUc7fhLCOEb1CGY9XPw?=
 =?iso-8859-2?Q?i2T5gdIhjP/JkmoPQJvZmBPlMNeOfWkmEnLdvgGEct35QCTLLnxwYx4nga?=
 =?iso-8859-2?Q?OSP6DPCwmpwvS3iSUymbcyKchypz7h/i1gGt6OCH14M+XN42O0zm9pJivY?=
 =?iso-8859-2?Q?MBcd/P6dvGGqo+jo9FySMwj4wJoZCkEKlSZ0+Xwk2jt4zIYJq1VOFjez92?=
 =?iso-8859-2?Q?axbjFUtzvrjbLWsZMaeHr/qsco/Wj9GqPnKlMm5uRM+VqIxMj29Mh3Y6K9?=
 =?iso-8859-2?Q?HGG1hHng5rD9gFcDVB+qJgGdrvkg62SW0YsZ+UHAlysihXl3xeZbr63n0D?=
 =?iso-8859-2?Q?FhS3JLtjHRXzFQXk9Ef7WEaLMdCT1QSbqsk9XDIh0CGE6ykUFvKkWc11cX?=
 =?iso-8859-2?Q?op9u3aAdFuOyJ5olUmKmLi2WzVKg9lJfydwyRYOdL0387ouVMOZmngYWh7?=
 =?iso-8859-2?Q?wGrJ6T27b4zyHPiDey0CkI1dBG5tpCxNBBU8N9NXlC89JZ+efrSRg9DCmi?=
 =?iso-8859-2?Q?Iainth60gqbDIztaxhDch1n93p2ttxkx3BtvJ35+AV8KDWfVSBOKK2L1ix?=
 =?iso-8859-2?Q?1RJFW2fL+NHT48epJuU0stCpWQdRZf6LMwWnbI/R2Y3cdS65ew4LAMq++r?=
 =?iso-8859-2?Q?e7bgVk1HE6J6j0D3o/Z+h/Rl8s3FNvGSQ5QWvus9LB+zXP671hjIfhjmxG?=
 =?iso-8859-2?Q?mNimRqJPsriA/cG1AMM2+sz0GpEHSIsbmF39yC0HtOeEWeJn/3l5p59GN0?=
 =?iso-8859-2?Q?12kA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9879f16c-6127-423c-ab4e-08dbc6003dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 00:07:34.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8rjdlQLa2MexPxIDCJL1lH5vxEqx0pQO8Ncvt0XhX5+XSK6RTyJaFmwnshjw7dafRSY+rIOYOcXUrYeE+DP+5sJXvrFJndCY7seNSP7/F6EH51bC+yn51IzyiP8YGEm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11951
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

> From: Bjorn Helgaas, Sent: Friday, October 6, 2023 12:09 AM
>=20
> On Tue, Sep 26, 2023 at 09:24:28PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe controller support for host mode.
> >
> > This controller is based on Synopsys DesignWare PCIe. However, this
> > particular controller has a number of vendor-specific registers, and as
> > such, requires initialization code like mode setting and retraining and
> > so on.
> >
> > [kwilczynski: commit log]
> > Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-17-yoshi=
hiro.shimoda.uh@renesas.com/
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
>=20
> You should never include a signed-off-by from the person you're
> sending the patch *to*; this "Signed-off-by: Krzysztof Wilczy=F1ski
> <kwilczynski@kernel.org>" should be added by Krzysztof when he applies
> it.

I understood it.

> Whoever applies this, please s/PCI: dwc:/PCI:/ in this subject and the
> "Add endpoint mode support" patch.  No need to include *both* "dwc:"
> and "rcar-gen4".
>=20
> > +config PCIE_RCAR_GEN4_HOST
> > +	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	select PCIE_DW_HOST
> > +	select PCIE_RCAR_GEN4
> > +	help
> > +	  Say Y here if you want PCIe controller (host mode) on R-Car Gen4 So=
Cs.
> > +	  To compile this driver as a module, choose M here: the module will =
be
> > +	  called pcie-rcar-gen4.ko. This uses the DesignWare core.
>=20
> This should be sorted so the menuconfig prompts are in alpha order.
>=20
> > + * Manually initiate the speed change. Return true if the change succe=
eded,
> > + * false if the change didn't finish within certain periods.
>=20
> "Return 0 if change succeeded; otherwise -ETIMEDOUT".
>=20
> No need to repost unless somebody suggests more significant rework;
> these can be tweaked when merging.

I got it.

> Thanks a lot for squashing into a single file; that's a major
> simplification.

I think so. Thank you for your review.

Best regards,
Yoshihiro Shimoda

> Bjorn
