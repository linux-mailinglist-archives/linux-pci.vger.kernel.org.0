Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB297A5CDA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfIBUFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 16:05:07 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44175 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIBUFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 16:05:07 -0400
Received: by mail-yb1-f195.google.com with SMTP id y21so5155671ybi.11
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2019 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+nHqq3IDJBzbo+BoMUgsEspgjUFuKr8XdEIQKUyMDs=;
        b=ZfYoNGQgV92AwKi7UkLrW9WHGpzHYcrA15lAlHr7B9IbH5qvNdkdxlmwBvy7tMUdcH
         Thh+eZrLhvqw5zQ+eBdUwWASmFCvIj7DY9PQgzLipNW5+N80nf0lUYowafRYnieD45Aa
         jH1E0uJwFQpfNY0Oeoyqh94R6SF558l2RGC8lzZA5DzQaELHiItaC+fboYl63t+B9NkR
         DnD8I6e5hgs/fK4VSpm1boYLLzuzH86ZaTp60/JlSAQXsp/srKkHFm+SZYRojmOX35CH
         9oLFpGtLxTf79653Btjz7TKsfVdoq1MXmd3iBeMg8Qk0820/d0JrJGEQ9Ule/ZNCAOEy
         0Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+nHqq3IDJBzbo+BoMUgsEspgjUFuKr8XdEIQKUyMDs=;
        b=A2tVKaJHpCMwpIVtFNRc2Vd48t907d+yAw4H1hO4a2+Ift0asg+FNGS65VtbKuT3ex
         bouD6z0OztZ8oTYNT1ziaUXR/F2UpU3O0Rd6k7iY0/TGB9hG9rFpdQHKVRMl6lBryfX4
         GKDKN0RCUml85pzHqRMN3xCGg9XBz90Hnc/mNZUkOq7fjEzDGcttl05mzXxI7lur3Vvy
         t9AGgkX79aERxIMaxUWTpgLcaUBi5J+PHWbmMQ7sldi5mMgiq2oPgE2Ly/OEprGPKjvB
         905mFOgDCVZkNJmZQM8xjLNFT7VMu5PhLFKZ6/W3gJfoNwG+lpB5UfESjr2zVuRnNRuP
         4+hQ==
X-Gm-Message-State: APjAAAXs6D+AkBlcDuDobnR+ZkmMFuZxl50oQ0YdLWufQsvYOATkMb0H
        +d3iZuyEcb5haMy8hXSbAWmOOQ==
X-Google-Smtp-Source: APXvYqwsFGYldjhD0hlR8/9tSwDpNETI3SFgyJslpeQ4m8bmZPdnqsFqfxI/QDdr4mb17s3JwdxeKw==
X-Received: by 2002:a25:7396:: with SMTP id o144mr22299001ybc.390.1567454706098;
        Mon, 02 Sep 2019 13:05:06 -0700 (PDT)
Received: from jaxon.wireless.duke.edu ([152.3.43.42])
        by smtp.gmail.com with ESMTPSA id y75sm1110040ywa.58.2019.09.02.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 13:05:05 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     jasowang@redhat.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     mst@redhat.com, linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Mon,  2 Sep 2019 16:05:03 -0400
Message-Id: <20190902200503.1167-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <c8ce8d58-4456-2829-23ce-579b9d941e24@redhat.com>
References: <c8ce8d58-4456-2829-23ce-579b9d941e24@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

On Sun, Sep 1, 2019 at 11:50 PM Jason Wang <jasowang@redhat.com> wrote:
> >> - You refer virtio specification in the above, does it mean your device
> >> is fully compatible with virtio (or only datapath is compatible?)
> > I discussed this issue with Kishon in the previous emails a lot.
> > Theoretically this should be compatible with all virtio devices, but
> > right now the code is closely coupled with virtio_net only.
> 
> 
> We probably want a generic solution like virtio transport instead of a 
> device specific one.

There is the question of motivation. Virtual ethernet over PCI has some
very immediate use cases, especially ssh. Virtual block/cosole devices
over PCI do not make whole lot of sense to me.

In supporting virtual ethernet, I created two virtio_devices that talk
to each other using skb. However, when supporting block/console devices,
it is not obvious how many devices there will be, what the relationship
between the devices is, and why they are created in the first place.

> >> - What's the reason for introducing kthreads for some kinds of
> >> translation or copying of descriptor?
> > So there is a virtio_device A on the endpoint, there is another
> > virtio_device B on the endpoint that acts as a virtio_net device for the
> > PCI host. Then I copied data from the tx virtqueue of B to rx virtqueue
> > of A, and vice versa, directly.
> 
> 
> If my understanding is correct. You only want device B to be visible as 
> a virtio device for Linux?

Device A is on endpoint Linux. Device B is on host Linux.
Code that controls how A behaves is entrely in this epf. This epf has
another part of code that polls and manipulates data on the host side so
that B on host side indeed behaves like a virtio_device.

> Another note, it looks to me that CAIF virtio is something similar but 
> the only differences are:
> 
> 1) rx virtqueue are flipped, which means it use virtio queue for TX and 
> vringh queue for RX
> 2) accessors
> 
> As you said, if the copying is done by software, can use manage to use 
> method 1 as CAIF virtio then we can try to use vringh code by simply 
> introducing new accessor (epf based)?

I'm not sure what you mean here. Are you saying we let device A's rx queue
BE the tx queue of device B and vice versa?

Also that design uses the conventional virtio/vhost framework. In this
epf, are you implying instead of creating a Device A, create some sort
of vhost instead?

> >> - Is it possible to reuse e.g vringh (by introducing new accesor) and
> >> virtio core codes?
> > Two structures are used that are not in source files. One is struct
> > vring_virtqueue and the other is struct virtnet_info.
> 
> 
> Note that, vringh allows different type of accessor. If the only 
> difference is the way to access the vring, it should work.

The objective is not accessing vrings. struct vring_virtqueue is used for
the part of code that handles Device A.

virtio_ring.h exposes a function that creates virtqueues and I used that
function. Under the hood of that function, a bigger struct,
vring_virtqueue containing struct virtqueue, is used internally. It
would be great if I can access some fields in vring_virtqueue just by
passing in a pointer of virtqueue. It could be something as simple as

bool is_vq_broken(struct virtqueue *_vq)
{
	struct vring_virtqueue *vq = to_vvq(_vq);
	return vq->broken;
}
EXPORT_SYMBOL(is_vq_broken);

If these accessors are added to virtio_ring.h or virtio_ring.c, I do not
need to copy the whole vring_virtqueue struct into my pci-epf-virtio.h.

All I need is accessors to "broken" and "last_used_idx" of
vring_virtqueue.

> > The descriptors are not copied. The data indicated by the physical
> > addresses in those descriptors are copied using pci endpoint framework
> > API.
> >
> > The problem is that this only works for virtio_net with the split
> > virtio_ring configuration.
> 
> 
> I think do need to think of a way of using vringh, then we can try to 
> implement packed ring layout there.

Sure, though making packed rings work will happen much later. I do not
have the VCU118 board right now.

> > virtnet_info can be solved more easily. For a virtio_net device.
> > ((struct virtnet_info *)virtio_device->priv)->dev is the struct
> > net_device created together with the virtio_device. I just need a
> > pointer to that struct net_device after all.
> 
> 
> I'm still not clear why we need to expose virtnet_info. Usually, we just 
> need to set vendor id and device id and call register_virtio_device().

I must delay the start of kthreads until the virtual network interface on
endpoint is brought up by `ifconfig eth0` up. If the kthreads started
copying data from host into the endpoint rx queue while the net_device's
flags did not contain IFF_UP, a crash would occur. I can do a more
thorough investigation of the cause of this, must either way, I need to
have access to the net_device in the epf.

Thank you for the feedback!

Best,
Haotian
