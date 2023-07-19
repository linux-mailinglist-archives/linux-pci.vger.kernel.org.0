Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8C759CA2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGSRlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGSRlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 13:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D752685
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 10:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488A2617D6
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 17:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6399BC433C8;
        Wed, 19 Jul 2023 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689788497;
        bh=ngedI035SgHXmSnCO6TIlOqOLCKDSfYkvddTtkbFtJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gcegc2K6Alrm/VdE+aCFa5FCwFcdrmgS6Mj7FV7ZI1RgBKxyH+O/xWl0ji1/QLEyM
         GU1CGi540Ge0dAdmviEgFz8dmevmGo0On1z+/fn1UJnvuJyLzTL0XsRofMusnV+o0w
         cHZnQHNOBqRA8Ju/j+4ZucxLjY3Wh3LDs7+arw84dVnECTofDj18TO0jrXi5H/Asiv
         yInRpYN5kokui/hBRbltB/EcT3nr5/MB+JGonceae1fVOFDjickIYjVXqeppB3adwR
         8Uv8itg/CQzKgf5MYLPaZIbszl0hYM4OZVNGKPgu/jdk/m7jmfQkCHalAuFY1d39bx
         uNKSj60mINR6A==
Date:   Wed, 19 Jul 2023 12:41:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/8] PCI: microchip: Rename and refactor
 mc_pcie_enable_msi()
Message-ID: <20230719174135.GA507746@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630154859.2049521-8-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:48:58PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> After improving driver to get MSI-related information from
> configuration registers (set at power on from the Libero FPGA
> design), its now clear that mc_pcie_enable_msi() is not a good

it's (contraction of "it is")

> name for this function.  The function is better named as
> mc_pcie_fixup_ecam() as its purpose is to correct the queue
> size of the MSI CAP CTRL.

> -static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
> +static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)

Since the purpose of this seems to be to fix stuff in the MSI cap,
removing "msi" from the name seems weird.  The fact that it uses ECAM
to access the registers is incidental.

> -	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> -	msg_ctrl |= queue_size << 4;
> -	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
> +	reg &= ~PCI_MSI_FLAGS_QSIZE;
> +	reg |= queue_size << 4;

Could maybe use FIELD_PREP() instead of the shift?  I guess this would
go in the "Gather MSI information" patch.

Bjorn
