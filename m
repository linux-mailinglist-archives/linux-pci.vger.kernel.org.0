Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA254A7B6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 06:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiFNEAu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 00:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiFNEAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 00:00:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18931392;
        Mon, 13 Jun 2022 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655179247; x=1686715247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1fVPZWCxtDewnkHG2CyRJwLawdLNoFjajpWOal8CLNU=;
  b=TskCKF2tNWtlytmjmWbTcwtiBAJASWrKUV2uHZmTb+3BQUamrronf5z5
   LmYznTDm/3JZcTeJgaPnDkClBogckjAc81kedBPnmJjPSJQXFnEwg4CKa
   DvX5Et0l0rEcjzhvx42zSMdr3hJXWe0jvDu+orjn7HjW6I2dU5HCBDTQV
   dnjgTO/axti6QCAayXsZw1MiO8A/acLhVNdTpmcpevWx+jNabH4YRFg7e
   Z8+ZhWFWeDbKkkO9NddDJbONX0DVnTwGj4FpeTPQVt32ZooIfw5L0fdYD
   cbLgp+e+Jd0pYZgYcOcJ3Mc4ljhC6UdWkzQVjK+DzLSXL+FPqbk9K+VzO
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203060314"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 12:00:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmZ3GLhwOYrqR9Z5t7o/Zt3Or+P4vc/f8bHgHSM2pdWn4V9e2iLgrSKTvyP6sLdHYB0tAyP3jAi6g41SrNp5aiVtNTVvLj0Dm6g/BucwY1WQ5drN4ZTO4XISdZ/2ZSVG3yZrOjMi711yXN+u7Vw7jrwqFfy/E0y7Pn0dksjwK3hvc/EcUGcLO8PMU649i3d/8j3ntWN2bktyIH2c12tEo3LNXdw9I4uthKItfcuDq6UQzSEMH4HHoIBVZI0BZUDBGDQ6dOEsTZjPoCEZ7jHCNvB7Km774R0k7dlh+r3tIeLktiy4n6kPajl1OkXf4SUpHpvwNuQpuHyobmBf+059fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fVPZWCxtDewnkHG2CyRJwLawdLNoFjajpWOal8CLNU=;
 b=QuX85qkOGHRq892N23izl4P0nLMulqeRArSKVCsfpXsgZP+wOe+ZofZ+2QeOZpTUXCEbSDA532i18Q9WnhfPlAe1bJX6A9tQvmtP74/DqqYf9jF0k10gq5NEAB1DsdYWtZU0RhaBt24lirqId1NfPZtT2Vctow3YU2qcvKoO9ANQpDEdL7afYY7Uz1ZFCrchtjiy1LTHXkHOLVSaztt/RU7DlNlFwg8FBQRBTRICY6Pvf7fhmR6T2Ija3oM480fJ+fhinpQEanFCAV0XarKSX3i3ufYPvSSv5M0n+S5chI/dMTJmV5HZ4Nk+TRFRqEKh80ihojE/6T5IeKjXLzz31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fVPZWCxtDewnkHG2CyRJwLawdLNoFjajpWOal8CLNU=;
 b=U0U9jDUdh4pvNSOWlZT90O4B0tpW21x+E8JpvLkl86w0K2cUPBfKeCMVB7F7CP22/Cd6G7QvVBh3FAipZ3mXfxY1Ld9Y8YFnyuwDVNafjS62Tio+DpxBg/iu0urGwIRTe+5P9g0f3cNCNWkXdKl34XY0ysAAof0sf3Gwkyfdlwc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (20.182.51.102) by
 BYAPR04MB5638.namprd04.prod.outlook.com (20.178.207.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 04:00:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:00:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index: AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAA==
Date:   Tue, 14 Jun 2022 04:00:45 +0000
Message-ID: <20220614040044.rypyclhqfv5w4xy7@shindev>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
 <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
 <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
 <20220614010907.bvbrgbz7nnvpnw5w@shindev>
 <YqfxKanxbZNN7Kfw@kbusch-mbp.dhcp.thefacebook.com>
 <8cf67806-5b9e-3476-d81b-2fb8d618df5c@nvidia.com>
In-Reply-To: <8cf67806-5b9e-3476-d81b-2fb8d618df5c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4187bb-a5a1-4501-7a9d-08da4dba7537
x-ms-traffictypediagnostic: BYAPR04MB5638:EE_
x-microsoft-antispam-prvs: <BYAPR04MB56381ABDF27286E8BF01B76EEDAA9@BYAPR04MB5638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHyZcyCAYYqakPaGQeHKB9+27IYvffjszIVAlsCSkl0/Yw251Ni5yHi7IidAFuj9XDfaDcFXr8rkt0oyIqQTEkvxls1uoRia/HjCwUotX2ORH7/rZGBJpi0CbKHgSMHobgUhfrVzuns5iOcm8Ugig0mQbMbo2QgR4xHGqv4GeUDkdnH4amnTPMMzCqamPVFlMunAhNQY9b9K9TWJ2Z6octv0oKeEHBssXR9rNY7y4ktPxelzRxFZdMk6KVnCly/oGF96P5TjdNhbKWgEdMpK4lzeu7GDw2PmVNqIgT6IMs3nGY/R/4ysKG5eH5hzDgCVvZf3+I2HUk9SPAalkx3RStCSCx2OpTQ2NTHMixk8SNgnyBMfCaB5aMT7lUMakSq9R3/FKz5nxarzyJtvi6gO2XcPHq5YYmuFLj5bfFrTM4q71hNeXHQvXFIggBGZGaqCgschzoiGACXyYKUaZdx2EkSe6xXpKFZ54wPxTCjoTh2R9gTIec7ylkUOdLPgOi3u1dq57wTAp5BmJFBZuemBZz9isa0REz5EMiy81JgV4R+mbsQdQ4vYTxuZBJ+UKzD9QcHDX7rPrI/qlnDtAuEMklHQsY1d+y5KyhPvS5xFFtjJMAjtCjsYQ8yE8nDdVB++OqyAUuikINJF9/X9qFbgfLyESAKmU87bkaNShjmo+n/JQU5RN9uYpQgUWQaTTrzwQtwD7ZA1WOpbfKm33er8Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(5660300002)(71200400001)(38100700002)(38070700005)(66946007)(6486002)(66556008)(86362001)(66476007)(4326008)(8676002)(66446008)(8936002)(6506007)(64756008)(508600001)(76116006)(53546011)(91956017)(2906002)(33716001)(6512007)(316002)(82960400001)(9686003)(1076003)(122000001)(44832011)(54906003)(6916009)(186003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jUAE8O7bdR9YMqlkWar8CWpF6QRNbvygTx3UkHou0WncYlTEeAfpY3MI6E+E?=
 =?us-ascii?Q?Kk4INt41aUmiU/vGHnhyHAe2mV9vjU8EcGogoi50xDRmA5Jn75sgFbWqUwEU?=
 =?us-ascii?Q?qn85IM84Je05j8mdXrmO62rhsqHzQlOimeGE2yNVWGaUSHHDg5PbZMoeEyow?=
 =?us-ascii?Q?qhu6o+BfEMSUoV6zJ6u2Tz7A908lAKamdWvtn8bgxy+GPO+m2x7e2rV/2I5X?=
 =?us-ascii?Q?iFGnoRtmjOtqP9C2RtaOcQ4pdjLoJpZXqDKrnPY4xr2J/s1r7GfvPTjsunMf?=
 =?us-ascii?Q?xg++6NRMdXXOCxsr9tVceof2BxUH4Rdi/e0pbUT6qgciFNzYCFShtRvexrGU?=
 =?us-ascii?Q?+hzG1gSjBzY8I7j8MAKb2nd2vXj/dbaKz2MsYnlOBK3DYrLe1HB2f9kQE/Kr?=
 =?us-ascii?Q?8mMpIXhRU94VTt0m90Olk76z3V5g/wGmxjtmGLAD5jgUvdV1mMGwHQaI8nbq?=
 =?us-ascii?Q?hrXXfD8j6glKmT1uOGwprwHYh5Hw4skZnYpNV1LL53+MfA1YxkDEj7dsSTK0?=
 =?us-ascii?Q?ZrA1SS28ldDgEzz4hS1/pAL8EKwRqo4/11kTeO7ABoeS1U7oSK9N3hEklqCl?=
 =?us-ascii?Q?fYwKMxnrJevAFbL18+Nm58RXKS9yrB7FYXjTioD7580l5QXsRezkdXcqCTCv?=
 =?us-ascii?Q?+71cSWKQIIjNdgV7nNDrnH/jq4sY5FH0J5Vks0Hmfz50JGRdWxu5PRWO8Ehl?=
 =?us-ascii?Q?F/YousEFGleFrQwOt2z+H9z+XstRbmL2aXqE1Mcx7JUUWxqhNAVL9diFfPVb?=
 =?us-ascii?Q?FA+7fCCN0sSHrhmngmqp5crcClihtLmVs2NtU6d97ctZsB5Uc4gSM6sy2rKD?=
 =?us-ascii?Q?OQtk4RtyNWC35Go9dmrefyNpiCrWMn27hxZy6StQOXGFA040o7gDFF3AZNSE?=
 =?us-ascii?Q?wAquK0EzNNejpyJ7My7OiTFfSifF+lks4cx2v6HMGmF9m/UowdFH9ny7EFHH?=
 =?us-ascii?Q?Hdepd4NLOcm8DSDwHZBgMcAwUvWUoHGW7lYW60NZ2lE/3yT/B13fw1ZHk46h?=
 =?us-ascii?Q?Jm/yeeDE8SyGpVI2lUsb7cdRRa6D9Sy0Nf5LhtRHNoVnoBEKewq/nKZykiv0?=
 =?us-ascii?Q?tOtuKhCdoSLjTvlYNOS9N6fvJMLXZ3p37TGA2GM2mDLUvga+rvvyW7VnFFPh?=
 =?us-ascii?Q?tc6T1B6yS6JeuF8zb3JIJIZzhDKiuNjT8nN3fmHFMu8ucSg3bsYV27jq11nL?=
 =?us-ascii?Q?UqtCN9deocv84mo2N7GXmEukeMRC6jyvcvOUr8Cm2MHYKhkgW5mKWJAEHmxK?=
 =?us-ascii?Q?aLFFnAiXEkMfeyV+Yo6XgKyUbnMM+WLDigwuqpQF8xoTVIF5VBrnWlYfJH1H?=
 =?us-ascii?Q?tlCJADPOjrC+ka7zeF+vuUoBhpBk9GMVMs2VKrpczPrvICtZGALetSyKSnTl?=
 =?us-ascii?Q?6SDpxVrrZFt7kaMQ9QfeI89cXUrseqCbZ5I47mv+OLCjNuLe7dZhfBtjjNFI?=
 =?us-ascii?Q?y0jCCHSbM9R8uPlbKr+3/EfcB5NC2/jhRNrNLBp7AiYvU2Y2k7G0uq24uLr0?=
 =?us-ascii?Q?eh54SjIwxV8zCMZ+b+9abeU2jj2flj8uFmkiK/piyOt6ko7ksPbCqYTG+ExP?=
 =?us-ascii?Q?pGOMQ+PnG6Yif8M8V1gltpuqoDbXxyXKSATV82XTE70rV/N1FofPcMlDUlBS?=
 =?us-ascii?Q?5qhSELik/3yBp3edGUrhdAO5qXsp7h2F7cP/ZIPmA+aquLZA1r4//K4TyqWF?=
 =?us-ascii?Q?+2OwQJgm3cfggOc91NChqCDe0i2JxLThYWuxz7WoyqePXu0pRfrYczjwzJ4a?=
 =?us-ascii?Q?6tjugqYTZADwhl4lY7PFsaGcx2FNYQ0kUyqgzR5N6Ek1IWXewMwX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <778AA2C98B637D4A931490A9BE12245F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4187bb-a5a1-4501-7a9d-08da4dba7537
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:00:45.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VZ/A/9W/Ca7Rm6vRXZ/VQA1gQEepqUQi4gWATjSb4RcAagDC4Yj5FpfVQiGFgjK41vDDsVzfEnINhYcZe6Q+XLgpUk/6Xawo56B5GbCf/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> Shinichiro,
>=20
> On 6/13/22 19:23, Keith Busch wrote:
> > On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> >> (CC+: linux-pci)
> >> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> >>> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrot=
e:
> >>>>
> >>>> And I am not even sure this is real. I don't know yet why this is sh=
owing up
> >>>> only now, but this should fix it:
> >>>
> >>> Hi Keith
> >>>
> >>> Confirmed the WARNING issue was fixed with the change, here is the lo=
g:
> >>
> >> Thanks. I also confirmed that Keith's change to add __ATTR_IGNORE_LOCK=
DEP to
> >> dev_attr_dev_rescan avoids the fix, on v5.19-rc2.
> >>
> >> I took a closer look into this issue and found The deadlock WARN can b=
e
> >> recreated with following two commands:
> >>
> >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> >>
> >> And it can be recreated with PCI devices other than NVME controller, s=
uch as
> >> SCSI controller or VGA controller. Then this is not a storage sub-syst=
em issue.
> >>
> >> I checked function call stacks of the two commands above. As shown bel=
ow, it
> >> looks like ABBA deadlock possibility is detected and warned.
> >=20
> > Yeah, I was mistaken on this report, so my proposal to suppress the war=
ning is
> > definitely not right. If I run both 'echo' commands in parallel, I see =
it
> > deadlock frequently. I'm not familiar enough with this code to any good=
 ideas
> > on how to fix, but I agree this is a generic pci issue.
>=20
> I think it is worth adding a testcase to blktests to make sure these
> future releases will test this.

Yeah, this WARN is confusing for us then it would be valuable to test by
blktests not to repeat it. One point I wonder is: which test group the test=
 case
will it fall in? The nvme group could be the group to add, probably.

Another point I wonder is other kernel test suite than blktests. Don't we h=
ave
more appropriate test suite to check PCI device rescan/remove race ? Such a=
 test
sounds more like a PCI bus sub-system test than block/storage test.

Having said that, still I think the test case is valuable for block/storage=
.
Unless anyone opposes, I'm open for the patch to add it.

--=20
Shin'ichiro Kawasaki=
