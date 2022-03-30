Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038B4EBF7C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiC3LEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiC3LEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 07:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39326A97A
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 04:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C67C2614D4
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F2C340EC;
        Wed, 30 Mar 2022 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648638167;
        bh=062Ey7HcxTsk5gLsjBqLtIvR4zGc8gGuGTQ1Cq+QUSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JySFydunVJNO1JRGl/pEkw/EH3v5IdYlotn5d6mPcs3bV5c9dJAY2RT1YCFO54aX5
         mVPeioT+UZ8Adu+w9YciP0W8K2o3ieY4DKWO+mCkXJvCjTB3NM0rCHydkkx7M0Ijkh
         PJ6ufTc1XeCXenpzvixcdgRqyzgrX8PlVJ00RnZ7pcAUbS3/9BcgWSSfCsLfHnko/+
         NirtTj589BKd/hGzxAU+jfZSfmy+rKhCxsgk4i4v7LI5r4evq6VOdyiNbgQkcFjMrE
         a7Y/EgbJKvdMiZjcxy655nJotNLxB1VfNcMJkcp4EhvJy/Rg1JQ3NU+QhXFPfiE4fH
         5A5m6edT8/HsA==
Date:   Wed, 30 Mar 2022 06:02:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     christophe.jaillet@wanadoo.fr, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/doc: cleanup references to the legacy PCI DMA API
Message-ID: <20220330110245.GA1680763@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330052556.2566388-1-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 07:25:56AM +0200, Christoph Hellwig wrote:
> Mention the regular DMA API calls instead of the now removed PCI DMA API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> ---
> 
> I'd plan to queue this up ASAP together with the pci-dma-compat.h
> removal.
> 
>  Documentation/PCI/pci.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index 87c6f4a6ca32b..67a850b556173 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -278,20 +278,20 @@ appropriate parameters.  In general this allows more efficient DMA
>  on systems where System RAM exists above 4G _physical_ address.
>  
>  Drivers for all PCI-X and PCIe compliant devices must call
> -pci_set_dma_mask() as they are 64-bit DMA devices.
> +set_dma_mask() as they are 64-bit DMA devices.
>  
>  Similarly, drivers must also "register" this capability if the device
> -can directly address "consistent memory" in System RAM above 4G physical
> -address by calling pci_set_consistent_dma_mask().
> +can directly address "coherent memory" in System RAM above 4G physical
> +address by calling dma_set_coherent_mask().
>  Again, this includes drivers for all PCI-X and PCIe compliant devices.
>  Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
>  64-bit DMA capable for payload ("streaming") data but not control
> -("consistent") data.
> +("coherent") data.
>  
>  
>  Setup shared control data
>  -------------------------
> -Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
> +Once the DMA masks are set, the driver can allocate "coherent" (a.k.a. shared)
>  memory.  See Documentation/core-api/dma-api.rst for a full description of
>  the DMA APIs. This section is just a reminder that it needs to be done
>  before enabling DMA on the device.
> @@ -367,7 +367,7 @@ steps need to be performed:
>    - Disable the device from generating IRQs
>    - Release the IRQ (free_irq())
>    - Stop all DMA activity
> -  - Release DMA buffers (both streaming and consistent)
> +  - Release DMA buffers (both streaming and coherent)
>    - Unregister from other subsystems (e.g. scsi or netdev)
>    - Disable device from responding to MMIO/IO Port addresses
>    - Release MMIO/IO Port resource(s)
> @@ -420,7 +420,7 @@ Once DMA is stopped, clean up streaming DMA first.
>  I.e. unmap data buffers and return buffers to "upstream"
>  owners if there is one.
>  
> -Then clean up "consistent" buffers which contain the control data.
> +Then clean up "coherent" buffers which contain the control data.
>  
>  See Documentation/core-api/dma-api.rst for details on unmapping interfaces.
>  
> -- 
> 2.30.2
> 
