Return-Path: <linux-pci+bounces-7908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A118F8D239A
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 20:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C518B21168
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F3A17106F;
	Tue, 28 May 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcht6+QW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D5171069;
	Tue, 28 May 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922630; cv=none; b=dXHXYFMdF+X/a4FLonBnj6uQ2l1G3+Cw4YMO+Qr99BQ1vceEb+mOS06AFnuNuRGNQuB2UgGAeWEBoKwWxkNOCEOwjXdY8n4AhdSSOSgpbqtCgPXaBTUHLt8J+dakrhTZ/lOwg8F7vZ2gLnwawdBDLm2/5urqOoplC3pPpU2+GsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922630; c=relaxed/simple;
	bh=FWibL0sEaU4RE9BpignSvuYHFALLjiDPkYf8ncX2AWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amlPVXme+etFSogNwtFpuisWEAX+qqL/Vg+yQMIIUSzVmviGJiQamyOZ1RcrKVqpSZGgzqCeBGhzZsl1ZeQZ/VYiXDSdUU5seLL/XeIJeysEQXKmwFYoAbiRU3nLVZhwpgdyxDmkHEZDSZ6JpIQ92zF6O5W0CiXf2i4X5S54DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcht6+QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBB1C3277B;
	Tue, 28 May 2024 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716922630;
	bh=FWibL0sEaU4RE9BpignSvuYHFALLjiDPkYf8ncX2AWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcht6+QWK7LsP821JNtNlWsWMvViBLiGeNi+xegUWdy33dJWPZ9pIOo0Q35++sH0X
	 h2dean6HlzUYbyyk96dSZk1j6AEKAydmiCKRkLQkDk2dQopoZf67KzChHeWuHGvPZP
	 0vIcrILZa27LQmTYSEOWR8xBnR6PSvofPZyy4LfJf0h0V4zsX7x0SwG4S6JzKdub6x
	 M4XKB9X8iw0OU4LVidWPPAGX3oJf+1scgrKnm+2hQdKJ1AF8a55kXGTU06nu/V72Dt
	 lztYqh92deyiMOSOYoGsIriLLFcKIfVc84b7X/USW3iPhwhEQE+Cq9NL24bgHl5Nak
	 Sc+N7ieqRqVvQ==
Date: Tue, 28 May 2024 20:57:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/3] Make pci/endpoint branch build
Message-ID: <ZlYpAGFgwgxnnBhZ@ryzen.lan>
References: <20240528130035.1472871-5-cassel@kernel.org>
 <20240528144452.GA307495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528144452.GA307495@bhelgaas>

On Tue, May 28, 2024 at 09:44:52AM -0500, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 03:00:36PM +0200, Niklas Cassel wrote:
> > The pci/next branch has currently not merged the latest pci/endpoint
> > branch.
> > 
> > Perhaps this delay in creating a new pci/next branch is because the
> > pci/endpoint branch currently fails to build.
> 
> The topic branches have things queued on them for build testing, but
> they haven't been merged to pci/next yet.  It's standard practice that
> we don't add v6.11 content to -next until v6.10-rc1 is tagged:
> https://lore.kernel.org/linux-next/20240523111023.7ade2aa4@canb.auug.org.au/
> 
> v6.10-rc1 was tagged 5/26, and 5/27 was a US holiday.  The topic
> branches will be merged to pci/next today.

Ok, great!

Although, perhaps you would want to defer merging pci/endpoint to pci/next
until the linker error has been fixed.

We have already gotten a bunch of reports of this on the linux-pci list:
https://lore.kernel.org/linux-pci/202405270544.yKgcokbA-lkp@intel.com/T/#u
https://lore.kernel.org/linux-pci/202405130815.BwBrIepL-lkp@intel.com/T/#u
https://lore.kernel.org/linux-pci/202405140344.glj9WfzM-lkp@intel.com/T/#u

Merging the branch to pci/next is guaranteed to have even move people hit
and complain about this error.


Kind regards,
Niklas

