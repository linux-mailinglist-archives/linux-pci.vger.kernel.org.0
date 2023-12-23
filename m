Return-Path: <linux-pci+bounces-1311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE281D105
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B49E1F22FE9
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE68865B;
	Sat, 23 Dec 2023 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="isvbNDbu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RHxXkE//"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39CD26C
	for <linux-pci@vger.kernel.org>; Sat, 23 Dec 2023 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703296325; x=1734832325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ah6wSrkC8euburODvN4JNl4zC9OzoBRKTqHdL3Va5Ro=;
  b=isvbNDbu820dQ8rZjitsPiKVVVLz12pl1/jOAzle4Hkqr4cAdMZ+gLRi
   Ub466dKsnUWSk/VY6RZDGEhwC0RDo7032vL3xYa/z6p9UVQxxwneceJCn
   Aev9sf63ud/FQ2VHLbRJT2oJTbDc9qujaXF9bxZnqQxUgF/V1nnZp+PjD
   GDLx9VSKBZA416HK5Ugmg5hIzf1PXHUXXm25uPz7wkueNOFAUfxd1a+OT
   aBXQJuUy4n96O/D6o/umD/ERglRCxb37AcWnjjxkVC7A2/bJLBT2Pr2vr
   wQesEVejYjFWM29d2hE6TFarl99iUYyQgcYEerobXbcK5zs+XPjjLqbFt
   w==;
X-CSE-ConnectionGUID: KBipkGIBTOmnXXdQIP2Jtw==
X-CSE-MsgGUID: fxkah75bQGGRiiHxIBdz2A==
X-IronPort-AV: E=Sophos;i="6.04,298,1695657600"; 
   d="scan'208";a="5524725"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2023 09:52:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC2JnV+mqcZjLLXWGDIXwM2kiUo8IJUPEHpVbvyedtdOuLQU0EfCRhsJ74zBUf0XdUtPbmCDvW7SboXKOtpxCZz3+Nxlaq8laJLOid1n01p1d4Wbxn1pYYlhG4N8ipmkl6sy8y+5fRwgMabDmaxHJxMFteHYlFkDk5YDYTAtLx7GVKthQsE7yePhEbwQc4Ii7Ynb3+EJNai+39qvLPv1i509opdQwv8Xqnh9xnFcB8g+N5PTwd+aantYcN4xHEXlyg4YYhwfZZiMbhzr40caN/EfK7YLarh4vcQbY4O0C+RtV7Z5AEHUlaKncuP2zxzOZmXBDy/hCjzfPEe/yf4F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah6wSrkC8euburODvN4JNl4zC9OzoBRKTqHdL3Va5Ro=;
 b=j4cchL8m+0wer3cZztDBxv2OOmK9tuFBdsjfoGnIp+p7X/CbqRmgZXRfziZZ9OWlXrpUAytulOQo4BbCHF4CobSp3rECi7QhjF++hpusds0V4GoOEN5LFewW0lBnKYM1bkHYZWxB0vg8MzNTVFeTbGKBMmv9Slsc2rEhE7fexpYcc/rl73Eyc5mojk3ZReo+ZrgwQQ1FlnXWwbidPgmJLko84B1yMTq65wvAsGQBy0BM1JqvEsIeRh/Z/wJs50f+IskV6BMLetf2H77woholS+BQMcvWyXea0iBdUEbNLM9O3xlF6XZdli3IVLPPwJqxhc9DIrGBVgDg4vVKSbduWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah6wSrkC8euburODvN4JNl4zC9OzoBRKTqHdL3Va5Ro=;
 b=RHxXkE//C4Q57R+T5qUxcM+C8fJWIAgbQMxYFzjl53Ka8qOR3oJqG1A3GhHYGDaCnEoT+MeIBnsoRW8uA4+RDhSXSM5iA1fl1dxIXcvtQKDltFOEdaT8IfNbR/1OKWzqF7/Ln4hpW2A2dkZMthfUmhcVbKYVW3boE0i9QTZuRxk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7903.namprd04.prod.outlook.com (2603:10b6:a03:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Sat, 23 Dec
 2023 01:52:02 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 01:52:02 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index:
 AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCAgABGvQCAAAxigIAA60IAgABPfQCAACtvgIAjWssA
Date: Sat, 23 Dec 2023 01:52:01 +0000
Message-ID: <ZYY9QHRE4Zz30LG8@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon> <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad> <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad> <ZWhwdkpSNzIdi23t@x1-carbon>
 <20231130135757.GS3043@thinkpad>
In-Reply-To: <20231130135757.GS3043@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7903:EE_
x-ms-office365-filtering-correlation-id: 2c730ceb-faef-454a-d72e-08dc0359c1b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0XmP4g1dqBdyehOU+7fPwT//6YU3eUVuA3/51gMYeADwIylna6TLZvBZrZO08KpW3dm5Xcefsx2tGkyu/7aA7zWb8NRW9/xMkLcgJUWQLnPjMJ5107KFLBS5sKMjq7RZxiOYy4S1HFNmafpFd1KHP/BbqGYv9P35DJfhq+Vk2t+TdhkP9Zzr6RkAUzLgvboq663xXu8pQH59LJR2g0Asyz8hdbrCQUYj5FPdovSm7PcPiyQEenGtxwBZtEjY8Dgh/3U9kF4ao2/UA4XFwXlfggJ/08hK+M2Oj5Yh44u9IfHq20xtY3fFJL1R/Irh0p5ei6SA4pIMu/s0hIyghBfiF3LmNIIaC4SvP7y8i8Fxp2hyequYH2bx8bjn8bNGskvTIMLGoaRGGNei3CLL0891yx/ayUBNXxh06IRwVLaNWPtcosB+tpCcHWNBaq3d1Qr7w/IrVW6oWtpg74moh8exSYUlMBqFy6roPagwHF2UfZOuBQDC0TL4+QT9PYSM8yde4P8XEeKrDvshyV9NqiZxv41MIuAkP0hwyHZWxyiyUQeFiqulsXNBCvzh0/xBks2zA7sF35MYI+x826Uq4MkUvPpSt4wEiPYVlpUuIJPm16j0AnWGiDTqPNm0VkJcGyLQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(76116006)(122000001)(8936002)(8676002)(91956017)(316002)(6916009)(66476007)(66446008)(66946007)(64756008)(82960400001)(54906003)(86362001)(2906002)(33716001)(41300700001)(38070700009)(66556008)(38100700002)(5660300002)(478600001)(9686003)(6512007)(6506007)(71200400001)(26005)(83380400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3fHZ3wJ0nVvmXsOVnBFyNx8ms7t2Xv8g+dRZ5Ys4H+HyYD9dpdVkuZDBFm0f?=
 =?us-ascii?Q?RSnYyYii6LzoJtZqKVNQLyRkl8Hg2CG6nAmIaQHwUSLMHd3v/+iaSG5TlQyA?=
 =?us-ascii?Q?elKSQyT5qYls1O5UwYmF9L3r2qtFGnn0HV3+ye8gqjmAYTHx+ocwHkvP4Q2Y?=
 =?us-ascii?Q?ngzwR8vCjHOl+U2INpOJ8TOdwoo/TaVui4b08ahnvNuWX0FOfreVTdSjbmDt?=
 =?us-ascii?Q?DUvTUF0pHvdLylZB9UyJEFcqd5FUenNYF9zZrjiN8O9W+hl+Y4AaKBypEUhu?=
 =?us-ascii?Q?EwC9M9gMmu/t3ex54d1+Eu650nB6/GsvpIjsYvd64z8UQc0R1dIk8cPhWmZ7?=
 =?us-ascii?Q?mjql5kvK+MtUeeQ+hh9bhZDgIFFIjUw2fXaBsjUJ5XEIDdjChr6vDNncdCTI?=
 =?us-ascii?Q?mxyJTlJhTU8kT/qaI9p66Uktz6snnTQ1yMfn2pRVFbCiYlnxH6bjcDlNAbNb?=
 =?us-ascii?Q?IHEPFnNAN8Hm6gf9uIX3vzqHXIwGSdNjmMKfebGlK/BdoMCkjJlk80bP/GXF?=
 =?us-ascii?Q?NSpI5g9y2T//jLFPh0c1dzChTIt6Sn0puYA/Jjoo+4u+MU919vOFjLbw1Fns?=
 =?us-ascii?Q?M48xgAUT4TtqXoNslDRcLJNbRa1LVUiFVFA/Cj5aG6NwTqMQyQmFVJg09zPS?=
 =?us-ascii?Q?HlnqH+T3eOwkKh2jBUePNAv8yP+Uz/0PPxqoa0PZ8xPENveHvMktDSi+zPZz?=
 =?us-ascii?Q?ga/cMm8IVnPZpx6j+UI+IeL3fD6BrFuy/AnIuPRNOpbLSYXpFnLfh1DTcsg5?=
 =?us-ascii?Q?AmKyrBZJTBsc7l2wbTtbXfuMnG5TtCiV+BTKvqgBPaD8FO3q35UP/EOTsxoj?=
 =?us-ascii?Q?NPNQj37SLvpz2mXJ3AwB4MG6OaLG+fuFkPgAUgvIGTRz4mKZI7mhhUus1L/X?=
 =?us-ascii?Q?O4QVyG2n3Exh1oj3guRDtbbpkbC6rEnIU5T6sTrwf36KZ7L14dRsyLJfzbYq?=
 =?us-ascii?Q?tCylpDVNVduFHvyL+xdkW+ozxSZYpSFr01vUsNwfdpaIUyF4ITk8RO3Y8Ga0?=
 =?us-ascii?Q?qxddsO6FV/5amRuN/iQKa7AG/HReyjqrC4cAb50sH+fcxa+D7kGJAjWamXrZ?=
 =?us-ascii?Q?johPY5aBofg6t6fRcsGR328AOnkswA+GhSBOKNsDmi6FB7jCTLhQLNZcj50K?=
 =?us-ascii?Q?VMmGOQ0FIVl6hRCDajOlzCvAS1KxoNtZ81y1rBQOmc/4EcNunH+xxCra+rqm?=
 =?us-ascii?Q?goUyAT3uF5ViKbLB6j8ZJ5mdMQY1IE8Y96ZyA0GO3ptnduM6EUnGLaopmLzV?=
 =?us-ascii?Q?CIoas5tT2nGMG/lFA+d2onEU96rx9woSGQJs/LO2PFkvv1Wti7KPPkVroh0v?=
 =?us-ascii?Q?vnfhgVTIH9duxpg04D98JdTbMVWgH7i5oJ+gpT8v9qPRPk468SycfVur8vDj?=
 =?us-ascii?Q?r2ndtd6i8r0mrLtb9vSHdKL9OHlAZLjgi+o7PYT0DzGntgXMDZMl7M5so24I?=
 =?us-ascii?Q?tNzSKjm5W55TXO6Q5lu6QCJqXPnqZsKidcpZuoYJl/ulGcV6Fs5AOdFdNVNx?=
 =?us-ascii?Q?FJHcnKTpqNjuHixSLu6LQa7tKzZoPW92rOh8SryZQQyggOjCpvrwchGg5oG5?=
 =?us-ascii?Q?TGRCiEpuiK+bx++rrdY8ADFnhUmm7y0Y0KLzEtnYOcU5Kf0mbqsQoiQIrbKp?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72ADD7F741234E42B906E66044A0C800@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w91yDozx5wCzajHU35ZWQ47It2gtokCrehnToLy+wRbykjsGmyh/Guxf6xK7qkzbLsEX56U+AfyVwYyP66XkCs+5CRiSvwgQYeD7fH/5blvehh7PQu1gYjMz+WE1QtkD2bOlJisoe2X0ISiMAT0ew9yoVA+Usk6F9EUFIcvBKbK1SGzNoP56jTIzjlZq4KYTHxoZEK36eW8XsjgjvUj/SlhpZL5kRNKvYvDD9UYTHVRHBUMqLreG7HL+KHzAD4Kl81x5hKnTb+H2MLXxpPIuKhgBcVayGMmq1k1+juVJP/t9rM/NlqZlad7ap0rbwykunTR7YTJxMSQwfqpDg82KG6lHAVjzzrAu1tGClfzVWYP041w+L/VbNurk1u/veH3VAzLZCD4MitMsoNOQywv2DjvJ1LVTB5bIyZwNga83406q2jQgtpiLbmjGdYaUL6G3d0OpzrxD5t3CRBG1DhlDM4An0EIkdEB4efuMFXNBp/Hp27gpmPstx9dlksc3D2pAgo2Ipt+ai+6ca7PMIcG75apP2AQEzyoZxjmgzUmQPmnkf4S6q7yGN/poqxBBMM9MQn8rJjE24QIzlSUi9BuUUtjOsXrgarpF2ifa5Hb9g9GuqgG1BBBCS+TNLL6GQJl5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c730ceb-faef-454a-d72e-08dc0359c1b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2023 01:52:01.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8qBKmNPahxmSbClr1rGgiTwPBZXOdwvAGPCaTXCvuvFZrIpuBHgbAY1sIUiY3OSwKcrofxR+r7/eBilL21HNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7903

On Thu, Nov 30, 2023 at 07:27:57PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 30, 2023 at 11:22:30AM +0000, Niklas Cassel wrote:
> > On Thu, Nov 30, 2023 at 12:08:00PM +0530, Manivannan Sadhasivam wrote:
> > >=20
> > > Looking at this issue again, I think your statement may not be correc=
t. In the
> > > stop_link() callback, non-core_init_notifier platforms are just disab=
ling the
> > > LTSSM and enabling it again in start_link(). So all the rest of the
> > > configurations (DBI etc...) should not be affected during EPF bind/un=
bind.
> >=20
> > Sorry for confusing you.
> >=20
> > When toggling PERST on a driver with a core_init_notifier, you will cal=
l
> > dw_pcie_ep_init_complete() - which will initialize DBI settings, and th=
en
> > stop/start the link by deasserting/asserting LTSSM.
> > (perst_assert()/perst_deassert() is functionally the equivalent to star=
t_link()/
> > stop_link() on non-core_init_notifier platforms.)
> >=20
> >=20
> > For drivers without a core_init_notifier, they currently don't listen t=
o PERST
> > input GPIO.
> > Stopping and starting the link will not call dw_pcie_ep_init_complete()=
,
> > so it will not (re-)initialize DBI settings.
> >=20
> >=20
> > My problem is that a bunch of hardware registers gets reset when receiv=
ing
> > a link-down reset or hot reset. It would be nice to write all DBI setti=
ngs
> > when starting the link. That way the link going down for a millisecond,=
 and
> > gettting immediately reestablished, will not be so bad. A stop + start =
link
> > will rewrite the settings. (Just like toggling PERST rewrites the setti=
ngs.)
> >=20
>=20
> I got slightly confused by this part. So you are saying that when a user =
stops
> the controller through configfs, EP receives the LINK_DOWN event and that=
 causes
> the EP specific registers (like DBI) to be reset?

Sorry for taking time to reply.
(I wanted to make sure that I was 100% understanding what was going on.)

So to give you a clear example:
If you:
1) start the EP, start the pci-epf-test
2) start the RC
3) run pci-epf-test
4) reboot the RC

this will trigger a link-down reset IRQ on the EP side (link_req_rst_not).


>=20
> I thought the LINK_DOWN event can only change LTSSM and some status regis=
ters.

link_req_rst_not will assert link_down_rst_n, which will assert
non_sticky_rst_n. So all non-sticky registers will be reset.

Some thing that has been biting me is that:
While advertized Resizable BAR sizes are sticky,
the currently used resizable BAR size is non-sticky.

So a reboot of the RC will reset the BAR sizes to reset values
(which on the SoC I'm using is 1 GB...)

So, there is an advantage of having a .core_init_notifier,
as this will allow you to reboot the RC without any problems.

I guess one solution, for DWC glue drivers that don't strictly
need a refclock is to just call dw_pcie_ep_init_complete() when
receiving the link-down IRQ (since when you get that, the core
has already reset non-sticky registers to reset values), and
then when you get a link-up again, you have already re-inited
the registers that got reset.


Kind regards,
Niklas=

