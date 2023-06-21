Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4A7390BF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjFUU0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFUU0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 16:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC619BF;
        Wed, 21 Jun 2023 13:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DF2616A0;
        Wed, 21 Jun 2023 20:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A239DC433C9;
        Wed, 21 Jun 2023 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687379156;
        bh=hiXA2jbxmgi4ukJ9eszqbew/jk2q5sgKpmcne0KLKto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QtOdHzUZZ9WvdV1lUeSql2NrqzAfwxVqRPjKGlvJMAIKkilz/cmef6xc87SOHrBnN
         im6QiaKv+N6loZUVdp616FvrP6l3BIUBVOjicXt75Rgi5hY5m3w1zwEiAbvT81vx7+
         7cwbo6gbWoAy949fBlC0aT5HTGiJ14Wv58fAe5XPIAvY1MHQwrr2rTj/9xXJ+h6G9v
         BTBYARfOse10oJAXsbaDOm5vUxKbxm2as8FjDoMjfNPqYuFErFQyFL2vADXh1N9dj0
         ZPCAR+wWm+Qyob/3llEsrt5s6c+6+GuQtSB6ce943VRU39f4noyVk2Ivd1gJRyn9Ml
         iZwE3FQRK2I0g==
Date:   Wed, 21 Jun 2023 15:25:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 3/5] PCI: Add PCI quirks to generate device tree node
 for Xilinx Alveo U50
Message-ID: <20230621202553.GA115453@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687368849-36722-4-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, s/Add PCI/Add/ (no need to repeat "PCI")

On Wed, Jun 21, 2023 at 10:34:07AM -0700, Lizhi Hou wrote:
> The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
> its PCI BAR. The card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. This allows U50 driver to
> load the flattened device tree and generate the device tree node for
> hardware peripherals underneath.
> 
> To generate device tree node for U50 card, added PCI quirks to call
> of_pci_make_dev_node() for U50.

s/added/add/ (tell me what the patch does, not what you did)

> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/quirks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c525867760bf..c8f3acea752d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6041,3 +6041,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +/*
> + * For PCI device which have multiple downstream devices, its driver may use
> + * a flattened device tree to describe the downstream devices.
> + * To overlay the flattened device tree, the PCI device and all its ancestor
> + * devices need to have device tree nodes on system base device tree. Thus,
> + * before driver probing, it might need to add a device tree node as the final

s/For PCI device which have multiple/For a PCI device with multiple/

It looks like you intend two separate paragraphs in the comment.  If
so, add a blank line between them.  If not, rewrap so they're a single
paragraph.

> + * fixup.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> -- 
> 2.34.1
> 
