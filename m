Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBEEC5A7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKAPbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 11:31:04 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:59060 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727100AbfKAPbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2019 11:31:04 -0400
X-Greylist: delayed 27857 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 11:31:03 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA17kVaF008732;
        Fri, 1 Nov 2019 02:46:41 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2055.outbound.protection.outlook.com [104.47.40.55])
        by mx0a-00010702.pphosted.com with ESMTP id 2vxwfr1d0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 02:46:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avKIeUoiu7mze9zOxTkaI7Zo2pW5qZXb4OUUWLHJRfPpTXUr78qFm81yeZAI1I9Z9wq0lcycVcIMeglLaTaLoxYdifedRNxJ3fSc9fhNWM9HLpbLoGRl5MH3EibzhzOSy3OLeGgPgJjwxQ2KpAZqjZVCvaPPRtBtnv4oyGcFt8CZGqahzXY0ushGD2fYlWioYCEImZitD8/2rP8UpR/zd1a9iu7bM0IsH/0rnv3SwsOAmOZLzn+zsuBOn7aiBNsbIbYLVIqknJzB984r0vxMMiIUCCGTyY/o2XTt7+u0+WD9wYgi6nQEuDM2oC7hZa+0zccOKsxKrrixMIs/a1hcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Lhv7absHzfWZ28VvG5XN7OLrXjEUHLAKLgVHel32c=;
 b=LWC17wpGIWW6LbZM7/d2GEtTDWglZbdHnhO8sfsiM95PBK3GcqkeQkZU729YVxqoe3l8DQvn+cLjLN0VG9JSliLizr6IaAxxhR65cLAOYtYn89ufnj7KlAZVPAxaJpdZNO/s+eM6XlAojSOUl8UoZ+GgUNgjTDsGIZ2IFbifdaabYnVAB1h61lkYEXfiM4EHapQq0pEIhs0G+m+EK00OC+i6xt+vtgWpiUqSaNoL0cgQpWQHeMnb87ww1mf36w0WGHBZpBvHUgCCtHmnThKp9tP/d8CrI7/BZ56p0r/1RuVOxdUG/+pHerTC9B7uuJnTyGeUi1eqIwBSdACJd0LvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Lhv7absHzfWZ28VvG5XN7OLrXjEUHLAKLgVHel32c=;
 b=mXznv3Z1JW/IVtSd4JluyYN5RgtDVNNI2KHJGWblFK0SsIWY6o9VQejoRMEOP0TK+32D+/AzQKqgv1C3RGrYyv+wvDT8V5pAJ6F1a0wdYw1wCi07uj/UMUUgDARvWWPveNhWikebK2+ObGm4Hlp0iSskUDP0Xrzxd5Pga6CPiiI=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB5887.namprd04.prod.outlook.com (20.179.20.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 07:46:33 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 07:46:32 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Thread-Topic: [EXTERNAL] Re: "oneshot" interrupt causes another interrupt to
 be fired erroneously in Haswell system
Thread-Index: AdWPm6PR1RqDULWNQ4axnrJI8tA/7wApA4gAABH4Z0A=
Date:   Fri, 1 Nov 2019 07:46:32 +0000
Message-ID: <MN2PR04MB625551DAE603FED3C81C41F0C3620@MN2PR04MB6255.namprd04.prod.outlook.com>
References: <MN2PR04MB625541BF4ADC84690B5C45E9C3630@MN2PR04MB6255.namprd04.prod.outlook.com>
 <20191031230532.GA170712@google.com>
In-Reply-To: <20191031230532.GA170712@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe31e7d9-66db-4af8-45b6-08d75e9f9d64
x-ms-traffictypediagnostic: MN2PR04MB5887:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR04MB5887E6CD4F3FD432F3D17F01C3620@MN2PR04MB5887.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(102836004)(446003)(99286004)(229853002)(3846002)(76176011)(66446008)(66476007)(66556008)(6916009)(64756008)(8936002)(11346002)(76116006)(256004)(4326008)(478600001)(6116002)(305945005)(6306002)(316002)(66946007)(7696005)(186003)(9686003)(7736002)(71190400001)(6246003)(71200400001)(33656002)(486006)(966005)(25786009)(5660300002)(74316002)(6506007)(54906003)(86362001)(2906002)(14454004)(8676002)(66066001)(6436002)(476003)(26005)(55016002)(81166006)(81156014)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5887;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iiH0kYpIapB1lb9VYJqSronJMwgntqBSvrQG4g9sem0cTd9oa0yEyUmjw5I6+Igk5ws5Mf5R1iOAKlTUf6kOIGD/iQHMbehKFerseOjmLuj4tO2nveJOce50eB5LDk50GPeqohDg89aFrDSJf30ShyZh5BoVhAY//yzvXcbV4dSZnt5KlHTEWOJHhL+VX3HDyP7wLUZbwJiRrIn8Vw/ZcJlhoNMHe1hB5LbuZh+C1qN5/jATNwY4nV5BUvAXlvQEE5d8QSW5L1WHbwr4FHfG0LoIFACy9CWRJGzHtKpBy49+5dg5gzm5IqNfR9HBKIh6jGXJzZyp2JIL+FdE3hLk660J3SBYj0Gmcp3/A89wyEjSqXkYH9Dg+fSzKYJKwUyTyTrfpFGtHasa9y5xhyyLsXFtn2YBcW+gj9Kwc5b2o4rTzGqBXVDs0tZbLpB93hw+DFp9YETDzEM8uC8SHnuMd+aU4g0nYuejHW+x4ha1AFQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe31e7d9-66db-4af8-45b6-08d75e9f9d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 07:46:32.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3BLUS2QA9CAu8/q8HW/mh4+97Bp65wyx4YlPott/So1/FxhoAp6m3AXnCPzrz1TM+3eTlke5845CR4vz/OpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5887
Subject: RE: Re: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_02:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=903
 clxscore=1011 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911010078
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [+cc Thomas, IRQ maintainer]
>=20
> On Thu, Oct 31, 2019 at 03:53:50AM +0000, Kar Hin Ong wrote:
> > Hi,
> >
> > I've an Intel Haswell system running Linux kernel v4.14 with
> > preempt_rt patch. The system contain 2 IOAPICs: IOAPIC 1 is on the PCH
> > where IOAPIC 2 is on the CPU.
> >
> > I observed that whenever a PCI device is firing interrupt (INTx) to
> > Pin 20 of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts:
> >    1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
> >    2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously
> >       triggered
> >
> > The unexpected interrupt is unhandled eventually. When this scenario
> > happen more than 99,000 times, kernel disables the interrupt line (Pin
> > 19 of IOAPIC 1) and causing device that has requested it become
> > malfunction.
> >
> > I managed to also reproduced this issue on RHEL 8 and Ubuntu 19-04
> > (without preempt_rt patch) after added "threadirqs" to the kernel
> > command line.
> >
> > After digging further, I noticed that the said issue is happened
> > whenever an interrupt pin on IOAPIC 2 is masked:
> >  - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1
> >  - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1
> >
> > I also noticed that kernel will explicitly mask a specific interrupt
> > pin before execute its handler, if the interrupt is configured as
> > "oneshot" (i.e. threaded). See
> > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v4.14/sou
> > rce/kernel/irq/chip.c*L695__;Iw!fqWJcnlTkjM!89koUU9_SERIAj1lseZyKsfYfm
> > guRciK8coEnuqi0cnJ4tIO3OV5vG3Lbhn6-g$
> > This explained why it only happened on RTOS and Desktop Linux with
> > "threadirqs" flag, because these configurations force the interrupt
> > handler to be threaded.
> >
> > From Intel Xeon Processor E5/E7 v3 Product Family External Design
> > Specification (EDS), Volume One: Architecture, section 13.1 (Legacy
> > PCI Interrupt Handling), it mention: "If the I/OxAPIC entry is masked
> > (via the 'mask' bit in the corresponding Redirection Table Entry),
> > then the corresponding PCI Express interrupt(s) is forwarded to the
> > legacy PCH"
> >
> > My interpretation is: when kernel receive a "oneshot" interrupt, it
> > mask the line before start handling it (or sending the eoi signal).
> > At this moment, if the interrupt line is still asserting, then the
> > interrupt signal will be routed to the IOAPIC in PCH, and hence
> > causing another interrupt to be fired erroneously.
> >
> > I would like to understand if my interpretation is make sense. If yes,
> > should the "oneshot" algorithm need to be updated to support Haswell
> > system?
>=20
> Just to make sure this hasn't already been fixed, can you reproduce the p=
roblem
> on a current kernel, e.g., v5.3 or v5.4-rc5?
The problem is reproducible on Ubuntu 19.10 (with kernel version 5.3.0-19-g=
eneric) as well.

>=20
> Bjorn
