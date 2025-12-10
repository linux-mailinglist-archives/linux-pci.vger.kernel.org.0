Return-Path: <linux-pci+bounces-42907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F61CB3B6E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2772B3006AAC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78F2FFF88;
	Wed, 10 Dec 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WV05/MLm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B10276020;
	Wed, 10 Dec 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389914; cv=none; b=feauNKyhRcgCc8poL4TMGbsZRMn/KLabLlK/WCg6v3vh1+XWgtobD03PNHfWRZcfjHrzQOw58mh4ds+LnY3IM0g7wIWdNWXFsJ22ERzrL02+gSJWDYaf5vTtiyeVZJYpJsVEhKRIvCzN+1frwotR36fu3lbp29mM1n9/qfcBkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389914; c=relaxed/simple;
	bh=pYBCjnLerM+kbhjz0T03Vu4YbsssOVGCV3+zISSrNHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TN3PxlZlsTKvGBsoB+9GrOxLjCs1mZqYXzvItOfXaIni7eFLu9PNpoOMsFurAz5kLe2ZPt9ZnEOEymyxPkfQuxO75egGBMvyoMW90vrxsE2M+w3/P5/ApxdEVmgTpWng4GkWde6MuGTbJGggJfTmjeVbN7DXNU/nzHgahvTLzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WV05/MLm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAFNU17023198;
	Wed, 10 Dec 2025 18:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8aH5nz
	iBmG79K+tZDZKeNtxazgDmjf0Do7pLuUo/VuY=; b=WV05/MLmyMHj5P7FeWUJbR
	6ZdphzwBsVBN+QoVXxq1Rx56jq52JEgbtj6xMXqBP/If9+gouur77qZRjgy+1tXj
	/hgsU2pA8plbwQu+YEXZAo2Di1JdXOKYIf4B+6D+esqckN5TKA9J1fEOG+SEdI80
	rbTDDfcmux93ijApjbBYwCrkZBii2eJ4d8HCu8kcB2tYS3VVHz9pI+4gfRLw8mEF
	frnRe5rMSGFxInk27yycv61bfEVzSTCH/UpnXaumMI53yBAKoOaU6+lvjyWIfUGn
	kTFm5qpYnHRaRxqLLWAS3wY4NHjTW3kkEYDXmDnOcdZXh5DqEbi50g/zARJ3a8dg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvuffg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 18:05:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAGrfPr012907;
	Wed, 10 Dec 2025 18:05:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ak21s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 18:05:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAI53TK43188694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 18:05:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CF8D20043;
	Wed, 10 Dec 2025 18:05:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D690B20040;
	Wed, 10 Dec 2025 18:05:02 +0000 (GMT)
Received: from [9.87.149.55] (unknown [9.87.149.55])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 18:05:02 +0000 (GMT)
Message-ID: <79c9f452ab031dfa34eccca8951cb257d2056b41.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
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
Date: Wed, 10 Dec 2025 19:05:02 +0100
In-Reply-To: <20251119-revert_sriov_lock-v2-2-ea50eb1e8f96@linux.ibm.com>
References: <20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com>
	 <20251119-revert_sriov_lock-v2-2-ea50eb1e8f96@linux.ibm.com>
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
X-Proofpoint-GUID: lrytVvQrNdOr3o3nFW-_JIbjuJbhJtRT
X-Proofpoint-ORIG-GUID: lrytVvQrNdOr3o3nFW-_JIbjuJbhJtRT
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6939b654 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=StQnNx5gWU8ioawhWRcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXxogsLMZLRlw4
 IYe9ZBGjXCgsIwCvKAYw8UtUdkxYYVjYYlwoyBflUZJQHkH6CBRrHz3GsjB4q1cRSSsml2q5Dn2
 jJlIPgdWOcbEUdY9ioMRkc3dgai2rL7P7SzEh4YKDaxjOQ7HfoRAL3sFDqrNO0ah/74VmPfxg60
 xXlNf9Asn1jsPOlYas859RxH+L0MQO6IXYB9OhkNfR27uYOwM612B0TeXC+aldWVbQNlXMNXkB4
 yZWJ+5CaxFIHxEmNC0C2jv8T6qVWaGGhJMVVMKU5neVmW5cOwGmn7FmVrfK5aIA7dhbHfl8sPvM
 EFsNHS27lwoCQr/n88x+Bqm+OXTBBZvX8ov+V+Yf4orwaK9WHZVMHGs+nkD7g3p6vj3rZSKJ0PV
 9mN38IemHl/4U/qEaGFf+3jatmFjpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

On Wed, 2025-11-19 at 13:34 +0100, Niklas Schnelle wrote:
> Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
> enabling/disabling SR-IOV") tried to fix a race between the VF removal
> inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
> rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove
> lock was also taken in sriov_add_vfs() to protect addition of VFs.
>=20
> This approach however causes deadlock on trying to remove PFs with
> SR-IOV enabled because PFs disable SR-IOV during removal and this
> removal happens under the PCI rescan/remove lock. So the original fix
> had to be reverted.
>=20
> Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
> sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable
> vs hotplug higher up in the callchain by taking the lock in
> sriov_numvfs_store() before calling into the driver's sriov_configure()
> callback.

I agree, adding the lock to sriov_numvfs_store() is adding the missing
serialization against other threads that create or remove PCI devices
without getting into the middle of implicit PCI VF device removal in
the course of a PF removal that grabbed pci_lock_rescan_remove()
already.

>=20
> Cc: stable@vger.kernel.org
> Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enablin=
g/disabling SR-IOV")
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/iov.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ac4375954c9479b5f4a0e666b5215094fdaeefc2..c6dc1b44bf602a0b1785b684f=
768fcd563f5b2aa 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> =20
>  	if (num_vfs =3D=3D 0) {
>  		/* disable VFs */
> +		pci_lock_rescan_remove();
>  		ret =3D pdev->driver->sriov_configure(pdev, 0);
> +		pci_unlock_rescan_remove();
>  		goto exit;
>  	}
> =20
> @@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  		goto exit;
>  	}
> =20
> +	pci_lock_rescan_remove();
>  	ret =3D pdev->driver->sriov_configure(pdev, num_vfs);
> +	pci_unlock_rescan_remove();
>  	if (ret < 0)
>  		goto exit;
> =20

This LGTM, feel free to add
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thank you!

