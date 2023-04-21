Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363A6EA7F7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDUKLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDUKLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 06:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03142CC1D
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 03:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819BD64FD2
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 10:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F4FC433EF;
        Fri, 21 Apr 2023 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682071835;
        bh=2WZ6zWGABxULbZd4MudNPVW+j5PfBaiFRohzEEx1ovY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOxm4/Nqy5Cv15JlPjl3lzWGJICyIhCIocWuvD8wNHgmjTIx4JbsGt5uyEzO5I2R2
         WBul5tCNBTyWlEioG/3NPT29Ov+93s6Oo96sEWsE26P6O8w2FZWZnZ52cbDcurQfnd
         Rl4XFlAdTZJK/EbYeLcYi7ptsYkLLKUnj0hmRAEWJhhu1WyvpoW2oqlLEBxWEWLgBt
         jtUDPM6ELKle/1xafqPnS+WfH97Shw/HIEYsihCN3nzh0m2wBTWULhyZGUMmEpj+lC
         UXuAYxo8hh8IzrhGZEd4Q87pQJRlsHxSV0KdFDEh9+RQt/BYu+NKccCWD8Ix6yCLQe
         RpzBQWh3h+pHA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 00/17] PCI endpoint fixes and improvements
Date:   Fri, 21 Apr 2023 12:10:29 +0200
Message-Id: <168207180934.83057.1899705528703808300.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 15 Apr 2023 11:35:25 +0900, Damien Le Moal wrote:
> This series fixes several issues with the PCI endpoint code and endpoint
> test drivers (RC side and EP side).
> 
> The first 2 patches address an issue with the use of configfs to create
> an endpoint driver type attributes group, preventing a potential crash
> if the user creates a directory multiple times for the driver type
> attributes.
> 
> [...]

Applied to controller/endpoint, thanks!

[01/17] PCI: endpoint: Automatically create a function specific attributes group
        https://git.kernel.org/pci/pci/c/8dcae97d9819
[02/17] PCI: endpoint: Move pci_epf_type_add_cfs() code
        https://git.kernel.org/pci/pci/c/f373bc7cee2a
[03/17] PCI: epf-test: Fix DMA transfer completion initialization
        https://git.kernel.org/pci/pci/c/8b60b96dc008
[04/17] PCI: epf-test: Fix DMA transfer completion detection
        https://git.kernel.org/pci/pci/c/5628aaabe60e
[05/17] PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
        https://git.kernel.org/pci/pci/c/62d58b868ebe
[06/17] PCI: epf-test: Simplify read/write/copy test functions
        https://git.kernel.org/pci/pci/c/8b5609b95b7b
[07/17] PCI: epf-test: Simplify pci_epf_test_raise_irq()
        https://git.kernel.org/pci/pci/c/508f488b0913
[08/17] PCI: epf-test: Simplify IRQ test commands execution
        https://git.kernel.org/pci/pci/c/82e72fc97901
[09/17] PCI: epf-test: Improve handling of command and status registers
        https://git.kernel.org/pci/pci/c/ad15592c26d5
[10/17] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
        https://git.kernel.org/pci/pci/c/0674535d28a8
[11/17] PCI: epf-test: Cleanup request result handling
        https://git.kernel.org/pci/pci/c/00b225e73f30
[12/17] PCI: epf-test: Simplify DMA support checks
        https://git.kernel.org/pci/pci/c/64cedb06b1d9
[13/17] PCI: epf-test: Simplify transfers result print
        https://git.kernel.org/pci/pci/c/e68f5440ffb6
[14/17] misc: pci_endpoint_test: Free IRQs before removing the device
        https://git.kernel.org/pci/pci/c/0ca8e07fc751
[15/17] misc: pci_endpoint_test: Re-init completion for every test
        https://git.kernel.org/pci/pci/c/259456ae2804
[16/17] misc: pci_endpoint_test: Do not write status in IRQ handler
        https://git.kernel.org/pci/pci/c/53a52a0d213e
[17/17] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
        https://git.kernel.org/pci/pci/c/7885dbeb8780

Thanks,
Lorenzo
