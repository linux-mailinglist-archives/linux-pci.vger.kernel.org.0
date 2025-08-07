Return-Path: <linux-pci+bounces-33562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9AB1DA78
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319086275ED
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474B248867;
	Thu,  7 Aug 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1iaBISD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C28204F93;
	Thu,  7 Aug 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578779; cv=none; b=tWcCGuuLRNTQz7hRFqlMXwshlsc+c89QfsoL2A9e88/o8Ko1jAV8Rao4OYr7vjQDtXXIezhFepLT+hTU9eLCj92A+E6IcdauKxq43fi0oJNnp74177Gr/NfUOL/bm0Ts5zd+eUX5MPXKDxyAo9BUSwdD+BeJJSelncznI+bujo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578779; c=relaxed/simple;
	bh=BJFggzQg4oB78eY+cmPQsLfenBp8Y/1FEflvAnamw9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a84UsrBQCP0pQ+ZDZAgtfgj/hP0BhnRj3/gCMqEdS6hLirwZWn0vUV5z7ELMsYoRNY1n+vmfrBytqFkhHv+Nnv7vwSm6pjXhYwXILKYY2QMK8DX2ngjy+dFPGrBhXrT/RgKQejwVLiSHffJ2Hdvd+pdR+aUAbFkUiAJ/bEXIU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1iaBISD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5775SDLN028233;
	Thu, 7 Aug 2025 14:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=ryfLtLeDXs3nbNtKSgths
	vsyjfARDXOnqgE+N8SlktY=; b=M1iaBISDpUOai2rSPVRK3tQOHckLoXYxbR7Z5
	HAgcIoTytNq662TxdSiSG7b5CtWpH3obyhsseiq6vQAAhlSz2+vO/7ybL61b2rha
	SziKalPymiJmnHR+AzVdfpFRCRXLs3xqhwZFqu9okgeo3M1m51gzv0v32RHFozYq
	+byrujpgW8qnv35zMxQTVlY88VWxXFOvVSjSuh0t4rRmTpkev657g4OHaCNCPHg7
	XNzqY9k4g1Lf0BsxkbbZwP9L0llcO3ohK/L6l0+sz5eTMdQ+xHqG7mmOu9ZLFFEm
	/4R+9wTyon6rQeno/gFRLBybmaStz4VRYqnli7bu6lKew+hvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq612x96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 14:59:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577EoDCi013493;
	Thu, 7 Aug 2025 14:59:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq612x93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 14:59:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577DirPG022647;
	Thu, 7 Aug 2025 14:59:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqh4wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 14:59:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577ExMFb53543182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 14:59:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6D8C20049;
	Thu,  7 Aug 2025 14:59:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DD7020040;
	Thu,  7 Aug 2025 14:59:16 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.216.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 14:59:16 +0000 (GMT)
Date: Thu, 7 Aug 2025 20:29:12 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Linas Vepstas <linasvepstas@gmail.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 3/3] powerpc/eeh: Use result of error_detected() in
 uevent
Message-ID: <nk2zd4agog5pqajeofiazo6aut7xekbj5jsvoe373lldfl2y2g@qngl743pigmr>
Reply-To: mahesh@linux.ibm.com
References: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
 <20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nPK7BmCEmykejs_odMrOVMw6UNvtcAPE
X-Proofpoint-ORIG-GUID: 3f5MHXYlkHYvcyFm94JM3rn0C-c4ud3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEyMCBTYWx0ZWRfXz/p2ZjS5q2Qz
 x45OPmCMPj6mqeDMd/qxE0o8foCg38eMo94PB/zXOHTuR8/NaF5aUzUQu8/gjv8+xz7trGu4qKg
 ha4SF21Q4LZ6896pPhU2mf5dUFkqykB7rWflRFBzZXmSf6NuVUzTLQwFn/p035ksBFK2K9O422D
 mi46nzsG8lduPa58gnKSgUEo/Gwpbu6BH1cJi5d77dOhNPPPgRkhyFj4Gsp8BUIqZDXEwKxlu/2
 JZ5frIIqXwVAs8AaVPYxVLOPagjwv01x9HkDhrFFWoMclbIPfUCRBmUYVHch3y0OleYQF3Pv08U
 gTIx8e6CwwjTx5oBMyWr5WdnzX1YBx72XLGPOn8t7dWNrhbkx4w4tB51yjFXHDGmOAmtp0qZ+GR
 jQIOt+82oMWWauScthmIsVMkuM6SZwF7CxWdE4TdSeLnnh/sk6tgXy8H1TqJBOVjaJKw7v8p
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6894bf50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=y5LWfs1rpAMjDq6n04wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070120

On 2025-08-07 15:55:40 Thu, Niklas Schnelle wrote:
> Ever since uevent support was added for AER and EEH with commit
> 856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume"), it
> reported PCI_ERS_RESULT_NONE as uevent when recovery begins.
> 
> Commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for
> udev") subsequently amended AER to report the actual return value of
> error_detected().
> 
> Make the same change to EEH to align it with AER and s390.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/aIp6LiKJor9KLVpv@wunner.de/
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 7efe04c68f0fe3fb1c3c13d97d58e79e47cf103b..20ed9685da8b7e6d419a4b02f715b52acfe715d3 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -334,7 +334,7 @@ static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
>  	rc = driver->err_handler->error_detected(pdev, pci_channel_io_frozen);
>  
>  	edev->in_error = true;
> -	pci_uevent_ers(pdev, PCI_ERS_RESULT_NONE);
> +	pci_uevent_ers(pdev, rc);
>  	return rc;
>  }

Thanks for the patch. Looks good to me.

Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

>  
> 
> -- 
> 2.48.1
> 
> 

-- 
Mahesh J Salgaonkar

