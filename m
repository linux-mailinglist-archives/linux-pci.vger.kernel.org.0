Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76C1191503
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgCXPj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 11:39:28 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:54272
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727905AbgCXPj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 11:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbxqPaUNLBpfnFgz2mdytG1dVf/BxIPBLRWfkLmwx/II4yrMfn2hjgq5XZ42pGggIItGLRyQP93bi6Cp5pCy5EqKRaFsRn0qUR5gJF69E2ZdKNlMA/7+Y9Rju2fpaiZb+HRb7ltUsaA4G4fCMBRArf+afJBfo6uL/kNjzdYubocdTxCdcuGJ/XMtqWZb03ylYLBhuYlQc9aPLxOwzWzvcjpVRoJbfDsPRyY4ZLVir+EaIvLMExv2LJzK3qYoBf5AZtJCpo1KQiVOU+DsrLrFgvrZyZw9rWIgNGanD8XykCof13o6DpHKry+c6MkL8jCfx+HRMWTLRthk/1s4g039jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Feu9e+wJ0RUr2kKNnGUUjsHvju/6LrGBpVafAltbTZw=;
 b=WKM6KyklB9OS2oHKS+jD1qXdDXV/iMU4WFzDrivIVj0PurGaiHsOCLFbhU/wqEE/HDHzpqbEr74Bt9LRNDXe3ZhOl3wx4FIfdOjnoFn5AtctZJ6zXZh+ULzvrXuV9dEqz2s5/z9emi3xUlGrrbGfuX8jy8ahnibo+ymWmLQgCBtqBmBhWOukzxzcPJ6yNOipXT5OmFF0Y+OzJ2ePupF7+RmyIVRs34eGdz7ey2P8FR+cwIaFRbhm3xaWGERFl2pbyi3CL5mHYzlWP232vYXRWaT/7cvSNtVjR90vFfFP1vguyprDwRht4iP8dTTy6zGa0hxxQu+rQSoIGiyy7JII1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Feu9e+wJ0RUr2kKNnGUUjsHvju/6LrGBpVafAltbTZw=;
 b=rxKoyXUC3H2d1RlaH6S8HIw0XU6btoow66kAjuu1emFMiyChLjLa6aMF/Yg4lGtesfbzOYLLjHWEZe80M7K2P3pZ8/okG3dFDYbOKjsFS2zitVBS/wiD00g2G0ik3PtrKKZPDvJajlFRoHdPnd7TF5mXenq6slwrLpXlHa/On5o=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB2748.namprd06.prod.outlook.com (2603:10b6:3:46::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Tue, 24 Mar 2020 15:39:24 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.027; Tue, 24 Mar 2020
 15:39:24 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAEZcnAAACX0QAAADQLA
Date:   Tue, 24 Mar 2020 15:39:24 +0000
Message-ID: <DM5PR06MB3132687F173C2BACB88136D292F10@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
 <CS1PR8401MB07289568BBE041784FBB326E95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB07289568BBE041784FBB326E95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [216.240.24.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6d3acf-cfb6-4dc5-fb5c-08d7d00987aa
x-ms-traffictypediagnostic: DM5PR06MB2748:
x-microsoft-antispam-prvs: <DM5PR06MB2748B4DEE65BB0DFF0025CBA92F10@DM5PR06MB2748.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(186003)(81156014)(66946007)(66446008)(66556008)(66476007)(81166006)(76116006)(64756008)(71200400001)(33656002)(52536014)(4326008)(8676002)(2906002)(53546011)(316002)(966005)(6506007)(7696005)(26005)(8936002)(478600001)(55016002)(110136005)(9686003)(86362001)(5660300002)(296002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB2748;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qx8/lGQglsXguMaNBKD+XgTcqFNoquEd5dSKkyxTWe+mgZSmsi68gdgEgBE8uBc+UPbD7CAZYjDA9NuY7BDeG9wsPQfE61lHfiVrkTFUrei7XR3h3OIqeNuyeGQ6PtDhgm9n+Ix13T0BCX60jY0Neh4+rc5uLbui2per1+pzp5a1fkJ/y3TjFdx250Iymu8OMO3Eaomh1BDGujqevITHv8/5l4P0iE/KQz7aouCcFqndheAdEgsIZ9WS208e1J2KMcgE0CsUd5zL7SlcdsRMCp36bQn17KpNVNjq2RkEe+sbQmP1nbK7zouQEY5e+gWuOIl2/hKrxgmKkCMW3nRMWc7h+QCUgDxrVY2gqWKlwvlACWFkRpobavNYXcAvFVpW1fnCOv9yYZWJ2Ad08AErZXajDmugFS1+OflX/77eATeJKfygl+uYu1sn4864tHkkOIhsSb+TZQxCvOrjpQ6GojyumBc2sL110q7M9SSTu9DwS1OotLar4JPeNCDGIWRewdkq27LaeoBfo1iB8nQMbA==
x-ms-exchange-antispam-messagedata: Azu+1/60zmKmTpDXquG/wtKTrvf00AdcfMGdtrnJPGipQNuc8pMCw43KPySpQC0fWK8XGmbDq8OtLi/ekUx6nKRchz3VD+/hUxGUYQJjtW8riRymJm/6CCum40hHJ+MooLaPjyqWvBluXMePjSZjEw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6d3acf-cfb6-4dc5-fb5c-08d7d00987aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:39:24.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9u2fC/uT7Yfquc1ga456Toon0R2NNcim2TgNSIQp6Ec2Bq+22UxISwQyDQ2KRqVThWK7nNY3em8GBTKmYYJEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2748
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I hit the same problem and have worked with the developers on a patch.   Yo=
u might give this a try if you are building your own kernel/driver.

https://www.spinics.net/lists/linux-pci/msg92395.html

-----Original Message-----
From: Haeuptle, Michael <michael.haeuptle@hpe.com>=20
Sent: Tuesday, March 24, 2020 10:37 AM
To: Hoyer, David <David.Hoyer@netapp.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




Hi David, yes, it does.

-- Michael

-----Original Message-----
From: Hoyer, David [mailto:David.Hoyer@netapp.com]
Sent: Tuesday, March 24, 2020 9:35 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

You mentioned that you are using the latest pciehp code.   Does this code c=
ontain the recently introduced ist_running flag?

-----Original Message-----
From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> On =
Behalf Of Haeuptle, Michael
Sent: Tuesday, March 24, 2020 10:22 AM
To: linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




From: Haeuptle, Michael
Sent: Tuesday, March 24, 2020 8:46 AM
To: 'linux-pci@vger.kernel.org' <linux-pci@vger.kernel.org>
Cc: 'michaelhaeuptle@gmail.com' <michaelhaeuptle@gmail.com>
Subject: Deadlock during PCIe hot remove

Dear PCI maintainers,

I'm running into a deadlock scenario between the hotplug, pcie and vfio_pci=
 driver when removing multiple devices in parallel.
This is happening on CentOS8 (4.18) with SPDK (spdk.io). I'm using the late=
st pciehp code, the rest is all 4.18.

The sequence that leads to the deadlock is as follows:

The pciehp_ist() takes the reset_lock early in its processing. While the pc=
iehp_ist processing is progressing, vfio_pci calls pci_try_reset_function()=
 as part of vfio_pci_release or open. The pci_try_reset_function() takes th=
e device lock.

Eventually, pci_try_reset_function() calls pci_reset_hotplug_slot() which c=
alls pciehp_reset_slot(). The pciehp_reset_slot() tries to take the reset_l=
ock but has to wait since it is already taken by pciehp_ist().

Eventually pciehp_ist calls pcie_stop_device() which calls device_release_d=
river_internal(). This function also tries to take device_lock causing the =
dead lock.

Here's the kernel stack trace when the deadlock occurs:

[root@localhost ~]# cat /proc/8594/task/8598/stack [<0>] pciehp_reset_slot+=
0xa5/0x220 [<0>] pci_reset_hotplug_slot.cold.72+0x20/0x36
[<0>] pci_dev_reset_slot_function+0x72/0x9b
[<0>] __pci_reset_function_locked+0x15b/0x190
[<0>] pci_try_reset_function.cold.77+0x9b/0x108
[<0>] vfio_pci_disable+0x261/0x280
[<0>] vfio_pci_release+0xcb/0xf0
[<0>] vfio_device_fops_release+0x1e/0x40
[<0>] __fput+0xa5/0x1d0
[<0>] task_work_run+0x8a/0xb0
[<0>] exit_to_usermode_loop+0xd3/0xe0
[<0>] do_syscall_64+0xe1/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
[<0>] 0xffffffffffffffff

I was wondering if there's a quick workaround. I think the pci_try_reset_fu=
nction would need to take the reset_lock before the device lock but there d=
oesn't seem to be a good way of doing that.

I'm also trying to see if we can delay calling the vfio functions that are =
initiated by SPDK but I think this inherent race should be addressed.

I'm also happy to submit a defect report if this emailing list is not appro=
priate.

* Michael
