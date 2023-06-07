Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670F1726E5D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjFGUuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjFGUtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 16:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99B2130;
        Wed,  7 Jun 2023 13:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DADE646E4;
        Wed,  7 Jun 2023 20:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA98AC433D2;
        Wed,  7 Jun 2023 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170965;
        bh=yIQkALqfpk76Ao9CbRynGfkR9SerCGob88NMbCbX+9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CYKPa6UBTMgPrPiN9HALK3dfzw30muDr1RYpAq8vN7hvUHrtbmH8c2SWq8oGrqHia
         8wxVvUe5TM4kQXF233PTjr4TUYPIGhOmus7i/c4bJiESw7JXT3j6rMfehECb0W6zYc
         JN91GxRbjjXCxXZZAEUyeW5dZr98CNe0DP5WMsqTT6VcgV3YDAzoOjGaDtr0XQTs3E
         VarfIXjpKKIEgBfIlUoZfW6DZOa12Tiz5CDVewzlInj6nbrMgC4ESMLrYxDexRrpVS
         X8kzoXGMOXiGo9pAWj66w01yXzdGL/rCQ+sXS2yEQW0KiJbNWmZ1uhek7FHpcm0xGA
         lh4o8tn1mqI9Q==
Date:   Wed, 7 Jun 2023 15:49:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org
Subject: Re: [PATCH v6 8/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230607204923.GA1174664@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602114756.36586-9-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 05:17:55PM +0530, Manivannan Sadhasivam wrote:
> Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> The driver implements the MHI function over PCI in the endpoint device
> such as SDX55 modem. The MHI endpoint function driver acts as a
> controller driver for the MHI Endpoint stack and carries out all PCI
> related activities like mapping the host memory using iATU, triggering
> MSIs etc...
> ...

> +static int pci_epf_mhi_bind(struct pci_epf *epf)
> +{
> ...

> +	ret = platform_get_irq_byname(pdev, "doorbell");
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get Doorbell IRQ\n");

This dev_err() causes this new warning from the 0-day robot [1]:

  drivers/pci/endpoint/functions/pci-epf-mhi.c:362:2-9: line 362 is redundant because platform_get_irq() already prints an error

Maybe we could drop it?

Bjorn

[1] https://lore.kernel.org/all/20230607163937.ZTc-D%25lkp@intel.com/
