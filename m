Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E4533244
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiEXUPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXUPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 16:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC982165
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 13:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633616171C
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 20:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FA9C34100;
        Tue, 24 May 2022 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653423312;
        bh=0JX473Io4yCGGl5vB2wMzTw3hO5Nnl6cxNE+p4mnNFk=;
        h=Date:From:To:Cc:Subject:From;
        b=bm6t62lYQNETxbTj4bSHAY7UFe59Vjv5flf4If0MtpYTjPypBNyx8Tw5Dn5NOw4p/
         tKycXlXYY7g5MWD0xUU6bu4UYx/XNcrwWfEV5QROP+wiu2bgzH+gYGo+OE39B3/5HU
         qdN2MZxucS1mGLc8o4vmtNN27NZrTP6iCSag+CoRq7c5jFJoqgXdXnPAp6ZYtB9X2y
         xUmJlHZl79IY3CIfs119R8MF8edsVvxVSDv79etbIvNuU0XWgzhLvhI/OtpCWPRylL
         SBp/9OWHhEN676FYq9MCXdKLxyyA79wu6ePfHRKy9Mq1BhC3sxuVZAlpu7FaISVhrw
         sPXVuxEiX5OYA==
Date:   Tue, 24 May 2022 15:15:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: PCI: keystone: ks_pcie_v3_65_add_bus()
Message-ID: <20220524201509.GA257154@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Not sure whether anybody cares about the keystone driver any more.  It
seems basically unmaintained after 57e1d8206e48 ("MAINTAINERS: move
Murali Karicheri to credits") [1].

Anyway, ks_pcie_v3_65_add_bus() [2] looks unusual to me.  It's an
.add_bus() method that is called whenever we create a new PCI bus:

  ks_pcie_v3_65_add_bus(...)
  {
    ks_pcie_set_dbi_mode
    dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1)
    dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1)
    ks_pcie_clear_dbi_mode(ks_pcie)
    dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start)
  }

This seems like something that should be done when the Root Port is
enumerated, not when we set up its secondary bus.  Maybe somewhere in
ks_pcie_host_init() or ks_pcie_config_msi_irq()?

I don't think we should use .add_bus() unless it's actually something
related to adding a bus.

[1] https://git.kernel.org/linus/57e1d8206e48
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-keystone.c?id=v5.18#n452
