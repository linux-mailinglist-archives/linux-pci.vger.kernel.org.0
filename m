Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12B3D7B5E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhG0QuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 12:50:09 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:26721
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229658AbhG0QuI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 12:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izauKpT9vp4n2gn5hBTl4QgKQkct5caTHvcG1rWTLpulJMnR1jW/tdXXT6/niFdDjMyfTpeqNKw0ucDffg+i7sjjW5ufSFllaXsp5UJ+jJGyFh0MBDL4AXZ9oFhB5R7OFA5xVOsua/DKbHLMcUpxG/+oVgl0GMvliFyuKpUw7ubfWsCyg4RInxaIsU96zz+nTzz6NxyzCJ1xmjSr0mEfTyr8gouebPNvj7+67K6ei5CwNLWRs//8AnSxhtL0fo5nmYAcggzUvhcKarl/lkd8FfvUaILqWZusnHm1b9406l0oUWt0cERtKkajZAlbHFG9+kYg1whAZs7h6PTcKQyVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILQGD6TQDZmlrwRLOAe5gqh7sag+7QRXBOHt9pc2ycc=;
 b=Vh003TK6fZH6tw8ZZ/Ov7Zw+TmB9HzfpH+sf94f/BQG0A6Ss3wSvCPstO6Xd9njUUIsETO1FLxrMuYQfsTJbwRHx/FOIS46n6gOqzf1R1RV5G5HRn1+C1+Zl2fSi1eTKvx626gR9U0aCFOPj6I4Zusrz9PoAINBROWo6C3xKKIaeV6g+MBX6qjRKL1IvFmmiLrlriyCib+8GHa3UKJY5IDm6OBt9EWSVSFE7Bq/L+iWTDbZMEys6khP4Bppaqj1FF0kpgaPFcRIYH4TZcWUG6ii6AIKLO3gHBIFRh3Vy9byPucQMfZ4L3+TCo5BdgTl3NnV1kG41C4BdWpSvQ+u7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILQGD6TQDZmlrwRLOAe5gqh7sag+7QRXBOHt9pc2ycc=;
 b=iyXc6zQMces/5QreYMfJSJOQOvcfZMU7ICB/1IMhS29qgeTlSdeMXO0MIELq3hnKlKRMUrjPQs1rkTkdono9X01xjW0aCRRwtZVjQShydR/Z76RxBo0u0EChq0JKycGr+ZSQES/rSh/lr8QNrjRa6cFy9QgY8PxZO9RsRvLha8e5t1SNXjCgQT9c+4aFt1CcFZY6JJFyO9+Rf0eyGEnMOm4CjbPXDdUvo7kdRbeCw01m4f8+6Amt90Acxf37NGvj0nB9i6OBMrL/Jc8RHCbS14GIMguywT1sf+0Bwb1H/DxqJ2GD5WS95sW5JMfhhuzv7vAcGxCD5A5hBTdcJwBrNA==
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 16:50:06 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::c8f5:7b13:4f70:e4b]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::c8f5:7b13:4f70:e4b%3]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 16:50:06 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Fangjian <f.fangjian@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Varun Sampath <varuns@nvidia.com>
Subject: RE: RFC: Plumbers microconf topic: PCI DOE and related.
Thread-Topic: RFC: Plumbers microconf topic: PCI DOE and related.
Thread-Index: AQHXgt/5GkPV9zbXrESKrMS9y8kzYatXByUw
Date:   Tue, 27 Jul 2021 16:50:05 +0000
Message-ID: <BL0PR12MB2532CC3B64CAB199051D5AA4BDE99@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <20210727130653.00006a0a@Huawei.com>
In-Reply-To: <20210727130653.00006a0a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa4fefb-1e8f-4bf6-b9e6-08d9511e9637
x-ms-traffictypediagnostic: MN2PR12MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37119E1F73D9168BFC8976A8BDE99@MN2PR12MB3711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEzNZuVz4PG3jmCeK29jGuf5Zt33aXocK0xlGjRdwB49ZMjwYEk88KfujovILVxQ4g5LQ5LCod9cKraMgNp8hGqAr045knfYUCNy4DuxwPCMGyEpY7omXa+EMWwFeRYtlmtfsIMTEUtwMXWnGa1efEl6kRXWR0ohXzrKe/gvOwL5fqYxyXY/nZOmWPj8DTZi+C8MgRH9AOL0J9ZToWG6/CGkbYlWTxTaDY0xl2UK2xuk4TLasrnCIrYKxGTzDte9NoT1ghX+McTPHT+hj9/PMGzIDbLRHkkwvtlD5ZXiBX0QskWZ6kD235TYxDLZeR4n1RpkxDGEv89+uuXplKbOMgC5araREJFjfLpzHP2cUqGfCW2/BHJid8N5j1nD4k0Bs47ca8PSU7pAm5CEOlbGxDT+A/Mup6guN7vhoea+nodDbqxbAoQxGkLH3R1UqgJ9vxPaDubPlwLQ0BwaWOfwSWhxkPac+3MpI3pQIWfVH/Gm1yjbcNJQwlAGfqgRj5Q8rpV7QICAtzy4wA1stQTITRVZQjxvQD+3fv276ux/RpmosBsEm5D2N0oUJ1OojHQuMwxi8bAmP7F2jdyKN/GplNpdRZeAI0fwIDjUMng/UGdblyorFbGD6VCS37g6aCrrZnKAexG09kiRtpPC7pNh1/d4P8OHXyO84ct1vEmRFWOjEkIRfYkds1JJkZORhsXpjI5qSop/0DGta5ctdxkSZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(33656002)(8936002)(55016002)(7416002)(186003)(107886003)(4326008)(122000001)(76116006)(478600001)(8676002)(66446008)(86362001)(316002)(71200400001)(64756008)(66556008)(7696005)(66476007)(38100700002)(52536014)(6506007)(66946007)(83380400001)(110136005)(5660300002)(2906002)(9686003)(54906003)(26005)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?nGheadBUDxfZXSN7+YgQUw5AIf/6GIH2LdYn8h/BR6f4HsF3Ftp/8O/sMG?=
 =?iso-8859-2?Q?pYgJqQiqmSTeLR/ZghQS/GCvYfpZLt/ZVewbR2raLaX8X0iwf0B/sOVrpP?=
 =?iso-8859-2?Q?2BjeiLWWzVU5BiBzNWBh78whzIKjt/zoN0/qi3DXXH0sHNl7SPS/5Coo9p?=
 =?iso-8859-2?Q?2ifO7PbWYuq+TEw4sw4ePzpViTiPjf3oXlxqln6ATIbtWlQXXaMXFufz3f?=
 =?iso-8859-2?Q?L4h/FeakU1uJtFYvW1d23Hfd1GWN98KOW4QTuNPFd2CnWIRjx9KP+3uYgb?=
 =?iso-8859-2?Q?U0wvF5kdlv2ecT6z95UyR4d4z4Akzs5L7feRb8UVctJgyZvdZFYdisg0PT?=
 =?iso-8859-2?Q?fRlQSHu8AVoLsVAj7dl+T5ZZ59nCZ7cHJoN1aMxcryLpjENd4AjIqUQJeX?=
 =?iso-8859-2?Q?aSPELrgweINNg9DMVl7h7C96QJpQrDDF2fujFrnTjAGmqfLzeyueLm1Wbz?=
 =?iso-8859-2?Q?pAN9T8p3k6nWPCPrLg9AmV81UWKtbjZ8RBSrsn6qiJirSvsnkGi8eGM5MJ?=
 =?iso-8859-2?Q?b022eULpHymkpNuXfS5XrT3Ki/sQ3xwrDC6YcAMgSlr2i7pSPC3+E2T35/?=
 =?iso-8859-2?Q?8yQ+BTCmVkB3eTY+uQU/SEhNuhgIrjdEBzAz4Q2xqcYcy+EXHtw8HG6+6h?=
 =?iso-8859-2?Q?zBDTcEPGtbOL2ofrg7DGcwJayQiMbIHzSva69IYdG5g/UGHee4Ci3jB+5F?=
 =?iso-8859-2?Q?Tqa/Sc884s6xBXDSFPE8VA4qCyt8up8cZYrBn3qjvkuVlOv9MmXe3MTmUI?=
 =?iso-8859-2?Q?zK3dmKaHa/ELnwhFzydDjkHrucwBj7OpGvjKi6JiDURzBE/I96rhMszRgF?=
 =?iso-8859-2?Q?uqZqR0PdXis0m1o4059pg8FuBwTLmWic6hV1Nx7Sme2qlG6M3jxuFbXJDa?=
 =?iso-8859-2?Q?zFY2HYkOaTcyLQL6J6SDKrCzQiaoERrgFQeeE7n8DrvqXuuyiBuq/C7ZeP?=
 =?iso-8859-2?Q?ixiAstjtZt+d1IiHELJrnsF5PUyzIAm7GB1sFzGgzuKrCwD9zM1+Y3QR5X?=
 =?iso-8859-2?Q?iSj3ReJsmLZDYct3Jh8nI2PbDHDJ1pTqMImNESLPFucIZDN56B3et5gCQd?=
 =?iso-8859-2?Q?jr+YPGx2i0CMCC//exPTA6nLIWPv/fjmTwgu61HP4GGbWOxNto5i3fvvmV?=
 =?iso-8859-2?Q?JABHooo9WWi5t9S/pZmac/7RiGXYK9j0lQmsEVugUKpqv+859VVm9QKYgF?=
 =?iso-8859-2?Q?3bboxdUqRUWcFUFcwGO0u36PbTwbJPTin1iNEvThchYEKj/+EYtQyIUda0?=
 =?iso-8859-2?Q?NkjASRtmduu8g6nvoK3FSEj3DP/XQ7yH0wa6NEI5etULhcUJoWDpwRemi2?=
 =?iso-8859-2?Q?/apt3wF+XtOzTxvT74NlRDahfJNyUJBL0qQ6PdaSX8e0tb6FSr4ebAvA3i?=
 =?iso-8859-2?Q?/0UOpjPAGw?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa4fefb-1e8f-4bf6-b9e6-08d9511e9637
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:50:05.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MsDieQZs9DiGmESICz7nJNhUL67gms+npSMY6Eg30HalGGztuK1QLs1h+Iy4YI/RG/RMCz53i3+IqLi4gZx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,=20

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>


> Open Questions / Problems:
> 1. Control which software entity uses DOE.
>    It does not appear to be safe (as in not going to disrupt each other r=
ather
>    than security) for multiple software entities (Userspace, Kernel, TEE,
>    Firmware) to access an individual DOE instance on a device without
>    mediation.  Some DOE protocols have clear reasons for Linux kernel
>    access (e.g. CDAT) others are more debatable.
>    Even running the discovery protocol could disrupt other users. Hardeni=
ng
>    against such disruption is probably best effort only (no guarantees).
>    Question is: How to prevent this?
>     a) Userspace vs Kernel. Are there valid reasons for userspace to acce=
ss
>        a DOE? If so do how do we enable that? Does a per protocol approac=
h
>        make sense? Potential vendor defined protocols? Do we need to lock
>        out 'developer' tools such as setpci - or do we let developers sho=
ot
>        themselves in the foot?
>     b) OS vs lower levels / TEE. Do we need to propose a means of telling=
 the
> OS
>        to keep its hands off a DOE?  How to do it?
>=20
> 2. CMA support.
>    Usecases for in kernel CMA support and whether strong enough to suppor=
t
>    native access. (e.g. authentication of VF from a VM, or systems not ru=
nning
>    any suitable lower level software / TEE)

Any time the device is reset, you'd want to measure again. I'd think every =
kernel
PF FLR/SBR/CXL reset needs to be followed by a measurement of the device
In kernel. Of course needs bigger discussion on the plumbing/infrastructure
to report the measurement and attest that the measurements post reset are v=
alid.
Instead of native access, could it be mediated via ACPI or UEFI runtime ser=
vice?
Not clear that ACPI/UEFI would be the appropriate mediator in all cases.=20

>    Key / Certificate management. This is somewhat like IMA, but we probab=
ly
>    need to manage the certificate chain separately for each CMA/SPDM
> instance.
>    Understanding provisioning models would be useful to guide this work.
>=20
> 3. IDE support
>    Is native kernel support worthwhile? Perhaps good to discuss
>    potential usecases + get some idea on priority for this feature.
>=20
> 4. Potential blockers on merging emulation support in QEMU. (I'm less sur=
e
>    on this one, but perhaps worth briefly touching on or a separate
>    session on emulation if people are interested? Ben, do you think this
>    would be worthwhile?)
>=20
> There are other minor questions we might slip into the discussion, time
> allowing such as need for async support handling in the kernel DOE code.
>=20
> For all these features, we have multiple layers on top of underlying PCI =
so
> discussion of 'how' to support this might be useful.
> 1) Service model - detected at PCI subsystem level, services to drivers.
> 2) Driver initiated mode - library code, but per driver instantiation etc=
.
>=20
> That's what have come up with this morning, so please poke holes in it an=
d
> point out what I've forgotten about.
>=20
> Note for an actual CFP proposal, I'll probably split this into at least t=
wo.
> Topic 1: DOE only.  Topic 2: CMA / IDE. As there is a lot here, for some =
topics
> we may be looking at introduce the topic + questions rather than resolvin=
g
> everything on the day.
>=20
> Thanks,
>=20
> Jonathan
>=20
> p.s. Perhaps it is a little unusual to have this level of 'planning' disc=
ussion
> explicitly on list, but we are working under some unusual constraints and
> inclusiveness and openness always good anyway!

