Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924550A6BC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390604AbiDURPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390597AbiDURPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 13:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBA49F12
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 10:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA87B803F5
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 17:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CE5C385A1;
        Thu, 21 Apr 2022 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650561146;
        bh=NiFLxdhRUm7nC6iDGmr0joaXrMpsGE8r3L6slsGANj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wg6SuY21NBkwjTMtGNPgbpXLdk0PRQkqh6FhC7nSGp059hYZeDH+I+4PfZh+bIjOY
         ljSvuBffbvYo1yvtNmeRryNThUKz6myAM1svrYxw1kBtGQSZ8pMx1FK5dj7qP+YnPn
         BSL+xeLy/rIkuump3zyJF3FHIn+SVy489WP1Tlve0JTPc9/HijDllIZDjRUBvTa/BJ
         Kx9CTG93nCm5Mn2aeDNgj5dpBRYyTthUS4l+tyD2GLwYgiJWNgOTp6wTD0TGIQ7cKa
         iZXl2KyB711acx+PdECLcMWjZBfjl9lIlnnxU4our6FJhwgdEgCogxstEhCt9qdf+u
         FlESleBWsxQFQ==
Date:   Thu, 21 Apr 2022 12:12:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/docs: Fix references to DMA set mask function
Message-ID: <20220421171224.GA1412390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165048747271.2959320.13475081883467312497.stgit@omen>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 02:45:05PM -0600, Alex Williamson wrote:
> The function is dma_set_mask(), fix a missed instance of the old
> pci_set_dma_mask() and a reference to a function that doesn't exist.
> 
> Fixes: 05b0ebd06ae6 ("PCI/doc: cleanup references to the legacy PCI DMA API")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/misc for v5.19 with Christoph's reviewed-by, thank you!

> ---
>  Documentation/PCI/pci.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index 67a850b55617..cced568d78e9 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -273,12 +273,12 @@ Set the DMA mask size
>  While all drivers should explicitly indicate the DMA capability
>  (e.g. 32 or 64 bit) of the PCI bus master, devices with more than
>  32-bit bus master capability for streaming data need the driver
> -to "register" this capability by calling pci_set_dma_mask() with
> +to "register" this capability by calling dma_set_mask() with
>  appropriate parameters.  In general this allows more efficient DMA
>  on systems where System RAM exists above 4G _physical_ address.
>  
>  Drivers for all PCI-X and PCIe compliant devices must call
> -set_dma_mask() as they are 64-bit DMA devices.
> +dma_set_mask() as they are 64-bit DMA devices.
>  
>  Similarly, drivers must also "register" this capability if the device
>  can directly address "coherent memory" in System RAM above 4G physical
> 
> 
