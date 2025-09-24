Return-Path: <linux-pci+bounces-36882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C981FB9B256
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEDD1B26E92
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F73168FC;
	Wed, 24 Sep 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1IrTg3g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E913314B90;
	Wed, 24 Sep 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736678; cv=none; b=YqbTDgWd0gId5kKBRVCAygQcUI8M8i2OM/jjX1qLbN35GjBlcnl/jnDy0jE7pvbQaIaZgTxKxnzyQbGqILMDCZ1w6Pvhsd1klvglCSGSvMGi5CJE2srKY1Eq4/OrjYFOtT/ihwjTLITIKalbW+xr1FLRQ5+LkEurzqmiQNlxaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736678; c=relaxed/simple;
	bh=ibBLmnWGd5dwikKX/unt0rlK10hiVA3T+Fur+t+XOY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV3ir4PKx81Ve8HwtPiAT29UQtcA8B+ZiBot6vGPt0/7JpC1dbS483xFI4lS18NQ6ySjcZoH8Exx5vypTqqd5OZixdgncLFP5Rcn38pmNB4iKrz9Wm2BEjzbGIp+stPM0T7txuJ5rg0Y0eIbUoMvERn9mVg/g4rzGvkYbqUK2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1IrTg3g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OFo5xN008363;
	Wed, 24 Sep 2025 17:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c1ejUn
	Xihd2+WKV0LQPEZ9PHhxyatEp9b3+NMwlNL/k=; b=h1IrTg3gT/aQvvxIHfE5Ru
	LZbXB9xGPTOy9865Qa5nToradB1xluobUFmyllwbMXqaRJckk/jqjp4AaJaxSYDx
	0lCPf4aZaqJdHRySpfKwBYaLX2M6mAJunHM9YQPdIpAKVu1Tnrp/0btxTnUBTNaX
	v+gbuSox34luogs8XgkIA+4ChTG1hpIGBvW1amvdAtpAZ2KT33qDQ0zB0CgLP95f
	n6izNJwkyMT9vWWJG4jlt9iHudO9fsstw7Ws0aUis2JDZLia/RnIMYIpX25zHFEv
	42TNTW48v0TVInVu4HB9dWrJ+C8kdpIb9vrMJk9Esw/py6i6CST1ZR9MDIEu17ew
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkgh3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:57:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OEgOQJ030397;
	Wed, 24 Sep 2025 17:57:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a19mgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:57:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OHvpdu32965266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:57:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6511B5805D;
	Wed, 24 Sep 2025 17:57:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA985805A;
	Wed, 24 Sep 2025 17:57:50 +0000 (GMT)
Received: from [9.61.252.148] (unknown [9.61.252.148])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 17:57:49 +0000 (GMT)
Message-ID: <d346c265-6b0e-42ce-8275-7969c8e549da@linux.ibm.com>
Date: Wed, 24 Sep 2025 10:57:40 -0700
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
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d43121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RiiMxNVSmK5LPl13xBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX3It9hmbLatt7
 6c5scWjsIfMyQKORsuDs9SYW8iK987TkAKhqlMF35evIOarwEGebuPJtvWviT3Qy1FI/xlXagsH
 MLS0qm4PujeSnzzq4cE+wMYYusvUlxH//YcxkG39WrUikKA0+WQFFzDY4aIXSQaZR9y2D/yq2XI
 3FL7H1HB/4VW7XRnuD/zyB8wIuLgCrGQgw9JMZtCJatyXktwW4z9kUK4VHcSJVWkqb1EPBhBtb/
 nZqvj0q60lfTnYVOHM3jrluuccqAiUURGkG6p2SfeVLSaTu/zSIcrGs8Yz1gfE9Oo7AJAj/yeQR
 rT7mps3bANwCHUhenPmvcXTaPI5c6DxvM1ktMeeDKvetnVz4TqG+5HPn9FlbtUkUzDfeQBNpYpc
 wGxgx5Of
X-Proofpoint-ORIG-GUID: X_G0C1SIkYgD_PsD6IiUr_EpkKD1kVuy
X-Proofpoint-GUID: X_G0C1SIkYgD_PsD6IiUr_EpkKD1kVuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010


On 8/26/2025 1:52 AM, Niklas Schnelle wrote:
> Before disabling SR-IOV via config space accesses to the parent PF,
> sriov_disable() first removes the PCI devices representing the VFs.
>
> Since commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()")
> such removal operations are serialized against concurrent remove and
> rescan using the pci_rescan_remove_lock. No such locking was ever added
> in sriov_disable() however. In particular when commit 18f9e9d150fc
> ("PCI/IOV: Factor out sriov_add_vfs()") factored out the PCI device
> removal into sriov_del_vfs() there was still no locking around the
> pci_iov_remove_virtfn() calls.
>
> On s390 the lack of serialization in sriov_disable() may cause double
> remove and list corruption with the below (amended) trace being observed:
>
>   PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
>   GPRS: 000003800313fb48 0000000000000000 0000000100000001 0000000000000001
>         00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc9480
>         0000000000000001 0000000000000000 0000000000000000 0000000180692828
>         00000000818e8000 000003800313fe2c 000003800313fb20 000003800313fad8
>   #0 [3800313fb20] device_del at c9158ad5c
>   #1 [3800313fb88] pci_remove_bus_device at c915105ba
>   #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
>   #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
>   #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
>   #5 [3800313fca0] __zpci_event_availability at c90fb3dca
>   #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
>   #7 [3800313fd60] crw_collect_info at c91905822
>   #8 [3800313fe10] kthread at c90feb390
>   #9 [3800313fe68] __ret_from_fork at c90f6aa64
>   #10 [3800313fe98] ret_from_fork at c9194f3f2.
>
> This is because in addition to sriov_disable() removing the VFs, the
> platform also generates hot-unplug events for the VFs. This being
> the reverse operation to the hotplug events generated by sriov_enable()
> and handled via pdev->no_vf_scan. And while the event processing takes
> pci_rescan_remove_lock and checks whether the struct pci_dev still
> exists, the lack of synchronization makes this checking racy.
>
> Other races may also be possible of course though given that this lack
> of locking persisted so long obversable races seem very rare. Even on
> s390 the list corruption was only observed with certain devices since
> the platform events are only triggered by the config accesses that come
> after the removal, so as long as the removal finnished synchronously
> they would not race. Either way the locking is missing so fix this by
> adding it to the sriov_del_vfs() helper.
>
> Just lik PCI rescan-remove locking is also missing in sriov_add_vfs()
> including for the error case where pci_stop_ad_remove_bus_device() is
> called without the PCI rescan-remove lock being held. Even in the non
> error case adding new PCI devices and busses should be serialized via
> the PCI rescan-remove lock. Add the necessary locking.
>
> Cc: stable@vger.kernel.org
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/iov.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ac4375954c9479b5f4a0e666b5215094fdaeefc2..77dee43b785838d215b58db2d22088e9346e0583 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -629,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
>   	if (dev->no_vf_scan)
>   		return 0;
>   
> +	pci_lock_rescan_remove();
>   	for (i = 0; i < num_vfs; i++) {
>   		rc = pci_iov_add_virtfn(dev, i);

Should we move the lock/unlock to pci_iov_add_virtfn? As that's where 
the device is added to the bus? Similarly move the locking/unlocking to 
pci_iov_remove_virtfn?

Thanks
Farhan

>   		if (rc)
>   			goto failed;
>   	}
> +	pci_unlock_rescan_remove();
>   	return 0;
>   failed:
>   	while (i--)
>   		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
>   
>   	return rc;
>   }
> @@ -762,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
>   	struct pci_sriov *iov = dev->sriov;
>   	int i;
>   
> +	pci_lock_rescan_remove();
>   	for (i = 0; i < iov->num_VFs; i++)
>   		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
>   }
>   
>   static void sriov_disable(struct pci_dev *dev)
>

