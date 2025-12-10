Return-Path: <linux-pci+bounces-42906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B2CB3A3F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2E53063F42
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EF71FE44A;
	Wed, 10 Dec 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jgWzs/nx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4730DEBC;
	Wed, 10 Dec 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765388132; cv=none; b=Qbuc8ClInaTvbHYO2F9TieTsUYHqyX+NUhdQ+NYr0WvxS+FVM8+9b+3QtqgkpTusqsQU1oCA+WdESeYvnrXIx7QRm3nOnE55oMMQjulNBS+H3kvCO33Iqmt6c3kesccrfbGsNAqHF8KcDGpyMaJRM9d5DrPrBPvM4QUYihYbTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765388132; c=relaxed/simple;
	bh=SrTDm+hCTOqHwCH+dUcITUYtr9IDWDc2eKPok1TWCFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhtlczeldQlfndQfK/Gv1VoHy5zd6myL4O4cja11mpgnDOSsi6MAWUg9tbfTupbs1X0JSjsLAhxt6EOd7TPs77FZcJrN1QJW4Bj/5Ly2/IvJDtE2PY7MsuPzplt+q+MKEf79M99kmEa5bPei9sQpwd78Yx6I+LYJzGTFbMZifUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jgWzs/nx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAFmghW000330;
	Wed, 10 Dec 2025 17:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L4zQdf
	OsBVZ1D8tqNmZjemJ1jW+qp2IfVM8Rkdj4KME=; b=jgWzs/nx1t60e6kcd+3QeF
	aH6yQmRaZ1FP9CjqJl7zZ5Z6XGVcKp7tgaptpnIk4D4DpX82k0Kta/daioC1qMuO
	SmnYXRox0ELHnedFqInPzNgEQBmDr13YLYpSbLZ21SnroFl21CIDgzLy0iZ4Alm2
	l1d3S5HVkhl6WlL3YffNSoDVRo556CnFR1vFu3bsRVZXujRfG06JHfZa8fhRh30F
	/qcD8aWl4ZLpU1VlwDUjq8JO5oXi5CSj1pBT4uhL21GyBsQTLaEEGHsctv7dp5iU
	pAlJwDwGPQePtnkGyaO0YasvhXg+vlBZ0Iu3yocsSVhMARlUEKZ0+Dj+Blr6YiGg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawvb7kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 17:35:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAGjT2N002053;
	Wed, 10 Dec 2025 17:35:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jhsf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 17:35:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAHZMhb8913260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 17:35:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90BAB20043;
	Wed, 10 Dec 2025 17:35:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDF720040;
	Wed, 10 Dec 2025 17:35:21 +0000 (GMT)
Received: from [9.87.149.55] (unknown [9.87.149.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 17:35:21 +0000 (GMT)
Message-ID: <f16e3e775a5e46672351f03a00295b7c71d6b69a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] Revert "PCI/IOV: Add PCI rescan-remove locking
 when enabling/disabling SR-IOV"
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
 <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Matthew
 Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic	 <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 10 Dec 2025 18:35:21 +0100
In-Reply-To: <20251119-revert_sriov_lock-v2-1-ea50eb1e8f96@linux.ibm.com>
References: <20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com>
	 <20251119-revert_sriov_lock-v2-1-ea50eb1e8f96@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SYQ97Xw60bEokNZQoxYYXdoMg9G9vn-r
X-Proofpoint-ORIG-GUID: SYQ97Xw60bEokNZQoxYYXdoMg9G9vn-r
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=6939af5f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=MQOrj0ii5XhWA5c1uIUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX19Nv77mEtEVA
 yzNJzuqfmnFo2/N05qAPZgA+/62b0y0TeUeIutO5JTV7aqTxZAMgUVlks5V1BFnR2aysmvqXPZG
 XyBe+/4Z8333ge2eQ1SXU6MZSqy3V7RA77wHuqqLru4Ks/0J7ENvAp2s1mxwKKiE38cwqw2Me7m
 O1VCYR3jKeAWgmVhSTv7KAjOJwWNyQRWcPT4+8BOeVSJFbe8GJvmki0kjVJ8kC6phEgiezJmvCL
 oeTcWc0gT0Nc/Asrr2DSoiqtqQFBX6jczeuMDdUbWmiDRMV61XNF6EH49fgbnNoNdtabdDkTmfy
 QK1iUZMcEFNePtglYQG3ahjMaks/8LX4K6bHP+WWD9hHZ6Ywtr7QhM6m6vuTWRv+gHWLEMs6WBT
 ie/7W+y7TflIkUhy/CqiwAOrx8Oa/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007

On Wed, 2025-11-19 at 13:34 +0100, Niklas Schnelle wrote:
> This reverts commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") which causes a deadlock by
> recursively taking pci_rescan_remove_lock when sriov_del_vfs() is called
> as part of pci_stop_and_remove_bus_device(). For example with the
> following sequence of commands:
>=20
> $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
> $ echo 1 > /sys/bus/pci/devices/<pf>/remove
>=20
> A trimmed trace of the deadlock on a mlx5 device is as below:
>=20
>  mutex_lock_nested+0x3c/0x50
>  sriov_disable+0x34/0x140
>  mlx5_sriov_disable+0x50/0x80 [mlx5_core]
>  remove_one+0x5e/0xf0 [mlx5_core]
>  pci_device_remove+0x3c/0xa0
>  device_release_driver_internal+0x18e/0x280
>  pci_stop_bus_device+0x82/0xa0
>  pci_stop_and_remove_bus_device_locked+0x5e/0x80
>  remove_store+0x72/0x90

I just hit this recursive lock issue when running "reset" instead of
"remove"


$ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
$ echo 1 > /sys/bus/pci/devices/<pf>/reset    =20

> This is not a complete fix as it restores the issue the cited commit
> tried to solve.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enablin=
g/disabling SR-IOV")
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/iov.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 77dee43b785838d215b58db2d22088e9346e0583..ac4375954c9479b5f4a0e666b=
5215094fdaeefc2 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -629,18 +629,15 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 n=
um_vfs)
>  	if (dev->no_vf_scan)
>  		return 0;
> =20
> -	pci_lock_rescan_remove();
>  	for (i =3D 0; i < num_vfs; i++) {
>  		rc =3D pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> -	pci_unlock_rescan_remove();
>  	return 0;
>  failed:
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i);
> -	pci_unlock_rescan_remove();
> =20
>  	return rc;
>  }
> @@ -765,10 +762,8 @@ static void sriov_del_vfs(struct pci_dev *dev)
>  	struct pci_sriov *iov =3D dev->sriov;
>  	int i;
> =20
> -	pci_lock_rescan_remove();
>  	for (i =3D 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
> -	pci_unlock_rescan_remove();
>  }
> =20
>  static void sriov_disable(struct pci_dev *dev)

Feel free to add my
Acked-by: Gerd Bayer <gbayer@linux.ibm.com>

