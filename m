Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C219F6524A8
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLTQcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTQcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 11:32:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83317DFE7
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 08:32:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC8F5CE1320
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 16:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF9C433D2;
        Tue, 20 Dec 2022 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671553960;
        bh=Bem8z5//1aEvoEVVdnx5RIqRMonjMFHjFzpnJmFo32M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAodN6DClMr8hmKGNFCfW2DeFLSmvd+YgOftHqGH0g8PMDm2wuYHUPiZFVObuJUpC
         xKYaNlkePLkV3NAYAnZQNYyYBmT+ls2jgTL42ZtIgswRVeTNFrsIdVqCHO7jKN3wtN
         cqvmE3hJtL4vGutpOiJiwHjdwT/Tl268yDfML8rYsNzc8LkBr4FIbK9IjoGb3APs+W
         ewmvKnlYKe2qJ87FNXDMIP7pIp37xy0lMIJTbJjShQqnigZptoMtvDsWLuFGVGrjt3
         vtGPnUWJc4e4IuC/SwgabpYGPtrcfwI7ZmElBtOp/ELnQB6eJpuOXSbgk8k5i0quWe
         4N7x73MNzi5EA==
Date:   Tue, 20 Dec 2022 09:32:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-4-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alvaro,

On Mon, Dec 19, 2022 at 10:35:11AM +0200, Alvaro Karsz wrote:
> This commit includes:
>  1) The driver to manage the controlplane over vDPA bus.
>  2) A HW monitor device to read health values from the DPU.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

<snip>

> +static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> +{
> +	char name[25];
> +	int ret, i, mask = 0;
> +	/* We don't know which BAR will be used to communicate..
> +	 * We will map every bar with len > 0.
> +	 *
> +	 * Later, we will discover the BAR and unmap all other BARs.
> +	 */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i))
> +			mask |= (1 << i);
> +	}
> +
> +	/* No BAR can be used.. */
> +	if (!mask) {
> +		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
> +	ret = pcim_iomap_regions(pdev, mask, name);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (mask & (1 << i))
> +			psnet->bars[i] = pcim_iomap_table(pdev)[i];
> +	}
> +
> +	return 0;
> +}
> +
> +static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> +{
> +	char name[20];
> +	int ret;
> +
> +	snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
> +	/* Request and map BAR */
> +	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
> +		return ret;
> +	}
> +
> +	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
> +
> +	return 0;
> +}

This patch as commit 73a720b16fa1 ("virtio: vdpa: new SolidNET DPU
driver.") in next-20221220 causes the following clang warnings:

  drivers/vdpa/solidrun/snet_main.c:561:2: error: 'snprintf' size argument is too large; destination buffer has size 25, but size argument is 256 [-Werror,-Wfortify-source]
          snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
          ^
  drivers/vdpa/solidrun/snet_main.c:581:2: error: 'snprintf' size argument is too large; destination buffer has size 20, but size argument is 256 [-Werror,-Wfortify-source]
          snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
          ^
  2 errors generated.

This does not appear to be a false positive but what was the intent
here? Should the local name variables increase their length or should
the buffer length be reduced?

Cheers,
Nathan
