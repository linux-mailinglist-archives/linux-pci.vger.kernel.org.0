Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEEF2BB5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfKGJ7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:59:54 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:10094 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387890AbfKGJ7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 04:59:54 -0500
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 04:59:52 EST
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA79ZweT018498;
        Thu, 7 Nov 2019 03:38:44 -0600
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-00010702.pphosted.com with ESMTP id 2w41xdj81b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 03:38:44 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DppZ0+qv3TgBp4Bucg32wwlzN6LSqeBattOCx6G0zbF5Uo4j59LTymYL4sfOAdPGolbDef8Z3a5Mi7dkeHAIKgka5k3b83P2mMXweeM/JtSB1D9wTLqVgyKWYWMP6/kATYUlJeo+vhVw9Z8DBpOM0R84ypMkwMko2Q7y/lfjmu4EPiPWkrMXtMfzDrSPyAUK/3yg5es0oFWnBBYKk2vt5RmpSVTP28AQPnbRCFZPma/PkClvutsXh7KQfTWeRXI83NK4yXOxFp3yJtFfP1RkpTe8aMTEwJEhDwBcBYgkZ4Do9CXNV9vQpe3Xz6LGpcrEOHVp9scq9H7FwYnyy81wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT3Aev0yHNyDVsA/uLIlPAA8+QHdxZnUvyLBCm3idUY=;
 b=jg49CjIsMhShZnoPrCbhGPotI2GW0ukYzMh/b5B5WhLfVVV9ijv8HCBby+LcS7YaPMoTDto6cPVzrhcyYTZm5RGNS+l1GwFKcwgPhLq2hc868M+3GkON37SBno3jdkI8PsDx7Ybc+Y+RhGhC6TdCHwplpqJZY8zQAlysYcF2UDPLtDQdnWtizHM7P3n747qc6UUUQ/I6d7CmRhNxOKGRoeE0a3XpZSq/MJ21zUZiiuMQOT+VrPF9wx6yb9lGjyH8WqhoT+RLIo2QDYGJLEczhpneLN2cSnENV6D9uqckrHewvCDOostxe1BnQC0+CR5wyr/kUnEE5PnZ8F/ZnwUbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT3Aev0yHNyDVsA/uLIlPAA8+QHdxZnUvyLBCm3idUY=;
 b=Wb/5HklA5PvNe3KbzRtbV8Zs48WVHIY9bq+VPSublx2KJ/u+hQjkbtWVHIlcsnwXA6+cYfLLGlt4UettZUTsUy3sbb5hLhqDI5mkvLAGQcXtkYFsyNNYBepi0krZM90ai3zO0VGc7ljIr4QqExeM1AL/3dM0TQt/zlXWXOhlKVE=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB6862.namprd04.prod.outlook.com (10.186.147.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 7 Nov 2019 09:38:42 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 09:38:41 +0000
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
Thread-Index: AdWPm6PR1RqDULWNQ4axnrJI8tA/7wApA4gAAMppJoAActcFoA==
Date:   Thu, 7 Nov 2019 09:38:41 +0000
Message-ID: <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
References: <20191031230532.GA170712@google.com>
 <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab36215-24b1-4b8c-745e-08d7636646a5
x-ms-traffictypediagnostic: MN2PR04MB6862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB68626B1FE3031A6D1095BD30C3780@MN2PR04MB6862.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39850400004)(396003)(189003)(199004)(478600001)(4326008)(229853002)(52536014)(81166006)(81156014)(8676002)(256004)(86362001)(9686003)(55016002)(6436002)(76116006)(14454004)(6246003)(25786009)(66476007)(66946007)(66556008)(64756008)(66446008)(8936002)(66066001)(486006)(476003)(33656002)(74316002)(26005)(186003)(305945005)(102836004)(7736002)(446003)(11346002)(316002)(76176011)(6506007)(7696005)(110136005)(3846002)(6116002)(5660300002)(54906003)(2906002)(71200400001)(99286004)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6862;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btOMbrIJGSlzPXof02umV5T6hLS6vSyTYXG+9otcyD7/PcOyJg3AdkSR0WlU3Oe+mwXX7SP/LHY0aKnEigHxP/byjfksD+GbUmYqEZeTw+UXBwLTYplzDBRaZNcirTFUX5Nm9ShgwpASfOxLAXMnCugOxFGhV1O+eWDzLIQB0mDar7Dm1uPvx8LPId1d1yv7D/k1V1dfCd1MYl12pK6vyqe6/1en0Vp0Y5L31+QpXJ/Z0LjaMII66KnXVr1jS/iIEIlrInIgYwo7sMMtzKcdCTwAO3b1BEG/olW0IVGtZmjUFybWaNLkuc/H85UfHxGCdaWKwgfftfjiJqTomyfINh/p4jiYtIQ5CiccQMtpehvdmav4Wx2xU1z1ULF11/7cHU+j4CoSc4YZHx/JTtNk5wHffdjyZYmA3oAmXQqoDvcVJ1MxE1FXOsHLziHSOoql
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab36215-24b1-4b8c-745e-08d7636646a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 09:38:41.8017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx0kDnNwiIirkPU/tBTWia9odAs7BgpYKY/GH4R+fpigob9TFRredWrNL1qWkzMJBSCAKd4g4TotHIdFh0buvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6862
Subject: RE: Re: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_02:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070096
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Thu, 31 Oct 2019, Bjorn Helgaas wrote:
> > On Thu, Oct 31, 2019 at 03:53:50AM +0000, Kar Hin Ong wrote:
> > > I've an Intel Haswell system running Linux kernel v4.14 with
> > > preempt_rt patch. The system contain 2 IOAPICs: IOAPIC 1 is on the
> > > PCH where IOAPIC 2 is on the CPU.
> > >
> > > I observed that whenever a PCI device is firing interrupt (INTx) to
> > > Pin 20 of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts:
> > >    1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
> > >    2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously
> > >       triggered
> > >
> > > The unexpected interrupt is unhandled eventually. When this scenario
> > > happen more than 99,000 times, kernel disables the interrupt line
> > > (Pin 19 of IOAPIC 1) and causing device that has requested it become
> > > malfunction.
> > >
> > > I managed to also reproduced this issue on RHEL 8 and Ubuntu 19-04
> > > (without preempt_rt patch) after added "threadirqs" to the kernel
> > > command line.
> > >
> > > After digging further, I noticed that the said issue is happened
> > > whenever an interrupt pin on IOAPIC 2 is masked:
> > >  - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1
> > >  - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1
>=20
> This is pretty much the same problem which we had analyzed and worked aro=
und
> years ago.
>=20
> > > From Intel Xeon Processor E5/E7 v3 Product Family External Design
> > > Specification (EDS), Volume One: Architecture, section 13.1 (Legacy
> > > PCI Interrupt Handling), it mention: "If the I/OxAPIC entry is
> > > masked (via the 'mask' bit in the corresponding Redirection Table
> > > Entry), then the corresponding PCI Express interrupt(s) is forwarded
> > > to the legacy PCH"
>=20
> Oh well. Really useful behaviour - NOT!
>=20
> > > I would like to understand if my interpretation is make sense. If
> > > yes, should the "oneshot" algorithm need to be updated to support
> > > Haswell system?
>=20
> No. You cannot change the oneshot algorithm.
>=20
> The workarounds for this are enabled by PCI quirls and either
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy or 'ioapicreroute' on the
> command line.
>=20
> It might be wortha try to add the PCI ID of that box to the quirk list, i=
.e. the PCI ID
> matches in drivers/pci/quirks.c which belong to the
> function: quirk_reroute_to_boot_interrupts_intel().

Do you mean adding the PCI ID of the device that actually fires interrupt? =
It can be any PCI card though (example: external ETH controller, data acqui=
sition module, etc).
Or you mean to add the ID of all PCIe root ports that routed to IOAPIC 2?

Based on Haswell specification, seems like every entry on IOAPIC 2 will exp=
erience this problem.
If to reroute every entry on IOAPIC 2 to IOAPIC 1, probably we should just =
disable IOAPIC 2 instead?

