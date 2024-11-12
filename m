Return-Path: <linux-pci+bounces-16490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C160D9C4DDE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 05:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F881F24DC8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33CB207A3E;
	Tue, 12 Nov 2024 04:48:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE64C91;
	Tue, 12 Nov 2024 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386919; cv=none; b=hLcFdoIAPNpLm/bCbFTTL6FoTGDEA6wW97xtLOZ3KC9vN/pbgBmvC0R0irYMAa3SGuXGPOMoJYrdTRgHuFt7ZMhrnixeqUV5WTYBHZihViKNrLpL8R9x0qmdt+GaElDSBJIaWlUqlu/w30xtD7IU2NtTFp6ct47CAudlevFkSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386919; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIM7Ubm3YtJAk3DPdJCU2IlxntBxbltsKgggGetkdo2v38eXfDGzCtRvH8jkLJzDx4XcK93gDtAR9+RhMb0sHXp+5FXlEg1Qt/Vj9nVaK21NVz3Erqkj4udfoDswRuLO7hAZcnRKJF8IePb1TiF19xOAoOhYACM/rasY9HH4uJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 766C168D09; Tue, 12 Nov 2024 05:48:34 +0100 (CET)
Date: Tue, 12 Nov 2024 05:48:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 5/6] virtio: blk/scsi: replace
 blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
Message-ID: <20241112044834.GC8883@lst.de>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org> <20241111-refactor-blk-affinity-helpers-v2-5-f360ddad231a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-5-f360ddad231a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


