Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CD7882C3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 10:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjHYI5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbjHYI5C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 04:57:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA21BCD
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 01:56:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf0b24d925so6019985ad.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1692953818; x=1693558618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuYpZM6PXIOW+mhZVcLd16VhM2ysqwu49mtAIt5qLW4=;
        b=XJI+RgEwntTJURM5icHrckj7NF7KZ2u9/gATyKSnG6Hxh8S3Akyf7eGFrPzRpAwIWH
         pABtwf2Px48a0WSy4soAL0gEJiGf1ie8FxoD1Zp2QYzZLDgbSd/9OFMqoFxH0yTknBuy
         qkEGF44entkwssrw7dkxPlTeGY/d65Di/G5EjNlwxhYjDQhMx4Kq9Y0Q4PLJARcXYTjN
         yEjy4rKO/0Jh3zgn5iBdBliTWnonBowOWOQQqZklWgrJZ8OFh4QsKT65MBst5p4TUKoj
         o6LiBH7kW5acDNxsB5b+j2krPyKy0UXiZJlDBd5eyYYwoRqOmJ57AMXRzng/g7Qkph0K
         nsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953818; x=1693558618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuYpZM6PXIOW+mhZVcLd16VhM2ysqwu49mtAIt5qLW4=;
        b=drsD+ZfkqEPVGtDqty9QfIcPABYH3Pi5R9GYuTfPHqEAP76mcHo0W3sk4aPq9+UmR7
         NigY62rBagoBNpcCjfLaRsXkSRoOIRbtBxtqBKYkTd0BeyN2//CQvAkeTqRpA4me1Q2M
         JZNXngSfO38Ap5cKo7tmlRCtwCccHc78Z3XCA/qrjnlnbz300lRkkA7J78aj5TN/Evn3
         O/uZrArmT/7pEy3bIRUsJugIQQrG0rjKn/p/MqkqKKOHi9c5Wo+jeCMH0BGAyFUdb3Vl
         YlpASOsex0+M8XOmwJt8AW8stzqtT1zdXL6MVI0XAUfoJ8z+KvBeSDSZvDg/jM0A4cSe
         Df9A==
X-Gm-Message-State: AOJu0Ywckv7P7G4TiOtdbmYJULOFbPp9BOBLk8JajwHQSunuFayPdNPY
        zpRW5zsHEm75Y81YtjA2fLb0xg==
X-Google-Smtp-Source: AGHT+IHYWcfQ7Kb+iZyOzphRNN53Hlx0lIarlId7bFcTsB0jDjAG/jIhpb7lPzAWrM0c65K2Dof5VQ==
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id s8-20020a170902ea0800b001c0a30e2388mr9285190plg.31.1692953818594;
        Fri, 25 Aug 2023 01:56:58 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001bf11cf2e21sm1117064ply.210.2023.08.25.01.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 01:56:58 -0700 (PDT)
Message-ID: <a24e048b-c1a2-78fe-9cd2-a5967e566a73@igel.co.jp>
Date:   Fri, 25 Aug 2023 17:56:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <20230823060923.GA3737@thinkpad>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230823060923.GA3737@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/08/23 15:09, Manivannan Sadhasivam wrote:
> On Fri, Aug 18, 2023 at 10:46:02PM +0900, Shunsuke Mie wrote:
>> Hi all,
>>
>> We are proposing to add a new test syste to Linux for PCIe Endpoint. That
>> can be run on QEMU without real hardware. At present, partially we have
>> confirmed that pci-epf-test is working, but it is not yet complete.
>> However, we would appreciate your comments on the architecture design.
>>
>> # Background
>> The background is as follows.
>>
>> PCI Endpoint function driver is implemented using the PCIe Endpoint
>> framework, but it requires physical boards for testing, and it is difficult
>> to test sufficiently. In order to find bugs and hardware-dependent
>> implementations early, continuous testing is required. Since it is
>> difficult to automate tests that require hardware, this RFC proposes a
>> virtual environment for testing PCI endpoint function drivers.
>>
> This sounds exciting to me and yes, it is going to be really helpful for
> validating EP framework as a whole.
>
>> # Architecture
>> The overview of the architecture is as follows.
>>
>>    Guest 1                        Guest 2
>> +-------------------------+    +----------------------------+
>> | Linux kernel            |    | Linux kernel               |
>> |                         |    |                            |
>> | PCI EP function driver  |    |                            |
>> | (e.g. pci-epf-test)     |    |                            |
>> |-------------------------|    | PCI Device Driver          |
>> | (2) QEMU EPC Driver     |    | (e.g. pci_endpoint_test)   |
>> +-------------------------+    +----------------------------+
>> +-------------------------+    +----------------------------+
>> | QEMU                    |    | QEMU                       |
>> |-------------------------|    |----------------------------|
>> | (1) QEMU PCI EPC Device *----* (3) QEMU EPF Bridge Device |
>> +-------------------------+    +----------------------------+
>>
>> At present, it is designed to work guests only on the same host, and
>> communication is done through Unix domain sockets.
>>
>> The three parts shown in the figure were introduced this time.
>>
>> (1) QEMU PCI Endpoint Controller(EPC) Device
>> PCI Endpoint Controller implemented as QEMU PCI device.
>> (2) QEMU PCI Endpoint Controller(EPC) Driver
>> Linux kernel driver that drives the device (1). It registers a epc device
>> to linux kernel and handling each operations for the epc device.
>> (3) QEMU PCI Endpoint function(EPF) Bridge Device
>> QEMU PCI device that cooperates with (1) and performs accesses to pci
>> configuration space, BAR and memory space to communicate each guests, and
>> generates interruptions to the guest 1.
>>
> I'm not very familiar with Qemu, but why can't the existing Qemu PCIe host
> controller devices used for EP communication? I mean, what is the need for a
> dedicated EPF bridge device (3) in host? (Guest 2 as per your diagram).
>
> Is that because you use socket communication between EP and host?

At least, the part that communicates with (1) is necessary, but I don't 
know if
the current implementation is appropriate. In addition, there is a 
performance
issue, so I am currently investigating QEMU more. e.g. pci emulation, 
shared-memory, etc.

I'd like to improve and submit a next rfc.

Thanks,

Shunsuke Mie

> - Mani
>
>> Each projects are:
>> (1), (3) https://github.com/ShunsukeMie/qemu/tree/epf-bridge/v1
>> files: hw/misc/{qemu-epc.{c,h}, epf-bridge.c}
>> (2) https://github.com/ShunsukeMie/linux-virtio-rdma/tree/qemu-epc
>> files: drivers/pci/controller/pcie-qemu-ep.c
>>
>> # Protocol
>>
>> PCI, PCIe has a layer structure that includes Physical, Data Lane and
>> Transaction. The communicates between the bridge(3) and controller (1)
>> mimic the Transaction. Specifically, a protocol is implemented for
>> exchanging fd for communication protocol version check and communication,
>> in addition to the interaction equivalent to PCIe Transaction Layer Packet
>> (Read and Write of I/O, Memory, Configuration space and Message). In my
>> mind, we need to discuss the communication mor.
>>
>> We also are planning to post the patch set after the code is organized and
>> the protocol discussion is matured.
>>
>> Best regards,
>> Shunsuke
