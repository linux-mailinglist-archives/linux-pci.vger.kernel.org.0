Return-Path: <linux-pci+bounces-18752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F59F742A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 06:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986861881FAC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBDA6EB7C;
	Thu, 19 Dec 2024 05:47:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746F13C3F2
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587227; cv=none; b=ZsMWIlXqIUTt+iTjhdOlw/1e6FOOnmiTg3+zYxyXRY5jPsHWmDYj/5f7OYNhIEPJHznXf+CApJ079++T5Ktc3Y+w/N/wtWUVEikqO1P+dQr5EyST0K85OrdTqEpDx50uyoRtWszn4NvucH56FTK+3iLgiIVbgKRAs4lWsr8F3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587227; c=relaxed/simple;
	bh=yfIkvlMknPO6sKbENsm0KDdAeN3ZXoUkQGbksLDlNzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgklTB+7ER6Vm64dd4EhJrc7VG/vj6EZGMaxsO/xXKyykhfNvXcen5gtSQbiZXh1DZXUlQJP1pL8cm6J4KulynxE7+CviBESWvnKmOPahAIdmYwr0yI15iDvsB3/b0yctqfw3e2X7KMKmtG+rDHRc87r6ktCa5Y1/zfnhpj5sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5CEB68AFE; Thu, 19 Dec 2024 06:47:01 +0100 (CET)
Date: Thu, 19 Dec 2024 06:47:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241219054701.GC18853@lst.de>
References: <20241212113440.352958-1-dlemoal@kernel.org> <20241212113440.352958-18-dlemoal@kernel.org> <20241217085355.y6bqqisqbr5kbxkl@thinkpad> <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org> <20241217164149.vuqwtthlykn7bobj@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217164149.vuqwtthlykn7bobj@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 10:11:49PM +0530, Manivannan Sadhasivam wrote:
> 'iomem' is just a token that is used by sparse tool to verify correctness of
> MMIO address handling.

That is true, but we don't have the token just for fun, but because iomem
needs to be treated differently.

> I know that the memory here is returned by
> dma_alloc_coherent() and is not exactly a MMIO. But since you are using
> READ_ONCE() and le32_to_cpu() on these addresses, I thought about suggesting
> readl/writel that does exactly the same internally. If you do not need ordering,
> then you can use relaxed variants as well.

No, using readl/writel on dma_alloc_coherent buffers is simply wrong.


