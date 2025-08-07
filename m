Return-Path: <linux-pci+bounces-33518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5AB1D278
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41735812C7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECD1537A7;
	Thu,  7 Aug 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="R77yKQye"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143061E0083
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548157; cv=none; b=uK0lAi7SBS4XyLynFLEPUEm61f79BG8xgkJBoyuZ8WAFxT7qRToBAuTL8wg6mbuPxMQ1bJU9FwdQpkzOWooVzefFSZUTE/Rg5RmfmyMSiMrHrapiNO4Gvldijv1hlBmFN9xuyj0HZYYHEtR4N6RDegw39+EI/MRCgs+fl09Z1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548157; c=relaxed/simple;
	bh=xtDEhWjuBWdSDCTWLwgagTDhWx3Dlmr8laZgs1ukzNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6FNfmMmaPjxFZYbMkHB4itS3tSNI8Eq1Njj/hta1Id9Ul0z/MGFrfuscHt+uIp1G1XkoVFetCeoCGEhp2B/J55WGw+jJsajySGzkpaut2C2ei3Fn33FtLYzGHkgryKLk7vvhDByNO+r/M6bRgutsTLcyibt7Bh775eXy0D1onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=R77yKQye; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4byHLc31ZCz4Yw0;
	Thu,  7 Aug 2025 02:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1754548152; bh=xtDEhWjuBWdSDCTWLwgagTDhWx3Dlmr8laZgs1ukzNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R77yKQyex7NKlsTM1aKH1sfjmuDfTVR4QgnlIXJUM232Q/A2ykpn0PGldFr8lfn8n
	 eJehZPcUmxhkyOIJrtkxjaCTKn+54YGuOZzokuge3DmLXO8fGfXymjjoZIKGykx02B
	 cMLpp4YKjX/nfVEcHs2aVfMzKk/1ogln9Gn/Yfco=
Message-ID: <1843af2c-c9a2-4cd2-b66c-a481edd31bd6@panix.com>
Date: Wed, 6 Aug 2025 23:29:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
To: Nam Cao <namcao@linutronix.de>
Cc: mani@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Me <kenny@panix.com>
References: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>
 <87v7mzn3ta.fsf@yellow.woof> <20250807051608.ExhI9r1T@linutronix.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250807051608.ExhI9r1T@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I can boot with this patch- thanks!

-K

On 8/6/25 22:16, Nam Cao wrote:
> On Thu, Aug 07, 2025 at 06:39:13AM +0200, Nam Cao wrote:
>> Kenneth Crudup <kenny@panix.com> writes:
>>
>>> I'm running Linus' master (as of today, cca7a0aae8958c9b1).
>>>
>>> If I revert the named commit, I can boot OK. Unfortunately there's no
>>> real output before the machine reboots, to help identify the problem.
>>>
>>> I have a(n enabled) VMD in my Alderlake machine:
>>>
>>> [    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM)
>>> i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
>>>
>>> If there's something else I can try, let me know.
>>
>> Thanks for the report. It is unfortunate that there is no output to work
>> with :(
>>
>> Let me stare at the commit again..
> 
> Another person reported problem with this commit, and that was resolved
> with the diff below.
> 
> Does it fix your case too?
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9bbb0ff4cc15..b679c7f28f51 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>   static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
>   			 unsigned int nr_irqs)
>   {
> +	struct irq_data *irq_data;
>   	struct vmd_irq *vmdirq;
>   
>   	for (int i = 0; i < nr_irqs; ++i) {
> -		vmdirq = irq_get_chip_data(virq + i);
> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		vmdirq = irq_data->chip_data;
>   
>   		synchronize_srcu(&vmdirq->irq->srcu);
>   
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


