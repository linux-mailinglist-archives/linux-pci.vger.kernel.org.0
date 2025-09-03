Return-Path: <linux-pci+bounces-35396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D56B427A7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E01620080C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A82D6619;
	Wed,  3 Sep 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bOh4APqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4B223DDA;
	Wed,  3 Sep 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919533; cv=none; b=eDppwKd330ZFoZOs2snKAR28r1laIWRRTnaFHI9prfrBK6+PDkSz2EZ5WYAA519B7dCiJIz1N+urdN7Waxajm5ABFL1LC1YwkBaOscJl1ybojIuwPOegNduThTgHWoIifS2E3n073uxDOXKJdOOfI2JaVuH347QGDg5E9HhFbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919533; c=relaxed/simple;
	bh=FiIkiSpuFxT0g5abb+gv+xkTrAB4hIzjIQ1Ot5c28S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pY71YRrKbnO1jQkH2QLSHCiipcy64w4k25Y58uq5JbULRxb/cJ/ePUf7ZWFroa8RLsTS7bT9QDqVZC42Q5o3TwQ5I2EHqQDQblx+88ue7iIeSdSJyfjENmRihHNM53eX/FbSndKeM0Tgpplhts9L2wKoHbHK8hMthd5YHRwguOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bOh4APqY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zOc1TU+gCwikwyFspVnDU43s9yZA+Tvry4r7pEjJC3E=;
	b=bOh4APqYgVVUTojPwrg7/+GF1ejFCsxRcTd8ChJu9t/RYOTJFp995PmkYezqv0
	pwbHyJlX/OJgT0bU936BE6BeO6OZFviHFz1ydpDPF+KrNY0mpcVvgDFcGSN3xERE
	deM0hAizpbNXHSuwUaQbhYezqvXgkREmvE9NReioIYqE4=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHFEi6drho9V5RGA--.49924S2;
	Thu, 04 Sep 2025 01:11:23 +0800 (CST)
Message-ID: <76cdf841-2c72-4faa-b2b9-7b2098337de0@163.com>
Date: Thu, 4 Sep 2025 01:11:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250902174828.GA1165373@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250902174828.GA1165373@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHFEi6drho9V5RGA--.49924S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4UAw1ktF1xuF1xCr1xXwb_yoW7ZFy8pa
	yUJwsayFs7GFyfua1DZa1F9ryYvas7ArW3Jr98K345C3Z8AFyktryYkw4rA3s7Jr92y34S
	vr1jqFyUu3Z0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcJ5wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhS9o2i4MaDnSgABsd



On 2025/9/3 01:48, Bjorn Helgaas wrote:
> On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
>> Current PCIe initialization logic may leave root ports operating with
>> non-optimal Maximum Payload Size (MPS) settings. While downstream device
>> configuration is handled during bus enumeration, root port MPS values
>> inherited from firmware or hardware defaults ...
> 
> Apparently Root Port MPS configuration is different from that for
> downstream devices?

Dear Bjorn,

Thank you very much for your reply.

Yes, at the very beginning, the situation I tested was like the previous 
reply:
https://lore.kernel.org/linux-pci/bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com/


Niklas helped find the documentation description of RK3588 TRM：
https://lore.kernel.org/linux-pci/aACoEpueUHBLjgbb@ryzen/


Dear Niklas,

If I have misunderstood Bjorn's review opinion, please help me clarify 
it together. Thank you again for helping me ping the Maintainer. When I 
wanted to ping, you did it before me.


> 
>> might not utilize the full
>> capabilities supported by the controller hardware. This can result in
>> suboptimal data transfer efficiency across the PCIe hierarchy.
>>
>> During host controller probing phase, when PCIe bus tuning is enabled,
>> the implementation now configures root port MPS settings to their
>> hardware-supported maximum values. Specifically, when configuring the MPS
>> for a PCIe device, if the device is a root port and the bus tuning is not
>> disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
>> match the Root Port's maximum supported payload size. The Max Read Request
>> Size (MRRS) is subsequently adjusted through existing companion logic to
>> maintain compatibility with PCIe specifications.
>>
>> Note that this initial setting of the root port MPS to the maximum might
>> be reduced later during the enumeration of downstream devices if any of
>> those devices do not support the maximum MPS of the root port.
>>
>> Explicit initialization at host probing stage ensures consistent PCIe
>> topology configuration before downstream devices perform their own MPS
>> negotiations. This proactive approach addresses platform-specific
>> requirements where controller drivers depend on properly initialized
>> root port settings, while maintaining backward compatibility through
>> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
>> utilized without altering existing device negotiation behaviors.
> 
> This last paragraph seems kind of like marketing without any real
> content.  Is there something important in there?

I think the above elaboration is sufficient. I will delete it.

> 
> Nits:
> s/root port/Root Port/

Will change.

> 
> Reword "implementation now configures" to be clear about whether "now"
> refers to before this patch or after.

Will be modified.

> 
> Update the MRRS "to maintain compatibility" part.  I'm dubious about
> there being a spec compatibility issue with respect to MRRS.  Cite the
> relevant section if there is an issue.

The description is inaccurate. I will correct it.



I plan to modify the commit message as follows:
If there are any incorrect descriptions, please correct them. Thank you 
very much.

Current PCIe initialization logic may leave Root Ports operating with
non-optimal Maximum Payload Size (MPS) settings. While downstream device
configuration is handled during bus enumeration, Root Port MPS values
inherited from firmware or hardware defaults might not utilize the full
capabilities supported by the controller hardware. This can result in
suboptimal data transfer efficiency across the PCIe hierarchy.

With this patch, during the host controller probing phase and when PCIe
bus tuning is enabled, the implementation configures Root Port MPS
settings to their hardware-supported maximum values. Specifically, when
configuring the MPS for a PCIe device, if the device is a Root Port and
the bus tuning is not disabled (PCIE_BUS_TUNE_OFF), the MPS is set to
128 << dev->pcie_mpss to match the Root Port's maximum supported payload
size. The Max Read Request Size (MRRS) is subsequently adjusted by
existing logic in pci_configure_mps() to ensure it is not less than the
MPS, maintaining compliance with PCIe specifications (see PCIe r7.0,
sec 7.5.3.4).

Note that this initial setting of the Root Port MPS to the maximum might
be reduced later during the enumeration of downstream devices if any of
those devices do not support the maximum MPS of the Root Port.

Best regards,
Hans

> 
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/probe.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4b8693ec9e4c..9f8803da914c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2178,6 +2178,16 @@ static void pci_configure_mps(struct pci_dev *dev)
>>   		return;
>>   	}
>>   
>> +	/*
>> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
>> +	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
>> +	 * strategy, and the MPSS of the devices below the root port, the MPS
>> +	 * of the root port might get overridden later.
>> +	 */
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
>> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);
>> +
>>   	if (!bridge || !pci_is_pcie(bridge))
>>   		return;
>>   
>> -- 
>> 2.25.1
>>


