Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B612191428
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCXPV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 24 Mar 2020 11:21:58 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:16196 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbgCXPV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 11:21:58 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OFKCvO027434;
        Tue, 24 Mar 2020 15:21:55 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2yyfwy2gw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 15:21:55 +0000
Received: from G4W9121.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 1482FC2;
        Tue, 24 Mar 2020 15:21:55 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 24 Mar 2020 15:21:54 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 24 Mar 2020 15:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxNlGsR3qKDq5T1wKSsvnx6OKWipmlM+IlyX3fmDFWeZgY/JDgCTZEEBaKtM3qTAcCYp8B8xfokuhuoKIkXg+pVKsbxxXqKW5pW+2d2MNZAO7MZziSLksfLQIq0z387BxRj69BinvgnVbiWnzAw8g/ZneWdBSLqkyv8ApZlkq6amjLnkp1Ag7ZHx+PJbyqVmCkCZgbdyUbiubqmLu5GL2vnrCOsdV2nXf2IOmBFa6PcLxHgGVq59PbN/DnLaP+shH7ufQrTleRosLhh2Rra5Vy4VeyQN23QCnFUkpvEi/ymxVrw+h03kQP8Df37QSi15b1oZ+b5ERBSVxiz+F2rs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8o1KagL3RpAgjPvBwbN8bBI1D3mWVio9GR0Z+eVZ14=;
 b=MVFx3oRLZhO3Fh1Gr3Ym/jle2kRcPnsUOWzkRdLkM4uLG3zrzbPolJ8MxC6bvEdt5z56+IO4dAiP9k13Beq66j5ZYNgD0eAR4oZyBb/iFvD3wCxNuZ6AvPl405+5ECotu1UQhk+ChRmn/67DavrlW5Ai5rF2Bc8FCuPAdLMkX+P0Ill5UeC75jmuOAkmAaSRYnLPBMnrlH8leM12K3pev1aNMHh0H9lispRHxR14IpD2pZOF2hrrh6XhpRePibfWqQiYPmsI1CKXrj3cIemRt4mF1vMUZjoYL+fRZeyhhxkMpAvUV+FBectzTtqY7TEDtmodd9UUeV/4rFJwOgYcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::23) by CS1PR8401MB0421.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 15:21:52 +0000
Received: from CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63]) by CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6:bc44:30cb:4e63%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:21:52 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: RE: Deadlock during PCIe hot remove
Thread-Topic: Deadlock during PCIe hot remove
Thread-Index: AdYB6Gv3K0A6oSaTTxyvgTO56UtwywABKdFA
Date:   Tue, 24 Mar 2020 15:21:52 +0000
Message-ID: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3340843-aefe-4144-de72-08d7d00714b0
x-ms-traffictypediagnostic: CS1PR8401MB0421:
x-microsoft-antispam-prvs: <CS1PR8401MB0421F586FCC11CC02047573595F10@CS1PR8401MB0421.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39860400002)(8936002)(81156014)(478600001)(7696005)(2906002)(71200400001)(186003)(53546011)(6506007)(86362001)(26005)(8676002)(4326008)(5660300002)(52536014)(6916009)(55016002)(66446008)(66556008)(66476007)(81166006)(66946007)(9686003)(64756008)(33656002)(316002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0421;H:CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TTJ5CnptxXlmYv5l5pDkIuh44urfnKog63UWJJJg+4gMBn4QSnyvthRRwvnOEp7YC9rLQ1M1lvX/zVOcehV8xqTjcHCUdyE2pbsKQ6mvbS96OrfmV4ZH8kvakbsBzKbITp+H/gpGvWIKRmRHFpth1puXwJhJfFdvR7VFWYFbBmBZrPcvQZEDMtemdAouRL7AOpQU2RCBNFRDe2gBIdlBwHSYeiGZnhi7sh9Gqsg58uKqX+AhQMZhSNMlACLPaqh4jCHQS8mevDBUKz0AJTNGZlMOAXGdP/nDc2M4EZMRQYP9IWyhKmNK1qit5k/EE5Bapi2xSDai2bD9cYJspeq+v0DpKMYHlJuU1d9ZlbYS9Ug/9zCLyqS//Q5v47FUki+m3/fswwuQglt2iRzvUH6Vw1nPp3YyZwzhdIDBn8yHINSntKB+zvp2zfzizNKy7ck
x-ms-exchange-antispam-messagedata: 7damsQW5EeWqdUgUmNdBm2HVJqXvPDg/Bxcuu9UFbdeejG/PovjMhSyagLgsLUBQOM5wJ7Qp411bh4EnfudAwTYrjRCawT3Tu9OmFHVw36VLBAYX0fbgZNnVQNoyq+eNd2kDnleJWV+Qt3vvObL/yw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3340843-aefe-4144-de72-08d7d00714b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:21:52.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNGvJJPyyFnTyFpszG6CLb1d3hA2r14Ffu61JSkvvselm+pI6VpQShyBoOul2fT5uKhwaUzFROqKtqsWDenqHFXW12/+JYcn5+k9u2U8wjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0421
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240085
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



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

[root@localhost ~]# cat /proc/8594/task/8598/stack
[<0>] pciehp_reset_slot+0xa5/0x220
[<0>] pci_reset_hotplug_slot.cold.72+0x20/0x36
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
