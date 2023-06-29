Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E5742E92
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF2UhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjF2UhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 16:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA612E4B;
        Thu, 29 Jun 2023 13:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE326162A;
        Thu, 29 Jun 2023 20:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B8C433C0;
        Thu, 29 Jun 2023 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071026;
        bh=F4iR1kf4VjUJOXwXJoDpEKi6qL+AsCelLmSSb+C9vzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iq8zmXdv4336YTUGZ5+0I7NVnRp8iuqMub1tJEsNbDsYkpcu/gU0ve2qDl9VgL5Ab
         VkK7XPMKF1fD5upJfy6tbKgHcEM7u/5dNq6DvuB8j/PaI69VWA5+PHRGkgiljd0KK/
         JwCG/WEY2dncXdIeufVUe08xXxoiYrA8viTm3ODt2c9f/wdVX3MxNsFkuuP4sTBySe
         RAT6L4zn7bhkpk8+Eu4igd4jCLy5Nv5K6rXwDPCa4/SNW1IJD55zw7ZP3VqZCw/ExV
         XQCXbIRuiRw7ndDNT5qjZcs7XWyhsKNGyAgrgQrwwkslVwtuyZWgsD0VVkSQI9s5me
         w5tWvNkuxH72A==
Date:   Thu, 29 Jun 2023 15:37:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V10 3/5] PCI: Add quirks to generate device tree node for
 Xilinx Alveo U50
Message-ID: <20230629203704.GA446887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688059190-4225-4-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 10:19:48AM -0700, Lizhi Hou wrote:
> The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
> its PCI BAR. The card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. This allows U50 driver to
> load the flattened device tree and generate the device tree node for
> hardware peripherals underneath.
> 
> To generate device tree node for U50 card, add PCI quirks to call
> of_pci_make_dev_node() for U50.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I already gave my ack for v9, so ideally you would add that before
posting the v10.  But here it is again :)

> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c525867760bf..7776012eb03f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6041,3 +6041,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +/*
> + * For a PCI device with multiple downstream devices, its driver may use
> + * a flattened device tree to describe the downstream devices.
> + *
> + * To overlay the flattened device tree, the PCI device and all its ancestor
> + * devices need to have device tree nodes on system base device tree. Thus,
> + * before driver probing, it might need to add a device tree node as the final
> + * fixup.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> -- 
> 2.34.1
> 
