Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B07BA59C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjJEQSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbjJEQQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C6117AF;
        Thu,  5 Oct 2023 08:09:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05297C433C8;
        Thu,  5 Oct 2023 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696518549;
        bh=5YVMBG6JswPWpw0WjpEGMYStxOrvWp+YdPZGxHSzB60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hPvGxVPoi3bmo4IgBvP0RsxJoNzqNanBnL7XLsRPatP1wWERT5+V2Yf2EZuj4+uMH
         LJgqH5n3JHOsByOiMd/bhO/mBlH7xfu/AegztZaA2HC+zHoJFnzPFVfTkzpp8CAzm1
         FbDQPGD3C8iywGD6p2MOJgO4adX7pI/Eb5U9BL0AtJH8/zTli+0U1vUWW6BGFQRRHd
         u6r5G0aL706HLTxljz6xFD1uLqqAyoNMidzplDf9M7+33ZWYU2ZX+L7z1W8V5Z9fqo
         ej1wyjqq9fJajpBh0VvX6owPFKLQZ7mmDZF0HTFtb4ZhaY+bx2d/rz4uPonNc1Cbgz
         UT/AizHg3tjog==
Date:   Thu, 5 Oct 2023 10:09:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v23 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support for host mode
Message-ID: <20231005150907.GA746291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926122431.3974714-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 09:24:28PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe controller support for host mode.
> 
> This controller is based on Synopsys DesignWare PCIe. However, this
> particular controller has a number of vendor-specific registers, and as
> such, requires initialization code like mode setting and retraining and
> so on.
> 
> [kwilczynski: commit log]
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-17-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

You should never include a signed-off-by from the person you're
sending the patch *to*; this "Signed-off-by: Krzysztof Wilczyński
<kwilczynski@kernel.org>" should be added by Krzysztof when he applies
it.

Whoever applies this, please s/PCI: dwc:/PCI:/ in this subject and the
"Add endpoint mode support" patch.  No need to include *both* "dwc:"
and "rcar-gen4".

> +config PCIE_RCAR_GEN4_HOST
> +	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	select PCIE_RCAR_GEN4
> +	help
> +	  Say Y here if you want PCIe controller (host mode) on R-Car Gen4 SoCs.
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called pcie-rcar-gen4.ko. This uses the DesignWare core.

This should be sorted so the menuconfig prompts are in alpha order.

> + * Manually initiate the speed change. Return true if the change succeeded,
> + * false if the change didn't finish within certain periods.

"Return 0 if change succeeded; otherwise -ETIMEDOUT".

No need to repost unless somebody suggests more significant rework;
these can be tweaked when merging.

Thanks a lot for squashing into a single file; that's a major
simplification.

Bjorn
