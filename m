Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D27AA812
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 18:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfIEQPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 12:15:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46264 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIEQPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 12:15:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id 201so963246ywo.13
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXZGe/GMm1AP9tqn/kRJhU+fbFG+dBRvZ/JuzgZ9dAo=;
        b=N9omsp7NCyKR+GZ4pgi8H30MeCim15w3VkiGjIMy4ljy/KwkU4MFduXrRg7xpnJPyF
         BHctIYbQqySBxCk6RNa/ZxQ6p3wsSth4KvvEiVUsINkeCmwbqxZL/ostbY2gf2b9CKLg
         Vn4OhTdkTIj/DvvCQRaZgulyBCn72gNH8Zkal7Uc9naOSiVUvfHHGlF/RwUoQjids+V4
         HInV6Durvglx1OvfLs0eH7SttZ3wcZQVVuPMiRjA/LR/xVT4rnhfpkl1af5g9TVMA0Dy
         yyVVBpwYfazjByU7zx2AYM85aiIvxeYShULf8fZi5C27GMHz5d5adzuJRtz0FGCTf3ys
         Jprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXZGe/GMm1AP9tqn/kRJhU+fbFG+dBRvZ/JuzgZ9dAo=;
        b=pMRBQr/T2H281yFgRMQ8E88JW7kiVAtoKpRdDDIcTNjks9u3/iMgyituzdIyjJIIIw
         C2ivVnZZ+mr+koFMIZXrLv3v/kd6nS6ZPHANO63GRTNo+kwK5wCiMrMdZae9bUjG9QRN
         wMdHi1uASAi9RM/o27om4a1Qy8TKYDw0sLYn3FGhAq571VdYU4in/vYVx4hdwLgsHWM8
         oP3qP4ytKcaUgLm4I+1tMqCZdFEVypOYsrs/L3FcfhLsoD5Epc/7Jrq5M5jEPHQIOtK5
         mdpWgSLNUOFEYpPdMDGAnF1vpxn0Hh2/BhFhveUVyBGpAk4Cj2TEf7VYbbHEtww/fE78
         w8hw==
X-Gm-Message-State: APjAAAWnyZMfe5w5le4kELOtJddzgJ2MYDk30LA0l2/bRXLZh5UfUR3I
        YVO+/T7xTMKbPOqlEyHsqpz8ew==
X-Google-Smtp-Source: APXvYqyG5gYmd4gdk9cp1NnCY0cEEKQpGbyOz5hp+kGb0CXwR0NcO5DwgzcwFRrFcc7vZay1SahyVg==
X-Received: by 2002:a81:99c1:: with SMTP id q184mr3087072ywg.70.1567700118360;
        Thu, 05 Sep 2019 09:15:18 -0700 (PDT)
Received: from jaxon.wireless.duke.edu ([152.3.43.45])
        by smtp.gmail.com with ESMTPSA id q128sm549266ywe.75.2019.09.05.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:15:17 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     mst@redhat.com, jasowang@redhat.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     haotian.wang@duke.edu, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Thu,  5 Sep 2019 12:15:16 -0400
Message-Id: <20190905161516.2845-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190905025823-mutt-send-email-mst@kernel.org>
References: <20190905025823-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 5, 2019 at 3:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > The host may write multiple 0 or 1's and the endpoint can only
> > detect one of them in an notif_poll usleep interval.
> 
> Right. Notifications weren't designed to be implemented on top of RW
> memory like this: the assumption was all notifications are buffered.

I can implement notification as a counter instead of a pending bit to
simulate a buffer. There will be many troublesome cases illustrated by
the following example.

The host sends a notification about available buffers 0-3. The endpoint
will probably consume buffers 0-5 as the notification is polled and
there is a delay. Then for some following notifications, the endpoint
may realize there are no corresponding available buffers to consume.
Those useless function calls waste cycles.

> So if you implement modern instead, different queues can use
> different addresses.

Will start working on this after switching the endpoint to using
vringh.c.

> > The host may write
> > some non-2 value as the endpoint code just finishes detecting the last
> > non-2 value and reverting that value back to 2, effectively nullifying
> > the new non-2 value.
> > 
> > The host may decide to write a non-2 value
> > immediately after the endpoint revert that value back to 2 but before
> > the endpoint code finishes the current loop of execution, effectively
> > making the value not reverted back to 2.
> > 
> > All these and other problems are made worse by the fact that the PCI
> > host Linux usually runs on much faster cores than the one on PCI
> > endpoint. This is why relying completely on pending bits is not always
> > safe. Hence the "fallback" check using usleep hackery exists.
> > Nevertheless I welcome any suggestion, because I do not like this
> > treatment myself either.
> 
> As long as you have a small number of queues, you can poll both
> of them. And to resolve racing with host, re-check
> rings after you write 2 into the selector

I assume your suggestion is based on modern virtio. vrings in legacy
virtio share a common notification read-write area.

> (btw you also need a bunch of memory barriers, atomics don't
> imply them automatically).

Thank you for the reminder. In this doc,
https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html, it says
"atomic_cmpxchg must provide explicit memory barriers around the operation,
although if the comparison fails then no memory ordering guarantees are
required". My understanding of this sentence is that the arch-specific
implementer of atomic_cmpxchg already surrounds the operation with
barriers in a more efficient way. The second part of the sentence
implies the doc's target audience is the implementer of atomic_cmpxchg.
Please correct me if I misunderstand this doc.

Thank you for your feedback.

Best,
Haotian
