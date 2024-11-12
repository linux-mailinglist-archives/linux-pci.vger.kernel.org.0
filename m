Return-Path: <linux-pci+bounces-16489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B19C4DD9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 05:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034701F24F1B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 04:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A40208217;
	Tue, 12 Nov 2024 04:48:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F684C91;
	Tue, 12 Nov 2024 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386890; cv=none; b=cesSrYoliLoB/IasgUmpR/lgeU2h1+CnTVBADgjkMia/SQ44+A0rEitmtSUAoztd3jS/RBcv7CYNylDHUloeeLcO36Ey7FfC7bRyFfDeUEInJgXJIuS3mWvMQa0JDXFUVpR7K/yjyGNZ7lbVuQjTkd2ezoQUfZP9WYYtIcpJG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386890; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3Egtw2O5EO73BcU0E8jSun4lvE7ejvZWuVZsgiq3g1QPL55N+DPg9a1FOCJzW2Zd7gpSPe7WQgupWSgNlU0N0pcaFtW+eAEmEWVcinLR2xYGKsfEIBG0d/gaNR3/CNcXXr8LEJLi80cNwBtfx7exf1vkZJPhz3E33mT6+WXVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF77868D09; Tue, 12 Nov 2024 05:48:04 +0100 (CET)
Date: Tue, 12 Nov 2024 05:48:04 +0100
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
Subject: Re: [PATCH v2 2/6] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Message-ID: <20241112044804.GB8883@lst.de>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org> <20241111-refactor-blk-affinity-helpers-v2-2-f360ddad231a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-2-f360ddad231a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


