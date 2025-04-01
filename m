Return-Path: <linux-pci+bounces-25097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA3A78331
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 22:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A9A188E677
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9A213230;
	Tue,  1 Apr 2025 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UoUO6NTH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B923234;
	Tue,  1 Apr 2025 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538508; cv=none; b=e/VjJvDCjC6OFIOTQ8QdZDJAS5WxX/aSNM4+9EVIrR3moRlRM4Yj8teMF+pwfad3z6TXWQkhtvcxrrswdxFurLZA4/dGrmCcjL/XjPeYdR8vha4g5lxkkllrru8ovYxFWHxBO4aPsOuIt7tP2xcyPS1691RB1QwVF/CJyul33S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538508; c=relaxed/simple;
	bh=Pq01BnmtIB0SRbfwFrvg4kMEEs+bl4tSxJrZiEgI3DM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XTtyZI4CfVXWVpVJ0+V1CTUjNXZjq4MYEB3Z1qxJQ07rBDQhmvlF2w/GHVdtVnSymwAmz+BVBw2Wrz8iXrfgC1hmFNEPBalDpXmcbpeywWfH5yA3nWAtffwkvlNVflMv9Dt2VQMdqxfLYM3l+SNqtFsJIrh5PvS6Y26So9mhpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UoUO6NTH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf6wq026021;
	Tue, 1 Apr 2025 20:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tIGOSl
	v8z58Q+wkjqybI3RqRtNeKMb+3FoycqEDPy7c=; b=UoUO6NTHWVb5zMc+jEi1wQ
	Z8sB3FnMIjlbysZHqcOp/Na1Y4R0BUW+Qi4hqi7OWy+T/hxKjTfOej9YUd3iD5X/
	2jS3X0WTKAsvrFyU8ImmV0rnd9ZUctNCeA3+yCNoZ9K5wxgsuvNvxdBoBvx4NxRM
	/sJJZLHQWCi58o0qf7GFHkxE/s22agFRlxDD41J/ua3rHgEFLCK8NWmvxvIEss7X
	vcPbW7u+XA9G5fCftdITrVeKz3vmnGNxVaWLim3xhNo9zS26doUjoxtJbnu+Pgjf
	4seoX3qiMaGR3dekXaIhVkWZVBLK9+Sbv13yGu9YDkr8MkrXjrIMwhG/lb3C3d3g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q608w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 20:14:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531KASgX010272;
	Tue, 1 Apr 2025 20:14:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nv9su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 20:14:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531KEoeR31457894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 20:14:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EBA5805C;
	Tue,  1 Apr 2025 20:14:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E43858054;
	Tue,  1 Apr 2025 20:14:50 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 20:14:50 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Apr 2025 15:14:49 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <87wmc9wg2z.ffs@tglx>
References: <87wmc9wg2z.ffs@tglx>
Message-ID: <e83622773199665d39db5f724537d9dd@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 97ggxYno2G7sRr-B88pD6kEeaU540Xda
X-Proofpoint-GUID: 97ggxYno2G7sRr-B88pD6kEeaU540Xda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_08,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=995
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010122

On 2025-03-28 06:27, Thomas Gleixner wrote:

> You are completely missing the point. This is not a problem restricted
> to PCI/MSI interrupts.
> 
Thanks for all suggestions! I will investigate more and check if we can 
fix it in device driver.

Looks several device drivers in kernel use two kernel APIs to set/clean 
IRQ_NO_BALACING status for a given irq.

irq_set_status_flags(irq, IRQ_NO_BALANCING);
irq_clear_status_flags(irq, IRQ_NO_BALANCING);

With these two APIs, device driver can decide if using kernel irq 
balance or setting irq affinity by driver itself?

So we can set/clear IRQ_NO_BALANCING during reset.

Thanks,
Wendy


