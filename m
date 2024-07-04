Return-Path: <linux-pci+bounces-9793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43199273B8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAED288378
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC961AB53B;
	Thu,  4 Jul 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uFhAScAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019C1A0730;
	Thu,  4 Jul 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088005; cv=none; b=TD+UUtZIoGlZoT16RG13rmI17WWY+Tl/VBmeIIl+rZ3Vk630RNXVHnLaFP1ql0ERvQVkihHN1CfRaTKzwt7DrYclkDiZpFc/Dvp79cyIq1s4wNtcb6OjA5eQMuWaCwLyx+Gcv4VM88vjoLfi3xrweL3O1dYs5XtkCwfScQD6+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088005; c=relaxed/simple;
	bh=ri7ZVe86JKjzpqC5bIJZsfQCruCljNSMit5y3s9O10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxrB4e+rMvB1UGf5wosN1Hh80FLQ6hq8zwZ7MCwD7zv+KCrjfqI6vU3j0dL8r1EpmQPNWJEJciDt/UDT+aAGWkasKUC0xCBqz+BWSD2xtmXYfBXzkyIHJ70Ag6sRJgXvDwWNyn2yDaLRToFZvFBPAOXgPdOdb92JJpE5aruxaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uFhAScAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD0C3277B;
	Thu,  4 Jul 2024 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720088005;
	bh=ri7ZVe86JKjzpqC5bIJZsfQCruCljNSMit5y3s9O10Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFhAScAXFiwChxa8HylNZvkMtjjuThUbvzB34mYnKlzx+5MU5uBA4sRmI3pBCUeD0
	 FZbgnynyDvA/kEjLszVgvuVyfo1birpuzzKcO11QVrLAtH9IoUdsGpSSnGFHstEGkg
	 hSwSk0SAvhFTd3U8yYSpgPZdR9YZFWlAKe12wHg0=
Date: Thu, 4 Jul 2024 12:13:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 13/18] sysfs: Allow bin_attributes to be added to
 groups
Message-ID: <2024070413-yeast-exposable-6d2d@gregkh>
References: <cover.1719771133.git.lukas@wunner.de>
 <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>

On Sun, Jun 30, 2024 at 09:48:00PM +0200, Lukas Wunner wrote:
> Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
> introduced dynamic addition of sysfs attributes to groups.
> 
> Allow the same for bin_attributes, in support of a subsequent commit
> which adds various bin_attributes every time a PCI device is
> authenticated.
> 
> Addition of bin_attributes to groups differs from regular attributes in
> that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
> vis-à-vis sysfs_add_file_mode_ns().
> 
> So call either of those two functions from sysfs_add_file_to_group()
> based on an additional boolean parameter and add two wrapper functions,
> one for bin_attributes and another for regular attributes.
> 
> Removal of bin_attributes from groups does not require a differentiation
> for bin_attributes and can use the same code path as regular attributes.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

