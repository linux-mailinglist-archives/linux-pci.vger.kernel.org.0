Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62B439DD25
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFGNAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 09:00:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7131 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGNAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 09:00:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzCyj1nQbzYsb8;
        Mon,  7 Jun 2021 20:55:25 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:58:13 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:58:12 +0800
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>,
        John Garry <john.garry@huawei.com>
References: <20210604190430.GA2220179@bjorn-Precision-5520>
From:   Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Date:   Mon, 7 Jun 2021 20:58:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210604190430.GA2220179@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/6/5 3:04, Bjorn Helgaas wrote:
> [+cc John, who tested 6bf6c24720d3]
> 
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
> 
> I'm happy to apply this, but I'm a little puzzled about 6bf6c24720d3
> ("iommu/of: Request ACS from the PCI core when configuring IOMMU
> linkage").  It was tested and fixed a problem, but I don't understand
> how.
> 
> 6bf6c24720d3 added the call to pci_request_acs() in
> of_iommu_configure() so it currently looks like this:
> 
>    of_iommu_configure(dev, ...)
>    {
>      if (dev_is_pci(dev))
>        pci_request_acs();
> 
> pci_request_acs() sets pci_acs_enable, which tells us to enable ACS
> when enumerating PCI devices in the future.  But we only call
> pci_request_acs() if we already *have* a PCI device.
> 
> So maybe 6bf6c24720d3 fixed a problem for *some* PCI devices, but not
> all?  E.g., did we call of_iommu_configure() for one PCI device before
> enumerating the rest?
> 
I test the kernel on an arm platform with qemu:

qemu-system-aarch64 \
  -cpu host \
  -kernel arch/arm64/boot/Image \
  -enable-kvm \
  -m 8G \
  -smp 2,sockets=2,cores=1,threads=1 	\
  -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3\
  -initrd rootfs.cpio.gz \
  -nographic \
  -append "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 nokaslr" \
  -device pcie-root-port,port=0x1,chassis=1,id=pci.1,addr=0x8 \
  -netdev user,id=hostnet0 \
  -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=08:13:3a:5a:22:5b,bus=pci.1,addr=0x0 
\

And find that the of_iommu_configure is called after the enumeration
of the pcie-root-port. And this might only infect the first device, when 
enumerating
the rest devices, the pci_acs_enable has already be enabled.

But to make sure that the pci_acs_enable will always be set before all 
PCI devices,
it would be better to set it in initialization of PCI bridges.

Thanks

Xingang

>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/pci/of.c         | 8 +++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>   			.np = master_np,
>>   		};
>>   
>> -		pci_request_acs();
>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>   					     of_pci_iommu_init, &info);
>>   	} else {
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index da5b414d585a..2313c3f848b0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>   
>>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   {
>> -	if (!dev->of_node)
>> +	struct device_node *node = dev->of_node;
>> +
>> +	if (!node)
>>   		return 0;
>>   
>> +	/* Detect IOMMU and make sure ACS will be enabled */
>> +	if (of_property_read_bool(node, "iommu-map"))
>> +		pci_request_acs();
>> +
>>   	bridge->swizzle_irq = pci_common_swizzle;
>>   	bridge->map_irq = of_irq_parse_and_map_pci;
>>   
>> -- 
>> 2.19.1
>>
> .
> 

.
