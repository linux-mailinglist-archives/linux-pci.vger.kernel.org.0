Return-Path: <linux-pci+bounces-40360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F1C369FE
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 17:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530481A264CF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0A32E155;
	Wed,  5 Nov 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P4n1P25v"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E63191D1;
	Wed,  5 Nov 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358111; cv=none; b=AhqbdQzq7xTlDLCk2wTWa6khfSqcson41iu5+B8eg23gAhi7LX+pvXCbWwwDhWP6juHDqG0zL2/F0Ay8Eo3TlWO0XD00fwn3PITs+GrkqMh9m4LivxiC3AK/lL5fJFrtFAge2PC/MYDfPMB0BE/djo0qC3sSm3RPWYT1IeSzvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358111; c=relaxed/simple;
	bh=kGzYEp9SFxcnthaF1TrKK09On/2f8FlBFW5KzORXOKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxinRGHQc7mOO0SuwfRiK4OPc+GL928Ojdijrwz4owJYpPNOpCD5o+6QroPcsEQXt2SgpYLwaAIwjFZfRpEey2jigoNjZUGM9zcK0QUYMnhtHh1llF+xLieJLAbZIhsCzrP1yDm8wFOAh9gdB0AQzF7SpF2cYQy2PfTixvn/H9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P4n1P25v; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tcdVGvvYVu/PkbNMPCqYgG9UvdQnVB9zG2W8MMjYye8=;
	b=P4n1P25vtWYb5G7Ut30LDYJA+ftgaR6FrRZB4Fow0nNhVxCGw/yGXaOIQ3K868
	fzx0rInd5v4/lMuvWqI4newHKfrvJ9VsTxCkKjTE4PQxJTPRsyOiC/vVEQE16sL0
	gSESp/0c3XFuXHx7QAf/W768+dttqELZMbgaSE+qI/LDs=
Received: from [IPV6:240e:b8f:927e:1000:c17c:cb22:ae30:df94] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBX3F1Bcwtpnx9GBg--.6198S2;
	Wed, 05 Nov 2025 23:54:41 +0800 (CST)
Message-ID: <8497a7c8-cd2b-4718-9ca5-69b21cde667b@163.com>
Date: Wed, 5 Nov 2025 23:54:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: Add macro for link status check delay
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251103153922.GA1806421@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251103153922.GA1806421@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBX3F1Bcwtpnx9GBg--.6198S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw18Gr4xtF48Zr47GFWfXwb_yoW8Jry5pF
	WkAa4akFWruw4293Z3Z3WUuF1YganFyryxCrW0gw15W3Wayr15WF45JF1jqrn7ZrZ7Gr12
	ywn8A3WfWFWqkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U038OUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwEKrWkLc0FuBQAA3e



On 2025/11/3 23:39, Bjorn Helgaas wrote:
> On Sun, Nov 02, 2025 at 12:05:36AM +0800, Hans Zhang wrote:
>> Add PCIE_LINK_STATUS_CHECK_MS macro for link status check delay.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 86449f2d627b..b57d8e4c3a48 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -77,6 +77,8 @@ struct pci_pme_device {
>>    */
>>   #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
>>   
>> +#define PCIE_LINK_STATUS_CHECK_MS 1
>> +
>>   static void pci_dev_d3_sleep(struct pci_dev *dev)
>>   {
>>   	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>> @@ -4632,7 +4634,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>>   		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>>   		if ((lnksta & lnksta_mask) == lnksta_match)
>>   			return 0;
>> -		msleep(1);
>> +		msleep(PCIE_LINK_STATUS_CHECK_MS);
> 
> Doesn't seem worth it to me.

Hi Bjorn,

Please drop this patch.

Best regards,
Hans

> 
>>   	} while (time_before(jiffies, end_jiffies));
>>   
>>   	return -ETIMEDOUT;
>> -- 
>> 2.34.1
>>


