Return-Path: <linux-pci+bounces-1959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780FF829245
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 03:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE6F288441
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 02:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C61378;
	Wed, 10 Jan 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PgNmX3Da"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886B1376;
	Wed, 10 Jan 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrYO479GjpTltLu7J21phy6doYPc0H4jWA2K95ER3OFEjwcal6uKPhrhQuFVpcRDYj1qO21o97y1NQn2OwYwWBeKANLAdPd55R/gQkD+PffeEb+iicfPs6yZKanr+ROBCdX4R/gVnzYtKdVIdS0/fIkQRz686KrAVfgoDhnS5sXd/6YgM/nah01+a1TQ/zSuxkGtHjVSAMPzayMJLniSbgzfdlK8lUm/ermgdWAs7uxN4hYqNuXb6Ojs9SVdWDwBiXsnWZs6xB7qZDiX3Kd2jTE4J+fLxUFljAL2YRxuKuX/QvLOGHu4l3vGATQlKLyKgL8A99mfX5op+mep+BkZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pglft+Bpg36wayQq4s5E54uJh60nAr9Ekh2EpZeOOrw=;
 b=oKznVM6YlAaInl0pwn+7yzHsH1enjqHcie8yFiakOuOj0GUmgR2vo/MBgAJL8m9O/S7lAsGn9Vu2fd6hdDnlG7ugXdW2HZq8AMWxuggDufXIG+C3UjQhXZXUQEevNbZSHRIwycHVRqgs/zGIRylrv5DedF3N5sBjIyCPZNCD5N2j/dtbv2kTVru6DjR6z1GBL2Eu0cmVnQbxgI5bsZbpbTIdNjjmL9hqCcyrmaCn1C/dEXhj1kxmM04Gr9zgi9wE7Qdft8pElYVngNYgdvAl5xdDf73nNKVx/M2p4FSvCo7yizfxXSs3m+nciKKI7kxA4DJWDQ6PzpOOrVKLVCx9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pglft+Bpg36wayQq4s5E54uJh60nAr9Ekh2EpZeOOrw=;
 b=PgNmX3Dadr8MElHh1/YV3GGPOkz8u9zSB2aphQehhVtNhTo785mp9I9bpGbr+aCadPlmbZK+8JiyjnBtbTaUwLyuWPlzzia/ZwjCy8GWkgpwu44XxUeXJGUneeiHzn6RpDD6R1BIy7FGwngxtIPrvp4TVMpQdV8wZ45JBf3bkwg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB10356.jpnprd01.prod.outlook.com
 (2603:1096:604:1f9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 02:01:58 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 02:01:58 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Serge Semin
	<fancer.lancer@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "gustavo.pimentel@synopsys.com"
	<gustavo.pimentel@synopsys.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Topic: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Index:
 AQHaMwbKcxJp/gf9MEupTc95qiYVULCyShaAgBjaDqCAATfbgIAEc9uwgAGAHACAABskYA==
Date: Wed, 10 Jan 2024 02:01:58 +0000
Message-ID:
 <TYBPR01MB5341F3CF2F2B12331730755BD8692@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References:
 <TYBPR01MB5341FE0273707AAE4A9F92E7D86A2@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20240110002152.GA2085796@bhelgaas>
In-Reply-To: <20240110002152.GA2085796@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB10356:EE_
x-ms-office365-filtering-correlation-id: 8c42a9f6-093c-4ac3-c05d-08dc118020d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z41+RGB5ITVWlCoHku1h42G3lMNUByywHWAl6yP0DIEDBIhxGJvNVJSRYTVAVPlRzvJ3B0XNzU33YK5vwnJXxh8f/G6caa7NPe7vO5uZd/aJnboyXYP75CZmDylQUB73S9aIIPhQN0s1xx5ejU5egQDlfpHzXZW7MoKvepLrTCPb6NkY5ihoUNjmzBd+wngLEDwLPtwuJq2x0pULBUZpfFoI9RwT5KFs0tLC19mby6YhXfK7/sD1u9agqmD7NZwJC5ilcIxxrSU2cLL7FSoWTOLCDEbFBBAZgAO0rb1XUWc1Hb6fR00S7hRm2A+dZjFX1D2+Xwz1Pyqvprel2FR5TigbXQ4WICAtFOJ7hqC5dVrxxOR0HoH6Vz22XeX/N88L0MlpRQ0veXkVT1JQW6AOzP+SLj+Ur2S2Fy7TGn2ScgFoWFnhu21LxtOausrWJndo1weJXz+UKETPs4T20mhIBGcPqqdfwQ4B2kLyznqedapkW1g7cljn+Vl1qKRi4pMJwaxcFUa4VY+SdFFk+3l0wGW5/i9/TLuIcbbC0tDjxG+GqhUJv8gXxPh0fpnHON/mWzxyIoR1YWqfNuBdkn+hhGQYYMTR82/L+Ciq6NK95Ew=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(4326008)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(2906002)(478600001)(26005)(316002)(966005)(54906003)(66946007)(66476007)(66446008)(64756008)(66556008)(6916009)(76116006)(83380400001)(41300700001)(122000001)(38100700002)(33656002)(55016003)(9686003)(86362001)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?yqv6OkKEq0dAXVzxk1z4jWxpfnl7EvYo9RG7PQURIMQjIYuNH4U43StK4G?=
 =?iso-8859-2?Q?DK+44iLuPYR1HHL3VpjFmSTMMmumtzAblusutcHiJKxX05ypeDgtnVf1X7?=
 =?iso-8859-2?Q?0/VeRd6o4pD2JNdZi7UQlacY3lTDj4d2zafwAW+PjhGe8zpUNwakomTl+V?=
 =?iso-8859-2?Q?ojcOFNCtxCEGRWd+yIBhewXzXNlj1HuXnaLeRHrWaISoJKOY4JHCIynxWN?=
 =?iso-8859-2?Q?KlOqUOrw//tfDpUfS6Xt7jmE5lTa5Aluc70uENskmr51sbPqEmshW98eVH?=
 =?iso-8859-2?Q?U74V7V6V4crZaWG8cnA4pQsoIEoBcfQoiv7vAytfAhgAaQr2xx/hVa899z?=
 =?iso-8859-2?Q?JkB5KjUOfYGFCxOGRuDU9rw0YX8DNwVcbe1KcRZLPlPshCrU2F1piENuzw?=
 =?iso-8859-2?Q?H3Fm2bHUIiPIUhgelh5V8pFnelCT4ET/eyBhp1I1Vz0NlQfsfblOG62BTC?=
 =?iso-8859-2?Q?kZRNphVnxUU5ORXvOGvm+kRerZNl828xWBb8MAoWZU8OBA5CDXN++99eG8?=
 =?iso-8859-2?Q?LKurRohCVP3NwumG6ujGfQX253DvXZ2dR+9UDMllPSnEu8XnLwwfBUz/UH?=
 =?iso-8859-2?Q?Jmw0OYxY/D9VSYelb/N+5Q1qFApsn4QKw9LRwcBJwM7x57VL0L7rpSa/lO?=
 =?iso-8859-2?Q?ew0VJWpf3H4VIJCF/AFh8pCZO2bomqZrtTQHB8zYF4dARYFP1YezfBuGiO?=
 =?iso-8859-2?Q?3fzV/V4lkPr4qzC3Oyg9eW2HPuRE0TLcm38oisNKsrW2tQAE1ZZ3+UGTk9?=
 =?iso-8859-2?Q?JbhgnO7D8HO/YNrgHh7MogR7feWFBES2KrEgXVMQ7XkDjFdhNZYrWn5pO1?=
 =?iso-8859-2?Q?t67WcrSDTM90hc1u5nzPVCc0ZSnlPYn7EPFrGZILlfJPvmY5ZxZUDAnifq?=
 =?iso-8859-2?Q?SK6u58Oo+/2ZCVxv/BPBduMA/TVLkSuBJ57nLerqxP8SIr7tPCfaap4V9n?=
 =?iso-8859-2?Q?6IrBNBx5qpapxwGRTvhtxzgJ/lMWXQtqT3GXQsxWMcEzcNiP+iRIBkFmJb?=
 =?iso-8859-2?Q?qMkbkD1u4vKynoe+Y4Js2DJjlcWj2kEUOAACPK3GXAn9pqrpz51DW+lp4V?=
 =?iso-8859-2?Q?91M/MGNLknmevhx2e79vrwZuWWBvvM4bFtlU8hCcaMCaMoSWv1rLRmmB/r?=
 =?iso-8859-2?Q?0D/XDVttD+c4+wqn7WC5SLNkgvFy1+ZHyvyVTDe+JNg73mMGv4rKPPql1q?=
 =?iso-8859-2?Q?Byr2/d/yO+rP74TPVZG0JQfEEBBczAgHxaYqZUXGT2OeNvFufizOWq0Gus?=
 =?iso-8859-2?Q?8CegIugb59MU2Jab+/zdl8CnIURaUHFYHkavYZkx8zorNrKKHJe2Nqym17?=
 =?iso-8859-2?Q?arZXfJxbl95+sD2AwGpBdDNKh0Spc+c4DhT+GKkymPplAAqphJTpTuFPwl?=
 =?iso-8859-2?Q?E2D232+h8k8HvbVoC14p/F/7HuoFyeN/OVxFIrBnvxkC4x2L4FZ63CSKfi?=
 =?iso-8859-2?Q?7+UBl9Ckx2/SMk592tn+wDxa25Ob1ajJhPZ/SKknzrfhHw+V7z3n6jcMVN?=
 =?iso-8859-2?Q?SIRM23ZINeyr29h0D7uTIKMJekU0yfpzDTbbJF0hMQabqJHfUWKHjGjlKE?=
 =?iso-8859-2?Q?lEKwQMAKiYEbRsyPkA+G3iAXJ2QHUsPYM/RFsoWvhAJdyVoPlWp3Awq2IE?=
 =?iso-8859-2?Q?3mC69ohGgCkeZ+Yc/2PZZ99o9fleUqa33BoR/Gw8XZQ+jSLKYAe8b4oGMK?=
 =?iso-8859-2?Q?5u/yZwKoPmeKKILyuRs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c42a9f6-093c-4ac3-c05d-08dc118020d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:01:58.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFTFh+qynkhHqCWaWsA7nF8JwdKnE/AaZRv6hjfJeG0vn35Gmo3YuhSZD67uayGhfesMLiSj0k2MzyHZQfHntFCBf54zfOhFpefU+EsOF/Ix+/7O4vU+swtpJldxaS3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10356

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, January 10, 2024 9:22 AM
>=20
> On Tue, Jan 09, 2024 at 01:34:54AM +0000, Yoshihiro Shimoda wrote:
> > ...
>=20
> > Now v6.7 had been released. So, should I resubmit this series after
> > v6.8-rc1 was released?  Or, would you resolve the conflicts for
> > merging this series into v6.8-rc1?
>=20
> No need, I think this is already merged in the PCI "next" branch and
> should appear in v6.8-rc1.
>=20
> If you take a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=3Dfbfd=
b71c8c79=20
> you should be able to confirm that your series is included correctly.
>=20
> If it's not, please let me know!

Thank you for your reply! I confirmed that this patch series had been merge=
d into
the PCI "next" branch correctly.

Best regards,
Yoshihiro Shimoda

> Bjorn

