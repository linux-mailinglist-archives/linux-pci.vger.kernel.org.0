Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACF964C0D8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 00:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiLMXpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 18:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiLMXpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 18:45:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D181C909;
        Tue, 13 Dec 2022 15:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E16EB815FE;
        Tue, 13 Dec 2022 23:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B8C433F1;
        Tue, 13 Dec 2022 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670975084;
        bh=2tvp9NwfkXVkp5bFjHTkmFQ7muXx0ZcIww+kK5zEtVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rs22s+42gOPyj0CUdx6/k27/mWhapSg8QDoyLDf0HLDv1OakEC2dfZBjVPBtaD+PN
         KX9CSFjEAe0Z15L9UPgyJG1XVfaI/uzPalHBmCeHUUwTY7LefInlrN7kqwidLdET7C
         iGRNJ+Y06F2m6nM1wdlEQ3AXL1DhP+NgNJO+e/UlBkcHNlqbX9KTC/sxvZKKpQspRp
         kbhg7V1fhF+DJBHQAZLnZ5kasXYZMbw4WDgswRcdLLQWy8yTPoWeRR603q21ECuYT+
         gJthfOJEwBvYAcRC6W0Z6yGjg5UYHku3byLM97SKQqRmiwmK2v4YLTqeFT04Y1NHnc
         3FFXLLu/W0Gdg==
Date:   Tue, 13 Dec 2022 17:44:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hch@infradead.org, nsekhar@ti.com
Subject: Re: [PATCH v7 01/23] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
Message-ID: <20221213234442.GA219721@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410135510.30673-1-kishon@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 10, 2017 at 07:25:10PM +0530, Kishon Vijay Abraham I wrote:
> Introduce a new EP core layer in order to support endpoint functions in
> linux kernel. This comprises the EPC library (Endpoint Controller Library)
> and EPF library (Endpoint Function Library). EPC library implements
> functions specific to an endpoint controller and EPF library implements
> functions specific to an endpoint function.

> +void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
> +{
> +	void *space;
> +	struct device *dev = &epf->dev;
> +	dma_addr_t phys_addr;
> +
> +	if (size < 128)
> +		size = 128;
> +	size = roundup_pow_of_two(size);
> +
> +	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
> +	if (!space) {
> +		dev_err(dev, "failed to allocate mem space\n");
> +		return NULL;
> +	}
> +
> +	epf->bar[bar].phys_addr = phys_addr;

> + * struct pci_epf_bar - represents the BAR of EPF device
> + * @phys_addr: physical address that should be mapped to the BAR
> + * @size: the size of the address space present in BAR
> + */
> +struct pci_epf_bar {
> +	dma_addr_t	phys_addr;

If this "phys_addr" is an address that can appear on the PCI bus, is
"phys_addr" a misnomer?  Many drivers use dma, dmabuf, bus_addr, etc.

Bjorn
