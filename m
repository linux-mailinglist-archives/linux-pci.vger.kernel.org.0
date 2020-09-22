Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E428627470E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVQ55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 12:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgIVQ55 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 12:57:57 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4BF23119;
        Tue, 22 Sep 2020 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600793876;
        bh=/jj6qZSe6NjzKJzPGQFQTS4G8QoibfgmhHtDoLSeVZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mvd0SVh5A+oLm98j/Y5vsRBquSHQ/JAb0Wopfg5OqpyyDjbJmv8TcgB851YQY7zuB
         h0KMDlu/Ouujcp80VWlZckGfuKn7SkXLaXfXjo6hkRRbxNgRwstgPDCiRugbTN7IEP
         KFI8t1aAfANL6PMvT5ZlcLQLVbci8g/qfPbzrstM=
Date:   Tue, 22 Sep 2020 11:57:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Message-ID: <20200922165755.GA2211756@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea7f7d342f97c758949a17b870012f52ce5b3f5.1600767645.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo]

On Tue, Sep 22, 2020 at 11:59:10AM +0200, Gustavo Pimentel wrote:
> Fixes warning given by executing "make C=2 drivers/pci/"
> 
> Sparse output:
> CHECK drivers/pci/controller/dwc/pcie-designware.c
>  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
>  cast truncates bits from constant value (ffffffff7fffffff becomes
>  7fffffff)
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Looks good to me; thanks for persevering with this.

Hopefully Lorenzo will apply this and, in the process, adjust the
subject line to match the history:

  PCI: dwc: ...

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c3a4d1..e7a41d9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  	}
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
>  }
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> -- 
> 2.7.4
> 
