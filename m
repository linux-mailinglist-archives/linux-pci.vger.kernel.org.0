Return-Path: <linux-pci+bounces-18807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEF9F8314
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570E71885B5C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4A19CD1E;
	Thu, 19 Dec 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="sRnyZtTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB79197552;
	Thu, 19 Dec 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632278; cv=none; b=u/yzGTzidtZ4HeQGlh/BZdVKdtigOLnCBv7lGXFD3AZVBONtEeShDEmvi3siPtI//B+JiYrk5jBl7Cagal9FDooZ4Ns8nUQ1RbEY6BHXGJSbT3ezPa6k1C+7sQLt2EF6S+ngl+TEeGc5M5wa5faF7uAnj/dJjl5+FYlVgR8UQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632278; c=relaxed/simple;
	bh=w2gOgq9BrbviYozCneoZmtMrnoWkRYkW7kxpxoWMWy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLqn7Rsrpr6IPUAiEVjPxhj3qvUcTX2kvG4z45WPPfkVpAN2wxUJBG8asWktmXE/bU43RUIYqukiGLADbB+YRk15mFoVcwCsVr5BIwDKxGmeynn6P4Z1YgC3YoGAjqJPDFHmnDwpVDBaF88M/g/Cr3P1Hc0zqM3sfgepkKFG0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=sRnyZtTe; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4YDf0r4TFfz4H22;
	Thu, 19 Dec 2024 13:17:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734632269; bh=w2gOgq9BrbviYozCneoZmtMrnoWkRYkW7kxpxoWMWy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sRnyZtTebTUeu5YNDJCP/HVMLMNImB8EriwvCl/my9FsFrYy6Prml9niSndpHpPmX
	 vpbSTmiRek6RZPCswFg4+XEInyRFovbF0W2Wbg9B9pO59cJ5WO08qkHSJP7n6CY/SJ
	 fwxbjtrXZQu7t12nXhEYlvl2ciUvw2mBGaztoAl8=
Message-ID: <28fd68e1-f76f-40a9-89a8-a24d693209c1@panix.com>
Date: Thu, 19 Dec 2024 10:17:48 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>, Me <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20241213230214.GA3434438@bhelgaas>
 <ffeae6a38215df37d8c109c16fd8b6713687ba77.camel@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <ffeae6a38215df37d8c109c16fd8b6713687ba77.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I do see that:

----
[E0] 781 /usr/src/ubuntu-kernel> dmesg | fgrep -i aspm
[    0.164233] ACPI FADT declares the system doesn't support PCIe ASPM, 
so disable it
[    0.579946] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.587377] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
using BIOS configuration
[    1.309826] pci 10000:e0:06.0: enable ASPM for pci bridge behind vmd
[    1.622705] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't 
have ASPM control
[110757.878494] pcieport 0000:00:07.0: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[171953.284616] pcieport 0000:00:07.0: ASPM: current common clock 
configuration is inconsistent, reconfiguring
----

On 12/19/24 08:25, David E. Box wrote:
> Hi Kenneth,
> 
> On Fri, 2024-12-13 at 17:02 -0600, Bjorn Helgaas wrote:
>> [cc->to: David, Nirmal]
>>
>> On Fri, Dec 13, 2024 at 02:26:37PM -0800, Kenneth Crudup wrote:
>>> OK, it looks like the effective change (that's not already contained in the
>>> LTR SNOOP patches already in Linus' master (et al.)) comes from this line
>>> from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for
>>> links under VMD domain"):
>>>
>>> ----
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 00143f5fb83a..d2ff44e7fbb1 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state
>>> *link, int blacklist)
>>>          aspm_l1ss_init(link);
>>>
>>>          /* Save default state */
>>> -       link->aspm_default = link->aspm_enabled;
>>> +       link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
>>> +                            ASPM_STATE_ALL : link->aspm_enabled;
>>
>> So I thought the "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)" in
>> f492edb40b54 would effectively do the same thing:
>>
>>>>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/
>>>>>>> lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
>>>>>>
>>>>>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
>>>>>> domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
>>>>>> IDs 0x9a09 and 0xa0b0.
>>>>>>
>>>>>> This looks like it should also be handled by upstream f492edb40b54
>>>>>> ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
>>>>>> "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
>>
>> But I guess it doesn't actually work.  I'm hoping David or Nirmal can
>> figure out why it doesn't because it seems obvious that it's the
>> intent.
> 
> Is PCIe ASPM disabled? In the kernel log do you see:
> 
>      "can't override BIOS ASPM; OS doesn't have ASPM control"
> 
> David
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


