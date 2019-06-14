Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B567E45673
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfFNHdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 03:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfFNHdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 03:33:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D113437EE0;
        Fri, 14 Jun 2019 07:33:34 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA9105DE00;
        Fri, 14 Jun 2019 07:33:24 +0000 (UTC)
Subject: Re: [PATCH v8 5/7] iommu: Add virtio-iommu driver
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        joro@8bytes.org, mst@redhat.com
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, Tomasz Nowicki <tn@semihalf.com>,
        kevin.tian@intel.com, bauerman@linux.ibm.com
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
 <20190530170929.19366-6-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5056ddfd-2f8f-39e9-2358-e5f040c890c6@redhat.com>
Date:   Fri, 14 Jun 2019 09:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190530170929.19366-6-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 14 Jun 2019 07:33:45 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi jean,

On 5/30/19 7:09 PM, Jean-Philippe Brucker wrote:
> The virtio IOMMU is a para-virtualized device, allowing to send IOMMU
> requests such as map/unmap over virtio transport without emulating page
> tables. This implementation handles ATTACH, DETACH, MAP and UNMAP
> requests.
> 
> The bulk of the code transforms calls coming from the IOMMU API into
> corresponding virtio requests. Mappings are kept in an interval tree
> instead of page tables. A little more work is required for modular and x86
> support, so for the moment the driver depends on CONFIG_VIRTIO=y and
> CONFIG_ARM64.
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  MAINTAINERS                       |   7 +
>  drivers/iommu/Kconfig             |  11 +
>  drivers/iommu/Makefile            |   1 +
>  drivers/iommu/virtio-iommu.c      | 934 ++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h   |   1 +
>  include/uapi/linux/virtio_iommu.h | 110 ++++
>  6 files changed, 1064 insertions(+)
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 429c6c624861..62bd1834d95a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16807,6 +16807,13 @@ S:	Maintained
>  F:	drivers/virtio/virtio_input.c
>  F:	include/uapi/linux/virtio_input.h
>  
> +VIRTIO IOMMU DRIVER
> +M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> +L:	virtualization@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/iommu/virtio-iommu.c
> +F:	include/uapi/linux/virtio_iommu.h
> +
>  VIRTUAL BOX GUEST DEVICE DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 83664db5221d..e15cdcd8cb3c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -473,4 +473,15 @@ config HYPERV_IOMMU
>  	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
>  	  guests to run with x2APIC mode enabled.
>  
> +config VIRTIO_IOMMU
> +	bool "Virtio IOMMU driver"
> +	depends on VIRTIO=y
> +	depends on ARM64
> +	select IOMMU_API
> +	select INTERVAL_TREE
> +	help
> +	  Para-virtualised IOMMU driver with virtio.
> +
> +	  Say Y here if you intend to run this kernel as a guest.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 8c71a15e986b..f13f36ae1af6 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> new file mode 100644
> index 000000000000..b2719a87c3c5
> --- /dev/null
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -0,0 +1,934 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtio driver for the paravirtualized IOMMU
> + *
> + * Copyright (C) 2019 Arm Limited
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/amba/bus.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/freezer.h>
> +#include <linux/interval_tree.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/wait.h>
> +
> +#include <uapi/linux/virtio_iommu.h>
> +
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
> +#define VIOMMU_REQUEST_VQ		0
> +#define VIOMMU_NR_VQS			1
> +
> +struct viommu_dev {
> +	struct iommu_device		iommu;
> +	struct device			*dev;
> +	struct virtio_device		*vdev;
> +
> +	struct ida			domain_ids;
> +
> +	struct virtqueue		*vqs[VIOMMU_NR_VQS];
> +	spinlock_t			request_lock;
> +	struct list_head		requests;
> +
> +	/* Device configuration */
> +	struct iommu_domain_geometry	geometry;
> +	u64				pgsize_bitmap;
> +	u32				first_domain;
> +	u32				last_domain;
> +	/* Supported MAP flags */
> +	u32				map_flags;
> +};
> +
> +struct viommu_mapping {
> +	phys_addr_t			paddr;
> +	struct interval_tree_node	iova;
> +	u32				flags;
> +};
> +
> +struct viommu_domain {
> +	struct iommu_domain		domain;
> +	struct viommu_dev		*viommu;
> +	struct mutex			mutex; /* protects viommu pointer */
> +	unsigned int			id;
> +	u32				map_flags;
> +
> +	spinlock_t			mappings_lock;
> +	struct rb_root_cached		mappings;
> +
> +	unsigned long			nr_endpoints;
> +};
> +
> +struct viommu_endpoint {
> +	struct viommu_dev		*viommu;
> +	struct viommu_domain		*vdomain;
> +};
> +
> +struct viommu_request {
> +	struct list_head		list;
> +	void				*writeback;
> +	unsigned int			write_offset;
> +	unsigned int			len;
> +	char				buf[];
> +};
> +
> +#define to_viommu_domain(domain)	\
> +	container_of(domain, struct viommu_domain, domain)
> +
> +static int viommu_get_req_errno(void *buf, size_t len)
> +{
> +	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
> +
> +	switch (tail->status) {
> +	case VIRTIO_IOMMU_S_OK:
> +		return 0;
> +	case VIRTIO_IOMMU_S_UNSUPP:
> +		return -ENOSYS;
> +	case VIRTIO_IOMMU_S_INVAL:
> +		return -EINVAL;
> +	case VIRTIO_IOMMU_S_RANGE:
> +		return -ERANGE;
> +	case VIRTIO_IOMMU_S_NOENT:
> +		return -ENOENT;
> +	case VIRTIO_IOMMU_S_FAULT:
> +		return -EFAULT;
> +	case VIRTIO_IOMMU_S_NOMEM:
> +		return -ENOMEM;
> +	case VIRTIO_IOMMU_S_IOERR:
> +	case VIRTIO_IOMMU_S_DEVERR:
> +	default:
> +		return -EIO;
> +	}
> +}
> +
> +static void viommu_set_req_status(void *buf, size_t len, int status)
> +{
> +	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
> +
> +	tail->status = status;
> +}
> +
> +static off_t viommu_get_write_desc_offset(struct viommu_dev *viommu,
> +					  struct virtio_iommu_req_head *req,
> +					  size_t len)
> +{
> +	size_t tail_size = sizeof(struct virtio_iommu_req_tail);
> +
> +	return len - tail_size;
> +}
> +
> +/*
> + * __viommu_sync_req - Complete all in-flight requests
> + *
> + * Wait for all added requests to complete. When this function returns, all
> + * requests that were in-flight at the time of the call have completed.
> + */
> +static int __viommu_sync_req(struct viommu_dev *viommu)
> +{
> +	int ret = 0;
> +	unsigned int len;
> +	size_t write_len;
> +	struct viommu_request *req;
> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
> +
> +	assert_spin_locked(&viommu->request_lock);
> +
> +	virtqueue_kick(vq);
> +
> +	while (!list_empty(&viommu->requests)) {
> +		len = 0;
> +		req = virtqueue_get_buf(vq, &len);
> +		if (!req)
> +			continue;
> +
> +		if (!len)
> +			viommu_set_req_status(req->buf, req->len,
> +					      VIRTIO_IOMMU_S_IOERR);
> +
> +		write_len = req->len - req->write_offset;
> +		if (req->writeback && len == write_len)
> +			memcpy(req->writeback, req->buf + req->write_offset,
> +			       write_len);
> +
> +		list_del(&req->list);
> +		kfree(req);
> +	}
> +
> +	return ret;
> +}
> +
> +static int viommu_sync_req(struct viommu_dev *viommu)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&viommu->request_lock, flags);
> +	ret = __viommu_sync_req(viommu);
> +	if (ret)
> +		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
> +	spin_unlock_irqrestore(&viommu->request_lock, flags);
> +
> +	return ret;
> +}
> +
> +/*
> + * __viommu_add_request - Add one request to the queue
> + * @buf: pointer to the request buffer
> + * @len: length of the request buffer
> + * @writeback: copy data back to the buffer when the request completes.
> + *
> + * Add a request to the queue. Only synchronize the queue if it's already full.
> + * Otherwise don't kick the queue nor wait for requests to complete.
> + *
> + * When @writeback is true, data written by the device, including the request
> + * status, is copied into @buf after the request completes. This is unsafe if
> + * the caller allocates @buf on stack and drops the lock between add_req() and
> + * sync_req().
> + *
> + * Return 0 if the request was successfully added to the queue.
> + */
> +static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
> +			    bool writeback)
> +{
> +	int ret;
> +	off_t write_offset;
> +	struct viommu_request *req;
> +	struct scatterlist top_sg, bottom_sg;
> +	struct scatterlist *sg[2] = { &top_sg, &bottom_sg };
> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
> +
> +	assert_spin_locked(&viommu->request_lock);
> +
> +	write_offset = viommu_get_write_desc_offset(viommu, buf, len);
> +	if (write_offset <= 0)
> +		return -EINVAL;
> +
> +	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->len = len;
> +	if (writeback) {
> +		req->writeback = buf + write_offset;
> +		req->write_offset = write_offset;
> +	}
> +	memcpy(&req->buf, buf, write_offset);
> +
> +	sg_init_one(&top_sg, req->buf, write_offset);
> +	sg_init_one(&bottom_sg, req->buf + write_offset, len - write_offset);
> +
> +	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
> +	if (ret == -ENOSPC) {
> +		/* If the queue is full, sync and retry */
> +		if (!__viommu_sync_req(viommu))
> +			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
> +	}
> +	if (ret)
> +		goto err_free;
> +
> +	list_add_tail(&req->list, &viommu->requests);
> +	return 0;
> +
> +err_free:
> +	kfree(req);
> +	return ret;
> +}
> +
> +static int viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&viommu->request_lock, flags);
> +	ret = __viommu_add_req(viommu, buf, len, false);
> +	if (ret)
> +		dev_dbg(viommu->dev, "could not add request: %d\n", ret);
> +	spin_unlock_irqrestore(&viommu->request_lock, flags);
> +
> +	return ret;
> +}
> +
> +/*
> + * Send a request and wait for it to complete. Return the request status (as an
> + * errno)
> + */
> +static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
> +				size_t len)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&viommu->request_lock, flags);
> +
> +	ret = __viommu_add_req(viommu, buf, len, true);
> +	if (ret) {
> +		dev_dbg(viommu->dev, "could not add request (%d)\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	ret = __viommu_sync_req(viommu);
> +	if (ret) {
> +		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
> +		/* Fall-through (get the actual request status) */
> +	}
> +
> +	ret = viommu_get_req_errno(buf, len);
> +out_unlock:
> +	spin_unlock_irqrestore(&viommu->request_lock, flags);
> +	return ret;
> +}
> +
> +/*
> + * viommu_add_mapping - add a mapping to the internal tree
> + *
> + * On success, return the new mapping. Otherwise return NULL.
> + */
> +static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> +			      phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	unsigned long irqflags;
> +	struct viommu_mapping *mapping;
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	mapping->paddr		= paddr;
> +	mapping->iova.start	= iova;
> +	mapping->iova.last	= iova + size - 1;
> +	mapping->flags		= flags;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
> +	interval_tree_insert(&mapping->iova, &vdomain->mappings);
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +/*
> + * viommu_del_mappings - remove mappings from the internal tree
> + *
> + * @vdomain: the domain
> + * @iova: start of the range
> + * @size: size of the range. A size of 0 corresponds to the entire address
> + *	space.
> + *
> + * On success, returns the number of unmapped bytes (>= size)
> + */
> +static size_t viommu_del_mappings(struct viommu_domain *vdomain,
> +				  unsigned long iova, size_t size)
> +{
> +	size_t unmapped = 0;
> +	unsigned long flags;
> +	unsigned long last = iova + size - 1;
> +	struct viommu_mapping *mapping = NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
> +	while (next) {
> +		node = next;
> +		mapping = container_of(node, struct viommu_mapping, iova);
> +		next = interval_tree_iter_next(node, iova, last);
> +
> +		/* Trying to split a mapping? */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		/*
> +		 * Virtio-iommu doesn't allow UNMAP to split a mapping created
> +		 * with a single MAP request, so remove the full mapping.
> +		 */
> +		unmapped += mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &vdomain->mappings);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	return unmapped;
> +}
> +
> +/*
> + * viommu_replay_mappings - re-send MAP requests
> + *
> + * When reattaching a domain that was previously detached from all endpoints,
> + * mappings were deleted from the device. Re-create the mappings available in
> + * the internal tree.
> + */
> +static int viommu_replay_mappings(struct viommu_domain *vdomain)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct viommu_mapping *mapping;
> +	struct interval_tree_node *node;
> +	struct virtio_iommu_req_map map;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	node = interval_tree_iter_first(&vdomain->mappings, 0, -1UL);
> +	while (node) {
> +		mapping = container_of(node, struct viommu_mapping, iova);
> +		map = (struct virtio_iommu_req_map) {
> +			.head.type	= VIRTIO_IOMMU_T_MAP,
> +			.domain		= cpu_to_le32(vdomain->id),
> +			.virt_start	= cpu_to_le64(mapping->iova.start),
> +			.virt_end	= cpu_to_le64(mapping->iova.last),
> +			.phys_start	= cpu_to_le64(mapping->paddr),
> +			.flags		= cpu_to_le32(mapping->flags),
> +		};
> +
> +		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		if (ret)
> +			break;
> +
> +		node = interval_tree_iter_next(node, 0, -1UL);
> +	}
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	return ret;
> +}
> +
> +/* IOMMU API */
> +
> +static struct iommu_domain *viommu_domain_alloc(unsigned type)
> +{
> +	struct viommu_domain *vdomain;
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +		return NULL;
> +
> +	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> +	if (!vdomain)
> +		return NULL;
> +
> +	mutex_init(&vdomain->mutex);
> +	spin_lock_init(&vdomain->mappings_lock);
> +	vdomain->mappings = RB_ROOT_CACHED;
> +
> +	if (type == IOMMU_DOMAIN_DMA &&
> +	    iommu_get_dma_cookie(&vdomain->domain)) {
> +		kfree(vdomain);
> +		return NULL;
> +	}
> +
> +	return &vdomain->domain;
> +}
> +
> +static int viommu_domain_finalise(struct viommu_dev *viommu,
> +				  struct iommu_domain *domain)
> +{
> +	int ret;
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	vdomain->viommu		= viommu;
> +	vdomain->map_flags	= viommu->map_flags;
> +
> +	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +	domain->geometry	= viommu->geometry;
> +
> +	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> +			      viommu->last_domain, GFP_KERNEL);
> +	if (ret >= 0)
> +		vdomain->id = (unsigned int)ret;
> +
> +	return ret > 0 ? 0 : ret;
> +}
> +
> +static void viommu_domain_free(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	iommu_put_dma_cookie(domain);
> +
> +	/* Free all remaining mappings (size 2^64) */
> +	viommu_del_mappings(vdomain, 0, 0);
> +
> +	if (vdomain->viommu)
> +		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
> +
> +	kfree(vdomain);
> +}
> +
> +static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	int i;
> +	int ret = 0;
> +	struct virtio_iommu_req_attach req;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct viommu_endpoint *vdev = fwspec->iommu_priv;
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	mutex_lock(&vdomain->mutex);
> +	if (!vdomain->viommu) {
> +		/*
> +		 * Properly initialize the domain now that we know which viommu
> +		 * owns it.
> +		 */
> +		ret = viommu_domain_finalise(vdev->viommu, domain);
> +	} else if (vdomain->viommu != vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> +		ret = -EXDEV;
> +	}
> +	mutex_unlock(&vdomain->mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * In the virtio-iommu device, when attaching the endpoint to a new
> +	 * domain, it is detached from the old one and, if as as a result the
> +	 * old domain isn't attached to any endpoint, all mappings are removed
> +	 * from the old domain and it is freed.
> +	 *
> +	 * In the driver the old domain still exists, and its mappings will be
> +	 * recreated if it gets reattached to an endpoint. Otherwise it will be
> +	 * freed explicitly.
> +	 *
> +	 * vdev->vdomain is protected by group->mutex
> +	 */
> +	if (vdev->vdomain)
> +		vdev->vdomain->nr_endpoints--;
> +
> +	req = (struct virtio_iommu_req_attach) {
> +		.head.type	= VIRTIO_IOMMU_T_ATTACH,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> +
> +		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!vdomain->nr_endpoints) {
> +		/*
> +		 * This endpoint is the first to be attached to the domain.
> +		 * Replay existing mappings (e.g. SW MSI).
> +		 */
> +		ret = viommu_replay_mappings(vdomain);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	vdomain->nr_endpoints++;
> +	vdev->vdomain = vdomain;
> +
> +	return 0;
> +}
> +
> +static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> +		      phys_addr_t paddr, size_t size, int prot)
> +{
> +	int ret;
> +	u32 flags;
> +	struct virtio_iommu_req_map map;
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	flags = (prot & IOMMU_READ ? VIRTIO_IOMMU_MAP_F_READ : 0) |
> +		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
> +		(prot & IOMMU_MMIO ? VIRTIO_IOMMU_MAP_F_MMIO : 0);
> +
> +	if (flags & ~vdomain->map_flags)
> +		return -EINVAL;
> +
> +	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
> +	if (ret)
> +		return ret;
> +
> +	map = (struct virtio_iommu_req_map) {
> +		.head.type	= VIRTIO_IOMMU_T_MAP,
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.virt_start	= cpu_to_le64(iova),
> +		.phys_start	= cpu_to_le64(paddr),
> +		.virt_end	= cpu_to_le64(iova + size - 1),
> +		.flags		= cpu_to_le32(flags),
> +	};
> +
> +	if (!vdomain->nr_endpoints)
> +		return 0;
> +
> +	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +	if (ret)
> +		viommu_del_mappings(vdomain, iova, size);
> +
> +	return ret;
> +}
> +
> +static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			   size_t size)
> +{
> +	int ret = 0;
> +	size_t unmapped;
> +	struct virtio_iommu_req_unmap unmap;
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	unmapped = viommu_del_mappings(vdomain, iova, size);
> +	if (unmapped < size)
> +		return 0;
> +
> +	/* Device already removed all mappings after detach. */
> +	if (!vdomain->nr_endpoints)
> +		return unmapped;
> +
> +	unmap = (struct virtio_iommu_req_unmap) {
> +		.head.type	= VIRTIO_IOMMU_T_UNMAP,
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.virt_start	= cpu_to_le64(iova),
> +		.virt_end	= cpu_to_le64(iova + unmapped - 1),
> +	};
> +
> +	ret = viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap));
> +	return ret ? 0 : unmapped;
> +}
> +
> +static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
> +				       dma_addr_t iova)
> +{
> +	u64 paddr = 0;
> +	unsigned long flags;
> +	struct viommu_mapping *mapping;
> +	struct interval_tree_node *node;
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
> +	if (node) {
> +		mapping = container_of(node, struct viommu_mapping, iova);
> +		paddr = mapping->paddr + (iova - mapping->iova.start);
> +	}
> +	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> +
> +	return paddr;
> +}
> +
> +static void viommu_iotlb_sync(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	viommu_sync_req(vdomain->viommu);
> +}
> +
> +static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH, prot,
> +					 IOMMU_RESV_SW_MSI);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +	iommu_dma_get_resv_regions(dev, head);
> +}
> +
> +static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +
> +static struct iommu_ops viommu_ops;
> +static struct virtio_driver virtio_iommu_drv;
> +
> +static int viommu_match_node(struct device *dev, void *data)
> +{
> +	return dev->parent->fwnode == data;
> +}
> +
> +static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
> +{
> +	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
> +						fwnode, viommu_match_node);
> +	put_device(dev);
> +
> +	return dev ? dev_to_virtio(dev)->priv : NULL;
> +}
> +
> +static int viommu_add_device(struct device *dev)
> +{
> +	int ret;
> +	struct iommu_group *group;
> +	struct viommu_endpoint *vdev;
> +	struct viommu_dev *viommu = NULL;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (!fwspec || fwspec->ops != &viommu_ops)
> +		return -ENODEV;
> +
> +	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
> +	if (!viommu)
> +		return -ENODEV;
> +
> +	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	vdev->viommu = viommu;
> +	fwspec->iommu_priv = vdev;
> +
> +	ret = iommu_device_link(&viommu->iommu, dev);
> +	if (ret)
> +		goto err_free_dev;
> +
> +	/*
> +	 * Last step creates a default domain and attaches to it. Everything
> +	 * must be ready.
> +	 */
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group)) {
> +		ret = PTR_ERR(group);
> +		goto err_unlink_dev;
> +	}
> +
> +	iommu_group_put(group);
> +
> +	return PTR_ERR_OR_ZERO(group);
> +
> +err_unlink_dev:
> +	iommu_device_unlink(&viommu->iommu, dev);
> +err_free_dev:
> +	kfree(vdev);
> +
> +	return ret;
> +}
> +
> +static void viommu_remove_device(struct device *dev)
> +{
> +	struct viommu_endpoint *vdev;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (!fwspec || fwspec->ops != &viommu_ops)
> +		return;
> +
> +	vdev = fwspec->iommu_priv;
> +
> +	iommu_group_remove_device(dev);
> +	iommu_device_unlink(&vdev->viommu->iommu, dev);
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *viommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
> +}
> +
> +static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	return iommu_fwspec_add_ids(dev, args->args, 1);
> +}
> +
> +static struct iommu_ops viommu_ops = {
> +	.domain_alloc		= viommu_domain_alloc,
> +	.domain_free		= viommu_domain_free,
> +	.attach_dev		= viommu_attach_dev,
> +	.map			= viommu_map,
> +	.unmap			= viommu_unmap,
> +	.iova_to_phys		= viommu_iova_to_phys,
> +	.iotlb_sync		= viommu_iotlb_sync,
> +	.add_device		= viommu_add_device,
> +	.remove_device		= viommu_remove_device,
> +	.device_group		= viommu_device_group,
> +	.get_resv_regions	= viommu_get_resv_regions,
> +	.put_resv_regions	= viommu_put_resv_regions,
> +	.of_xlate		= viommu_of_xlate,
> +};
> +
> +static int viommu_init_vqs(struct viommu_dev *viommu)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
> +	const char *name = "request";
> +	void *ret;
> +
> +	ret = virtio_find_single_vq(vdev, NULL, name);
> +	if (IS_ERR(ret)) {
> +		dev_err(viommu->dev, "cannot find VQ\n");
> +		return PTR_ERR(ret);
> +	}
> +
> +	viommu->vqs[VIOMMU_REQUEST_VQ] = ret;
> +
> +	return 0;
> +}
> +
> +static int viommu_probe(struct virtio_device *vdev)
> +{
> +	struct device *parent_dev = vdev->dev.parent;
> +	struct viommu_dev *viommu = NULL;
> +	struct device *dev = &vdev->dev;
> +	u64 input_start = 0;
> +	u64 input_end = -1UL;
> +	int ret;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> +	    !virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP))
> +		return -ENODEV;
> +
> +	viommu = devm_kzalloc(dev, sizeof(*viommu), GFP_KERNEL);
> +	if (!viommu)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&viommu->request_lock);
> +	ida_init(&viommu->domain_ids);
> +	viommu->dev = dev;
> +	viommu->vdev = vdev;
> +	INIT_LIST_HEAD(&viommu->requests);
> +
> +	ret = viommu_init_vqs(viommu);
> +	if (ret)
> +		return ret;
> +
> +	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
> +		     &viommu->pgsize_bitmap);
> +
> +	if (!viommu->pgsize_bitmap) {
> +		ret = -EINVAL;
> +		goto err_free_vqs;
> +	}
> +
> +	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> +	viommu->last_domain = ~0U;
> +
> +	/* Optional features */
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
> +			     struct virtio_iommu_config, input_range.start,
> +			     &input_start);
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
> +			     struct virtio_iommu_config, input_range.end,
> +			     &input_end);
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +			     struct virtio_iommu_config, domain_range.start,
> +			     &viommu->first_domain);
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +			     struct virtio_iommu_config, domain_range.end,
> +			     &viommu->last_domain);
> +
> +	viommu->geometry = (struct iommu_domain_geometry) {
> +		.aperture_start	= input_start,
> +		.aperture_end	= input_end,
> +		.force_aperture	= true,
> +	};
> +
> +	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
> +		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
> +
> +	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
> +
> +	virtio_device_ready(vdev);
> +
> +	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
> +				     virtio_bus_name(vdev));
> +	if (ret)
> +		goto err_free_vqs;
> +
> +	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
> +	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
> +
> +	iommu_device_register(&viommu->iommu);
> +
> +#ifdef CONFIG_PCI
> +	if (pci_bus_type.iommu_ops != &viommu_ops) {
> +		pci_request_acs();
> +		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +#endif
> +#ifdef CONFIG_ARM_AMBA
> +	if (amba_bustype.iommu_ops != &viommu_ops) {
> +		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +#endif
> +	if (platform_bus_type.iommu_ops != &viommu_ops) {
> +		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
> +		if (ret)
> +			goto err_unregister;
> +	}
> +
> +	vdev->priv = viommu;
> +
> +	dev_info(dev, "input address: %u bits\n",
> +		 order_base_2(viommu->geometry.aperture_end));
> +	dev_info(dev, "page mask: %#llx\n", viommu->pgsize_bitmap);
> +
> +	return 0;
> +
> +err_unregister:
> +	iommu_device_sysfs_remove(&viommu->iommu);
> +	iommu_device_unregister(&viommu->iommu);
> +err_free_vqs:
> +	vdev->config->del_vqs(vdev);
> +
> +	return ret;
> +}
> +
> +static void viommu_remove(struct virtio_device *vdev)
> +{
> +	struct viommu_dev *viommu = vdev->priv;
> +
> +	iommu_device_sysfs_remove(&viommu->iommu);
> +	iommu_device_unregister(&viommu->iommu);
> +
> +	/* Stop all virtqueues */
> +	vdev->config->reset(vdev);
> +	vdev->config->del_vqs(vdev);
> +
> +	dev_info(&vdev->dev, "device removed\n");
> +}
> +
> +static void viommu_config_changed(struct virtio_device *vdev)
> +{
> +	dev_warn(&vdev->dev, "config changed\n");
> +}
> +
> +static unsigned int features[] = {
> +	VIRTIO_IOMMU_F_MAP_UNMAP,
> +	VIRTIO_IOMMU_F_INPUT_RANGE,
> +	VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +	VIRTIO_IOMMU_F_MMIO,
> +};
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_IOMMU, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_iommu_drv = {
> +	.driver.name		= KBUILD_MODNAME,
> +	.driver.owner		= THIS_MODULE,
> +	.id_table		= id_table,
> +	.feature_table		= features,
> +	.feature_table_size	= ARRAY_SIZE(features),
> +	.probe			= viommu_probe,
> +	.remove			= viommu_remove,
> +	.config_changed		= viommu_config_changed,
> +};
> +
> +module_virtio_driver(virtio_iommu_drv);
> +
> +MODULE_DESCRIPTION("Virtio IOMMU driver");
> +MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 6d5c3b2d4f4d..cfe47c5d9a56 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> new file mode 100644
> index 000000000000..5da1818080de
> --- /dev/null
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Virtio-iommu definition v0.12
> + *
> + * Copyright (C) 2019 Arm Ltd.
> + */
> +#ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
> +#define _UAPI_LINUX_VIRTIO_IOMMU_H
> +
> +#include <linux/types.h>
> +
> +/* Feature bits */
> +#define VIRTIO_IOMMU_F_INPUT_RANGE		0
> +#define VIRTIO_IOMMU_F_DOMAIN_RANGE		1
> +#define VIRTIO_IOMMU_F_MAP_UNMAP		2
> +#define VIRTIO_IOMMU_F_BYPASS			3
> +#define VIRTIO_IOMMU_F_MMIO			5
> +
> +struct virtio_iommu_range_64 {
> +	__le64					start;
> +	__le64					end;
> +};
> +
> +struct virtio_iommu_range_32 {
> +	__le32					start;
> +	__le32					end;
> +};
> +
> +struct virtio_iommu_config {
> +	/* Supported page sizes */
> +	__le64					page_size_mask;
> +	/* Supported IOVA range */
> +	struct virtio_iommu_range_64		input_range;
> +	/* Max domain ID size */
> +	struct virtio_iommu_range_32		domain_range;
> +	/* Probe buffer size */
> +	__le32					probe_size;
> +};
> +
> +/* Request types */
> +#define VIRTIO_IOMMU_T_ATTACH			0x01
> +#define VIRTIO_IOMMU_T_DETACH			0x02
> +#define VIRTIO_IOMMU_T_MAP			0x03
> +#define VIRTIO_IOMMU_T_UNMAP			0x04
> +
> +/* Status types */
> +#define VIRTIO_IOMMU_S_OK			0x00
> +#define VIRTIO_IOMMU_S_IOERR			0x01
> +#define VIRTIO_IOMMU_S_UNSUPP			0x02
> +#define VIRTIO_IOMMU_S_DEVERR			0x03
> +#define VIRTIO_IOMMU_S_INVAL			0x04
> +#define VIRTIO_IOMMU_S_RANGE			0x05
> +#define VIRTIO_IOMMU_S_NOENT			0x06
> +#define VIRTIO_IOMMU_S_FAULT			0x07
> +#define VIRTIO_IOMMU_S_NOMEM			0x08
> +
> +struct virtio_iommu_req_head {
> +	__u8					type;
> +	__u8					reserved[3];
> +};
> +
> +struct virtio_iommu_req_tail {
> +	__u8					status;
> +	__u8					reserved[3];
> +};
> +
> +struct virtio_iommu_req_attach {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;
> +	__le32					endpoint;
> +	__u8					reserved[8];
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +struct virtio_iommu_req_detach {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;
> +	__le32					endpoint;
> +	__u8					reserved[8];
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +#define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
> +#define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
> +#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
> +
> +#define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
> +						 VIRTIO_IOMMU_MAP_F_WRITE |	\
> +						 VIRTIO_IOMMU_MAP_F_MMIO)
> +
> +struct virtio_iommu_req_map {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;
> +	__le64					virt_start;
> +	__le64					virt_end;
> +	__le64					phys_start;
> +	__le32					flags;
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +struct virtio_iommu_req_unmap {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;
> +	__le64					virt_start;
> +	__le64					virt_end;
> +	__u8					reserved[4];
> +	struct virtio_iommu_req_tail		tail;
> +};
> +
> +#endif
> 
