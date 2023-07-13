Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE649752B5C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjGMUJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGMUJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 16:09:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A21720;
        Thu, 13 Jul 2023 13:09:52 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qK2d0-0007XX-UA; Thu, 13 Jul 2023 22:09:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v2 0/3] RK3588 PCIe2 support
Date:   Thu, 13 Jul 2023 22:09:29 +0200
Message-ID: <9408492.EvYhyI6sBW@phil>
In-Reply-To: <20230713171851.73052-1-sebastian.reichel@collabora.com>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian,

Am Donnerstag, 13. Juli 2023, 19:18:48 CEST schrieb Sebastian Reichel:
> Hi,
> 
> This adds PCIe v2 support for RK3588. The series has been tested with
> the onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1)
> and Radxa Rock 5B (&pcie2x1l2).
> 
> Changes since v1:

Didn't Rob write that he applied patches 1-3 of the v1 series? [0]
or did I miss further communication somehow?

Thanks
Heiko

[0] https://lore.kernel.org/r/20230626193238.GA3553158-robh@kernel.org

>  * https://lore.kernel.org/all/20230616170022.76107-1-sebastian.reichel@collabora.com/
>  * Dropped patch adding 'RK3588' (queued by Rob)
>  * Updated patch adding legacy-interrupt-controller according to comments
>    from Rob and Serge
>     - added missing additionalProperties: false
>     - added all properties to new required property
>     - removed useless quotes around interrupt-controller
>     - added Rob's Reviewed-by
>  * Updated patch adding the missing RK356x/RK3588 interrupt names, so that it
>    provides more details about the interrupts
>  * Updated the DT patch according to the comment from Jonas Karlman, so that
>    the addresses are in 32 bit address space starting at 0x40000000
> 
> [0] https://lore.kernel.org/all/20230612171337.74576-1-sebastian.reichel@collabora.com/
> 
> Thanks,
> 
> -- Sebastian
> 
> Sebastian Reichel (3):
>   dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
>   dt-bindings: PCI: dwc: rockchip: Add missing
>     legacy-interrupt-controller
>   arm64: dts: rockchip: rk3588: add PCIe2 support
> 
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  48 ++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  76 +++++++++++-
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  54 +++++++++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 108 ++++++++++++++++++
>  4 files changed, 285 insertions(+), 1 deletion(-)
> 
> 




