Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACA61FF88
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiKGU3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 15:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiKGU3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 15:29:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01426AE5;
        Mon,  7 Nov 2022 12:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB38612F3;
        Mon,  7 Nov 2022 20:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75190C433D6;
        Mon,  7 Nov 2022 20:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667852935;
        bh=yvpUUnOPYhg2U+DkWMtEWcYfKBAQIgETZ3DrNN9r0mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=to0/8UgUzeTStHPDDlxQoR6tBFjNif8uBLMwr5Bu+rBtdWEp/o/XeDU6X9Icks+Zk
         XkqUVcIOzjuOd6N7lYmThOqVGCR1Xxkr8ZX175A/8aHDeoGGEDdU6mEwLE0jtQt21M
         Dllv9WtoHjwMFalUN5XluPhdyQalFXaO+u3brBeHG3vMebOVeMRPGC10p/vLVTdAJW
         4teCPHxU9rYWT0e08mQFwpgH+zQ05PIHOa7c8Smdlpa+7sy23yEANoI7Rn0Rbw9yP4
         7VLNOZxtowMkDXJx/AYX65a0HUlQMghUMEx2FjFmM6ed4nFihXwQVg83CU32gEB1EC
         dk8xlEQqhigng==
Date:   Mon, 7 Nov 2022 14:28:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221107202853.GA416802@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> During the review of the patch that fixes DBI access in PCI EP, Rob
> suggested [1] using a fixed interface for passing the events from EPC to
> EPF instead of the in-kernel notifiers.

> Manivannan Sadhasivam (5):
>   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
>   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
>   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
>   PCI: endpoint: Use callback mechanism for passing events from EPC to
>     EPF
>   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
>  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
>  include/linux/pci-epc.h                       | 10 +----
>  include/linux/pci-epf.h                       | 19 ++++++----
>  6 files changed, 59 insertions(+), 51 deletions(-)

Doesn't apply cleanly on v6.1-rc1.  Does it depend on something else?
