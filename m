Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1F6E2812
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNQJ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDNQJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5D6A5E
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AD1648DD;
        Fri, 14 Apr 2023 16:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16046C433D2;
        Fri, 14 Apr 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488564;
        bh=ULFAgbepcwxvEv1WHdnbDA3LaszqFtFFXJHxxkcO45M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n89c17W54QHw9VYMLJmqZwkqyJ1pt27UZd/YokPQMZV3CjrTX+W/FrfmmXJB10LSp
         6wj0L1u+ZyC0EWZ0zVSs7MgAqtRv+RHwts/cxBcPoy7Wk68yzMzKzu0Vy28DXT0RzC
         VQbyslnl+BVx4pgKy5AddIzJ7zBH8nSN+EN7WXpg362LePegnoVEBhb5tva5TzuZGc
         150/ObJ9OLrrPx/iD5UXtOCgpxPBW7GbQY5ynSTF4lTWnscVax7KqlDTmr8sgx835a
         TQk7978n9TExcL04axbZmJcunyP2wAorHRhHFEaWiJz1JdZTnp2eMdJHg6s6qZUCiD
         Z/3ggQ7VfWV3w==
Date:   Fri, 14 Apr 2023 11:09:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, '@bhelgaas
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 08/17] PCI: epf-test: Simplify IRQ test commands
 execution
Message-ID: <20230414160922.GA197844@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-9-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:48PM +0900, Damien Le Moal wrote:
> For the commands COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ and
> COMMAND_RAISE_MSIX_IRQ, the function pci_epf_test_cmd_handler()
> sets the STATUS_IRQ_RAISED status flag and calls the epc function
> pci_epc_raise_irq() directly. However, this is also exactly what the
> pci_epf_test_raise_irq() function does. Avoid duplicating these
> operations by directly using pci_epf_test_raise_irq() for the IRQ test
> commands. It is OK to do so as the host side endpoint test driver always
> set the correct irq type for the IRQ test commands.
> 
> At the same time, the irq number check done for the
> COMMAND_RAISE_MSI_IRQ and COMMAND_RAISE_MSIX_IRQ commands can also be
> moved to pci_epf_test_raise_irq() to also check the IRQ number requested
> by the host for other test commands.
> 
> Overall, this significantly simplifies the pci_epf_test_cmd_handler()
> function.

s/irq/IRQ/ several times above to be consistent.
