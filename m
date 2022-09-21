Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939B5BF9D6
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIUIv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 04:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiIUIvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 04:51:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0658B2FA;
        Wed, 21 Sep 2022 01:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7gWEQsTaHzZeXaTkibbq3MYnGCnvxcKwVThhqzd9bQFrJoK88EXT7p2xzXpRP3fbMYQM2cJpdZJtOGGfGV4DoRX/vBINuqFUQNlIPn2Fu2OjBlok8xcnvVzUa6pg4SRCGn/jgQRk2BVRFhiSficLirydtsNJlKOGc/5e0NZLpQ8j9UDDZftT0HjdwqPnqO8vLiNfVyMpjCmaieurki+IoYK9ddAAcfy3+GHLqKTIhC6cMuYNvvx/awvAQQflKK6SgkUPgeBBIy0KCgMjKj8Qh0Qg78hWOsEePzZAQCPxBkG0aj23/b4Ej5CWWHcoSW1WFqHdh7GPHaaIjHom2B2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rqaXn6LOdv1VPuWN1KMNH/zZ8c6cLLrXB89Gs9F4SY=;
 b=G1FpHeY9If8xo8mVmZ5gm7KKMgtkvltccpnF8FmCNZsxO9eZjcothW0D9mMFybe4gtNljxdME31tqhCVsQGdRaSfHzeqs6AlsIZfFdwAFt7+BL0+XcnaWcsV0KuosEQId7O43nN9h8uzdLniGTXDQ7Cy/YosfnSYq9mTL5orS8n3PkoI7XCDDcHEUDh+SEE6yxXnt2WYjH4IRa6Jvlylf+GUq02dQ9LSKctAcJLmHjBLPc2THGbXeGKNFVFe4Fv86tk2FvSuWsx0BDYwbMQp3yoKhDwtg9fYKwGfPA55wGbyRPpUy6+KkiZ8J7m8uRXZhivCKyVHrD0WalMxRV0eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rqaXn6LOdv1VPuWN1KMNH/zZ8c6cLLrXB89Gs9F4SY=;
 b=Aqy9ZL+ThGMbvH+bKFyG9bpgBusuP7cCzpOlaXZ1+GxwcM++a0CLYjYluavQk5j+tbnHZA1iQOxF6OCw/FKej8N1GR89Wtc9THWo4aiyHuufFtE4CSDGWJhx+HXDas4j3oZP6dkGJHC1F2Xnv8seabl+85bU8BBTmj6o0mC+alA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5879.jpnprd01.prod.outlook.com
 (2603:1096:604:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 08:50:40 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0%3]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 08:50:40 +0000
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
Thread-Index: AQHYwPb10WBUW4aL8USUjKSsjeOuO63o14qAgABA65CAACd9AIAAbCOQ
Date:   Wed, 21 Sep 2022 08:50:40 +0000
Message-ID: <TYBPR01MB5341179B666B4B85D190E892D84F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB5341A75BFA6AFFCF59FA4502D84F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20220921022204.GA1154967@bhelgaas>
In-Reply-To: <20220921022204.GA1154967@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB5879:EE_
x-ms-office365-filtering-correlation-id: e72345a0-c9e1-4636-469f-08da9bae5c85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Je5j4VlIDuNfZQTi2xsyjA+W9S/q3AMrBniC0kHobZcZleA18aq/0/ffa5lHMQ78HuvdHkmQzS8TLxO/LIRoHlpOzpZzuGta4yG8ZHmW0v7GUP7fgqbRV3BNmfEB0gRVZc3dkz/4uj/TgZQw84ACgvx1Euo5pT4CWX5lkMTH/lHcuBz4WpBD6TxZUEizg1+MinMgeQt56FhWhuVPqMaTbkeyyGJZFvfD1xU6vhVld3mURwEANlhprjVDmxpzrViAJeGsMK/VkfhXuDwgrgnItk6UWSAmFe+2fJvMbgzY2EHGn4cm5eBBxqtjZmUw6hDo8brB1BoaK08agu/CawGKi6WJ80rx5bvc4aNWQPS1oiG6YVp0g4HALai+6LKxZfDVa11alXEp86tmygO0rr9Lk0YiVWzzbeF9O72QI4yIpgtmYe+RvXV2RHbAmH+XQoh1GCvsA7fPN0+BlYIFp1AXxPsaq0oRlUAiv/qGiHmy/mZFu3El+MEL1xeeUNKxY46sAiVM69GYVeWkPm1+bUvge40xFr2Vd36oB0t5EOsQa3+A1QVsO2RLf7GE1VP5kC3hUNRwoHweJMIgYmut8/s+1/vyIU0c3UG54Zdms4sg5hY5lZXxuqHQulVpA6HHJqRObQH38GCpeSWwh8Io0C9onggVNoLB9RjFfoVZUbc2lvVmEtZeYuWdPkEFQwDL8o+9sNlF0DExQNNQQc9JpvgUUXXrAcRWx7dDd0a8bmC42cDMJiGe8lIYEsJ85dgPhpIGXE9YQc+YgpxJ1hfrgOZtOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(8676002)(55016003)(66446008)(478600001)(66556008)(7416002)(66476007)(66946007)(52536014)(8936002)(64756008)(5660300002)(6916009)(54906003)(316002)(71200400001)(4326008)(6506007)(76116006)(9686003)(7696005)(186003)(33656002)(86362001)(41300700001)(2906002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aj0dcmvGRZtcBy+gjfdmMZ3hxjSP2b9BpkqsORL72A4fAD36n5jp/+PIHk/v?=
 =?us-ascii?Q?eqYsGckJ/xDyNC2hrlSV/GrfkjlSTau0cnND3JHO69rHAr5Pf5wZtvPtfiGr?=
 =?us-ascii?Q?zbHAVnT1YD6W9ZHEgFuVv6p3m/OOERBo5Pwu2qhm8+xIY9yF0nk3knJQFP2f?=
 =?us-ascii?Q?gaBH29LaUBa6p5oL27+kyL/qmtrOxMu8wJ5KlWpm0CLV2PH/I7CDhFYUGkiU?=
 =?us-ascii?Q?LwbPZWlSd6gkUc+OHdwHImTPAgWyVD90Jl5weyU16UXMYe6R7oqEJI2w780x?=
 =?us-ascii?Q?feVsrwX6jb5d5KYLgfzxXqm2+UC2TXvOboFc9fLfOV2bkW7YPsqOpzaZZNuU?=
 =?us-ascii?Q?6Tbb5hK8nd5BG4TZ9TOv/6kPYt0L9Q/hlM31sC3u2JV3HJJyQa3FpHGYuIN1?=
 =?us-ascii?Q?qjjDJ3TEDf+/4GIUZOPxxGwdal+yG4yjK0jUOKXd1WQORmrvoHwMQMtgJKJo?=
 =?us-ascii?Q?TAjpDJEHe6zdLz+QObWCTkQaLF6EtAIzHwCJjucSPKxYv4DNkVnowTdiinPt?=
 =?us-ascii?Q?Vjsz6CxR76tv01QB3Vdu2kIFEGHz7Zzd7vyKxBi6alcXdgj5s+FwGHbq7vHK?=
 =?us-ascii?Q?HQqRsCDX88K2gC43tBFcOU9iVw96khm1TI3naE7A0uA3BP3HVk0zCm3sU9IJ?=
 =?us-ascii?Q?6ZVjq7g73ihW8W2ARDThdrrFsgb1BfRUgYmD4+6OSffQ09yZLvd/kSLrlyHd?=
 =?us-ascii?Q?yoUrWJ3zMRuN5qp61KDTjSOWXOrUlsLp41WwhOeFsBiaWgYyWLeyirrrxmWH?=
 =?us-ascii?Q?treDOA9tiqPh0b3nBi13ujywlPjvQzS2JVcfm1eZJkDDP6/wF87fPQIgWcNX?=
 =?us-ascii?Q?kk24Svk54R8SjRKa9T6F7ccHTOv3c3iUWmdhrXLyhQRGhDChmEunkUsc7qKp?=
 =?us-ascii?Q?KcExNmM0KN7AsY+sMFMTOi+6H9qPJzqUdge5R2Ew7r7PGD7J6Dvtu4Spbrgt?=
 =?us-ascii?Q?7/x5PP0HItgkuDd1hlE0pPdw/V8zGilXu0OtQwqKACYTdbrZ/b2BHefmiQ5j?=
 =?us-ascii?Q?Q9umsPCahwnh3aGfYsPIlvvwc1HSPEhVs/1hkabsZLH4MJAI/swdq5YTMffy?=
 =?us-ascii?Q?EC2h2fhinEMs5Mh3WxoDAByfRnnsJmAW1lhmJAzcs7A+k05CGjo6TMTo7vwG?=
 =?us-ascii?Q?I5l3C3VK3hvGK/S/FmPMMxLgIBY0adn3SYoqyS3K4Ti2GRI02oYHV1Yq7mqA?=
 =?us-ascii?Q?QCU7Y/Jjw/OnjJKYdxENrBXgxv5Mu3yiIFihI/gwposzGxJco9+gLEE/9DR7?=
 =?us-ascii?Q?KzwN62YE03gTw2dR2kFiIeYL+SEr16UDNqp+Bh3Un2aYqEMEAt/OUHFRzgFs?=
 =?us-ascii?Q?dgKX0TiAXeWWrwxVuaYAir8enCky4FSeOQQw46o7Y3/0hcUX7GsPzyHfGYma?=
 =?us-ascii?Q?GrqE8PHSsrH6IAOhf6FK5nVHk9fZ+MvYSEvZSzHgCNjD3bpo5IoGwq6tfOlH?=
 =?us-ascii?Q?S+O+Q9tOfjn9Sj+SIU2mO1qguls4TzjEOx6UeiKLrBLYhn5wLpOOyGnXLvfk?=
 =?us-ascii?Q?ZoGaKUIbnZW7HmYYISEkVHPOrXRbXAm9fF9kKTr5OhBKeZ7eGCwMYSYiVVZW?=
 =?us-ascii?Q?y7it/YOWEPBhp4dj/hOlFUjNf5x/DpF6umOz7/EFP76UWPb9DnplmSwDinc/?=
 =?us-ascii?Q?g5cKWEM8t1l2lkaPHyTBJD04zPAYLslUrCHppBllImOqurhJiDSniRAnOdAV?=
 =?us-ascii?Q?BWkrnw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72345a0-c9e1-4636-469f-08da9bae5c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 08:50:40.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOkqWMWd8HtCfzsi2rm1NjjSuH9uG92QQrmLRuL5y5RlENaGEUkJak3N4RkvrUgCdxCFN8vgqQEW0dRQ3iOlQUzp1xl+IWHgtA0jYvPinMFKg0kXMthjHPlp1Ke5PKvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5879
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

> From: Bjorn Helgaas, Sent: Wednesday, September 21, 2022 11:22 AM
>=20
> On Wed, Sep 21, 2022 at 12:05:26AM +0000, Yoshihiro Shimoda wrote:
> > Hi Bjorn,
> > > From: Bjorn Helgaas, Sent: Wednesday, September 21, 2022 5:08 AM
> > >
> > > On Mon, Sep 05, 2022 at 04:12:48PM +0900, Yoshihiro Shimoda wrote:
> > > > Add macros defining Maximum Link Width bits in Link Capabilities
> > > > Register.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  include/uapi/linux/pci_regs.h | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci=
_regs.h
> > > > index 57b8e2ffb1dd..c9f4c452e210 100644
> > > > --- a/include/uapi/linux/pci_regs.h
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -538,6 +538,13 @@
> > > >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vecto=
r bit 3 */
> > > >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vecto=
r bit 4 */
> > > >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vecto=
r bit 5 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8=
 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x=
12 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x=
16 */
> > > > +#define  PCI_EXP_LNKCAP_MLW_X32	0x00000200 /* Maximum Link Width x=
32 */
> > >
> > > In PCIe r6.0, x32 is mentioned a few times, but not actually defined
> > > for Link Capabilities.  Has it been defined in an ECN or something?
> >
> > I should have looked PCIe r6.0, but I looked PCIe r4.0 v1.0 and it ment=
ioned x32.
> > So, I wrote the x32 macro.
>=20
> Sure enough.  It's there in r4.0 and r5.0, but dropped from r6.0.
> Wish there were a git tree where we could see whether this was a
> mistake or there was some reason for it.  Maybe nobody had actually
> built x32 hardware and they wanted to reserve the flexibility for
> something else.

I understood it.

> > I'll drop PCI_EXP_LNKCAP_MLW_X32 on v6 patch.
>=20
> When you do, add my:
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you! I'll submit v6 patches tomorrow (or later).

Best regards,
Yoshihiro Shimoda

