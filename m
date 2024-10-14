Return-Path: <linux-pci+bounces-14430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338099C3D2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA02808F7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA613D2BC;
	Mon, 14 Oct 2024 08:44:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AA14A0B5
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895469; cv=none; b=gZWnmnlndfWcvqfxaWQbbcK8tFFyeBI11tvtrE5FVi9119wosTP6X4cjuZxP94kSTH1PffFVlTcwMdE8DyY83w+VuMC23YSfYiTZDX93VUtZLmmMdTcfXpYq5wtGzUHIiVyFzzKSGZFFTvQesE3v0sogMhpR4nWiiQ5q8ng9h8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895469; c=relaxed/simple;
	bh=gC00YYLrV1biEby/WcuHE8B3ZoJo5ev5pGj7t3efG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp+vju1DbFTPNw+KCFoM3BtA5PQYVzwUbJWqqxe1a9fySYufNlGigtxG8tFPzKvrOP+sQfXOfrjbik3bTktb8aeXuU5PdHhbr36cFjpMahUJw/mekAOju7zOCxHI0m921aI9PuyzbxzQRcde4oySuYmW+1wnQWma51A0r1fvE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9A04227AAC; Mon, 14 Oct 2024 10:44:24 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:44:24 +0200
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
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20241014084424.GC23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

For one please keep nvme target code in drivers/nvme/  PCI endpoint is
just another transport and should not have device class logic.

But I also really fail to understand the architecture of the whole
thing.  It is a target driver and should in no way tie into the NVMe
host code, the host code runs on the other side of the PCIe wire.


