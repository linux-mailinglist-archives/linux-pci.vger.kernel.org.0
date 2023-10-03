Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203F7B6014
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjJCE4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 00:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjJCE4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 00:56:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195FCA9
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 21:56:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so279633a12.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Oct 2023 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1696308967; x=1696913767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilTkBZZFi3vmBxJRkL+Dl4/IVPKPPr9aHRYw+yB6dQk=;
        b=gS2qR58E1rNoRspxH3DCG81ntoeLCvQT1Bvj6O3ZK5H5K5tFVkyBm7tE/VgfHqt7S1
         41gqW9V460btjZVheUx6N7n8LjF2aWjL4mHEk+nRVG4zKe8+UXW3mP6V9SHFE+FVkmEF
         vqXPjxlUY/gNnzLWO8PkMUkTJJL1LoQBwVD+S3fnkw3omtAKVaKW5LFKz92eTjTCaNi2
         wM0eCZwoSWJdAGE/4F7WoM+ZBGAJMBcoW8kKebmXajAMx5QaYB2yi5MJ9zWG3gWqtMd7
         U62s57mOG/P0ltxn9GgDuMqFyiMvCe878RsitZ6EZJFWlGdtoJdI8TLKCy6B/afWMigG
         dglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308967; x=1696913767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilTkBZZFi3vmBxJRkL+Dl4/IVPKPPr9aHRYw+yB6dQk=;
        b=BH1RxCHB3xfn3lFdkEYaN44SASy0n1fj+KopXWDxey3dajrw5RG16sgr/iWBqb5pU6
         HRh7qZx83JQ2jIrHTiFo+dbOpoQ4t+DMS/pg0QkAn/6Ub8HNSno00Hp8aNwnU/dkJ4eL
         FmT/TagW693ALJitxcWjDYQ3dmlwz42s/LBfmbLhMJm6Ba6bKS11hlwDNkG8HP+eTAC/
         pjGtNRF/FaDaSsAmeI30Xyqb46IAw885ooqPqxkWMDm3hyNPffQYrdFzJ3AWWpNQn7xS
         rRjDFRhJcaBCC+ocqyUFLqqTDpidASS995bYImS2hHAcPeZYk9oWV5RWZWIdiuManlYN
         Av/A==
X-Gm-Message-State: AOJu0YwKSOd6421k9viigIxEoDoqljD0qW5jtrpFBPlPWz9xJ1hR3hP7
        0eZxra2QeE9OV7JDJ/gbB6Y2eg==
X-Google-Smtp-Source: AGHT+IH6NCGNlIKP+rW1/FCMU9Rq5G8uJz4TIGGSpaElLBI7UzyCuW43dLZzcPo2KaHCpJB1fBKpxA==
X-Received: by 2002:a05:6a20:3d87:b0:13f:b028:789c with SMTP id s7-20020a056a203d8700b0013fb028789cmr12882806pzi.5.1696308967409;
        Mon, 02 Oct 2023 21:56:07 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001c631236505sm365110plg.228.2023.10.02.21.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 21:56:07 -0700 (PDT)
Message-ID: <61d82a6b-ab8a-06cc-9514-0baac736f92f@igel.co.jp>
Date:   Tue, 3 Oct 2023 13:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
 <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
 <1269bf62-d67f-9f61-0139-dc20d23a9b5e@ti.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <1269bf62-d67f-9f61-0139-dc20d23a9b5e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vaishnav,

On 2023/09/26 21:40, Vaishnav Achath wrote:
> Hi Kishon, all,
>
> On 26/09/23 15:17, Shunsuke Mie wrote:
>> On 2023/09/21 18:11, Kishon Vijay Abraham I wrote:
>>> +Vaishnav
>>>
>>> Hi Shunsuke,
>>>
>>> On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
>>>> Hi all,
>>>>
>>>> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
>>>> can be run on QEMU without real hardware. At present, partially we have
>>>> confirmed that pci-epf-test is working, but it is not yet complete.
>>>> However, we would appreciate your comments on the architecture design.
>>>>
>>>> # Background
>>>> The background is as follows.
>>>>
>>>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>>>> framework, but it requires physical boards for testing, and it is difficult
>>>> to test sufficiently. In order to find bugs and hardware-dependent
>>>> implementations early, continuous testing is required. Since it is
>>>> difficult to automate tests that require hardware, this RFC proposes a
>>>> virtual environment for testing PCI endpoint function drivers.
>>> This would be quite useful and thank you for attempting it! I would like to
>>> compare other mechanisms available in-addition to QEMU before going with the
>>> QEMU approach.
>> I got it. I'll make a table to compare some methods that includes greybus to
>> realize this emulation environment.
>>
>>
>> Best,
>>
>> Shunsuke
>>
>>> Though I don't understand this fully, Looking at
>>> https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, Vaishnav seems to solve the same problem using greybus for multiple type s of devices.
>>>
>>> Vaishnav, we'd wait for your OSS presentation but do you have any initial
>>> thoughts on how greybus could be used to test PCIe endpoint drivers?
>>>
> Apologies for the delay, I don't think greybus can be used for PCIe testing as
> there is no greybus equivalent for PCIe[1], it can only be used for relatively
> simpler devices today, I guess roadtest(UML based)[2] could be an alternative in
> this case.

Thank you for your comment.

To my understanding, the roadtest uses UML and it interact with hardware 
model written in python to do testing. This would be grate for automated 
testing to test drivers and subsystems.

For this PCIe endpoint, I think we need to hosts, one that works as a 
PCIe endpoint and one that is a PCIe Root Complex to it. Is it possible 
to realize the system?
like:
UML + PCIe endpoint function driver <-> python HW model (PCI Endpoint 
controller) <-> UML + pci driver for the function


As another option, I'm considering the feasibility of dummy PCIe EPC 
driver. It works as a PCIe EPC device in kernel and show pci device 
according to the PCIe endpoint function driver to the same host. so It 
could be realize a single host and test the function driver.


Best,

Shunsuke

> 1 -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/greybus
> 2 - https://lore.kernel.org/lkml/YjN1ksNGujV611Ka@sirena.org.uk/
>
> Thanks and Regards,
> Vaishnav
>
>>> Thanks,
>>> Kishon
>>>
>>>> # Architecture
>>>> The overview of the architecture is as follows.
>>>>
>>>>     Guest 1                        Guest 2
>>>> +-------------------------+    +----------------------------+
>>>> | Linux kernel            |    | Linux kernel               |
>>>> |                         |    |                            |
>>>> | PCI EP function driver  |    |                            |
>>>> | (e.g. pci-epf-test)     |    |                            |
>>>> |-------------------------|    | PCI Device Driver          |
>>>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>>>> +-------------------------+    +----------------------------+
>>>> +-------------------------+    +----------------------------+
>>>> | QEMU                    |    | QEMU                       |
>>>> |-------------------------|    |----------------------------|
>>>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>>>> +-------------------------+    +----------------------------+
>>>>
>>>> At present, it is designed to work guests only on the same host, and
>>>> communication is done through Unix domain sockets.
>>>>
>>>> The three parts shown in the figure were introduced this time.
>>>>
>>>> (1) QEMU PCI Endpoint Controller(EPC) Device
>>>> PCI Endpoint Controller implemented as QEMU PCI device.
>>>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>>>> Linux kernel driver that drives the device (1). It registers a epc device
>>>> to linux kernel and handling each operations for the epc device.
>>>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>>>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>>>> configuration space, BAR and memory space to communicate each guests, and
>>>> generates interruptions to the guest 1.
>>>>
>>>> Each projects are:
>>>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
>>>> <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
>>>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>>>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
>>>> <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
>>>> files: drivers/pci/controller/pcie-qemu-ep.c
>>>>
>>>> # Protocol
>>>>
>>>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>>>> Transaction. The communicates between the bridge(3) and controller (1)
>>>> mimic the Transaction. Specifically, a protocol is implemented for
>>>> exchanging fd for communication protocol version check and communication,
>>>> in addition to the interaction equivalent to PCIe Transaction Layer Packet
>>>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>>>> mind, we need to discuss the communication mor.
>>>>
>>>> We also are planning to post the patch set after the code is organized and
>>>> the protocol discussion is matured.
>>>>
>>>> Best regards,
>>>> Shunsuke
