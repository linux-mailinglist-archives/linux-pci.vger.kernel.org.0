Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC119167A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 17:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCXQcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 12:32:36 -0400
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:13606
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727647AbgCXQcf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 12:32:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXhDg5ec7PohudZ5ahxFI8nlaAiOusZSpCrgOsCP4dPYkN8FOoaw3SFbUZyW3XyGRFka166b05f49yN1UFxCdEp7hpvkUd3zSnhFNDMlxWS0Qmar5XudQ6L8wzzfiYVrPhplmbpSRPdxwF/XB6Y8SX/uh7DP9qloLz80z5Ubw55cy/4gfSSV2gkRfAnl9uZmow9r2OldrFZW3IHVobsOiHj3yWn/K7keK0O2H5jHub/x0JHcIQk8c6grUNmCDdS5hyexD48PlLnPY9AWLCrB0WrNmljdJiJxZXM4V/eMWj8tPjrkyM0FymX/MRF/7uLSQeDV2Yk4HYQ4t008BH2fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSt4GCpHH+N7bbpGMh8ELc0FIlpp03wlENzNTYYTAwg=;
 b=mo7cl6MnO0Z9WFHFeMXiRrFfGSgkQcHCLtgVsPwywbFgKaGI/Vs7KTQWcrRWcRQsILDonINjs48xwOYFjqblWKYf2MlR/aWYNoHs1o/CX1jfagDbtDAFzRB+sjHtMxEnBVv3wCmIQP4VP66HlKeCD/CGoiYIpGBKayFh9OhKXEVbvhtD2n9PNsBvKaWmXtmfXmBxJUmMXnsyB1LeR2+JpwwNsbbOWh3os/zGV6P0TPaLcxPZUBLarKHqhCKrRH/engQGcfILyfh8EpsSZTMb/KPyT9yIpgY71hDgJi+XR3OYfjcUWjYtv5YKFlVFfI95bqJaZn5GAPwZP18m0dTNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSt4GCpHH+N7bbpGMh8ELc0FIlpp03wlENzNTYYTAwg=;
 b=vE6cs0/F+xC0wfaNTMWiQBHb+ls/PS3l6USjZxd0ufapSNoi03xVi46shWB8h5mpkCLodgfot0cS9uzjUTJxfkqeeI/Sv8TtrzIIJY3AIPzfQWuT3xY7wdBY31vxscAFMsN0aZ3wUW6J+xMNhGIzjl2trcg1EcPd16hxhHXgIU4=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB3308.namprd06.prod.outlook.com (2603:10b6:4:43::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 24 Mar 2020 16:32:32 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.027; Tue, 24 Mar 2020
 16:32:32 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAEZcnAAACX0QAAADQLAAADyYXAAAOxvYA==
Date:   Tue, 24 Mar 2020 16:32:32 +0000
Message-ID: <DM5PR06MB3132E32994F39EC7D4F1EE7792F10@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
 <CS1PR8401MB07289568BBE041784FBB326E95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132687F173C2BACB88136D292F10@DM5PR06MB3132.namprd06.prod.outlook.com>
 <CS1PR8401MB07280E920BC8B0F55088610395F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB07280E920BC8B0F55088610395F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [216.240.24.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db3f963-6762-455a-5070-08d7d010f405
x-ms-traffictypediagnostic: DM5PR06MB3308:
x-microsoft-antispam-prvs: <DM5PR06MB3308B8B16B60681D9C94F95F92F10@DM5PR06MB3308.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(76116006)(186003)(110136005)(296002)(71200400001)(26005)(478600001)(8936002)(86362001)(316002)(966005)(81166006)(8676002)(2906002)(81156014)(66556008)(4326008)(66946007)(64756008)(66446008)(66476007)(55016002)(52536014)(7696005)(33656002)(53546011)(5660300002)(6506007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3308;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUpQ/bglv12snXPI87u80Xv+TxL8yzGx63jVkgKLY8CeO2d2hf3Opy3BH5yKX6Gde4hHIblZ4StIHpLYbV/3nul8b+SZXV2x/zPGXaC/pNXS6ljyjloRbNP0sBpqjcnUWhKyUZQrsU7eNKjdyMY5Q2YEukjQHftMzvX/bnUBF9M39CqIXfYyWjxYIg71IaYJlKabbGv7avCdSzQaoYkSZAMn9PpAdn8SDBtdE+QSuU/GgCiWhVcCJx4zLQmp2Udvs+YHk3p5mSyuaZFSgDqn9jENstEfHC5OkQO4fu1Pcoz5DtzAhjDUboWvcR7jdGyoeKPal/QAsJ7YXLBTmyH8eYnSomgTMwvcRIs2GG6f3JmIu4Y55Y9UlQ8jM3dF5epCXN5gBpfDzdlz+xVuzlNmA6ZR0wRDq7gcGizVkpRY/uPlFat3TrVz4FS0V3ilkuEEbKpjUVhlkNO6RNiePBZjbHARWFy0jhXX5WAry8xG3sSHjHk9ueVoulGqc1q6KARAvhXecvWpreLhIez+Qudv/Q==
x-ms-exchange-antispam-messagedata: FC9G2595FI408DfgJzROGabCMsKPePpeFMR6ifbDf2z3/Vh8WLh6hDYCay99Ddi39W0ujLyB/LQiYqN7o9qK1cUtkdU7CFKvVLW6UQWtXaau+PiA7dLL1GMXKif+fF9JKvG2IyS8UO8ij9wSzoUtQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3f963-6762-455a-5070-08d7d010f405
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:32:32.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdcJUeF8GV2nUZOGoqBkF3z4G4O4c9FWFezgDB11JYMFmd4sYMdOouz7HzlCM6NgArTydh6OfEMCgwwYG1+OfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3308
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok - sounds like it is not the same issue then.  I just was trying to feed =
you info in case you hit the same problem.

-----Original Message-----
From: Haeuptle, Michael <michael.haeuptle@hpe.com>=20
Sent: Tuesday, March 24, 2020 11:27 AM
To: Hoyer, David <David.Hoyer@netapp.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




Hi David,

Unfortunately, this patch didn't help. Just to illustrate where the deadloc=
k is happening in case it wasn't clear:

1) pciehp_hist takes ctrl->reset_lock

2) a user space process calls vfio_pci_release (implicitly via munmap())

3) vfio_pci_release calls pci_try_reset_function

4) pci_try_reset_function takes calls device_lock

5) pci_try_reset_function eventually calls pciehp_reset_slot which waits on=
 ctrl->reset_lock

6) pcihp eventually calls device_release_driver_internal which waits on the=
 device_lock

It's that user space process calling into pci_try_reset_function that leads=
 to the deadlock issue.

-- Michael

-----Original Message-----
From: Hoyer, David [mailto:David.Hoyer@netapp.com]
Sent: Tuesday, March 24, 2020 9:39 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

I hit the same problem and have worked with the developers on a patch.   Yo=
u might give this a try if you are building your own kernel/driver.

https://www.spinics.net/lists/linux-pci/msg92395.html

-----Original Message-----
From: Haeuptle, Michael <michael.haeuptle@hpe.com>
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
