Return-Path: <linux-pci+bounces-11635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C909508A6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DE2848A8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB719F497;
	Tue, 13 Aug 2024 15:13:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016C198A05
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562002; cv=none; b=dPKJ2oP7nVXVAQDJbatfoVoKVK3sX/OWzvt4ockKaxq5kLOF3yg5oFifqJPyjSXig1E9yOQsNUfgMi+HyyB08pBX6XQ31kI1mSA+NAW9xigZKDKQ/lZIj6yEyvJA1T1YuQzJ4OQSiMAL3/P1eJAiEy34owD4gSrEXIaY/CNz1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562002; c=relaxed/simple;
	bh=XHnd2sfk7prcrK2btqjAkLHOBKM6t1c0RxkIVdYe7gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK2bxIYiRf8s+6aKeTwDIE3zQd3NcY28w+wUDP/7BCeqfZIO0FEuc8MyrFSt+Sw5lbxc5zAe0jCNQ9352o1C68YQnAefXHG85s8cuTiMSdOu2EkH2K/+YZskSWDZO+XPUxs/ngmX01Ae2kqbT7FfcANW4OzZqKNBE0QdSpngHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A64B868AFE; Tue, 13 Aug 2024 17:13:15 +0200 (CEST)
Date: Tue, 13 Aug 2024 17:13:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED
 management
Message-ID: <20240813151315.GA18084@lst.de>
References: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com> <20240813113024.17938-4-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813113024.17938-4-mariusz.tkaczyk@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Still looks good to me (despite the still pointless __packed):

Reviewed-by: Christoph Hellwig <hch@lst.de>


