Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED8717D66
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEaKvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjEaKvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 06:51:49 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC07126
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 03:51:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so22231155ab.2
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685530306; x=1688122306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL+MUAGjHXCcVBhRxcCYXFGT+AfAFBLYOnPjKg/aVcI=;
        b=Eh+I0hgvt7vbsksAnBxrKvE4+kAg82/jq/WqMTCfwpB6OOhlxkMjQmpKkQLwUDz0jj
         VF8wShWQF/m5XJ+GeyDOCwaB8QRsPnjqRIjLXh/s5NqQk6uTUJ/6vYQkkC9CrUZX5jZ4
         TJIBITvLjFM+I57GTztJJ58kFDtAUmnlG5+KQbgXDoX/CZ2+oDs8LUVi9O9aVsU8p0Zq
         H/ZXbcAjkfyWpoOVydazKLtDVtY7wWbXmHyeG5rNo4wvfk8Ea5/Z/MTu9z6H30hYA/0N
         4E8r9KZF+N/Jigi0LROJvNcqN8CXNZQWaPW1aoQEJbSR1I5djVOz94pyaOZ/mCDY4nDK
         JWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685530306; x=1688122306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OL+MUAGjHXCcVBhRxcCYXFGT+AfAFBLYOnPjKg/aVcI=;
        b=UQXrDgM/ieFq4xKbwuDr7HyBpaIMF8wzcnaA2bLj+KAnsdYXZ/dJ5k4VtJUVY7n3pa
         UA9z5ycsfguo4Hwr1dDc7N9fdAiqAg0NUq9MwZ19JvGWDyByW/OrR7b8moWxbiABx4dp
         uEGWAuurFI7IViOQx8k61CI7ja2l8YBT5681SktWZqUcrFCyb2M0zwe4aZexJbIVu20o
         D26hjPaiUWTyJ+ynh0c0DkTDPN1yx32Cc4edodnrpXieAME02HQAkX0rrK8NzgzqI3hK
         ZSTAwxH5Tq0/Hmc/ityN2O/RycaoggsKlYlFtrYnedvRyz+tQB/hRWHvMGORGaKFNywR
         7QCQ==
X-Gm-Message-State: AC+VfDzPObM/AnxreMSKzen0edH5zTxLYto6ulLGWAP9u8MlXXrtrZoo
        FycQGzt+i8Bng5qnDckpOP2GVw==
X-Google-Smtp-Source: ACHHUZ5wTHf6brPVTM9Pu10tfLM6QoR8MR+RK/fU0uvSnUIafDy/ueDylPxOs/iblYKzccIBhVU3DA==
X-Received: by 2002:a92:c144:0:b0:33a:f1b2:eb6c with SMTP id b4-20020a92c144000000b0033af1b2eb6cmr2344646ilh.3.1685530306356;
        Wed, 31 May 2023 03:51:46 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b001b045c9abd2sm1041969plb.143.2023.05.31.03.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 03:51:45 -0700 (PDT)
Message-ID: <2422273d-5ac2-63ef-8a31-230ebfbe3b23@igel.co.jp>
Date:   Wed, 31 May 2023 19:51:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To:     Jason Wang <jasowang@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
 <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
 <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
 <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Content-Language: en-US
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm sorry for late response.

On 2023/05/19 11:01, Jason Wang wrote:
> On Thu, May 18, 2023 at 5:54 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>> Gentle ping ...
>>
>>
>> Thanks,
>>
>> Shunsuke.
>>
>> On 2023/05/10 12:17, Shunsuke Mie wrote:
>>> Hi Json,
>>> 2023年5月8日(月) 13:03 Jason Wang <jasowang@redhat.com>:
>>>> On Thu, Apr 27, 2023 at 6:44 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>>>>> Add a new PCIe endpoint function driver that works as a pci virtio-console
>>>>> device. The console connect to endpoint side console. It enables to
>>>>> communicate PCIe host and endpoint.
>>>>>
>>>>> Architecture is following:
>>>>>
>>>>>    ┌────────────┐         ┌──────────────────────┬────────────┐
>>>>>    │virtioe     │         │                      │virtio      │
>>>>>    │console drv │         ├───────────────┐      │console drv │
>>>>>    ├────────────┤         │(virtio console│      ├────────────┤
>>>>>    │ virtio bus │         │ device)       │◄────►│ virtio bus │
>>>>>    ├────────────┤         ├---------------┤      └────────────┤
>>>>>    │            │         │ pci ep virtio │                   │
>>>>>    │  pci bus   │         │  console drv  │                   │
>>>>>    │            │  pcie   ├───────────────┤                   │
>>>>>    │            │ ◄─────► │  pci ep Bus   │                   │
>>>>>    └────────────┘         └───────────────┴───────────────────┘
>>>>>      PCIe Root              PCIe Endpoint
>>>>>
>>>> I think it might only works for peer devices like:
>>>>
>>>> net, console or vsock.
>>> Could you tell me what "peer devices" means?
> I meant, for example we know in the case of virtio-net, TX can talk
> with RX belonging to another device directly.
>
> But this is not the case for other devices like virito-blk.
Thank you. I comprehended it.
>>>> So there're many choices here, I'd like to know what's the reason for
>>>> you to implement a mediation.
>>>>
>>>> An alternative is to implement a dedicated net, console and vsock
>>>> driver for vringh (CAIF somehow works like this). This would have
>>>> better performance.
>>> Does it mean that the driver also functions as a network driver directly?
> I meant, e.g in the case of networking, you can have a dedicated
> driver with two vringh in the endpoint side.
>
> The benefit is the performance, no need for the (datapath) mediation.
>
> But if we don't care about the performance, this proposal seems to be fine.
>
> Thanks
I agree with you.  The design you suggested is better in terms of 
performance.
However, the proposed design is not bad for the following the reasons I 
think.

The proposed design has one more operation in control plane because the data
steps over the virtio-net driver, but the number of copies at the data plane
remains the same. I think the operation added in control plane has small 
effects
for performance.

Moreover, there are some advantages when the data step over the virtio-net
driver. We can make use of the optimizations and some functions without
modifications and implementations. e.g. ethtool and XDP(BPF) supports.

Any comments would be appreciated.

>>>>> This driver has two roles. The first is as a PCIe endpoint virtio console
>>>>> function, which is implemented using the PCIe endpoint framework and PCIe
>>>>> EP virtio helpers. The second is as a virtual virtio console device
>>>>> connected to the virtio bus on PCIe endpoint Linux.
>>>>>
>>>>> Communication between the two is achieved by copying the virtqueue data
>>>>> between PCIe root and endpoint, respectively.
>>>>>
>>>>> This is a simple implementation and does not include features of
>>>>> virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
>>>>> virtio console driver only displays /dev/hvc0.
>>>>>
>>>>> As an example of usage, by setting getty to /dev/hvc0, it is possible to
>>>>> login to another host.
>>>>>
>>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>>>> ---
>>>>> Changes from v2:
>>>>> - Change to use copy functions between kiovs of pci-epf-virtio.
>>>>>
>>>>>    drivers/pci/endpoint/functions/Kconfig        |  12 +
>>>>>    drivers/pci/endpoint/functions/Makefile       |   1 +
>>>>>    drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
>>>>>    3 files changed, 609 insertions(+)
>>>>>    create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
>>>>>
>>>>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>>>>> index fa1a6a569a8f..9ce2698b67e1 100644
>>>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>>>> @@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
>>>>>           select VHOST_RING_IOMEM
>>>>>           help
>>>>>             Helpers to implement PCI virtio Endpoint function
>>>>> +
>>>>> +config PCI_EPF_VCON
>>>>> +       tristate "PCI Endpoint virito-console driver"
>>>>> +       depends on PCI_ENDPOINT
>>>>> +       select VHOST_RING
>>>>> +       select PCI_EPF_VIRTIO
>>>>> +       help
>>>>> +         PCIe Endpoint virtio-console function implementatino. This module
>>>>> +         enables to show the virtio-console as pci device to PCIe host side, and
>>>>> +         another virtual virtio-console device registers to endpoint system.
>>>>> +         Those devices are connected virtually and can communicate each other.
>>>>> +
>>>>> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
>>>>> index a96f127ce900..b4056689ce33 100644
>>>>> --- a/drivers/pci/endpoint/functions/Makefile
>>>>> +++ b/drivers/pci/endpoint/functions/Makefile
>>>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)              += pci-epf-test.o
>>>>>    obj-$(CONFIG_PCI_EPF_NTB)              += pci-epf-ntb.o
>>>>>    obj-$(CONFIG_PCI_EPF_VNTB)             += pci-epf-vntb.o
>>>>>    obj-$(CONFIG_PCI_EPF_VIRTIO)           += pci-epf-virtio.o
>>>>> +obj-$(CONFIG_PCI_EPF_VCON)             += pci-epf-vcon.o
>>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/pci/endpoint/functions/pci-epf-vcon.c
>>>>> new file mode 100644
>>>>> index 000000000000..31f4247cd10f
>>>>> --- /dev/null
>>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
>>>>> @@ -0,0 +1,596 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * PCI Endpoint function driver to impliment virtio-console device
>>>>> + * functionality.
>>>>> + */
>>>>> +#include <linux/pci-epf.h>
>>>>> +#include <linux/virtio_ids.h>
>>>>> +#include <linux/virtio_pci.h>
>>>>> +#include <linux/virtio_console.h>
>>>>> +#include <linux/virtio_ring.h>
>>>>> +
>>>>> +#include "pci-epf-virtio.h"
>>>>> +
>>>>> +static int virtio_queue_size = 0x100;
>>>>> +module_param(virtio_queue_size, int, 0444);
>>>>> +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
>>>>> +
>>>>> +struct epf_vcon {
>>>>> +       /* To access virtqueues on remote host */
>>>>> +       struct epf_virtio evio;
>>>>> +       struct vringh_kiov *rdev_iovs;
>>>>> +
>>>>> +       /* To register a local virtio bus */
>>>>> +       struct virtio_device vdev;
>>>>> +
>>>>> +       /* To access virtqueus of local host driver */
>>>>> +       struct vringh *vdev_vrhs;
>>>>> +       struct vringh_kiov *vdev_iovs;
>>>>> +       struct virtqueue **vdev_vqs;
>>>>> +
>>>>> +       /* For transportation and notification */
>>>>> +       struct workqueue_struct *task_wq;
>>>>> +       struct work_struct raise_irq_work, rx_work, tx_work;
>>>>> +
>>>>> +       /* To retain virtio features. It is commonly used local and remote. */
>>>>> +       u64 features;
>>>>> +
>>>>> +       /* To show a status whether this driver is ready and the remote is connected */
>>>>> +       bool connected;
>>>>> +};
>>>>> +
>>>>> +enum {
>>>>> +       VCON_VIRTQUEUE_RX,
>>>>> +       VCON_VIRTQUEUE_TX,
>>>>> +       // Should be end of enum
>>>>> +       VCON_VIRTQUEUE_NUM
>>>>> +};
>>>> It would be better if we can split the console specific thing out,
>>>> then it allows us to do ethernet and vsock in the future.
>>> I'm planning to implement each virtio device in a separate file.
>>> https://lwn.net/Articles/922124/
>>>
>>>
>>>
>>>> Thanks
>>>>
>>> Best regards,
>>> Shunsuke

Best regards,

Shunsuke

