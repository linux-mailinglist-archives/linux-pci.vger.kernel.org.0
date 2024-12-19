Return-Path: <linux-pci+bounces-18751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25E9F7428
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 06:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C43188247F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 05:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974871F8ACD;
	Thu, 19 Dec 2024 05:45:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A91FA243
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587150; cv=none; b=JBmMilSRrTMMLMy7xxPMn+hBI2zvTopc7jnL3OQDHgcot9PIjxz6aoN2mQRtXr8abfGbPab58HaAozu07Ll//kZKQUbflKoxCODMLT1E4lizetXyirrzovZ0z1k4o54tlzhZ5NV/Q4sq+kVExkwmjJyW27HbV779FtvCZP4/P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587150; c=relaxed/simple;
	bh=AXKENok961A+Wg36pBRSS+QZh5uuofOrb4MrR7Cj/Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON9zlSj7+Wgi1lZFhB5jJnF2hU/vkCDs0kasQ1nkn/usAkr1/oEbji9/hBvINl9eCSnmij1snuAr2QJjZ74JvzzOfdUf8oRxGyOpaKDPuvxrOndmTEYhrkUZI4xkBDOgFBACL6QsK0ilNJYP6awva96KQb0deuok0v82sHxeKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5826668AFE; Thu, 19 Dec 2024 06:45:43 +0100 (CET)
Date: Thu, 19 Dec 2024 06:45:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241219054542.GB18853@lst.de>
References: <20241212113440.352958-1-dlemoal@kernel.org> <20241212113440.352958-18-dlemoal@kernel.org> <20241217085355.y6bqqisqbr5kbxkl@thinkpad> <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 06:35:33AM -0800, Damien Le Moal wrote:
> >> +static inline u32 nvmet_pciep_bar_read32(struct nvmet_pciep_ctrl *ctrl, u32 off)
> >> +{
> >> +	__le32 *bar_reg = ctrl->bar + off;
> >> +
> >> +	return le32_to_cpu(READ_ONCE(*bar_reg));
> > 
> > Looks like you can use readl/writel variants here. Any reason to not use them?
> 
> A bar memory comes from dma_alloc_coherent(), which is a "void *" pointer and
> *not* iomem. So using readl/writel for accessing that memory seems awefully
> wrong to me.

Using readl/writel not only sounds wrong, but fundamentally is wrong.
readl/writel should only be used on pointers returned from ioremap and
friends.  On some architectures it might use entirely different
instructions from normal loads and stores, and on others it needs to
be a lot more careful.

> NVMe BAR cannot be fixed size as its size depends on the number of queue pairs
> the controller can support. Will check if the 4K alignment is mandated by the
> specs. But it sure does not hurt...

Keeping it 4k alignment will make everyones life simpler.


