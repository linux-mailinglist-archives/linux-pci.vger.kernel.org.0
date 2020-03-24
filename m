Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A2191489
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCXPfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 11:35:15 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:30561
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbgCXPfP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 11:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsQBVJA+8N65jbmGGGhEjSFmtNoRCnbMcR0uIDwW2Yf5uV/7YKjVf+DNh8agjx+BjFoNivu5w26MqDUXl5Rj1ITEPg5op0O0xO6dsEnRDj7XIcn4TNS/mDfffW5uHwBKBZUjpT+Fap4XE34tA29V1rnbncCNkmMTU25mq03WAg6Jq9SIWgX5JOEcTn4BitnXfI/6qIWsgxSDVStkSZVkfucoMlR+wqN3jabNN6qvqTlIDlvzpHnNnhlDjGlqUphESL+bgV328UbF0plLLqcj4AF6TBULwSzLsN7lus+XrU9mjmmtOReWLXFZjRaK2JxEKsy2khB8m2iazkeGxI23xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JsEBY4j00nATxY+fIRCmAJNf2KWa2YqnvuDuqiR+Ks=;
 b=U1yyjZXkuwSSz4oypjslNVGdPgSvoCSgkxnKkta0y5+EfUDv8LC45O/axFySh9WCTDygILYAyYgPw4yPFhiT3mXQiVA7usZv663NjjYYKucLVN5U3nHlAqbAeP8psVkCk2rTzoeVj2hogYUTFk7V5Bk6rbjm46NeV0M2eE6hZwNQwsb28l/zqgWN0a5dgldDR+NSLpVzhJz7RlcE1C8dY8oLijsCtUmZW1qftBk5wxSK611NavdiYqZvOrkAps1sE6efxr9Dq6CJUtMpWd9en+fEaKd7jWaRR8MurTNRr04OMqySFuevOmtGef1CovW74kEJLpfnKRF8h0DIHXlP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JsEBY4j00nATxY+fIRCmAJNf2KWa2YqnvuDuqiR+Ks=;
 b=GtkyZHcjFL0FNhO4UooQNfcMoiKyJNFGsdm61f0eF8GmCiqMqa+XwmURFSsD0Kk5NYuxhn+cD8C3hv0ZmMp4VqGMc0RZRJMugeP+Z6aN8bUBUKY3J9M4RqG7M4gMZyWdZi4ihpP6Mmlgz/WVJcDiNw8+2da9GMPpmQ1Zb/9SreY=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB2426.namprd06.prod.outlook.com (2603:10b6:3:57::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:35:12 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.027; Tue, 24 Mar 2020
 15:35:12 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAEZcnA=
Date:   Tue, 24 Mar 2020 15:35:12 +0000
Message-ID: <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [216.240.24.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ada783f1-b56f-46f9-3301-08d7d008f19e
x-ms-traffictypediagnostic: DM5PR06MB2426:
x-microsoft-antispam-prvs: <DM5PR06MB24262CD287E5A9CC8BC9897592F10@DM5PR06MB2426.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(76116006)(66446008)(8676002)(66476007)(7696005)(81166006)(296002)(316002)(52536014)(6506007)(5660300002)(2906002)(26005)(81156014)(478600001)(4326008)(53546011)(71200400001)(66946007)(64756008)(66556008)(8936002)(110136005)(86362001)(9686003)(33656002)(55016002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB2426;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u3CZoY6SJyXwRSSS6c7gkkAnlyCof5gGdZZnsrPifXbaR453jqOixeREA8tX2ln5C99V7S4sBqzciiNgUFD7nTGYfMpMHANFiZrhRvUvRkVm6bCRRv+Rr55AH9BzOJmM4udWD1ISwi9D6epFTBTGfBy1BjPhRHB4mOuRt2VhsgrkeYdcBLWREn34eKbM8BzrQuQXxpBE3aJyUP7VMKMKH7FJ9jIP6Vt1eHHKo5B8EvAS3eoTQ8hRuBYYoKO/QFoXd6qVRI2OvjWyqCUB8dL6Nz0NIdcNBMPmoKQBRi4CbAsk7MYommejQ5bGkp3/W8AdxPLysFbfEyINzwxNTBdGRCqAvp91QjyTQ0wYUmMh4QBW0xM+QEWyxNp/UOuDdaxPPh2Pv0wSIyla04VMAlQhVFFaHO0bblm+FD0Y818dKCquSKjk0EsIll4QgGr/xh0
x-ms-exchange-antispam-messagedata: D1y3kNM4rPitbLXpbooPCcYyybyF+Yb9TYZ2y0sNycJ9R/hfxy/p3bpD69SGDM5pbRkHDtoUps/Uj0D6uh4Ti3paHwVHk1o3LzqZiIG4G3qV3V+cm0/GWr1Krv8U/yrzV8IB7QZLoUqwU1pxqyJLFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada783f1-b56f-46f9-3301-08d7d008f19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:35:12.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaEn9mw2pUjC2puvbBsx2WPZjWAyjOdjbeh2lJ3q1NLFP6y8Ek8ZoH80sGPO2Dm5ThRtJM7rThT8YZ9NskHDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2426
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
