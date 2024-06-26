Return-Path: <linux-pci+bounces-9317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B116918599
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5494287ED8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9118A928;
	Wed, 26 Jun 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0vHs/2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838481802B2;
	Wed, 26 Jun 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415317; cv=none; b=S9zZ1d8sqp8QjBTm0wHOIqNMIZu7pchO4LsVOZqiNcBcxofrV9IDKPuFQUpJfwk/1zrQfIKbeuzEGA8iZqSx4nTXYEK0IASPhFNCyZ2ZhnV4goAaRT27kDko5c6Qbm9aO4h2IpgBZXGgFQRopbXV92xvoWqJxFk+DSvlL5QTCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415317; c=relaxed/simple;
	bh=8IQ81VX6qQNbtyEW2rTC8cmOk7EiV9iaDpCs1/CLdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ic7ExBUYuoSa1bPZm7GnCPv7frwqiZxkypIHBcy4kR0f2HP+GzFufeHblH5IHHEFyWxT9HB0zycqftlX76BShaJ4Gm4LteYwI4PSeOFE8AyhYrh7quM+KmewEI1nyOT5/L6066g5vKSghzEK1SKFF63MlDif4sthO3lkOVcejBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0vHs/2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB84BC116B1;
	Wed, 26 Jun 2024 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415317;
	bh=8IQ81VX6qQNbtyEW2rTC8cmOk7EiV9iaDpCs1/CLdPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h0vHs/2KoepLvPUkxh7l7hpYnG+XDO/Z5oN40qf9ZL8/IVehfV6gR6aanzPZNUSTH
	 CMw4cgUZ0Ox6aRcmlamMhwlKQ90GL1J8TNwVKsjkONV62nD1WQ+QmNhCReQD1BzAUs
	 DpD8FGfuSLnLLR+6fYrU9D+bihlt8NF/X1/f09rFNDFsRvCUWF472j5r3VTmbpDHc/
	 qDlF0B1d3p2JVTp8kaugsjNl0pGKnxqFeZahlnwQCSl89K7q6v/szkE522Bw2ZTVKH
	 F6z5zwlQhUtbCrmSFUfb5QsDbdWbDTg3/NBRkJH5UlRRJ89ULucJi5g7hlokaWgN3f
	 gx5xOQ0cJayQA==
Date: Wed, 26 Jun 2024 10:21:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	brking@linux.vnet.ibm.com, gbatra@linux.ibm.com,
	aneesh.kumar@kernel.org, christophe.leroy@csgroup.eu,
	nathanl@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com,
	tpearson@raptorengineering.com, mahesh.salgaonkar@in.ibm.com
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
Message-ID: <20240626152154.GA1467164@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624121052.233232-2-krishnak@linux.ibm.com>

I expect this series would go through the powerpc tree since that's
where most of the chance is.

On Mon, Jun 24, 2024 at 05:39:27PM +0530, Krishna Kumar wrote:
> Description of the problem: The hotplug driver for powerpc
> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
> hot-unplug/disable the PCIe switch/bridge from the PHB.
> 
> Root Cause of Crash: The crash is due to the reason that, though the msi
> data structure has been released during disable/hot-unplug path and it
> has been assigned with NULL, still during unregistartion the code was
> again trying to explicitly disable the msi which causes the Null pointer
> dereference and kernel crash.

s/unregistartion/unregistration/
s/Null/NULL/ to match previous use
s/msi/MSI/ to match spec usage

> Proposed Fix : The fix is to correct the check during unregistration path
> so that the code should not  try to invoke pci_disable_msi/msix() if its
> data structure is already freed.

s/Proposed Fix : The fix is to// ... Just say what the patch does.

If/when the powerpc folks like this, add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gaurav Batra <gbatra@linux.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Brian King <brking@linux.vnet.ibm.com>
> 
> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
> ---
>  drivers/pci/hotplug/pnv_php.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 694349be9d0a..573a41869c15 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -40,7 +40,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>  				bool disable_device)
>  {
>  	struct pci_dev *pdev = php_slot->pdev;
> -	int irq = php_slot->irq;
>  	u16 ctrl;
>  
>  	if (php_slot->irq > 0) {
> @@ -59,7 +58,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>  		php_slot->wq = NULL;
>  	}
>  
> -	if (disable_device || irq > 0) {
> +	if (disable_device) {
>  		if (pdev->msix_enabled)
>  			pci_disable_msix(pdev);
>  		else if (pdev->msi_enabled)
> -- 
> 2.45.0
> 

