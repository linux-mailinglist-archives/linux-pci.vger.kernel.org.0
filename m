Return-Path: <linux-pci+bounces-8917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40B90D8D0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13CBB37D78
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88504D8C2;
	Tue, 18 Jun 2024 15:20:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16044CE05;
	Tue, 18 Jun 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724038; cv=none; b=FQFhpkbRBNDOFrqez/FEOrThWKlnU1FJsxzXtPPzcC+FnvPiksVEn+00LQqDMDq1+Fp+SmsMvbh2u+ZzqgLQqrKoyYqa8de08en149kVHln6uUoRHIbgqKLPdVnuFM81G8gopIQLo3/dx3+RdPWChhPcfGZbaoxr7NNrKuboNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724038; c=relaxed/simple;
	bh=n/fRSaMQD1tYH9Xuyl9lD+l+43rICCNzQtg/jdEtL6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cr3BJfP/g/Yrf4OIZWFDKzL5Vp8aCVlTqDXgrkzt6X3dqdSeAeu5vNkT5hkqjC5bX9LGgU2RcrHw/aA//KEDglXmqpux9Hlo4fwpVpVhqeUyZfULhKzXm9WLAeZpJsyxhhuEZByCE55+Ty+GMF2Lw+dU/FRnTqwYrlPIuh2Og64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D84B61E5FE01;
	Tue, 18 Jun 2024 17:19:28 +0200 (CEST)
Message-ID: <fc546ab5-3ffe-4b72-9d3f-f4807ad4858f@molgen.mpg.de>
Date: Tue, 18 Jun 2024 17:19:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240611151102.GA963259@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240611151102.GA963259@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +X86 maintainers]


Dear Bjorn, dear Linux folks,


Am 11.06.24 um 17:11 schrieb Bjorn Helgaas:
> On Mon, Jun 10, 2024 at 10:27:37PM +0200, Paul Menzel wrote:
>> Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
>>> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
>>>> On the servers below Linux warns:
>>>>
>>>>        Unknown NUMA node; performance will be reduced
>>>
>>> This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
>>> NUMA node info"), which appeared in v5.5, so I assume this isn't new.
>>>
>>> That commit log says:
>>>
>>>     In pci_call_probe(), we try to run driver probe functions on the node where
>>>     the device is attached.  If we don't know which node the device is attached
>>>     to, the driver will likely run on the wrong node.  This will still work,
>>>     but performance will not be as good as it could be.
>>>
>>>     On NUMA systems, warn if we don't know which node a PCI host bridge is
>>>     attached to.  This is likely an indication that ACPI didn't supply a _PXM
>>>     method or the DT didn't supply a "numa-node-id" property.
>>>
>>> I assume these are all ACPI systems, so likely missing _PXM.  An
>>> acpidump could confirm this.
>>
>> I created an issue in the Linux Kernel Bugzilla [1] and attached the output
>> of `acpidump` on a Dell PowerEdge T630 there. The DSDT contains:
>>
>>          Device (PCI1)
>>          {
>>          […]
>>              Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
>>              {
>>                  If ((CLOD == 0x00))
>>                  {
>>                      Return (0x01)
>>                  }
>>                  Else
>>                  {
>>                      Return (0x02)
>>                  }
>>              }
>>          […]
>>          }
> 
> This machine (the T630, from your first message) has several PCI host
> bridges:
> 
>    ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
>    pci_bus 0000:ff: root bus resource [bus ff]
> 
>    ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
>    pci_bus 0000:7f: root bus resource [bus 7f]
> 
>    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
>    pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
>    pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
>    pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
>    pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
>    pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>    pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
>    pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
>    pci_bus 0000:00: root bus resource [bus 00-7e]
> 
>    ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
>    pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
>    pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
>    pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
>    pci_bus 0000:80: root bus resource [bus 80-fe]
> 
> PCI0 and PCI1 lead to all your normal PCI devices, they both
> implement _PXM, and they have all the usual apertures for PCI I/O and
> MMIO space where device BARs live.
> 
> UNC0 and UNC1 lead to these special chipset devices, they don't
> implement _PXM, and they don't have any resources except the bus
> number.  The devices on bus 7f and ff can only be used via config
> space accesses, and I have no idea what they are used for.

Maybe the X86 folks now.


Kind regards,

Paul


>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218951

