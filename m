Return-Path: <linux-pci+bounces-45193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32ED3B12C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 260CE3089DA1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2422EFDBB;
	Mon, 19 Jan 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0FHIXqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D02F2619;
	Mon, 19 Jan 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839907; cv=none; b=hogzsHMyuIAuypoBW69DOFd/BFq5Lqcb17iU/ylYvcz3REg3rgUptsqiT+ZixgjYDTSHrNBVR92nkLtOGnABsiJHQ68I/ATBTCT919Ine+UqVumYYaUmdvt6n39SXoI+6nMsm7QJ44EbxGUzpdkHxamep1OKFDJwQ6qk4XVfO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839907; c=relaxed/simple;
	bh=e3sRnByaIYggujklQ5lFjxbjG2I9RHdUGb40JU+mB1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hxBULAoR7WqwdXJ9NVnuHOEJbn53IncFSNxAvLHLKFcXwGvODg2TucAoqa/1guXU6inkpO+NCVBpXbyDHeT3BiRO3ug35tI6cNXbYLRuRN/Rx0oFRtRptpgE5jSMKCo6oRfyDvbDP3mnnvGfdU8b1aoHV4C3Z5zsJUZ9Hi9wluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0FHIXqI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEP9vR030111;
	Mon, 19 Jan 2026 16:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a5XMby
	JyD+gQNUr5gvwAsxtNEoo5BEbxR59Ypv0YNjE=; b=H0FHIXqIn0GUe1kormJ/iA
	37m9Zz7PUE4SBg9LD6JCHp6FT/nCwnS1cGWF3wWTQ5unPv18/TdUgoVtt30Gb2ay
	jalnWmcy7YSZzo23bNklNaOLJuK7RloPjpkuBP6LpW9Hv1arMy5p1PusY51Er8Xv
	3tuIlR/9Js1pX9UvuWoMxNgc7+no3ZXgrN47iweTGfGScWTEQvgtPmy4KkbKIt3+
	F8MW6c44X6T2C36Mpjq8WsJv20SQ12wAfp+dH8fiGbY4JXK+1O3d3MRReuyfs9z2
	bGh86vOI7XJV1Exe5nk4yZhrxfrLUY5tjIMewdV1SyE3RG+wuZlmXS79UZfBg/Ag
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rsd9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:24:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JESP9H002002;
	Mon, 19 Jan 2026 16:24:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjfk32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:24:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JGOrv836176322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 16:24:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DBC82004B;
	Mon, 19 Jan 2026 16:24:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C7A20043;
	Mon, 19 Jan 2026 16:24:53 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 16:24:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 17:24:53 +0100
Message-Id: <DFSPESVR3INE.HYERH8O05PYP@linux.ibm.com>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 7/9] vfio-pci/zdev: Add a device feature for error
 information
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-8-alifm@linux.ibm.com>
In-Reply-To: <20260107183217.1365-8-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVS4aORW9w5U5cWYvuAuClNql5rY9eoD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEzNiBTYWx0ZWRfX1IAHF7/PuqtF
 CKPp0SPCYP6xUxhOslOPIUMVniptmZuvelDP7miQiqHqTQmAwWARI/VBHQVxqnBCZv9HtyRBDgE
 TynsU/BtC1ub+ib+cKtIdQ+X5NuvcmghUNkBcWwGCzVlVqMFG4gx0aciDJa3/dPBGyyVIDrcbKG
 UahDtKN/D3jJ2Fbzf7ZZJ5+SFvQ9sOxBSfJIkAzwm4X9xk1dcKvz3DZ4qWXSaP0WZhPn/Z3Wxjt
 MvqvgrfLSg9c7S337Pn4H1tahS7hjjEAQulhx2eEeWWAsAehK14DqxidP4bmGWAUcKRdGFHmeEJ
 jqtuQV/hmq1nWIMqor+2AdzLufjN9phkLeI+ErghHwFvkhppH/gaaR75zHgz/R4aNNhRuzp6PTL
 cUvnSAun/g744k4CDWufK0iKUtG7epsY6902nL9/jgYajcLEgpJ+XgdkPb0jpofT9w0+1RPRkWT
 Oqw7jHyLi837oz6KWeg==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696e5ada cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=47-nCBhZC7b6S0W8LZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vVS4aORW9w5U5cWYvuAuClNql5rY9eoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190136

On Wed Jan 7, 2026 at 7:32 PM CET, Farhan Ali wrote:
> For zPCI devices, we have platform specific error information. The platfo=
rm
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add=
 a
> new device feature to expose this information.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 34 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 16 +++++++++++++++
>  4 files changed, 61 insertions(+)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3a11e6f450f7..f677705921e6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1526,6 +1526,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
*device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);

Would it make sense to name this more generically, e.g.
VFIO_DEVICE_FEATURE_ERROR_RECOVERY, in case other architectures also want t=
o
support something like this in the future?

-- snip --

> =20
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 2be37eab9279..261954039aa9 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,40 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core=
_device *vdev,
>  	return ret;
>  }
> =20
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err;
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> +	int ret;
> +	int head =3D 0;

Maybe we should use reverse x-mas notation:
	struct vfio_device_feature_zpci_err err;
	struct vfio_pci_core_device *vdev;
	struct zpci_dev *zdev;
	int head =3D 0;
	int ret;

	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
	zdev =3D to_zpci(vdev->pdev);

-- snip --

