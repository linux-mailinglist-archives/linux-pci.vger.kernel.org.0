Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAE5BF1AF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 02:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiIUAFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 20:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIUAFd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 20:05:33 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE95EDCC;
        Tue, 20 Sep 2022 17:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYLRC9NuZpDVFw4i/No6X3XJ5vL7kbfEmZGJovPfvdlnbPqvUFVD5QLrfuejTiHcty1niZMio8TZJpRY5pbB2qpQoXduCZpQfX0eWGfpbdrMwEQzl7b52sNnctGOBekvDZUFIDJ/JdQhBVnUZgptbNv16K0Pr9/WVbFBpshyB9GuXIYRYlLD63HVam+em0oIyQKPAFidH+2zZ5WR1HZDZqP21i0pX0zTpR9BVMHz6NsHve1L9LTVODNfH2CRLsJeE2i7jdrAAZm+us2dRa3PQjRasKPea6DTFfjkWFxyl9rVoCxlHD9yMQClWt+gbdMYIP7BQzDa9frnYHYj7bBPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1VdXnRYzhapv41NSM7Fzl64TSgHj5l9XxjnNr/gmxs=;
 b=QGSKQR2TWk5hubz5bVeAps4l83y+/0UbvQ+rh6ahJCc30Ll7ZD6fFEs0nCWvWGpGcCdBbXQGJKrZlPLRuIS4nzj+Tgs0Up3QGxzcZvXosEK1OJKkG7RLLc2AMV6YQWxkCgVU1BNlYvAfhG2SrQq8NOueY0aXxrq9fqJ/Vsgev2CdV0/phXIaaxShuh6x9FSjVUbrrSPjLSsba8RWiBCbTJrPF9RrsgPbG4FgGvjy48ZE/Va8zu6tICHi/nXzwFAI21/FZs0EsZWewBuuKUwmt1O+JBDLBzVWJ2F7ppRaD6/HpdUkhgCsT8u5SwpmbfnQPf7TrdPZ3XyAR6wCCQa8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1VdXnRYzhapv41NSM7Fzl64TSgHj5l9XxjnNr/gmxs=;
 b=Pta0ZBNT1ELylaI+OobI6vEdK8E0mf4ueRRHr8JkESRdeyPV/dlOzYXLVy2K7ZW2R5mqtx+BhLwFEGdmkzUHsoyRS5TieH54W5fdPPHuecn6z3GycNHWYt4eaSAzu2n07hNUa/TxCVXNOPO26V8m33Lr+44UtkuowXvZarIVnbk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB9318.jpnprd01.prod.outlook.com
 (2603:1096:604:1c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Wed, 21 Sep
 2022 00:05:29 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0%3]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 00:05:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v5 03/12] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Topic: [PATCH v5 03/12] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Index: AQHYwPb10WBUW4aL8USUjKSsjeOuO63o14qAgABA65A=
Date:   Wed, 21 Sep 2022 00:05:26 +0000
Message-ID: <TYBPR01MB5341A75BFA6AFFCF59FA4502D84F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220905071257.1059436-4-yoshihiro.shimoda.uh@renesas.com>
 <20220920200823.GA1134038@bhelgaas>
In-Reply-To: <20220920200823.GA1134038@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB9318:EE_
x-ms-office365-filtering-correlation-id: 98ae3ee8-f9cd-4a1f-70c5-08da9b64fcc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rlb0gq2hUV9+MFQtV8tjHNy4OxnmFy/isUtE0HepGgrXs7x3mjBW7BqSKWvaW35WrXyORUhN3nnSB0ALUF1QM7LrZeclM9u3xw3rZrquEztbnn+UjhKVfe/QLcizduGbtYZ/d2fo2SzDs24qiOYupkq4X419TctR/7wVzUAqa0Rm/UWUNn9dASRoJ6DBu42quPVCSZpOJH5lZhvs0bhSoNoxqi+6qLTtLj19LeyKULWzBEylihLx61GVB0aVJ12Ro5odv4YXGhnfTpMKorbP/gULS7HGkmQWRQ3LgSfRTqjuRmiZ9RZCX6Ja1HzDkoVkTg5VDC1NhIWcaRW+zIG7/r7qPW3vzGlTiUf2zhtDxcZTRQ8lWybfsPToIGd2hHX6BHSMK752qM3J+KI29Lqb2kJwCcjh9+BvU6qUTmBh7dEI6Hjz29QLaHq3XbDM5ic1FmYYrQ2dvZ+9yy+RlSdPrSXbgDiTPEY0ipd0uGKEGFtb+kGo4oHeL1P5H8LK5Tk78IfyPRJjSdzbKYs5ergduubwxkgYbm9Py0SfFltrdisz/vqnJml0OsEPYxkzIgdKqXfCBmMgsbOP618AC2CgchmBROxL9E3Y0YT9c5Krt+wN2NpGenBbG1+vXwJ60hKU4/gJKVv/FqhXF7tINmtvfgSS0KFOsnrsDHegz/utPKaK8iT373LSyY9VGdTOZBTAlzLIXX/gdm0qbEI8K34JQ3Wy9K/fAIWYPpSheVEyQQTUDKm2MJCnBtXOVieQ8Oqb/jbJlcP/lCdZACQt3+ruMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(2906002)(38070700005)(54906003)(55016003)(38100700002)(316002)(86362001)(6916009)(122000001)(6506007)(66446008)(52536014)(4326008)(9686003)(64756008)(186003)(7696005)(76116006)(66556008)(66946007)(478600001)(41300700001)(66476007)(71200400001)(8676002)(8936002)(5660300002)(7416002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2QbkrVVgwwnwPR6jqsWO7ekqvMSA3920hgq9sTr1tWpfBfcV1mRaQw1o2cHq?=
 =?us-ascii?Q?Qw0/eMcEf8+Y3fPMvhy8asKARS9lcmh+8iF+m9DTF/xMuMMVBY2zHeUekDZB?=
 =?us-ascii?Q?e9V5WJ3qMxGe2zWhp5WAd2sKnMq+Zli3usrEOLx9MpaaqbHOs6TtiJrtU1U5?=
 =?us-ascii?Q?IDvOQRt+nBGVwcB5M6gITeTA+e9qJgPbVyf0NdYxcucRsyGk1IKU9JTjPt2n?=
 =?us-ascii?Q?r9TO3ALgSJAgcl8QVsiAgMkNYMNgJE6+OL4S6ZGGYPVs0ZEyGn2cfKUFMhms?=
 =?us-ascii?Q?82UqCobeuti9QkGooy9fzP+Yfuy/p5vccZUEXujlLqVb1sMnv2jqr3gNljhc?=
 =?us-ascii?Q?QtaCy/pw3N55oMhJfRBSgbzlI09/F0cTOgAzTb5LrE2x5InsCFV7vUA+OqOG?=
 =?us-ascii?Q?wrRab20GxFJgoCJ8V7TOi+gxsD18tUlBnZtVD46Rv/TnCuedDcb88sVlBRVP?=
 =?us-ascii?Q?TxH7UJpKyAivhtluB/S+R91yaa6tt7TeqN3H9M+FeGNcVAGCFEjqFyBK0EeS?=
 =?us-ascii?Q?SiCB4YpVg+4cyK/oo5ggy5Lkn+TWei45ut5gdSrUrtKCoPKDoniLNU6IDtAz?=
 =?us-ascii?Q?VNU8txAqcZGtfPjk5OTpi9oxIMgmuQw9AtEYBODSCYd+pKqiOiTpjDIMpYL1?=
 =?us-ascii?Q?nqCmM+JpVAqNv7JVA8eGfCAsCd2nkDp90Gser6fBFxo0uRR6f6LqSqGL8zhz?=
 =?us-ascii?Q?z8faiGvujgk76AQeT8TNeIJ9KNed60m/ynSuaYIZSGcotEHU7nOgaAF+yWw+?=
 =?us-ascii?Q?MjadhWoQXATigzm2TglBKId6CHPGqVWj19P3lrWSdaS0K0j/G7/howJUKINZ?=
 =?us-ascii?Q?stSHeJJYQFK6du3YvnK6MEwHJDR1xLQ0aJYVIfpEYiGlZCPybB0rsXmV5ydm?=
 =?us-ascii?Q?9qy7USefos+tj6Yl+FPzJ2GhxzxaK/884LEj88MQrPt0Q5/zafOhRSC1zvMK?=
 =?us-ascii?Q?ejZktc2XZr3u89tVixHOZfu/+oFb2vTXh/ZheeJYpKqsfu5DJe0nUjpfNkod?=
 =?us-ascii?Q?JBaC8oeLLCoun9Llycy7s05xE7rJoOcc+vTos169PI8MLWAol44QeV9d5ewz?=
 =?us-ascii?Q?Yh9LCAl9joAfXz0fc9kOJaL6HFWNeej8NhqWN0wjLDbcom12rK2GufWF0Y0U?=
 =?us-ascii?Q?+rowtdmvJjoZxSx/j4EoXDW5dddj2nkHJWqFs3qN6/UVhRk3j3ikrU1E0QNd?=
 =?us-ascii?Q?d8ujJ3FHFY/mOWOV0sDtE4Gi/u24YYUHPnyVg10dvnGquOPLsbwtzAcXhI7Y?=
 =?us-ascii?Q?Gaz60f+cpAwpl/x+0ayFhA+D8QXfxuFJG/eoQTqWqf2DNKcdto/m9xDX6ayG?=
 =?us-ascii?Q?QzvEMmOFVvYAkGcL7KBIRyBgZe9HJxgC/6aKayVit6k13HSTA/4YDjopb0RY?=
 =?us-ascii?Q?2sY+xGoEkcFcT5+3MZXzT8LQooY1aFqNl9ntHFxqbZlUDdOeUY2c+ZBThAyE?=
 =?us-ascii?Q?BMiMC/8A/JIGmWzyOn12SE4neBExfucDSFHOK5sp9+vDig11/2uxJ7OSKDd7?=
 =?us-ascii?Q?zhj/6XCmN2QylUn5NWmbALka1lou0eqtLc4idikeWRXfEnUzCAGbH/NuPnMp?=
 =?us-ascii?Q?U2dZ6mwBEdYr+W4M6VL0HtLkV7CcEBBjABq62fOZuhtauO6j5nSeu+b4ZiYf?=
 =?us-ascii?Q?byx60Zo/oJ+ExZ28k4SMDaUrPhazJavcwEdr2gQtNL2x4am5aWvbDgKKZYyZ?=
 =?us-ascii?Q?NZsA1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ae3ee8-f9cd-4a1f-70c5-08da9b64fcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 00:05:26.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKxvOND/+WySQ7aT4CXypzilYaimyrURdLYxwNPeDWqBaXsDq1a8GLPbn4G0VuwET1DPJPJ6lrazC0MJNNrzsubAlv5DyaDND1CiQQWY5+wsFg8Z62SlmPNBlwaqEedH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for your review!

> From: Bjorn Helgaas, Sent: Wednesday, September 21, 2022 5:08 AM
>=20
> On Mon, Sep 05, 2022 at 04:12:48PM +0900, Yoshihiro Shimoda wrote:
> > Add macros defining Maximum Link Width bits in Link Capabilities
> > Register.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 57b8e2ffb1dd..c9f4c452e210 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -538,6 +538,13 @@
> >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bi=
t 3 */
> >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bi=
t 4 */
> >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bi=
t 5 */
> > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 *=
/
> > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 *=
/
> > +#define  PCI_EXP_LNKCAP_MLW_X32	0x00000200 /* Maximum Link Width x32 *=
/
>=20
> In PCIe r6.0, x32 is mentioned a few times, but not actually defined
> for Link Capabilities.  Has it been defined in an ECN or something?

I should have looked PCIe r6.0, but I looked PCIe r4.0 v1.0 and it mentione=
d x32.
So, I wrote the x32 macro.

I'll drop PCI_EXP_LNKCAP_MLW_X32 on v6 patch.

Best regards,
Yoshihiro Shimoda

