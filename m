Return-Path: <linux-pci+bounces-45194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFDBD3B376
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AF3320FA21
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AA37F738;
	Mon, 19 Jan 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nj0Y258/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041D37E2F4;
	Mon, 19 Jan 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840912; cv=none; b=mOioTsA667Atl55g2+hqu+h2ushu0CfQshnXN6D1cxA+LonFkVDPBmuTnBsW78T33mfN+Sw2GpgTzjcRAW3/quOjmAr1hV1ES2ppvbtHxOJQf2yuJdQhjgZlSRHIsxsVmjgWgkOWW0tjUfMdgE7hmgF4qxc/DDOXNQ5r+wHNVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840912; c=relaxed/simple;
	bh=8Cly1GNk3mzFV8x9Zkf123bjtN9EA4JdBcM0Ptv/1Cw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R8YdfTFe6CrMo5HUuOHor0CbFoxQQnEsrT0zhn7tWj28yUeAOXMTYSUchN42vOw4F2tNcFe6FRxJr9dIoLYaVJ9jiXcNukhwvwZo06EfzAB9oeGAmC4+uYGy0qH1oL1Y8sZzaYxjP6bV2tuISHDh0V6iX8lnRM85XvtN31RkW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nj0Y258/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JD23K7021348;
	Mon, 19 Jan 2026 16:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uu1yRz
	y+SJbnUICqN/kuc63CT+bwXeCFlWsXFTz7C44=; b=nj0Y258/iYDviv7zCPKnQG
	WOvsMuA7krNcoa7JXMoosBTLoq99V/M5ra1P73Aha1lVAwiK03rkMm0T1pRO915O
	yD9HIIjke8YL3puTmR3L/sswG/vGVRUPWoDfymZ918Yv21Oe/dmHDwW1NPReHqsL
	cpSOE/pW7koJ/zGZV0riMszuAJhTjc4FE/aYdvmUfniM/NRoiGTFCPgGhqBB7OwA
	VaFRK9/PuagTM2Zp6AuW8aJIjrv+mxnZvrSbRy1bz+aaGe2Blnc0TlBv2PQWlt9M
	CPhmSYuyXLNhC/ag9WA4RBXJRbYkWL4OG9p8ICQwtuWWqgDUXTWyR7h9lS7K23Bg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u8pcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:41:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGBMVg016636;
	Mon, 19 Jan 2026 16:41:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xr1mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 16:41:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JGfeZl56361256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 16:41:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9502F20049;
	Mon, 19 Jan 2026 16:41:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654F620040;
	Mon, 19 Jan 2026 16:41:40 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 16:41:40 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 17:41:40 +0100
Message-Id: <DFSPRNLTB21S.3LEKR3G14X5XD@linux.ibm.com>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 8/9] vfio: Add a reset_done callback for vfio-pci
 driver
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-9-alifm@linux.ibm.com>
In-Reply-To: <20260107183217.1365-9-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bBJNYWwFpTr6Twf6X4K_jIcGoRKR0iga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEzNiBTYWx0ZWRfX2MTGIISrZrNP
 Mxggeb+oBX0n8Dbb/yqV+d518lFaaTYf12jcLgcSUuBalASpmxm/0iOgSwT25/VsGJ5AxZbC9Ld
 vC4/WfsC+MT8a0Oqod/t0CqTOPW4zK9PXDDPlVL7nRjSoOcC2ZDE4FKUI4sl5JBhJd/sLyN1l37
 mKbnQG+WcuFouaK4RxMqdv51m59C9gkKayMMPjZdg+xYGpLhr8c+fooOylRmNvb+T9koJUQ1cVF
 yQVOnB4CtFaUN93DbZbCaT7uzosNlEwypRO4Mvq4zPApVxVdr6w1QE5hf1uUM3BnsPwCMmq5YFM
 qVRTIz9PGUTC8BdzDWOiyREc249QK5K8EvKMY7rXy3sfwR4I7Mzhv4voObf8BALK12P6orSO++t
 rjEWM+zJ694XjF2lA9CqD+liV20g9h0OwLirGKYUP1jb+CHmJn4SLE0bVbjrZEjk/uETtItFxkQ
 N/T+xoAZGug0K7jlkQQ==
X-Proofpoint-ORIG-GUID: bBJNYWwFpTr6Twf6X4K_jIcGoRKR0iga
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696e5ec9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ufQ_8dze9sbmFIOUPKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190136

On Wed Jan 7, 2026 at 7:32 PM CET, Farhan Ali wrote:
> On error recovery for a PCI device bound to vfio-pci driver, we want to
> recover the state of the device to its last known saved state. The callba=
ck
> restores the state of the device to its initial saved state.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f677705921e6..c92c6c512b24 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2249,6 +2249,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)
> +		return;
> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	pci_restore_state(pdev);
> +}
> +
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  				  int nr_virtfn)
>  {
> @@ -2313,6 +2324,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> =20
>  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
>  	.error_detected =3D vfio_pci_core_aer_err_detected,
> +	.reset_done =3D vfio_pci_core_aer_reset_done,
>  };
>  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
> =20

Feel free to add my
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>

Thanks,
Julian

