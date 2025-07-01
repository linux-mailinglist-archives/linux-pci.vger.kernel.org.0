Return-Path: <linux-pci+bounces-31185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B5AF001D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CF51C011E7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CAD27E07A;
	Tue,  1 Jul 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1ero2cp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEE27E05F;
	Tue,  1 Jul 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387952; cv=none; b=t/9CKBFMWJBKCRBx53QCwvLAYYQeDm06WsIH3CGIegCloHfzysd/7B9SI5DGr0z6KjN0bn1xKG1vFI6PfysRM3dfkvv5sGuUwGik7K+YUoZa6J49pKb6nGvvGCfWGbfDFU3Hl7JRjz/nFLJRTubNMCxzN4RRELdWuyhHoTs7Iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387952; c=relaxed/simple;
	bh=KLnOYWMx8dtRRlrLc1EiKeuVmR84Zv0deauTJHdmEMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KquL+Ek6s37qWdS8ZeElNZo5dSlMCeNLfNSbqG4nh3Ysgcywblpa8zSVsxjZC1VgLvUHtZH3OqhbOU2fqGaG3v6leroZrXMqokvI7Z4vG6MIRr633nEdQRBZjUuBOMbp0eoHz5td3V/kiHmAiQIN33wjv2mRFuEjhqD5xB+dZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ero2cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683DCC4CEEB;
	Tue,  1 Jul 2025 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751387951;
	bh=KLnOYWMx8dtRRlrLc1EiKeuVmR84Zv0deauTJHdmEMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S1ero2cpFfF+jYqpi6yPUy6RqrRUXhpbNPqmgtwj6rJOzkBSUwptSOwERdpe5Qt4z
	 Gh58eiH9s5lIpaKyg2A0zGT1rWL8fSqdQCBrWWk4hNs2CglLHz9H6N1PYYa1+u6S3v
	 SuVRLlQSDGXdDIHZoJjGjQgQcXHITAfyEJjPS1iJ4eOqu9iOuqZ7/lFbTveZvtQnxa
	 rPbPCp2tk7qie8STl2nuPXT47A7RTGzp81aC50XiLnlVf0KT1gj3gJlvwopKncZG++
	 QP8QCN+ZHT8RYWfzFd/LQD9DQnQK5MF7/dnTdFUjBrcnnu3QeLrhzmCqUfc6yL0bIj
	 spSiIHyTJgGMg==
Date: Tue, 1 Jul 2025 11:39:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Make dw_pcie_ptm_ops static
Message-ID: <20250701163910.GA1838835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701120856.15839-1-mani@kernel.org>

On Tue, Jul 01, 2025 at 05:38:56PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ptm_ops is not used outside of this file, so make it static. This
> also fixes the sparse warning:
> 
>   drivers/pci/controller/dwc/pcie-designware-debugfs.c:868:27: warning: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?
> 
> Fixes: 852a1fdd34a8 ("PCI: dwc: Add debugfs support for PTM context")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250617231210.GA1172093@bhelgaas
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks, looks good to me.

> ---
>  drivers/pci/controller/dwc/pcie-designware-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index c67601096c48..7356b0f6a2ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -865,7 +865,7 @@ static bool dw_pcie_ptm_t4_visible(void *drvdata)
>  	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
>  }
>  
> -const struct pcie_ptm_ops dw_pcie_ptm_ops = {
> +static const struct pcie_ptm_ops dw_pcie_ptm_ops = {
>  	.check_capability = dw_pcie_ptm_check_capability,
>  	.context_update_write = dw_pcie_ptm_context_update_write,
>  	.context_update_read = dw_pcie_ptm_context_update_read,
> -- 
> 2.45.2
> 

