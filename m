Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B9570F84
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 03:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiGLBcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 21:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLBc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 21:32:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C18D5CF;
        Mon, 11 Jul 2022 18:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkJODEO1RhDysEloCofzxnKidi6+pWn2xncU64OovtNJhMrIjYypcE0IJgzZibHoUDQRQcWHTdgLT3/HaWTUKR4RAftEyO53NCVbj+FwImI8mUWFj0q18uJg3dIwo9y/sanmRzHbhyHBb81eoO7QCSqC0EuEeEQINmxEEeJjlBmfzftqH/UYXHZVwWrtJ+Pg9jivNmfuAi++2aiPPgpMgNvbOczb51ZharbZnckI3GaoiSmWpf/ICv6Y2pVQC6verPwfhDmtOJYH4qHcc1I2QCIxxq0ufnVqLkQp/b+4rwr05F9U9fOtoWkhyYmqegEiXDJY5vzPQ3nlYuYMH0RbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEb0w8bicVCjH2gF80U4d9HdszGzqVgy/bGR40gXzsg=;
 b=Y9lzo+foPfPwHYZLYoE8juDuJ2RwrnAxvwdko/+mKbRmV21j3KH63B8iLvEiH08NFfSjMctDRjoe9+GYo8+y4uMwP0V1POdZbESl5DKBVu7cXzBpTzpnuRYm+3rMOIE8BygEHvw6bx48fXUzxy3tyna+vaswqdCtLlYI1D/rs6G9xLf4xW8xLDN5PG3dj8dCYfXGlY+4/ai3q2KfIq9YIuVT67J3wLbgdKsBrkAKXL2yxJ5GbcObXk4fL3LfV0tPiV9RKuCjSx4p/uyABL4/bk+PqZ38eV4CT+9hxhpnSu929Y9BWoOJxuRKgLLdcP2JckFyhsO4xR8EmmHG0E2ZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEb0w8bicVCjH2gF80U4d9HdszGzqVgy/bGR40gXzsg=;
 b=easFhzi3fVWB4dj+jqCpyrSG5KQm2s448xYZjtvDvYffRDHjc+PPq7yT32/1lfP6u0n6YdEeISFqRFbBVPYb7FLKfJKj0UjFCeqXbrgEOmFTknRolFMPcnL+K6LmgjVl9xvDHBTpoIQ5KVGjxlIcH2v7gIf1JYeJ0kKgUfOVYrg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSYPR01MB5496.jpnprd01.prod.outlook.com
 (2603:1096:604:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 01:32:25 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:32:25 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 06/13] PCI: dwc: host: Read num-lanes property before
 host_init()
Thread-Topic: [PATCH v3 06/13] PCI: dwc: host: Read num-lanes property before
 host_init()
Thread-Index: AQHYjSg/pZigRB2HS0+P2aogG7Wjj615jyYAgABzhBA=
Date:   Tue, 12 Jul 2022 01:32:25 +0000
Message-ID: <TYBPR01MB5341AEC6AF41088BFE38B142D8869@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-7-yoshihiro.shimoda.uh@renesas.com>
 <20220711183336.GA4189538-robh@kernel.org>
In-Reply-To: <20220711183336.GA4189538-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bba47a-a1e0-4bab-c894-08da63a6602e
x-ms-traffictypediagnostic: OSYPR01MB5496:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pGGVk6t17UpsSr5YIVuI5I0uKJ8tLROy/mlPpU8wg2C4bQeABVciAD8PH7mx7qfONFvhkVeu3UQLiiUh4ayyviDqQ+i+zvr41qui1W/+SG23h5oWPZLziUqcZd+7RBBGREBOJn/HJsIfHAAq+iOqTPR7PxLyqwIbNox4HNFqHHGS1Ds/sXCe4iI4POsOlcyCnJPLyXDBVX48okPi1j3nVQKa3MG0flGSh5cvt/BDM36iNCZjyLtV6v0iWTPOzky779lryW7HD2U2anM/o5hhdOshfzCBHrCcGSkiJF2VDKl60FAKodMP5VqXVKbLmPqrYc8we/mNsS3NHlf0W5/v0I8/f1m1vSjfuGaEB1ZoASSuVbpXbfdTGJ7OoW2B4A8H3CIJAai0E9SHqtYED31fi5SE9QkE6u6IHBx61aYmjDje/7JpnSt4wKsnBDf5gS2kYWGIHW51jbNWfRfdaP9xBxUzMsXuA8euBe6BQ4oLJTj0QwaWK0dqNfCi6Ct3WzLVjxNHd4FtOxirX7dqUS5NDF+QIfFxcBsPaZs0aBFXKh3TcbDCHR+/epCOBbN82Lfl5fiWn9NLuq6bQ5VCkqhISawcmYhP1QKjI2BLK2suvXatWJDrkHAGa+l/s3Hnjjz1tKc4lZP8S3NXqVqomtDpZUvuc6voGwmmbjrsG2En/9v5EA/DAbSMngqngJcz3HNnt2r91iDX7ZIo4CA82ISZO+Rx1EIoIva/YTe3yASKLpzSBsYhZXSXuMaoLF4oeLqbr3XUIbl4vLFAGE+T+6NYE/C9bGBmvV7XDgyFUJv0l75PK24xkPBZuSD7LTCpmashHrkB+G1cFEhTd+F10enUcw9ju9mDAne/3VP5NrybdK3tLvz4lnvCsqpFtvIdaNWF0GddVkrU/4BM1oOhpLsWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(38100700002)(122000001)(2906002)(38070700005)(7416002)(5660300002)(8936002)(52536014)(66946007)(9686003)(4326008)(66446008)(66476007)(6506007)(76116006)(8676002)(7696005)(55016003)(71200400001)(966005)(41300700001)(316002)(45080400002)(83380400001)(478600001)(66556008)(6916009)(54906003)(33656002)(86362001)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jyyajZDl/sSKmJvFYl6IMeut2XavVhfqfFhbwMgdQp41zWwV7CgnJIQMvEsW?=
 =?us-ascii?Q?TN46Cz6xmeHl3Uhb3E2bjTdixuGQt6JpN5ilhnLGJQc6fPyrnwQvYFwm8X0m?=
 =?us-ascii?Q?SijEhg4yVvCN8DatY3zRjtUu30YxRuP/7dt3gNdiqfuMPBPXmRbzZdGNViBQ?=
 =?us-ascii?Q?Nhn1D+mzOKrIrOFkDuNVqZSLmTJ2np0X8ktWA9IJTIFtOqf0FBvlwYUjstuD?=
 =?us-ascii?Q?IRE1zJCrKqV7s6WsL86dCOdGksGUePivu/1j1wxtRSZJJIeaK0qR3eokNOOM?=
 =?us-ascii?Q?7rZ+K06PWq3fn/+xW9P3h/dFERDPKNDQbOfjvxGLLttJJEcR5fVgFDzCmnKz?=
 =?us-ascii?Q?bAJ7unriQw9SFELIFYeL+6xncXU291AdjhcwK/7ocV9G6G96I+NjxXARk4Io?=
 =?us-ascii?Q?3AbLh6cX7GQjdZLGjZ2sioj5fOXZ09DSUbmQJENGKYLFsBtFoN2nHrmFX/u+?=
 =?us-ascii?Q?yciae+twv0utQN1We0KVKBRWEZkHA8zGh20Vh+6jtTjMGdtdQXtBhX00deJB?=
 =?us-ascii?Q?bZxNEECbPzhP1Zht1PRbj8Ws/9fWqQ92TFXfPKdX2Gtp3ixbo8mebUMBRCi8?=
 =?us-ascii?Q?I0KMpCG0WBpwAQYJfAbqmKFNynxFAUyGo6/Ehpwsh4t8AuafmJmQG/VYXIAp?=
 =?us-ascii?Q?8vXxfcNZ27HUnQsIqW+BtYtRltoUEXP6lTwqhG8ydKCsHZhzyeJclftCTWAo?=
 =?us-ascii?Q?lGW/G0mCTp1keJp070KGq1SHZAomTGn3uOw+XAWUk2RJF89WwYb63aYIN6Va?=
 =?us-ascii?Q?lQNB4VaYnzuVQ3tMC7OQ7O/IPrHVVHSoefzyU4N7Iq4/+T/Zm21RT9eYGEoZ?=
 =?us-ascii?Q?poBosqR3BE/6XAb6wEUBsqNWhvNg6sMM6CFOkem1XrGqI/dkPnDak6j159zY?=
 =?us-ascii?Q?lH1zzkKONL8FWg4hCKSLmifnyaFKz7masza5rReO0og7RCjGKjXiEMrGi7jc?=
 =?us-ascii?Q?W3DyJ+rw5++t7gmc9WU4zIUAedpq75+dYl6lZ2S8E7IyqYSHn3qYORZnyuz6?=
 =?us-ascii?Q?4ojjUHMWzh46EgYpjsCXtFlrykO+2oY84WqEQK/7pK4RrEtW8tzqGJaG5OXm?=
 =?us-ascii?Q?w0i1QuWGZrRT+/SpCDO6k++Hi+tE32IdyAIVl+iTv5LmS+a3aGOOwFxj7WCg?=
 =?us-ascii?Q?i0QUaNCmWJ87obHQsX2659H29m/xogOIiWavYIl4vJCMDDfnQgK0kRRwsfr8?=
 =?us-ascii?Q?AeX3BcH+kzMXMVfOamVfV1NxSlnLmL6W4ip/fBU7zHpt2NLkUvpCgrauxvwG?=
 =?us-ascii?Q?a90VUfjOBc684mfNX0PNdHcnbhFYqAksrDVNEAHRGi4jbGy9YEIn+IWAqZGm?=
 =?us-ascii?Q?QdEVJ4NwQpp7mEv5tubiOwMkIoUSD1FSOr/2OJASZkJUUUa8rmmIBAta64PG?=
 =?us-ascii?Q?nMR+A+nU0qBnP8ILPywARfUIG7wm8a4FXqGiXpKTTATOHTILDLZiiB0+/nbP?=
 =?us-ascii?Q?YdZ8MaBKHtrGDgldge3IervhW4JjghRmX7TCJB+UqxLRtyVawnXWKqIn3vL2?=
 =?us-ascii?Q?zSXLJBMD6dJxcpeldEfmOcoQTYCKvtw5q072xym5fAYsyist+foGeg21iH4P?=
 =?us-ascii?Q?CpcjWKIbu3ZPL0/la7BWGJFlQADFe8Nk8PQPjXCyaq3ZGhrmvkwspuE5sei1?=
 =?us-ascii?Q?C+RvHHgmTTG/UUUMrMnjj0ZeMPwvjpiSiu/LdM9U4obEBOGoPb93NILZZWMK?=
 =?us-ascii?Q?xUqhoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bba47a-a1e0-4bab-c894-08da63a6602e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:32:25.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEazBYn5Wa5AJqrYhqfN9uy/v74sjynAaYo4w+mizsIwfY9zuaO245M8WemZj3BksTTB1/fPTMnHE8RqWK9GkQnxox6xYd5sjFiI9qDn+in7Zj27QWTAChgFX9NWdlnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5496
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

> From: Rob Herring, Sent: Tuesday, July 12, 2022 3:34 AM
>=20
> On Fri, Jul 01, 2022 at 05:54:13PM +0900, Yoshihiro Shimoda wrote:
> > Vendor-specific initialization needs this information so that
> > read it before host_init(). And then, we can assume that
> > dw_pcie_{ep,host}_init() gets the property so that dw_pcie_setup()
> > doesn't need to get it again.
>=20
> Patches 5 and 6 should be combined.
>=20
> We already have 2 drivers (keystone and tegra) that need this earlier
> still which this patch doesn't address. I think we need some sort of
> function to initialize the dw_pcie struct with defaults to be called
> after alloc or as part of alloc. To do the latter, there needs to be
> more unification on whether dw_pcie is a pointer or struct in the
> platform specific struct. That's a lot of churn though...

Thank you for the review and comments.

As I sent an email yesterday on the cover letter [1], I realized that
Serge sent a lot of patches for dwc PCI common code. And, this patch
could be completely replaced with the following patch because
you already sent your Reviewed-by :)

https://patchwork.kernel.org/project/linux-pci/patch/20220610085706.15741-1=
5-Sergey.Semin@baikalelectronics.ru/

So, I'll drop patches 5 and 6 from this patch series.

[1]
https://lore.kernel.org/all/TYBPR01MB53417EFE0A6DC5AF3D54A0F3D8829@TYBPR01M=
B5341.jpnprd01.prod.outlook.com/

Best regards,
Yoshihiro Shimoda

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
> >  drivers/pci/controller/dwc/pcie-designware.c      | 1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 1e3972c487b5..cf875bdcfabb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -336,6 +336,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	if (pci->link_gen < 1)
> >  		pci->link_gen =3D of_pci_get_max_link_speed(np);
> >
> > +	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
> > +
> >  	/* Set default bus ops */
> >  	bridge->ops =3D &dw_pcie_ops;
> >  	bridge->child_ops =3D &dw_child_pcie_ops;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index d92c8a25094f..101e892e22e8 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -726,7 +726,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  	val |=3D PORT_LINK_DLL_LINK_EN;
> >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> >
> > -	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
> >  	if (!pci->num_lanes) {
> >  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> >  		return;
> > --
> > 2.25.1
> >
> >
