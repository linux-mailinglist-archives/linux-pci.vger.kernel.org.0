Return-Path: <linux-pci+bounces-37086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91691BA3200
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 11:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441E53878D5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F035272E45;
	Fri, 26 Sep 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AiYEWoOQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6A266B41;
	Fri, 26 Sep 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878703; cv=none; b=Hz/U1Mr+J9WjZ3Z3/TodlO9Rc5KzteU6qe1IeLW8PszNrrJroGSt3lPeLYVMOowi3Jpdiyv79O9cEOTsmG0Gchoila2GDDL7+bINkz3x1hFwhlIC3M5Ef+vtxl6aNKanMOX32Nkt9w5Htdr4SgHMLTcUghuE108yhxWZSxJyqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878703; c=relaxed/simple;
	bh=09kan+U31Jz6b5Ad+svTygdsayplxe6p3shterplYdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=sdft1c/xZNZJNWOP45OT+BLX+0deEkJZ093Ne+gC+h9SmrX9FdbekmJXcMcllZuSyC5MjjJ1KRDjh9qkURRQkOxz30KiJxD4xDP1Q6nTjjwjCWikNLQZLQ1SuM6giwbuzweWSsgDPlB7B0c2rYbsfIG/6RgLr3Mq/w08SBkd55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AiYEWoOQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q76QgM017808;
	Fri, 26 Sep 2025 09:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h9PMRN
	9SGM7LQikPgneHzFKW6JzZ9aKpjdpXy28FLPk=; b=AiYEWoOQzEFBNFBb1GAVct
	CiIE/TzCzCH6NmhI6rqK8nrIiHEF6Evvi+K/GZ4MTf78QwjdTDao3sMTbMdtP0l+
	OqQw5jsg5vJkuG3zwDPF07DuPuvr1A1T/PwzuoJd9nE7JIFy3lyBi8gJIgCzX1aw
	cQqfYwkZFtJMuQb1K0XspuMzH1zrzWsmCP9bwTMvbK+G1zqoFIONgbA5DUjwhNoI
	A3W8DtTzKGD5Rp5ne2dwKP7Jjg0kz+SZdWhuaqtnRywOIP23q4UcQeXIDfEQNRHc
	h+FPqZV8tmVMd2bYkbLB+ES4C00YIHljuO8xTTc/DApO6VeE2uYmqUGdIYSLFfHw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbdbj4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:24:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6PPJN006373;
	Fri, 26 Sep 2025 09:24:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpkacj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 09:24:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58Q9Os2p50856316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 09:24:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FB0820043;
	Fri, 26 Sep 2025 09:24:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5424C20040;
	Fri, 26 Sep 2025 09:24:53 +0000 (GMT)
Received: from localhost (unknown [9.111.81.227])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 09:24:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 11:24:52 +0200
Message-Id: <DD2MGKOWJ4G1.2QC87YOMH7T63@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Bjorn Helgaas"
 <helgaas@kernel.org>,
        "Lukas Wunner" <lukas@wunner.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Benjamin Block"
 <bblock@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Farhan Ali"
 <alifm@linux.ibm.com>,
        "Julian Ruess" <julianr@linux.ibm.com>,
        "Heiko
 Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
From: "Julian Ruess" <julianr@linux.ibm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
 <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d65beb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RiiMxNVSmK5LPl13xBwA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfXy0hiFk7yxEG3
 oJxnRwzbRB7G0pGQvnKqUGHDwvwdV38BVcGW+77kLiscmRGXzw5FC6OYd6y6uZzIVJEQynKq3zS
 xo9+CC99jcNYkA9SAHd+P8Vl/9Nt6IsP+cHVtWFbpwp8PYFckNBxoNV1SrR/I26NMDfq/+OEH//
 IqprtofPnxMZhI0+JHngmc8hpP7XNPGzdMXb7wKaVclWNyFss56A7eMyTOlimJXyageDy2E+5GK
 AMTvNUBoLbuy4FPhK0h3UD9XLVj/bdk1GoM4Fp0zobXXOadtVEg49dnSQ+qo4Dgx91H4mBOKdO5
 JbNcxCh7lItQ0u55WcSJtHKvohaMJB4I1blcumwfsfG3ul/Z/4QtbefOQlfOQO/JGJRQxUZmYMT
 l++hrMuRlUDjd1S/wn/vLNBJmaiD2g==
X-Proofpoint-GUID: uKeT5O9Ao0EoFPHZd_1BUJBSFeeuv__c
X-Proofpoint-ORIG-GUID: uKeT5O9Ao0EoFPHZd_1BUJBSFeeuv__c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Tue Aug 26, 2025 at 10:52 AM CEST, Niklas Schnelle wrote:
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
>  PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
>  GPRS: 000003800313fb48 0000000000000000 0000000100000001 000000000000000=
1
>        00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc948=
0
>        0000000000000001 0000000000000000 0000000000000000 000000018069282=
8
>        00000000818e8000 000003800313fe2c 000003800313fb20 000003800313fad=
8
>  #0 [3800313fb20] device_del at c9158ad5c
>  #1 [3800313fb88] pci_remove_bus_device at c915105ba
>  #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
>  #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
>  #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
>  #5 [3800313fca0] __zpci_event_availability at c90fb3dca
>  #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
>  #7 [3800313fd60] crw_collect_info at c91905822
>  #8 [3800313fe10] kthread at c90feb390
>  #9 [3800313fe68] __ret_from_fork at c90f6aa64
>  #10 [3800313fe98] ret_from_fork at c9194f3f2.
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
>  drivers/pci/iov.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ac4375954c9479b5f4a0e666b5215094fdaeefc2..77dee43b785838d215b58db2d=
22088e9346e0583 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -629,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 n=
um_vfs)
>  	if (dev->no_vf_scan)
>  		return 0;
> =20
> +	pci_lock_rescan_remove();
>  	for (i =3D 0; i < num_vfs; i++) {
>  		rc =3D pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> +	pci_unlock_rescan_remove();
>  	return 0;
>  failed:
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
> =20
>  	return rc;
>  }
> @@ -762,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
>  	struct pci_sriov *iov =3D dev->sriov;
>  	int i;
> =20
> +	pci_lock_rescan_remove();
>  	for (i =3D 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
>  }
> =20
>  static void sriov_disable(struct pci_dev *dev)

Feel free to add my
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>

Thanks,
Julian


