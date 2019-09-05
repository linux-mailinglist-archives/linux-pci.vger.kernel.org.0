Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B198FA9B26
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfIEHHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 03:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbfIEHHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 03:07:23 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C32E581F22
        for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2019 07:07:22 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id o34so1441248qtf.22
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 00:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8m99Y8gQoNecA4vYCpQNwSISspOY7Jl4iaZpC5WC0QM=;
        b=gH+xmrAPe/9F6Z5MyJSsyQG6Sfo+ARKlCmepAaMdvtsl7nsKY80A/lmxz0W+l++Hk0
         ZZ97ZCI46tGtEQUW+FcWMPW9S4Srv+L2HQYdDAdFOSGwswx5nP/hk9UWEyvKZLayIX8P
         xcx1XjiDU0NpPj9Nn9WYXyfRjMOBswS7csG21t8c3t4Df5PHG/2vGMI8eqSQalejtAvT
         rS9oqFeGSrlEvSUmWITsSy5WqtwmVO1MDcAtdXy0XsUHOicSpaKocGS9xQF5n7ZtmE+j
         lT8VqDyL2HtTMFLt5z1Xj1ls2vOmWmy56WBWnp9Xm3D1srInMSdrq02KAkdYXCk7hN+7
         OgFA==
X-Gm-Message-State: APjAAAVHrRmwjOAn3XjEqufjooCNwLP47XPdWhyONicZsgKdZ3ubBg4y
        8BL879QiuSP7Q5JlI6ZFuV/FJyPDQxEbpiXrnoV1B8ziw84EP6YYtGKDTo6NzIGDvajugjUN/q6
        XXC2YhVUpcsQn+TCpz5s1
X-Received: by 2002:a37:ad0f:: with SMTP id f15mr1381073qkm.398.1567667242118;
        Thu, 05 Sep 2019 00:07:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTtnd1Z5rCYyb1aLL17itHUvWvEREAo+8czA0grp0cVB2paeah3PHMmdS2xa03iw1olD4WQQ==
X-Received: by 2002:a37:ad0f:: with SMTP id f15mr1381050qkm.398.1567667241828;
        Thu, 05 Sep 2019 00:07:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id m92sm664749qte.50.2019.09.05.00.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:07:20 -0700 (PDT)
Date:   Thu, 5 Sep 2019 03:07:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Haotian Wang <haotian.wang@sifive.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jasowang@redhat.com, linux-pci@vger.kernel.org,
        haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Message-ID: <20190905025823-mutt-send-email-mst@kernel.org>
References: <20190903021403-mutt-send-email-mst@kernel.org>
 <20190903203938.899-1-haotian.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903203938.899-1-haotian.wang@sifive.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 04:39:38PM -0400, Haotian Wang wrote:
> Hi Michael,
> 
> Thank you for your feedback!
> 
> On Tue, Sep 3, 2019 at 2:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Aug 23, 2019 at 02:31:45PM -0700, Haotian Wang wrote:
> > > This endpoint function enables the PCI endpoint to establish a virtual
> > > ethernet link with the PCI host. The main features are:
> > > 
> > > - Zero modification of PCI host kernel. The only requirement for the
> > >   PCI host is to enable virtio, virtio_pci, virtio_pci_legacy and
> > >   virito_net.
> > 
> > Do we need to support legacy? Why not just the modern interface?
> > Even if yes, limiting device
> > to only legacy support is not a good idea.
> 
> I absolutely agree with you on modern interfaces being better. The issue
> here is that I did not support legacy because of compatibility reasons
> but because I was forced to choose legacy.
> 
> In the summer, I asked the hardware team whether I had read-write access
> to the capabilities registers from the endpoint but did not receive a
> response back then.
> 
> Now I can write the code using modern virtio but I cannot easily verify
> the epf will actually function on the hardware.
> 
> Reading and writing of capabilities list registers requires patches to
> the pci endpoint framework and the designware endpoint controller as
> well. I will probably work on that after I resolve these other issues.
> 
> > > +	if (!atomic_xchg(pending, 0))
> > > +		usleep_range(check_queues_usec_min,
> > > +			     check_queues_usec_max);
> > 
> > What's the usleep hackery doing? Set it too low and you
> > waste cycles. Set it too high and your latency suffers.
> > It would be nicer to just use a completion or something like this.
> 
> If the pending bit is set, the kthread will go directly into another
> round. The usleep is here because, in case the pending bit is not set,
> the kthread waits a certain while and then checks for buffers anyway as
> a sort of "fallback" check.
> 
> Problem with completion is that there is no condition to complete on. I
> can change the usleep_range() to schedule() if that is a more sensible
> thing to do.
> 
> If you mean wait until the pending bit is set, I can do that. Back when
> I wrote this module, the reason for not doing that was the endpoint
> might fail to catch notification from the host.
> 
> If you are interested, here is a more detailed expanation.


So the below basically means the communication is racy.
Yes using timers help recover from that, but in
a way that is very expensive, and will also lead
to latency spikes.

> > > +static int pci_epf_virtio_catch_notif(void *data)
> > > +{
> > > +	u16 changed;
> > > +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> > > +	void __iomem *avail_idx;
> > > +	u16 event;
> > > +#endif
> > > +
> > > +	register const __virtio16 default_notify = epf_cpu_to_virtio16(2);
> > > +
> > > +	struct pci_epf_virtio *const epf_virtio = data;
> > > +	atomic_t *const pending = epf_virtio->pending;
> > > +
> > > +	while (!kthread_should_stop()) {
> > > +		changed = epf_virtio16_to_cpu(epf_virtio->legacy_cfg->q_notify);
> > > +		if (changed != 2) {
> > > +			epf_virtio->legacy_cfg->q_notify = default_notify;
> > > +			/* The pci host has made changes to virtqueues */
> > > +			if (changed)
> > > +				atomic_cmpxchg(pending, 0, 1);
> > > +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> > > +			avail_idx = IO_MEMBER_PTR(epf_virtio->avail[changed],
> > > +						  struct vring_avail,
> > > +						  idx);
> > > +			event = epf_ioread16(avail_idx) + event_suppression;
> > > +			write_avail_event(epf_virtio->used[changed], event);
> > > +#endif
> > > +		}
> > > +		usleep_range(notif_poll_usec_min,
> > > +			     notif_poll_usec_max);
> > > +	}
> > > +	return 0;
> > > +}
> 
> The pending bit is set if the notification polling thread sees a value
> in legacy_cfg->q_notify that is not 2, because the PCI host virtio_pci
> will write either 0 when its rx queue consumes something or 1 if its tx
> queue has offered a new buffer. My endpoing function will then set that
> value back to 2. In this process there are numerous things that can go
> wrong.
> 
> The host may write multiple 0 or 1's and the endpoint can only
> detect one of them in an notif_poll usleep interval.

Right. Notifications weren't designed to be implemented on top of RW
memory like this: the assumption was all notifications are buffered.
So if you implement modern instead, different queues can use
different addresses.

> 
> The host may write
> some non-2 value as the endpoint code just finishes detecting the last
> non-2 value and reverting that value back to 2, effectively nullifying
> the new non-2 value.
> 
> The host may decide to write a non-2 value
> immediately after the endpoint revert that value back to 2 but before
> the endpoint code finishes the current loop of execution, effectively
> making the value not reverted back to 2.
> 
> All these and other problems are made worse by the fact that the PCI
> host Linux usually runs on much faster cores than the one on PCI
> endpoint. This is why relying completely on pending bits is not always
> safe. Hence the "fallback" check using usleep hackery exists.
> Nevertheless I welcome any suggestion, because I do not like this
> treatment myself either.

As long as you have a small number of queues, you can poll both
of them. And to resolve racing with host, re-check
rings after you write 2 into the selector
(btw you also need a bunch of memory barriers, atomics don't
imply them automatically).


> > > +	net_cfg->max_virtqueue_pairs = (__force __u16)epf_cpu_to_virtio16(1);
> > 
> > You don't need this without VIRTIO_NET_F_MQ.
> 
> Noted.
> 
> Best,
> Haotian
