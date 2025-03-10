Return-Path: <linux-pci+bounces-23360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E5AA5A35B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBDE1756A2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A893237706;
	Mon, 10 Mar 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHbrf96w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2A23645D;
	Mon, 10 Mar 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632182; cv=none; b=F2j0Z6p9xx5g9IqeAO5ERv4xL5s7o5bAUuTswcOlNqwJ8sbB9LpZl8+WijDaemLgWV0h1OzLIiRdsZOQLbUmnyCKU3IHQpS5wXvK1mpVS16cWMRnFj9obJAJnLN1n9fEzdknWb9hCT2XtVHZTQAvO0txV7BpgEaNU6WqxYaw1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632182; c=relaxed/simple;
	bh=B1dwEYHZKnLt80ZUErOw0CDO1S8uFBV9OslqHOT3lqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VkjuAFGYZwDSNlSdQi2E7fM0MovpGMqk30P6zHaHtpUvRDctaEWHu/wx9Rwed0zsbojMAmEvRCaUoIMReDTKEi8LQHv6Er2RYsxerqdX0GKy82mQ6Slp1arJ5oNKu7GXRTAOLCPbhMjzKWJ8gocyOrPfprqpVWQ9ZHP+tuQIwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHbrf96w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B62FC4CEEC;
	Mon, 10 Mar 2025 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632182;
	bh=B1dwEYHZKnLt80ZUErOw0CDO1S8uFBV9OslqHOT3lqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pHbrf96wz8OzDHLNDfbXY1BIyfwMdFcuG5XHQVwk4xV5A53jiJy+bC9xGKa7qzoE+
	 jxu825YojH3DcmmsoSt0U8j5bNu862tTht9+pYHrcGQwV2ITXkXi54j2ibmAkOMbbf
	 GdkLKyobc3HxMEhLPjTBDPjDS7AgVu8+c5pG0lslbs00ScJrHr72ODuU937MipHLbh
	 7UiOuQ0oA0X96c7RtG4nsRua6CDyuDbrBnw3pNVBSXNyNEFGN0p10dSixIuQJ031k8
	 gL/nLbKwBD4S9Q56DnlYrHHzy1EldzitQyqyN1rRFrnClGKOS8BU1PULZpe9JHFJfU
	 fjTd4GeUXnAGg==
Date: Mon, 10 Mar 2025 13:43:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Todd Kjos <tkjos@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Log debug messages about reset method
Message-ID: <20250310184300.GA561876@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303204220.197172-1-helgaas@kernel.org>

On Mon, Mar 03, 2025 at 02:42:20PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Log pci_dbg() messages about the reset methods we attempt and any errors
> (-ENOTTY means "try the next method").
> 
> Set CONFIG_DYNAMIC_DEBUG=y and enable by booting with
> dyndbg="file drivers/pci/* +p" or enable at runtime:
> 
>   # echo "file drivers/pci/* +p" > /sys/kernel/debug/dynamic_debug/control
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/reset for v6.15.

> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..3d13bb8e5c53 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5230,6 +5230,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int i, m, rc;
> +	const struct pci_reset_fn_method *method;
>  
>  	might_sleep();
>  
> @@ -5246,9 +5247,13 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  		if (!m)
>  			return -ENOTTY;
>  
> -		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_DO_RESET);
> +		method = &pci_reset_fn_methods[m];
> +		pci_dbg(dev, "reset via %s\n", method->name);
> +		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
>  		if (!rc)
>  			return 0;
> +
> +		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
>  		if (rc != -ENOTTY)
>  			return rc;
>  	}
> -- 
> 2.34.1
> 

