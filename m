Return-Path: <linux-pci+bounces-16577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940AA9C5DE0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AA6282295
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B220D4FC;
	Tue, 12 Nov 2024 16:54:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF292003D6;
	Tue, 12 Nov 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430479; cv=none; b=BjZPvCDBvGpD9PVt79iBnjMt2C5znaYavBRDYMExJNYga4wSTEIJPzDAzsMTDzs64rn/jHppfObS63VZXltkKyj9YwNMbJU5brniycxMsewVOWzvK6i2gHI2rkPuAXe2ID92WLXJ07oTOpNhKVKOr8Ks8zXyyYk3wj1Evi+6lK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430479; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwHGnAcFip0XuPkyZhPQO6d91qj6fY4hZuLl0OkzGfSnnuzBlfxckpZYdHk7g1CxcYL0Lhm2Cn1gJ7/H+EqkGCoO/fD2mXzuoFTYemOlJM77FQVICw9f6ye03T2awgxMczFPbBvWF9uc03j5avUi2KQkHOmF18rLSlFYAHRr+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6192368D0D; Tue, 12 Nov 2024 17:54:33 +0100 (CET)
Date: Tue, 12 Nov 2024 17:54:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/8] PCI: hookup irq_get_affinity callback
Message-ID: <20241112165433.GB20057@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


