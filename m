Return-Path: <linux-pci+bounces-925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A084812544
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1A01F21920
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE026803;
	Thu, 14 Dec 2023 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XPPUpWWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AAFB7;
	Wed, 13 Dec 2023 18:28:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtXkZVB2LT+GK1s72+cfW9davwBqj4+xBV/EnszLC7WHq92H5tYW/dd7oUzqs56YNzqLM7DZGrDS+v4bIX6C4qR83t75JZQAEXwj4eYsonKAidkZtEft/bG0BfJa3o9CRExBpuqF9h3aYjg1YZ0dHzrstAPFVQhSa9lH7ce4zguyYu7xBjGi+uuUkq4evxOldogw36XiPBbUxFgta5C8RjK0XJTOdUi2YHjWYconqCJ0g0DQ0t5aqgVaIqKodam9sD3qzOc0Lqv9u91LYkbqDKO3FRla+641bhDcUBVo0NBIQm8OsViuXOVNeREfTxECK4pC5IyYegW8KXZwhoPR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiVsDSFtN7dIafs5Ghtu+Ud1/dH3ss9M0gbABos3MbY=;
 b=Aa4AtikUhJfGWERHZz8OhWsA2t0FjRmO/idufkTaFkAMAQouCQy/SNkm7LSWiwMf4C4dPupUt5HEdkxlQgQvVrJZFD9B5RAcS8iDLhuUkOKjXWl5T++8c/18U0pi6xorr37xOulKiYt/DZTAAiqyTMAQbFqaHLr2HQha9832T4UM9RTHZnk/Yxb+ayOItLBhuniLdLfDRo6CfCjptZsR9YFipHxSvDUjRnpRkKgqpZaIriZ/FHcgxhkBH+MNnNrT5mzfCA8o4bqLXPi2ePz4iHbxrtyn8kSBfEi+b24p9SzRoXeuob/2GmWmJ8NBYCLQw2Xtxc3bZX5I7zbmfBsZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiVsDSFtN7dIafs5Ghtu+Ud1/dH3ss9M0gbABos3MbY=;
 b=XPPUpWWdamO7PPQeV57N0rU0EnOnASOfccVZUr/EOO+IyhIb+WDEB7nLJN7muyTApVFFsdrMD0nntOwUzsiYTM858bUaE/jfqEts0UsBLMOLrhFXmBGX/1wXAdqqob+GAGb9vXOQlfi3d84PbUy557JIfyRq8Ov4z8I3GDM9Umk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB10938.jpnprd01.prod.outlook.com
 (2603:1096:400:39e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 02:28:12 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 02:28:12 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>
CC: Marek Vasut <marek.vasut+renesas@gmail.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci: rcar-gen4: Replace of_device.h with explicit of.h
 include
Thread-Topic: [PATCH] pci: rcar-gen4: Replace of_device.h with explicit of.h
 include
Thread-Index: AQHaKS3WeiLCWj9RKkmGuwuZnDHiF7CoCKkAgAAN/RA=
Date: Thu, 14 Dec 2023 02:28:12 +0000
Message-ID:
 <TYBPR01MB53415F2C51CB51A0ADFBD278D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231207165251.2855783-1-robh@kernel.org>
 <20231214013316.GA1462914@rocinante>
In-Reply-To: <20231214013316.GA1462914@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB10938:EE_
x-ms-office365-filtering-correlation-id: 08c1be37-75cd-4a08-ddae-08dbfc4c51f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PDO8NjqiU3WFMSNuZgIDkyWmC/lbFhfoMMX2fuNLufEmIrXueXj6payXiYBaP5P2gNH7xCsWF1eTE1H1zbPbiqTnCrdKxTANQIYrbPpq+T8poYJx5jowvbskdEFA++Nw+SAIEOi4twQ7AvGaRAQU/p0N5x7dz4JQZuAsUatUbGF3hENuvQl2VBIiLVWy6FU29cKGMo02aHWPpHGoD9nBmcrMg/nGhqYfRH6lvG6gFqr78cK3yYnfpc3+bd/dl1wWMq+fzsmZgZEh6qpeppp9cZ0LHvAiUqFm+MJFrwGcI4HYjK8toHoKi92xHbl7YOUH+xjMW2rmmFNN3bdmQIWnEHi/U1tOEkx9gvNssXN17Dn3Zm2S8PSi6Lr5I0sI7Exz5DkPp5MgLkSa+1cAefMNXwj0fvMk3cLnAp0mBN4/EHpkykOEK5l8AobyubsahMYW7TnKVk0sykwq9F8xYtQdCXLM/xidTaTyIYjc0zTanMhe+857oMbs7kWDyVUTMaH7+T+xSb0VQwRscak4MVPGVAGCT2OLfhRhJovkP4J8qTE3kfgJnL2AtLsGOp/izD+SpBj0kqX+0WpqOnPzXhZCEALzG6lzKAFH/R8vwp2uGpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(122000001)(41300700001)(38070700009)(5660300002)(33656002)(2906002)(71200400001)(66574015)(7696005)(6506007)(83380400001)(9686003)(966005)(478600001)(26005)(66476007)(8936002)(8676002)(4326008)(316002)(110136005)(64756008)(54906003)(76116006)(66946007)(66446008)(55016003)(66556008)(86362001)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?9Z9WG8m+IXwiwKYLmspe60kEJnJtdQ5eC5lBFGkxHnE2iHAajlBtHv2A8f?=
 =?iso-8859-2?Q?oiQvE9dsRNBB1xQQBhcVPEJXttpwXQuR1Kj07KPmnmEM3vz7w58k5wbcbS?=
 =?iso-8859-2?Q?fclMF5umhN92juKcACrBxetLhBYxL+TrFgBHlhSYCO+1fyI7WoRaxEB7DX?=
 =?iso-8859-2?Q?FWzE4O9JBJcMYa7wTdERvOxbINefUcPMOdHcpDVj2ZpEbuvzt8hv00Uhni?=
 =?iso-8859-2?Q?rU6L5Y+DzYu3sg8jUqKu2PFwDmJKd/M4LG2R5ZiOXjt++oc6cY2J9GHZil?=
 =?iso-8859-2?Q?cUOpRffGdu5e24BhIzwL65rzvvWTQ3kPOuqnHYe7HqyOSocItrq1OEphY8?=
 =?iso-8859-2?Q?DyWR6MGaqQ4lGpX5WzIoQVPGOglOeJdzU3CHg8jZcTMyytWAa51T5YQ2lW?=
 =?iso-8859-2?Q?OurGVY38JlVpgDypEsRn/ivZn4n1JA4ijtdiEwV+mcJ0tqVQtBtNOWku3k?=
 =?iso-8859-2?Q?4PvJrWYaB344m4saYmdf6BSHNSs2XJ7AvWE8ypGhrgC9knAG2PSkO4kHe0?=
 =?iso-8859-2?Q?oaDAg/gfT1vn79KxZ6Xu2LH+b7Wc6j/gKwsvjZBbaPUSYbMTLU2yfefKoP?=
 =?iso-8859-2?Q?u7SB36+fMRoLfOLlUClcQhMQdoKKj1WLgekShw9bh7b9vhY4YGkoGm7UL+?=
 =?iso-8859-2?Q?Tv2Vfo95BMBGP5Iqq6tcO2I/sQwQitnimZzgLTAZ8iy92ACezinO3A8cc4?=
 =?iso-8859-2?Q?KyHpAhukxaU7k672xWkLRSwP9BMbLRripIn6nu0zNRdnpdDZXATGCnWnPu?=
 =?iso-8859-2?Q?BYLAXiHvm0J0ZjX8lMgKsLeaV5va++0g7LnTU3HUntLG9YJQUcpGYgXf67?=
 =?iso-8859-2?Q?cTkGXkXWeiSmPh+EdrYtyYzkfIf8gBeGfZs6eykKHOvqtbXK+sCmmDBBUj?=
 =?iso-8859-2?Q?zHJvQHX0iHlTYaT3kz3ShPY/NE4EqEON17IdJFd4k3FtX3mR0USeIK0sF6?=
 =?iso-8859-2?Q?0yGMy0a/jukH7R72317NCmsSk1XgH3vPPuUCWFD4JfiaVTo87VET0rehlR?=
 =?iso-8859-2?Q?a5X/870Nrk3umjm2YR3NZoPGVewiPCw7nvMHdFsMa8xajXioIrISfXAHKO?=
 =?iso-8859-2?Q?MQt9XsQIxrWrJzsICOvKn88Yie0dZQcNMDh0BY7FePcoE2MNXeV+HijOT+?=
 =?iso-8859-2?Q?M9IBS38tYntODcvOT3w6gSWg/RJLKpsiMQsgTVuNexlV+9MxRWLXQ0Hw85?=
 =?iso-8859-2?Q?1ADLWRD8zS0ewDwD2GOOPzcxyeB2/IM0kz5LHOqC15oPq5OtHLt8/rT4f1?=
 =?iso-8859-2?Q?e8h4tyG404xumjbkgITkeLc1KldiWqevNMDvDnTuO0xVkDctSl7TTRC6jp?=
 =?iso-8859-2?Q?swI057Bqf5saXf/GldxjeynZtRPzw+1cQPWCFrGF2RE/ayckh6Nv19m1J4?=
 =?iso-8859-2?Q?/3jmXfBRNzcbOOnt/G9prx8MyS0P07hLEwWxhEOuEWSWFmSNMw2h0dGtRi?=
 =?iso-8859-2?Q?Kq3zyKAZRwSczb3f+y/tsYFH8FfxekmR0OA2MAHVpc8ExtDzbgyL7OmJvq?=
 =?iso-8859-2?Q?GmMckR9ZQQSP7DJVihKyT2vVs6oQR8y1Bv9YOO6W6hVE4FOIbBAWgLxutj?=
 =?iso-8859-2?Q?ibp4RTjGXphbKdRybcG6mcT+kYsGknYK4h8AVfochYAuycKVIjC4QoNXrU?=
 =?iso-8859-2?Q?itCxfyhri/sZvfM2YVUg+G/DtoC0MhFXcGCRrLbkcl26SH4okwAy651JVE?=
 =?iso-8859-2?Q?CZD+50fr6xWJ5AjGghA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c1be37-75cd-4a08-ddae-08dbfc4c51f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:28:12.5138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsELz3nunmpN95vMFXYdjBJ+sFt84njZJlPVjP6FTSOguIvvci11/EZtujwXVr3tER244+oysJGlmF1GL0Cm/LAPSHjAZzs5vTJCN4O8IgUs+bUarewfiNH7ATr8Wm4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10938

Hello,

> From: Krzysztof Wilczy=F1ski, Sent: Thursday, December 14, 2023 10:33 AM
>=20
> Hello,
>=20
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it was merged into the regular platform bus=
.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
>=20
> Applied to controller/rcar, thank you!
>=20
> [1/1] PCI: rcar-gen4: Replace of_device.h with explicit of.h include
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=3D=
263714f5fcf8

Thank you! I completely overlooked this patch. Maybe it's too late, but I a=
lso reviewed this patch, so

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

It's up to you whether my tag is added to the commit or not :)

Best regards,
Yoshihiro Shimoda

> 	Krzysztof

