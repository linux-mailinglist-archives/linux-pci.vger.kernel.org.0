Return-Path: <linux-pci+bounces-38902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E824BF6F8D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913FC18842C7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7B338903;
	Tue, 21 Oct 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnF9I0Fl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BA32ED3B;
	Tue, 21 Oct 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055649; cv=none; b=N2x7YD0Xpat030U1dtLJqe1LBVGEER8a6D9+hupbsoHR5+K6pCnEQbNBaZVZdnrmo4UEsnM+S2kmZJpeMnmoJ6dIzrdBErUY5Q6SO7ZITyHeH0WAzsWqXB538wz85QvGREgU5dFQ1rumexGldBRtxEbinWsUi6AC5wi6LtJUH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055649; c=relaxed/simple;
	bh=JzxByh5kUBoKHIxN82xwOONVGLcA34XTs/076ZBn/jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilmq88LI7bA9us0kOWxsYjwXFFx4cTAAD42FTjgz0MP4u+M6aDiQTizAIjZTTcx7g2pviQTtdDyiDmBWRi/hwXVvm2nTNjbUtE73ePM+K1HQnLlyv7NPF0nNL6O0RNwvRCrc7ueNqI6y8GJT3zXmlWBlTGET/HnHHGBW3qJR+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jnF9I0Fl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LDcG6F027549;
	Tue, 21 Oct 2025 14:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yOIHTh
	PjQYl0MFMCKBnXOX5p5/c+cVfRPWqfjLRw10s=; b=jnF9I0FlYcIpBi/g6o9BYp
	4AxoXDmsLyF73v871SgpUI3JKh0jOySkJn4B5Bf4nxB6p+rnUN6+DZmd6dAvtOMR
	/uOopbJCiA3jbdiccDI6bR/iNFtibDWEosmigIvYqw3izQQMUcHmHJ3jajM3Qa8r
	A6g2w1+HFS6ZLiP0gV+3jdzIJd5CoKc/DDzP+3ataB1cWYVInDEYGZJjw44qPIEq
	/bHwMKDcH1csC6XRfRt8glKz380SGQrzuRXGg78BuEB+xoLXWm/G6peV5gMRRO6y
	3hVRXBJoGduHzjYx7Oq5Y6gvvgjhLAUeUkXn+zdzeHMz0GFCK39Qz3lJYRJFyHIA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f7dgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 14:07:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCF5DI024940;
	Tue, 21 Oct 2025 14:07:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqju15c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 14:07:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LE7MAX24576754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 14:07:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADBD85805E;
	Tue, 21 Oct 2025 14:07:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5C45805F;
	Tue, 21 Oct 2025 14:07:21 +0000 (GMT)
Received: from [9.61.43.59] (unknown [9.61.43.59])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 14:07:21 +0000 (GMT)
Message-ID: <0170a16a-aadd-450f-be9a-9b60dfd5c8e7@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:07:21 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] s390/pci: Restore IRQ unconditionally for the zPCI
 device
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, schnelle@linux.ibm.com
References: <20251020190200.1365-1-alifm@linux.ibm.com>
 <20251020190200.1365-4-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20251020190200.1365-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f7939d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=X6ZiwJvXWaKFF5TKYhAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8RplYV_leo0CPNopDWt-CIFvZ4pPABj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8lh7A9xZZgw2
 2jIOg691Sj/zkSDhvapiXdpin/U9OnGJKBb7avSgjKKqqdWr7YbVTe+cx6vesJXQOyxE25m1Fk3
 584mZ3Ft2pYHLyrvnDne5+ph5/8jaEOsq8XvwwCfpwNzgv6B9t9T+Yp40QAELTfuoir6/Y5ojsi
 mf8ArdU0Niig3iLca7AYfBzjgiP/BV4kAXvPssWlBC23kmAwAvfKWoKmy2msD3TuawSDUQIAdld
 x4DCqx5dS7WMeBWv2c6cgluYRxsl4PBbiLhYvBAJdSBsqgLmA9hchOCjFTyhf4OTq4mZDOF+FhO
 2dF91IVxviwyktc90dPlsjcjZSDPORnodwYzVJOEwSrZEWeGuzyJWjb0L5D9eiIOq/DhaRTZV69
 W9/hDC7ujrIkDHAerCneZ4S/haLqLQ==
X-Proofpoint-ORIG-GUID: 8RplYV_leo0CPNopDWt-CIFvZ4pPABj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On 10/20/25 3:02 PM, Farhan Ali wrote:
> Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
> introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
> resetting a zPCI device.
> 
> Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug slot"),
> mentions zpci_clear_irq() being called in the path for zpci_hot_reset_device().
> But that is not the case anymore and these functions are not called
> outside of this file. Instead zpci_hot_reset_device() relies on
> zpci_disable_device() also clearing the IRQs, but misses to reset the
> zdev->irqs_registered flag.
> 
> However after a CLP disable/enable reset, the device's IRQ are
> unregistered, but the flag zdev->irq_registered does not get cleared. It
> creates an inconsistent state and so arch_restore_msi_irqs() doesn't
> correctly restore the device's IRQ. This becomes a problem when a PCI
> driver tries to restore the state of the device through
> pci_restore_state(). Restore IRQ unconditionally for the device and remove
> the irq_registered flag as its redundant.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But one question: Unlike the other 2 patches in this series, this only touches s390 code.  It doesn't depend on the other 2 patches in this series, right?

If not then shouldn't this one go thru s390 rather than PCI subsystem?  Note: none of the s390 arch maintainers are on CC.

> ---
>  arch/s390/include/asm/pci.h | 1 -
>  arch/s390/pci/pci_irq.c     | 9 +--------
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 

