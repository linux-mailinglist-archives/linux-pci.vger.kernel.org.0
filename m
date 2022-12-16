Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022864EC51
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLPNvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLPNvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 08:51:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0A4D5DB;
        Fri, 16 Dec 2022 05:51:44 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGC77na016200;
        Fri, 16 Dec 2022 13:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VFZ4MTdXlbfjOFjAA4BQAC6AERzE/EDfKr1EYTSI9mE=;
 b=PUSEr1Davilw9OrMeB+rSk17cODp9xYkmCNT6SdECkCjf8vcQiN4ilOAyWAsZvc4Hb7z
 MfQkv33vr2FALQduR4lFIj67VsgQPL/jQ7Tls2NX2SD0rLqkaIRFg778qwGmXYyPuNSZ
 rTZ3RBmqbCPo7EiniR4+tEgz2+Z99KpGy8vf2OU3HCCviGO4Ql9nSWzqPwHhRIQu+2m2
 ssfmgvytBqRvVgvcloPnNhbVFEViXIh6wu8jySTDoLdxx/sfY7KCdHLkLp9I6Rn00PSM
 zCRh6dlAjZNEHgigCBJYOBOGGZTM07RUJhbT8qiQdxGyjVqXffjt3EBoJ6CtvL/8Gro1 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgq584au5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 13:51:07 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BGDAMQA008893;
        Fri, 16 Dec 2022 13:51:06 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgq584at7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 13:51:06 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGCgZtA020797;
        Fri, 16 Dec 2022 13:51:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3mf07gxms9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 13:51:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BGDp3PD8782466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 13:51:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D56258054;
        Fri, 16 Dec 2022 13:51:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AE435805A;
        Fri, 16 Dec 2022 13:51:00 +0000 (GMT)
Received: from [9.160.114.181] (unknown [9.160.114.181])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 16 Dec 2022 13:51:00 +0000 (GMT)
Message-ID: <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
Date:   Fri, 16 Dec 2022 08:50:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <86wn6rptdu.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pFp8GjXlg3U7vUFhdUPD_teoVR03tnDs
X-Proofpoint-ORIG-GUID: WywdAnYNZDxur1Co8RwNWNs0CYpMYP2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/22 4:53 AM, Marc Zyngier wrote:
> On Thu, 15 Dec 2022 16:23:20 +0000,
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
>> On 12/15/22 9:49 AM, Thomas Gleixner wrote:
>>> On Wed, Dec 14 2022 at 10:42, Niklas Schnelle wrote:
>>>> On Tue, 2022-12-13 at 11:04 -0800, Guenter Roeck wrote:
>>>>> This patch results in various s390 qemu test failures.
>>>>> There is a warning backtrace
>>>>>
>>>>>    12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_valid+0x2a/0xb0
>>>>>
>>>>> followed by
>>>>>
>>>>> [   12.684333] virtio_net: probe of virtio0 failed with error -34
>>>>>
>>>>> and Ethernet interfaces don't instantiate.
>>>> As far as I'm aware so far he tracked this down to code calling
>>>> msi_domain_get_hwsize() which in turn calls msi_get_device_domain()
>>>> which then returns NULL leading to msi_domain_get_hwsize() returning 0.
>>>> I think this is related to the fact that we currently don't use IRQ
>>>> domains.
>>>
>>> Correct and for some stupid reason I thought 0 is a good return value
>>> here :)
>>>
>>>
>>>
>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>> index bd4d4dd626b4..8fb10f216dc0 100644
>>> --- a/kernel/irq/msi.c
>>> +++ b/kernel/irq/msi.c
>>> @@ -609,8 +609,8 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
>>>  		info = domain->host_data;
>>>  		return info->hwsize;
>>>  	}
>>> -	/* No domain, no size... */
>>> -	return 0;
>>> +	/* No domain, default to MSI_MAX_INDEX */
>>> +	return MSI_MAX_INDEX;
>>>  }
>>>  
>>>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>>
>> Ah, that makes sense...  So, with that diff applied, that fixes most of the issues I'm seeing incl. the virtio one that Guenter mentioned.  But it looks like NVMe devices are still broken on s390 with a different backtrace -- the bisect for that one points to another patch in part2 of this work and looks like another issue with missing irq domain:
>>
>> 40742716f294 genirq/msi: Make msi_add_simple_msi_descs() device domain aware
>>
>>
>> [    4.308861] ------------[ cut here ]------------
>> [    4.308865] WARNING: CPU: 7 PID: 9 at kernel/irq/msi.c:167 msi_domain_free_msi_descs_range+0x3c/0xd0
>> [    4.308877] Modules linked in: mlx5_core aes_s390 nvme des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 nvme_core sha1_s390 sha_common pkey zcrypt rng_core autofs4
>> [    4.308896] CPU: 7 PID: 9 Comm: kworker/u20:0 Not tainted 6.1.0 #179
>> [    4.308898] Hardware name: IBM 3931 A01 782 (KVM/Linux)
>> [    4.308900] Workqueue: events_unbound async_run_entry_fn
>> [    4.308905] Krnl PSW : 0704c00180000000 00000000b6426b78 (msi_domain_free_msi_descs_range+0x40/0xd0)
>> [    4.308909]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> [    4.308911] Krnl GPRS: 0700000080eda0a0 0000000000000000 0000000080eda0a0 0000000000000000
>> [    4.308913]            0000000000000000 0000000000000000 0000000000000cc0 0000000080eda000
>> [    4.308914]            00000000b7ddc000 0000000091934aa8 000000000000ffff 0000000000000000
>> [    4.308915]            0000000080344200 0000000080f2b1c0 0000037fffb5b918 0000037fffb5b8c8
>> [    4.308924] Krnl Code: 00000000b6426b68: e54cf0ac0000	mvhi	172(%r15),0
>> [    4.308924]            00000000b6426b6e: ec3c000b017f	clij	%r3,1,12,00000000b6426b84
>> [    4.308924]           #00000000b6426b74: af000000		mc	0,0
>> [    4.308924]           >00000000b6426b78: eb9ff0b00004	lmg	%r9,%r15,176(%r15)
>> [    4.308924]            00000000b6426b7e: 07fe		bcr	15,%r14
>> [    4.308924]            00000000b6426b80: 47000700		bc	0,1792
>> [    4.308924]            00000000b6426b84: b90400a5		lgr	%r10,%r5
>> [    4.308924]            00000000b6426b88: b9040013		lgr	%r1,%r3
>> [    4.308935] Call Trace:
>> [    4.308938]  [<00000000b6426b78>] msi_domain_free_msi_descs_range+0x40/0xd0 
>> [    4.308945]  [<00000000b6bb126e>] pci_free_msi_irqs+0x26/0x48 
>> [    4.308950]  [<00000000b6baf4d4>] pci_disable_msix+0x6c/0x80 
>> [    4.308954]  [<00000000b6baf716>] pci_free_irq_vectors+0x26/0x88 
>> [    4.308956]  [<000003ff7fdfa8f4>] nvme_setup_io_queues+0x18c/0x398 [nvme] 
>> [    4.308968]  [<000003ff7fdfbf1e>] nvme_probe+0x2e6/0x3b0 [nvme] 
>> [    4.308972]  [<00000000b6ba44cc>] local_pci_probe+0x44/0x80 
>> [    4.308974]  [<00000000b6ba46d8>] pci_call_probe+0x50/0x180 
>> [    4.308976]  [<00000000b6ba5166>] pci_device_probe+0xae/0x110 
>> [    4.308978]  [<00000000b6c0a19a>] really_probe+0xd2/0x480 
>> [    4.308982]  [<00000000b6c0a6f8>] driver_probe_device+0x40/0xf0 
>> [    4.308984]  [<00000000b6c0a80e>] __driver_attach_async_helper+0x66/0xf0 
>> [    4.308986]  [<00000000b63cfb72>] async_run_entry_fn+0x4a/0x1b0 
>> [    4.308987]  [<00000000b63c1368>] process_one_work+0x200/0x458 
>> [    4.308991]  [<00000000b63c1aee>] worker_thread+0x66/0x480 
>> [    4.308993]  [<00000000b63caa00>] kthread+0x108/0x110 
>> [    4.308996]  [<00000000b634f2dc>] __ret_from_fork+0x3c/0x58 
>> [    4.308999]  [<00000000b6f8da2a>] ret_from_fork+0xa/0x40 
>> [    4.309006] Last Breaking-Event-Address:
>> [    4.309007]  [<00000000b6426ba8>] msi_domain_free_msi_descs_range+0x70/0xd0
>> [    4.309009] ---[ end trace 0000000000000000 ]---
>> [    8.957187] nvme: probe of 0003:00:00.0 failed with error -22
>> [    8.957216] ------------[ cut here ]------------
>> [    8.957217] WARNING: CPU: 5 PID: 9 at kernel/irq/msi.c:275 msi_device_data_release+0x76/0xa0
>> [    8.957229] Modules linked in: mlx5_core aes_s390 nvme des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 nvme_core sha1_s390 sha_common pkey zcrypt rng_core autofs4
>> [    8.957248] CPU: 5 PID: 9 Comm: kworker/u20:0 Tainted: G        W          6.1.0 #179
>> [    8.957252] Hardware name: IBM 3931 A01 782 (KVM/Linux)
>> [    8.957254] Workqueue: events_unbound async_run_entry_fn
>> [    8.957259] Krnl PSW : 0704e00180000000 00000000b642729a (msi_device_data_release+0x7a/0xa0)
>> [    8.957262]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>> [    8.957265] Krnl GPRS: a813fdc020800000 00000000928b6840 0000000091934ab8 0000000080344200
>> [    8.957267]            0000000000000000 0000000091934a80 0000000080d79988 0000000000000000
>> [    8.957268]            0000000080eda0a0 0000037fffb5bc10 0000000080eda0a0 0000000091934aa8
>> [    8.957270]            0000000080344200 00000000800e0402 00000000b642724e 0000037fffb5bad0
>> [    8.957279] Krnl Code: 00000000b642728c: f0a0000407fe	srp	4(11,%r0),2046,0
>> [    8.957279]            00000000b6427292: 47000700		bc	0,1792
>> [    8.957279]           #00000000b6427296: af000000		mc	0,0
>> [    8.957279]           >00000000b642729a: a7f4ffdf		brc	15,00000000b6427258
>> [    8.957279]            00000000b642729e: af000000		mc	0,0
>> [    8.957279]            00000000b64272a2: 4120b048		la	%r2,72(%r11)
>> [    8.957279]            00000000b64272a6: c0e5005a0c4d	brasl	%r14,00000000b6f68b40
>> [    8.957279]            00000000b64272ac: e548a1180000	mvghi	280(%r10),0
>> [    8.957290] Call Trace:
>> [    8.957292]  [<00000000b642729a>] msi_device_data_release+0x7a/0xa0 
>> [    8.957295] ([<00000000b642724e>] msi_device_data_release+0x2e/0xa0)
>> [    8.957298]  [<00000000b6c0f608>] release_nodes+0x50/0xd8 
>> [    8.957305]  [<00000000b6c111aa>] devres_release_all+0xaa/0xf0 
>> [    8.957308]  [<00000000b6c0a2f2>] really_probe+0x22a/0x480 
>> [    8.957310]  [<00000000b6c0a6f8>] driver_probe_device+0x40/0xf0 
>> [    8.957312]  [<00000000b6c0a80e>] __driver_attach_async_helper+0x66/0xf0 
>> [    8.957314]  [<00000000b63cfb72>] async_run_entry_fn+0x4a/0x1b0 
>> [    8.957315]  [<00000000b63c1368>] process_one_work+0x200/0x458 
>> [    8.957320]  [<00000000b63c1aee>] worker_thread+0x66/0x480 
>> [    8.957322]  [<00000000b63caa00>] kthread+0x108/0x110 
>> [    8.957325]  [<00000000b634f2dc>] __ret_from_fork+0x3c/0x58 
>> [    8.957328]  [<00000000b6f8da2a>] ret_from_fork+0xa/0x40 
>> [    8.957336] Last Breaking-Event-Address:
>> [    8.957337]  [<00000000b6427254>] msi_device_data_release+0x34/0xa0
>> [    8.957339] ---[ end trace 0000000000000000 ]---
>>
>> The line number for the first warning points to the WARN_ON check in msi_ctrl_valid -- specifically it's the !dev->msi.data->__domains[ctrl->domid].domain check that is failing.
>>
>> The second warning is the WARN_ON_ONCE(!xa_empty(&md->__domains[i].store)) check in msi_device_data_release, presumably a victim of backing out after the first error.
>>
> 
> Yeah, the non-irqdomain legacy path definitely wounds up here, and we
> end-up leaking descriptors. If the following hack works for you, I'll
> ferry the two fixes to Linus asap.
> 
> Thanks,
> 
> 	M.
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index bd4d4dd626b4..9921dc57f1b4 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -165,7 +165,8 @@ static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
>  	unsigned int hwsize;
>  
>  	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
> -			 !dev->msi.data->__domains[ctrl->domid].domain))
> +			 (dev->msi.domain &&
> +			  !dev->msi.data->__domains[ctrl->domid].domain))
>  		return false;
>  
>  	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
> 

Close, but I had to add an extra ) at the end that was missing :)

With both these fixes applied, it actually then leads to the very next WARN_ON failing in msi_ctrl_valid...  Because ctrl->last == hwsize.  I think Thomas' initial fix for msi_domain_get_hwsize has an off-by-1 error, I think we should return MSI_XA_DOMAIN_SIZE for msi_domain_get_hwsize instead.

Here's what my final squashed diff looks like, and with this applied everything seems to be working again for s390 (Guenter, can you test again on powerpc?).  Thanks all!

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bd4d4dd626b4..955267bbc2be 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -165,7 +165,8 @@ static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
        unsigned int hwsize;
 
        if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
-                        !dev->msi.data->__domains[ctrl->domid].domain))
+                        (dev->msi.domain &&
+                         !dev->msi.data->__domains[ctrl->domid].domain)))
                return false;
 
        hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
@@ -609,8 +610,8 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
                info = domain->host_data;
                return info->hwsize;
        }
-       /* No domain, no size... */
-       return 0;
+       /* No domain, default to MSI_XA_DOMAIN_SIZE */
+       return MSI_XA_DOMAIN_SIZE;
 }
