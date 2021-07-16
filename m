Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630A13CB853
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhGPOCv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 10:02:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15029 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbhGPOCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 10:02:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GRCT7257RzZjxh;
        Fri, 16 Jul 2021 21:56:27 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 21:59:46 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 21:59:45 +0800
Subject: Re: [question]: Query regarding the PCI addresses
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <lijinlin3@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210714165427.GA1854138@bjorn-Precision-5520>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <9809f4d7-cf9e-3672-cb02-4c49c55abada@huawei.com>
Date:   Fri, 16 Jul 2021 21:59:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210714165427.GA1854138@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/7/15 0:54, Bjorn Helgaas wrote:
> [+cc Matthew for "lspci -P"]
>
> On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
>> Since linux identify PCI peripheral by [domain:bus:device:function] number
>> like following,
>>
>> # lspci -D
>> 0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
>> 0000:00:01.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
>> 0000:00:02.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
>> Express Root Port 0 (rev 02)
>> 0000:00:02.1 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
>> Express Root Port 0 (rev 02)
>> 0000:00:02.2 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
>> Express Root Port 0 (rev 02)
>> 0000:00:02.3 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
>> Express Root Port 0 (rev 02)
>> 0000:01:00.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
>> 0000:02:01.0 USB controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
>> USB2 EHCI Controller (rev 10)
>> 0000:02:02.0 Unclassified device [00ff]: Virtio: Virtio memory balloon
>> 0000:02:03.0 SCSI storage controller: Virtio: Virtio SCSI
>> 0000:02:04.0 Display controller: Virtio: Virtio GPU (rev 01)
>> 0000:03:00.0 Ethernet controller: Virtio: Virtio network device (rev 01)
>>
>> Here are my questions: Are these [domain:bus:device:function] number
>> come from hardware's physical connection or allocated by software
>> dynamic?
> The device and function numbers are completely determined by the
> hardware and are not programmable.
>
> Bus numbers are programmable and are determined by the Secondary Bus
> Number of the bridge leading to the device.  These bus numbers are
> generally programmed by the BIOS on x86.  It's possible for Linux to
> reprogram them, but it generally leaves them alone if they are valid.
>
> On x86 with ACPI, the domain number comes from the _SEG method of the
> PNP0A03 device that describes the host bridge.  This may correspond to
> a programmable hardware register, but that isn't visible to the OS and
> Linux has no way to change it.
>
>> If hardware do not change, can we guarantee these number do not
>> change after system reboot?
> For the typical x86 system with ACPI, this is really a question for
> the BIOS.  If the hardware doesn't change, I would *expect* the
> domain/bus/device/function numbers to stay the same, but only BIOS
> folks can answer this definitively.
>
>> If they are not fixed, then is there anyway I can get a fixed ID
>> which can indicate physical connection.
> You can look at the "lspci -P" option.  I'm not really familiar with
> this, but I think Matthew (cc'd) implemented it.
>
> Bjorn
> .

Thanks Bjorn for your great analysis and I would ask BIOS for their 
suggestions.
I think we can put some constraints such as make BIOS give a stable bus
number on our users to meet their needs of finding a stable path,
although this method looks ugly.

Wenchao

