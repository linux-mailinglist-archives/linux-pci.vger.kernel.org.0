Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A988EA7513
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfICUjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 16:39:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38025 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfICUjk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 16:39:40 -0400
Received: by mail-yw1-f65.google.com with SMTP id f187so6409845ywa.5
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2019 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfJtr3HmMw+Qly0P03/i6uDrpUIh5pdiVIES/f8cDk0=;
        b=Y1jXofh98eoI4QnlVUJGxaeWEYYsZuTIiTLlAIHAvdLlejKeBRg8dIv121nwF1zQbw
         pX5r0FWYgk7/KovGPhLPmiyO6P8AejdlFtng1qLslLaIOyo/X+SF6KagfJpxUB0PUJD7
         QkjcVgq1Kn8yfS8JhT+yUssmqHYLvh404X+MQinXxGA1wkBbWBkw1p+2w2tCtp4nVVgH
         AkCHCo8g7a2Kj7oatMWQM/3ActCG/J9Qm/peEPRFjriMuAex79LC7pyHXLkgsIFtGzfs
         zwcFFmP+KSIXHDLT3u5JFHjwsgi3G4dTRC0kWFRMsbAd7/ndtUkPpufXSDMq9bdKW+WC
         bGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfJtr3HmMw+Qly0P03/i6uDrpUIh5pdiVIES/f8cDk0=;
        b=XG5XZ/GahFmycBaVoT2jPXMJdZ0qZLd3fzWPN/INckPS7MU1ZWRjzwUOXApJipGAir
         Es4QXOx/9pXlphGRpydyVpzyD+Jqd4xakGUJvW2MXI2I7sEM/FoL4aHjR+B/I5M4f13L
         MS0m6FQlSDIx7ySGEDxOOJH6PYaFjJPyCYzhZdR8B97PpyyfAEoQNuYSHjnW7LFsbiB2
         Y7r9jnAo9z+oBy2vlQrmUBLycvFUN5KhTuf+yl/hTO48y5uYgXG14B76DEsBE5TczgOx
         vkd7FqY6wOHNulLaNckydPncccFa1fGc1oH3aqq0IlNkBrWxbtBPEVGW/V6TU3dTRTqA
         1ZIA==
X-Gm-Message-State: APjAAAUGddPg7adFgnlv1yA1gmuE01gwpmb+c1YcVNJnKceg96FuNbx/
        Wl5G74N7UKCgh0YO5/VgttJlzw==
X-Google-Smtp-Source: APXvYqxh9ovvF6bd5vAouWG17SOe1WwopPzetWOwQXC8fhMfYVl5xl0aHJaeretnKRwgEs5JoKyFjQ==
X-Received: by 2002:a0d:c5c6:: with SMTP id h189mr25709529ywd.274.1567543179399;
        Tue, 03 Sep 2019 13:39:39 -0700 (PDT)
Received: from jaxon.wireless.duke.edu ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id w123sm1454843yww.22.2019.09.03.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:39:38 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     mst@redhat.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jasowang@redhat.com
Cc:     linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Tue,  3 Sep 2019 16:39:38 -0400
Message-Id: <20190903203938.899-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903021403-mutt-send-email-mst@kernel.org>
References: <20190903021403-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

Thank you for your feedback!

On Tue, Sep 3, 2019 at 2:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Aug 23, 2019 at 02:31:45PM -0700, Haotian Wang wrote:
> > This endpoint function enables the PCI endpoint to establish a virtual
> > ethernet link with the PCI host. The main features are:
> > 
> > - Zero modification of PCI host kernel. The only requirement for the
> >   PCI host is to enable virtio, virtio_pci, virtio_pci_legacy and
> >   virito_net.
> 
> Do we need to support legacy? Why not just the modern interface?
> Even if yes, limiting device
> to only legacy support is not a good idea.

I absolutely agree with you on modern interfaces being better. The issue
here is that I did not support legacy because of compatibility reasons
but because I was forced to choose legacy.

In the summer, I asked the hardware team whether I had read-write access
to the capabilities registers from the endpoint but did not receive a
response back then.

Now I can write the code using modern virtio but I cannot easily verify
the epf will actually function on the hardware.

Reading and writing of capabilities list registers requires patches to
the pci endpoint framework and the designware endpoint controller as
well. I will probably work on that after I resolve these other issues.

> > +	if (!atomic_xchg(pending, 0))
> > +		usleep_range(check_queues_usec_min,
> > +			     check_queues_usec_max);
> 
> What's the usleep hackery doing? Set it too low and you
> waste cycles. Set it too high and your latency suffers.
> It would be nicer to just use a completion or something like this.

If the pending bit is set, the kthread will go directly into another
round. The usleep is here because, in case the pending bit is not set,
the kthread waits a certain while and then checks for buffers anyway as
a sort of "fallback" check.

Problem with completion is that there is no condition to complete on. I
can change the usleep_range() to schedule() if that is a more sensible
thing to do.

If you mean wait until the pending bit is set, I can do that. Back when
I wrote this module, the reason for not doing that was the endpoint
might fail to catch notification from the host.

If you are interested, here is a more detailed expanation.

> > +static int pci_epf_virtio_catch_notif(void *data)
> > +{
> > +	u16 changed;
> > +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> > +	void __iomem *avail_idx;
> > +	u16 event;
> > +#endif
> > +
> > +	register const __virtio16 default_notify = epf_cpu_to_virtio16(2);
> > +
> > +	struct pci_epf_virtio *const epf_virtio = data;
> > +	atomic_t *const pending = epf_virtio->pending;
> > +
> > +	while (!kthread_should_stop()) {
> > +		changed = epf_virtio16_to_cpu(epf_virtio->legacy_cfg->q_notify);
> > +		if (changed != 2) {
> > +			epf_virtio->legacy_cfg->q_notify = default_notify;
> > +			/* The pci host has made changes to virtqueues */
> > +			if (changed)
> > +				atomic_cmpxchg(pending, 0, 1);
> > +#ifdef CONFIG_PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> > +			avail_idx = IO_MEMBER_PTR(epf_virtio->avail[changed],
> > +						  struct vring_avail,
> > +						  idx);
> > +			event = epf_ioread16(avail_idx) + event_suppression;
> > +			write_avail_event(epf_virtio->used[changed], event);
> > +#endif
> > +		}
> > +		usleep_range(notif_poll_usec_min,
> > +			     notif_poll_usec_max);
> > +	}
> > +	return 0;
> > +}

The pending bit is set if the notification polling thread sees a value
in legacy_cfg->q_notify that is not 2, because the PCI host virtio_pci
will write either 0 when its rx queue consumes something or 1 if its tx
queue has offered a new buffer. My endpoing function will then set that
value back to 2. In this process there are numerous things that can go
wrong.

The host may write multiple 0 or 1's and the endpoint can only
detect one of them in an notif_poll usleep interval.

The host may write
some non-2 value as the endpoint code just finishes detecting the last
non-2 value and reverting that value back to 2, effectively nullifying
the new non-2 value.

The host may decide to write a non-2 value
immediately after the endpoint revert that value back to 2 but before
the endpoint code finishes the current loop of execution, effectively
making the value not reverted back to 2.

All these and other problems are made worse by the fact that the PCI
host Linux usually runs on much faster cores than the one on PCI
endpoint. This is why relying completely on pending bits is not always
safe. Hence the "fallback" check using usleep hackery exists.
Nevertheless I welcome any suggestion, because I do not like this
treatment myself either.

> > +	net_cfg->max_virtqueue_pairs = (__force __u16)epf_cpu_to_virtio16(1);
> 
> You don't need this without VIRTIO_NET_F_MQ.

Noted.

Best,
Haotian
