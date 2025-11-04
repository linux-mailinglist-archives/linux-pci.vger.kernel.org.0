Return-Path: <linux-pci+bounces-40222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87766C32167
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC30B4E43C6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530083D561;
	Tue,  4 Nov 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="am+dmD4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6FD32F775;
	Tue,  4 Nov 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274032; cv=none; b=autHsPjJZRCB+3VVhyZgM9jlZoS5SqfHfRUup0D80cbTr+c23A9vhGiriTtfvz7admRaUeedBWsc+x/xfxw+4cw4+QR/dRGUYhMTSNTanTNpPeq5RotQTctP3q4wlxl7wQYKCislFkltOk/pSyffs4ItWSpbZ+H14VXBZU6kN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274032; c=relaxed/simple;
	bh=pvceWXrh7x65nzJ2dOdCOnduz1aioba1jmBOWxFquQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1tML+qlemP+EtYtYXYD07NudMrfjygmKF3MdqWmjG87nNgGg/UCNJF/FOJWMSC42jN2L5Nchd6Aj+BPdu1qUuvrA/tdgEC0dhMGgQV2G/jWXPNjDtQe/8QNftOCtwoTs5nEN1OHxo1IoUVKVwtifirXOdulRIelnKG52C5+1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=am+dmD4/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=trzVWn3q8K520lsD6h38S6zhjQv/gzjNZVwNLqNGPyU=;
	b=am+dmD4/csrOyZJOXdSv2u8xwXTFEawi+UcC+idUmmLv+AgzSeygvq/5Ck0Xgh
	cpk0VkMOwAHn/1AZXzAmPrfewybsTU9OcfMi7rYJDgiiVc4co3uE0tCrahbMzuus
	vfmKoe+LvaGmNLfPd3ajSOM7Z6a9nv2LO4D227qGg7quM=
Received: from [IPV6:240e:b8f:927e:1000:355:1a70:fad9:bcdf] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3r7uOKgppcpmYBg--.12641S2;
	Wed, 05 Nov 2025 00:32:15 +0800 (CST)
Message-ID: <161d6789-4e7f-456a-91ed-9ef682187eae@163.com>
Date: Wed, 5 Nov 2025 00:32:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250620155507.1022099-2-18255117159@163.com>
 <20250902174828.GA1165373@bhelgaas> <aLlmV8Qiaph1PHFY@ryzen>
 <aQoU-JhWz6IYTpGi@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aQoU-JhWz6IYTpGi@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3r7uOKgppcpmYBg--.12641S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4rGw18Ww48Gw13uw4DJwb_yoW7Gw48pa
	yjqa1vyFn7GryfCrs2va1F9rWUtrZ3AFW5Jr98Jry093Z0vF1Iqr4qyw45Cas7Cr4DArWj
	vrZ8XryxZ3Z5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U46wZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgD7o2kKH03PFAAAsI



On 2025/11/4 23:00, Niklas Cassel wrote:
> Hello Hans,
> 
> Any chance that you have time to re-spin this series?
> 
> I've seen some new DWC based drivers like NXP that also want to
> configure MPS.
> 
> Most likely we know the reason... The PCI core does not change it
> without this series.
> 

Hi Niklas,

I will modify a version based on Bjorn and your opinions and then send 
it out.

Best regards,
Hans

> 
> Kind regards,
> Niklas
> 
> On Thu, Sep 04, 2025 at 12:13:43PM +0200, Niklas Cassel wrote:
>> On Tue, Sep 02, 2025 at 12:48:28PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
>>>> Current PCIe initialization logic may leave root ports operating with
>>>> non-optimal Maximum Payload Size (MPS) settings. While downstream device
>>>> configuration is handled during bus enumeration, root port MPS values
>>>> inherited from firmware or hardware defaults ...
>>>
>>> Apparently Root Port MPS configuration is different from that for
>>> downstream devices?
>>
>> pci_host_probe() will call pci_scan_root_bus_bridge(), which will call
>> pci_scan_single_device(), which will call pci_device_add(), which will
>> call pci_configure_device(), which will call pci_configure_mps().
>>
>> This will be done for both bridges and endpoints.
>>
>> The bridge will be scanned/added first, before devices behind the bridge.
>>
>>
>> While pci_configure_device()/pci_configure_mps() will be called for both
>> bridges and endpoints, pci_configure_mps() will do an early return for
>> devices where pci_upstream_bridge() returns NULL, i.e. for devices where
>> that does not have an upstream bridge, i.e. for the root bridge itself:
>> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2181-L2182
>>
>> So MPS will not be touched for root bridges.
>>
>> This patch ensures that MPS for root bridges gets initialized to MPSS
>> (Max supported MPS).
>>
>> Later, when pci_configure_device()/pci_configure_mps() is called for a
>> device behind the bridge, if the MPSS of the device behind the bridge is
>> smaller than the MPS of the bridge, the code reduces the MPS of the bridge:
>> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2205
>>
>>
>> My only question with this patch is if there is a bridge behind a bridge,
>> will the bridge behind the bridge still have pci_pcie_type() ==
>> PCI_EXP_TYPE_ROOT_PORT ?
>>
>> If so, perhaps we should modify this patch from:
>>
>> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
>> +               pcie_write_mps(dev, 128 << dev->pcie_mpss);
>> +       }
>> +
>>          if (!bridge || !pci_is_pcie(bridge))
>>                  return;
>>
>>
>> to:
>>
>> +       if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
>> +               pcie_write_mps(dev, 128 << dev->pcie_mpss);
>> +       }
>> +
>>          if (!bridge || !pci_is_pcie(bridge))
>>                  return;
>>
>>
>>
>>>> During host controller probing phase, when PCIe bus tuning is enabled,
>>>> the implementation now configures root port MPS settings to their
>>>> hardware-supported maximum values. Specifically, when configuring the MPS
>>>> for a PCIe device, if the device is a root port and the bus tuning is not
>>>> disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
>>>> match the Root Port's maximum supported payload size. The Max Read Request
>>>> Size (MRRS) is subsequently adjusted through existing companion logic to
>>>> maintain compatibility with PCIe specifications.
>>>>
>>>> Note that this initial setting of the root port MPS to the maximum might
>>>> be reduced later during the enumeration of downstream devices if any of
>>>> those devices do not support the maximum MPS of the root port.
>>>>
>>>> Explicit initialization at host probing stage ensures consistent PCIe
>>>> topology configuration before downstream devices perform their own MPS
>>>> negotiations. This proactive approach addresses platform-specific
>>>> requirements where controller drivers depend on properly initialized
>>>> root port settings, while maintaining backward compatibility through
>>>> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
>>>> utilized without altering existing device negotiation behaviors.
>>>
>>> This last paragraph seems kind of like marketing without any real
>>> content.  Is there something important in there?
>>>
>>> Nits:
>>> s/root port/Root Port/
>>>
>>> Reword "implementation now configures" to be clear about whether "now"
>>> refers to before this patch or after.
>>>
>>> Update the MRRS "to maintain compatibility" part.  I'm dubious about
>>> there being a spec compatibility issue with respect to MRRS.  Cite the
>>> relevant section if there is an issue.
>>
>> I'm not sure why the commit message mentions MRRS at all.
>>
>> Sure, pcie_write_mrrs() might set MRRS to MPS, but that is existing logic
>> and not really related to the change in this patch IMO.
>>
>>
>> Kind regards,
>> Niklas


