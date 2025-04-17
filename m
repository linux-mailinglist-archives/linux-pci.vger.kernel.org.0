Return-Path: <linux-pci+bounces-26057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE9A91448
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F65A1432
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763A215061;
	Thu, 17 Apr 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kK5v809E"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D051CAA92;
	Thu, 17 Apr 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872498; cv=none; b=jSPu1OC96BUi06gSDjYpoCvOYabcriB7AGwyB6akk3BzkDiqaPpOo+zD9HjMcylh4Dt1MyGwRyzyAbryETWylsFYH58bnNWSeYCvwjCzRXgGJSj9K5ztPCfHIt0dpLJ+5RwIHgYZjZgGMdUzY11H72ByJXMtrYLu9Jwj9nvBpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872498; c=relaxed/simple;
	bh=ukCcaMdJXQ5rliM6c9NU2hGSoLfFjHJkx8DMketdcSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqyNgzfs69Rk/vanVxtJOtWmd/ExNo2qQndIC0vW2prOFk0lNZkyWE0dvZX7Pangcq8jR6B5dvmGfMAVrJl/2LO/497BxXKCfR6nOzg6jWFaWeY3RMXIgZeTy1ca5FJeMuajWwDXlfxrANvENi4UlQ1ejVworeLQI07+fqcqF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kK5v809E; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=rbiGEnPXfTJBFF8/Jzz38hsNkOYWx3lXorEkxn6cETU=;
	b=kK5v809ETPJ3ci6A09qlTPH3adIYbW9/Wauc6MkwQWvQRd9/IEBmozRHpc54gC
	beR3IZ7QNyYS2A6bsWB9lC2X4ufe5Z1KXmlpjYrAVWcIYRMQBuayV0qNfqbvNePj
	fFU4aG/eE57jAb6wKfZwxdKctJIffsLPv2dTN1P9fNeWM=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn37D7owBo5BmAAg--.29857S2;
	Thu, 17 Apr 2025 14:47:26 +0800 (CST)
Message-ID: <a8cc995e-c6d5-4079-b6d9-765f76a7ec7a@163.com>
Date: Thu, 17 Apr 2025 14:47:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <20250416204051.GA78956@bhelgaas>
 <bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com> <aACZP48pWk5Y62dK@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aACZP48pWk5Y62dK@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBn37D7owBo5BmAAg--.29857S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww15ZrW5WFW5urWkAr4fZrb_yoW3ZF15p3
	4ayF13KrWkJrW7K3Z5tF1DGr1xtr1qyF4UGF45G34rtF1a9r1Dtry29r1Sqa47Wry5JFya
	gw4UJ3yIvw45J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxMyo2gAnhDdWQAAs7



On 2025/4/17 14:01, Niklas Cassel wrote:
> On Thu, Apr 17, 2025 at 10:19:10AM +0800, Hans Zhang wrote:
>> On 2025/4/17 04:40, Bjorn Helgaas wrote:
>>> On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
>>>> The RK3588's PCIe controller defaults to a 128-byte max payload size,
>>>> but its hardware capability actually supports 256 bytes. This results
>>>> in suboptimal performance with devices that support larger payloads.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> index c624b7ebd118..5bbb536a2576 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> @@ -477,6 +477,22 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>>>>    	return IRQ_HANDLED;
>>>>    }
>>>> +static void rockchip_pcie_set_max_payload(struct rockchip_pcie *rockchip)
>>>> +{
>>>> +	struct dw_pcie *pci = &rockchip->pci;
>>>> +	u32 dev_cap, dev_ctrl;
>>>> +	u16 offset;
>>>> +
>>>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>> +	dev_cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCAP);
>>>> +	dev_cap &= PCI_EXP_DEVCAP_PAYLOAD;
>>>> +
>>>> +	dev_ctrl = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>>>> +	dev_ctrl &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>> +	dev_ctrl |= dev_cap << 5;
>>>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, dev_ctrl);
>>>> +}
>>>
>>> I can't really complain too much about this since meson does basically
>>> the same thing, but there are some things I don't like about this:
>>>
>>>     - I don't think it's safe to set MPS higher in all cases.  If we set
>>>       the Root Port MPS=256, and an Endpoint only supports MPS=128, the
>>>       Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
>>>       that case the RP may respond with a 256-byte payload the Endpoint
>>>       can't handle.  The generic code in pci_configure_mps() might be
>>>       smart enough to avoid that situation, but I'm not confident about
>>>       it.  Maybe I could be convinced.
>>>
>>
>> Dear Bjorn,
>>
>> Thank you very much for your reply. If we set the Root Port MPS=256, and an
>> Endpoint only supports MPS=128. Finally, Root Port is also set to MPS=128 in
>> pci_configure_mps.
> 
> In you example below, the Endpoint has:
>   DevCap: MaxPayload 512 bytes
> 
> So at least your example can't be used to prove this specific point.
> But perhaps you just wanted to show that your Max Payload Size increase
> actually works?
> 

Dear Niklas,

Do you have an Endpoint with MPS=128? If so, you can also help verify 
the logic of the pci_configure_mps function. I don't have an Endpoint 
with MPS=128 here.


The processing logic of the pci_configure_mps function has been verified 
on our own SOC platform. Please refer to the following log.
Our Root Port will set MPS=512.


0002:30:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 167
         Bus: primary=30, secondary=31, subordinate=5f, sec-latency=0
         I/O behind bridge: 300000-300fff [size=4K] [16-bit]
         Memory behind bridge: 38300000-383fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled] [64-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         Expansion ROM at 38200000 [virtual] [disabled] [size=1M]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [80] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [90] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                 Address: 000000000e060040  Data: 0000
                 Masking: fffffffe  Pending: 00000000
         Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
                 Vector table: BAR=0 offset=00000040
                 PBA: BAR=0 offset=00000040
         Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 1024 bytes


0002:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8125 2.5GbE Controller (rev 05)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE 
Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 166
         Region 0: I/O ports at 300000 [size=256]
         Region 2: Memory at 38300000 (64-bit, non-prefetchable) [size=64K]
         Region 4: Memory at 38310000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 01
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 2048 bytes


hans@hans:~$ iperf3 -s
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from ethernet_ip, port 47114
[  5] local ubuntu_host_ip port 5201 connected to ethernet_ip port 47122
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   108 MBytes   902 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec
[  5]   3.00-4.00   sec   112 MBytes   941 Mbits/sec
[  5]   4.00-5.00   sec   112 MBytes   941 Mbits/sec
[  5]   5.00-6.00   sec   112 MBytes   941 Mbits/sec
[  5]   6.00-7.00   sec   112 MBytes   941 Mbits/sec
[  5]   7.00-8.00   sec   112 MBytes   941 Mbits/sec
[  5]   8.00-9.00   sec   112 MBytes   941 Mbits/sec
[  5]   9.00-10.00  sec   112 MBytes   941 Mbits/sec
[  5]  10.00-10.04  sec  4.92 MBytes   941 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.04  sec  1.10 GBytes   938 Mbits/sec 
receiver
-----------------------------------------------------------


root@cix-localhost:~# iperf3 -c ubuntu_host_ip
Connecting to host ubuntu_host_ip, port 5201
[  5] local ethernet_ip port 47122 connected to ubuntu_host_ip port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   114 MBytes   958 Mbits/sec    0    484 KBytes
[  5]   1.00-2.00   sec   113 MBytes   946 Mbits/sec    0    535 KBytes
[  5]   2.00-3.00   sec   112 MBytes   936 Mbits/sec    0    559 KBytes
[  5]   3.00-4.00   sec   113 MBytes   946 Mbits/sec    0    587 KBytes
[  5]   4.00-5.00   sec   112 MBytes   939 Mbits/sec    0    587 KBytes
[  5]   5.00-6.00   sec   113 MBytes   948 Mbits/sec    0    587 KBytes
[  5]   6.00-7.00   sec   112 MBytes   936 Mbits/sec    0    587 KBytes
[  5]   7.00-8.00   sec   112 MBytes   939 Mbits/sec    0    587 KBytes
[  5]   8.00-9.00   sec   112 MBytes   942 Mbits/sec    0    619 KBytes
[  5]   9.00-10.00  sec   113 MBytes   945 Mbits/sec    0    677 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.10 GBytes   944 Mbits/sec    0             sender
[  5]   0.00-10.04  sec  1.10 GBytes   938 Mbits/sec 
receiver

Best regards,
Hans


