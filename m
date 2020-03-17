Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB61881A6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgCQLRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 07:17:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgCQLRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 07:17:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FE31FB;
        Tue, 17 Mar 2020 04:17:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B9E3F534;
        Tue, 17 Mar 2020 04:17:51 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:17:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Fix compiler error
Message-ID: <20200317111732.GA25261@e121166-lin.cambridge.arm.com>
References: <20200317074719.10668-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317074719.10668-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 01:17:19PM +0530, Kishon Vijay Abraham I wrote:
> Commit 812828eb5072 ("PCI: endpoint: Fix ->set_msix() to take BIR
> and offset as arguments") was created before adding deferred
> core initialization support in commit 5e50ee27d4a5 ("PCI: pci-epf-test:
> Add support to defer core initialization").
> However since deferred core initialization was merged before
> re-designing MSI-X support, it caused the following compiler error.
> 
> drivers/pci/endpoint/functions/pci-epf-test.c:697:12: error: ‘epf_test’ undeclared (first use in this function);
> 
> Fix the compilation error here.
> 
> Fixes: 812828eb5072 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Lorenzo,
> 
> This patch can be squashed with
> "PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments"

Done, thank you very much.

Lorenzo

> Thanks
> Kishon
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index eaf192be02bb..3b4cf7e2bc60 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -660,6 +660,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  
>  static int pci_epf_test_core_init(struct pci_epf *epf)
>  {
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epf_header *header = epf->header;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epc *epc = epf->epc;
> -- 
> 2.17.1
> 
