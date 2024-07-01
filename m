Return-Path: <linux-pci+bounces-9503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24591D9B7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F51C221AA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B382498;
	Mon,  1 Jul 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDmpEFyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FE347B4;
	Mon,  1 Jul 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821479; cv=none; b=kK42RispxcuwZFiINA261swNY7xnW6r6ujg/X5j/AjeXitQKnUCd7RywsH5QRMT4LdaCkuWnVd1jeIQ7DfY9dNQJmjbeGvwwrUJ2R2Ug0OWRSByR72NaPf8sAh45kXq2ltHwb0Bp2sLLMcPXUHJZ4O7e2or58zNeT7Fm7DtPCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821479; c=relaxed/simple;
	bh=CO0atmO61p3aGajumua4T4JBohTwicxstoDR6BwINw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iR1SXlCtywLilQdJbcepvHxisxo5peCVXI2pOxj86dIcjk3eitpvJ5q+lJ83zuWoht5oUTis136pxVL/1expvjEpFK9rxYNJF+D/kPtrpWfht2fTlZi4I9znN5bvrQumlZdXW9cm+cJqXwOtz6D+VSrMaq74Ueph4QOokUBT900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EDmpEFyz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617ucU6018969;
	Mon, 1 Jul 2024 08:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	nCQv8/viKXnzHIWRR3w7m2uDPzOmhLiFd/+m7V5VxVE=; b=EDmpEFyzjuXM29op
	Xhsg9nsSWUbVnRXaDnP5Qiv4ZJdYfpycohP/HfSMeJqzew0Xb7CQfOyix0475LcO
	UDmHIKOUDu7lVZdzbaakWf2lfa5hJJaWZPaJhEJqNybhXVkvD6wXuzPQPlBq2NLI
	+VMmRmlAuTtDeV2DKpWbOn1+ETvUc0uBJEA3zzysrHIncOih9RtWSJpaszNxLCdD
	5JVx5xRH9CZ/5654DqFwQpkHkndhjCgYCcV6BrNYvzJWYT52IgKxrBl1znp1An0H
	159AvMqx8l3vejfk0F0rzKY1YgyssueT8jkjsXeZsPABU27hXWM2fvFSCsfG8pdZ
	e9JrLA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403r3u02w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:11:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4618B1MO009261;
	Mon, 1 Jul 2024 08:11:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403r3u02vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:11:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46185Ddv026417;
	Mon, 1 Jul 2024 08:11:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpp5bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:11:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4618AsMV30802434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 08:10:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF6282004B;
	Mon,  1 Jul 2024 08:10:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 968442004D;
	Mon,  1 Jul 2024 08:10:51 +0000 (GMT)
Received: from [9.109.241.85] (unknown [9.109.241.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 08:10:51 +0000 (GMT)
Message-ID: <c17fa094-f337-4422-8ae0-d554d66dd92a@ibm.com>
Date: Mon, 1 Jul 2024 13:40:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
To: Krishna Kumar <krishnak@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org, linux-pci@vger.kernel.org,
        Shawn Anastasio
 <sanastasio@raptorengineering.com>,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        gbatra@linux.ibm.com, bhelgaas@google.com,
        tpearson@raptorengineering.com, oohall@gmail.com,
        brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20240701074513.94873-1-krishnak@linux.ibm.com>
 <20240701074513.94873-2-krishnak@linux.ibm.com>
Content-Language: en-US
From: Krishna Kumar <krishna.kumar11@ibm.com>
In-Reply-To: <20240701074513.94873-2-krishnak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uGtoPARkEk5c4KUJx69RJXApADgzx_sF
X-Proofpoint-ORIG-GUID: pmjukpBmqWJ1wsAj0Hj6FZSeQcph6LQ5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407010060

Hi Michael,

When you apply/merge the patch, please consider below URL in commit message.
This is the URL where this issue was reported - 

https://lists.ozlabs.org/pipermail/linuxppc-dev/2023-December/267034.html

Thanks, 
Krishna


On 7/1/24 1:15 PM, Krishna Kumar wrote:
> Description of the problem: The hotplug driver for powerpc
> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
> hot-unplug/disable the PCIe switch/bridge from the PHB.
>
> Root Cause of Crash: The crash is due to the reason that, though the msi
> data structure has been released during disable/hot-unplug path and it
> has been assigned with NULL, still during unregistration the code was
> again trying to explicitly disable the MSI which causes the NULL pointer
> dereference and kernel crash.
>
> The patch fixes the check during unregistration path to prevent invoking
> pci_disable_msi/msix() since its data structure is already freed.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gaurav Batra <gbatra@linux.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Brian King <brking@linux.vnet.ibm.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
> ---
>  drivers/pci/hotplug/pnv_php.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 694349be9d0a..573a41869c15 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -40,7 +40,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>  				bool disable_device)
>  {
>  	struct pci_dev *pdev = php_slot->pdev;
> -	int irq = php_slot->irq;
>  	u16 ctrl;
>  
>  	if (php_slot->irq > 0) {
> @@ -59,7 +58,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>  		php_slot->wq = NULL;
>  	}
>  
> -	if (disable_device || irq > 0) {
> +	if (disable_device) {
>  		if (pdev->msix_enabled)
>  			pci_disable_msix(pdev);
>  		else if (pdev->msi_enabled)

