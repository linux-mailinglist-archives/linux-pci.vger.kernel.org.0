Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F281914DD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgCXPh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 24 Mar 2020 11:37:28 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:25048 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgCXPh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 11:37:27 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OFTdaX028506;
        Tue, 24 Mar 2020 15:37:25 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2ywddpfe8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 15:37:25 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 8BE46B4;
        Tue, 24 Mar 2020 15:37:24 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 24 Mar 2020 15:37:24 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Frontend Transport; Tue, 24 Mar 2020 15:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTFgsD5zFRCLg9USYduptzYT1RWCz/7fbIRtg+Fjun9zD4b3gp5k+M3ue/XH8ID5Z2lRY8z7QxkYgFSQlLwArAZznWI2sj4HCRqHyAGgiLGclCPFT59utGDZZfVQ7qUBSiKVUIVwdGU9c63oH7IS+sE6FAOvKcWSvEAkJFLL0v5aYajgp2M/sNRq6intnUew9Nz0KSy27OpKxEj8PUNHMh7KT1Or2gC6OpJTo5UsQO71G8FC8CPd6Jdi2krnc+7+q4xF+Gq7vU7R8gOG76UoTux6OCHXsk+TdDkKYO0zGAHPT7SZuV0I0w8omh/uu+O1CnpJla8ZkGRf763epvjpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8rODActuFO6Z+rd0acjgSm8SgovjCpGfOk+o7dA+60=;
 b=XGhGRtV8ejMn5GLp948UeHiNuGNxvonf1L05D+ayKudLVEgFEX3N6uICCYPCLDjV3ZBnvFzqcoqdug6YIbvlJ6oaM+HiDaFbxdhbF9Pjw7tCaW/NM6VG9E8dshc6TlSISjMRIGsFCmr08m9FU4GEoyY9OkZzYSSHYi9fCV2RdTGGV+JA8CwklK3DfUGCzsTlCYVDqo4voFz2+GVOdnsFVGDd/rhxEuGNngpW82vnOYYB5FU5OlRq71Cs8uhsfPKXdaAupVREtgbhDGIMBZ2S6HmU9oWfmhc9nmLrFYeoo7ni5awJX7NpPsckm5tlxjObSVWX2vlUVN1+Q57eLxYehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB0502.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 15:37:23 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:37:23 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     "Hoyer, David" <David.Hoyer@netapp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFAAAEZcnAAACX0QA==
Date:   Tue, 24 Mar 2020 15:37:22 +0000
Message-ID: <CS1PR8401MB07289568BBE041784FBB326E95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
In-Reply-To: <DM5PR06MB3132D4C5AA587EEC211C9FB892F10@DM5PR06MB3132.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5433b4a-0de0-415d-96da-08d7d0093f37
x-ms-traffictypediagnostic: CS1PR8401MB0502:
x-microsoft-antispam-prvs: <CS1PR8401MB050253C6C3F414F31A37BD0495F10@CS1PR8401MB0502.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(53546011)(316002)(26005)(66476007)(66946007)(186003)(66446008)(64756008)(66556008)(6506007)(2906002)(110136005)(52536014)(5660300002)(76116006)(7696005)(478600001)(86362001)(4326008)(71200400001)(55016002)(8936002)(9686003)(33656002)(81156014)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0502;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuF+MG57rvkIUv2+9CMmrZSWfVSkzULHIXIKwNkLwcYBHrE+Er0ZHOrDN5zzOcsxrnNJtobZaruaIO4dHe35780NjisW12jtKpUaz9vt5ojiwN/rMYuNwydUYKHB7PECUqZl9GubVx0I1v5H6Rt9COL6adplYksCEd8B8tvLCmGdLPZYgnmZCR+faHGAlvdSfB06AjSaAhf9VTNhjZ5EvByU2Y4oinIcJnu9cgIFb+POuLru9RzonaCdC9yvXzqAGz7LmMFi4GlGGCZNHKibZcgfHcp+KZozPKeGtUGk5gJzSnbc/qH0J+SDXY7DSgo5440GOt42Nxa4q112d3MIPmYB13N8zvhVUjoGcL7LXWPtA6i1XLuyLjFRz96oGq6RWQlIFGWDVQC18tQBf0gTH220Fonwxx1E+zlH74QKJmFPGOERtU4K418Ds6uSBH0V
x-ms-exchange-antispam-messagedata: 9mmKHaZVvXCtnbLoPAq8C0r3zZlUqGaxJKqsmVHhR1r6wjyFDk8tIOeEq8HL8RPMrL3f+6e2rcB7bFwmgnC4TQknVDjaW8pdQ/UJnoUph33JC2f+KLAWf3cLA6ReYNyg+VrTz0FeHKfC8u2a4th59A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-Network-Message-Id: f5433b4a-0de0-415d-96da-08d7d0093f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:37:22.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBut6hli1ns4SYJ7E5wrEEY3Md/k5GtIezfPSwBtCv018ee0qMAqqiC0YVYbgpAk/MUXdmxToT9HYeWXKro13F9AXx/i4TDN0cjZWpo1GCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0502
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240085
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
