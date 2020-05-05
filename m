Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92FA1C5398
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgEEKr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 06:47:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEEKr5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 06:47:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32F430E;
        Tue,  5 May 2020 03:47:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F4C3F305;
        Tue,  5 May 2020 03:47:55 -0700 (PDT)
Date:   Tue, 5 May 2020 11:47:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        p.zabel@pengutronix.de, gustavo.pimentel@synopsys.com,
        andriy.shevchenko@intel.com, eswara.kota@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] PCI: dwc: intel: make intel_pcie_cpu_addr() static
Message-ID: <20200505104749.GA13446@e121166-lin.cambridge.arm.com>
References: <20200415084953.6533-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084953.6533-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 15, 2020 at 04:49:53PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/pci/controller/dwc/pcie-intel-gw.c:456:5: warning: symbol
> 'intel_pcie_cpu_addr' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index fc2a12212dec..2d8dbb318087 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -453,7 +453,7 @@ static int intel_pcie_msi_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> +static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	return cpu_addr + BUS_IATU_OFFSET;
>  }
> -- 
> 2.21.1
> 
