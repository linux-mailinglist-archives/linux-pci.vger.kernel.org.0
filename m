Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E463264C632
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiLNJnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 04:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLNJnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 04:43:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DEB1164;
        Wed, 14 Dec 2022 01:43:50 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BE9JNAd030739;
        Wed, 14 Dec 2022 09:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3gi2wou0ABUxjcEbKd+Ly/BoyUYxoUun8qeNZxBHXk8=;
 b=WebdvC2mdzQrlkTlbWKZTLWmtApdcOjcRKjhp7t3Dl5CRANZK/TjSxmOAJlkVdArVCw0
 LOSx8weGbzY+IchpisChrnOOuUOlctDEDjOzjyqSECPhyFJutU49mtwA9rnWi4FyGiUO
 +sZw70ZZBbR2x1YbfxkyEj0vogorBT9yBvGA/Gg5gAbjpyZ3N5/5MsSRMDMS1ljKrvOS
 6dksP83QC0qzIvSsZcjWxxzNHJdAJCgX50hVzwI33lBFoQ0tvU58hVIYsPwVlX1VlZIF
 b1jXvioAxUECxfwbBHqh1VboXHzw9rHsFa6zmFmfsBA3qMZnQ4Je04/kYUQMDuUxOdvA og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfbragn4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:43:07 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BE9JQpL030801;
        Wed, 14 Dec 2022 09:43:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfbragn31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:43:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJsvI5001267;
        Wed, 14 Dec 2022 09:43:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3meyyegu6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:43:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BE9h1qc45875688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 09:43:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6ECF20043;
        Wed, 14 Dec 2022 09:43:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3837020040;
        Wed, 14 Dec 2022 09:43:00 +0000 (GMT)
Received: from [9.171.85.81] (unknown [9.171.85.81])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Dec 2022 09:43:00 +0000 (GMT)
Message-ID: <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Date:   Wed, 14 Dec 2022 10:42:59 +0100
In-Reply-To: <20221213190425.GA3943240@roeck-us.net>
References: <20221124230505.073418677@linutronix.de>
         <20221124232325.798556374@linutronix.de>
         <20221213190425.GA3943240@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EeQ_SiAy6ENmzT2Azb-RUaKQJdAJHn_5
X-Proofpoint-ORIG-GUID: HEfarUzCsFVgUxMVi5EnE0CS7YI4lpn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-12-13 at 11:04 -0800, Guenter Roeck wrote:
> Hi,
>=20
> On Fri, Nov 25, 2022 at 12:25:59AM +0100, Thomas Gleixner wrote:
> > Per device domains provide the real domain size to the core code. This
> > allows range checking on insertion of MSI descriptors and also paves th=
e
> > way for dynamic index allocations which are required e.g. for IMS. This
> > avoids external mechanisms like bitmaps on the device side and just
> > utilizes the core internal MSI descriptor storxe for it.
> >=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
>=20
> This patch results in various s390 qemu test failures.
> There is a warning backtrace
>=20
>    12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_val=
id+0x2a/0xb0
>=20
> followed by
>=20
> [   12.684333] virtio_net: probe of virtio0 failed with error -34
>=20
> and Ethernet interfaces don't instantiate.
>=20
> When trying to instantiate virtio-pci and booting from it, I see
> the same warning backtrace followed by
>=20
> [    9.943123] virtio_blk: probe of virtio0 failed with error -34
>=20
> and a crash.
>=20
> A typical backtrace is
>=20
> [   12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_va=
lid+0x2a/0xb0
> [   12.675108] Modules linked in:
> [   12.675346] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N=
 6.1.0-03225-g764822972d64 #1
> [   12.675512] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [   12.675648] Krnl PSW : 0704c00180000000 00000000001ec4c6 (msi_ctrl_val=
id+0x2e/0xb0)
> [   12.675853]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [   12.675987] Krnl GPRS: 00000000435318a9 0000000000000000 0000000003551=
0a0 0000000000000000
> [   12.676069]            0000000000000000 000000000000ffff 0000000000000=
000 0000037fffb1b6c0
> [   12.676151]            0000000000000000 0000037fffb1b658 0000000000000=
000 0000037fffb1b658
> [   12.676232]            0000000002ae4100 00000000035510a0 0000037fffb1b=
568 0000037fffb1b538
> [   12.677127] Krnl Code: 00000000001ec4b8: 58303000		l	%r3,0(%r3)
> [   12.677127]            00000000001ec4bc: ec3c000f017f	clij	%r3,1,12,00=
000000001ec4da
> [   12.677127]           #00000000001ec4c2: af000000		mc	0,0
> [   12.677127]           >00000000001ec4c6: a7280000		lhi	%r2,0
> [   12.677127]            00000000001ec4ca: b9840022		llgcr	%r2,%r2
> [   12.677127]            00000000001ec4ce: ebbff0a00004	lmg	%r11,%r15,16=
0(%r15)
> [   12.677127]            00000000001ec4d4: c0f400714f1a	brcl	15,00000000=
01016308
> [   12.677127]            00000000001ec4da: b9160033		llgfr	%r3,%r3
> [   12.677743] Call Trace:
> [   12.677835]  [<00000000001ec4c6>] msi_ctrl_valid+0x2e/0xb0
> [   12.677943]  [<00000000001ec58a>] msi_domain_free_descs+0x42/0x120
> [   12.678024]  [<00000000001ecaf0>] msi_domain_free_msi_descs_range+0x38=
/0x48
> [   12.678103]  [<00000000009db7ae>] __pci_enable_msix_range+0x44e/0x710
> [   12.678186]  [<00000000009d9da4>] pci_alloc_irq_vectors_affinity+0xa4/=
0x120
> [   12.678268]  [<00000000009f5888>] vp_request_msix_vectors+0xb8/0x208
> [   12.678348]  [<00000000009f5f24>] vp_find_vqs_msix+0x254/0x2f0
> [   12.678428]  [<00000000009f6016>] vp_find_vqs+0x56/0x1f8
> [   12.678508]  [<00000000009f4e4e>] vp_modern_find_vqs+0x3e/0x90
> [   12.678587]  [<0000000000ad8c14>] virtnet_find_vqs+0x244/0x3e8
> [   12.678669]  [<0000000000ad9268>] virtnet_probe+0x4b0/0xca8
> [   12.678748]  [<00000000009ed6b4>] virtio_dev_probe+0x1ec/0x418
> [   12.678826]  [<0000000000a3c246>] really_probe+0xd6/0x480
> [   12.678906]  [<0000000000a3c7a0>] driver_probe_device+0x40/0xf0
> [   12.678985]  [<0000000000a3d0e4>] __driver_attach+0xbc/0x228
> [   12.679065]  [<0000000000a396c0>] bus_for_each_dev+0x80/0xb8
> [   12.679143]  [<0000000000a3b38e>] bus_add_driver+0x1d6/0x260
> [   12.679222]  [<0000000000a3dc10>] driver_register+0xa8/0x170
> [   12.679312]  [<00000000017b8848>] virtio_net_driver_init+0x88/0xc0
>=20
> This worked fine in v6.1 and earlier kernels. Bisect log attached.
>=20
> Guenter

Yes, we were about to report the same issue. Currently in linux-next
PCI support is broken for both ConnectX based NICs, NVMes etc. Matthew
Rosato bisected this to the above mentioned commit on Monday and was I
believe still investigating details.


As far as I'm aware so far he tracked this down to code calling
msi_domain_get_hwsize() which in turn calls msi_get_device_domain()
which then returns NULL leading to msi_domain_get_hwsize() returning 0.
I think this is related to the fact that we currently don't use IRQ
domains.

Thanks,
Niklas
