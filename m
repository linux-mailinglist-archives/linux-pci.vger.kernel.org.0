Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2257AE04
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGTCal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 22:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbiGTCa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 22:30:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD9F61120;
        Tue, 19 Jul 2022 19:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658284025; x=1689820025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iriKVUc7Fmttf1cIECrJyqix/xxisdf+Kmv000hJIWQ=;
  b=SQdkK8xpRYr56zZwIJvgMaEu5ACCnnJLG190s48DwCUwd2BTRrVtkDWp
   ySP0V8TOWhn/KnfnP/5Azz5RvXpUILxDybih1nm0bvsa+/OZaqXsyR0xx
   JxFihWkDsQPw97U0fxOVKQlL1FMFmhXK2fSaktKUJdPL/tWw4e+MigFGR
   y4//2KDEWx9MMUAxqXOP6WdhKnpHfPv5J6X4VGutdyWLAO0o5slfZG/+D
   eyOonFbQDROxNDgjUUpJUzS9LXryLMRxmEGC6EEXiymIQabvRgcZB69nc
   61PyA57SXBr9VB3jgCAvM9SHyk5znyV5THVaD1hNLe/vgDEV3QkMVmCb+
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650902400"; 
   d="scan'208";a="204974801"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2022 10:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEzf6PtxBWRMEC2j3Ifczxm6lWpPgkd+M9KfulqWibTuO5MS6Yl5gkbiH9HUI5k6Y15W1jPp1hcLAWRk3SXEKXKeNqX9iHCHsPTqfBQJFDcKSIG6BvxmaS2bdcoH5nDm7udueT56bGVFaAJiu8OPX0doAYi7/uQqcln0oYYHRDLYZz17rmKScJn8dpJv1LgjCtiMxX1fbIQpQl3B54aENyzcCA/wnPRb3v9BYnqO5spvm7njyWi5BOZEhNU+B87K/8uuowNu/gDh4mFNY4WpOE9e0Hxo1epUy53txrbi13dckwFaJaWsXQMmG1zaL+U+JrlxXViOs6pCiLSE3n9+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODRc/0WWuC+7G/lZeH8UKwCuXb0+TYfvIppYOyLxoIU=;
 b=Mfp6UUdpVYILJ9LMcCIWLsRNKwmE55Om1p0Svr4Lzzq6hLduX+e6Z4HmMu3cjliCvJW5mSBKof3Mc287zdSwv6lDL/Mel4m6W81Kaj7r479Kfb4Ulu1IbAn0jzBZALmWP3QxGQBuXPLfwXMYrbG+X1Rt4LCxLTsCkIem1LiJRWYxCQ6pCqqNfLirlqqGbQ4LedEdaP6ngT0FaoKgBB+ku4utrHd4QRJxcMmB6A7hTtRGNgd9VoVfVwsFn3bl7ojd0Y+36xkHIWhFrpMtq/WqQaQQFW0tO+zKA69PdSFr+x56YvSj2y2W6l4E7VlRq2IXiRDH34KcCrVT7R+2Up2New==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODRc/0WWuC+7G/lZeH8UKwCuXb0+TYfvIppYOyLxoIU=;
 b=zVO+DhvwCx6xQiHFnW3JPF2Z8f+0W+ENseaL3OwTy4sKqyoUmv3KUSTcd66aS0dL3V8CWXxHiJnZ+kwbo0nrVBG+f/vqz2O/oPeTSLR31uz7fLJRibaTaxXx6McaTuHnhja5MUC2RHSsZiLg0BcuJVdzQaBTutdxdntIMKgalaI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0178.namprd04.prod.outlook.com (2603:10b6:404:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Wed, 20 Jul 2022 02:27:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:27:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index: AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAIACmtiAgAA6YwCANDpNAIABKGaAgABB0AA=
Date:   Wed, 20 Jul 2022 02:27:01 +0000
Message-ID: <20220720022700.yrprhniwsgtwpbnp@shindev>
References: <20220719045036.h273puvs3cibafix@shindev>
 <20220719223127.GA1585747@bhelgaas>
In-Reply-To: <20220719223127.GA1585747@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac8003ea-83b1-47c6-49c4-08da69f7547a
x-ms-traffictypediagnostic: BN6PR04MB0178:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWpbDz+VRqtiy+erdG1fxo/SjHXbn20L1CZNIlQLSX9nMPmfnNOf8G6wMBh0aLlbU0+gvmdSdOW2nWGWttMSIbgU9fxJE/5mRUQ7UJFHOG7yH4xBeaEPAvTn9V8sA38A394gQA9FMDhDF2fVsKqEfPOf9ZMIkOyok52dgGjO8A3TE9fauTxVcHxLeMBCaMwIC4PoLknPUPfb7diX7U5NxqJfE8xTWvxXpuCecjPqCrT8w1raQhEPNPVM4vIwJXMd3nalKu6cofeOaNmzfTra5THYq4uKmgsMkp7GSa+/l9l2TpLjDJHOdcEK4G3UcJ9Jx/JeTXfuKgbRW+rDl24VT8mDBvzh92z9E1XklVxgTtv3l9BfmJwkxMdG3rKxNiWZqXYYwK5dajwGwZPJlekNkXFhXEtRAvgLxC47PsgHfNHkbLKhrh1xw+eA919Z+UBalndU7DoSIeULYQHKWb2+QiaG1uqftmmgCAQefvRjIsLvxZErX0/75fzNySgfVO3eaRAU74f764dnDJS61NlK4hjdC4v0lT/ppuphccqT86WmTYNzj/gaezYC+BhfkRyHUPlLb5/0VRDEdbmpnzCNC2iFTqh0TJ3xqc6vk3TwdAOcYy9FHncAPBXAnQ5dhADNgFfR7Wp3pZ3/Fi6hFSNw2zAtF+qJ5eGsSUXm0fNqe9dMZ9MIZE+U6D0NJ+5nF/4Q0CUIOmksHHiS5LASPqWw0gr8Ub6VdAZLAIYGApA7UOiR5oqABj7CDdJBG/2k+UTgHEliniYMeakVGHNDKEv4b8KpDVefZgNEUxIMR4R2WEZ2lD0KDmyOFvMJqz4WWtnZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(91956017)(1076003)(38070700005)(41300700001)(122000001)(186003)(66476007)(38100700002)(8676002)(316002)(54906003)(66446008)(6916009)(4326008)(83380400001)(71200400001)(66556008)(66946007)(9686003)(6506007)(86362001)(6512007)(26005)(64756008)(76116006)(5660300002)(7416002)(8936002)(3716004)(82960400001)(33716001)(478600001)(44832011)(6486002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?80yQ3FTIv/PoRZMmUAGCz60K11WdXEd1V8rZRCLHeKXkyTXyIje61Eg6A/z0?=
 =?us-ascii?Q?WCcC5K4gBX92NUYfTrIAz9O/J0eo7W8hdo8WZ6uKkX1qezJTX0SS5HRSlxQ0?=
 =?us-ascii?Q?NMGocCQxcP+bIPRIpSLzP4LwmC9L1NiifsZ/GJ/ASVD5jzT4hvKPO7nAOHiF?=
 =?us-ascii?Q?eYCEcZtkN1Af8YVQglkmwRlO4xgSmvZEv2fajJnnk460HLwIcVJ3lMZUH7bM?=
 =?us-ascii?Q?mMLA3DwX9WDwchzlkmt/axRLcMiwJABEGtvJv8y1dhe0uGv5bFsM3jafG1D/?=
 =?us-ascii?Q?H7pqGt34UTTZ6snjWglTx2uks/vfdME7qmixOph70/ayvBNylxsLJFm6V0ud?=
 =?us-ascii?Q?IkR6/g84JZnKa275xl0qRtZF1GycKZXEmtJYf/Y3eWYhYXS44I6iXbzwCWux?=
 =?us-ascii?Q?N14exlBZ5tgI1/pzlAg405zqZKP+UfXKiiE9WpLF0mt3KmjljWDJw4Rdge2i?=
 =?us-ascii?Q?2tjkTp3dHXqmk0PwjUaxb7eO0JjGkJ/30igN/Iv8p1dM/JlDS+A2EoRD5BCV?=
 =?us-ascii?Q?OyY/pvSfjOS2IwIvwovX76Eakb7BDktk6hdEXmxwz/qmL8N27w4iMhiKm22G?=
 =?us-ascii?Q?QJ/xhldJFf8MYEvSaX+SB5KVeUdvKF0ULIMYDV2CZpDKzxbs28uZ05LEkyDO?=
 =?us-ascii?Q?iWojsdCd1K4IouUq7tk2C8zvLQRxuj32dZUO4HwQgwT+CjYqVw1n7L4Nne+1?=
 =?us-ascii?Q?UMo9uLwCUFaq8ZgQMJqw5Ns6rgq+ycAgrdI6jl5vswzWqG2mF/JJ991vCbbq?=
 =?us-ascii?Q?Zl3cW0EPMWSa8ojp7Gd/tZbeGL61+UxoTXzn4orHdt4mrsuBCpRJhIXvM69b?=
 =?us-ascii?Q?RWULPgNbnuAGgfnME/a/KVvgOYYkbdCh2npHZF2iEY8fxU7x8FQmfjtIxYZO?=
 =?us-ascii?Q?ID5Sa52o26ekmr0jgDmO4b/8QhoYtpEMws8hdqCTByWTSGOpF0zAUG7Bua/b?=
 =?us-ascii?Q?x0kMSOTrRsTQpqtWzzWWWB2ahNNsvuotrYBpHxTfvXOgeY/fhvevBsEqiuLV?=
 =?us-ascii?Q?NrqZHYPuMW2hKSNSLMkUEZKcPBtb3knSFOK68d1uWlCEasNbffwKWgYaFDQ8?=
 =?us-ascii?Q?j1eAMZ2ckg2uLJZzcsEvHjSDNTNe6xVaLb3slRL/YY7V4H7MuDHfo+kDRtAl?=
 =?us-ascii?Q?R4bjopxuT8nexRuss9wTEVMEyENUP7o7mcCKePSL7fbb5myhkKdY51NmhDEN?=
 =?us-ascii?Q?hkgMgxG47Hx/6PqUpl/9q0vWXfByeC8guqkE3DYsXearwCisTD+tMg3uCebp?=
 =?us-ascii?Q?BqLJCejFRLAecJDjxZCJEU+3+I6D3eRdLy0798se3IHQep3IzmE+NWxQGlUS?=
 =?us-ascii?Q?8KhuQE5wFT/Ezui4llbxA2uW84YBVWUWq0u7zKn0lNVjQkyrpUKKnA6mQAiW?=
 =?us-ascii?Q?OTMLnjDzLaI6idEwWkpJ82Trjn6I5DQIcjccDcdPid1kVoZdK0hrOsfu57vY?=
 =?us-ascii?Q?ZqdDFh/3VtTX9I9+hUd+LRvNzJtxwZKS45Kf19cGCVYPvTmZrSIL9YenKRjA?=
 =?us-ascii?Q?8NbK2DKMH3YioV3XEEOpFUhFHaIWLRGLOwfWA6M1Epllw5iwjzuDEbgtUvGT?=
 =?us-ascii?Q?E5tJW4/bBkKEouP0qFR071NlpdRzj8wopZZhkMz4+8kcjTgdqoFg2sMqsHm+?=
 =?us-ascii?Q?JH/zE4qMSC/b6dnFBlR0POk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A8961C1E48AE3408B097D59BD3AF49A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8003ea-83b1-47c6-49c4-08da69f7547a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:27:02.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRrZqbQRzzznb3Gc2RYRm1bhAAUOqC2tRvztBs8el9Tg6H3mqPTDiFmfkKmRqIzTtrnZ1jdzcc0ACroAArCLS7XYydOuctqmOOKT5sYrOOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0178
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Jul 19, 2022 / 17:31, Bjorn Helgaas wrote:
> On Tue, Jul 19, 2022 at 04:50:36AM +0000, Shinichiro Kawasaki wrote:
> > On Jun 15, 2022 / 17:16, Keith Busch wrote:
> > > On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote=
:
> > > > >=20
> > > > > Yeah, this WARN is confusing for us then it would be valuable to
> > > > > test by blktests not to repeat it. One point I wonder is: which t=
est
> > > > > group the test case will it fall in? The nvme group could be the
> > > > > group to add, probably.
> > > > >=20
> > > > > Another point I wonder is other kernel test suite than blktests.
> > > > > Don't we have more appropriate test suite to check PCI device
> > > > > rescan/remove race ? Such a test sounds more like a PCI bus
> > > > > sub-system test than block/storage test.
> > > >=20
> > > > I'm not aware of such a test, but it would be nice to have one.
> > > >=20
> > > > Can you share your qemu config so I can reproduce this locally?
> > > >=20
> > > > Thanks for finding and reporting this!
> > >=20
> > > This ought to be reproducible with any pci device that can be
> > > removed. Since we initially observed with nvme, you can try with
> > > such a device. A quick way to get one appearing in qemu is to add
> > > parameters:
> > >=20
> > >         -drive id=3Dn,if=3Dnone,file=3Dnull-co://,format=3Draw \
> > > 	-device nvme,serial=3Dfoobar,drive=3Dn
> >=20
> > Did you have chance to reproduce the WARN? Recently, it was reported
> > again [1] and getting attention.
>=20
> I have not paid any attention to this yet.  From what I can tell, the
> problem was discovered by a test case (i.e., not reported by a
> real-world user), it is not a recent regression, we haven't identified
> a commit that introduced the problem, and we do not have a potential
> fix for it.  Obviously it needs to be fixed and I'm not trying to
> minimize the problem; I just want to calibrate it against everything
> else.

Bjorn, thank you for sharing your view, which sounds reasonable for me.

--=20
Shin'ichiro Kawasaki=
