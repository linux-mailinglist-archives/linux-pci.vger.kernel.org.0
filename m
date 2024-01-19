Return-Path: <linux-pci+bounces-2347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6818328CA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 12:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113A5285504
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DA4C3BC;
	Fri, 19 Jan 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+uSZWCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7084CB21;
	Fri, 19 Jan 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663861; cv=none; b=M3AmPpWHbnPXsz4EhRdbLUhFVBckDuzzxL6VyjNJNF+gQ3jbWKDBcE3LSY0N31QD85fsgfLrdCaLdgTTfpWbo/rxTcrEYFMBAttQ/fgp4kfhPcD/+MSVcK/cIXHQRnBU85GAyub/5f6RXI3CP/aX0kNcSKW4olfIiSsyE1JgzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663861; c=relaxed/simple;
	bh=vN3dZKhzrKwIL8dW972H6cQsJ4YfJlEDp0fFfY132YQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hebYbsPWGZTJ83/D2E90YAAO99rd3MM1q4PCSGc42JSzE/85q4WsKF8+YXulDE9UQ84tZL3oH7fC7xoxRBukDIdICs6ySsvoufRgVNiRbLqURcS0V4txIWldQYGgm6aq23r6p9jtY5BbQU2T9H4lNv/4kEytiRICBVgVJgKgHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+uSZWCS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705663858; x=1737199858;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vN3dZKhzrKwIL8dW972H6cQsJ4YfJlEDp0fFfY132YQ=;
  b=H+uSZWCSglaVd6bPFVanfBP17lri8lCk4ks66KfVsbQ7RSjP6nPpBSAI
   DWb2bGaxxkB0SHnUxWGhyUNUJ3I5a1mLVJe2emC3mxz+W/EQuGHuvUAKe
   zkCkKQQRuDtOagHSU+0cKTg0CmOzY0uSeSf8EhakyEcKz/3Ik5vmTNNFv
   5YSQVpgOYZXSrnpNo4BJs+jTZ7TXxGO6U8A4P60muQy+QYOirEJTrkbja
   KYnEbwSCuxXQt5mTq9akK9wdPYI62RJb6yffvwntDATjfFvMPYLRb94Lh
   HMRk175VEaGZ/C23WNnT0d12mzXNW7pUMIidC95faUxIT8UU9WL/mKYP0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="621847"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="621847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 03:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="33371563"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 03:30:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 19 Jan 2024 13:30:49 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Niklas Cassel <niklas.cassel@wdc.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
In-Reply-To: <c5035dc2-a379-48f0-8544-aa57d642136b@moroto.mountain>
Message-ID: <d550f0b2-b2cc-3c4c-1525-3dac2e032e99@linux.intel.com>
References: <c5035dc2-a379-48f0-8544-aa57d642136b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Jan 2024, Dan Carpenter wrote:

> The "msg_addr" variable is u64.  However, the "aligned_offset" is an
> unsigned int.  This means that when the code does:
> 
>         msg_addr &= ~aligned_offset;

Wouldn't it be more obvious to replace the entire line with this:
	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);

+ add the #include for it. It should handle the casting to the same type 
internally.

-- 
 i.


> 
> it will unintentionally zero out the high 32 bits.  Declare
> "aligned_offset" as a u64 to address this bug.
> 
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: fix a typo in the commit message
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..2b6607c23541 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -525,7 +525,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
>  	u32 reg, msg_data, vec_ctrl;
> -	unsigned int aligned_offset;
> +	u64 aligned_offset;
>  	u32 tbl_offset;
>  	u64 msg_addr;
>  	int ret;
> 

