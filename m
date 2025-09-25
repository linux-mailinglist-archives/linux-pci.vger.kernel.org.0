Return-Path: <linux-pci+bounces-36933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57068B9DE86
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097724281AE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD806FC5;
	Thu, 25 Sep 2025 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uqt15nMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820C1A4F12;
	Thu, 25 Sep 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786499; cv=none; b=IjEiY8LmiWrMJQ9zC26F5fiI1XlHwpKIUTIgPCxVWs8aNQ3mfym0dgcgz/W8k9WvC39GCk0HyUuYe0UEFVQ9Dfdhp6/mjok7ruyriIRhFQgovx0610OiaLyKD30Sn5Wko3lMLa0kq3oxQDgXwvVvyOobWWMlBMBKGoIV26SiU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786499; c=relaxed/simple;
	bh=96zpyVLXb0/xXQ3jhEnIZnbG0HfQSRlcYlVpln0QGPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BH5rxXVnn6U9yFev8t/p7ekw9ldE6IVNt0afBdKwVZfyw6d3zJnj2MnrOioy+T0mIX40+pAOOSWOfMO4qmpMj5ohEQ7zbZKag4avznqUlDf5nin2kyylBFgXHg3jvJyIFRhSNwS0TTfss7Kv//6N6Sat28kDYevDsID/4yku8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uqt15nMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OL71nG003982;
	Thu, 25 Sep 2025 07:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=evErLQ
	dsuI+irJgrBXX0L6SyF4tqxBvXiIrNeagjD/Q=; b=Uqt15nMADd4LtT2h9nKLQK
	qsogtZGjD3JyX209jBAZu9isHbwG1/v5uHyV69OhWcidvp7txAi0Ev9TdmevOoFJ
	AwkliDrZPs2lXQPK19JGwBSu61Sa72VeFQszrBnyaMcm8dhwZrBsUfB3W0//meOc
	Tu2forYY/GAOwlshvmRBgv2DgeIsDO4Hw6cXoJn+mCgMMfX9A8TU6nkAYTNaw1fg
	/HiDHobT89XXqDk5lMCd5xpAcrlUFH6uhpDP6LPzwRzUpoNZ1n9SAhXlUw4rwZGP
	uWbm6fJyqVR9UhQ1shc5b69lW06qDaXGH0ClNRY4YTMj47hGKCMI/qHP6+G7kivA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyueea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 07:48:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P6SQVH020211;
	Thu, 25 Sep 2025 07:48:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83kcm4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 07:48:12 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58P7mAFT31064530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 07:48:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C87F58056;
	Thu, 25 Sep 2025 07:48:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E20CE5804E;
	Thu, 25 Sep 2025 07:48:07 +0000 (GMT)
Received: from [9.111.71.247] (unknown [9.111.71.247])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 07:48:07 +0000 (GMT)
Message-ID: <9fb43fc399ac5917605b7bc721c4b0affb8ca255.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block
 <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Ruess
 <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 25 Sep 2025 09:48:07 +0200
In-Reply-To: <d346c265-6b0e-42ce-8275-7969c8e549da@linux.ibm.com>
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
	 <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
	 <d346c265-6b0e-42ce-8275-7969c8e549da@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d4f3bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=tmWI2QDjmt9rcYb-4t0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o89TCv57fsfiIcqbj50abCdBm-KM_9T3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfXzjxFyCHKbiNV
 fMCYfc4BsunVq3fHcFocs82BrutgGkkPd3r61vFpF0TCOU8Kr7LBdbatZFF7OVXJXyhDHJSZzgQ
 K2riwqDkpvt+CvVniwXs4xk1arSGy8aZk6VqsLg+4wQmf/2AAxeSNxZntWU7rV0mOk5WAi4+fiu
 Uwqs+WyiJjd+HZ13YRizl1IY3Geog3Iue8IEDRzMGbh7THU80Tfd7sBb6NrTptgBbzZ4FyBn2oI
 UEJmU3L/G8ylgTCoLZ1WFiXUaG9vkQLm8YMrkjTkn76kx2niXE6n9F8q9COyEgDfKbDUHgM6i23
 MxqVMuqwMtNLe55ETr9PYfYHbBNUd8MulskWorfhqOF69kRkIAM56k5bAu3rG9K+yluroHeW64i
 PLpeC8W6
X-Proofpoint-ORIG-GUID: o89TCv57fsfiIcqbj50abCdBm-KM_9T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

On Wed, 2025-09-24 at 10:57 -0700, Farhan Ali wrote:
> On 8/26/2025 1:52 AM, Niklas Schnelle wrote:
> > Before disabling SR-IOV via config space accesses to the parent PF,
> > sriov_disable() first removes the PCI devices representing the VFs.
> >=20
> > Since commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()")
> > such removal operations are serialized against concurrent remove and
> > rescan using the pci_rescan_remove_lock. No such locking was ever added
> > in sriov_disable() however. In particular when commit 18f9e9d150fc
> > ("PCI/IOV: Factor out sriov_add_vfs()") factored out the PCI device
> > removal into sriov_del_vfs() there was still no locking around the
> > pci_iov_remove_virtfn() calls.
> >=20
> > On s390 the lack of serialization in sriov_disable() may cause double
> > remove and list corruption with the below (amended) trace being observe=
d:
> >=20
> >   PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
> >   GPRS: 000003800313fb48 0000000000000000 0000000100000001 000000000000=
0001
> >         00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc=
9480
> >         0000000000000001 0000000000000000 0000000000000000 000000018069=
2828
> >         00000000818e8000 000003800313fe2c 000003800313fb20 000003800313=
fad8
> >   #0 [3800313fb20] device_del at c9158ad5c
> >   #1 [3800313fb88] pci_remove_bus_device at c915105ba
> >   #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
> >   #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
> >   #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
> >   #5 [3800313fca0] __zpci_event_availability at c90fb3dca
> >   #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
> >   #7 [3800313fd60] crw_collect_info at c91905822
> >   #8 [3800313fe10] kthread at c90feb390
> >   #9 [3800313fe68] __ret_from_fork at c90f6aa64
> >   #10 [3800313fe98] ret_from_fork at c9194f3f2.
> >=20
> > This is because in addition to sriov_disable() removing the VFs, the
> > platform also generates hot-unplug events for the VFs. This being
> > the reverse operation to the hotplug events generated by sriov_enable()
> > and handled via pdev->no_vf_scan. And while the event processing takes
> > pci_rescan_remove_lock and checks whether the struct pci_dev still
> > exists, the lack of synchronization makes this checking racy.
> >=20
> > Other races may also be possible of course though given that this lack
> > of locking persisted so long obversable races seem very rare. Even on
> > s390 the list corruption was only observed with certain devices since
> > the platform events are only triggered by the config accesses that come
> > after the removal, so as long as the removal finnished synchronously
> > they would not race. Either way the locking is missing so fix this by
> > adding it to the sriov_del_vfs() helper.
> >=20
> > Just lik PCI rescan-remove locking is also missing in sriov_add_vfs()
> > including for the error case where pci_stop_ad_remove_bus_device() is
> > called without the PCI rescan-remove lock being held. Even in the non
> > error case adding new PCI devices and busses should be serialized via
> > the PCI rescan-remove lock. Add the necessary locking.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> > Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/pci/iov.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index ac4375954c9479b5f4a0e666b5215094fdaeefc2..77dee43b785838d215b58db=
2d22088e9346e0583 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -629,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16=
 num_vfs)
> >   	if (dev->no_vf_scan)
> >   		return 0;
> >  =20
> > +	pci_lock_rescan_remove();
> >   	for (i =3D 0; i < num_vfs; i++) {
> >   		rc =3D pci_iov_add_virtfn(dev, i);
>=20
> Should we move the lock/unlock to pci_iov_add_virtfn? As that's where=20
> the device is added to the bus? Similarly move the locking/unlocking to=
=20
> pci_iov_remove_virtfn?
>=20
> Thanks
> Farhan
>=20
>=20

I contemplated this as well. Most of the existing uses of
pci_lock/unlock_rescan_remove() are relatively coarse grained covering
e.g. the scanning of a whole bus. So I tried to keep this in line with
that such that all the VFs are added in a single critical section.

Thanks,
Niklas

