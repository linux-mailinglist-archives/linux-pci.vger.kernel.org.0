Return-Path: <linux-pci+bounces-14937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDB9A65CB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276A81C21F23
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0E1E1C19;
	Mon, 21 Oct 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/vsJPUn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424881946A8
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508686; cv=none; b=MosF0ihvK99n/9mWBlxxlWBIr89zSlPvsioJHhPfR8LWgKsgTm3gyoPDOwnrnJ3lOblxBjKzwJst+qkxgqz7Ks2/WSj8CWr0gzQtlue8hEO0UIOOv7eHlxXqilnCNsgmzQbQ9/jrKojo4bcBYXvZmpCipWMSXvsU3LVJ/rr/A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508686; c=relaxed/simple;
	bh=gevUG9ZerobcgVv911P+SgOjgYIga+2NvNywrrk2CQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELKObtGi50icD+WLyYD01CWPeyyJdUDIQz1FrQtZ/YHeJ3URuUgvVXZ93toNZPEHDyzvvuoL76mp1w9y0qT4tvaTUWiZzaKG1G+wf6XbVekmWdcsdGSiNPepKvqUk9HzGp0Xa7RNUsN9SQbhN5Fsz6ZdxXIFkloylVVBPs1t16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/vsJPUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E77C4CEC3;
	Mon, 21 Oct 2024 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729508685;
	bh=gevUG9ZerobcgVv911P+SgOjgYIga+2NvNywrrk2CQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/vsJPUnKSZrlRDgh6VdahjCeBH16TNYKg89+qGgv5SYyxlsiyrTArorCHnvI+X6u
	 3cLfyXCFaL3Fbo04vGab7kh+EpC+lMeGFnZzJ7egm8/jUDusV4g5FowjLwGGkq9syv
	 fAJiMLE70Itd9HR9ZZ2PUstDy/Y4x3JntdJ6HZ28=
Date: Mon, 21 Oct 2024 13:04:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <2024102148-helium-elk-b100@gregkh>
References: <20241018222213.GA764583@bhelgaas>
 <757d1cda-875b-4135-8b3e-110154a9543e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757d1cda-875b-4135-8b3e-110154a9543e@linux.alibaba.com>

On Mon, Oct 21, 2024 at 10:04:03AM +0800, Guixin Liu wrote:
> > This proc interface feels inherently racy.  We keep track of the
> > current item (n) in a struct seq_file, but I don't think there's
> > anything to prevent a pci_dev hot-add or -remove between calls to
> > pci_seq_start().
> Yes, maybe lost some information this time.
> > 
> > Is the proc interface the only place to get this information?  If
> > there's a way to get it from sysfs, maybe that is better and we don't
> > need to spend effort optimizing the less-desirable path?
> 
> This is the situation I encountered: in scenarios of rapid container
> 
> scaling, when a container is started, it executes lscpu to traverse
> 
> the /proc/bus/pci/devices file, or the container process directly
> 
> traverses this file. When many containers are being started at once,
> 
> it causes numerous containers to wait due to the locks on the klist
> 
> used for traversing pci_dev, which greatly reduces the efficiency of
> 
> container scaling and also causes other CPUs to become unresponsive.
> 
> 
> User-space programs, including Docker, are clients that we cannot easily
> modify.
> 
> Therefore, I attempted to accelerate pci_seq_start() within the kernel.
> 
> This indeed resulted in the need for more code to maintain, as we must
> 
> ensure both fast access and ordering. Initially, I considered directly
> 
> modifying the klist in the driver base module, but such changes would
> 
> impact other drivers as well.

I am not opposed to any driver core changes where we iterate over lists
of objects on a bus, but usually that's not a real "hot path" that
matters.  Also, you need to keep the lists in a specific order, which I
do not think an xarray will do very well (or at least not the last time
I looked at it, I could be wrong.)

I understand your need to want to make 'lspci' faster, but by default,
'lspci' does not access the proc files, I thought it went through sysfs.
Why not just fix the userspace tool instead if that's the real issue?

Just because you can modify the kernel, doesn't mean you should, often
the better solution is to fix userspace from doing something dumb, and
if it is doing something dumb, then let it and have it deal with the
consequences :)

thanks,

greg k-h

