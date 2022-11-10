Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E1624576
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKJPTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiKJPSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24662FFF1;
        Thu, 10 Nov 2022 07:18:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E353619A3;
        Thu, 10 Nov 2022 15:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B386C433C1;
        Thu, 10 Nov 2022 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668093491;
        bh=aWfJdOuQxkek+fc/abYLX4U0ClXLg+ex/ABF0AlJm+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHwzJSi4AFv7EiV5nrZ+IH1ZUnsEtnGPcwsRYq3QBFxtDrzVgUcIaVdj0afJL4Csd
         eVsbOsN/lIwNchgrp/9MOxTr6UwDkvcsJHkJrtwv+lRfAQlbtGcRyo1M8sbKgZMWb8
         +kE0xHc1sxY59K3E78N/lQxTSWiHAustUHQjW+BL+LyDhweUodDp1b7HAEPaX/NiZ1
         9tdX4j/7d+0DpthG+xzduKqV3kpFa7xI6XUNvvMuB/dhoa0Ont2tFRgP9lKQ9l/y6x
         QGc7jwn/1UkyGjWO3b18LduF5lKsjjlMJSulPHyN/4Cd6jUjsN/yE6rLqHi3Rc2ldi
         68foeyLbxyEQw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v5 0/3] Add driver nodes for MT8195 SoC
Date:   Thu, 10 Nov 2022 16:18:03 +0100
Message-Id: <166809342824.141750.6981614117590772998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103025656.8714-1-tinghan.shen@mediatek.com>
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
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

On Thu, 3 Nov 2022 10:56:53 +0800, Tinghan Shen wrote:
> Add pcie and venc nodes for MT8195 SoC.
> 
> This series is based on linux-next/next-20221028.
> Depends on https://lore.kernel.org/all/20221001030752.14486-1-irui.wang@mediatek.com/
> 
> v4 -> v5:
> - update reset-names of pcie yaml
> 
> [...]

Applied to pci/dt (dts updates should go via platform tree), thanks!

[1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
      https://git.kernel.org/lpieralisi/pci/c/c9bfd858402c

Thanks,
Lorenzo
