Return-Path: <linux-pci+bounces-16719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B59C803A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B791F241D7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99BB1E3DC9;
	Thu, 14 Nov 2024 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9gmxVSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A41C1AB6
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549205; cv=none; b=Ldyp/PhcASo/UxwVQ2dZuXy+0l0cVCNKYRCge0Z6kI8daMfeuKrvSbX5+YVClfXDs0R7o51RJCul7V4V/n5wFNAxyPGvYtn8K8koiVvbJjw7aXGAMCmlUT73TFMtLq3VzMwNlhoKs7qn5EUx7PryTF/4eCXRPVXsJgHU0B3asvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549205; c=relaxed/simple;
	bh=R7x7pjybJYVTt7xbgrbtqtCIwgd0awU+glBfxSo59DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmkFQl4/gsVDuMnMiXitpUtausgnLJsRCLiETKKo+QthGC32/yckE87z0xokBRDi+1ZI8Zsw6Jxv8z6M1inr3Cydq84xuc0DJR53Zbm/BBlluGEZe6PiMNOY/S3DCB38qISERUAqJGh7v+zRDtXalvON/ZGUABvZuhyFsCWlWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9gmxVSe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731549203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7VonX42shxT96KYGey0nbt1GczZThNx0w3qXBIrjLI=;
	b=H9gmxVSeco2YeQgpIAib8joL0m8cKTr4sky5StVLV3APUL4k0a1toEyMS/FQSGySlxKUpc
	p74n0wPCnsVqix+5xOIZ+HfSo5ukOQv40x2q+XcAFoi7BHGInGaUO4rcyFH+F/9EGzuPQZ
	m8vTkbrQ2VWytzA72QrxfaMYkRzcO7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668--0qIiGIwN9e1f3wh8DP2LQ-1; Wed,
 13 Nov 2024 20:53:19 -0500
X-MC-Unique: -0qIiGIwN9e1f3wh8DP2LQ-1
X-Mimecast-MFC-AGG-ID: -0qIiGIwN9e1f3wh8DP2LQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE08E1956048;
	Thu, 14 Nov 2024 01:53:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.113])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5A181956054;
	Thu, 14 Nov 2024 01:53:00 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:52:55 +0800
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
Subject: Re: [PATCH v4 02/10] driver core: add irq_get_affinity callback
 device_driver
Message-ID: <ZzVX92YaqVpW9cPw@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-2-dd3baa1e267f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-2-dd3baa1e267f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Nov 13, 2024 at 03:26:16PM +0100, Daniel Wagner wrote:
> Introducing a callback in struct device_driver so that a device driver
> can hook up the getters directly. This approach avoids exposing random
> getters in drivers.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  include/linux/device/driver.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 5c04b8e3833b995f9fd4d65b8732b3dfce2eba7e..0d1aee423f6c076ae102bdd0536233c259947fac 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -74,6 +74,7 @@ enum probe_type {
>   * @suspend:	Called to put the device to sleep mode. Usually to a
>   *		low power state.
>   * @resume:	Called to bring a device from sleep mode.
> + * @irq_get_affinity:	Get IRQ affinity mask for the device.
>   * @groups:	Default attributes that get created by the driver core
>   *		automatically.
>   * @dev_groups:	Additional attributes attached to device instance once
> @@ -112,6 +113,8 @@ struct device_driver {
>  	void (*shutdown) (struct device *dev);
>  	int (*suspend) (struct device *dev, pm_message_t state);
>  	int (*resume) (struct device *dev);
> +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> +			unsigned int irq_vec);
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;

The patch looks fine, but if you put 1, 2 and 5 into single patch,
it will become much easier to review, anyway:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming


