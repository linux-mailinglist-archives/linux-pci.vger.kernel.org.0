Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20C6A10B1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBWTmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBWTmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 14:42:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346A5D444;
        Thu, 23 Feb 2023 11:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA4F6177E;
        Thu, 23 Feb 2023 19:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C292BC433EF;
        Thu, 23 Feb 2023 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677181352;
        bh=yBmZi1dgHiYx3f1jIdVOufjs7LlM8Rf+8jsvfrqP5eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jjYxMDUKZhonBr9WaQk+3e1oaOg71ENniA+tkDkWixIxikS5zJ1MOKKipwjbNj5N/
         O6JkZLgXAlb0SGWKstzO8DbFZw8uGn2RD3riEpNvJq1ZxA3tU4Z4hMq0kZagAW9haq
         nyyXcsWo6PgF0NGDmG5ZsAeMmOk+OvAVsS7yPvBuEwu48VEzW1O4/co3ps993eBuqJ
         ldpaqS2tGq2MuGRV2hbHBZeN+BwC5uT/gHtOJpwcV7EXZLEC2yG9OEPX4hjbRhDz8r
         ZUixli7uPsQHdBQ3TEba70j5CHzzHYkmuz3vXZn/HtFPMLS5STqwg9fuKqDWTbv8hx
         fVC5+6MFFdVVA==
Date:   Thu, 23 Feb 2023 13:42:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] PCI: dwc: Add support for Marvell AC5 SoC
Message-ID: <20230223194230.GA3888258@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 23, 2023 at 08:05:24PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for AC5 SoC with MSI and in message emulated legacy mode.
> There are differences in the registers addresses, blocks, DDR location
> for coherent DMA allocation and additional implementation specific registers.
> In addition, support cases of older Designware IP (Armada 7020) which supports
> above 4GB PCIe physical memory window by use of device tree.
> ...

> Elad Nachman (4):
>   dt-bindings: PCI: dwc: add DMA, region mask bits
>   PCI: dwc: support AC5 Legacy PCIe interrupts
>   PCI: dwc: Introduce Configurable DMA mask
>   PCI: dwc: Introduce region limit from DT
> 
> Raz Adashi (1):
>   PCI: armada8k: Add AC5 SoC support
> 
> Vadym Kochan (1):
>   dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC
> 
> Yuval Shaia (1):
>   PCI: armada8k: Add MSI support for AC5 SoC

Capitalize subject consistently.  Use consistent driver tags.  Use
parallel sentence structure.

s/add DMA/Add DMA/
s/PCI: dwc: support/PCI: armada8k: Support/
  (this particular patch only affects armada8k, so don't label it "dwc")
s/support/Support/
s/Configurable/configurable/
s/Add MSI support for AC5 SoC/Add AC5 MSI support/
  (parallel to "Add AC5 SoC support")

The PCIe spec doesn't really use "legacy" when defining the interrupt
model.  I think you're referring to INTx, which it *does* use and is
more specific.  If so, please say "INTx interrupts" instead of "legacy
PCIe interrupts".
