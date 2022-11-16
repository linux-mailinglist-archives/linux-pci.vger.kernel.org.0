Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702D62C53B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiKPQqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiKPQp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:45:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DA22535;
        Wed, 16 Nov 2022 08:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3475FB81DFA;
        Wed, 16 Nov 2022 16:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B9C433C1;
        Wed, 16 Nov 2022 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616896;
        bh=HYpEHb458ynbxAKabjr4uSIFgXP6E7ARKUixQ37JNbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S/lCORL+53IpIORWuv0CT/72nB3+aH4UbStCBy4xwsYjjw4GUO8DNw9wiX0aCYBJv
         44M6dGbkGYQ1nqWANg80A18EwFOThv8MtqErFQzOapPuV34rA3s/z2Pj+oiMbdU1AT
         j/eS9WvY21WPImy8rEgcqNW1oP9aVEWqNdxX4kdtLnqBg9YbxE7OYinnA4x2fDdiy9
         Ogg5vgo7wZetuRfoSbP85mfnJEIZ572r0M0uwLEHvfWz4+iCq7RfXvg21K2YziZ71s
         M2JHkDmN9hS/0+np3KsulIQvrt6ZyMLqFNqWhSpF3JNzok4R7bYl0XPjxPJWAOv5sz
         B26h4thcE9Chw==
Date:   Wed, 16 Nov 2022 10:41:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 5/9] PCI: microchip: Gather MSI information from
 hardware config registers
Message-ID: <20221116164135.GA1117054@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-6-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:00PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> The PCIe root complex on PolarFire SoC is configured at bitstream creation
> time using Libero.  Key MSI-related parameters include the number of
> MSIs (1/2/4/8/16/32) and the MSI address. In the device driver, extract
> this information from hw registers at init time, and use it to configure
> MSI system, including configuring MSI capability structure correctly in
> configuration space.

Minor nits for v2.

> +	/* fixup msi enable flag */

s/msi/MSI/ here and comments below to match other usage.

> +	reg = readw_relaxed(ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +	reg |= PCI_MSI_FLAGS_ENABLE;
> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* fixup msi queue flags */
> +	queue_size = reg & PCI_MSI_FLAGS_QMASK;
> +	queue_size >>= 1;
> +	reg &= ~PCI_MSI_FLAGS_QSIZE;
> +	reg |= queue_size << 4;
> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* fixup msi addr fields */

> +	/* allow enabling msi by disabling msi-x */

s/msi-x/MSI-X/
