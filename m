Return-Path: <linux-pci+bounces-17135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E419D462D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E04280F46
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7913CA97;
	Thu, 21 Nov 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNkGKcmI"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618432309A9
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732159086; cv=none; b=HBAnWjKRkmHCZ0gk3HyAUgGd/kWxxTjoZ9sXqc2WSD77o6p3X62N+AR2pbOxmga6fAHl1Qgx9wJ23ubEU3wug5nkKOzSqNHeYnj+cGWNsDzYbibZSssUJ4OirUxoIMSi+p24KyGxMf1Dswp+AajxGf2pG9jE/InhwsA/VDRlpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732159086; c=relaxed/simple;
	bh=Gv2WTv/RHyyTjXZzvU6darKROH8goLI5nvGgzCz7ycI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzXpSCOVcDE+K3OJup9FDWgT+nCBQBTUQU5M5m89iRLMzMaqChp+mBQggrOFs4kLfd7S3hSHnaK7/Ih1LckBqRH179B/cCmhKUkiKReTDraZcZMJ9H4FFLOCFihu1uef7xJf4RuUhCm6eDOX5z9gBazQHKuY2fZc1HNO1fTrGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNkGKcmI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732159084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+WIG4TPfrG4VASxbGrgOqgHpj5Duzkfx8Vl/VFOUF0=;
	b=HNkGKcmIJ5LViW0lrNe0sq6eu+FG5TQ9kk9xwCzMgwK49gImg8epZRMBrqrEJiahRXA75C
	TFku44yN7c3r6xcXnJqBjTb9lBZLNWd9r8DonugkwvuSZOg+8PRuN38c8qRcqTlPSwOagi
	HhjBFI+y0ykUQEPxXrXNlRVVS/IitJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-PeCzXuiKPk2GasMU42hR-Q-1; Wed,
 20 Nov 2024 22:18:01 -0500
X-MC-Unique: PeCzXuiKPk2GasMU42hR-Q-1
X-Mimecast-MFC-AGG-ID: PeCzXuiKPk2GasMU42hR-Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1A421956077;
	Thu, 21 Nov 2024 03:17:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 335FB1956086;
	Thu, 21 Nov 2024 03:17:43 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:17:38 +0800
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
Subject: Re: [PATCH v5 7/8] virtio: blk/scsi: replace
 blk_mq_virtio_map_queues with blk_mq_map_hw_queues
Message-ID: <Zz6mUlLliyL73Xyf@fedora>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-7-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-7-c472afd84d9f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Nov 15, 2024 at 05:37:51PM +0100, Daniel Wagner wrote:
> Replace all users of blk_mq_virtio_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_virtio_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


