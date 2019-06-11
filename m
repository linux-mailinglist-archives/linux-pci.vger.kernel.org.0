Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0B3C821
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 12:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405192AbfFKKIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 06:08:16 -0400
Received: from foss.arm.com ([217.140.110.172]:57408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405185AbfFKKIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 06:08:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E075D346;
        Tue, 11 Jun 2019 03:08:14 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FAB53F557;
        Tue, 11 Jun 2019 03:09:56 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:08:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2] PCI: endpoint: Allocate enough space for fixed size
 BAR
Message-ID: <20190611100811.GB29976@redmoon>
References: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 02:47:59PM -0700, Alan Mikhak wrote:
> PCI endpoint test function code should honor the .bar_fixed_size parameter
> from underlying endpoint controller drivers or results may be unexpected.
> 
> In pci_epf_test_alloc_space(), check if BAR being used for test register
> space is a fixed size BAR. If so, allocate the required fixed size.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied to pci/endpoint for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 27806987e93b..7d41e6684b87 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	int bar;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	const struct pci_epc_features *epc_features;
> +	size_t test_reg_size;
>  
>  	epc_features = epf_test->epc_features;
>  
> -	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
> +	if (epc_features->bar_fixed_size[test_reg_bar])
> +		test_reg_size = bar_size[test_reg_bar];
> +	else
> +		test_reg_size = sizeof(struct pci_epf_test_reg);
> +
> +	base = pci_epf_alloc_space(epf, test_reg_size,
>  				   test_reg_bar, epc_features->align);
>  	if (!base) {
>  		dev_err(dev, "Failed to allocated register space\n");
> -- 
> 2.7.4
> 
