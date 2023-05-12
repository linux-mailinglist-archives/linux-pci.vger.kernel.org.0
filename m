Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A516E700D4B
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjELQra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjELQrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 12:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1439ED6;
        Fri, 12 May 2023 09:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7863663BBE;
        Fri, 12 May 2023 16:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B4DC4339B;
        Fri, 12 May 2023 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683910043;
        bh=KlgnmU4xeqwpanlDerWw2/PC991uOcdGI+fGV9j4OTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N9jPyD71TiXbKqopq9EEb7oCcX5tIofr695ll+49fTMNjlJZxK3MDjwQa4IrwQur+
         qf69CQLqDuQv/By+iSPtWlnuDcT5tYSVS/aF6lexCfotl73qEdbUWKyWU88f/cdkfW
         /UaGSm7HiTEuxMXGn0K5trrNy9RhlWoP+rwEk5YKh+mHgrCPkKlA/IJs80DbcNiOir
         rRLxq8vA29b1fzyivSuXKO2gWFIFdF6gTTeEmvyqfCNuJAbg68n9jSwik9hkpiwCaX
         3o6V42MTdNEouECEfzyOOo0W7+OEnMaLG4ZPdIUSbdkvIlXDjNhLWA4JE68VnbsS9Z
         QaPlBzoq4lkug==
Date:   Fri, 12 May 2023 11:47:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] PCIE: j721e: Add support to build pci-j721e as a
 kernel module
Message-ID: <ZF5tmV+cXc/qwQAU@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512070510.1873171-3-a-verma1@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow previous subject line style (specifically, "PCI" not "PCIE"):

  053ca37c87af ("PCI: j721e: Initialize pcie->cdns_pcie before using it")
  19e863828acf ("PCI: j721e: Drop redundant struct device *")
  72de208f2bda ("PCI: j721e: Drop pointless of_device_get_match_data() cast")
  496bb18483cc ("PCI: j721e: Fix j721e_pcie_probe() error path")
  c8a375a8e15a ("PCI: j721e: Add PCIe support for AM64")
  f1de58802f0f ("PCI: j721e: Add PCIe support for J7200")

On Fri, May 12, 2023 at 12:35:09PM +0530, Achal Verma wrote:
> pci-j721e driver can be build as a in-built kernel driver only, which is not required as it
> is not used during boot time in most cases. This change add support to build pci-j721e as a
> kernel loadable module.
> J721e PCIe controller can work in both host mode and end-point mode.
> In order to enable host mode driver and endpoint driver to be built independently either
> as built-in or kernel module, the pcie-j721e.c driver is refactored into following components:
> 
> 1) pci-j721e-host.c : Driver used when PCIe controller has to be initialized in host mode.
> 2) pci-j721e-ep.c : Driver used when PCIe controller has to be initialized in endpoint mode.
> 3) pci-j721e.c : contains common code required in both modes.

Wrap all to fit in 75 columns, add blank lines between paragraphs.

Bjorn
