Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A339E18C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfH0INE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 04:13:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33032 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbfH0IND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 04:13:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R8CtEC128784;
        Tue, 27 Aug 2019 03:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566893575;
        bh=SLAIqNpEdbSDH7lO/i55t89ktWWB0Od2Ze/0NTinkbU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nYNIx2uoqJ+YCXeL6zALrjfYliXnZ69ZSOAnvSnynvKrVBprVJjaV+H74O7j0X8Lf
         BAwvFWeIRbimqvNXjTOm+zzQyQeUEeN+5mGr5DgahtrCNYVisqC0VnrG+0/W3RGkko
         pFMjxiF9hDLd9GlACWjJIBXuMz9mh6K1YfcdCwes=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R8Cteq082930
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 03:12:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 03:12:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 03:12:54 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R8CpW8125622;
        Tue, 27 Aug 2019 03:12:52 -0500
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <haotian.wang@duke.edu>, <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-pci@vger.kernel.org>
References: <c656fd34-68b1-46d9-38e4-c77138d3604f@ti.com>
 <20190826215957.6430-1-haotian.wang@sifive.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <442f91a5-be7f-c4c2-dd24-81c510aab86b@ti.com>
Date:   Tue, 27 Aug 2019 13:42:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826215957.6430-1-haotian.wang@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Haotian Wang,

On 27/08/19 3:29 AM, Haotian Wang wrote:
> Hi Kishon,
> 
> Thank you so much for the reply!
> 
> On Mon, Aug 26, 2019 at 6:51 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> This function driver is tested on the following pair of systems. The PCI
>>> endpoint is a Xilinx VCU118 board programmed with a SiFive Linux-capable
>>> core running Linux 5.2. The PCI host is an x86_64 Intel(R) Core(TM)
>>> i3-6100 running unmodified Linux 5.2. The virtual link achieved a
>>> stable throughput of ~180KB/s during scp sessions of a 50M file. The
>>

> 
> I haven't taken a close look at vhost. Using virtio_device was mainly
> because I did not change the code on the PCI host side, therefore using
> the same structs as virtio_pci and virtio_ring made it easy to access
> data structures on the PCI host from the endpoint. Another reason is
> that in this endpoint function, the use case of virtio_device was not
> entirely the same as that of kvm/qemu. Instead, this was probably closer
> to what veth did, in that it established a connection between a pair of
> virtio_devices. So far virtio_device has served the purpose well and I
> could reuse a lot of code from virtio.
> 
>> Please add the Documentation as a separate patch.
> Should I submit that as a different patch in the same patch series or a
> totally different patch? Thanks!

You could add that as a different patch in the same patch series.
> 
>>> +	CONFIG_VIRTIO
>>> +	CONFIG_VIRTIO
>>
>> ^^redundant line.
> Will fix.
> 
>>> +CONFIG_PCI_HOST_LITTLE_ENDIAN must be set at COMPILE TIME. Toggle it on to build
>>> +the module with the PCI host being in little endianness.
>> It would be better if we could get the endianness of the host at runtime. That
>> way irrespective of the host endianness we could use the same kernel image in
>> endpoint.
> There are two ways I can imagine of achieving this. The first is to
> change the whole endpoint function into using modern virtio interfaces,
> because those specify little endianness to be used in all of __virtio16,
> __virtio32 etc. I didn't take that path because the development platform
> did not allow me to access some PCI configuration space registers, such
> as the vendor-specific capabilities. These were required to configure a
> virtio_device representing the PCI host.

I would prefer this approach.
Do you need any vendor specific capabilities for virtio_device?
> 
> The second way is to add a module parameter for host endianness. The
> user has to make sure that module parameter is setup correctly before
> this endpoint function calls linkup() though.
> 
>>> +Enable PCI_ENDPOINT_DMAENGINE if your endpoint controller has an implementation
>>
>> Presence of dma engine could come from epc_features. Or try to get dma channel
>> always and use mem_copy if that fails. config option for dmaengine looks
>> un-necessary.
> This ties back to the previous point of the unmerged dma patch. The
> correct way to implement dma depends on that patch.
> 
>>> +config PCI_EPF_VIRTIO_SUPPRESS_NOTIFICATION
>>> +	bool "PCI Virtio Endpoint Function Notification Suppression"
>>> +	default n
>>> +	depends on PCI_EPF_VIRTIO
>>> +	help
>>> +	  Enable this configuration option to allow virtio queues to suppress
>>> +	  some notifications and interrupts. Normally the host and the endpoint
>>> +	  send a notification/interrupt to each other after each packet has been
>>> +	  provided/consumed. Notifications/Interrupts can be generally expensive
>>> +	  across the PCI bus. If this config is enabled, both sides will only
>>> +	  signal the other end after a batch of packets has been consumed/
>>> +	  provided. However, in reality, this option does not offer significant
>>> +	  performance gain so far.
>>
>> Would be good to profile and document the bottle-neck so that this could be
>> improved upon.
> I have a theory for this. The only real "interrupt" is from the
> endpoint to host. The "notification" from the host to endpoint is
> actually enabled by the endpoint continuously polling for a value in
> BAR 0. When the host wants to notify the endpoint, it writes to an
> offset in BAR 0 with the index of the virtqueue where an event just
> occurs. The endpoint has a dedicated loop that monitors when that value.
> Because of this setup, making the host send fewer notifications does not
> help because the bottleneck is probably in the expensive polling on the
> endpoint. As a consequence, suppressing notification and interrupts does
> not seem to offer performance gain.
> 
>>> +/* Default bar sizes */
>>> +static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>>
>> Only use the BARs actually required by the function.
> Will do.
> 
>>> +/*
>>> + * Clear mapped memory of a map. If there is memory allocated using the
>>> + * pci-ep framework, that memory will be released.
>>> + *
>>> + * @map: a map struct pointer that will be unmapped
>>> + */
>>> +static void pci_epf_unmap(struct pci_epf_map *map)
>>> +{
>>> +	if (map->iobase) {
>>
>> how about this instead..
>> 	if (!map->iobase)
>> 		return;
> Sure.
> 
>>> +	align = map->align;
>>> +	iosize = (align > PAGE_SIZE && size < align) ? align : size;
>>
>> The align parameter should already be configured correctly by epc_features and
>> the size should be already handled by pci_epc_mem_alloc_addr().
> This "align" is exactly the same as the align from epc_features. This
> line of code actually proved necessary in my development platform. The
> epc mem allocator only makes sure the memory allocated is aligned but it
> fails to operate on PCI host memory that is not properly aligned. The
> endpoint device I developed on had a disastrous 64K page size. When
> reading from a physical memory address on the PCI host, the lower 16
> bits of the memory address were all zeroed out. For example, when the
> endpoint tried to read the byte at 0x12345 (a phys_addr_t) on the PCI
> host, what it actually read was the byte at 0x10000. Because of this, I
> had to potentially allocate a much larger space than asked for. If
> wanted to access 0x12345, after mapping, map->phys_iobase would be
> 0x10000, map->phys_ioaddr would be 0x12345, and a whole 64K memory
> region would be allocated.

All right. This is for aligning the host address.
> 
>> This looks unnecessary.
> See above.
> 
>>> +/*
>>> + * Get value from the virtio network config of the local virtio device.
>>> + *
>>> + * @vdev: local virtio device
>>> + * @offset: offset of starting memory address from the start of local
>>> + *	    virtio network config in bytes
>>> + * @buf: virtual memory address to store the value
>>> + * @len: size of requested data in bytes
>>> + */
>>> +static inline void epf_virtio_local_get(struct virtio_device *vdev,
>>> +					unsigned int offset,
>>> +					void *buf,
>>> +					unsigned int len)
>>> +{
>>> +	memcpy(buf,
>>> +	       (void *)&vdev_to_epf_vdev(vdev)->local_net_cfg + offset,
>>> +	       len);
>>> +}
>>
>> Have all this network specific parts in a separate file. Use the layering
>> structure similar to vhost.
> Will try to do.
> 
>>> +/*
>>> + * Initializes the virtio_pci and virtio_net config space that will be exposed
>>> + * to the remote virtio_pci and virtio_net modules on the PCI host. This
>>> + * includes setting up feature negotiation and default config setup etc.
>>> + *
>>> + * @epf_virtio: epf_virtio handler
>>> + */
>>> +static void pci_epf_virtio_init_cfg_legacy(struct pci_epf_virtio *epf_virtio)
>>> +{
>>> +	const u32 dev_feature =
>>> +		generate_dev_feature32(features, ARRAY_SIZE(features));
>>> +	struct virtio_legacy_cfg *const legacy_cfg = epf_virtio->reg[BAR_0];
>>
>> virtio_reg_bar instead of BAR_0
> The dilemma was that the virtio_pci on PCI host will only write to BAR
> 0. I may need to throw an error if the first free bar is not BAR 0.

hmm.. We need a better way to handle it. Just having
PCI_VENDOR_ID_REDHAT_QUMRANET in virtio_pci may not be sufficient then.
> 
>>> +	pci_epc_stop(epc);
>>
>> You should never have pci_epc_stop() in function driver as that will break
>> multi-function endpoint devices. I'll fix this in pci-epf-test.c.
> Look forward to your progress on this.
> 
>>> +	for (bar = BAR_0; bar <= BAR_5; bar += add) {
>>
>> Are you using all these BARs? It's best to allocate and initialize the BARs we use.
> Will only use BAR 0 instead.
> 
>> Please add a description for each of these structures.
> I had to copy these structures exactly as they were from virtio_ring.c
> unfortunately, because they were not exposed via any header file. If
> virtio_ring.c has some struct changes, this endpoint function will have
> to change accordingly.

Some of the structures are exposed in virtio_ring.h. We probably need to use
that instead of using the structures from virtio_ring.c.
> 
> Thank you so much for taking time to review this patch. Now that I came
> back to university and continued my undergrad study, my kernel
> development work will probably slow down a lot. The heavy-lifting work
> such as creating more layers to allow more virtio devices will take a
> much longer time.

Agreed. IMHO we should adapt vhost as a generic backend driver so that it could
be used behind PCI.

Cheers
Kishon
