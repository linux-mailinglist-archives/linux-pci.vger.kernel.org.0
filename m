Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA73FA4DD7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 05:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfIBDur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Sep 2019 23:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbfIBDur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Sep 2019 23:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5FD58B8F2D;
        Mon,  2 Sep 2019 03:50:46 +0000 (UTC)
Received: from [10.72.12.232] (ovpn-12-232.pek2.redhat.com [10.72.12.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82E4F1001947;
        Mon,  2 Sep 2019 03:50:41 +0000 (UTC)
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     mst@redhat.com, linux-pci@vger.kernel.org, haotian.wang@duke.edu
References: <f5e5dc8a-2e02-a675-8ab9-b2ab58640452@redhat.com>
 <20190830230621.8338-1-haotian.wang@sifive.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c8ce8d58-4456-2829-23ce-579b9d941e24@redhat.com>
Date:   Mon, 2 Sep 2019 11:50:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830230621.8338-1-haotian.wang@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 02 Sep 2019 03:50:47 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/8/31 上午7:06, Haotian Wang wrote:
> Hi Jason,
>
> Thank you for your reply.
>
> On Fri, Aug 30, 2019 at 2:12 AM Jason Wang <jasowang@redhat.com> wrote:
>> - Is there a doc for this endpoint device?
> The doc for the board is
> https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/ug1224-vcu118-eval-bd.pdf,
> but this is not all that useful.


Yes it is.


>   The more important information is
> actually in the endpoint controller source code,
> drivers/pci/controller/dwc/pcie-designware-ep.c and
> drivers/pci/controller/dwc/pcie-designware-ep.h.
>
>> - You refer virtio specification in the above, does it mean your device
>> is fully compatible with virtio (or only datapath is compatible?)
> I discussed this issue with Kishon in the previous emails a lot.
> Theoretically this should be compatible with all virtio devices, but
> right now the code is closely coupled with virtio_net only.


We probably want a generic solution like virtio transport instead of a 
device specific one.


> The reason
> is that this endpoint function does not use the intended datapath of
> virtio. I will explain in the answer to the next question.
>
>> - What's the reason for introducing kthreads for some kinds of
>> translation or copying of descriptor?
> So there is a virtio_device A on the endpoint, there is another
> virtio_device B on the endpoint that acts as a virtio_net device for the
> PCI host. Then I copied data from the tx virtqueue of B to rx virtqueue
> of A, and vice versa, directly.


If my understanding is correct. You only want device B to be visible as 
a virtio device for Linux?

Another note, it looks to me that CAIF virtio is something similar but 
the only differences are:

1) rx virtqueue are flipped, which means it use virtio queue for TX and 
vringh queue for RX
2) accessors

As you said, if the copying is done by software, can use manage to use 
method 1 as CAIF virtio then we can try to use vringh code by simply 
introducing new accessor (epf based)?


> The PCI endpoint can interrupt the host
> but the host cannot interrupt the endpoint. Therefore, the endpoint has
> two dedicated kthreads that constantly poll for notifications and data
> changes that happen on the host side, one for tx and one for rx.
> Therefore, there is really no "vhost" involved. Data is transferred
> between two virtio_devices directly.


Right.


>
> The descriptors are not copied. The data indicated by the physical
> addresses in those descriptors are copied using pci endpoint framework
> API.
>
> The problem is that this only works for virtio_net with the split
> virtio_ring configuration.


I think do need to think of a way of using vringh, then we can try to 
implement packed ring layout there.


>
>> - Is it possible to reuse e.g vringh (by introducing new accesor) and
>> virtio core codes?
> Two structures are used that are not in source files. One is struct
> vring_virtqueue and the other is struct virtnet_info.


Note that, vringh allows different type of accessor. If the only 
difference is the way to access the vring, it should work.


>
> After some thought, I can reduce the use of vring_virtqueue to be only
> in the function
>
> static void epf_virtio_interrupt(struct vring *, struct device *)
>
> This function emulates the following function in virtio_ring.c
>
> irqreturn_t vring_interruptp(int irq, void *_vq)
>
> The motivation is that for the local virtio_device A, it does not need
> to use interrupt at all. When the a kthread got something from the
> PCI host and placed data in the rx queue of A, that same kthread could
> call the callback function associated with the rx queue directly.
>
> Specifically I need to access the fields "last_used_idx" and "broken" of
> vring_virtqueue somehow.
>
> virtnet_info can be solved more easily. For a virtio_net device.
> ((struct virtnet_info *)virtio_device->priv)->dev is the struct
> net_device created together with the virtio_device. I just need a
> pointer to that struct net_device after all.


I'm still not clear why we need to expose virtnet_info. Usually, we just 
need to set vendor id and device id and call register_virtio_device().


>
>> Btw, I'm going to post mdev transport for virtio (with a sample of
>> vringh loopback device). Technically, this can go through mdev bus as well.
> I am not that familiar with mdev, but will read up on it. Thank you for
> the info.


Will cc you.

Thanks


>
> Best,
> Haotian
