Return-Path: <linux-pci+bounces-40359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32313C36951
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7661A45B94
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCA23EAA1;
	Wed,  5 Nov 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L6a4pKWT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8026CE0F;
	Wed,  5 Nov 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358086; cv=none; b=eK7f6p3OngwD5FX8YXZuL4nrPdfziYHoNkzEuDKMDsNiB6EH3F8wJcxaumYHTnm++6YJOH7nY4vaXRA2JRy+ov+ZihH57Me/XUhd5HAek6PrFIjl7VzeAA7XhFaKuYTMv4l1LCPHvIo306ieJYNxkqL1rSWmO4+top4xzta5+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358086; c=relaxed/simple;
	bh=cHxAaKIXL3i/jmnRG0py7jhTnyhgh3Mm/5zptuC/FDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDRDtGoTGAPAHyPr9YoKZ26fjRDvZOKqQukg5NkVMSk2RPqRgGOIDYn30vsx44YqcVpaWghj1xEzboccXZqKNfyeFHgevkgqpLtw20opDlzVd1PK70qI36QsDMRtIkSU9SpcOuzOweTiKMqw/AcMqXWyIg0Jo4Y3TTP/BhcWrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L6a4pKWT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ghm8iWL49NV0j9nnNI8LTVhhezP2ePDGm8w0tfXDzBQ=;
	b=L6a4pKWTpqFsyxK5AzB5nKpgBuX0cHEUoHiROvI9SRb82cSynCb0KCJgEne3tf
	IJXRKJYq2zljqnXHvbJWaWFMKxU7QTxgBQ2zEFnn76MHLLVXGeACo1O/OGrkYUW1
	pS/L+FeRM0TZO2liinCxCwsD4ns5ggntx2qlkzrDe6dsY=
Received: from [IPV6:240e:b8f:927e:1000:c17c:cb22:ae30:df94] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXHF0zcwtpSMA+Bw--.9773S2;
	Wed, 05 Nov 2025 23:54:28 +0800 (CST)
Message-ID: <aa9f58f6-054e-4fb4-8cb7-01ea88d7f483@163.com>
Date: Wed, 5 Nov 2025 23:54:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation
 delays
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101160538.10055-4-18255117159@163.com>
 <20251103153734.GA1806239@bhelgaas> <aQjlOHJoj-Fkkk4b@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aQjlOHJoj-Fkkk4b@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXHF0zcwtpSMA+Bw--.9773S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrAry8Xr47ur1UCr1UAwb_yoW8JFy7pa
	4rJFW5tF40yrZ5Gw1vvanxXF1Fyr9xGF9Fgr48WryftFyDAwnxJFy0gFWYgF9xArWrCw1U
	Zay5WF1fXFs8Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsBMiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhX8o2kLXfHYkQABs2



On 2025/11/4 01:24, Lukas Wunner wrote:
> On Mon, Nov 03, 2025 at 09:37:34AM -0600, Bjorn Helgaas wrote:
>> On Sun, Nov 02, 2025 at 12:05:37AM +0800, Hans Zhang wrote:
>>> Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
>>> operation delays to improve code readability.
> [...]
>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>> @@ -28,6 +28,9 @@
>>>   #include "../pci.h"
>>>   #include "pciehp.h"
>>>   
>>> +#define WAIT_PDS_TIMEOUT_MS	10
>>> +#define POLL_CMD_TIMEOUT_MS	10
>>> +
>>>   static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
>>>   	/*
>>>   	 * Match all Dell systems, as some Dell systems have inband
>>> @@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>>>   			smp_mb();
>>>   			return 1;
>>>   		}
>>> -		msleep(10);
>>> +		msleep(POLL_CMD_TIMEOUT_MS);
>>
>> Lukas might have different opinions and I would defer to him here.
>>
>> But IMO (a) these aren't timeouts, they are poll intervals, (b) the
>> values are arbitrary with no connection to a spec, so less reason for
>> a #define, and (c) the #defines don't improve readability because now
>> I have to look at two places to understand the poll loops.
> 
> I agree on all counts.
> 

Hi Bjorn,

Please drop this patch.

Best regards,
Hans


> Thanks,
> 
> Lukas


