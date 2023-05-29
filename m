Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF70715259
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2XhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 19:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjE2XhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 19:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F0B5;
        Mon, 29 May 2023 16:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60DCC62835;
        Mon, 29 May 2023 23:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C3DC433EF;
        Mon, 29 May 2023 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685403429;
        bh=3B+MmOlbiMmgBtxc8d5IIkby4kqCRhuIzE/NwcQYrDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X0pHygzc6Dje+aO7lTX72oPwP92fCVMmmZUL3M/v9OHYGwylAUgwNOXe2ujTVDmGX
         k+NUncRC0TK3C4nJ3tmAPw06XRiD/j+03OTGkrd8DLgd7NniQ8MHfDiiurJSX005IS
         Hccj1QS7DlUxHe6UAapx5rUWcX0dkXAnjBl9AShxVjnexu5zvoqzHKQUvCAFDU+3Oy
         Q8ISqFWdIKX+7r8UI+7HxxfDPmi22i1f8MRTNATmR8ZpvGFAVSns45xPOdXoXkWkKI
         FtVatZtYXGR95z2qWCxobgCnaH9H1N9VyOUwSS0YmtzYeC3TYp9uFJbWSrqr0Afo/G
         3IHLiFMm5QD3w==
Message-ID: <dd4b1867-204d-8ee0-fcfc-29c52abddb48@kernel.org>
Date:   Tue, 30 May 2023 08:37:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-8-manivannan.sadhasivam@linaro.org>
 <ZHSkdakXJegKRD+q@lpieralisi> <20230529173815.GG5633@thinkpad>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230529173815.GG5633@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/30/23 02:38, Manivannan Sadhasivam wrote:
[...]
>>> +static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
>>> +				   phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>>> +{
>>> +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
>>> +	struct pci_epf *epf = epf_mhi->epf;
>>> +	struct pci_epc *epc = epf->epc;
>>> +	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
>>> +
>>> +	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr - offset);
>>> +	pci_epc_mem_free_addr(epc, phys_addr - offset, virt_addr - offset, size + offset);
>>> +}
>>> +
>>> +static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
>>> +{
>>> +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
>>> +	struct pci_epf *epf = epf_mhi->epf;
>>> +	struct pci_epc *epc = epf->epc;
>>> +
>>> +	/*
>>> +	 * Vector is incremented by 1 here as the DWC core will decrement it before
>>> +	 * writing to iATU.
>>
>> This isn't OK. It is an API, you can't write code explicitly relying on
>> the underlying implementation. I assume the API is not well specified,
>> that's why we need these tricks ?
>>
> 
> Well, this is not an API issue but rather an implementation detail of the DWC EP
> core driver. The DWC driver expects the interrupt vectors to be 1 based, so it
> decrements it before writing to the MSI address:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c#n537

Then the driver should be fixed so that this peculiarity is not visible at the
user API level, resulting in a uniform usage of the API for all functions
regardless of the controller being used.

-- 
Damien Le Moal
Western Digital Research

