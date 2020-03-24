Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30F919164C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgCXQ0x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 24 Mar 2020 12:26:53 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:16176 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbgCXQ0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 12:26:51 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OGDA19030384;
        Tue, 24 Mar 2020 16:26:49 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ywbt0rc8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 16:26:48 +0000
Received: from G9W8455.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id BA09A72;
        Tue, 24 Mar 2020 16:26:47 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 24 Mar 2020 16:26:47 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 24 Mar 2020 16:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td8BfZdJlqkptLFDcefNtmXaXTysyUY00h3Q0XLnXAaCA4nkMHZbrQmrXrWG22v+0mQrmU7K+nium1WR9QwFreTXtXPpOQwqmvBo8YIUWnD7mb0/VUys38EVMDZT8mPW0wlo5hku8fSJC9+M0WoDDxFDyMYmtgMRcozl7io+xRlWOCUCklVNpwP+buQfz7JD9nzLRpVJImSj8sBfuUImUMlTvnlw34fgTAHhXNjnn3bCfhjAIzjKxTUn/6yYHGdnkcaQxk1gCS1gtg+sGOzaPATtur9qJ8HAIprld6ZgIy1ewdIta1nuGmUmqRMOUlxd66jFI5atQajlx8MAVbiEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1L9v8KB7ZQa+hd67BPUYqXYCg9BPWurtYbmnUw+ymg=;
 b=PvH4iCcYll1gycFQGeyD0zuA9pzumUG52OZz3Q6OreaDhncGD7lCVm2IlcQ1etxt2rnKlbkAGQn0RMF9p6HZpV5XnM/0SGCN6HDLbgkNIZ4UQq5/GnGTDMFyET/rQ2kalecBFHr9FK9Uus0n9JWEGwGJCd7ufDM60WKZxU9HCTHFiPrYOpnb0YOOYCd4rxTzlDMyUKxM+J3s48YuLR26nJm2G6n3on/xG9yQT3BRhfRwoze57nwO02xqGETdkePjIwOfhso/GipUH6JVieM2mcsYu2hkgoz55OhJ2igap/Q/BYO4NoaMGn6LXejnkDFw2MBEVQA3sXoHiRGo8hVunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB0885.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7510::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 16:26:46 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 16:26:46 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     "Hoyer, David" <David.Hoyer@netapp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAEZcnAAACX0QAAADQLAAADyYXA=
Date:   Tue, 24 Mar 2020 16:26:46 +0000
Message-ID: <CS1PR8401MB07280E920BC8B0F55088610395F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
 <CS1PR8401MB07289568BBE041784FBB326E95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132687F173C2BACB88136D292F10@DM5PR06MB3132.namprd06.prod.outlook.com>
In-Reply-To: <DM5PR06MB3132687F173C2BACB88136D292F10@DM5PR06MB3132.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1adeab9-2cad-42c7-107e-08d7d0102574
x-ms-traffictypediagnostic: CS1PR8401MB0885:
x-microsoft-antispam-prvs: <CS1PR8401MB08855B8F2E82C3B70AF5A46395F10@CS1PR8401MB0885.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(136003)(396003)(5660300002)(110136005)(76116006)(316002)(81156014)(66446008)(66476007)(9686003)(55016002)(966005)(4326008)(33656002)(8676002)(66556008)(81166006)(64756008)(66946007)(8936002)(52536014)(6506007)(86362001)(7696005)(26005)(71200400001)(478600001)(2906002)(53546011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0885;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0MMlTWbUux/fVhjzqNb72f0YaGHNbMiobFo58pmDsiAhMNUNJqkeuKUthP0f9pt3r4U7jbCelJcND7TjVXYAf5EsoKdilx6fV4l/VeTjGaXKyrB2xnn45AchypeeUy53TsPWBEWdUrAXFyxO3cI772dgh304Hs7ATqNLvawyPaSB/PmOiLG30J8Urac4yKi/GfPQTPc+jZdNtqozi4RFTpReZMqcWL3oszckF+mZb5y+Par+T3RV7cVqnZ/fBJIYfLOH7hXZoNJoFwOkATL0/ImFaHG6CB6huD40XtNrJzr+wlhYWaJEyJu+F8+l2R0VSX+RXqskZurP1P0lsZSqduxuWlMbkVn+Q/XGfkTfAizlm8W5kP+1p3TAzFOg4Wn2dXk5hId0KfoGG0sBXLGe3NMCkpcfjNhNCnOhQ04a5Am6dwh7iBZ4DbjayRNOSeiO0fTavPP2f+TottqkYxURQSq3KL2oe0M/yxYEH9xoGiCna8VITzhPOcAeU1YwdECg27t24WR41G8n0vLfTHliA==
x-ms-exchange-antispam-messagedata: rkcTGzHzBrtqY1tYoHNgwUvdnt2F3PVrBDVPYLnwLfq13PZJInAmAeH+bzip0DndqniZFuELn3Op0a96p2CCr1xNNYYECCmALHtXs1/VJUpFCEs6Y/7FhoRbTZbHluSC1XLRTgIE/YfWlpDAHLPzJw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: e1adeab9-2cad-42c7-107e-08d7d0102574
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:26:46.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/IgrONMuPE0UH3K2XGoZz7EnPLmwctN5yNz6QYXUv4Vxto+AUthU15LW8bH5B5wsrFWRpkQFZejtL8Ln6IHy4l5JNG9tY/Pyw6CW6KpkDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0885
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240087
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

Unfortunately, this patch didn't help. Just to illustrate where the deadlock is happening in case it wasn't clear:

1) pciehp_hist takes ctrl->reset_lock

2) a user space process calls vfio_pci_release (implicitly via munmap())

3) vfio_pci_release calls pci_try_reset_function

4) pci_try_reset_function takes calls device_lock

5) pci_try_reset_function eventually calls pciehp_reset_slot which waits on ctrl->reset_lock

6) pcihp eventually calls device_release_driver_internal which waits on the device_lock

It's that user space process calling into pci_try_reset_function that leads to the deadlock issue.

-- Michael

-----Original Message-----
From: Hoyer, David [mailto:David.Hoyer@netapp.com] 
Sent: Tuesday, March 24, 2020 9:39 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

I hit the same problem and have worked with the developers on a patch.   You might give this a try if you are building your own kernel/driver.

https://www.spinics.net/lists/linux-pci/msg92395.html 

-----Original Message-----
From: Haeuptle, Michael <michael.haeuptle@hpe.com> 
Sent: Tuesday, March 24, 2020 10:37 AM
To: Hoyer, David <David.Hoyer@netapp.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.




Hi David, yes, it does.

-- Michael

-----Original Message-----
From: Hoyer, David [mailto:David.Hoyer@netapp.com]
Sent: Tuesday, March 24, 2020 9:35 AM
To: Haeuptle, Michael <michael.haeuptle@hpe.com>; linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

You mentioned that you are using the latest pciehp code.   Does this code contain the recently introduced ist_running flag?

-----Original Message-----
From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> On Behalf Of Haeuptle, Michael
Sent: Tuesday, March 24, 2020 10:22 AM
To: linux-pci@vger.kernel.org
Cc: michaelhaeuptle@gmail.com
Subject: RE: Deadlock during PCIe hot remove

NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.




From: Haeuptle, Michael
Sent: Tuesday, March 24, 2020 8:46 AM
To: 'linux-pci@vger.kernel.org' <linux-pci@vger.kernel.org>
Cc: 'michaelhaeuptle@gmail.com' <michaelhaeuptle@gmail.com>
Subject: Deadlock during PCIe hot remove

Dear PCI maintainers,

I'm running into a deadlock scenario between the hotplug, pcie and vfio_pci driver when removing multiple devices in parallel.
This is happening on CentOS8 (4.18) with SPDK (spdk.io). I'm using the latest pciehp code, the rest is all 4.18.

The sequence that leads to the deadlock is as follows:

The pciehp_ist() takes the reset_lock early in its processing. While the pciehp_ist processing is progressing, vfio_pci calls pci_try_reset_function() as part of vfio_pci_release or open. The pci_try_reset_function() takes the device lock.

Eventually, pci_try_reset_function() calls pci_reset_hotplug_slot() which calls pciehp_reset_slot(). The pciehp_reset_slot() tries to take the reset_lock but has to wait since it is already taken by pciehp_ist().

Eventually pciehp_ist calls pcie_stop_device() which calls device_release_driver_internal(). This function also tries to take device_lock causing the dead lock.

Here's the kernel stack trace when the deadlock occurs:

[root@localhost ~]# cat /proc/8594/task/8598/stack [<0>] pciehp_reset_slot+0xa5/0x220 [<0>] pci_reset_hotplug_slot.cold.72+0x20/0x36
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

I was wondering if there's a quick workaround. I think the pci_try_reset_function would need to take the reset_lock before the device lock but there doesn't seem to be a good way of doing that.

I'm also trying to see if we can delay calling the vfio functions that are initiated by SPDK but I think this inherent race should be addressed.

I'm also happy to submit a defect report if this emailing list is not appropriate.

* Michael
