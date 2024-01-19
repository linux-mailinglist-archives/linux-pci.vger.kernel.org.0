Return-Path: <linux-pci+bounces-2396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B97833108
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070E11C21D03
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02458237;
	Fri, 19 Jan 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut1qqGeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507B56B7B;
	Fri, 19 Jan 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705166; cv=none; b=jDbj6/ldT02dUb3x44RJZ36RdshS3sIwBO3x5f9QyA74wQdeSoxNGpq1rv/3fQBFqdsMmoB+qgu8j3rxHWEl1Bpu/RknGiu5dFiGXZCSRxUPuWF/6Ppgzng8SB4WEHGgig04vP6Qd85Aub/tN3uW7jUSexktQWAwVzy9conIdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705166; c=relaxed/simple;
	bh=R+D0jk/2xIKckQ4bRuHaV19Q6bC2783kDdOIqDI6aVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CrbIk61WmEG43c2Y05B4Q7DjkdFTnVKsgn3wqz2hW9m+Pdj7SeSSn21FlNbNWNkjM0zbWc5AgOAXfVEgIVjeutQDDqeCawrLRACshYYzhR+l5cZKwNMgl8rNezX5uda5jCIH8BI0UgWdpznKDW1eEXloHiH+9ZJ1Kzo53+tygRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut1qqGeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C5C433C7;
	Fri, 19 Jan 2024 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705705165;
	bh=R+D0jk/2xIKckQ4bRuHaV19Q6bC2783kDdOIqDI6aVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ut1qqGeKL6SDjjZnM3+TyodeE0wMlOB3DvZ4OZWLukoMnEEAB81JeMxten0zHXHV3
	 fMgjt/MR6sXA4prsQC61w6cjuW8P0GRqE7T1dLDT5CcfUMrMs1ZaQlS+7z4Q4/Rhaq
	 YC4fotRM1zaiBwkGaEMQTDhEnJriNKy76mOYqplqJ21GHCkvscDcd1XUj2Y053W8Yz
	 RdsHZPPpnwOYwVlOYESFQF5HrfJpzRe1ywTfdDBjhfLQpnQ8VY1E31A0eUFLAYE5Na
	 vNtUFQeMuY8JHdjwxWNAKQTINBj4zQycfk5GT7WQK0DNO7FL76GbyKtxhW4X2Cbdq6
	 LksvSEA7an54g==
Date: Fri, 19 Jan 2024 16:59:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/DPC: Fix TLP Prefix register reading offset
Message-ID: <20240119225923.GA191511@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240118110815.3867-1-ilpo.jarvinen@linux.intel.com>

On Thu, Jan 18, 2024 at 01:08:15PM +0200, Ilpo Järvinen wrote:
> The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
> 7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading
> from the first DWORD. Add the iteration count based offset calculation
> into the config read.

So IIUC the user-visible bug is that we print only the first PIO TLP
Prefix (duplicated several times), and we never print the second,
third, etc Prefixes, right?

I wish we could print them all in a single pci_err(), as we do for the
TLP Header Log, instead of dribbling them out one by one.

> Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..e5d7c12854fa 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -234,7 +234,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  
>  	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
>  		pci_read_config_dword(pdev,
> -			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
> +			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
>  		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
>  	}
>   clear_status:
> -- 
> 2.39.2
> 

