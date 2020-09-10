Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DE264F1D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIJTe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgIJTev (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 15:34:51 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D115221D81;
        Thu, 10 Sep 2020 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766491;
        bh=ksxkD7CoWHBWoeooRpLgc48k96/HNdsGMEUrhw4P95M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fyJDTrWKH893FaVVt1OBSFJ9f8hlkqYHqiIOG2oJfs84qz/Op1sf/oMRThvCTHSaU
         hYzRyv2nHZ5cGHRz2s1hRK7BZ+s5xapIW//Kjf3VgsTE07q+fETLVHkAY9n8H69ZmW
         l2pLX2AP6MuZ7hv25meQ8h6oN9ScbwIh5otsCAR4=
Date:   Thu, 10 Sep 2020 14:34:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dwc: unexport dw_pcie_link_set_max_speed
Message-ID: <20200910193449.GA807725@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909134234.31204-1-yuehaibing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 09, 2020 at 09:42:34PM +0800, YueHaibing wrote:
> This function has been made static, which causes warning:
> 
> WARNING: modpost: "dw_pcie_link_set_max_speed" [vmlinux] is a static EXPORT_SYMBOL_GPL
> 
> Fixes: 3af45d34d30c ("PCI: dwc: Centralize link gen setting")

This commit is still on Lorenzo's pci/dwc branch, so he should be able
to squash this fix in.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d105efb5722..3c3a4d1dbc0b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -508,7 +508,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  
>  }
> -EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
>  
>  static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  {
> -- 
> 2.17.1
> 
> 
