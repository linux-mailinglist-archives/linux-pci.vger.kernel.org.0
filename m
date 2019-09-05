Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593EFA98E2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIED2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 23:28:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39047 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIED2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 23:28:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id s142so263020ybc.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 20:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TTAvKAHjzeAJQ+6mMKnpPNjuI8vC91e63aZnW7VfDY=;
        b=FM/Y91uQbdsVAAd/mmvKITutmeFbZUewskeCPgmPJy5i6/tXvizu0yIPPFDpUcbDuK
         BotxuzauwEeqM5z5PtAtOGZW+YrPvRHufUODnBJmFKP6++UjQuBOz8clwqrYVJirKp+I
         ZDH/ILXb7g85MpxnvejUlbwVZG717+rrvVBM/kwwR54G6aKdKHlKE+bUISjKh8UeLhtr
         kilocU7ZIzTzMYo/0FHDserkcOP+qZ9+3VHZvc9u/kQVlZtEizGEQqXgoQe9RhKZnv37
         XjCvmQ+Pb1qol0ziCCxQ71OXKPjqHPHgIYEowFN6M6cqVUADu1U8I3Ut36skErm4YkVg
         ymSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TTAvKAHjzeAJQ+6mMKnpPNjuI8vC91e63aZnW7VfDY=;
        b=lIeS9WuU0Kx405J8GCQnMNTHzNGY9wcYESVzw/w0sxawROOMsbMvFQqQAVDHClbdvT
         mTLwsS5qKhZmePQcKXfGDHCDlY05/a6LKCsMeL1lleHvsw3IUw0mX7G8wsvBDnLIehBL
         lZaz5p7xNH/b5Wh8X41n6RInPQi91ZJ4vXh/bkRpKz2D2BN1JOAtv3Df6xWGe69NUZXw
         yvv5Bw9o7yTt/Nt1dvj32dYgtpCCeAY7OULXdLKRjGiyi+zlomDldd6vqA66iXdMN8qr
         W+Dg+BnXZOrOS/kITpB7JYeb2HWE55ayT2RFjAOjjGlF5FWp3zNU/6eRbJ0cohTvUViy
         OEbw==
X-Gm-Message-State: APjAAAWs9LtI5Kq27qUMjtp9IjJGSWm3GfvR8SzBfhyfcPqNVMnxoXge
        fot0buwqZGO3uSTh3lXcEMSwCg==
X-Google-Smtp-Source: APXvYqzZFLdsJYh/nYkprlhVc2JM/scvZttYFUDoyg0Z96t976Sgj1hMwEjczoWVDkoZZ4/GPU9t4w==
X-Received: by 2002:a25:c6d0:: with SMTP id k199mr821628ybf.153.1567654082472;
        Wed, 04 Sep 2019 20:28:02 -0700 (PDT)
Received: from jaxon.wireless.duke.edu ([152.3.43.42])
        by smtp.gmail.com with ESMTPSA id l40sm201908ywk.79.2019.09.04.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 20:28:01 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     jasowang@redhat.com, kishon@ti.com, mst@redhat.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Wed,  4 Sep 2019 23:28:01 -0400
Message-Id: <20190905032801.11138-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <59982499-0fc1-2e39-9ff9-993fb4dd7dcc@redhat.com>
References: <59982499-0fc1-2e39-9ff9-993fb4dd7dcc@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you so much for the detailed explanation!

On Wed, Sep 4, 2019 at 10:56 PM Jason Wang <jasowang@redhat.com> wrote:
> Let me explain:
> 
> - I'm not suggesting to use vhost_net since it can only deal with
> userspace virtio rings.
> - I suggest to introduce netdev that has vringh vring assoticated.
> Vringh was designed to deal with virtio ring located at different types
> of memory. It supports userspace vring and kernel vring currently, but
> it should not be too hard to add support for e.g endpoint device that
> requires DMA or whatever other method to access the vring. So it was by
> design to talk directly with e.g kernel virtio device.
> - In your case, you can read vring address from virtio config space
> through endpoint framework and then create vringh. It's as simple as:
> creating a netdev, read vring address, and initialize vringh. Then you
> can use vringh helper to get iov and build skb etc (similar to caif_virti=
> o).

You are right. It's easy to set up corresponding vringh's.

> The differences is.
> - Complexity: In your proposal, there will be two virtio devices and 4
> virtqueues. It means you need to prepare two sets of features, config
> ops etc. And dealing with inconsistent feature will be a pain. It may
> work for simple case like a virtio-net device with only _F_MAC, but it
> would be hard to be expanded. If we decide to go for vringh, there will
> be a single virtio device and 2 virtqueues. In the endpoint part, it
> will be 2 vringh vring (which is actually point the same virtqueue from
> Host side) and a normal network device. There's no need for dealing with
> inconsistency, since vringh basically sever as a a device
> implementation, the feature negotiation is just between device (network
> device with vringh) and driver (virtito-pci) from the view of Linux
> running on the PCI Host.
> - Maintainability: A third path for dealing virtio ring. We've already
> had vhost and vringh, a third path will add a lot of overhead when
> trying to maintaining them. My proposal will try to reuse vringh,
> there's no need a new path.

I also agree with this part. This is the more sustainable way to go also
because vringh is actively maintained together with virtio.

> not that hard as you imagine to have a new type of netdev, I suggest to
> take a look at how caif_virtio is done, it would be helpful.

This is the part where I had misunderstanding about. I would read how
caif_virtio use vringh to for networking stuff.

Again thank you for spending so much time and thought!

Haotian
