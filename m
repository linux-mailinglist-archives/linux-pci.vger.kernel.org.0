Return-Path: <linux-pci+bounces-20058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4DA1510B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DC93A98A7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A51FF618;
	Fri, 17 Jan 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAd96aZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD71F957;
	Fri, 17 Jan 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122150; cv=none; b=Tjh6xdMDkd0PES4Sv0HRUgPRbbNK5qLwYFLZgBQTQWUZ8b9G2Eq8xKhpbPT1McWV07IB2jjWkG06a/YsLhZz+VqA0Y35SaU8cnhJLD3njyWEzDZ0HD/jCujcEpsXxHMOw4BzfQ+0izi3/GiW0MivhIIpIE0ZYImByrfa9ZWCp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122150; c=relaxed/simple;
	bh=Xb/EwJx8cYzyfsX97qqfhtH0U5tFSjwQi6dyUInZWhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbHB1mWAihNVLxs1XJ8b9WG0OHzSBV99EjB7JYIMOkj8liBiGkm0wQ22PWicA2fLT22tAQfTmforZTLGWy+NfPV+C8DWzIKj0FgRnk2KpYSFJJcQNyU/SZlAhxYgIjF1q/JWtvsKMy2+I+kD9KkWiJd+PbIVtGhifJui/W28tqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eAd96aZj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=0ysGIoZ4NZ7E9Ad6yIq65d/mO8sayRFgvH4aJQOXIvY=;
	b=eAd96aZjh/8PFTW4LY+TQg/+4potNHJk9CEdpuQjvWpKvo7g3fG7krwvNEozBl
	zYnowN4Tu3aMagKB0aIMI0KFSSje1toTXCx4CMk4/QFS8YClvXetcW2UALn3jhuE
	MlEJAcKDWEinPSGG58nCIBxscBb+WinH/HumvTlo8pNEM=
Received: from [192.168.31.193] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHD_XFYIpnV1bpGQ--.32780S2;
	Fri, 17 Jan 2025 21:53:10 +0800 (CST)
Message-ID: <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com>
Date: Fri, 17 Jan 2025 21:53:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org,
 Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com,
 jiwei.sun.bj@qq.com, sunjw10@outlook.com
References: <20250115134154.9220-1-sjiwei@163.com>
 <20250115134154.9220-3-sjiwei@163.com>
 <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
Content-Language: en-US
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD_XFYIpnV1bpGQ--.32780S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4rAFykZr4Dtw1Dtry8uFg_yoW7Xr48pF
	W5Ga4ayr4DGrWfuF1DWa1xXFyUZ3ZayFW5J34xKrW5ZFy3Aa9YvF1jkF4Sv3WUZr4kZ34Y
	va4ayr48Aa1YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRec_fUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/xtbBDxfXmWeKWeZ3nwAAss



On 1/16/25 22:12, Ilpo Järvinen wrote:
> On Wed, 15 Jan 2025, Jiwei Sun wrote:
> 
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
>> PCIe Link Speed"), the local variable "lnkctl2" is not changed after
>> reading from PCI_EXP_LNKCTL2 in the pcie_failed_link_retrain(). It might
>> cause that the removing 2.5GT/s downstream link speed restriction codes
>> are not executed.
>>
>> Reread the Link Control 2 Register before using.
>>
>> Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>> ---
>>  drivers/pci/quirks.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 76f4df75b08a..02d2e16672a8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -123,6 +123,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>  			return ret;
>>  		}
>>  
>> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>  	}
> 
> I started to wonder if there would be a better way to fix this. If I've 
> understood Maciej's intent correctly, there are two cases when the 2nd 
> step (the one lifting the 2.5GT/s restriction) should be used:
> 
> 1) TLS is 2.5GT/s at the entry to the quirk and it's an ASMedia switch.
> 
> 2) If the quirk lowered TLS to 2.5GT/s and the link became up fine 
> because of that. This also currently checks for ASMedia but in the v1 you 
> also proposed to change that. We know it works in some cases with ASMedia 
> but are unsure what happens with other switches.
> 
> In the case 2, we don't need to check TLS since the function itself asked 
> TLS to be lowered which did not return an error, so we know the speed was 
> lowered so why spend time on rereading the register? A simple local 
> variable could convey the same information.

Uh, maybe my commit messages wasn't clear. My understanding is as
following,

  98 int pcie_failed_link_retrain(struct pci_dev *dev)
  99 {  
			 ...
 111         pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 112         pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 113         if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
 114                 u16 oldlnkctl2 = lnkctl2;
 115         
 116                 pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 117         
 118                 ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 119                 if (ret) {
 120                         pci_info(dev, "retraining failed\n");
 121                         pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
 122                                               true);
 123                         return ret;
 124                 }
 125         
 126                 pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 127         }
 128         
 129         if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
 130             (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
 131             pci_match_id(ids, dev)) {
 132                 u32 lnkcap;
 133         
 134                 pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 135                 pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 136                 ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);


Consider the following scenario:
After the execution of line 111, lnkctl2.tls is 0x3 (Gen 3, such as
for the device ASMedia ASM2824). The function call
pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false) on line 118 returns 0,
and the tls field of the link control 2 register is modified to 0x1 
(corresponding to 2.5GT/s).
﻿
However, within this section of code, lnkctl2 is not modified (after 
reading from register on line 111) at all and remains 0x5. This results 
in the condition on line 130 evaluating to 0 (false), which in turn 
prevents the code from line 132 onward from being executed. The removing
2.5GT/s downstream link speed restriction work can not be done.
﻿
Before the commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed()
to set PCIe Link Speed"), after setting the minimum speed and successfully
completing retraining, an attempt would be made to clear the minimum speed.
IIUC, even for this device ASMedia ASM2824, it is necessary to reread the
link control 2 register after successful retraining on line 118.

> 
> In case 1, I don't think ASMedia check should be removed. It was about a 
> case where FW has a workaround to lower the speed (IIRC). If Link Speed is 
> 2.5GT/s at entry but it's not ASMedia switch, there's no 2.5GT/s 
> restriction to lift.
> 
> 
> As a general comment abouth your test case, I don't think this Target 
> Speed quirk really is compatible with your test case. The quirk makes 
> assumption that the Link Up/Down status changes are because of the changes 
> the quirk made itself but your rapid add/remove test alters the 
> environment, which produces unrelated Link Up/Down status changes that get 
> picked up by the quirk (a false signal).

Yes, it seems that our testing has entered an inappropriate code flow, 
but how to avoid it is a troublesome issue.

Thanks,
Regards,
Jiwei
> 


