Return-Path: <linux-pci+bounces-40141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF16C2DFCB
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D23718861A4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05323EAB8;
	Mon,  3 Nov 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7WI3lfH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896523F424;
	Mon,  3 Nov 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200393; cv=none; b=dAsPRLgIXUGiVPrq1Z4mZ/XgcQ9H28cEaSAB3LueK2ycsJU9Qn5NVSjjxdad+mQX2bqb2BnFcWjFv+TPY1SonZe8mhtUVTQ78yhClo3JENH/guSaIy7KP4QFlqk//ptSRNZXoMlY+GJATiPkepIAGLb+ri42prxtpql2MDyd1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200393; c=relaxed/simple;
	bh=Kac5lSc3ZFVs7GEaDyy81vhSMWGmEIGM3XQ2XmIyVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2MluAaj+SK2AZXJktNZvydf02jCbn8t2LG72tFC4lxZVgZKzoDmCbsfFriEGpC7F6YuA/PofaDGwNQzKBUa0dJ3vztutMWYnl23sZgVmzRU0BWgpI0/Wsny3gCTYy8jKJrVDxZ4QvizA1oQELPxTs9ybgHotLZC/oVqbOgYBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7WI3lfH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3FpVRI014150;
	Mon, 3 Nov 2025 20:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=htRMfZ
	9R3to4vxd+58ydhHlps46rgkZllpNuI6g3iBw=; b=e7WI3lfHtPmcC9bk5FHf4E
	Pbo17wciWbksZGv40jfQwaIIaR2BaoXltEBn9Gpm6wUXTImi3f5SqWaARdH7J0cL
	uBKvlJyWCZLN5Isg1XNurz33mb2eSkerkcmh7dKo75yJkAmeY93BWecb3bftGwvj
	AX3Y//oJt8yoTYwyazj2iGU+Ter/eVEJ5xU/4YiOp7apz97bx//f9AyXst8EG5/C
	q37JZK2f+pS8BiI7ob1uDUSLFGxW0HfVqbTikR5RW8us7IgB1IwoVkNIXCgIhgdz
	z8QLfcarRlR/R8tmChnewTd6JSF/ZJ7KrjF0kjIspqlPtq0tutZbu8U31pRfu1kA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v1rak5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 20:06:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3H88NX027407;
	Mon, 3 Nov 2025 20:06:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwy7p8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 20:06:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3K6QUW43254104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 20:06:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D255804E;
	Mon,  3 Nov 2025 20:06:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E0C5803F;
	Mon,  3 Nov 2025 20:06:25 +0000 (GMT)
Received: from [9.61.255.153] (unknown [9.61.255.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 20:06:25 +0000 (GMT)
Message-ID: <a14936ac-47d6-461b-816f-0fd66f869b0f@linux.ibm.com>
Date: Mon, 3 Nov 2025 12:06:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI fixes for s390
To: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc: schnelle@linux.ibm.com, mjrosato@linux.ibm.com, bblock@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
References: <20251022212411.1989-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251022212411.1989-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OnjSUmc5bndQ4lonZnMWVcKPksdc1BZv
X-Proofpoint-ORIG-GUID: OnjSUmc5bndQ4lonZnMWVcKPksdc1BZv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX7EGAOqdm7CoL
 UvCSAvI9b4HhxNJr0S4qFbxI1cpi5m59f9ySZvatQl+ukd2DYjABuePeF6ZVevUKCGmm1kTzHXw
 xescUuwMQJGErunTMKiZs/sYHYTTgaUK0gOqbVI9pp6OtBeL/R/ElCmzqc72ctD2PZ/AItkMe93
 Si4rZxQ/5GEoFpBjRLLtgPESNK6rWyQc92+ZFNz9sMj4S19ZqF5aIDvhj8YwjvzLCsSPuPTeuhT
 HMQQGfAFmhc34cxcbGXXYoyGWX5+9ZWWEvGcnVUYGhtZ0nB7z6bW12ObFr9hX66XVegP08vSQJ4
 ZFpdsTK51CgEEyMJmx0EH5WO+tdVu5ThVqJk9ZDdsJ7j6cGJPVeJjD9J+wYYx13cAd+3dnr9X5K
 WLGZTb2SYwFKOTrw9vHJ+DinLOFiJw==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=69090b44 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ot00pLiJCk8oO3MthJUA:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Hi Bjorn,

Polite ping. I would like to get these patches merged as they fix some 
existing issues for PCI devices on s390. Please let me know if there are 
any concerns with the patches or anything needs to be changed.

Thanks

Farhan

On 10/22/2025 2:24 PM, Farhan Ali wrote:
> Hi,
>
> I came across some issues in PCI code for s390 while working on VFIO error
> recovery for s390 PCI devices [1]. These patches can be indepedently applied and
> has no depedency on error recovery patch series. We would like to get these
> patches merged as they do fix some existing issues.
>
> [1] https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/
>
> ChangeLog
> ---------
> v1 -> v2
>     - Re-work patch 1 on setting per_func_slot flag. The flag is set if platform
>     enables per function pci slots (currently only enabled for s390).
>     - Drop R-b tags for patch 1.
>
> Thanks
> Farhan
>
>
> Farhan Ali (2):
>    PCI: Allow per function PCI slots
>    s390/pci: Add architecture specific resource/bus address translation
>
>   arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
>   drivers/pci/host-bridge.c |  4 +--
>   drivers/pci/pci.c         |  5 +--
>   drivers/pci/slot.c        | 25 +++++++++++--
>   include/linux/pci.h       |  1 +
>   5 files changed, 102 insertions(+), 7 deletions(-)
>

