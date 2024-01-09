Return-Path: <linux-pci+bounces-1860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BF827C8F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 02:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871101C228B6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 01:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E610E4;
	Tue,  9 Jan 2024 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="KVda5fYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3620FB;
	Tue,  9 Jan 2024 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htx/pjOjY50ITCCLXVI/X0V7qSRZMG/2rl2xh2OPVJaHkwD10+lzgNYqgG19QZWxcgXlRf7jZRLLBgZpfHoXfGKhkM4DfCLIHWuXrrnAgb4DdmVFngSw9zpqvQCVC76wN8TmoF+ZR1DSiFzmymI8hl0UO3xdSy0+qdTzWMHJt6o68JQAcJ6YYeesDi5e0jvPOE17IKLrzMVA9COTFlLLmtHJnovssT22jvatErePjgOmdiYYjpeSc15lHLHCEMRKUj56L9ixnW2+0a7hzbZnp7xTj5mqUoTD6+VQSvk5/5ow0p/1pIDoOmuJ7TpO9ELyRUGZfTucGUNezLRCYtQTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd+GOP3pK98JBFAJnJjUOAT7mZQHpIKsO9FQJiJt6Ns=;
 b=leFnm8QLzDcnfXEFyO5VKnB/Yo3TKv2o1cT4L+CbINfw7yCRS+89pPYEepQzmOoYfNpckqJl3FzY9QFHsCbf6KNS7f36NViJYFR+tpdVigl3qFcw4cmTcH+jopqq4Nbq9dy5XkDUrbNToJN95MHLfE6VUM5zeV2kwFy/qawkLZNFGRrfXt8di7Bju1moVr1hvyAhXi5s+INhIIACQE8VkZCo6EXtO6j+rv8vFVQ+IhmAr0qq3xg2UHC6x970Q7M5HBF6D4TpY2xdiiVqmKtYoUqLtgtMc+cGAA2fuGpKQnADH81HsS/Ahei0+SfJW6i0l63OSj0asbFLamMeKu+VjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd+GOP3pK98JBFAJnJjUOAT7mZQHpIKsO9FQJiJt6Ns=;
 b=KVda5fYRfWEqLtA4teXhKPWIVS23Q2ci8YFb7V+Wqdv4HhX75gQnydUFFnm9jgKDFkGiCS6F5ygtcypwQdVUf0/GQpJpf94C1sEoPtmP0quW9vpFtQlquShzqW/Pb7zqQFUcPiMZqLUODzFAYrGrgd8aPHuhLkFusrjGTkY8CP0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB9999.jpnprd01.prod.outlook.com
 (2603:1096:400:1dc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15; Tue, 9 Jan
 2024 01:34:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870%3]) with mapi id 15.20.7181.009; Tue, 9 Jan 2024
 01:34:55 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: Serge Semin <fancer.lancer@gmail.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Manivannan
 Sadhasivam <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Topic: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Index: AQHaMwbKcxJp/gf9MEupTc95qiYVULCyShaAgBjaDqCAATfbgIAEc9uw
Date: Tue, 9 Jan 2024 01:34:54 +0000
Message-ID:
 <TYBPR01MB5341FE0273707AAE4A9F92E7D86A2@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
 <fgnz47aqndjyn2y4u7jhdbdagtarwaasiekajavmxolpmsdu74@plhasdd5z55b>
 <TYBPR01MB534178CDECD712FE68F8A446D8662@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20240106052723.GC1227754@rocinante>
In-Reply-To: <20240106052723.GC1227754@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB9999:EE_
x-ms-office365-filtering-correlation-id: 7ceb01e7-f3cd-4850-e3b0-08dc10b32ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GFnu4LZTQJR0/DVRp+ZOfa85Fqvwfzk9bYz+zC5o/y29Ss2S5ZZ0Ry/FmSteveduETBKw505nLuyX5JIxAHn+t33Po9AcJqeZdhJFjLAwt1Cj8OjU72kYepwv/x9UjE9R3b2Ujf6CV+xTVleqyXihovTOkxgfIxKTHUhMVoKnwA/7rgR+DfABy4wROEFAgDiySTAKD2aKy/uzV3iWkpluulk0WZemJu+CWv5+3+YzprGe1pGYqXuZ8An35Xl3nvElE+t4vKQsYsRsqs/Fbts9ucM+Hn2ID9Lqd9o4sgmuGGtOIdKdxFAZSNeqKoNDvG93tayJW1rNrp9ZJR8yik6rvnJSX4Khdo3rD++Y+rC1TnxVJgV2L25c95JjysjACK61GyacvMtpeccAsV/4BSO9M9vZOrRYnuXtT3SmFv8ePErA19YYB9Zwprs515VXsFW/u3jxl+VH9xzgiX81gtbZatRPGBkJocOFK8VcxQRhRTpclsFWHtl/6OkV1bZCcmqDTFx4TlBDnKxloVjF0Bb4yjmNnrdw4XlghuWjTxgKFjCvrVQvvYvKRINLFjCkSbh0o9F+RxDbjdy9iasNRj8jcnbYHi6Hm7S8tFGEL5J9Ss=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(9686003)(966005)(71200400001)(6506007)(478600001)(7696005)(5660300002)(83380400001)(66574015)(41300700001)(2906002)(66476007)(66946007)(4326008)(64756008)(54906003)(66556008)(6916009)(66446008)(76116006)(8676002)(8936002)(52536014)(38070700009)(316002)(38100700002)(122000001)(33656002)(86362001)(7416002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?rva1+0r+/RbG8gjfNZ/AnZqI8GGdzVAALs+c9JdCW+Q7VpqOGEik6Am85v?=
 =?iso-8859-2?Q?4be9Lc5vFDQWnO6Ik6it02gaYkIWnya9x7jcJWsSRt73euwrTzebO4QLvX?=
 =?iso-8859-2?Q?X73kr4iUSWLPpMLS4Y09SYves9Cu7YSYDtg/3W/LofEwFbuDDwzGtl75xg?=
 =?iso-8859-2?Q?mA13yuseqfEWwGuwSRB4ZnegUosRmee/CKS2iJSHuB5f+0W7niojoqOJHq?=
 =?iso-8859-2?Q?etka2PMyKiQ2+Q7pk2GtgCTfLmvOLF/bksSe0OZl1z5+DOaa3//Fwdoea/?=
 =?iso-8859-2?Q?fs3iYV3PibGNOdqPqpWdB9tcL4sPpZez4Lx5Jgf2z3fxkWOouow5myRH/Y?=
 =?iso-8859-2?Q?x3hLsNfemQtmxbYaHaZ/JKNnPGi+GJVz/5UDio0yYsh8iHjV6ksqjAMgeZ?=
 =?iso-8859-2?Q?BB3IZikQrbd8l0mObBJr6okbPoMoJ/dB1WWMixHmtAWlVyYhuaVKn5g+8G?=
 =?iso-8859-2?Q?s9th4+oxuoIZTHpKnOrAVW3NP85JFWee4GLQB8l4LMdXwEPLseWx6hiXNp?=
 =?iso-8859-2?Q?r8uo1r89RcjkTugwNnY6HCOE9bxHJHJRy/h1D1dGOW1cL+eQXYHDbNIyiO?=
 =?iso-8859-2?Q?K6/BKe1gLqZjJ+g9jjFOTfixs28xId4uEit5hN2u+9ZIRgbxU0MMrdtYxI?=
 =?iso-8859-2?Q?s244R/wyVsq7OptkMM97E7DrbF8ZC/Z3xB5TPW4YiXudkHokUONn64xUk9?=
 =?iso-8859-2?Q?qHp2l/A/g34JrT6XmYBOPOUs1LhKykoAbjWzuJG5mbV1MoI+RearHwRhgz?=
 =?iso-8859-2?Q?3obqP1fcofn9mMRipPTuZ2kl5GEhbldR7lN7rxWoKjmX0zkNBQeB2HvDfy?=
 =?iso-8859-2?Q?HYUhMbuDfinJmPQ4NJF1zjeVqN0bA09ZTYgJ+t2S9TIK+obQFVqI77vT+g?=
 =?iso-8859-2?Q?r/cRlIxi6YKmjaOVZ+gqPGhRdXfabd8hRI49UpGORQ4o8HUOxKrAyTsuXR?=
 =?iso-8859-2?Q?m1oX36Z3tlwWtk91f6g6i7cmwfbCrzjDxf4O2lLQDILS4slp7hJ1N25+G/?=
 =?iso-8859-2?Q?ry+HumNf5Mwauk1J4E8JEEqUaqX1AcR+36eBq72nsxcn2kh/ZlGjDw8lUD?=
 =?iso-8859-2?Q?JPtD1RdWGbzG24c8VNpCdjapvqpl2/cgVLagiRe4Fc5VfwlwaSt87pUwWg?=
 =?iso-8859-2?Q?/kt/7gQL7iueUERyjaadXx8rhMePBGY/QMxPhpBEUu8UO9olvs/l2rIkhg?=
 =?iso-8859-2?Q?FgJLCMeDEsTWHACb94nnaQ9Nl4fsoSg2bJG2uL77+wEdFH7FLjS3lam/8Z?=
 =?iso-8859-2?Q?0fgWjqMMKMxk8K6YDCADHNoebUm/y84EroU+EqtjMdDcCHSWR140HriOv/?=
 =?iso-8859-2?Q?J2cpARoF+u25aN7tIYadO0xW8aCxprzP/vM4WXtRSSkX0QnkrMhMnSrk+p?=
 =?iso-8859-2?Q?qm0Q1wFqAVyPSl04OUdmqZ5fdotsOBLGfo4eWB7fPjr66gZYImzMaQpE0r?=
 =?iso-8859-2?Q?IJwdM+IoW6zUS4C6wyZ++lXwmNq4agWFKQEq5f7d7rC9omm5CPcVEWqhWt?=
 =?iso-8859-2?Q?Y5M9KeD1E5dyp4s/Pi0q3Ug/ksgXDSiuVAOzQN2A6vbxMs1NC9KygDdmwb?=
 =?iso-8859-2?Q?4EwFMmH5gq6kLh1LGjMdeOjcffsbWofhc6Cyht0lxwqr71Epc62Ip4qwlN?=
 =?iso-8859-2?Q?49+lpc1ahwxV/OquzSbPVRT0ln9AwhjbEuUP78JHrTQjhy/o3VyYTsWw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceb01e7-f3cd-4850-e3b0-08dc10b32ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 01:34:54.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NS/ztReD+etrbbG+zY9hHT73gIv+OjZ9JFkuP8cEfZzZ/XDWEjS9nLWycKU3BnyfvoBlXoR5ahG+3IDwe6b6F9pShrnHhBrMeHG4+ziUvCPZej1UJqHC67mUJop2PBM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9999

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Saturday, January 6, 2024 2:27 PM
>=20
> Hello,
>=20
> [...]
> > > > Changes from v3:
> > > >
<snip URL>
> > > >  - Based on the latest pci.git / next branch. So, I modified the pa=
tch 1/6
> > > >    for pci-layerscape.c.
>=20
> Shimoda-san, don't use next when working on patches.  I might have told y=
ou
> this once before, per the following. Something that is easy to forget.
>=20
> https://lore.kernel.org/all/20230828160712.GA2127814@rocinante/

Oops. I'm sorry. As you mentioned, I completely forgot it...

> This is the HEAD branch you should be using:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/
>=20
> You should seldom use our "next" or the upstream "linux-next" when workin=
g
> on a series you want to send to us.  That is, unless someone explicitly a=
sks
> you to do so or the changes you wish to submit to be applied are simple.

I got it.

> > > >  - Add Reviewed-by tag in the patch 4/6.
> > > >  - Fix locations of read/write accessors by grouped for readability=
 in
> > > >    the patch 4/6.
> > >
> > > The series has got all the Mani's acks. The last nitpick was fixed in
> > > v4. No more comments at least from my side. What about merging it in
> > > (before merge window v6.8 is opened)?
> >
> > Serge, thank you for your comment.
> >
> > Hi Krzysztof, Lorenzo, Bjorn, Mani,
>=20
> Hi. Happy New Year 2024!
>=20
> > Would you apply this patch series into pci.git / next branch?
>=20
> We don't apply specific series like that.  Bjorn will collect other
> branches, and then eventually update our "next", which then will be
> picked up and the upstream "linux-next" will eventually include it.

I got it.

> > I confirmed that the patch series could be applied on the latest pci.gi=
t / next branch
> [...]
>=20
> I appreciate that.  However, I now need to resolve some conflicts to
> apply this series.  See my comment above. :)

I understood it.
Now v6.7 had been released. So, should I resubmit this series after v6.8-rc=
1 was released?
Or, would you resolve the conflicts for merging this series into v6.8-rc1?

Best regards,
Yoshihiro Shimoda

> 	Krzysztof

