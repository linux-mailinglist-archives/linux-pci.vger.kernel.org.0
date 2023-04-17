Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F46E3D55
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 04:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDQCLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 22:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 22:11:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4711D
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 19:11:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kx14so4031533pjb.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681697511; x=1684289511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnlRciSQ8X7WWGZSx9hlRKrfeUfAjen+Pljb/Shq8Sc=;
        b=oC4D72dU+xIQQLgJ0rL5uWC1ObsbwOLg7HQAJGC0ZN4mEn16fRnH07IOMu/JQcZHVH
         y7kig+eTtWN4th/cMy+FDkPO/R/DHxM4bC1pRyAsqsot5USVytJI0+sPz4oV7xL+HHnS
         jlqzgzZY35vEtUr3zN8mFUlbzooT83WYdR7EJuHOiirqehiRdGAN9P/bjPdgJk1bEy6e
         sJTh1G5QRUFz+psa1A5teBbZ+u5SjW33X7OWvCOZmj4+UCkqQV2je8TpCtfslDySBjNF
         nAp8+hlqj+NDAmH1pggj2FlIpZybJP/h98QTSZafdhwRrPRTzq+JGuamUvh6DfI6IYaS
         E5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681697511; x=1684289511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnlRciSQ8X7WWGZSx9hlRKrfeUfAjen+Pljb/Shq8Sc=;
        b=k445H+gl2w4SZX4i1THJ6rcJxxf0vhtwTOc1pyWxXw3k31/mbVr/R5uEIyCVOTbsTo
         TPHYZHvL0cpfNVmdSNG6EAcrCaF3MrONLJNdyoVprbYdxrFpK4DJh94eP3ZkvKLyLuiw
         C6XCGOf+42HAYXemOc/bl0xv0qW85kcwRebs9mMJClYS7rsdU+lsBkS2WQq1W9mtJXY3
         VeS4H4akssTenpsSGbRwVUNdlEQsL8NAXUdYI0BKHLVWUOJGl2q9RYGtgnlLQIqChGqn
         B1Q6pS+ixBDhii1zKdK24LDtrPXuU7itjCY6zFjh4UsHh34p4wO+8mWWQR5FN7+EUwQT
         i0nQ==
X-Gm-Message-State: AAQBX9dZcQUMme5r7bodQbd9XkJg3+zHOucZu8cg3aFiUrgEQNJ/cmwt
        CKb6iObbKtVjSIR3aJmdJ+GXCx0kQME+JGswA84=
X-Google-Smtp-Source: AKy350bdaEVaA1sWVsC9V0FCl4r1X6pxb+q8V0/MS/TJCKBus8mKe7bvfysrPGRxWoo4C11vImaaZg==
X-Received: by 2002:a05:6a20:b284:b0:eb:df85:5d7c with SMTP id ei4-20020a056a20b28400b000ebdf855d7cmr12602133pzb.11.1681697511245;
        Sun, 16 Apr 2023 19:11:51 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d14-20020aa78e4e000000b00639eae8816asm6475158pfr.130.2023.04.16.19.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 19:11:50 -0700 (PDT)
Message-ID: <9e9acbf6-3486-56d3-c15a-c3d67557c2a9@igel.co.jp>
Date:   Mon, 17 Apr 2023 11:11:46 +0900
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
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/04/14 23:39, Frank Li wrote:
>
>> -----Original Message-----
>> From: Shunsuke Mie <mie@igel.co.jp>
>> Sent: Friday, April 14, 2023 7:39 AM
>> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Krzysztof Wilczyński <kw@linux.com>; Manivannan Sadhasivam
>> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
>> Jason Wang <jasowang@redhat.com>; Shunsuke Mie <mie@igel.co.jp>;
>> Frank Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; Randy
>> Dunlap <rdunlap@infradead.org>; Ren Zhijie <renzhijie2@huawei.com>;
>> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>> virtualization@lists.linux-foundation.org
>> Subject: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
>>
>> Caution: EXT Email
>>
>> PCIe endpoint framework provides APIs to implement PCIe endpoint
>> function.
>> This framework allows defining various PCIe endpoint function behaviors in
>> software. This patch extend the framework for virtio pci device. The
>> virtio is defined to communicate guest on virtual machine and host side.
>> Advantage of the virtio is the efficiency of data transfer and the conciseness
>> of implementation device using software. It also be applied to PCIe
>> endpoint function.
>>
>> We designed and implemented a PCIe EP virtio console function driver using
>> the extended PCIe endpoint framework for virtio. It can be communicate
>> host and endpoint over virtio as console.
>>
>> An architecture of the function driver is following:
>>
>>   ┌────────────┐         ┌──────────────
>> ────────┬────────────┐
>>   │virtio      │         │                      │virtio      │
>>   │console drv │         ├───────────────┐      │console
>> drv │
>>   ├────────────┤         │(virtio console│      ├─────
>> ───────┤
>>   │ virtio bus │         │ device)       │◄────►│ virtio bus │
>>   ├────────────┤         ├---------------┤      └──────
>> ──────┤
>>   │            │         │ pci ep virtio │                   │
>>   │  pci bus   │         │  console drv  │                   │
>>   │            │  pcie   ├───────────────┤                   │
>>   │            │ ◄─────► │  pci ep Bus   │                   │
>>   └────────────┘         └──────────────
>> ─┴───────────────────┘
>>     PCIe Root              PCIe Endpoint
>>
> [Frank Li] Some basic question,
> I see you call register_virtio_device at epf_vcon_setup_vdev,
> Why call it as virtio console?  I suppose it should be virtiobus directly?

I'm sorry I didn't understand your question. What do you mean the 
virtiobus directly?

>
> Previous you use virtio-net, why change to virtio-console here?  Does it matter?

No, it doesn't. Just I'd like to break down the changes into smaller 
steps to make it easier to review and merge the changes.

As a first step, I propose adding a simplest virtio function driver with 
the extension defined in pci-epf-virtio.{h,c}.

> All virtio-XXX should work?
Yes, the extension is designed to use any type of virtio device.
>
> You removed EDMA support this version?
I planed the support will be added with epf virtio-net patches.
>
>> Introduced driver is `pci ep virtio console drv` in the figure. It works
>> as ep function for PCIe root and virtual virtio console device for PCIe
>> endpoint. Each side of virtio console driver has virtqueue, and
>> introduced driver transfers data on the virtqueue to each other. A data
>> on root tx queue is transfered to endpoint rx queue and vice versa.
>>
>> This patchset is depend follwing patches which are under discussion.
>>
>> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
>> link:
>> https://lore.k/
>> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
>> 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>> %7C%7C&sdata=jYgy%2Bxk84ZXZRVfqm0GCXoRnCTLMrX4zTfV%2Bs5Mmsvo
>> %3D&reserved=0
>> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
>> link:
>> https://lore.k/
>> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cea6513dbf
>> 4084b80ced208db3ce54133%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C638170727558800720%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>> %7C%7C&sdata=K4El76GSAGtsWkNBXJK5%2Fn7flCN20eEMZpZYTX2WIZ0%3
>> D&reserved=0
>>
>> First of this patchset is introduce a helper function to realize pci
>> virtio function using PCIe endpoint framework. The second one is adding
>> a missing definition for virtio pci header. The last one is for PCIe
>> endpoint virtio console driver.
>>
>> This is tested on linux-20230406 and RCar S4 board as PCIe endpoint.
>>
>> Shunsuke Mie (3):
>>    PCI: endpoint: introduce a helper to implement pci ep virtio function
>>    virtio_pci: add a definition of queue flag in ISR
>>    PCI: endpoint: Add EP function driver to provide virtio-console
>>      functionality
>>
>>   drivers/pci/endpoint/functions/Kconfig        |  19 +
>>   drivers/pci/endpoint/functions/Makefile       |   2 +
>>   drivers/pci/endpoint/functions/pci-epf-vcon.c | 554 ++++++++++++++++++
>>   .../pci/endpoint/functions/pci-epf-virtio.c   | 469 +++++++++++++++
>>   .../pci/endpoint/functions/pci-epf-virtio.h   | 123 ++++
>>   include/uapi/linux/virtio_pci.h               |   3 +
>>   6 files changed, 1170 insertions(+)
>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h
>>
>> --
>> 2.25.1
