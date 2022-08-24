Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97D59F8B2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiHXLkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 07:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXLkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 07:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402314E607;
        Wed, 24 Aug 2022 04:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA4961964;
        Wed, 24 Aug 2022 11:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2560C433D6;
        Wed, 24 Aug 2022 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661341216;
        bh=nAChmvsQjvtcSVy62sD3IXOHSXzowoeX589gEndadc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5LaXsQk2IVr92x+ZZ4emyhdpasxXMD6OezvzajgXW0YQ3XtDXtrHuxJ+SR9a/iH4
         gXk7ShBQ2RuEifLicqFoGdHAWrozlxYN2WPwLJvEZA/CZ+g2eGR7mKF8SwniZHYTrt
         kowuWv07npmbFo2q5Y/plj8zI8C2KK+qvUFm04QhpHhhGH/wZFYePjk1j92EvQVO/s
         cb06W5zIAsezCVg/Vk/9mbWhkvP66HB5XvTM7VZ9zt2kohIYfTT6k/2Y0z7UepPp1c
         O6SHYTf9yUca2uiAbAF8qkEUe1R9+BaDbIdi+NCPCZZCYI4anvsTUtbPUKR0tfIYF0
         IZxMBkhAVL2+A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <mail@conchuod.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] Fix RISC-V/PCI dt-schema issues with dt-schema v2022.08
Date:   Wed, 24 Aug 2022 13:40:07 +0200
Message-Id: <166134118410.100046.14129524978971500704.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 20 Aug 2022 00:14:09 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey all,
> 
> Got a few fixes for PCI dt-bindings that I noticed after upgrading my
> dt-schema to v2022.08.
> 
> [...]

Applied to pci/dt, thanks!

[1/7] dt-bindings: PCI: fu740-pci: fix missing clock-names
      https://git.kernel.org/lpieralisi/pci/c/b408fad61d34
[2/7] dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
      https://git.kernel.org/lpieralisi/pci/c/05a5741019a5
[3/7] dt-bindings: PCI: microchip,pcie-host: fix missing dma-ranges
      https://git.kernel.org/lpieralisi/pci/c/1a7966b33b5b

Thanks,
Lorenzo
