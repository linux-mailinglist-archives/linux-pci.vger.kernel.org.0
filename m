Return-Path: <linux-pci+bounces-37029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9DBA1BCC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98871898E99
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02E2652A6;
	Thu, 25 Sep 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PcEXW0dK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE314A8E;
	Thu, 25 Sep 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837965; cv=none; b=OMNCem88wDehPbgEx0eImF1F5K1mzjdTUYGQtVmJaBWivP4Y1vYhBX1X2gjSdHJ3pX9iucaIrpyTxbG2XdwnObwjobSzS0kCdFXzIG8fhuoNVR+3pVNQsx+tnXHMagQktKoK2shlqulg0nNQ/RALAymyGArdt83b9miAZZDRVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837965; c=relaxed/simple;
	bh=dgahcYI50uIA6amKSI62BYH+n1qIuOu+Xr2tu6p9RJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+q3LhwN6R34ts+nVMTtypPOPDG/UDl4ExzhAqn/ks17CCtMsch5O+iwIFokbpYyoFBgsVbDDKEjItSAbcc8ZJm7RDMWxZes7jW8p0G9S47IbtquS8xHJbmEEviYGyvA8hFMhAYCuGChqZvfJ62VDTCxOAQOSRL5qCQ1IzQT814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PcEXW0dK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImKV2030005;
	Thu, 25 Sep 2025 22:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K7IRn6
	bG/6nky59M0Oo2KeM1fFNlrak9irHbIR1LLzI=; b=PcEXW0dKW/ZzIaNcLcP6o7
	QAf48rO1q7z311g0AC5Ji40dVw5nhc8D9LbIyTUyZ0pvggELKOrFl/gTeNQ7rxRC
	YfQiiBjLbYlr4hZ/T3iQ2Kg2kYFlIlizRospe55sblNmyXKLl2wac0dIHUfNEGCK
	peypBAhhnfb3HKH87DGXggWcnp4mTqb2bK/1iZb7eYfe3O6Hm/tE57GwVJ/zv4tK
	mVSwQVEndzrDq/Wq6vfROPOBv4ZrOgXuebdJ1mjGhB6Xi0phE4/7Mis0gAEwDFfi
	SVnxm7bbngxZjdhcEViue/Mph4XrkU5Yi9RYIWuFPrqcPKaZChFFelZIisVK71wg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbagwe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 22:05:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PLe3sj014307;
	Thu, 25 Sep 2025 22:05:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm0yue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 22:05:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PM5twN25952884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 22:05:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F40158050;
	Thu, 25 Sep 2025 22:05:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13D9258045;
	Thu, 25 Sep 2025 22:05:54 +0000 (GMT)
Received: from [9.61.254.10] (unknown [9.61.254.10])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 22:05:53 +0000 (GMT)
Message-ID: <82ab0e33-43ab-4b65-b24f-9ea83a859d62@linux.ibm.com>
Date: Thu, 25 Sep 2025 15:05:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
 <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
 <d346c265-6b0e-42ce-8275-7969c8e549da@linux.ibm.com>
 <9fb43fc399ac5917605b7bc721c4b0affb8ca255.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <9fb43fc399ac5917605b7bc721c4b0affb8ca255.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N2eU3qL5PwiwqGVOyQl1CGnycvZfnP5l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfXywC3eHLPAczg
 bb+hIriYgiTrcBDlydpWi5pVIN5prxkyDLOoJ68BPNdsFBjDNodO6CY0apYMAPvSrC68RmR3MCQ
 w9SHZC7o1THHA6Z8F2PpXI2q2wlzpgDEthfgXUqv9lrtHGYk7a8UFfhb2G6MfC86O/Wbs2MmFm0
 AJDJRt2soKtLGLZCGfDIu/fWsTNJ9o62s+TrVjSOEOX1yOYNKVr6DEo5ZTeu5pRwecWfTx+FoJF
 ywRxP6JcxaM42EsnxTza6OIbjPBzQpExq5VWWOMRXmeZ/PZe7bhAW/IpS2sEHmMbX54BePV8LoT
 mBvXXJwmKXGTErIhMfBX8pi0lTZ9bcmwKYIy5guS/TgdSnb6hw1KB3/DsyoP3Fra9IeD+fY8SC/
 ca5x7p+z/I1tgBGJWncghW7z3IqEug==
X-Proofpoint-ORIG-GUID: N2eU3qL5PwiwqGVOyQl1CGnycvZfnP5l
X-Authority-Analysis: v=2.4 cv=B6W0EetM c=1 sm=1 tr=0 ts=68d5bcc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=f7japnTVbOoWgXTj3B8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174


On 9/25/2025 12:48 AM, Niklas Schnelle wrote:
> On Wed, 2025-09-24 at 10:57 -0700, Farhan Ali wrote:
>> On 8/26/2025 1:52 AM, Niklas Schnelle wrote:
>>> Before disabling SR-IOV via config space accesses to the parent PF,
>>> sriov_disable() first removes the PCI devices representing the VFs.
>>>
>>> Since commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()")
>>> such removal operations are serialized against concurrent remove and
>>> rescan using the pci_rescan_remove_lock. No such locking was ever added
>>> in sriov_disable() however. In particular when commit 18f9e9d150fc
>>> ("PCI/IOV: Factor out sriov_add_vfs()") factored out the PCI device
>>> removal into sriov_del_vfs() there was still no locking around the
>>> pci_iov_remove_virtfn() calls.
>>>
>>> On s390 the lack of serialization in sriov_disable() may cause double
>>> remove and list corruption with the below (amended) trace being observed:
>>>
>>>    PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
>>>    GPRS: 000003800313fb48 0000000000000000 0000000100000001 0000000000000001
>>>          00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc9480
>>>          0000000000000001 0000000000000000 0000000000000000 0000000180692828
>>>          00000000818e8000 000003800313fe2c 000003800313fb20 000003800313fad8
>>>    #0 [3800313fb20] device_del at c9158ad5c
>>>    #1 [3800313fb88] pci_remove_bus_device at c915105ba
>>>    #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
>>>    #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
>>>    #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
>>>    #5 [3800313fca0] __zpci_event_availability at c90fb3dca
>>>    #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
>>>    #7 [3800313fd60] crw_collect_info at c91905822
>>>    #8 [3800313fe10] kthread at c90feb390
>>>    #9 [3800313fe68] __ret_from_fork at c90f6aa64
>>>    #10 [3800313fe98] ret_from_fork at c9194f3f2.
>>>
>>> This is because in addition to sriov_disable() removing the VFs, the
>>> platform also generates hot-unplug events for the VFs. This being
>>> the reverse operation to the hotplug events generated by sriov_enable()
>>> and handled via pdev->no_vf_scan. And while the event processing takes
>>> pci_rescan_remove_lock and checks whether the struct pci_dev still
>>> exists, the lack of synchronization makes this checking racy.
>>>
>>> Other races may also be possible of course though given that this lack
>>> of locking persisted so long obversable races seem very rare. Even on
>>> s390 the list corruption was only observed with certain devices since
>>> the platform events are only triggered by the config accesses that come
>>> after the removal, so as long as the removal finnished synchronously
>>> they would not race. Either way the locking is missing so fix this by
>>> adding it to the sriov_del_vfs() helper.
>>>
>>> Just lik PCI rescan-remove locking is also missing in sriov_add_vfs()
>>> including for the error case where pci_stop_ad_remove_bus_device() is
>>> called without the PCI rescan-remove lock being held. Even in the non
>>> error case adding new PCI devices and busses should be serialized via
>>> the PCI rescan-remove lock. Add the necessary locking.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
>>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>>    drivers/pci/iov.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>> index ac4375954c9479b5f4a0e666b5215094fdaeefc2..77dee43b785838d215b58db2d22088e9346e0583 100644
>>> --- a/drivers/pci/iov.c
>>> +++ b/drivers/pci/iov.c
>>> @@ -629,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
>>>    	if (dev->no_vf_scan)
>>>    		return 0;
>>>    
>>> +	pci_lock_rescan_remove();
>>>    	for (i = 0; i < num_vfs; i++) {
>>>    		rc = pci_iov_add_virtfn(dev, i);
>> Should we move the lock/unlock to pci_iov_add_virtfn? As that's where
>> the device is added to the bus? Similarly move the locking/unlocking to
>> pci_iov_remove_virtfn?
>>
>> Thanks
>> Farhan
>>
>>
> I contemplated this as well. Most of the existing uses of
> pci_lock/unlock_rescan_remove() are relatively coarse grained covering
> e.g. the scanning of a whole bus. So I tried to keep this in line with
> that such that all the VFs are added in a single critical section.
>
> Thanks,
> Niklas

Makes sense, the patch LGTM.
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

Thanks
Farhan



