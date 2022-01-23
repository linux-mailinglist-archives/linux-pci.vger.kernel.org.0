Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6449716F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiAWMKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 07:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 07:10:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C54C06173B;
        Sun, 23 Jan 2022 04:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6A27B80CD0;
        Sun, 23 Jan 2022 12:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39DFC340E2;
        Sun, 23 Jan 2022 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642939817;
        bh=gjuqgtA8NkkbAj8od2tDkDBDycbTBrLq37rQBNtwky0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSDgppls5Brq/3BhSrshWh6sc4JihhqlIvgwdmamukk4Wvp12ZCJeCdf9+17AZRQv
         TI9dVHIDgD19fdecUk1e4ZHg1I58jP+f949C8FHxuXsT8E1yZtCDUlBX0N/2tdec5S
         XoHhjk7nQGS/E47QyG9cKVk7IQS4XlI8JBibuTcUAUU6ndy+EsG9Mia+a9CNGsXMUE
         jSc5nNOAD/gsgL9fPtT4qrXJvvJd9rdXlYVpQMU+/kndzX6LlIZibovS9tLSUUIW6e
         Uqe44nCb0rXZSijrEbYMKnw2HnW/GTx23NRsYc7P1q+lOb5tJ956iJV/YxN2wG49MH
         VjYtuJD0IqOvg==
Date:   Sun, 23 Jan 2022 20:02:42 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Message-ID: <Ye1D4lYAIpDe7qAN@xhacker>
References: <20211226074019.2556-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211226074019.2556-1-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 26, 2021 at 03:40:19PM +0800, Jisheng Zhang wrote:
> If the host which makes use of the IP's integrated MSI Receiver losts
> power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> register is always set as 0xffffffff incorrectly, thus the MSI can't
> work after resume.
> 
> Fix this issue by moving pp->irq_mask[ctrl] initialization to
> dw_pcie_host_init(), so we can correctly set the mask reg during both
> boot and resume.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Hi all,

This patch can still be applied to the latest linus tree. Do you want
me to rebase and send out a new version?

Without this patch, dwc host MSI interrupt(if use the IP's integrated
MSI receiver) can't work after resume. Could it be picked up as a fix
for v5.17?

Thanks

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..2fa86f32d964 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -362,6 +362,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret < 0)
>  				return ret;
>  		} else if (pp->has_msi_ctrl) {
> +			u32 ctrl, num_ctrls;
> +
> +			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +				pp->irq_mask[ctrl] = ~0;
> +
>  			if (!pp->msi_irq) {
>  				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
>  				if (pp->msi_irq < 0) {
> @@ -541,7 +547,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  		/* Initialize IRQ Status array */
>  		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -			pp->irq_mask[ctrl] = ~0;
>  			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
>  					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>  					    pp->irq_mask[ctrl]);
> -- 
> 2.34.1
> 
