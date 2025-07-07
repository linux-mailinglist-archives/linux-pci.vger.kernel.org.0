Return-Path: <linux-pci+bounces-31604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B3AFADC4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539614202D6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21221FF30;
	Mon,  7 Jul 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p67LGEFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9811F3BA9;
	Mon,  7 Jul 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874917; cv=none; b=B6sn+WbVFfGo3x0FNjaw6N8HTCy4P4cjnrwolKSSt7v9toU72Ztf8I1pcs/mH/MRRF9R+UaYJ5vQeaKEYknZvmgNSxAzucHGivYSUrj0Vz8+h0xoDgQyW9NA70lS1RUnmzrJHyfxx38a14x/mhmTY74GqiGC/yf/9v7+DSS3nf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874917; c=relaxed/simple;
	bh=cKHCdC+8OOd0fD7Q6fM3+v+3PV/zmLtX9TiNQ2cQZ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS/ULC1VXg+KCLXT7MwP4onLeTmcAJJBJZW5y+NODdH+iXTQoZJBAss/ZgNxj/uzchDFbPyGEIO7QgZOZWz6tQJ1hFisR0CKF6agF75yQcHijofdKW9ooYTTooGV5fxJ/+RLYQIjR7gz7kT0GnJfim05LAcXUlkBXMmNJ6gn1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p67LGEFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A6C4CEE3;
	Mon,  7 Jul 2025 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751874915;
	bh=cKHCdC+8OOd0fD7Q6fM3+v+3PV/zmLtX9TiNQ2cQZ/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p67LGEFw8Y8mR0UwD7IgYaIE104jXSK26SQNEAKmF/tbFaBjbdD9k1V3mPmbvWMba
	 0q/RfJWn3Vk1fOfPQcOBuTDSrKRRc8ldahaIxYuE7dmBJkRlgkqG9krKI/cPY/EzSH
	 u0+4Amlb3z5ekyEP0iBSisQfRv9N2xjNf6R4BRV+aF/d77kKvl2vthodKZWp9uNrCU
	 YRub/z7IcWu2aRAye2UUw9SlnznGiFlbOm0inxa49qRWeIatIL/3leLgwgwUtoDqeB
	 mH8I8orXFbSnD2Fq6q2wrku+HR/ht9u6VKpCUsgbENXiSZQw7ng056oxSICGJoOLyo
	 xzPlPDJrrinwQ==
Date: Mon, 7 Jul 2025 13:25:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Make dw_pcie_ptm_ops static
Message-ID: <wlaa7mvvlyo5v3yfwnpsmyd4xa2z5nbo3rl47va4nodilsghlg@afuurqynurnz>
References: <20250701120856.15839-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701120856.15839-1-mani@kernel.org>

On Tue, Jul 01, 2025 at 05:38:56PM GMT, Manivannan Sadhasivam wrote:
> dw_pcie_ptm_ops is not used outside of this file, so make it static. This
> also fixes the sparse warning:
> 
>   drivers/pci/controller/dwc/pcie-designware-debugfs.c:868:27: warning: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?
> 
> Fixes: 852a1fdd34a8 ("PCI: dwc: Add debugfs support for PTM context")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250617231210.GA1172093@bhelgaas
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

Applied to pci/controller/dwc!

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்

