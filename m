Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363C5185742
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 02:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgCOBfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 21:35:30 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:21315
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgCOBfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Mar 2020 21:35:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfykn4ujuQ9jO5IPkAexwjIz4gcVsfedmc0C87sGtYbRuEQsGKrojcVuo2lGipgb7AW3bO79mbLoxW/uzaUyWJLA3eMbwRqQyk2UenPc3p0ho/a0KuTSscdFAOLCmglGjSGnns/dBPoAKNWzO4YAk0I3/OwjY3jCm2qL13sLnLxbvN7OH2WW8Dc00wh7f5MxMUYZMJ04Hp57M47OCCbliT5qzggRZ/ijhyZSrvXwSPp8U0CrHL8XKj4ddv9B3OzGBhwPNvLuLJgwwCdm/5qcWBnS5lQAI74ta3xibccTooBRQ1iSW7s/HUTw516SyWHVmYkbmwHLBk3xTnqpY3Xznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygA2KSuJKN8mVtVsRJf0e8Am6xHS4myVBr328zLn3Ow=;
 b=EeOlIHE9WJ5c0JNJGNVtEp+3JJslkc3EKAp6TFQUmLIIDbagD5cuxg4Vh5xv4IALoSdQJ57jkVXOR9ABN13xPEG1EgPhRR8uQ/Lig5V+xUgPWrf6VygQbytkjsa3mbP1X9BkRz7VTHLFzV3GDkNy200g2outhoqA0sJ2jmXGAYfagwCqlRh+fplclG9nHz+mSMOwzcKKWFdNFY6MHycOWoKtQ2+tDvvDVZ9BvlcM6yGhFKtEWikY5elr91n168tLOyCgoZZItO+Io4YJAMjE43gPQljcy4Lmzgg5WSrYOVsvJk2aNwK3n64ZJhHKU5DYcp5ah41HO2apbjXMbKvq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygA2KSuJKN8mVtVsRJf0e8Am6xHS4myVBr328zLn3Ow=;
 b=LIWcfvbMPK88qMxaNOYviCWQHiQZ1aROksoXQh5XifI2Z7W/0dzV6kA4sRj/5omWbNbPi+5wJMF8w6oMpzan2hC7p2sKObF4IYsXI3Hy4BQYburBxgZRt2TRSnIAZ6wBJuKegkjHngiULAsk380JHphMi0osuW58ObuSdbduCZc=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB3356.namprd06.prod.outlook.com (2603:10b6:4:41::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Sat, 14 Mar 2020 14:19:44 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.007; Sat, 14 Mar 2020
 14:19:44 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Kernel hangs when powering up/down drive using sysfs
Thread-Topic: Kernel hangs when powering up/down drive using sysfs
Thread-Index: AdX6C4g8wtFnF4AzTBuWtW2g0jlmPg==
Date:   Sat, 14 Mar 2020 14:19:44 +0000
Message-ID: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGhveWVyXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZDg5MDNjYzQtNjVmZS0xMWVhLWIwNzYtOGMxNjQ1?=
 =?us-ascii?Q?MTE0MjYwXGFtZS10ZXN0XGQ4OTAzY2M2LTY1ZmUtMTFlYS1iMDc2LThjMTY0?=
 =?us-ascii?Q?NTExNDI2MGJvZHkudHh0IiBzej0iMjc5NCIgdD0iMTMyMjg2NjkxODI3ODkw?=
 =?us-ascii?Q?NzU3IiBoPSJNSzZhNVBhMVV5Y291YURQenEzZWJXNGxiR289IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFDUUVBQUJG?=
 =?us-ascii?Q?dXVtYUMvclZBVmVwRDJnZCs2SzlWNmtQYUIzN29yMEdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDMEF3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVdVWFc0QUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVl3QmZBR01BZFFCekFIUUFid0J0?=
 =?us-ascii?Q?QUY4QVlRQnVBSGtBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHVUFjZ0J6QUc4QWJnQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1QUhVQWJRQmlBR1VBY2dBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWN3?=
 =?us-ascii?Q?QnpBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJrQUdRQWNnQmxBSE1BY3dB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [68.102.166.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f468fcbf-d60d-43fa-7202-08d7c822be5e
x-ms-traffictypediagnostic: DM5PR06MB3356:
x-microsoft-antispam-prvs: <DM5PR06MB3356215C0A96D9AFE0B385F192FB0@DM5PR06MB3356.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(33656002)(6506007)(478600001)(316002)(26005)(52536014)(186003)(5660300002)(8936002)(81156014)(71200400001)(81166006)(8676002)(66476007)(66446008)(66556008)(66946007)(55016002)(64756008)(76116006)(6916009)(9686003)(86362001)(7696005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3356;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zm2b552hv6J9+mpFQVnlOaEuXMGHt3BYxkl0gCirWKb5PZVX9lMXz9jNvNoF8rj17tG+24Ns01CiekWAjRiuSuTRj1wOuPbXhhRs1eFgRJcsRC8Pce6Y/TgYMNbEYuD+iYSEq0lqFS30C/5+q7apSRNk/1ctGgU0+/fhgwgVX/+ff4E4dqCv6if5dq0DG2wV6Qt7dHOrYR+o50zX2LGO9YZxlt0faIE8d84T0YpfWhTEj8OPvwVz1oSyi2nCvI29s6k8R6qnwk2h/NBeJ8dIDaR1xEe7V+q8eFlTLZPWl9qrnqWBBnawQCd42eL5egxDa1uu5OqGSTPhtReCGzj4+bDjTEf0iNfIJz2QsympW+NB4lNsMB7Md59swz2gUoCVHxuG9OJ5xeOsQwlO8chdma03j3OsA+71Zjup/leQA4VhYhVeSj8XE3Ca2CAWpuvY
x-ms-exchange-antispam-messagedata: XGNLpuyJYeM9GJVZqU+VqYh//xmMHuuIZuvHawCTo6tOav35FkcCHZICfMVDPr8WJoqVRiQrKdOzYgtw4MtBXZc3S+AffKMcK7FGCyHjwQ07Q66xIwTP1pB/ky+7Kd8EmTJadhMrR47grwYO57hiKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f468fcbf-d60d-43fa-7202-08d7c822be5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 14:19:44.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuGmJBn0+ZKhg90IAzCPL4Wvad4h25yME1BxDT8LT3VI8KbKmRIEu6E9SNxKckV/I1CR/m9afPY4JvGrtPvjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3356
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have come across what we believe to be a kernel bug (using 4.19.98-1 ker=
nel in Debian Buster).

We are seeing an issue with the latest kernel when it comes to powering up/=
down drives.    If you use /sys/bus/pci/slots/<N>/power to power up/down a =
drive, the command is hanging with this latest version of the kernel.   We =
have found that applying the following change appears to fix it.   We are n=
ot finding any bug reports upstream yet.

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_=
hpc.c
index c3e3f53..c4d230a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -637,6 +637,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
        events =3D atomic_xchg(&ctrl->pending_events, 0);
        if (!events) {
                pci_config_pm_runtime_put(pdev);
+               ctrl->ist_running =3D false;
+               wake_up(&ctrl->requester);
                return IRQ_NONE;
       }

We believe the reason we see this (and not the others who introduced it) ar=
e because of our timings on our PLX-based switch.  Since we fan things out =
over I2C transactions instead of direct GPIOs, there are different timings =
than most folks would see.

We've instrumented the code and we do see that pciehp_ist() runs twice, onc=
e exiting with IRQ_HANDLED and then again with IRQ_NONE.  We believe that i=
s due to the timing differences.  Adding debug in here changes the timings =
enough that the hang goes away, so we are having troubles proving this 100%=
 at the moment.  But just based on code inspection, if pciehp_ist() exits w=
ith the IRQ_NONE case, then nothing will ever set ist_running=3Dfalse until=
 a subsequent hotplug event happens that causes the IRQ_HANDLED case to run=
.  (We were able to prove that will cause things to "unhang" and progress a=
t that point - if you're hung and you remove a drive, the slot status chang=
e will then unstick things.)

So we currently believe the problem is:
pciehp_sysfs_enable/disable_slot() each have a wait_event() that checks for=
 ctrl->pending_events and ctrl->ist_running to both be false.  We run throu=
gh pciehp_ist() the first time, return with IRQ_HANDLED, pending_events=3D=
=3D0, ist_running=3D=3D0.  While pciehp_sysfs_enable/disable_slot() are wak=
ing up, pciehp_ist() runs a 2nd time, setting ist_running=3D=3D1, (pending_=
events is still 0) and returning IRQ_NONE.  Now that ist_running=3D=3D1, th=
e original wait_event() goes back to waiting and will not be woken up until=
 something causes pciehp_ist() to run again with a pending_events!=3D0 that=
 will result in returning IRQ_HANDLED.

Setting ist_running=3D0 and issuing a wake_up() for the IRQ_NONE return cas=
e in pciehp_ist() seems to fix this.
