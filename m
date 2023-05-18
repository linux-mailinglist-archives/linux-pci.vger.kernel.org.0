Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422A707D52
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjERJyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjERJyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 05:54:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B2E4E
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 02:54:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643846c006fso1817919b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1684403673; x=1686995673;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wt78fUxV6LOew5dfjUF3WMm8EbNEfc8NoopwolgUsm4=;
        b=oa56e/cOFzouJJv0/MzasDsZCTvPgTaB7sJCEQvT0wP/eycS8LqxRbFSmGBHFcW/Yq
         Pwv7SlrXHAGE59pwj9hnqdqU7DpahBba+IByjlAPLS1zUdYSkJcYUpMUSosYJ3Lu5uB9
         CDKTb4GxrgeG5GpL6s/9AfD0UA0vnb7N4XzTazYWjs9BY1tLyUFC4qMBLhLUVjk2JPgB
         nMskIF5V7Yja08OJ8yxnmF2EFh0RpY4ntmNWK2sbo9f+wo61nMXezi0/kPgo3n9KcTTh
         o/5xbZfbWEvLkr6Nf8y79uiYypC2sHNc9A/mDzgt5M6SupbpWyL8NVHk8ERp7kCSaQUO
         enng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403673; x=1686995673;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt78fUxV6LOew5dfjUF3WMm8EbNEfc8NoopwolgUsm4=;
        b=ZaVDYg9iQUuZ3k7UvHbRtSJBpyasPDaInvV/kKhXwSUw9gXmwKovplal7L3gawtFDo
         z+P3YTSf2Sxl+SYIuomuh8piUSEjA7tZ0Ai0KmwqKhwj3iS1wF24uasL5M2KW9mgwd5E
         pp/FMvSZ6DYj9pw1Ft0JCsFZkSLUyCbkT68PM+h8kjnowaOdCyceEuMsj8KfKgW/VXni
         JUoM4vwt00p9oL5o6MBt9g/VFjl6CW1jYwYbxFi9PfvPToBJ/6gl2M8rIYCC41Yxcupz
         nOXqxFoeE+V//dVYzCfAkSsQc0GGmQpQl2OPlFci1LPCQZv0CmOw4neYwdtydg2HK1GY
         Q7jw==
X-Gm-Message-State: AC+VfDx1tPNq5qFV7ktbmgvFnOFa9SE06oEWxtz1DIaJW9/s6G85OP8V
        RtmR7GrO1Wbbi7zc517VwcwrRA==
X-Google-Smtp-Source: ACHHUZ5Y/5eVpiIq2BE9YtPYSYOpfkKx54IPVaQdjI3ksPbZmzoFIpZ5xJQw09lbxNUw1uhpMhr97w==
X-Received: by 2002:a05:6a20:8e1c:b0:109:c500:376c with SMTP id y28-20020a056a208e1c00b00109c500376cmr256819pzj.12.1684403672718;
        Thu, 18 May 2023 02:54:32 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0063d3801d196sm996774pfu.23.2023.05.18.02.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:54:32 -0700 (PDT)
Message-ID: <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
Date:   Thu, 18 May 2023 18:54:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
Content-Language: en-US
From:   Shunsuke Mie <mie@igel.co.jp>
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
In-Reply-To: <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
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

Gentle ping ...


Thanks,

Shunsuke.

On 2023/05/10 12:17, Shunsuke Mie wrote:
> Hi Json,
> 2023年5月8日(月) 13:03 Jason Wang <jasowang@redhat.com>:
>> On Thu, Apr 27, 2023 at 6:44 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>>> Add a new PCIe endpoint function driver that works as a pci virtio-console
>>> device. The console connect to endpoint side console. It enables to
>>> communicate PCIe host and endpoint.
>>>
>>> Architecture is following:
>>>
>>>   ┌────────────┐         ┌──────────────────────┬────────────┐
>>>   │virtioe     │         │                      │virtio      │
>>>   │console drv │         ├───────────────┐      │console drv │
>>>   ├────────────┤         │(virtio console│      ├────────────┤
>>>   │ virtio bus │         │ device)       │◄────►│ virtio bus │
>>>   ├────────────┤         ├---------------┤      └────────────┤
>>>   │            │         │ pci ep virtio │                   │
>>>   │  pci bus   │         │  console drv  │                   │
>>>   │            │  pcie   ├───────────────┤                   │
>>>   │            │ ◄─────► │  pci ep Bus   │                   │
>>>   └────────────┘         └───────────────┴───────────────────┘
>>>     PCIe Root              PCIe Endpoint
>>>
>> I think it might only works for peer devices like:
>>
>> net, console or vsock.
> Could you tell me what "peer devices" means?
>
>> So there're many choices here, I'd like to know what's the reason for
>> you to implement a mediation.
>>
>> An alternative is to implement a dedicated net, console and vsock
>> driver for vringh (CAIF somehow works like this). This would have
>> better performance.
> Does it mean that the driver also functions as a network driver directly?
>>
>>> This driver has two roles. The first is as a PCIe endpoint virtio console
>>> function, which is implemented using the PCIe endpoint framework and PCIe
>>> EP virtio helpers. The second is as a virtual virtio console device
>>> connected to the virtio bus on PCIe endpoint Linux.
>>>
>>> Communication between the two is achieved by copying the virtqueue data
>>> between PCIe root and endpoint, respectively.
>>>
>>> This is a simple implementation and does not include features of
>>> virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
>>> virtio console driver only displays /dev/hvc0.
>>>
>>> As an example of usage, by setting getty to /dev/hvc0, it is possible to
>>> login to another host.
>>>
>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>> ---
>>> Changes from v2:
>>> - Change to use copy functions between kiovs of pci-epf-virtio.
>>>
>>>   drivers/pci/endpoint/functions/Kconfig        |  12 +
>>>   drivers/pci/endpoint/functions/Makefile       |   1 +
>>>   drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
>>>   3 files changed, 609 insertions(+)
>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
>>>
>>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>>> index fa1a6a569a8f..9ce2698b67e1 100644
>>> --- a/drivers/pci/endpoint/functions/Kconfig
>>> +++ b/drivers/pci/endpoint/functions/Kconfig
>>> @@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
>>>          select VHOST_RING_IOMEM
>>>          help
>>>            Helpers to implement PCI virtio Endpoint function
>>> +
>>> +config PCI_EPF_VCON
>>> +       tristate "PCI Endpoint virito-console driver"
>>> +       depends on PCI_ENDPOINT
>>> +       select VHOST_RING
>>> +       select PCI_EPF_VIRTIO
>>> +       help
>>> +         PCIe Endpoint virtio-console function implementatino. This module
>>> +         enables to show the virtio-console as pci device to PCIe host side, and
>>> +         another virtual virtio-console device registers to endpoint system.
>>> +         Those devices are connected virtually and can communicate each other.
>>> +
>>> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
>>> index a96f127ce900..b4056689ce33 100644
>>> --- a/drivers/pci/endpoint/functions/Makefile
>>> +++ b/drivers/pci/endpoint/functions/Makefile
>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)              += pci-epf-test.o
>>>   obj-$(CONFIG_PCI_EPF_NTB)              += pci-epf-ntb.o
>>>   obj-$(CONFIG_PCI_EPF_VNTB)             += pci-epf-vntb.o
>>>   obj-$(CONFIG_PCI_EPF_VIRTIO)           += pci-epf-virtio.o
>>> +obj-$(CONFIG_PCI_EPF_VCON)             += pci-epf-vcon.o
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/pci/endpoint/functions/pci-epf-vcon.c
>>> new file mode 100644
>>> index 000000000000..31f4247cd10f
>>> --- /dev/null
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
>>> @@ -0,0 +1,596 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * PCI Endpoint function driver to impliment virtio-console device
>>> + * functionality.
>>> + */
>>> +#include <linux/pci-epf.h>
>>> +#include <linux/virtio_ids.h>
>>> +#include <linux/virtio_pci.h>
>>> +#include <linux/virtio_console.h>
>>> +#include <linux/virtio_ring.h>
>>> +
>>> +#include "pci-epf-virtio.h"
>>> +
>>> +static int virtio_queue_size = 0x100;
>>> +module_param(virtio_queue_size, int, 0444);
>>> +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
>>> +
>>> +struct epf_vcon {
>>> +       /* To access virtqueues on remote host */
>>> +       struct epf_virtio evio;
>>> +       struct vringh_kiov *rdev_iovs;
>>> +
>>> +       /* To register a local virtio bus */
>>> +       struct virtio_device vdev;
>>> +
>>> +       /* To access virtqueus of local host driver */
>>> +       struct vringh *vdev_vrhs;
>>> +       struct vringh_kiov *vdev_iovs;
>>> +       struct virtqueue **vdev_vqs;
>>> +
>>> +       /* For transportation and notification */
>>> +       struct workqueue_struct *task_wq;
>>> +       struct work_struct raise_irq_work, rx_work, tx_work;
>>> +
>>> +       /* To retain virtio features. It is commonly used local and remote. */
>>> +       u64 features;
>>> +
>>> +       /* To show a status whether this driver is ready and the remote is connected */
>>> +       bool connected;
>>> +};
>>> +
>>> +enum {
>>> +       VCON_VIRTQUEUE_RX,
>>> +       VCON_VIRTQUEUE_TX,
>>> +       // Should be end of enum
>>> +       VCON_VIRTQUEUE_NUM
>>> +};
>> It would be better if we can split the console specific thing out,
>> then it allows us to do ethernet and vsock in the future.
> I'm planning to implement each virtio device in a separate file.
> https://lwn.net/Articles/922124/
>
>
>
>> Thanks
>>
> Best regards,
> Shunsuke
