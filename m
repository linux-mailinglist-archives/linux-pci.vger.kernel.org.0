Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A755DFD9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiF0WlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiF0WlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 18:41:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332BB193FE;
        Mon, 27 Jun 2022 15:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC734B819BA;
        Mon, 27 Jun 2022 22:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B11AC34115;
        Mon, 27 Jun 2022 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656369660;
        bh=4/K9joc295zYQ8ztp373EU6ZFmyHW62BR4utv5l/YvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QFoF+581jUiwSgy1iW7LUdx2GTFBnr/ebfCUuTFvkWOOH+etCv0kKDey0UeoSWHvR
         gngssrpYYlnw/ZHUUybTpuoD5ihtr5m4+JPnMrPiX2ITJgKj6bJMeJi27R/sjaTgAg
         T9ttb9i6IZSj71gsWSkfwRUJGaN1/L0i/MjPt0DiWMjMMgR/3H94fZisjoZdRC41+v
         8YuNLqPQtnm29eA44JSjDquponB7a8SFZxJFQXKD5rMfKqpzQAa6a1o7N+AXtRGPrj
         ygSXr+j5nuqnWIR3KPLCOvSuLVprjoqwDpqllGocxRUh2meiXIeZedHF2fpY17JfL9
         sIPCetEzvWaEA==
Date:   Mon, 27 Jun 2022 17:40:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Chocron <jonnyc@amazon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH RESEND v5 03/18] PCI: dwc: Disable outbound windows for
 controllers with iATU
Message-ID: <20220627224058.GA1784787@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624143428.8334-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan for pcie-al.c, Kishon for pci-keystone.c]

On Fri, Jun 24, 2022 at 05:34:13PM +0300, Serge Semin wrote:
> In accordance with the dw_pcie_setup_rc() method semantics and judging by
> what the comment added in commit dd193929d91e ("PCI: designware: Explain
> why we don't program ATU for some platforms") states there are DWC
> PCIe-available platforms like Keystone (pci-keystone.c) or Amazon's
> Annapurna Labs (pcie-al.c) which don't have the DW PCIe internal ATU
> enabled and use it's own address translation approach implemented. In
> these cases at the very least there is no point in touching the DW PCIe
> iATU CSRs. Moreover depending on the vendor-specific address translation
> implementation it might be even erroneous. So let's move the iATU windows
> disabling procedure to being under the corresponding conditional statement
> clause thus performing that procedure only if the iATU is expected to be
> available on the platform.

Added Jonathan and Kishon to make sure pcie-al.c and pci-keystone.c
(the only two drivers that override the default dw_child_pcie_ops)
won't be broken by skipping the outbound window disable.

> Fixes: 458ad06c4cdd ("PCI: dwc: Ensure all outbound ATU windows are reset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index bc9a7df130ef..d4326aae5a32 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -543,7 +543,6 @@ static struct pci_ops dw_pcie_ops = {
>  
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
> -	int i;
>  	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> @@ -594,19 +593,22 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>  
> -	/* Ensure all outbound windows are disabled so there are multiple matches */
> -	for (i = 0; i < pci->num_ob_windows; i++)
> -		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> -
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
>  	 * the platform uses its own address translation component rather than
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		int atu_idx = 0;
> +		int i, atu_idx = 0;
>  		struct resource_entry *entry;
>  
> +		/*
> +		 * Ensure all outbound windows are disabled so there are
> +		 * multiple matches

I know you only moved this comment and didn't change the wording, but
do you know what it means?  What "multiple matches" is it talking
about, and why are they important?

I guess Rob previously moved it with 458ad06c4cdd ("PCI: dwc: Ensure
all outbound ATU windows are reset") [1], and it looks like maybe the
point is to *avoid* having an outbound transaction match multiple
windows?  So maybe this comment should say this?

  Disable all outbound windows to make sure a transaction can't match
  multiple windows.

[1] https://git.kernel.org/linus/458ad06c4cdd

> +		 */
> +		for (i = 0; i < pci->num_ob_windows; i++)
> +			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> +
>  		/* Get last memory resource entry */
>  		resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  			if (resource_type(entry->res) != IORESOURCE_MEM)
> -- 
> 2.35.1
> 
