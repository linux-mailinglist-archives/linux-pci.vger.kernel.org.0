Return-Path: <linux-pci+bounces-24400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C5A6C3C8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A019A3B1BB6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9DB1EF08F;
	Fri, 21 Mar 2025 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCNZ6FgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C641EB9E5;
	Fri, 21 Mar 2025 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586918; cv=none; b=k/pkKszDyUhAATfSZQrY7Dnml4LNabCrVjoiYNNlDdufxnYlDehbP6SCCIfVIp319jHMSeu1wB26X0UNgEPbQnazo+3HisjnYx8R5fhtFJ3DOlWItRuM22jWTWPs1gxTgoK2KCaHh4Ogo8bDfy920nx+Jx9ZixJtUGUdXE2I7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586918; c=relaxed/simple;
	bh=tIog+CGELQ0s2081J61AkjpCpIfX2TI8undKZgLm9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RYcetoTKPK5yrSLY3/4KNejfbaFh2AJtksEC4EKNz2xxj0Ip8G7sQ80cj8fnAu8Oy7wdU4fsUdXDOFDZo1k+xYc0tAg4jhuPeaylU1Q7beyOw+cUw9+mWdePXgJglQg5L4oiM2JU5tlWM7fVyuIhwnfEBZumCtTwUaap8v5mV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCNZ6FgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA3BC4CEE3;
	Fri, 21 Mar 2025 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742586917;
	bh=tIog+CGELQ0s2081J61AkjpCpIfX2TI8undKZgLm9WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RCNZ6FgKFhqXc5Cch2P/yDJbGh9sMVfLk2ZyKxENlnancR1NrsJWZ8WWyxIPTBMS4
	 Cal3RErz3TlMo5RfUU1PeRCUzAkxcWPHmkgo1qdN/k64hMj/yBS53vJiUZ6LEQBor/
	 7vKn68jxUrH6zrlHdbvLaizXYgI9iKPffYWTY7+8huezOUZDzI8qilbh8/s+hrxexH
	 JQL6zGsltIE9k7BHGUzlJtEyY4HNdmZXPLzOOwFSMjbaw+DGDhaqaTmcfUGldVe0CY
	 4pK1qJuulmTpE5nBYzywL3nRolHnm3ehvaRrrQTwsYrPz+BlA15ib4bW1+PK4PYrC3
	 a4sDum8btJMuQ==
Date: Fri, 21 Mar 2025 14:55:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, leonro@nvidia.com,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] PCI: Fix NULL dereference in SR-IOV VF creation error
 path
Message-ID: <20250321195515.GA1142211@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310084524.599225-1-shayd@nvidia.com>

On Mon, Mar 10, 2025 at 10:45:24AM +0200, Shay Drory wrote:
> Add proper cleanup when virtfn setup fails to prevent NULL pointer
> dereference during device removal. The kernel oops[1] occurred due to
> Incorrect error handling flow when pci_setup_device() fails.
> 
> Fix it by introducing pci_iov_scan_device() which handle virtfn
> allocation and setup properly, instead of invoking
> pci_stop_and_remove_bus_device() whenever pci_setup_device is failed.
> This prevents accessing partially initialized virtfn devices during
> removal.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 00000000000000d0
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 22 UID: 0 PID: 1151 Comm: bash Not tainted 6.13.0+ #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:device_del+0x3d/0x3d0
> Call Trace:
>  <TASK>
>  ? __die+0x20/0x60
>  ? page_fault_oops+0x150/0x3e0
>  ? exc_page_fault+0x74/0x130
>  ? asm_exc_page_fault+0x22/0x30
>  ? device_del+0x3d/0x3d0
>  pci_remove_bus_device+0x7c/0x100
>  pci_iov_add_virtfn+0xfa/0x200
>  sriov_enable+0x208/0x420
>  mlx5_core_sriov_configure+0x6a/0x160 [mlx5_core]
>  sriov_numvfs_store+0xae/0x1a0
>  kernfs_fop_write_iter+0x109/0x1a0
>  vfs_write+0x2c0/0x3e0
>  ksys_write+0x62/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")
> CC: Keith Busch <kbusch@kernel.org>
> Change-Id: I7cee1123c90ce184661470dcafab45cec919bc72
> Signed-off-by: Shay Drory <shayd@nvidia.com>

Applied to pci/resource for v6.15, thanks!

I like how pci_iov_scan_device() turned out.

---
> changes from v1:
> - add pci_iov_scan_device() helper (Bjorn)
> ---
>  drivers/pci/iov.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9e4770cdd4d5..9f08df0e7208 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -285,23 +285,16 @@ const struct attribute_group sriov_vf_dev_attr_group = {
>  	.is_visible = sriov_vf_attrs_are_visible,
>  };
>  
> -int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> +static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
> +					   struct pci_bus *bus)
>  {
> -	int i;
> -	int rc = -ENOMEM;
> -	u64 size;
> -	struct pci_dev *virtfn;
> -	struct resource *res;
>  	struct pci_sriov *iov = dev->sriov;
> -	struct pci_bus *bus;
> -
> -	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> -	if (!bus)
> -		goto failed;
> +	struct pci_dev *virtfn;
> +	int rc = -ENOMEM;
>  
>  	virtfn = pci_alloc_dev(bus);
>  	if (!virtfn)
> -		goto failed0;
> +		return ERR_PTR(rc);
>  
>  	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>  	virtfn->vendor = dev->vendor;
> @@ -314,8 +307,34 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  		pci_read_vf_config_common(virtfn);
>  
>  	rc = pci_setup_device(virtfn);
> -	if (rc)
> -		goto failed1;
> +	if (rc) {
> +		pci_dev_put(dev);
> +		pci_bus_put(virtfn->bus);
> +		kfree(virtfn);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return virtfn;
> +}
> +
> +int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> +{
> +	int i;
> +	int rc = -ENOMEM;
> +	u64 size;
> +	struct pci_dev *virtfn;
> +	struct resource *res;
> +	struct pci_bus *bus;
> +
> +	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> +	if (!bus)
> +		goto failed;
> +
> +	virtfn = pci_iov_scan_device(dev, id, bus);
> +	if (IS_ERR(virtfn)) {
> +		rc = PTR_ERR(virtfn);
> +		goto failed0;
> +	}
>  
>  	virtfn->dev.parent = dev->dev.parent;
>  	virtfn->multifunction = 0;
> -- 
> 2.38.1
> 

