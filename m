Return-Path: <linux-pci+bounces-14429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C739E99C3C6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4581C22A51
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846A14F126;
	Mon, 14 Oct 2024 08:43:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371D154C0F
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895384; cv=none; b=isM3VugtfempKq+esv3LqQtoWGlrK+Dkd4bc5KAI6H/f2Cd2IHMAy7UZ7KoxavUtWHJV45EjeIgC/TJF1GfMgyzvYE9rx+wcSM5qk8b9pC15oZl2GEaHDtHQb0so1ZmrAJ0v6DoUUqDq1KZ8YATCrLubqG0PMYCjwaOILnLaPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895384; c=relaxed/simple;
	bh=MV8bWDO9MKPjPHdVP4gEN6djkelDCFU8jZoCSscMxbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVZzDkDsvJ2Xu2t80Xr16J2pY9rFz9bGH6llW7Ej5Sw9EC1kKcx2+jGzeCTTt3/wu6YUAzrnQbhpm2FlRwSDmkkmpHgeAadpQQP5cAe/yriWzNFrihzHmwdh+y/FzxibZSKcJbI6gvux+Na/21zakq8jrIKtYk+14sQssDm81gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1A6E227AAC; Mon, 14 Oct 2024 10:42:58 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:42:58 +0200
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
Subject: Re: [PATCH v2 3/5] nvmef: Introduce the NVME_OPT_HIDDEN_NS option
Message-ID: <20241014084258.GB23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 11, 2024 at 09:19:49PM +0900, Damien Le Moal wrote:
> Introduce the NVME fabrics option NVME_OPT_HIDDEN_NS to allow a host
> controller to be created without any user visible or internally usable
> namespace devices. That is, if set, this option will result in the
> controller having no character device and no block device for any of its
> namespaces.
> 
> This option should be used only when the nvme controller will be
> managed using passthrough commands using the controller character
> device, either by the user or by another device driver.

That doesn't make any sense whatsover.  Why would you create a
passthrough controller to support PCIe?


