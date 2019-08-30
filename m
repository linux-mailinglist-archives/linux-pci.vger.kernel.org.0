Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0094AA40C6
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3XGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 19:06:24 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:47063 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfH3XGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 19:06:24 -0400
Received: by mail-yb1-f179.google.com with SMTP id y194so3035099ybe.13
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2019 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zq93mxKoUwjJ0cp53Wf00OXZXPugaZasfQ8q5ucfsfY=;
        b=bn3I6c1LLNVCs3pyazQPUfKtjNYk/GF3NGGCEgsPP0jTOBoPitrwgGI3nrjGByn64w
         6bRaBF4QDcPz3ghd9OXSZHQ7zuNt3aHp2l7MHVCDYJ0rPgnKWffOqk6sh+8WziBW2JVg
         S5B6XxoUJTVtVRJhuMZdN3zxiQgRNBFVAyYLGbjV+MhZAjrsjqLqpK6dPM+hKjR6GKDG
         8Eb3fguBxUUDgbUTkHYbLNyfrhMwZ+tG3m0WKA5B9T+Ux35Wunb6fsQTY2YOtLxel44v
         zAygX+tk1Lw/5D3HbfcwbrCxXgSi71XmyhWhvtlMKuQkNgC/ObqzJzC4wz53CZ2V6ECT
         1p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zq93mxKoUwjJ0cp53Wf00OXZXPugaZasfQ8q5ucfsfY=;
        b=kA2GneVIHQEXEikA1p5ZZBAn2YGpmOA++JfJtcTWnUY3WPyKTycrG92QlWlfoXtxnd
         bZHGI5grHQXR6aNp+Eb7aYgcm1PlIdGwP9XPTsro95zInvOLdeEo27W7Xwo+Z8vfVOVQ
         U4Ni8t19vWvlHJMKmxVX3pO9yMuJr8fiGi3C3ph2RRkzM7T0jAyfuUAhMox1sA3te6c7
         Hpq+b7A4ZfdZXr9nrnWhl4oazL3vFOWzxD3QGZne6aqkQAqyNcmk5guwUQElRIQ8NTvG
         dMZc8z2FyCobaUL8iBv/MipWayDB0D91ORV5hjvdDeed6DWQqJItlOa1ZaoGIDswn2U6
         OvgA==
X-Gm-Message-State: APjAAAX1QAw0/xQNudXgUNzXl33wcRFJeSxVvXJVmh4ZCPeqHZ36QvWt
        yg1W1lT5xor/tcPa28Dxa3M5YA==
X-Google-Smtp-Source: APXvYqwNrjlZlOaYmsE6XAlnvFuj+Wtcpm3BCqKpeMAerOTFk/kRJO72tXp8kevpU6KO3XiN98kMlA==
X-Received: by 2002:a25:cfca:: with SMTP id f193mr13444393ybg.69.1567206383279;
        Fri, 30 Aug 2019 16:06:23 -0700 (PDT)
Received: from jaxon.localdomain ([152.3.43.56])
        by smtp.gmail.com with ESMTPSA id r20sm1542690ywe.41.2019.08.30.16.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:06:22 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     jasowang@redhat.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     mst@redhat.com, linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Fri, 30 Aug 2019 19:06:21 -0400
Message-Id: <20190830230621.8338-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <f5e5dc8a-2e02-a675-8ab9-b2ab58640452@redhat.com>
References: <f5e5dc8a-2e02-a675-8ab9-b2ab58640452@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

Thank you for your reply.

On Fri, Aug 30, 2019 at 2:12 AM Jason Wang <jasowang@redhat.com> wrote:
> - Is there a doc for this endpoint device?
The doc for the board is
https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/ug1224-vcu118-eval-bd.pdf,
but this is not all that useful. The more important information is
actually in the endpoint controller source code,
drivers/pci/controller/dwc/pcie-designware-ep.c and
drivers/pci/controller/dwc/pcie-designware-ep.h.

> - You refer virtio specification in the above, does it mean your device
> is fully compatible with virtio (or only datapath is compatible?)
I discussed this issue with Kishon in the previous emails a lot.
Theoretically this should be compatible with all virtio devices, but
right now the code is closely coupled with virtio_net only. The reason
is that this endpoint function does not use the intended datapath of
virtio. I will explain in the answer to the next question.

> - What's the reason for introducing kthreads for some kinds of
> translation or copying of descriptor?
So there is a virtio_device A on the endpoint, there is another
virtio_device B on the endpoint that acts as a virtio_net device for the
PCI host. Then I copied data from the tx virtqueue of B to rx virtqueue
of A, and vice versa, directly. The PCI endpoint can interrupt the host
but the host cannot interrupt the endpoint. Therefore, the endpoint has
two dedicated kthreads that constantly poll for notifications and data
changes that happen on the host side, one for tx and one for rx.
Therefore, there is really no "vhost" involved. Data is transferred
between two virtio_devices directly. 

The descriptors are not copied. The data indicated by the physical
addresses in those descriptors are copied using pci endpoint framework
API.

The problem is that this only works for virtio_net with the split
virtio_ring configuration.

> - Is it possible to reuse e.g vringh (by introducing new accesor) and
> virtio core codes?
Two structures are used that are not in source files. One is struct
vring_virtqueue and the other is struct virtnet_info.

After some thought, I can reduce the use of vring_virtqueue to be only
in the function 

static void epf_virtio_interrupt(struct vring *, struct device *)

This function emulates the following function in virtio_ring.c

irqreturn_t vring_interruptp(int irq, void *_vq)

The motivation is that for the local virtio_device A, it does not need
to use interrupt at all. When the a kthread got something from the
PCI host and placed data in the rx queue of A, that same kthread could
call the callback function associated with the rx queue directly.

Specifically I need to access the fields "last_used_idx" and "broken" of
vring_virtqueue somehow.

virtnet_info can be solved more easily. For a virtio_net device.
((struct virtnet_info *)virtio_device->priv)->dev is the struct
net_device created together with the virtio_device. I just need a
pointer to that struct net_device after all.

> Btw, I'm going to post mdev transport for virtio (with a sample of
> vringh loopback device). Technically, this can go through mdev bus as well.
I am not that familiar with mdev, but will read up on it. Thank you for
the info.

Best,
Haotian
