Return-Path: <linux-pci+bounces-37988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B653BD6635
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429B14004B1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BABD2EACF9;
	Mon, 13 Oct 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHFFebKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AD246778;
	Mon, 13 Oct 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391634; cv=none; b=dcsQ5iXL+g9xaZDRGrM/j08h/XMXZYpilOt7plz4OZ/bX8S8gCJAH4abXFP5XFr1LaphcKbCuv/c1Qz5nZF2ALBY0ker2oUZaz2pDD34U9zZe/9PgqKFKQ6olop2WkOVnGSUybcSbXAVqKQI1DyPEJoVgVdyCHTShvuKKSGuYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391634; c=relaxed/simple;
	bh=lSBBgblcFkXBDIkspp2NfyRR5bmbe73dKuE4WTS8jDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d5dNi61uV6IerjR9QsknmRjkKBjZAfFXqia+80UQct8lWuujHcpJElVxr2IUYnixmNEMXNWOEv8HHPXEtgty5Z2usF/0nFyRfyxNVe2Wpfp4kEgqvOEla44BwubkVFK0fVS1OE+XYmCKD55q8vf43p/DzjN1MbeJ2BMG+AO70Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHFFebKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36141C4CEE7;
	Mon, 13 Oct 2025 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391634;
	bh=lSBBgblcFkXBDIkspp2NfyRR5bmbe73dKuE4WTS8jDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bHFFebKjDxDGEhGMg8dyCjd/ziBHfpvK4q3BORNkHxy6RFK/HkSlHnxHNZaJcU+fv
	 zgYNkeG2NOCR2WMjzuK10Vf/JLGyt3NSAxSKOUzzT0w5JTXWhTMH32B9e0gORUeeLa
	 1B12+EA2ExEmvA5CComPNc2hUZJEl5zFi6c8BmDYcKkO8PvsZJvnDB/9hor3cQUOGU
	 /QUyqn6Dvok+J5IxdL81O7iIDzDNtYNb4ulIBvHSzB54DBrMiFmeTWmaggQA1X05Jp
	 C15zzfjFk3IQ5Xx8Mer/RaiJfA7uvnXQ2Osayog3FfNYUjEDiteOy940e15RnpuBah
	 9q8TNLDolTX2g==
Date: Mon, 13 Oct 2025 16:40:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, christian.bruel@foss.st.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
Message-ID: <20251013214033.GA865945@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930023809.7931-1-bhanuseshukumar@gmail.com>

On Tue, Sep 30, 2025 at 08:08:09AM +0530, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
> 
> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> [  474.710934] Call trace:
> [  474.710995]  __might_resched+0x130/0x158
> [  474.711011]  __might_sleep+0x70/0x88
> [  474.711023]  mutex_lock+0x2c/0x80
> [  474.711036]  pci_epc_get_msi+0x78/0xd8
> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
> 
> The BUG arises because the EP's pci_epf_test_doorbell_handler is making an
> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
> 
> To fix the issue convert hard irq handler to a threaded irq handler to allow it
> to call functions that can sleep during bottom half execution. Register threaded
> irq handler with IRQF_ONESHOT to keep interrupt line disabled until the threaded
> irq handler completes execution.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>

Thanks for the fix!  It looks like you posted it during the v6.18
merge window, so it was a little bit too late to be included in the
v6.18 changes, but it looks like good v6.19 material.

Can you please:

  - Rebase to pci/main (v6.18-rc1)
  - Add a space before each "("
  - Remove the timestamps because they're unnecessary distraction
  - Add "()" after function names in commit log
  - s/irq/IRQ/
  - Rewrap the commit log to fit in 75 columns
  - Rewrap the code below to fit in 78 columns because most of the
    rest of the file does
  - Carry Niklas' Reviewed-by when you post the v3

> ---
>  Note : It is compiled and tested on TI am642 board.
> 
>  Change log. V1->V2: 
>   Trimmed Call trace to include only essential calls.
>   Used 12 digit commit ID in fixes tag.
>   Steps to reproduce the bug are removed from commit log.
>   Link to V1: https://lore.kernel.org/all/20250917161817.15776-1-bhanuseshukumar@gmail.com/
>  	
>  Warnings can be reproduced by following steps below.
>  *On EP side:
>  1. Configure the pci-epf-test function using steps given below
>    mount -t configfs none /sys/kernel/config
>    cd /sys/kernel/config/pci_ep/
>    mkdir functions/pci_epf_test/func1
>    echo 0x104c > functions/pci_epf_test/func1/vendorid
>    echo 0xb010 > functions/pci_epf_test/func1/deviceid
>    echo 32 > functions/pci_epf_test/func1/msi_interrupts
>    echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>    ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
>    echo 1 > controllers/f102000.pcie-ep/start
> 
>  *On RC side:
>  1. Once EP side configuration is done do pci rescan.
>    echo 1 > /sys/bus/pci/rescan
>  2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
>   ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST
>   Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8..c9e2eb930ad3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -725,8 +725,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>  
> -	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
> -			  "pci-ep-test-doorbell", epf_test);
> +	ret = request_threaded_irq(epf->db_msg[0].virq, NULL, pci_epf_test_doorbell_handler,
> +				   IRQF_ONESHOT, "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
>  			"Failed to request doorbell IRQ: %d\n",
> -- 
> 2.34.1
> 

