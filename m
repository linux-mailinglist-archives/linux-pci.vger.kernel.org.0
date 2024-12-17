Return-Path: <linux-pci+bounces-18663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCC9F54D1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E0C1892CF1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E71F76C4;
	Tue, 17 Dec 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d357qGxB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6D1F76C3
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457232; cv=none; b=cV7+ECNikCyE4J1mK8/l2F+OhKKe/e7N1P6h/qeU+oLM3iHNLNzzb7rptdZBVrMxOElQDsG0PdstKgEN/qi/ctn2AKC1rvpsR5YkwH/fgwn91s45DNSCsCnxG52l0t7bwkaWB+K/4kKQe9pYjFviGuxQoKi4mWEArNuB6boF+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457232; c=relaxed/simple;
	bh=OIKNEe2dG+sZEzI0F9QYMHX2hal6afap3WmtlZRMc7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ode6luSwI08wOBQUQDlSr4xjo4T4X2/eUv5uawUDjbsI1M+lhlhvOj4fE7DBNqbpp4Xm9MG9hbwrgP7KblwN8wqkT2NJdy701GjYSV65K9SyqIu4nzgF/RGw7uLcDyAGeM7zRIa1wVkaSH2mHAfUSBytIkCDqXHjJ6NBCPV8ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d357qGxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C8C4CED3;
	Tue, 17 Dec 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734457231;
	bh=OIKNEe2dG+sZEzI0F9QYMHX2hal6afap3WmtlZRMc7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d357qGxBpbybDlJ6tL3of1u7bV6uXnjy2wTtGfvktloQB7Y4ZuyVkvfG/jdhNil7P
	 Eehbcyh3BQuv9Qfw8DRlzCgMVlDaoNtsPSUniu29OjafuJz+f8fn/yYx78rn/0C4y2
	 LajEsDoD1/bJiGFuD9sIbtNBXftwaI1udp4h26z9A3fpCNpbStI8S86c2xzcjFfU1Y
	 oVFtlpYFAXGDndVZF+PFfKf/szeorqubS+FFikiFtE4AZuybbEoptARJgqYXgwfDBv
	 o0aBA5pXQK5RAlN+IlCaMZ1XnuBTbZ7Ke0sIGhuLmromF9yo93P54ta1uL/ZqWJwlB
	 cJQx6sYHqb9Fw==
Message-ID: <5c8ad404-6121-4aba-ad39-73794bf8532f@kernel.org>
Date: Tue, 17 Dec 2024 09:40:29 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-19-dlemoal@kernel.org>
 <20241217173003.sqz67o24z5co7dck@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217173003.sqz67o24z5co7dck@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 9:30, Manivannan Sadhasivam wrote:
>> +Now, create a subsystem and a port that we will use to create a PCI target
>> +controller when setting up the NVMe PCI endpoint target device. In this
>> +example, the port is created with a maximum of 4 I/O queue pairs::
>> +
>> +        # cd /sys/kernel/config/nvmet/subsystems
>> +        # mkdir nvmepf.0.nqn
>> +        # echo -n "Linux-nvmet-pciep" > nvmepf.0.nqn/attr_model
>> +        # echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
>> +        # echo "0x1b96" > nvmepf.0.nqn/attr_subsys_vendor_id
>> +        # echo 1 > nvmepf.0.nqn/attr_allow_any_host
>> +        # echo 4 > nvmepf.0.nqn/attr_qid_max
>> +
>> +Next, create and enable the subsystem namespace using the null_blk block device::
>> +
>> +        # mkdir nvmepf.0.nqn/namespaces/1
>> +        # echo -n "/dev/nullb0" > nvmepf.0.nqn/namespaces/1/device_path
>> +        # echo 1 > "pci_epf_nvme.0.nqn/namespaces/1/enable"
> 
> I have to do, 'echo 1 > nvmepf.0.nqn/namespaces/1/enable'

Good catch. That is the old name from previous version. Will fix this.

>> +
>> +Finally, create the target port and link it to the subsystem::
>> +
>> +        # cd /sys/kernel/config/nvmet/ports
>> +        # mkdir 1
>> +        # echo -n "pci" > 1/addr_trtype
>> +        # ln -s /sys/kernel/config/nvmet/subsystems/nvmepf.0.nqn \
>> +                /sys/kernel/config/nvmet/ports/1/subsystems/nvmepf.0.nqn
>> +
>> +Creating a NVMe PCI Endpoint Device
>> +-----------------------------------
>> +
>> +With the NVMe target subsystem and port ready for use, the NVMe PCI endpoint
>> +device can now be created and enabled. The NVMe PCI endpoint target driver
>> +should already be loaded (that is done automatically when the port is created)::
>> +
>> +        # ls /sys/kernel/config/pci_ep/functions
>> +        nvmet_pciep
>> +
>> +Next, create function 0::
>> +
>> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pciep
>> +        # mkdir nvmepf.0
>> +        # ls nvmepf.0/
>> +        baseclass_code    msix_interrupts   secondary
>> +        cache_line_size   nvme              subclass_code
>> +        deviceid          primary           subsys_id
>> +        interrupt_pin     progif_code       subsys_vendor_id
>> +        msi_interrupts    revid             vendorid
>> +
>> +Configure the function using any vendor ID and device ID::
>> +
>> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pciep
>> +        # echo 0x1b96 > nvmepf.0/vendorid
>> +        # echo 0xBEEF > nvmepf.0/deviceid
>> +        # echo 32 > nvmepf.0/msix_interrupts
>> +
>> +If the PCI endpoint controller used does not support MSIX, MSI can be
>> +configured instead::
>> +
>> +        # echo 32 > nvmepf.0/msi_interrupts
>> +
>> +Next, let's bind our endpoint device with the target subsystem and port that we
>> +created::
>> +
>> +        # echo 1 > nvmepf.0/portid
> 
> 	'echo 1 > nvmepf.0/nvme/portid'
> 
>> +        # echo "nvmepf.0.nqn" > nvmepf.0/subsysnqn
> 
> 	'echo 1 > nvmepf.0/nvme/subsysnqn'

Yep. Good catch.

> 
>> +
>> +The endpoint function can then be bound to the endpoint controller and the
>> +controller started::
>> +
>> +        # cd /sys/kernel/config/pci_ep
>> +        # ln -s functions/nvmet_pciep/nvmepf.0 controllers/a40000000.pcie-ep/
>> +        # echo 1 > controllers/a40000000.pcie-ep/start
>> +
>> +On the endpoint machine, kernel messages will show information as the NVMe
>> +target device and endpoint device are created and connected.
>> +
> 
> For some reason, I cannot get the function driver working. Getting this warning
> on the ep:
> 
> 	nvmet: connect request for invalid subsystem 1!
> 
> I didn't debug it further. Will do it tomorrow morning and let you know.

Hmmm... Weird. You should not ever see a connect request/command at all.
Can you try this script:

https://github.com/damien-lemoal/buildroot/blob/rock5b_ep_v25/board/radxa/rock5b-ep/overlay/root/pci-ep/nvmet-pciep

Just run "./nvmet-pciep start" after booting the endpoint board.

The command example in the documentation is an extract from what this script
does. I think that:

	echo 1 > ${SUBSYSNQN}/attr_allow_any_host

missing may be the reason for this error.


-- 
Damien Le Moal
Western Digital Research

