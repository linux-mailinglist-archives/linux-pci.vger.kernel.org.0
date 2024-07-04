Return-Path: <linux-pci+bounces-9794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A689273BD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3312A1C20B8D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D601AB8E0;
	Thu,  4 Jul 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0Snfnhk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB61A0730;
	Thu,  4 Jul 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088053; cv=none; b=oHd9Pnx8zrxMNTFEi8nucf65sKyAi9RtM4p3XQa3ML+wqrftDtfdN5LTe6pwh3h6YjbZWI/SPRpzDOdIuOyY5t9+6D0FlwV8RJGnTo6S6In/B6kF5rSDoaZzh0493nSQYVCb5PHEpdWlriHlwAN1CfWuS5wGMZUoaSNb8isEtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088053; c=relaxed/simple;
	bh=//9ECFtIGDXgr32mbIQKVc5AnOz194f6V+ACEj8MpgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDHPo9PsbvbxWrc7Tyonm5fqF5tpTxLNpsAkjybA5DGWlpLjkJI0xdyDPSEYplJWHLYFBbi6afjdHzdPFw/0cIV6OuoQ/l3w3w4zTpqRFO+J9Z6iKd2roBK0JellRR52i2Ww2fP0Q/8fzSJOZWOI0HukigTNEid9gPcieTgphrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P0Snfnhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE24C3277B;
	Thu,  4 Jul 2024 10:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720088052;
	bh=//9ECFtIGDXgr32mbIQKVc5AnOz194f6V+ACEj8MpgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0Snfnhkj7uh2n7nFP/HQF3ZtnaVvZYR1xwzsS0dArbNGUFC5+LHN2ThdInM8ZElo
	 MJLN06S9UKEw3wfnzRZr31xLe4MeAKuMCFZEoz5h+nghEzu2GncPBwjAYYtjopSi+0
	 eaHIaJSdXhwv/RyirzP6bvWuHIUBHv8L/40yEph0=
Date: Thu, 4 Jul 2024 12:14:10 +0200
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
Subject: Re: [PATCH v2 14/18] sysfs: Allow symlinks to be added between
 sibling groups
Message-ID: <2024070459-valley-partly-88e2@gregkh>
References: <cover.1719771133.git.lukas@wunner.de>
 <7b4e324bdcd5910c9460bb5fc37aaf354f596ebf.1719771133.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4e324bdcd5910c9460bb5fc37aaf354f596ebf.1719771133.git.lukas@wunner.de>

On Sun, Jun 30, 2024 at 09:49:00PM +0200, Lukas Wunner wrote:
> A subsequent commit has the need to create a symlink from an attribute
> in a first group to an attribute in a second group.  Both groups belong
> to the same kobject.
> 
> More specifically, each signature received from an authentication-
> capable device is going to be represented by a file in the first group
> and shall be accompanied by a symlink pointing to the certificate slot
> in the second group which was used to generate the signature (a device
> may have multiple certificate slots and each is represented by a
> separate file in the second group):
> 
> /sys/devices/.../signatures/0_certificate_chain -> .../certificates/slot0
> 
> There is already a sysfs_add_link_to_group() helper to add a symlink to
> a group which points to another kobject, but this isn't what's needed
> here.
> 
> So add a new function to add a symlink among sibling groups of the same
> kobject.
> 
> The existing sysfs_add_link_to_group() helper goes through a locking
> dance of acquiring sysfs_symlink_target_lock in order to acquire a
> reference on the target kobject.  That's unnecessary for the present
> use case as the link itself and its target reside below the same
> kobject.
> 
> To simplify error handling in the newly introduced function, add a
> DEFINE_FREE() clause for kernfs_put().

Nice!

> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

