Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980876362EC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiKWPKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 10:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiKWPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 10:09:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254912AE12;
        Wed, 23 Nov 2022 07:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5D44B82096;
        Wed, 23 Nov 2022 15:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA1FC433C1;
        Wed, 23 Nov 2022 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216162;
        bh=ZB9yXxoNWv0/ib9hXa9McUF3dn9BdeiQydTdlw+V3J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkvAYFNHhdlZqIJOGsEfQnFk5pkTAqg36frexyGlewnwozb7Y5OIe5S0WzD2y/V+s
         awdkDoeGQwn3xQTF2F8mJlQdrs85FCT81aqnz9QGwEXWXGjCMruifGgQupcscmCrDl
         tZeRNbP0MUfm/ZmV7xvZvTyhXu7P3YkZk1LJ3gemPja1XRB3FQjUquXsvSDGEH73MS
         kgXjZ0JzobJ9Jea0NsaHr4KZjEsxdN8Gaud++siIa3Ii56I04nx3utAfGHPtAOat66
         wkX901eLvy0zt6DQ51YA7hoTJJWQ5Aa/cvCfUV43nvi1EBoqePr/1zsbaQQ4DEJbiz
         BkK021E9NWl6A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v7 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
Date:   Wed, 23 Nov 2022 16:09:12 +0100
Message-Id: <166921583106.17960.15949667825256145052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 13 Nov 2022 22:12:41 +0300, Serge Semin wrote:
> This patchset is a third one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: Done v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> Merged: kernel 6.0-rc1
> [3: In-review v7] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: ---you are looking at it---
> [4: Done v6] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
> 
> [...]

I think it is time we merged this series - we went through
several rounds of reviews and it should be ready for
mainline (in particular wrt using the generic infrastructure
it puts in place).

Applied to pci/dwc, thank you.

[01/20] dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
        https://git.kernel.org/lpieralisi/pci/c/b8a83e600bdd
[02/20] dt-bindings: visconti-pcie: Fix interrupts array max constraints
        https://git.kernel.org/lpieralisi/pci/c/4cf4b9b70ab2
[03/20] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
        https://git.kernel.org/lpieralisi/pci/c/057646a5db2f
[04/20] dt-bindings: PCI: dwc: Remove bus node from the examples
        https://git.kernel.org/lpieralisi/pci/c/b9fe9985aee2
[05/20] dt-bindings: PCI: dwc: Add phys/phy-names common properties
        https://git.kernel.org/lpieralisi/pci/c/875596361910
[06/20] dt-bindings: PCI: dwc: Add max-link-speed common property
        https://git.kernel.org/lpieralisi/pci/c/eaa9d8865287
[07/20] dt-bindings: PCI: dwc: Apply generic schema for generic device only
        https://git.kernel.org/lpieralisi/pci/c/f133396e2d00
[08/20] dt-bindings: PCI: dwc: Add max-functions EP property
        https://git.kernel.org/lpieralisi/pci/c/12f7936c7a0e
[09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
        https://git.kernel.org/lpieralisi/pci/c/35486813c41b
[10/20] dt-bindings: PCI: dwc: Add reg/reg-names common properties
        https://git.kernel.org/lpieralisi/pci/c/4cc13eedb892
[11/20] dt-bindings: PCI: dwc: Add clocks/resets common properties
        https://git.kernel.org/lpieralisi/pci/c/bd9504af9169
[12/20] dt-bindings: PCI: dwc: Add dma-coherent property
        https://git.kernel.org/lpieralisi/pci/c/4a8972542a6d
[13/20] dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
        https://git.kernel.org/lpieralisi/pci/c/98b59129cb9f
[14/20] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
        https://git.kernel.org/lpieralisi/pci/c/ce27c4e61f2d
[15/20] PCI: dwc: Introduce dma-ranges property support for RC-host
        https://git.kernel.org/lpieralisi/pci/c/8522e17d4cab
[16/20] PCI: dwc: Introduce generic controller capabilities interface
        https://git.kernel.org/lpieralisi/pci/c/7f9e982dc4fc
[17/20] PCI: dwc: Introduce generic resources getter
        https://git.kernel.org/lpieralisi/pci/c/ef8c58877fe7
[18/20] PCI: dwc: Combine iATU detection procedures
        https://git.kernel.org/lpieralisi/pci/c/9f67ecdd9579
[19/20] PCI: dwc: Introduce generic platform clocks and resets
        https://git.kernel.org/lpieralisi/pci/c/ef69f852a978
[20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
        https://git.kernel.org/lpieralisi/pci/c/ba6ed462dcf4

Thanks,
Lorenzo
