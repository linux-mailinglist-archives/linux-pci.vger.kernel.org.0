Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C967AED06
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjIZMlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjIZMlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 08:41:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A825EB;
        Tue, 26 Sep 2023 05:41:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QCef8S047203;
        Tue, 26 Sep 2023 07:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695732041;
        bh=9v9rGczE3/my015hhEIWMVdENgwZpCtEfNna3/6DrGw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fJFgIat4cGFp8y4f4/QvQPzyco6mC07mSv2D8PTpIlNUuo7teQH41KET9ukCIAR5P
         3L8m+n77d2QnoeHBhvMQIxZHRULqzAy/iMJYBP50hT6m8howpaY2VCcHm6nDDszCwZ
         KyPr4DciJrgueN9BjEZ9ubuIIkMX+9WakHqLcuFg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QCefnf025963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 07:40:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 07:40:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 07:40:41 -0500
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QCeaY9059407;
        Tue, 26 Sep 2023 07:40:37 -0500
Message-ID: <1269bf62-d67f-9f61-0139-dc20d23a9b5e@ti.com>
Date:   Tue, 26 Sep 2023 18:10:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To:     Shunsuke Mie <mie@igel.co.jp>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
 <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
Content-Language: en-US
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon, all,

On 26/09/23 15:17, Shunsuke Mie wrote:
> 
> On 2023/09/21 18:11, Kishon Vijay Abraham I wrote:
>> +Vaishnav
>>
>> Hi Shunsuke,
>>
>> On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
>>> Hi all,
>>>
>>> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
>>> can be run on QEMU without real hardware. At present, partially we have
>>> confirmed that pci-epf-test is working, but it is not yet complete.
>>> However, we would appreciate your comments on the architecture design.
>>>
>>> # Background
>>> The background is as follows.
>>>
>>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>>> framework, but it requires physical boards for testing, and it is difficult
>>> to test sufficiently. In order to find bugs and hardware-dependent
>>> implementations early, continuous testing is required. Since it is
>>> difficult to automate tests that require hardware, this RFC proposes a
>>> virtual environment for testing PCI endpoint function drivers.
>>
>> This would be quite useful and thank you for attempting it! I would like to
>> compare other mechanisms available in-addition to QEMU before going with the
>> QEMU approach.
> 
> I got it. I'll make a table to compare some methods that includes greybus to
> realize this emulation environment.
> 
> 
> Best,
> 
> Shunsuke
> 
>> Though I don't understand this fully, Looking at
>> https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, Vaishnav seems to solve the same problem using greybus for multiple type s of devices.
>>
>> Vaishnav, we'd wait for your OSS presentation but do you have any initial
>> thoughts on how greybus could be used to test PCIe endpoint drivers?
>>

Apologies for the delay, I don't think greybus can be used for PCIe testing as
there is no greybus equivalent for PCIe[1], it can only be used for relatively
simpler devices today, I guess roadtest(UML based)[2] could be an alternative in
this case.

1 -
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/greybus
2 - https://lore.kernel.org/lkml/YjN1ksNGujV611Ka@sirena.org.uk/

Thanks and Regards,
Vaishnav

>> Thanks,
>> Kishon
>>
>>>
>>> # Architecture
>>> The overview of the architecture is as follows.
>>>
>>>    Guest 1                        Guest 2
>>> +-------------------------+    +----------------------------+
>>> | Linux kernel            |    | Linux kernel               |
>>> |                         |    |                            |
>>> | PCI EP function driver  |    |                            |
>>> | (e.g. pci-epf-test)     |    |                            |
>>> |-------------------------|    | PCI Device Driver          |
>>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>>> +-------------------------+    +----------------------------+
>>> +-------------------------+    +----------------------------+
>>> | QEMU                    |    | QEMU                       |
>>> |-------------------------|    |----------------------------|
>>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>>> +-------------------------+    +----------------------------+
>>>
>>> At present, it is designed to work guests only on the same host, and
>>> communication is done through Unix domain sockets.
>>>
>>> The three parts shown in the figure were introduced this time.
>>>
>>> (1) QEMU PCI Endpoint Controller(EPC) Device
>>> PCI Endpoint Controller implemented as QEMU PCI device.
>>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>>> Linux kernel driver that drives the device (1). It registers a epc device
>>> to linux kernel and handling each operations for the epc device.
>>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>>> configuration space, BAR and memory space to communicate each guests, and
>>> generates interruptions to the guest 1.
>>>
>>> Each projects are:
>>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
>>> <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
>>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
>>> <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
>>> files: drivers/pci/controller/pcie-qemu-ep.c
>>>
>>> # Protocol
>>>
>>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>>> Transaction. The communicates between the bridge(3) and controller (1)
>>> mimic the Transaction. Specifically, a protocol is implemented for
>>> exchanging fd for communication protocol version check and communication,
>>> in addition to the interaction equivalent to PCIe Transaction Layer Packet
>>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>>> mind, we need to discuss the communication mor.
>>>
>>> We also are planning to post the patch set after the code is organized and
>>> the protocol discussion is matured.
>>>
>>> Best regards,
>>> Shunsuke
