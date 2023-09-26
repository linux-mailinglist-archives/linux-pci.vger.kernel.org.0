Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EF7AE987
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjIZJsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjIZJsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 05:48:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02CBE
        for <linux-pci@vger.kernel.org>; Tue, 26 Sep 2023 02:47:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692c70bc440so3667675b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Sep 2023 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1695721675; x=1696326475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKP3MzLWO9YF43zV3hOBWrQ0vFnkikx+qy/eqoZksLU=;
        b=Vblyh2mnu7teGYwlha0L1TZCdy2fZ6gOM/cwZSTZofzOG3EjAzb/sVLkH5pckR2eOW
         9fQyS2e3NWAyUTU0yr5jYkmX/rCaVOsqi6CzeMsbVi7qs5kJb1oaDT3GqLtJqfmncV3V
         SSIMHsds2wd4aDN04B1jyBc5tzaxoOAeTXX0rmGBgyYI7MU2z1454tLWBOzajQZgsx1v
         WLPxcCsAZSkWgwHvSX9GBYtFhiPZ8UqmTqj7Chtx85AV0tf33Ag5GeOuWkpXMvzwhCdk
         4K5Ng2ICahY9ki6SMr8GJ+vuSsdFsuytQopNHOGorYr6HksnEMS5tKa/et5B+xgdV+MN
         RW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695721675; x=1696326475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKP3MzLWO9YF43zV3hOBWrQ0vFnkikx+qy/eqoZksLU=;
        b=tyggUgfodcIQASPuBfpqhbmcKaszC0gw4CUPDtp4ZiLDKySVbXwattn8/61p1ZN1Ew
         nlm3KdD50+X50mFSPIO7uuMHKYBuNbcdyu1rdxvpjU9kc1fabSgOfKKkukfJTvqLldwU
         9XvoR7UkXHnfHYTXfstZPZSiA6uareALptvScwYyjUZK52Y2xhuQGMB7CMxtY7GE4roY
         Ouh6BgHGI9Xa5ELGi9Sg8/uCStPP2+4BPH/8hM4kb8KjA+rfEplcBVmFgQu1eS4BfYdr
         SQt9lXZBxjfAP8uKn3HiiEZ39WKPmYPqCXRy7nMFT5WMmSU82L1AGoSDhIzNAcVzWY2t
         HDpw==
X-Gm-Message-State: AOJu0YwWA6+l02FfwM8UZG21ae6hrkZQITJgW/RDBDi0CH9DkGIbB/3r
        aBnAcl1QDjZYNt5Ww9WHOaEh/g==
X-Google-Smtp-Source: AGHT+IHkkACOh7dgZFFa/QbHIqytll0Y6aTqu1t2IA0bc5L6Z2iD4zYiqDdeRy5IKT8/Mkf7zM31ag==
X-Received: by 2002:a05:6a00:80b:b0:690:d48a:2acc with SMTP id m11-20020a056a00080b00b00690d48a2accmr9641454pfk.29.1695721675490;
        Tue, 26 Sep 2023 02:47:55 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b0068fe9c7b199sm5641837pff.105.2023.09.26.02.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 02:47:55 -0700 (PDT)
Message-ID: <fe309259-01f0-871f-4620-3a4bdc56a186@igel.co.jp>
Date:   Tue, 26 Sep 2023 18:47:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, vaishnav.a@ti.com
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
Content-Language: en-US
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/09/21 18:11, Kishon Vijay Abraham I wrote:
> +Vaishnav
>
> Hi Shunsuke,
>
> On 8/18/2023 7:16 PM, Shunsuke Mie wrote:
>> Hi all,
>>
>> We are proposing to add a new test syste to Linux for PCIe Endpoint. 
>> That
>> can be run on QEMU without real hardware. At present, partially we have
>> confirmed that pci-epf-test is working, but it is not yet complete.
>> However, we would appreciate your comments on the architecture design.
>>
>> # Background
>> The background is as follows.
>>
>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>> framework, but it requires physical boards for testing, and it is 
>> difficult
>> to test sufficiently. In order to find bugs and hardware-dependent
>> implementations early, continuous testing is required. Since it is
>> difficult to automate tests that require hardware, this RFC proposes a
>> virtual environment for testing PCI endpoint function drivers.
>
> This would be quite useful and thank you for attempting it! I would 
> like to compare other mechanisms available in-addition to QEMU before 
> going with the QEMU approach.

I got it. I'll make a table to compare some methods that includes 
greybus to realize this emulation environment.


Best,

Shunsuke

> Though I don't understand this fully, Looking at 
> https://osseu2023.sched.com/event/1OGk8/emulating-devices-in-linux-using-greybus-subsystem-vaishnav-mohandas-achath-texas-instruments, 
> Vaishnav seems to solve the same problem using greybus for multiple 
> type s of devices.
>
> Vaishnav, we'd wait for your OSS presentation but do you have any 
> initial thoughts on how greybus could be used to test PCIe endpoint 
> drivers?
>
> Thanks,
> Kishon
>
>>
>> # Architecture
>> The overview of the architecture is as follows.
>>
>>    Guest 1                        Guest 2
>> +-------------------------+    +----------------------------+
>> | Linux kernel            |    | Linux kernel               |
>> |                         |    |                            |
>> | PCI EP function driver  |    |                            |
>> | (e.g. pci-epf-test)     |    |                            |
>> |-------------------------|    | PCI Device Driver          |
>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>> +-------------------------+    +----------------------------+
>> +-------------------------+    +----------------------------+
>> | QEMU                    |    | QEMU                       |
>> |-------------------------|    |----------------------------|
>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>> +-------------------------+    +----------------------------+
>>
>> At present, it is designed to work guests only on the same host, and
>> communication is done through Unix domain sockets.
>>
>> The three parts shown in the figure were introduced this time.
>>
>> (1) QEMU PCI Endpoint Controller(EPC) Device
>> PCI Endpoint Controller implemented as QEMU PCI device.
>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>> Linux kernel driver that drives the device (1). It registers a epc 
>> device
>> to linux kernel and handling each operations for the epc device.
>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>> configuration space, BAR and memory space to communicate each guests, 
>> and
>> generates interruptions to the guest 1.
>>
>> Each projects are:
>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1 
>> <https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1>
>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc 
>> <https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc>
>> files: drivers/pci/controller/pcie-qemu-ep.c
>>
>> # Protocol
>>
>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>> Transaction. The communicates between the bridge(3) and controller (1)
>> mimic the Transaction. Specifically, a protocol is implemented for
>> exchanging fd for communication protocol version check and 
>> communication,
>> in addition to the interaction equivalent to PCIe Transaction Layer 
>> Packet
>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>> mind, we need to discuss the communication mor.
>>
>> We also are planning to post the patch set after the code is 
>> organized and
>> the protocol discussion is matured.
>>
>> Best regards,
>> Shunsuke
