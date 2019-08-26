Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACE9D8C4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfHZWAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 18:00:00 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32960 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfHZWAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 18:00:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id e65so7197309ywh.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2019 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MH7CkXPMaalnbkeMAiiA9YYT70nqAt4qD2eh1omxYuQ=;
        b=Z0UhKiV4gMrPhcxtntVjAyBoTq9eE/z+eXN1gArLSrYH12kc5ei3b3asSCuPYAyZO4
         WCmVyxKLfmcZbQZX5frZbkLIOQ+w6wfAP3ZE/QFjv4jsOAaTsyac+SVXxUMMRg45SGd8
         ZM+RMHpXVZj2ttiutlPiTjPyJhaXsiqkbPzJrAOqbfb+u174f1Hfw7ysl4ASAPbtw/gk
         VTMIH3a7jQqY6I6bKXkeZf2X31Qb4ja3shc+C8mHqwRUtH3UpxiR6dP15n1uEDpyas5w
         90j3bsJrLtDRC6+g3+4Og4sLwVcR7ZJpwouAW4CF26iN4o6Cit+paeNip4qAmpycPiwY
         MXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MH7CkXPMaalnbkeMAiiA9YYT70nqAt4qD2eh1omxYuQ=;
        b=tSKt8CLvq563ttDpKjDzhjRIvQy4BcUM36Bx3oII6Ramw1+f6Mjb+5v2rrJjjUsoFa
         DeCpfLlfsI5XC8rXuJ64dMid49CgXbngF/n7Zkg3vpVJdlGI8pRY87q7jS3wAbw2wf/t
         Wu6laGF0FJJADBMtkFyacOzD7ww9cUflItaVhL6cyeEoODUVhuYdXKD+ruAzG+LC9R+U
         Z9SaELKmO+ukQ6cas4IHiSriXSidlxyBtfkGwJ4kgRb9MIKyL2mWZV+ct1Y3gPrvxwsV
         IrHe212a7FoMbRec05U+kosgtOLybSQnM1lfZjXNilpAfUokxmXPYVsv8Sv5H0I47Job
         ij3A==
X-Gm-Message-State: APjAAAWvwNCePHq8FJ6tjdsatuv4x/sMl+cFLrvCirn/MZT0GHrZCzx7
        NWNbJbVVvNZg8/sQRnR9JwUbAQ==
X-Google-Smtp-Source: APXvYqx4oJCCn2w5CfAAxHw4uOOVph4KZI4kasWIRxtZDeEtDb/LuN8VM2KG91h6fCtJg9lHpysf3A==
X-Received: by 2002:a81:5c87:: with SMTP id q129mr13635750ywb.403.1566856799182;
        Mon, 26 Aug 2019 14:59:59 -0700 (PDT)
Received: from jaxon.wireless.duke.edu ([152.3.43.42])
        by smtp.gmail.com with ESMTPSA id d15sm2668070ywa.34.2019.08.26.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 14:59:58 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     haotian.wang@sifive.com, haotian.wang@duke.edu, mst@redhat.com,
        jasowang@redhat.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Mon, 26 Aug 2019 17:59:57 -0400
Message-Id: <20190826215957.6430-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <c656fd34-68b1-46d9-38e4-c77138d3604f@ti.com>
References: <c656fd34-68b1-46d9-38e4-c77138d3604f@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Thank you so much for the reply!

On Mon, Aug 26, 2019 at 6:51 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > This function driver is tested on the following pair of systems. The PCI
> > endpoint is a Xilinx VCU118 board programmed with a SiFive Linux-capable
> > core running Linux 5.2. The PCI host is an x86_64 Intel(R) Core(TM)
> > i3-6100 running unmodified Linux 5.2. The virtual link achieved a
> > stable throughput of ~180KB/s during scp sessions of a 50M file. The
> 
> I assume this is not using DMA as below you mentioned you got worse throughput
> with DMA. What's the throughput using DMA?
From host to endpoint, scp speed was 180KB/s without dma and 130KB/s
with dma. From endpoint to host, scp speed was 220KB/s without dma and
150KB/s. My guess for the causes of lower throughput when dma is used is
that there the two major reasons. Firstly, the platform dma
implementation of the hardware I used was pretty new. It had many
inefficient algorithms. Secondly, the dma transfer function of pci-epf
seems to make blocking calls. In the pci_epf_tx() function,
pci_epf_data_transfer() is called. pci_epf_data_transfer will wait on
completion of the dma transfer. Since pci_epf_data_transfer runs on the
same kernel thread as the main function that handles endpoint to
host transfer in pci_epf_virtio, every packet that gets transferred via
dma still blocks the thread for the duration of transfer. This sort of
defeats the purpose of dma.

There was actually a critical error I made about dma in the patch. The
dma patch to the endpoint framework,
http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/drivers/pci/endpoint/pci-epf-core.c?h=ti-linux-4.19.y,
has not been merged into the upstream kernel yet. dma related code
should not appear in this version of the patch. I apologize for this
mistake.

> At a high level, you need more layering as it'll help to add more virtio based
> devices over PCIe. Ideally all the vring/virtqueue part should be added as a
> library.
> 
> You've modeled the endpoint side as virtio_device. However I would have
> expected this to be vhost_dev and would have tried re-using some parts of 
> vhost (ignoring the userspace part). Was this considered during your design?
Thank you for the suggestion about more layering. I have thought about
that. virtio has done a very good job of separating out
function-specific drivers (virtio_net etc.), vring/virtqueue setup
(virtio_pci) and actual data transfer (virtio_ring). Thus in this
endpoint function, I can easily set up a remote virtio_device
representing the PCI host and a local virtio_device representing the
endpoint itself. The difficulty lies in actual transfer of data. For
example, virtio_net and virtio_blk use very different transfer
mechanisms. The best I can do now is probably abstracting out the setup
phase as a library of some sort.

I haven't taken a close look at vhost. Using virtio_device was mainly
because I did not change the code on the PCI host side, therefore using
the same structs as virtio_pci and virtio_ring made it easy to access
data structures on the PCI host from the endpoint. Another reason is
that in this endpoint function, the use case of virtio_device was not
entirely the same as that of kvm/qemu. Instead, this was probably closer
to what veth did, in that it established a connection between a pair of
virtio_devices. So far virtio_device has served the purpose well and I
could reuse a lot of code from virtio.

> Please add the Documentation as a separate patch.
Should I submit that as a different patch in the same patch series or a
totally different patch? Thanks!

> > +	CONFIG_VIRTIO
> > +	CONFIG_VIRTIO
> 
> ^^redundant line.
Will fix.

> > +CONFIG_PCI_HOST_LITTLE_ENDIAN must be set at COMPILE TIME. Toggle it on to build
> > +the module with the PCI host being in little endianness.
> It would be better if we could get the endianness of the host at runtime. That
> way irrespective of the host endianness we could use the same kernel image in
> endpoint.
There are two ways I can imagine of achieving this. The first is to
change the whole endpoint function into using modern virtio interfaces,
because those specify little endianness to be used in all of __virtio16,
__virtio32 etc. I didn't take that path because the development platform
did not allow me to access some PCI configuration space registers, such
as the vendor-specific capabilities. These were required to configure a
virtio_device representing the PCI host.

The second way is to add a module parameter for host endianness. The
user has to make sure that module parameter is setup correctly before
this endpoint function calls linkup() though.

> > +Enable PCI_ENDPOINT_DMAENGINE if your endpoint controller has an implementation
> 
> Presence of dma engine could come from epc_features. Or try to get dma channel
> always and use mem_copy if that fails. config option for dmaengine looks
> un-necessary.
This ties back to the previous point of the unmerged dma patch. The
correct way to implement dma depends on that patch.

> > +config PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
> > +	bool "PCI Virtio Endpoint Function Notification Suppression"
> > +	default n
> > +	depends on PCI_EPF_VIRTIO
> > +	help
> > +	  Enable this configuration option to allow virtio queues to suppress
> > +	  some notifications and interrupts. Normally the host and the endpoint
> > +	  send a notification/interrupt to each other after each packet has been
> > +	  provided/consumed. Notifications/Interrupts can be generally expensive
> > +	  across the PCI bus. If this config is enabled, both sides will only
> > +	  signal the other end after a batch of packets has been consumed/
> > +	  provided. However, in reality, this option does not offer significant
> > +	  performance gain so far.
> 
> Would be good to profile and document the bottle-neck so that this could be
> improved upon.
I have a theory for this. The only real "interrupt" is from the
endpoint to host. The "notification" from the host to endpoint is
actually enabled by the endpoint continuously polling for a value in
BAR 0. When the host wants to notify the endpoint, it writes to an
offset in BAR 0 with the index of the virtqueue where an event just
occurs. The endpoint has a dedicated loop that monitors when that value.
Because of this setup, making the host send fewer notifications does not
help because the bottleneck is probably in the expensive polling on the
endpoint. As a consequence, suppressing notification and interrupts does
not seem to offer performance gain.

> > +/* Default bar sizes */
> > +static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> 
> Only use the BARs actually required by the function.
Will do.

> > +/*
> > + * Clear mapped memory of a map. If there is memory allocated using the
> > + * pci-ep framework, that memory will be released.
> > + *
> > + * @map: a map struct pointer that will be unmapped
> > + */
> > +static void pci_epf_unmap(struct pci_epf_map *map)
> > +{
> > +	if (map->iobase) {
> 
> how about this instead..
> 	if (!map->iobase)
> 		return;
Sure.

> > +	align = map->align;
> > +	iosize = (align > PAGE_SIZE && size < align) ? align : size;
> 
> The align parameter should already be configured correctly by epc_features and
> the size should be already handled by pci_epc_mem_alloc_addr().
This "align" is exactly the same as the align from epc_features. This
line of code actually proved necessary in my development platform. The
epc mem allocator only makes sure the memory allocated is aligned but it
fails to operate on PCI host memory that is not properly aligned. The
endpoint device I developed on had a disastrous 64K page size. When
reading from a physical memory address on the PCI host, the lower 16
bits of the memory address were all zeroed out. For example, when the
endpoint tried to read the byte at 0x12345 (a phys_addr_t) on the PCI
host, what it actually read was the byte at 0x10000. Because of this, I
had to potentially allocate a much larger space than asked for. If
wanted to access 0x12345, after mapping, map->phys_iobase would be
0x10000, map->phys_ioaddr would be 0x12345, and a whole 64K memory
region would be allocated.

> This looks unnecessary.
See above.

> > +/*
> > + * Get value from the virtio network config of the local virtio device.
> > + *
> > + * @vdev: local virtio device
> > + * @offset: offset of starting memory address from the start of local
> > + *	    virtio network config in bytes
> > + * @buf: virtual memory address to store the value
> > + * @len: size of requested data in bytes
> > + */
> > +static inline void epf_virtio_local_get(struct virtio_device *vdev,
> > +					unsigned int offset,
> > +					void *buf,
> > +					unsigned int len)
> > +{
> > +	memcpy(buf,
> > +	       (void *)&vdev_to_epf_vdev(vdev)->local_net_cfg + offset,
> > +	       len);
> > +}
> 
> Have all this network specific parts in a separate file. Use the layering
> structure similar to vhost.
Will try to do.

> > +/*
> > + * Initializes the virtio_pci and virtio_net config space that will be exposed
> > + * to the remote virtio_pci and virtio_net modules on the PCI host. This
> > + * includes setting up feature negotiation and default config setup etc.
> > + *
> > + * @epf_virtio: epf_virtio handler
> > + */
> > +static void pci_epf_virtio_init_cfg_legacy(struct pci_epf_virtio *epf_virtio)
> > +{
> > +	const u32 dev_feature =
> > +		generate_dev_feature32(features, ARRAY_SIZE(features));
> > +	struct virtio_legacy_cfg *const legacy_cfg = epf_virtio->reg[BAR_0];
> 
> virtio_reg_bar instead of BAR_0
The dilemma was that the virtio_pci on PCI host will only write to BAR
0. I may need to throw an error if the first free bar is not BAR 0.

> > +	pci_epc_stop(epc);
> 
> You should never have pci_epc_stop() in function driver as that will break
> multi-function endpoint devices. I'll fix this in pci-epf-test.c.
Look forward to your progress on this.

> > +	for (bar = BAR_0; bar <= BAR_5; bar += add) {
> 
> Are you using all these BARs? It's best to allocate and initialize the BARs we use.
Will only use BAR 0 instead.

> Please add a description for each of these structures.
I had to copy these structures exactly as they were from virtio_ring.c
unfortunately, because they were not exposed via any header file. If
virtio_ring.c has some struct changes, this endpoint function will have
to change accordingly.

Thank you so much for taking time to review this patch. Now that I came
back to university and continued my undergrad study, my kernel
development work will probably slow down a lot. The heavy-lifting work
such as creating more layers to allow more virtio devices will take a
much longer time.

Best,
Haotian
