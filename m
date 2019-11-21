Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21012105161
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUL2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 06:28:24 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:10868 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKUL2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 06:28:24 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 06:28:22 EST
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALBKQq0025209;
        Thu, 21 Nov 2019 05:22:21 -0600
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0b-00010702.pphosted.com with ESMTP id 2waey5pmgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 05:22:21 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2ZPdVZ0lmQAnnaQbDKve8L3DDgcTtiXQdHDjWEWPQzG9NvsQUx22TxOjjqVY4vWb/X8Cwt1bLkLGaCfhoQtMuUz0ybe52pfA9lRHpTmxdxvWxtslYErek0LmvwAoROwFA2HB9LByDzx0JyDEtOIFSXruWUhqF1MHqGdCAXeaLNHhRuO1IXkoaSxB1En9wBDMRwS+tU/u5kjfppU0xT80ZXIcrBQ+dshuGERaxbeT1tBPcDw5mexOgpSoZmylY/vWdHiszHQL28IvvAG7kfwbsMqj6qxuTQhOVF3aHBd1FLmCmjT0QUR+b2sdr+ATgi1wc9e0tbNFaN3IiqR4Nzlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGrpv3LZUnCQZYpdF31C+Z8WPUnGDCGheUqSd5C3QVs=;
 b=hNlbIiIkwkePlbc5HnkblVJKF0/XUjUwLhnWYajYF0qI9OK9nmSz724+QZo7VW0nZRJSkLu6E3D1ERD4GrCO9xtKW/cVk6JxWO1JK+KzAmfXez/nPLWDe+2clUqm97fXgPiXWYwUHwanahcqqL/jJvly8Yh2805Nr2yP+YWxlB67DVjZuOJOeVbwdK0juG+wgXOMlx+0+b5zCa5bFzMDe8R10VFt4TcXI9X61tEPchI1cXYRu7E9Es6mNLpvrtYMv2HjVyY9DMsM6Ft9UeBbdJYhLZVMPqvNsvP0Ur8vSGdgmbB0BsqQz3uauurqQQt93UpziqdDMc3pSu11Y8HGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGrpv3LZUnCQZYpdF31C+Z8WPUnGDCGheUqSd5C3QVs=;
 b=YGPReHLy9Y05Ri9R6RGwWdg3bfoh4Ffsbpxe7YtXkqYCdiVeYPbUi5qp1QPQi7vu0n8vq7+R7Sh71p7AUDuJ5fX7Cd9H9TZqyClAB3TWjfaNlp1Ds6DX+z7FrO0pFABkxF3FbclM1DryH4/e6jbf1aTqHzw2SEK6Jg20lg+fQ24=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB6736.namprd04.prod.outlook.com (10.141.117.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 21 Nov 2019 11:22:19 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::408b:62a3:dabe:23ac]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::408b:62a3:dabe:23ac%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 11:22:19 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>
Thread-Topic: [EXTERNAL] Re: "oneshot" interrupt causes another interrupt to
 be fired erroneously in Haswell system
Thread-Index: AdWPm6PR1RqDULWNQ4axnrJI8tA/7wApA4gAAMppJoAActcFoALKM+gQ
Date:   Thu, 21 Nov 2019 11:22:19 +0000
Message-ID: <MN2PR04MB6255F9C4B0449BA0CE36CFA2C34E0@MN2PR04MB6255.namprd04.prod.outlook.com>
References: <20191031230532.GA170712@google.com>
 <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
 <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f4ebd4-c67d-4725-e9cc-08d76e751254
x-ms-traffictypediagnostic: MN2PR04MB6736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6736401A2958A37604EDC5FAC34E0@MN2PR04MB6736.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39850400004)(478694002)(199004)(189003)(3846002)(446003)(229853002)(64756008)(6116002)(26005)(66446008)(66066001)(66476007)(25786009)(316002)(305945005)(7736002)(66556008)(2906002)(86362001)(478600001)(71200400001)(71190400001)(74316002)(6436002)(256004)(4326008)(76116006)(11346002)(186003)(99286004)(52536014)(4744005)(66946007)(76176011)(8936002)(81166006)(33656002)(6506007)(102836004)(8676002)(81156014)(5660300002)(54906003)(110136005)(7696005)(14454004)(9686003)(55016002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6736;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlZSYcH+/NOiv8xivGJ9u1fyJA1YBOXG2oLmdbMVDmq4FvMGDPHhUwtK+g5wUBwA9T9xwkE6ApU1CCK6XkdvPg8FHmTeK9khhSIuXzX4sb5dIW1sjBn0Wj23dyTOs5TvHJmBN1Ezarm0vIAE8c1eW2GZWoYPzxiS5sKmXY9LKMG8aX7/kCz1Rxh8Ga/QvfUkVlqXscXjai01xK42G1ZkZoSzNCdzMSxrzuIw62UgDwfZUBqTl97aLOpOMfP6AibvekSGTt2uILY2ek3Fn5Clxzwr5uIfJmAZld/TgREzM/PFLcV5Ku7zxGIsuUboPyV9bOPPkWhvLiz8EmNreRwr/cQZDGxUh2uqzWBSD7FwJqPQLWXGQfE4NylCaJ8jmP0jcvqNzDiuUCzPUJl2mnA3c/A63+HcA3muPy42qMNamTJs8lCSX7J47NC0Ij/e2gKl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f4ebd4-c67d-4725-e9cc-08d76e751254
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 11:22:19.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9t2aLF1l+Sfu+i/K0S8NCFwLyr6FklaZ+93IJ4AnTK/ZB3oz6lRZU51hs85DGQEumEFnlps8pwZaF3UKImTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6736
Subject: RE: Re: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=832 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > The workarounds for this are enabled by PCI quirls and either
> > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy or 'ioapicreroute' on
> the
> > command line.
> >
> > It might be wortha try to add the PCI ID of that box to the quirk
> > list, i.e. the PCI ID matches in drivers/pci/quirks.c which belong to
> > the
> > function: quirk_reroute_to_boot_interrupts_intel().
>=20
> Do you mean adding the PCI ID of the device that actually fires interrupt=
? It
> can be any PCI card though (example: external ETH controller, data
> acquisition module, etc).
> Or you mean to add the ID of all PCIe root ports that routed to IOAPIC 2?
>=20
> Based on Haswell specification, seems like every entry on IOAPIC 2 will
> experience this problem.
> If to reroute every entry on IOAPIC 2 to IOAPIC 1, probably we should jus=
t
> disable IOAPIC 2 instead?

Hi Thomas, Bjorn,=20
Any thoughts on this?

Thanks.
Kar Hin Ong=20

