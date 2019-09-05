Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9308A98A0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfIEC41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 22:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEC41 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 22:56:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A116430025F1;
        Thu,  5 Sep 2019 02:56:26 +0000 (UTC)
Received: from [10.72.12.231] (ovpn-12-231.pek2.redhat.com [10.72.12.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBCA194B2;
        Thu,  5 Sep 2019 02:56:20 +0000 (UTC)
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>, kishon@ti.com,
        mst@redhat.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, haotian.wang@duke.edu
References: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
 <20190904215801.2971-1-haotian.wang@sifive.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <59982499-0fc1-2e39-9ff9-993fb4dd7dcc@redhat.com>
Date:   Thu, 5 Sep 2019 10:56:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904215801.2971-1-haotian.wang@sifive.com>
Content-Type: multipart/mixed;
 boundary="------------B8680429502EE7BA0E4D0CA4"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 02:56:26 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------B8680429502EE7BA0E4D0CA4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 2019/9/5 =E4=B8=8A=E5=8D=885:58, Haotian Wang wrote:
> Hi Jason,
>
> I have an additional comment regarding using vring.
>
> On Tue, Sep 3, 2019 at 6:42 AM Jason Wang <jasowang@redhat.com> wrote:
>> Kind of, in order to address the above limitation, you probably want t=
o=20
>> implement a vringh based netdevice and driver. It will work like,=20
>> instead of trying to represent a virtio-net device to endpoint,=20
>> represent a new type of network device, it uses two vringh ring instea=
d=20
>> virtio ring. The vringh ring is usually used to implement the=20
>> counterpart of virtio driver. The advantages are obvious:
>>
>> - no need to deal with two sets of features, config space etc.
>> - network specific, from the point of endpoint linux, it's not a virti=
o=20
>> device, no need to care about transport stuffs or embedding internal=20
>> virtio-net specific data structures
>> - reuse the exist codes (vringh) to avoid duplicated bugs, implementin=
g=20
>> a virtqueue is kind of challenge
> With vringh.c, there is no easy way to interface with virtio_net.c.
>
> vringh.c is linked with vhost/net.c nicely=20


Let me clarify, vhost_net doesn't use vringh at all (though there's a
plan to switch to use vringh).


> but again it's not easy to
> interface vhost/net.c with the network stack of endpoint kernel. The
> vhost drivers are not designed with the purpose of creating another
> suite of virtual devices in the host kernel in the first place. If I tr=
y
> to manually write code for this interfacing, it seems that I will do
> duplicate work that virtio_net.c does.


Let me explain:

- I'm not suggesting to use vhost_net since it can only deal with
userspace virtio rings.
- I suggest to introduce netdev that has vringh vring assoticated.
Vringh was designed to deal with virtio ring located at different types
of memory. It supports userspace vring and kernel vring currently, but
it should not be too hard to add support for e.g endpoint device that
requires DMA or whatever other method to access the vring. So it was by
design to talk directly with e.g kernel virtio device.
- In your case, you can read vring address from virtio config space
through endpoint framework and then create vringh. It's as simple as:
creating a netdev, read vring address, and initialize vringh. Then you
can use vringh helper to get iov and build skb etc (similar to caif_virti=
o).


>
> There will be two more main disadvantages probably.
>
> Firstly, there will be two layers of overheads. vhost/net.c uses
> vringh.c to channel data buffers into some struct sockets. This is the
> first layer of overhead. That the virtual network device will have to
> use these sockets somehow adds another layer of overhead.


As I said, it doesn't work like vhost and no socket is needed at all.


>
> Secondly, probing, intialization and de-initialization of the virtual
> network_device are already non-trivial. I'll likely copy this part
> almost verbatim from virtio_net.c in the end. So in the end, there will=

> be more duplicate code.


It will be a new type of network device instead of virtio, you don't
need to care any virtio stuffs but vringh in your codes. So it looks to
me it would be much simpler and compact.

But I'm not saying your method is no way to go, but you should deal with
lots of other issues like I've replied in the previous mail. What you
want to achieve is

1) Host (virtio-pci) <-> virtio ring <-> virtual eth device <-> virtio
ring <-> Endpoint (virtio with customized config_ops).

But I suggest is

2) Host (virtio-pci) <-> virtio ring <-> virtual eth device <-> vringh
vring (virtio ring in the Host) <-> network device

The differences is.
- Complexity: In your proposal, there will be two virtio devices and 4
virtqueues. It means you need to prepare two sets of features, config
ops etc. And dealing with inconsistent feature will be a pain. It may
work for simple case like a virtio-net device with only _F_MAC, but it
would be hard to be expanded. If we decide to go for vringh, there will
be a single virtio device and 2 virtqueues. In the endpoint part, it
will be 2 vringh vring (which is actually point the same virtqueue from
Host side) and a normal network device. There's no need for dealing with
inconsistency, since vringh basically sever as a a device
implementation, the feature negotiation is just between device (network
device with vringh) and driver (virtito-pci) from the view of Linux
running on the PCI Host.
- Maintainability: A third path for dealing virtio ring. We've already
had vhost and vringh, a third path will add a lot of overhead when
trying to maintaining them. My proposal will try to reuse vringh,
there's no need a new path.
- Layer violation: We want to hide the transport details from the device
and make virito-net device can be used without modification. But your
codes try to poke information like virtnet_info. My proposal is to just
have a new networking device that won't need to care virtio at all. It's
not that hard as you imagine to have a new type of netdev, I suggest to
take a look at how caif_virtio is done, it would be helpful.

If you still decide to go with two two virtio device model, you need
probably:
- Proving two sets of config and features, and deal with inconsistency
- Try to reuse the vringh codes
- Do not refer internal structures from virtio-net.c

But I recommend to take a step of trying vringh method which should be
much simpler.

Thanks


>
> Thank you for your patience!
>
> Best,
> Haotian

--------------B8680429502EE7BA0E4D0CA4
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
JJaQ8I7hEjBpmSTF4uR0ETUJmQbCBynU
=3DCBPY
-----END PGP PUBLIC KEY BLOCK-----

--------------B8680429502EE7BA0E4D0CA4--
