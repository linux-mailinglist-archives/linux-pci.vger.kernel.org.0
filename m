Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835EC715CE0
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjE3LTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjE3LTL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 07:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41EB0;
        Tue, 30 May 2023 04:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C6162A36;
        Tue, 30 May 2023 11:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D0C433EF;
        Tue, 30 May 2023 11:19:05 +0000 (UTC)
Date:   Tue, 30 May 2023 16:48:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
        kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230530111853.GH6379@thinkpad>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-8-manivannan.sadhasivam@linaro.org>
 <ZHSkdakXJegKRD+q@lpieralisi>
 <20230529173815.GG5633@thinkpad>
 <dd4b1867-204d-8ee0-fcfc-29c52abddb48@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd4b1867-204d-8ee0-fcfc-29c52abddb48@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 08:37:07AM +0900, Damien Le Moal wrote:
> On 5/30/23 02:38, Manivannan Sadhasivam wrote:
> [...]
> >>> +static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> >>> +				   phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
> >>> +{
> >>> +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> >>> +	struct pci_epf *epf = epf_mhi->epf;
> >>> +	struct pci_epc *epc = epf->epc;
> >>> +	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> >>> +
> >>> +	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr - offset);
> >>> +	pci_epc_mem_free_addr(epc, phys_addr - offset, virt_addr - offset, size + offset);
> >>> +}
> >>> +
> >>> +static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
> >>> +{
> >>> +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> >>> +	struct pci_epf *epf = epf_mhi->epf;
> >>> +	struct pci_epc *epc = epf->epc;
> >>> +
> >>> +	/*
> >>> +	 * Vector is incremented by 1 here as the DWC core will decrement it before
> >>> +	 * writing to iATU.
> >>
> >> This isn't OK. It is an API, you can't write code explicitly relying on
> >> the underlying implementation. I assume the API is not well specified,
> >> that's why we need these tricks ?
> >>
> > 
> > Well, this is not an API issue but rather an implementation detail of the DWC EP
> > core driver. The DWC driver expects the interrupt vectors to be 1 based, so it
> > decrements it before writing to the MSI address:
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c#n537
> 
> Then the driver should be fixed so that this peculiarity is not visible at the
> user API level, resulting in a uniform usage of the API for all functions
> regardless of the controller being used.
> 

Just checked with Kishon offline and confirmed that this is an API behavior.
I also checked other drivers and they all doing the same.

But unfortunately, this behavior is not documented in the API. Will add a patch
for that.

- Mani

> -- 
> Damien Le Moal
> Western Digital Research
> 

-- 
மணிவண்ணன் சதாசிவம்
