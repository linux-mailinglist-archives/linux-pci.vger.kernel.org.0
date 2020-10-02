Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E24B2811E6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgJBMBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 08:01:05 -0400
Received: from foss.arm.com ([217.140.110.172]:33970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 08:01:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F8F1063;
        Fri,  2 Oct 2020 05:01:02 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17713F70D;
        Fri,  2 Oct 2020 05:01:01 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:00:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Toan Le <toan@os.amperecomputing.com>, Duc Dang <dhdang@apm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xgene: Remove unused assignment to variable msi_val
Message-ID: <20201002120059.GE23640@e121166-lin.cambridge.arm.com>
References: <20200922030257.459898-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922030257.459898-1-kw@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 03:02:57AM +0000, Krzysztof Wilczyński wrote:
> The value assigned to msi_val after the inner loop finishes its run is
> never used for anything, and it is also immediately overridden in the
> line that follows with the return value from the xgene_msi_int_read()
> function.
> 
> Since the value of msi_val following the inner loop completion is never
> used in any meaningful way the assignment can be removed.
> 
> Addresses-Coverity-ID: 1437183 ("Unused value")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pci-xgene-msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to pci/xgene, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 02271c6d17a1..2470782cb01a 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -493,8 +493,8 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	 */
>  	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
>  		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
> -			msi_val = xgene_msi_ir_read(xgene_msi, irq_index,
> -						    msi_idx);
> +			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
> +
>  		/* Read MSIINTn to confirm */
>  		msi_val = xgene_msi_int_read(xgene_msi, irq_index);
>  		if (msi_val) {
> -- 
> 2.28.0
> 
