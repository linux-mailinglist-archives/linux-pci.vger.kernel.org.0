Return-Path: <linux-pci+bounces-26760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2DA9CB88
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F453AC204
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1BE253359;
	Fri, 25 Apr 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GaGj7k2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC803242D99;
	Fri, 25 Apr 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590736; cv=none; b=jAvAQB6t2uSaLaIhODMWdakTEgpkynwPwSJWndnhvn25GZ3xIbEjOPjqiu3sHTVkaoRc2dLf6PqE7pYeWivxUm/SgkgKRi+TVer3a8ueDkDk0LOfux9Zw3l5s25TjtS6DYeP9VqSL6Niefvimn8qmSxOx+aWztwZmP3kWsbd3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590736; c=relaxed/simple;
	bh=zj8iEYBmgTZCdGRMrPhxZ4jZfaarUGk5o1ezZy1Rm9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn9l5KrHWqjm3vUyLzYKPbFW8oKlV6rjxjzahkspJatCzvVGlmQoHl7QKPE7T3x8BE3CD7DVstZox+YbJxV2Z2siSSjcQDEvu6ZDe015yIAehIT/zWJcEPRQpmzLD1SM/MGjssaEugz3R4FhBE1tTSASCtTrwlJRfmSDwXxS3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GaGj7k2R; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=T5dUauytFt6G0vhlS6nMmP45chnWZOXEMoc/tzxHhIM=;
	b=GaGj7k2R/HA+At4zWfBYbU5M1Nqxcf4OPnU9y/mEnnsYleW6Td0tc+noxG7Ufo
	sBnc+qihnveVY8CAK+jyZEZuemSJ2FBpEeg51ULwZeDMQCMeCAQNKmVpRNpu5Ykv
	DNV/h0xkLAGJLhUGuCBbOQA9oX4vk6QkfTfGIlltPs9Ug=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnn7+UmQtocRMiCQ--.4501S2;
	Fri, 25 Apr 2025 22:17:57 +0800 (CST)
Message-ID: <1904ac4c-832a-4d2c-ab8b-15d3fdf515d0@163.com>
Date: Fri, 25 Apr 2025 22:17:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Configure root port MPS to hardware maximum
 during host probing
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: lpieralisi@kernel.org, kw@linux.com, heiko@sntech.de,
 thomas.petazzoni@bootlin.com, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-2-18255117159@163.com> <aAtikPOYlGeJCsiA@ryzen>
 <a4963173-dd9a-4341-b7f9-5fdb9485233a@163.com> <aAuSXhmRiKQabjLO@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAuSXhmRiKQabjLO@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnn7+UmQtocRMiCQ--.4501S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWDCFy7Xry3ArW8Cw4xCrg_yoWxZF17pr
	WaqF43trWkJFW5ta9rtF1UuFW7twsYvFW3tFsxGr1kta1fuFn3CwsFgry0qw47Cr9YvF1U
	taykJ3y0qF98Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jorWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxg6o2gLk-CiFQAAst



On 2025/4/25 21:47, Niklas Cassel wrote:
> Hello Hans,
> 
> On Fri, Apr 25, 2025 at 06:56:53PM +0800, Hans Zhang wrote:
>>
>> But I discovered a problem:
>>
>> 0001:90:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
>>           ......
>>           Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
>>                   DevCap: MaxPayload 512 bytes, PhantFunc 0
>>                           ExtTag- RBE+
>>                   DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                           RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>                           MaxPayload 512 bytes, MaxReadReq 1024 bytes
>>
>>
>>
>> 			Should the DevCtl MaxPayload be 256B?
>>
>> But I tested that the file reading and writing were normal. Is the display
>> of 512B here what we expected?
>>
>> Root Port 0003:30:00.0 has the same problem. May I ask what your opinion is?
>>
>>
>> 		......
>> 0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
>> NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
>>           ......
>>           Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                   DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
>> unlimited, L1 unlimited
>>                           ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>> SlotPowerLimit 0W
>>                   DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                           RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>> FLReset-
>>                           MaxPayload 256 bytes, MaxReadReq 512 bytes
>> 		......
> 
> Here we see that the bridge has a higher DevCtl.MPS than the DevCap.MPS of
> the endpoint.
> 
> Let me quote Bjorn from the previous mail thread:
> 
> """
>    - I don't think it's safe to set MPS higher in all cases.  If we set
>      the Root Port MPS=256, and an Endpoint only supports MPS=128, the
>      Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
>      that case the RP may respond with a 256-byte payload the Endpoint
>      can't handle.
> """
> 
> 
> 
> I think the problem with this patch is that pcie_write_mps() call in
> pci_host_probe() is done after the pci_scan_root_bus_bridge() call in
> pci_host_probe().
> 
> So pci_configure_mps() (called by pci_configure_device()),
> which does the limiting of the bus to what the endpoint supports,
> is actually called before the pcie_write_mps() call added by this patch
> (which increases DevCtl.MPS for the bridge).
> 
> 
> So I think the code added in this patch needs to be executed before
> pci_configure_device() is done for the EP.
> 
> It appears that pci_configure_device() is called for each device
> during scan, first for the bridges and then for the EPs.
> 
> So I think something like this should work (totally untested):
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -45,6 +45,8 @@ struct pci_domain_busn_res {
>          int domain_nr;
>   };
>   
> +static void pcie_write_mps(struct pci_dev *dev, int mps);
> +
>   static struct resource *get_pci_domain_busn_res(int domain_nr)
>   {
>          struct pci_domain_busn_res *r;
> @@ -2178,6 +2180,11 @@ static void pci_configure_mps(struct pci_dev *dev)
>                  return;
>          }
>   
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
> +               pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +       }
> +
>          if (!bridge || !pci_is_pcie(bridge))
>                  return;
> 
> 
> 
> But we would probably need to move some code to avoid the
> forward declaration.
> 

Dear Niklas,

Thank you very much for your reply and suggestions. The patch you 
provided has been tested by me and is normal.



Bjorn and Mani, thoughts?


Please see the following log:

lspci -vvv
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
                         MaxPayload 256 bytes, MaxReadReq 1024 bytes
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
                         MaxPayload 256 bytes, MaxReadReq 1024 bytes
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

0004:00:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
         ......
         Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 1024 bytes
         ......

0004:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. 
RTL8852BE PCIe 802.11ax Wireless Network Controller
         ......
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<4us, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- 
FLReset-
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
         ......


Best regards,
Hans



