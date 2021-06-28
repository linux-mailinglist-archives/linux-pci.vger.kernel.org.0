Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE823B5ECD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhF1NXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 09:23:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13028 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhF1NXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 09:23:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GD7Sf0NGFzZhp4;
        Mon, 28 Jun 2021 21:17:38 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 21:20:42 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 21:20:42 +0800
From:   Xingang Wang <wangxingang5@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Auger Eric <eric.auger@redhat.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>
References: <20210604190430.GA2220179@bjorn-Precision-5520>
 <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com>
Date:   Mon, 28 Jun 2021 21:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I would like to add more explanation about what problem this patch
fixed.

I am testing the SVA/vSVA series patches written by @Jean and @Brucker.
I test with the following qemu command line, with a hisilicon SEC device
attached on a pcie-root-port.

$QEMU/qemu-system-aarch64 \
     -enable-kvm \
     -kernel $LINUX/arch/arm64/boot/Image \
     -m 16G \
     -smp cores=8,threads=1,sockets=2 	\
     -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3 \
     -device 
pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,addr=0x1 \
     -device vfio-pci,host=75:00.0,bus=pci.1,addr=0x0,id=acc2 \
     -net none \
     -initrd ./mfs.cpio.gz \
     -cpu host \
     -nographic \
     -append "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000" \

And I got the guest PCI configuration:
00:00.0 Class 0600: Device 1b36:0008 		# root bus
00:01.0 Class 0604: Device 1b36:000c 		# root port
	Capabilities: [148 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport
01:00.0 Class 1000: Device 19e5:a255 (rev 21) 	# SEC

The PCI configuration shows that the ACS of the pcie root port is
not enabled, while it should have.

Then when I insmod device driver and init the SVA feature, I got

[   24.342450] hisi_sec2 0000:01:00.0: cannot attach to incompatible 
domain (0 SSID bits != 10)
[   24.343731] hisi_sec2 0000:01:00.0: Failed to add to iommu group 0: -22
[   24.345243] hisi_sec2 0000:01:00.0: enabling device (0000 -> 0002)
qemu-system-aarch64: vfio_enable_vectors failed to register S1 MSI 
binding for vector 0(-2)
qemu-system-aarch64: vfio: Error: Failed to setup MSI fds: Interrupted 
system call
qemu-system-aarch64: vfio: Error: Failed to enable MSI

I figured out that this error occurs in the arm_smmu_attach_dev
when checking ssid_bits for SVA feature,
the master->ssid_bits != smmu_domain->s1_cfg.s1cdmax caused this 
problem. This is becuase the ACS of pcie-root-port is not enabled, the 
pcie-root-port and SEC device share the same domain.
And SEC's ssid_bits is 10, while pcie-root-port's s1cdmax is zero, this 
cause the problem.

And about why the ACS is not enabled in kernel, I have explained as the 
following:

On 2021/6/7 20:58, Xingang Wang wrote:
> On 2021/6/5 3:04, Bjorn Helgaas wrote:
>> [+cc John, who tested 6bf6c24720d3]
>>
>> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
>>> From: Xingang Wang <wangxingang5@huawei.com>
>>>
>>> When booting with devicetree, the pci_request_acs() is called after the
>>> enumeration and initialization of PCI devices, thus the ACS is not
>>> enabled. And ACS should be enabled when IOMMU is detected for the
>>> PCI host bridge, so add check for IOMMU before probe of PCI host and 
>>> call
>>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>>> devices.
>>
>> I'm happy to apply this, but I'm a little puzzled about 6bf6c24720d3
>> ("iommu/of: Request ACS from the PCI core when configuring IOMMU
>> linkage").  It was tested and fixed a problem, but I don't understand
>> how.
>>
>> 6bf6c24720d3 added the call to pci_request_acs() in
>> of_iommu_configure() so it currently looks like this:
>>
>>    of_iommu_configure(dev, ...)
>>    {
>>      if (dev_is_pci(dev))
>>        pci_request_acs();
>>
>> pci_request_acs() sets pci_acs_enable, which tells us to enable ACS
>> when enumerating PCI devices in the future.  But we only call
>> pci_request_acs() if we already *have* a PCI device.
>>
>> So maybe 6bf6c24720d3 fixed a problem for *some* PCI devices, but not
>> all?  E.g., did we call of_iommu_configure() for one PCI device before
>> enumerating the rest?
>>
> I test the kernel on an arm platform with qemu:
> 
> qemu-system-aarch64 \
>   -cpu host \
>   -kernel arch/arm64/boot/Image \
>   -enable-kvm \
>   -m 8G \
>   -smp 2,sockets=2,cores=1,threads=1     \
>   -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3\
>   -initrd rootfs.cpio.gz \
>   -nographic \
>   -append "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 nokaslr" \
>   -device pcie-root-port,port=0x1,chassis=1,id=pci.1,addr=0x8 \
>   -netdev user,id=hostnet0 \
>   -device 
> virtio-net-pci,netdev=hostnet0,id=net0,mac=08:13:3a:5a:22:5b,bus=pci.1,addr=0x0 
> \
> 
> And find that the of_iommu_configure is called after the enumeration
> of the pcie-root-port. And this might only infect the first device, when 
> enumerating
> the rest devices, the pci_acs_enable has already be enabled.
> 
> But to make sure that the pci_acs_enable will always be set before all 
> PCI devices,
> it would be better to set it in initialization of PCI bridges.
> 
> Thanks
> 
> Xingang
> 
>>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>>> configuring IOMMU linkage")
>>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>>> ---
>>>   drivers/iommu/of_iommu.c | 1 -
>>>   drivers/pci/of.c         | 8 +++++++-
>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index a9d2df001149..54a14da242cc 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct 
>>> device *dev,
>>>               .np = master_np,
>>>           };
>>> -        pci_request_acs();
>>>           err = pci_for_each_dma_alias(to_pci_dev(dev),
>>>                            of_pci_iommu_init, &info);
>>>       } else {
>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>> index da5b414d585a..2313c3f848b0 100644
>>> --- a/drivers/pci/of.c
>>> +++ b/drivers/pci/of.c
>>> @@ -581,9 +581,15 @@ static int 
>>> pci_parse_request_of_pci_ranges(struct device *dev,
>>>   int devm_of_pci_bridge_init(struct device *dev, struct 
>>> pci_host_bridge *bridge)
>>>   {
>>> -    if (!dev->of_node)
>>> +    struct device_node *node = dev->of_node;
>>> +
>>> +    if (!node)
>>>           return 0;
>>> +    /* Detect IOMMU and make sure ACS will be enabled */
>>> +    if (of_property_read_bool(node, "iommu-map"))
>>> +        pci_request_acs();
>>> +
>>>       bridge->swizzle_irq = pci_common_swizzle;
>>>       bridge->map_irq = of_irq_parse_and_map_pci;
>>> -- 
>>> 2.19.1
>>>
>> .
>>
> 
> .
