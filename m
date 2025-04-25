Return-Path: <linux-pci+bounces-26746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC9A9C670
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF593B2882
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7E22F3BE;
	Fri, 25 Apr 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QK67PW4F"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA54438B;
	Fri, 25 Apr 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578661; cv=none; b=Wn5+ZwbDRwB14liFLz8K7bCoiPn+bweokSB0/hsLjXuw6spDkgR7x86QbIDz4ddWy6x8mjM0r56p9UrOQ6oejkAKBrTLTsWXjUJ4a5Gp/AZJk3uuOjMZO03j2oIF5K47euQxajGtYbRISgXxg+2n7zzekb5n8PhsSbRJFSjX1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578661; c=relaxed/simple;
	bh=78RWYMFDC6mWs3yvvBcOidNI0oUxCEx1K0w0K1PKkNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUt68u++QwXAGK28xwrdO3+Hi8G34UjJoSC7H9RzURlW/uoRRfylGA8oW12zDJXw+qZxdhrL5bGIit84Bh3DiKMKxtvCuu6QgZZZQBI3TpWa7l6o3iQKtaRQlQXpxc/sa7FFsMrtR2eqzp9Q7d0Jw4hbPlhszpZkLpLakrndv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QK67PW4F; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=nli07KgLUrDYMWH1Lc6yMKqrWlicadkP3LHn0B363Ng=;
	b=QK67PW4FjfSzrmfyXNv5GmvlkVPoZEf2davAV77hrwJvc+qVVB1LzVsDPWl8vz
	p6/EwY+XU+RSGhim+vaB3ppkMRytTNQrWT/BipxTXBhDRmekRXwrvClHv5dDlPaU
	SI21SaaGPJ2Ule5IuvpoUNSfCKl4KLveY51UECCuqwoL0=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCH5yx1agto6+qPCQ--.28259S2;
	Fri, 25 Apr 2025 18:56:55 +0800 (CST)
Message-ID: <a4963173-dd9a-4341-b7f9-5fdb9485233a@163.com>
Date: Fri, 25 Apr 2025 18:56:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Configure root port MPS to hardware maximum
 during host probing
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-2-18255117159@163.com> <aAtikPOYlGeJCsiA@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAtikPOYlGeJCsiA@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCH5yx1agto6+qPCQ--.28259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFy8Jw4fXr47ury3ZFyrZwb_yoW3Xw17pF
	W2qF42yF4kJF43Ka97tF18uFWjq3ZY9FW3JFsxJr1qv3Z3u3Z5C3sFkFyFq3y7Jr9Yvr1U
	taykJ340vFs8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzmhwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDws6o2gLX6dyxAABsx



On 2025/4/25 18:23, Niklas Cassel wrote:
> On Fri, Apr 25, 2025 at 05:57:07PM +0800, Hans Zhang wrote:
>> Current PCIe initialization logic may leave root ports operating with
>> non-optimal Maximum Payload Size (MPS) settings. While downstream device
>> configuration is handled during bus enumeration, root port MPS values
>> inherited from firmware or hardware defaults might not utilize the full
>> capabilities supported by the controller hardware. This can result in
>> suboptimal data transfer efficiency across the PCIe hierarchy.
>>
>> During host controller probing phase, when PCIe bus tuning is enabled,
>> the implementation now configures root port MPS settings to their
>> hardware-supported maximum values. By iterating through bridge devices
>> under the root bus and identifying PCIe root ports, each port's MPS is set
>> to 128 << pcie_mpss to match the device's maximum supported payload size.
>> The Max Read Request Size (MRRS) is subsequently adjusted through existing
>> companion logic to maintain compatibility with PCIe specifications.
>>
>> Explicit initialization at host probing stage ensures consistent PCIe
>> topology configuration before downstream devices perform their own MPS
>> negotiations. This proactive approach addresses platform-specific
>> requirements where controller drivers depend on properly initialized root
>> port settings, while maintaining backward compatibility through
>> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
>> utilized without altering existing device negotiation behaviors.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Perhaps Mani deserves a Suggested-by tag?
> 

Dear Niklas,

Thank you very much for your reply. Ok. Sorry, I missed it. I 'm going 
to add Suggested-by tag.

> 
>> ---
>>   drivers/pci/probe.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 364fa2a514f8..3973c593fdcf 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3206,6 +3206,7 @@ EXPORT_SYMBOL_GPL(pci_create_root_bus);
>>   int pci_host_probe(struct pci_host_bridge *bridge)
>>   {
>>   	struct pci_bus *bus, *child;
>> +	struct pci_dev *dev;
>>   	int ret;
>>   
>>   	pci_lock_rescan_remove();
>> @@ -3228,6 +3229,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>   	 */
>>   	pci_assign_unassigned_root_bus_resources(bus);
>>   
>> +	if (pcie_bus_config != PCIE_BUS_TUNE_OFF) {
>> +		/* Configure root ports MPS to be MPSS by default */
>> +		for_each_pci_bridge(dev, bus) {
>> +			if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
>> +				continue;
>> +
>> +			pcie_write_mps(dev, 128 << dev->pcie_mpss);
>> +			pcie_write_mrrs(dev);
> 
> The comment says configure MPS, but the code also calls pcie_write_mrrs().
> 
> Should we update the comment or should we remove the call to pcie_write_mrrs()?
> 

I have tested and found that the result is the same whether 
pcie_write_mrrs() is called or not.

> Note that even when calling pcie_write_mrrs(), it will not update MRRS for the
> common case (pcie_bus_config == PCIE_BUS_DEFAULT).

But I discovered a problem:

0001:90:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
          ......
          Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                  DevCap: MaxPayload 512 bytes, PhantFunc 0
                          ExtTag- RBE+
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 512 bytes, MaxReadReq 1024 bytes



			Should the DevCtl MaxPayload be 256B?

But I tested that the file reading and writing were normal. Is the 
display of 512B here what we expected?

Root Port 0003:30:00.0 has the same problem. May I ask what your opinion is?


		......
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
          ......
          Capabilities: [70] Express (v2) Endpoint, MSI 00
                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
FLReset-
                          MaxPayload 256 bytes, MaxReadReq 512 bytes
		......





Several PCIe ports that I enabled.

root@cix-localhost:~# cat /proc/version
Linux version 6.15.0-rc2-00015-gced1536aaf04-dirty (hans@hans) ......
root@cix-localhost:~# lspci
0000:c0:00.0 PCI bridge: Device 1f6c:0001
0000:c1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller S4LV008[Pascal]
0001:90:00.0 PCI bridge: Device 1f6c:0001
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM9A1/PM9A3/980PRO
0003:30:00.0 PCI bridge: Device 1f6c:0001
0003:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8125 2.5GbE Controller (rev 05)root@cix-localhost:~# lspci -vvv
0000:c0:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
          ......
          Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                  DevCap: MaxPayload 512 bytes, PhantFunc 0
                          ExtTag+ RBE+
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0000:c1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
          ......
          Capabilities: [70] Express (v2) Endpoint, MSI 00
                  DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
FLReset-
                          MaxPayload 512 bytes, MaxReadReq 512 bytes
		......
0001:90:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
          ......
          Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                  DevCap: MaxPayload 512 bytes, PhantFunc 0
                          ExtTag- RBE+
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
          ......
          Capabilities: [70] Express (v2) Endpoint, MSI 00
                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
FLReset-
                          MaxPayload 256 bytes, MaxReadReq 512 bytes
		......
0003:30:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
          ......
          Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                  DevCap: MaxPayload 512 bytes, PhantFunc 0
                          ExtTag- RBE+
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0003:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8125 2.5GbE Controller (rev 05)
          ......
          Capabilities: [70] Express (v2) Endpoint, MSI 01
                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                          MaxPayload 256 bytes, MaxReadReq 4096 bytes
          ......

Best regards,
Hans


