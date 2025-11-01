Return-Path: <linux-pci+bounces-40037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E6C28258
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417F7402A23
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073E1C860B;
	Sat,  1 Nov 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ozt+HsMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814634D396;
	Sat,  1 Nov 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013786; cv=none; b=bLM2L4nH69gM4yck4BXeRHQiVLMMQhwkqy6ASBXmtOiPCtubHrV0RLs1jXpvoVCnkKwf/+xahXHRqhcKxFPsme1wqQ2fryuydmRuF2tTDy+ez52TQIctkt7W+fqSSwTw/26iAuwAUfnsO4CcE5NcnE0BVtVc2BN5msHdw+b7jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013786; c=relaxed/simple;
	bh=K2JYXfQ0hVDX8OIELLq6/FdS5/KG83sW03rGHpTMU/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V4OsG/3ZqiJXEM6l+gXiZ8SPgyuwouYODeLPLT7j8rE2WPUfhowStu8w22KDK00tW+cnqE0NjfTOLg0cSGfEKPlchhvpqa0JhtnOuE+vIumRbIdD/8iCuXlrhBCHzzTU/IIsS2lQ5IMooavZR8UwTWp6hBA2Pzy8Dd1xG27p3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ozt+HsMT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=dguzoqFh9vYupZqCUF84hwScckDIUOLpGnPK71FG71w=;
	b=Ozt+HsMT43uGLkU4z9xdYV2n7kn1ibNZYJ+g4YfqcwyCCwQmZ32uPVgZ/gyl2b
	nJYuOuk5FhL+mskcZv5S1stWs6qnMLBsPf0d/5DQ7Lw3n65BicsKdx2M3fR9FDSb
	/daTnrnXT5OnRsgRBA2LrKnjnC+10/+1HThm76lhJzIcI=
Received: from [IPV6:240e:b8f:927e:1000:3c54:eb11:a795:c9c9] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3VyZGMgZpRqjcAw--.51288S2;
	Sun, 02 Nov 2025 00:16:07 +0800 (CST)
Message-ID: <eb45e253-0aec-4fca-9bfe-31d23fe8bd1d@163.com>
Date: Sun, 2 Nov 2025 00:16:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation
 delays
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, bhelgaas@google.com,
 helgaas@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101160538.10055-1-18255117159@163.com>
 <20251101160538.10055-4-18255117159@163.com>
 <c1afb7fa-c45f-44e3-81e1-200da04c29ef@wanadoo.fr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <c1afb7fa-c45f-44e3-81e1-200da04c29ef@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3VyZGMgZpRqjcAw--.51288S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw48AF15AF1rGr47Aw4Utwb_yoW8AF1xp3
	95AFWYyF1rJr45CayrZan8Jrn8A3ZxCrZFkrW8GryfCFyxA3s8A3WfKa4YqF1fAryUur1U
	XFy5JFy5XFs8tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uk3k_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhj4o2kGKs2TPQAAsf



On 2025/11/2 00:13, Christophe JAILLET wrote:
> Le 01/11/2025 à 17:05, Hans Zhang a écrit :
>> Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
>> operation delays to improve code readability.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/hotplug/pciehp_hpc.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/ 
>> pciehp_hpc.c
>> index bcc51b26d03d..15b09c6a8d6b 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -28,6 +28,9 @@
>>   #include "../pci.h"
>>   #include "pciehp.h"
>> +#define WAIT_PDS_TIMEOUT_MS    10
>> +#define POLL_CMD_TIMEOUT_MS    10
>> +
>>   static const struct dmi_system_id 
>> inband_presence_disabled_dmi_table[] = {
>>       /*
>>        * Match all Dell systems, as some Dell systems have inband
>> @@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, 
>> int timeout)
>>               smp_mb();
>>               return 1;
>>           }
>> -        msleep(10);
>> +        msleep(POLL_CMD_TIMEOUT_MS);
>>           timeout -= 10;
> 
> Should we have: timeout -= POLL_CMD_TIMEOUT_MS;
> 
> ?

Hi Christophe,

Thank you very much for your reply and reminder.

If Bjorn finds it meaningful, I will fix it in the next version.


> 
>>       } while (timeout >= 0);
>>       return 0;    /* timeout */
>> @@ -283,7 +286,7 @@ static void pcie_wait_for_presence(struct pci_dev 
>> *pdev)
>>           pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>>           if (slot_status & PCI_EXP_SLTSTA_PDS)
>>               return;
>> -        msleep(10);
>> +        msleep(WAIT_PDS_TIMEOUT_MS);
> 
> Same with WAIT_PDS_TIMEOUT_MS.
> 

Will change.

Best regards,
Hans

> CJ
> 
>>           timeout -= 10;
>>       } while (timeout > 0);
>>   }


