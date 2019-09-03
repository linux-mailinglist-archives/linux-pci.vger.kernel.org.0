Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF2A66B5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfICKmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 06:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfICKmP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 06:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CA00308FE8D;
        Tue,  3 Sep 2019 10:42:14 +0000 (UTC)
Received: from [10.72.12.79] (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5983219C78;
        Tue,  3 Sep 2019 10:42:09 +0000 (UTC)
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     mst@redhat.com, linux-pci@vger.kernel.org, haotian.wang@duke.edu
References: <c8ce8d58-4456-2829-23ce-579b9d941e24@redhat.com>
 <20190902200503.1167-1-haotian.wang@sifive.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
Date:   Tue, 3 Sep 2019 18:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902200503.1167-1-haotian.wang@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 03 Sep 2019 10:42:14 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/9/3 上午4:05, Haotian Wang wrote:
> Hi Jason,
>
> On Sun, Sep 1, 2019 at 11:50 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> - You refer virtio specification in the above, does it mean your device
>>>> is fully compatible with virtio (or only datapath is compatible?)
>>> I discussed this issue with Kishon in the previous emails a lot.
>>> Theoretically this should be compatible with all virtio devices, but
>>> right now the code is closely coupled with virtio_net only.
>>
>> We probably want a generic solution like virtio transport instead of a
>> device specific one.
> There is the question of motivation. Virtual ethernet over PCI has some
> very immediate use cases, especially ssh. Virtual block/cosole devices
> over PCI do not make whole lot of sense to me.
>
> In supporting virtual ethernet, I created two virtio_devices that talk
> to each other using skb. However, when supporting block/console devices,
> it is not obvious how many devices there will be, what the relationship
> between the devices is, and why they are created in the first place.


Ok, I get this, see comments below.


>
>>>> - What's the reason for introducing kthreads for some kinds of
>>>> translation or copying of descriptor?
>>> So there is a virtio_device A on the endpoint, there is another
>>> virtio_device B on the endpoint that acts as a virtio_net device for the
>>> PCI host. Then I copied data from the tx virtqueue of B to rx virtqueue
>>> of A, and vice versa, directly.
>>
>> If my understanding is correct. You only want device B to be visible as
>> a virtio device for Linux?
> Device A is on endpoint Linux. Device B is on host Linux.
> Code that controls how A behaves is entrely in this epf. This epf has
> another part of code that polls and manipulates data on the host side so
> that B on host side indeed behaves like a virtio_device.


So if I understand correctly, what you want is:

1) epf virtio actually represent a full virtio pci device to the host 
Linux.
2) to endpoint Linux, you also want to represent a virtio device (by 
copying data between two vrings) that has its own config ops

This looks feasible but tricky. One part is the feature negotiation. You 
probably need to prepare two set of features for each side. Consider in 
your case, you claim the device to support GUEST_CSUM, but since no 
HOST_CUSM is advertised, neither side will send packet without csum. And 
if you claim HOST_CUSM, you need to deal with the case if one of side 
does not support GUEST_CSUM (e.g checksum by yourself). And things will 
be even more complex for other offloading features. Another part is the 
configuration space. You need to handle the inconsistency between two 
sides, e.g one side want 4 queues but the other only do 1.


>
>> Another note, it looks to me that CAIF virtio is something similar but
>> the only differences are:
>>
>> 1) rx virtqueue are flipped, which means it use virtio queue for TX and
>> vringh queue for RX
>> 2) accessors
>>
>> As you said, if the copying is done by software, can use manage to use
>> method 1 as CAIF virtio then we can try to use vringh code by simply
>> introducing new accessor (epf based)?
> I'm not sure what you mean here. Are you saying we let device A's rx queue
> BE the tx queue of device B and vice versa?


I want to suggest this but after some thought I think it's better to 
keep host side untouched as you propose.


>
> Also that design uses the conventional virtio/vhost framework. In this
> epf, are you implying instead of creating a Device A, create some sort
> of vhost instead?


Kind of, in order to address the above limitation, you probably want to 
implement a vringh based netdevice and driver. It will work like, 
instead of trying to represent a virtio-net device to endpoint, 
represent a new type of network device, it uses two vringh ring instead 
virtio ring. The vringh ring is usually used to implement the 
counterpart of virtio driver. The advantages are obvious:

- no need to deal with two sets of features, config space etc.
- network specific, from the point of endpoint linux, it's not a virtio 
device, no need to care about transport stuffs or embedding internal 
virtio-net specific data structures
- reuse the exist codes (vringh) to avoid duplicated bugs, implementing 
a virtqueue is kind of challenge


>
>>>> - Is it possible to reuse e.g vringh (by introducing new accesor) and
>>>> virtio core codes?
>>> Two structures are used that are not in source files. One is struct
>>> vring_virtqueue and the other is struct virtnet_info.
>>
>> Note that, vringh allows different type of accessor. If the only
>> difference is the way to access the vring, it should work.
> The objective is not accessing vrings. struct vring_virtqueue is used for
> the part of code that handles Device A.


Kind of. E.g in your code you need to use a dedicated function to access 
the virtqueue of Host Linux. When using vringh, you can invent a new 
type of accessor to do that.


>
> virtio_ring.h exposes a function that creates virtqueues and I used that
> function. Under the hood of that function, a bigger struct,
> vring_virtqueue containing struct virtqueue, is used internally. It
> would be great if I can access some fields in vring_virtqueue just by
> passing in a pointer of virtqueue. It could be something as simple as
>
> bool is_vq_broken(struct virtqueue *_vq)
> {
> 	struct vring_virtqueue *vq = to_vvq(_vq);
> 	return vq->broken;
> }
> EXPORT_SYMBOL(is_vq_broken);
>
> If these accessors are added to virtio_ring.h or virtio_ring.c, I do not
> need to copy the whole vring_virtqueue struct into my pci-epf-virtio.h.
>
> All I need is accessors to "broken" and "last_used_idx" of
> vring_virtqueue.


It looks to me that all you want is just tell the address of host 
virtqueue and features to vringh through e.g vringh_init_endpint() 
(probably derived from vringh_init_kern()). Then you can use 
vringh_get_desc_endpoint() to access the host virtqueue etc. You may 
refer cfv_rx_poll() for an reference.


>
>>> The descriptors are not copied. The data indicated by the physical
>>> addresses in those descriptors are copied using pci endpoint framework
>>> API.
>>>
>>> The problem is that this only works for virtio_net with the split
>>> virtio_ring configuration.
>>
>> I think do need to think of a way of using vringh, then we can try to
>> implement packed ring layout there.
> Sure, though making packed rings work will happen much later. I do not
> have the VCU118 board right now.


Right, the point the is somehow reuse the codes instead of duplicating them.


>
>>> virtnet_info can be solved more easily. For a virtio_net device.
>>> ((struct virtnet_info *)virtio_device->priv)->dev is the struct
>>> net_device created together with the virtio_device. I just need a
>>> pointer to that struct net_device after all.
>>
>> I'm still not clear why we need to expose virtnet_info. Usually, we just
>> need to set vendor id and device id and call register_virtio_device().
> I must delay the start of kthreads until the virtual network interface on
> endpoint is brought up by `ifconfig eth0` up. If the kthreads started
> copying data from host into the endpoint rx queue while the net_device's
> flags did not contain IFF_UP, a crash would occur. I can do a more
> thorough investigation of the cause of this, must either way, I need to
> have access to the net_device in the epf.


If we go with the way of using net device with vringh. There won't be 
such issue.

Thanks


>
> Thank you for the feedback!
>
> Best,
> Haotian
