Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDFB5FFD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfIRJTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 05:19:53 -0400
Received: from foss.arm.com ([217.140.110.172]:38004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfIRJTx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 05:19:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40632337;
        Wed, 18 Sep 2019 02:19:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE223F59C;
        Wed, 18 Sep 2019 02:19:51 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:19:50 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 04/26] PCI: endpoint: Use PCI_STD_NUM_BARS
Message-ID: <20190918091949.GB9720@e119886-lin.cambridge.arm.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-5-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916204158.6889-5-efremov@linux.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 11:41:36PM +0300, Denis Efremov wrote:
> To iterate through all possible BARs, loop conditions refactored to the
> *number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
> valid BAR "i <= BAR_5". This is more idiomatic C style and allows to avoid
> the fencepost error. Array definitions changed to PCI_STD_NUM_BARS where
> appropriate.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 10 +++++-----
>  include/linux/pci-epc.h                       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1cfe3687a211..5d74f81ddfe4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -44,7 +44,7 @@
>  static struct workqueue_struct *kpcitest_workqueue;
>  
>  struct pci_epf_test {
> -	void			*reg[6];
> +	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
>  	enum pci_barno		test_reg_bar;
>  	struct delayed_work	cmd_handler;
> @@ -377,7 +377,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epc_stop(epc);
> -	for (bar = BAR_0; bar <= BAR_5; bar++) {
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		epf_bar = &epf->bar[bar];
>  
>  		if (epf_test->reg[bar]) {
> @@ -400,7 +400,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  
>  	epc_features = epf_test->epc_features;
>  
> -	for (bar = BAR_0; bar <= BAR_5; bar += add) {
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {

Is it possible to completely remove the BAR_x macros, or are there exsiting
users after this patchset?

As your patchset replaces BAR_0 with 0 and BAR_1 with 1, does this suggest
that other users of BAR_x should be removed and also replaced with a number?

Apologies if you this doesn't fall in the remit of this patchset.

Thanks,

Andrew Murray

>  		epf_bar = &epf->bar[bar];
>  		/*
>  		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> @@ -450,7 +450,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  	epf_test->reg[test_reg_bar] = base;
>  
> -	for (bar = BAR_0; bar <= BAR_5; bar += add) {
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
>  		epf_bar = &epf->bar[bar];
>  		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>  
> @@ -478,7 +478,7 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>  	bool bar_fixed_64bit;
>  	int i;
>  
> -	for (i = BAR_0; i <= BAR_5; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		epf_bar = &epf->bar[i];
>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>  		if (bar_fixed_64bit)
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f641badc2c61..56f1846b9d39 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -117,7 +117,7 @@ struct pci_epc_features {
>  	unsigned int	msix_capable : 1;
>  	u8	reserved_bar;
>  	u8	bar_fixed_64bit;
> -	u64	bar_fixed_size[BAR_5 + 1];
> +	u64	bar_fixed_size[PCI_STD_NUM_BARS];
>  	size_t	align;
>  };
>  
> -- 
> 2.21.0
> 
