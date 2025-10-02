Return-Path: <linux-pci+bounces-37407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F703BB39F5
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 12:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226CD188CA4D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175752F9C2A;
	Thu,  2 Oct 2025 10:20:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C52EDD52;
	Thu,  2 Oct 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400438; cv=none; b=CqBQ8miqsvEhPG+zH0iK6iw9R0KU2IYiYHmH4Dc7T4Zqm3MrviVwK3PtOF95U+q348Vrj5lk9e+BSCa2xwXvHBovpXgLyzG+8bqiYjOuOR7+YDYwiDB2/+5YZiCBslRwRBkOIfcZQR5/tAJA7nae5dzLC8hnyh8BPCXthELKuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400438; c=relaxed/simple;
	bh=US6asV8i0eIu1t+KJRb7YRcaFr03ZIyKY5f4wIwvZPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVD5eoIlRujTkYyrxfhqKt5tUP4YvazBXS7itauEnl+a80Hiaybggq/EX+8D1m5w7sZUWolWUT+nmtYBpMZEPEtruGC1HR9zyJ5TdMMewikewMtNPaEXNluSZ14+n0FVY+tHEmiN9rCHnO+ujIrMqq3liDqKzVbdaRnj3mq1Svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ccnWf6vw3z9sSg;
	Thu,  2 Oct 2025 12:06:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mj6qsATOgVWG; Thu,  2 Oct 2025 12:06:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ccnWf5Jssz9sSd;
	Thu,  2 Oct 2025 12:06:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 87D8F8B773;
	Thu,  2 Oct 2025 12:06:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0QNfI8vOuITt; Thu,  2 Oct 2025 12:06:38 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0759F8B769;
	Thu,  2 Oct 2025 12:06:37 +0200 (CEST)
Message-ID: <a63012d4-0c98-4022-8183-5a3488ca66e9@csgroup.eu>
Date: Thu, 2 Oct 2025 12:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <7b5c1235-df92-4f18-936c-3d7c0d3a6cb3@linux.intel.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <7b5c1235-df92-4f18-936c-3d7c0d3a6cb3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/09/2025 à 17:10, Sathyanarayanan Kuppuswamy a écrit :
> 
> On 9/29/25 2:15 AM, Breno Leitao wrote:
>> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
>> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
>> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
>> does not rate limit, given this is fatal.
>>
>> This prevents a kernel crash triggered by dereferencing a NULL pointer
>> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
>> AER info. This change aligns pci_print_aer() with 
>> pci_dev_aer_stats_incr()
>> which already performs this NULL check.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal 
>> error logging")
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> - This problem is still happening in upstream, and unfortunately no 
>> action
>>    was done in the previous discussion.
>> - Link to previous post:
>>    https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F20250804-aer_crash_2-v1-1- 
>> fd06562c18a4%40debian.org&data=05%7C02%7Cchristophe.leroy2%40cs- 
>> soprasteria.com%7Cfd3d2f1b4e8448a8e67608ddff6a4e70%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638947554250805439%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6yTN1%2Fq%2Fy0VKX%2BXpE%2BiKxBrn19AkY4IPj01N2ZdxEkg%3D&reserved=0
>> ---
> 
> Although we haven't identified the path that triggers this issue, adding 
> this check is harmless.

Is it really harmless ?

The purpose of the function is to ratelimit logs. Here by returning 1 
when dev->aer_info is NULL it says: don't ratelimit. Isn't it an opened 
door to Denial of Service by overloading with logs ?

Christophe

> 
> Reviewed-by: Kuppuswamy Sathyanarayanan 
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> 
> 
>>   drivers/pci/pcie/aer.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e286c197d7167..55abc5e17b8b1 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct 
>> pci_dev *pdev,
>>   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>>   {
>> +    if (!dev->aer_info)
>> +        return 1;
>> +
>>       switch (severity) {
>>       case AER_NONFATAL:
>>           return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
>>
>> ---
>> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
>> change-id: 20250801-aer_crash_2-b21cc2ef0d00
>>
>> Best regards,
>> -- 
>> Breno Leitao <leitao@debian.org>
>>


