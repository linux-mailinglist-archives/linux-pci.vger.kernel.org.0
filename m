Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D76E5ECD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDRKb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDRKb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 06:31:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A6E42
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 03:31:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b52ad6311so2283069b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681813879; x=1684405879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTXdY5NuBVVPgEbeE3bHL/Qnxc0lVVP6ZRYfwYnz1ac=;
        b=wGWlYWS1etvSoTQUet4lObRX9RWt9eN7hVdv/B0GnhqYqwypMHz2jioeZxu0/wiV6t
         lhZKuhp7IZ8KKVFJO5Ja3u4uRmNoUk0UGqDcG7PJ+6dCJRvv3JC++wsDQZywXygCGg/a
         E/p4k+BU1gIUvsZddckIzwaqZQaJ3V8o1lakTKR6r5tqb5JbiqNQWaOPLZd/O0nSyfsT
         1wydQGBCAOgnyM56ehWnNoXysNPPeyEdENHgmXKoL10sb1jJ74f/ngXMwvsGpCN+uImT
         c0ur12HhIt0U+frEZzjkQ8qaqZhZavMOTiyHruP5cJe/E1EIJLk6EWJd1HEdNf5sk8gS
         hQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813879; x=1684405879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTXdY5NuBVVPgEbeE3bHL/Qnxc0lVVP6ZRYfwYnz1ac=;
        b=OKwyhhYO2mq9y19cc3/6b1YmbBFUrrDk5a62hlNND/2XlYwQVIL6UBXpQRCbjnsdRF
         J9fvgNvcmjlogOYteINCPtvHQvETK0i0buQg6cCvhw5xUKHx0XGcrUkLPRR7cxENeFm3
         BRXkApJ1WpsnOTTh3w6fqWBA05+YmB3k21sKg3HaOL3K4+jAUYYKyq3pnScQc+MeHE2z
         c5lHhhcydVqLStubSb8Xm+jF/11l//UVtYnMntQK/Pe8RjBEYYRxjalFVVLfrMmZSErh
         i1VMn0JQbxdcXXAAmwRrzw88cIURuhLTTEaqeSoRH00mXbEdzhWAiBpknPCXNkomxyvA
         jRJQ==
X-Gm-Message-State: AAQBX9dGeJRz4Y646sZGa2Is/Ym6NGCFpR9lmMuF9UGUEGR5UvEicRuq
        Fm4lptN5lbLPey3DCHqZDQ6ghg==
X-Google-Smtp-Source: AKy350Zi63/seSKnnXtoC1hx5JGZfJDFrYlHZz7PvnC5IGwEnfPHrlVk3AwQkCWZmpadURE4ezzECw==
X-Received: by 2002:a05:6a00:ace:b0:63d:3c9d:2c9 with SMTP id c14-20020a056a000ace00b0063d3c9d02c9mr1425230pfl.3.1681813879315;
        Tue, 18 Apr 2023 03:31:19 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b0062dbafced27sm9092959pfn.27.2023.04.18.03.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:31:18 -0700 (PDT)
Message-ID: <7680d6cd-163d-8648-33da-c3d7d2e2fa3d@igel.co.jp>
Date:   Tue, 18 Apr 2023 19:31:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20230414123903.896914-1-mie@igel.co.jp>
 <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <9e9acbf6-3486-56d3-c15a-c3d67557c2a9@igel.co.jp>
 <AM6PR04MB483893F2A017B54AE29474A9889C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB483893F2A017B54AE29474A9889C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/04/18 0:19, Frank Li wrote:
>
>> -----Original Message-----
>> From: Shunsuke Mie <mie@igel.co.jp>
>> Sent: Sunday, April 16, 2023 9:12 PM
>> To: Frank Li <frank.li@nxp.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Krzysztof Wilczyński <kw@linux.com>; Manivannan Sadhasivam
>> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
>> Jason Wang <jasowang@redhat.com>; Jon Mason <jdmason@kudzu.us>;
>> Randy Dunlap <rdunlap@infradead.org>; Ren Zhijie
>> <renzhijie2@huawei.com>; linux-kernel@vger.kernel.org; linux-
>> pci@vger.kernel.org; virtualization@lists.linux-foundation.org
>> Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
>>
>> Caution: EXT Email
>>
>> On 2023/04/14 23:39, Frank Li wrote:
>>>> -----Original Message-----
>>>> From: Shunsuke Mie <mie@igel.co.jp>
>>>> Sent: Friday, April 14, 2023 7:39 AM
>>>> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> Cc: Krzysztof Wilczyński <kw@linux.com>; Manivannan Sadhasivam
>>>> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
>>>> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
>>>> Jason Wang <jasowang@redhat.com>; Shunsuke Mie <mie@igel.co.jp>;
>>>> Frank Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; Randy
>>>> Dunlap <rdunlap@infradead.org>; Ren Zhijie <renzhijie2@huawei.com>;
>>>> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>>>> virtualization@lists.linux-foundation.org
>>>> Subject: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
>>>>
>>>> Caution: EXT Email
>>>>
>>>> PCIe endpoint framework provides APIs to implement PCIe endpoint
>>>> function.
>>>> This framework allows defining various PCIe endpoint function behaviors
>> in
>>>> software. This patch extend the framework for virtio pci device. The
>>>> virtio is defined to communicate guest on virtual machine and host side.
>>>> Advantage of the virtio is the efficiency of data transfer and the
>> conciseness
>>>> of implementation device using software. It also be applied to PCIe
>>>> endpoint function.
>>>>
>>>> We designed and implemented a PCIe EP virtio console function driver
>> using
>>>> the extended PCIe endpoint framework for virtio. It can be communicate
>>>> host and endpoint over virtio as console.
>>>>
>>>> An architecture of the function driver is following:
>>>>
>>>>    ┌────────────┐         ┌────────────
>> ──
>>>> ────────┬────────────┐
>>>>    │virtio      │         │                      │virtio      │
>>>>    │console drv │         ├───────────────┐      │
>> console
>>>> drv │
>>>>    ├────────────┤         │(virtio console│      ├───
>> ──
>>>> ───────┤
>>>>    │ virtio bus │         │ device)       │◄────►│ virtio bus │
>>>>    ├────────────┤         ├---------------┤      └────
>> ──
>>>> ──────┤
>>>>    │            │         │ pci ep virtio │                   │
>>>>    │  pci bus   │         │  console drv  │                   │
>>>>    │            │  pcie   ├───────────────┤                   │
>>>>    │            │ ◄─────► │  pci ep Bus   │                   │
>>>>    └────────────┘         └────────────
>> ──
>>>> ─┴───────────────────┘
>>>>      PCIe Root              PCIe Endpoint
>>>>
>>> [Frank Li] Some basic question,
>>> I see you call register_virtio_device at epf_vcon_setup_vdev,
>>> Why call it as virtio console?  I suppose it should be virtiobus directly?
>> I'm sorry I didn't understand your question. What do you mean the
>> virtiobus directly?
> I go through your code again.  I think I understand why you need pci-epf-vcon.c.
> Actually,  my means is like virtio_mmio_probe.
>
> vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>
> I am not sure that if VIRTIO_MMIO_VENDOR_ID and VIRTIO_MMIO_DEVICE_ID
> reuse PCI's vendor ID and Device ID.  If yes, you can directly get such information
> from epf.  If no,  a customer field can been added at epf driver.
>
> So you needn't write pci-epf-vcon  and pci-epf-vnet .....
>
> Of cause it will be wonderful if directly use virtio_mmio_probe by dynmatic create platform
> Devices.  It may have some difficult because pci memory map requirement.
I think that some fields are shared between the vdev and epf device.
However, we need to implement device emulation because each virtio device
has its specific set of tasks. For example, the virtio-net device has a
control queue, and the driver can request MAC filters, VLANs, and other
settings via this queue. These requests have to be processed by the virtio
device that we are implementing in pci-epf-vnet.

The simplest virtio-console device doesn’t have these tasks, but the other
virtio devices requireprocessing them.

That's why the current pci-epf-virtio design requires a specific
implementation for each virtio device.

Is this what you meant?

>
>>> Previous you use virtio-net, why change to virtio-console here?  Does it
>> matter?
>>
>> No, it doesn't. Just I'd like to break down the changes into smaller
>> steps to make it easier to review and merge the changes.
>>
>> As a first step, I propose adding a simplest virtio function driver with
>> the extension defined in pci-epf-virtio.{h,c}.
>>
>>> All virtio-XXX should work?
>> Yes, the extension is designed to use any type of virtio device.
>>> You removed EDMA support this version?
>> I planed the support will be added with epf virtio-net patches.
>>>> Introduced driver is `pci ep virtio console drv` in the figure. It works
>>>> as ep function for PCIe root and virtual virtio console device for PCIe
>>>> endpoint. Each side of virtio console driver has virtqueue, and
>>>> introduced driver transfers data on the virtqueue to each other. A data
>>>> on root tx queue is transfered to endpoint rx queue and vice versa.
>>>>
>>>> This patchset is depend follwing patches which are under discussion.
>>>>
>>>> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
>>>> link:
>>>>
>> https://lore.k/
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7Cff59a16f88c643913e3908db3
>> ee91ca8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817294315
>> 3821831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
>> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=hTB
>> 5UDaJoJfta9ohMG%2BrxCVJY34ANn10iSLP9iCHX3M%3D&reserved=0
>>>> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
>> 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>>>> %7C%7C&sdata=jYgy%2Bxk84ZXZRVfqm0GCXoRnCTLMrX4zTfV%2Bs5Mm
>> svo
>>>> %3D&reserved=0
>>>> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
>>>> link:
>>>>
>> https://lore.k/
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7Cff59a16f88c643913e3908db3
>> ee91ca8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63817294315
>> 3821831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
>> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=hTB
>> 5UDaJoJfta9ohMG%2BrxCVJY34ANn10iSLP9iCHX3M%3D&reserved=0
>>>> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
>> 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>>>> %7C%7C&sdata=K4El76GSAGtsWkNBXJK5%2Fn7flCN20eEMZpZYTX2WIZ0
>> %3
>>>> D&reserved=0
>>>>
>>>> First of this patchset is introduce a helper function to realize pci
>>>> virtio function using PCIe endpoint framework. The second one is adding
>>>> a missing definition for virtio pci header. The last one is for PCIe
>>>> endpoint virtio console driver.
>>>>
>>>> This is tested on linux-20230406 and RCar S4 board as PCIe endpoint.
>>>>
>>>> Shunsuke Mie (3):
>>>>     PCI: endpoint: introduce a helper to implement pci ep virtio function
>>>>     virtio_pci: add a definition of queue flag in ISR
>>>>     PCI: endpoint: Add EP function driver to provide virtio-console
>>>>       functionality
>>>>
>>>>    drivers/pci/endpoint/functions/Kconfig        |  19 +
>>>>    drivers/pci/endpoint/functions/Makefile       |   2 +
>>>>    drivers/pci/endpoint/functions/pci-epf-vcon.c | 554
>> ++++++++++++++++++
>>>>    .../pci/endpoint/functions/pci-epf-virtio.c   | 469 +++++++++++++++
>>>>    .../pci/endpoint/functions/pci-epf-virtio.h   | 123 ++++
>>>>    include/uapi/linux/virtio_pci.h               |   3 +
>>>>    6 files changed, 1170 insertions(+)
>>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
>>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
>>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h
>>>>
>>>> --
>>>> 2.25.1
