Return-Path: <linux-pci+bounces-2327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA02831F1E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 19:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D171B230E0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F71C281;
	Thu, 18 Jan 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HX4iepBs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FpIj8AqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E72DF62
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602827; cv=fail; b=TyepYL7iMVcldG/7w6/Kr2OAlVg215zr6BiqZA2uP/m+a4CY41yB7bG46qY9ieYM9fqSVUdcXWcOJ9+MQSdpiJh2q8Nx+NsBUjKdsSJ9Yn9f611qgdfksvnnXo0HWGqvxkrwDnnsEYxqfFJ5MLqduCqblxiczUS5kjKTGgOExTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602827; c=relaxed/simple;
	bh=87c/xi+5aYqqRDfX1AHjksNH5aOecqRChyqN/Oxu35Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxTRl4MsEVuVohVytrjvrcFIDLP0fzWXaeBtrV09JatIC7HhvXNV6P9UkDrbiRE9T2x79saE8LojrJgvuaQXtiFe5CwI6E3rX2mQSGk9U6a51w+jbmdPBn/4kCycohsvjEAo9Bq/du0HDv2oJFB+oOI5JPs8FrqRv3AEF7emQg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HX4iepBs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FpIj8AqL; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705602825; x=1737138825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=87c/xi+5aYqqRDfX1AHjksNH5aOecqRChyqN/Oxu35Y=;
  b=HX4iepBsEA7AzCTx/EWCN2WnoFquGn9jp6jozaRFpsH755eTiUV7fXkU
   F0wquIbnqTMMXfMoiLQKBXxoW1L7U2YSy7GCvsEt0vaec9ucIqTTtxb5h
   9nga95feJoaVOqWkSj82frSDoMrWbeHiAqviWLuv5QOpH20o5e5kBUgzW
   KpfO0uGY/s8wLG5uCyBcFWhpSZK0yss2pIyXdebLtHeBtNZdcvgveXOyv
   jdj+Ym8bikayGHalMnHbH1YZhnnlTQMGoBjzP7A1PnwcQzviRQn9pMn2Y
   xqOoMfdnzy5PEs2qubTwGUYsgONStmFflrfEC8OjzXZw5IbI/r6HvC3KP
   w==;
X-CSE-ConnectionGUID: 9ll/p3U9SrCtbBMMpaAhxw==
X-CSE-MsgGUID: xIDE5x5yR1iMzsHu4lGFGg==
X-IronPort-AV: E=Sophos;i="6.05,203,1701100800"; 
   d="scan'208";a="6947856"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2024 02:33:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIbHOjGdMLVmprFeQfXZOmKknAMoqNC8UXNIATdz4McWXus2yeEqQVTePdx8Ghc0ZAaZk7WeIU5x6CI707lptmMf3QT7Odi2EPeRMtaik4vtewTcyaFK7fPKNOtRsAGICb/KmC+Bc2mKTrwi4GU52S0Esu2pOjUTGye9Kas8FJPl54yScoAAGHxKystf2LluPA+FsHj3YxbSfxORlUCJx57Z3X4YGheVyIX5iaMdheVpaeuLLZ9k/ZOdsEGEwqcfj7qvbG1TnxDanM6F9QKYG6sSN03j9gxVq7D/v/vE2WNgjjC7+p7/v9p/svXhvC0TNGjK0r2g94ZsgmGU6Bs5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wR9q8ZNZuJjCHnZTa7jK5p1y5twY4hLLdO2r8bt2eI=;
 b=HjK6Fn+wc3OhuWGoTighSw0jpP0CamUDqz5mg3SyQcS0Vf6aOHgiLY8Rw8DEE5ctvs16a1M+qa8CBuI7hH3NxhIhzFB8gpHMDFbYnfQWbWlq8tP9glpQHHDQ7aFBOX0UiYShqr0pOg36t8OFTV3/Ukxfyqvd9z9b++bTXM1zoU8uZPui1lrmoAilWTYYvZN/bImqBm8mriOx5xvdWfWhFfcGxEgrFFNyA5bfDbOECjKJ2Bd67uuHMODbpZkQ0rMZ96mKzQkrOTPNr2MnMos2BGDs4lXw5PEZ79x3bgGFmQTkPrpcjWZsMsRk0m81FH9wb9UbD5xuOQnnCaTnxKw6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wR9q8ZNZuJjCHnZTa7jK5p1y5twY4hLLdO2r8bt2eI=;
 b=FpIj8AqL4ieJyQoa/lRd1BjCzc7Da5cA2jZBwrIIM6IuMAAkxa1kSvxVa3Y1LmFshnGsPFfSYYinA2t63vgf7KzMF6DWuIITvY4XG9XENtZrZgtvTJtyaKJ3Wrx85rUzWzw0HsEItwSANdXRMdsgktGDaLlsfRYBrltje68sEWY=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by SJ0PR04MB7856.namprd04.prod.outlook.com (2603:10b6:a03:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 18:33:35 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440%7]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 18:33:35 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index:
 AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCAgABGvQCAAAxigIAA60IAgABPfQCAACtvgIAjWssAgBbgVQCAExQfgA==
Date: Thu, 18 Jan 2024 18:33:35 +0000
Message-ID: <Zalu//dNi5BhZlBU@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon> <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad> <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad> <ZWhwdkpSNzIdi23t@x1-carbon>
 <20231130135757.GS3043@thinkpad> <ZYY9QHRE4Zz30LG8@x1-carbon>
 <20240106151238.GC2512@thinkpad>
In-Reply-To: <20240106151238.GC2512@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|SJ0PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: 988a0f77-a596-4427-7682-08dc1853fb56
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4Ay260MG7K4XvF/0jCPkQRCvWsMLzhNtb0dGKwUPRc4Pi9eVzwrL29iZY/tzPZtogQbE+WTyAZto1yzt9964bjJy8nXXnIJSklRQgrvhgzP+3UbCThAl0GNEWYnNgzBpP+BcHMe8k5cKrq8RjOvlaEpVQmLFsEPXSgFMHyOTZqxUjZuYga4nKHZm7D8qWHRkCrys9tzVf4lS78aiodTDxHFJl9nmSTSC6tMqSIYJYHg8hRuGAqIkRSFmh6i5fmSvjoxLa1bQ+Euz+SXcjG+hHf9gnr//PgVDPYhHD857CsC3x98npEAacX72NIOXMkNe79nYEcKKWPsHCph165+nJX3F2LIaO2fWoPTH0uiZHc4gJgfXQ501hOtPcCUPGMX4fhE3vl+c2DuHz6iAv5NWegTIOvaFQxmM/MZakXkZCc1ecMcqaTSzzzBzBUbGZ+/jA/AvBQZ0fklebsRKkdN6729JUMIRU7hGy1KieCdwpZHPDFkoFGVu+nhFAtc9qTlLRG+FVDxV/3TjsMgqAxDKpBfn+tI7j72sYjbqZ5UpTxgwtJsnVXl5FLvBaQls9Aq6sOflx34FrV4jsYZGhgZNc1NRIcv89ASB0KMCaGOEtBofOLXlC9wBuGGBzKLKzP3u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38070700009)(41300700001)(6512007)(9686003)(26005)(83380400001)(33716001)(82960400001)(5660300002)(76116006)(2906002)(91956017)(86362001)(66556008)(66446008)(64756008)(66476007)(6916009)(66946007)(6486002)(8676002)(8936002)(122000001)(4326008)(54906003)(316002)(71200400001)(6506007)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1GHKbwYEFTydFDO6GOGY1rFPPKLNs9rK3YmAU+K1nCxvwym9qsw6/TByMIOn?=
 =?us-ascii?Q?U5TiO2io6woo91i8VVfMI4O+M40cJF4Cvpu1mCbaomwwqkMwTafsppZXXDgL?=
 =?us-ascii?Q?2w03FhEmJu92Ja6v4ER/u7VAK4gEpkb9CO6BVNUhMK7/tvGY5gJEHlBhi4ZG?=
 =?us-ascii?Q?eqhuJCSb8RmgJ6dIRYnGnKHfQLQQbLQyA8D56QIlByMF4rp4IyrxGD2mOV+5?=
 =?us-ascii?Q?JkvFtyC2o8wQZVE7lIHBIAgo1qD0QyJAx/OEhRnSnEMxt8VFHXwXLOojclZN?=
 =?us-ascii?Q?zUy9xbYx0hs+i37J1w0iKPsgGRvm/NGMWOzJq2INuSde7MI7xKqjCSvGvla4?=
 =?us-ascii?Q?OPMbDBs+ofC0o2bvVyZ0LlLAnMUbfUBxvJEzLB8yQVzv9kiWy9m694UVddoP?=
 =?us-ascii?Q?LW8NVBEOTIpDnXPy/QjnPH9JMAtqLJj6tFIiYYMWfrWY336Hg2ts290pMfqZ?=
 =?us-ascii?Q?giUAgFg4p6ymkJraldoslWC8xsbtUUo9Yl/T+ABk8dDi2WEdFk2Wi6Vrpldi?=
 =?us-ascii?Q?yOoRIgdI7hYyVYZQACZN9+SnkH96CKX5TmPdDSHDUe+9290IGASVlaGIfCf7?=
 =?us-ascii?Q?W0aakLWpJvXdalB4SxIn0qZfdmWm6+pAQiOu424iakT5zlJZxLx32ah77rR7?=
 =?us-ascii?Q?p4VuY00iTrM9dye6jog6VuVRxS9jitXZt/db96Oj8yUW9f3eNIG1oJ5tnwlr?=
 =?us-ascii?Q?CDmzh8jHMUpETbY/s00PMgJofBPdAzz+uFot3qfrBkT+ZRWluff5ZWlgnhSF?=
 =?us-ascii?Q?jAFjURParH6sKD3KJ+gbXuXDfk0R2QIT8Ca+fseqmeH1GBjJMj6J4tkhpQCR?=
 =?us-ascii?Q?qA2RXImw6Wu8F2yQtbFwin84Rb5JZ+DW5lWtlRFIcGuCOZtNE8a+oYNUOAkf?=
 =?us-ascii?Q?clgQ4OYq2z0hSuWZTsPEjJtCXmop8lD+6s2DNm7iSkm4zm2QLTm8PMb4hL4/?=
 =?us-ascii?Q?zHaNajH2hJ/LY/4GkMN2OZ+MD1Pz08NlyfT77CaGci9Dph7DUf5fqmuLFrFZ?=
 =?us-ascii?Q?Z05ZNnLJkSkklOAIlz6ZUFYI8HvFV9wcZEJY4/VTbpd1rUfha+A7mdmD/Sx6?=
 =?us-ascii?Q?TsQoD7aLFskqzeWn88sI53YRZRlwH3DgOsFH3Vrk8bNmJaqsGADX/wcH6I8K?=
 =?us-ascii?Q?IjIe7iw6DeghXnsau0zuM8Xm/QaGAK3g8ET3kg8B3MsHNcnbe7yZQORSLtAW?=
 =?us-ascii?Q?8kLOV2gQMKGVbPC+sUG3p6XbeVHrj7+uSm1pbrgX2pu/byGQkMhq5vQMMXdy?=
 =?us-ascii?Q?L8N4KRQ3gCB6MpzHTM5PYcHJ+XcUZz5+kz6/9LgVUvykkjlIAHFi3LvoQsbY?=
 =?us-ascii?Q?BxPSoNA90INDAzBUml+O4xLwBdboqTWw+pKnMES/uahBIeIqmWzplC0uyOIm?=
 =?us-ascii?Q?yyi9/QwR7Oi6lMJScNTQGyfq4NfPBe5RufT+adcltP2s5eZWgfW+m1tXyPcO?=
 =?us-ascii?Q?5n0H83GA+cRhVziGGoDU5BQfOi2d6bD1Um0d1/Z8mfvd/T/JQ6dcdXXp1YWS?=
 =?us-ascii?Q?6HtS66tbO4832HpgZeXSeiBciUTdNSiil+1CjLziJ8vihHQXEMp2NcRY12Qd?=
 =?us-ascii?Q?0kJeyYOh1u5BYs3AYmgzdZKS6preTathzeWepNiALZYlF297BtsdH8s3C9Ac?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <846175DEBC7C1B4F9727B5066CA18745@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ggUzZOFmne+iXMRoH8rUA4mYfVg3CxO+uLHlzHLPPiKj0KlnrO7+sqtyhpRvsqLHAPXM5Mm4aSYSdPUEUxnAEG4qno8OPNUvYQ14fRSsxFwGgiIGvIm5JpMtq7NWNAnReAygc5AmKF/AMGeOsfXMWehQ+cFX0WlCfT+XcbB/r3IX1OjE4zAsKf4CT/qedfxPxDHfqzb0/c5x8FXGpjsIlQqPuaU+lvw1LyCaYLDoqogjgO4IEVXvnDh8fXXA4gti0b17Ioo4h8XeZPNrz0XiQPorty6ETuP6EIpecU4+U/jgnd7Cbe4OMhGVi4h1L0YPUwD3+Lwv4909spQ1VvF85UAbSiNg9pc9S1rdUd5cyYRi3YIqZY7ZKtXfhZiR0/g/l6am3YTssGEsVTFSqKVY8tx+cA3p8B6UjtejfdLoGUabi3EzVQPVlwcQdq16EEv78mJdShD1J1vv2e8qX8ZRvI6JgoHZTZiG7Rg99kcZzqLT3/qgcwTJflSGuVE0Nqm/AY4qQtecgMs6LHcbOdIZuiNbtIMPi3MQQxmfibDHjcOeVl6IWqJ6vCK9+uJUITlOwHomX5ypBnMr4fQXLIUxZ13HZEBOeD+Um7R23cMd5T51xgr6KWJ4kgdugZbcpWa5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a0f77-a596-4427-7682-08dc1853fb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 18:33:35.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrPz81hACpd96cRMl9SaIE/r6L0y0Y74qIlKl90uJIUmcN+rKAI/5LIwu/3VpYprh8VSCiznLw78g/R6wwcfCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7856

Hello Mani,

On Sat, Jan 06, 2024 at 08:42:38PM +0530, Manivannan Sadhasivam wrote:
> >=20
> > So to give you a clear example:
> > If you:
> > 1) start the EP, start the pci-epf-test
> > 2) start the RC
> > 3) run pci-epf-test
> > 4) reboot the RC
> >=20
> > this will trigger a link-down reset IRQ on the EP side (link_req_rst_no=
t).
> >=20
>=20
> Right. This is the sane RC reboot scenario. Although, there is no guarant=
ee
> that the EP will get LINK_DOWN event before perst_assert (I've seen this =
with
> some RC platforms).
>=20
> But can you confirm whether your EP is receiving PERST assert/deassert wh=
en RC
> reboots?

Yes, it does:

## RC side:
# reboot

## EP side
[  845.606810] pci: PERST asserted by host!
[  845.657058] pci: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
[  845.657759] pci: hot reset or link-down reset (LTSSM_STATUS: 0x0)
[  852.483985] pci: PERST de-asserted by host!
[  852.503041] pci: PERST asserted by host!
[  852.521616] pci: PCIE_CLIENT_INTR_STATUS_MISC: 0x2003
[  852.522375] pci: link up! (LTSSM_STATUS: 0x230011)
[  852.610318] pci: PERST de-asserted by host!

The time between 845 and 852 is the time it takes for the RC to
boot and probe the RC PCIe driver.

Note that I currently don't do anything in the perst gpio handler,
I only print when receiving the PERST GPIO IRQ, as I wanted to be
able to answer your question.


Currently, what I do instead, in order to handle a link down
(which clears all the RESBAR registers) followed by a link up,
is to re-write the RESBAR registers when receiving the link down IRQ.
(This is only to handle the case of the RC rebooting.)

A nicer solution would probably be to modify dw_pcie_ep_set_bar() to
properly handle controllers with the Resizable BAR capability, and remove
the RESBAR related code from dw_pcie_ep_init_complete().

However, that would still require changes in pci-epf-test.c to call
set_bar() after a hot reset/link-down reset (and it is not possible
to distinguish between them), which could be done by either:
1) Making sure that the glue drivers (that implement Resizable BAR capabili=
ty)
 call dw_pcie_ep_init_notify() when receiving a hot reset/link-down reset
 IRQ (or maybe instead when getting the link up IRQ), as that will
 trigger pci-epf-test.c to (once again) call set_bar().
or
2) Modifying pci-epf-test.c:pci_epf_test_link_up() to call set_bar()
 (If epc_features doesn't have a core_init_notifier, as in that case
 set_bar() is called by pci_epf_test_core_init()).
 (Since I assume that not all SoCs might have a PERST GPIO.)
or
3) We could allow glue drivers that use an internal refclk to still make
 use of the PERST GPIO IRQ, and only call dw_pcie_ep_init_notify(),
 as that would also cause pci-epf-test.c to call set_bar().
 (These glue drivers, which implement the Resizable BAR capability would
 however not need to perform a full core reset, etc. in the PERST GPIO
 IRQ handler, they only need to call dw_pcie_ep_init_notify().)

Right now, I think I prefer 1).

What do you think?

Since it seems that not many SoCs that use a DWC core, have Resizable
BAR capability implemented, I will try to see what I can come up with.


Kind regards,
Niklas=

