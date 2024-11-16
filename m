Return-Path: <linux-pci+bounces-16955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD29CFD06
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 08:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BE8287F97
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFB1922C4;
	Sat, 16 Nov 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOQCUicn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486918F2FC;
	Sat, 16 Nov 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731743055; cv=none; b=r26tXw1wlWs2hI4J+dJv36VA3iuI1cU7Jk31ILHtXrX8IZBzDOXGPjGXLw0Ki3FCSWbbvTf1SM1TLlzZOTVKXFgetVP6G6SNQ0P7KgSDNuNjY31jirDZRSSEbPaRaWDhpOIje1b2wAyIdYd6RfOLZ7JjK6XchDzhf7EhtfZWCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731743055; c=relaxed/simple;
	bh=KjZjAEkpsSJVk26vPJowBhePl2ldo8B8xA9M+L+OP1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TolBG1P4YqFfEygud6Xq2kRbCB3zETKmJfnNpT/yd3BEPSZibmPXFj1BDCkeHupHC6iZ8/dj7HKd+o8auCQI1lloTL560kKjnUyw2OU4ebb3KymUFOq0MSL/Q6CkSkID8/gsO5iIYMNZJ1TEN0Z4uwBioOlv9d+bxjQh2gjN/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOQCUicn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5BC4CEC3;
	Sat, 16 Nov 2024 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731743055;
	bh=KjZjAEkpsSJVk26vPJowBhePl2ldo8B8xA9M+L+OP1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOQCUicnwHNNzRTBmMFH15E3g7z4J3tIJqz7Dr9Ale/FyqEtTpNLZfPxqhM19/8CY
	 E8lmIRCIY2Xcfm7maGcIKl1o/VmaE6VpJVF9DrbOnoeJS1bFBBLDCygNBuYtlN9iXn
	 Pdtrt352UODTQ6+/exPN8L8OXRJwaEyEG43NYmh4=
Date: Sat, 16 Nov 2024 08:43:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <2024111642-bush-violet-da1a@gregkh>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-1-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-1-c472afd84d9f@kernel.org>

On Fri, Nov 15, 2024 at 05:37:45PM +0100, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

