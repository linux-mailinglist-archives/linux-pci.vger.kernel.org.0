Return-Path: <linux-pci+bounces-14166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA699807D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886F628231B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B141D094F;
	Thu, 10 Oct 2024 08:28:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876011D07BE
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548881; cv=none; b=XuY+Qf0wB+jKins954icyIxjJ5k3A/jA7Aaksv4uoJIu3cuq1d4qLkQxWrJZxNXpe2aPlO6ulCHA4eAjH8ScGTGE2Y2AUESejjPhpuKcgUD8w69eG84YR/hrzR8zwHVv+atgAC/5qyiG7/c8GugMFcwJXQGtQXYAqBEyIbVIqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548881; c=relaxed/simple;
	bh=a4lwyihkjQ512CbZMA1kyuFLqeoHJrX5zYLjyIjS95U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BolVMST6UtWiJnk+I4Rk8KRRD05LYUVT5i/vGXBZB6rzV03UgaHZ6GVbQNDyv3kJs0fA03ZqaC049i9jKHZrwC607IhVT0iP0JC1rqaT/DW85q8vWlwnXLyGv3EUnoBda5JSk9RjIxxNzjTkvDCaH6Vw3UefuPF9CAKx7U2YJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FE63227A8E; Thu, 10 Oct 2024 10:27:55 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:27:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
Message-ID: <20241010082754.GA8319@lst.de>
References: <20241007044351.157912-1-dlemoal@kernel.org> <20241007044351.157912-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 07, 2024 at 01:43:47PM +0900, Damien Le Moal wrote:
> The code for nvmet_get_log_page_len() has no pedendency on nvme target
> code and only depends on struct nvme_command. Move this helper function
> out of drivers/nvme/target/admin-cmd.c and inline it as part of the
> generic definitions in include/linux/nvme.h. Apply the same modification
> to nvmet_get_log_page_offset().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

