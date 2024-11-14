Return-Path: <linux-pci+bounces-16718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7E9C8028
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0895CB23597
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE117C20F;
	Thu, 14 Nov 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXV+56hl"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EE42A9B
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548757; cv=none; b=hXiV3oQ6j6kSQD01dM8NfJTxeyRDQfg1Ee5AD/M2vz9pOvF7gsp+KnnPFQZTjTPml0Oz+w89Zzuunv/Clp/VmGmVCqtLjI+AnXTL6Q13o9tWf509MhDMRlAS66JGxUDxr2zLxQegIyfeLiu4WMa54MrtO+YHqsPiNE1Rc/yfGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548757; c=relaxed/simple;
	bh=bwGDRMVI7TyWZ6zyTO+7IA/7Wp5/HS+XvIpLC3KJ3dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwI25tW8Iq8VLSJUmf6mAICUuYuQHTAIu5FyQCju9wwKErlJUmEuCbEcfJSKuLD94esV6iQ1nCIlvn+j3HMLd7hVWpC/oZdyoTIDdYtE7aZu/ZUarn3/cwMS7lR0/qERX4tuP3LJevtnd0Tr+BzjPQwnh9X6t07rfg5VtjUsDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXV+56hl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731548754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yR1GZUFS0LBQ/guHbrlldU7st7AuyATsxiMe8yNoBo0=;
	b=DXV+56hllusqiksz4sbuDudGoz/R3YmZ83Vc1Eo3cjI7pK+sToapTP8AT0aO9ULouNAWS4
	5+bfGSxRP0ENJ5wnKPIS07MKeEBkiWAhvnOn2BMRfzN1bNc53b+VPBZPDnjP46gLnIbIHQ
	1vfAUSoBykUdIrVX8W1wNUjPs58zfAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237--a1l96hQNMq7uvZ2A6y2Xg-1; Wed,
 13 Nov 2024 20:45:50 -0500
X-MC-Unique: -a1l96hQNMq7uvZ2A6y2Xg-1
X-Mimecast-MFC-AGG-ID: -a1l96hQNMq7uvZ2A6y2Xg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22431955F41;
	Thu, 14 Nov 2024 01:45:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C92A30000DF;
	Thu, 14 Nov 2024 01:45:31 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:45:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 01/10] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <ZzVWNy3oer4jFjFk@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-1-dd3baa1e267f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-1-dd3baa1e267f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 13, 2024 at 03:26:15PM +0100, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  include/linux/device/bus.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,6 +48,7 @@ struct fwnode_handle;
>   *		will never get called until they do.
>   * @remove:	Called when a device removed from this bus.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> + * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
>   *
>   * @online:	Called to put the device back online (after offlining it).
>   * @offline:	Called to put the device offline for hot-removal. May fail.
> @@ -87,6 +88,8 @@ struct bus_type {
>  	void (*sync_state)(struct device *dev);
>  	void (*remove)(struct device *dev);
>  	void (*shutdown)(struct device *dev);
> +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> +			unsigned int irq_vec);
>  
>  	int (*online)(struct device *dev);
>  	int (*offline)(struct device *dev);
> 

Looks one nice abstraction,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


