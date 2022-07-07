Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6E56AB82
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiGGTG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiGGTG6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 15:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276725A46E
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 12:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD52D62316
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 19:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FC1C3411E;
        Thu,  7 Jul 2022 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657220817;
        bh=IAmRKxJ34lud0b3yZbL9wcXc4LiEdsgoKPDx8mJMN0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+xQ4uDXxigpbtEprBrX8MwdjM2nJvHG7u21dl6IECaa9ScVZTZPOgwBckH6WAU+V
         YwRbYFyjcs9nc5ZgFBK8gbGgOuhzdDfV6Im1+NRC8OzyqRzfM7dGRdx+OYynsSFU41
         oPteJG3vgUN0NtcA9wErh+5Kbi8+5z80rS/O9aiOcEJcr0T11YZ/XLWPyx9k8ce3TE
         rCZC08iGbvyPYMaFPVtUfUnOsDLnTbScAfZZ7SfGIDJFIDDXEWcr/O+ZIuedq7va68
         QV6RCVbh46QpxKkz1fG2+QfYN6UTxoajIhX2nQYzsztGHbQiTfNgJJusDGwmqXZyqA
         9nfGsxIVbxU/w==
Date:   Thu, 7 Jul 2022 13:06:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Luse <paul.e.luse@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>
Subject: Re: [PATCH v2] PCI: Add save and restore capability for TPH config
 space
Message-ID: <YscuzThniuGE6qYW@kbusch-mbp.dhcp.thefacebook.com>
References: <20220707154238.2536-1-paul.e.luse@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707154238.2536-1-paul.e.luse@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 11:42:38AM -0400, Paul Luse wrote:
> From: paul luse <paul.e.luse@intel.com>
> 
> The PCI subsystem does not currently save and restore the configuration
> space for the TPH (Transaction Layer Packet Processing Hints) capability,
> leading to the possibility of configuration loss in some scenarios. For
> more information please refer to PCIe r6.0 sec 6.17.
> 
> This was discovered working on the SPDK Project (Storage Performance
> Development Kit, see https://spdk.io/) where we typically unbind devices
> from their native kernel driver and bind to VFIO for use with our own
> user space drivers. The process of binding to VFIO results in the loss
> of TPH settings due to the resulting PCI reset.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: paul luse <paul.e.luse@intel.com>
> ---

Hi Paul,

If you need to submit subsequent versions, could you include a summary of what
changed from the previous? You can just jot them down below this '---' line for
the reviewers, and any text there would be omitted from the changelog.

As far as I can tell, the only difference is 'tph' is a u16 instead of an int
in pci_save_tph_state().

> +config PCIE_TPH
> +	bool "PCI TPH (Transaction Layer Packet Processing Hints) capability support"
> +	help
> +	  This enables PCI Express TPH (Transaction Layer Packet Processing Hints) by
> +	  making sure they are saved and restored across resets. Enable this if your
> +	  hardware uses the PCI Express TPH capabilities. For more information please
> +	  refer to PCIe r6.0 sec 6.17.

I'm not sure this needs a config option. Even if hardware isn't supporting TPH,
this state save code doesn't takes up much space, and saving this config
capability seems to always be the right thing if hardware is supporting TPH.

Otherwise, this looks good to me.
