Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD21C528B
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEKGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 06:06:17 -0400
Received: from foss.arm.com ([217.140.110.172]:36158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgEEKGR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 06:06:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E61F631B;
        Tue,  5 May 2020 03:06:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2423F305;
        Tue,  5 May 2020 03:06:15 -0700 (PDT)
Date:   Tue, 5 May 2020 11:06:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     wangzhou1@hisilicon.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] PCI: dwc: Make hisi_pcie_platform_ops static
Message-ID: <20200505100613.GC12543@e121166-lin.cambridge.arm.com>
References: <1587611883-26960-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587611883-26960-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 11:18:03AM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning:
> symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-hisi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
> index 6d9e1b2..11f5ff7 100644
> --- a/drivers/pci/controller/dwc/pcie-hisi.c
> +++ b/drivers/pci/controller/dwc/pcie-hisi.c
> @@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -struct pci_ecam_ops hisi_pcie_platform_ops = {
> +static struct pci_ecam_ops hisi_pcie_platform_ops = {
>  	.bus_shift    = 20,
>  	.init         =  hisi_pcie_platform_init,
>  	.pci_ops      = {
> -- 
> 2.6.2
> 
