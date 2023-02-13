Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D883695305
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBMV2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMV2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 16:28:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944B21A04;
        Mon, 13 Feb 2023 13:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DF8BB81929;
        Mon, 13 Feb 2023 21:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623BBC433D2;
        Mon, 13 Feb 2023 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676323696;
        bh=1v0p/2P0YaPiMh1RgrMKDhzCSL7p5e8tOLhPt055RiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eW8E1UxEix7Oubsu3tHAFZ+DIA9ehv0PqeT8YL3i4x41l9nuV3VXWnOAsvBHsJaVG
         rUaQw1UmthM12k9g1nRT/qhOX0IYhOJUrmHpAUkmMUA4NZP7ZURbNe0rk6Ptq+A8Hr
         dKI7sOnwdei28bwIX1uCX8hm+My/q/UBdZpjXSiMg/g+K3Rm9VjUNc9ZpVUCJVlKzd
         j2a+lpvNdO/9YgSKbn8TR5HMk/0ZmFBH9Cwa6hy9YzGDp6OAs0TacrZCCwh5LjWLjC
         k1jlXDaW645l9850SC5QjFHTBNsJ1xJVMCvU1Yh5jFIGvDGDUl0FDM35CiacbPZYr1
         BRWRtuxNQQrsQ==
Date:   Mon, 13 Feb 2023 15:28:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Honor firmware's device disabled status
Message-ID: <20230213212815.GA2934310@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210164351.2687475-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 10:43:51AM -0600, Rob Herring wrote:
> If a device has a firmware node (DT/ACPI), and the device is marked
> disabled, that is currently ignored. Add a check for this condition
> and bail out creating the pci_dev.
> 
> This assumes the config space for the device can still be accessed
> because they already have by this point in order to identify the device.
> 
> Cc: Liu Peibao <liupeibao@loongson.cn>
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied with Binbin's tested-by to pci/enumeration for v6.3, thanks!

> ---
> Please test if this works for Loongson.
> ---
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1779582fb500..b1d80c1d7a69 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1841,6 +1841,8 @@ int pci_setup_device(struct pci_dev *dev)
>  
>  	pci_set_of_node(dev);
>  	pci_set_acpi_fwnode(dev);
> +	if (dev->dev.fwnode && !fwnode_device_is_available(dev->dev.fwnode))
> +		return -ENODEV;
>  
>  	pci_dev_assign_slot(dev);
>  
> -- 
> 2.39.1
> 
