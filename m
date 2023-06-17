Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4447733F3F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbjFQHj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jun 2023 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjFQHj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2023 03:39:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218311AB;
        Sat, 17 Jun 2023 00:39:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so20595911fa.0;
        Sat, 17 Jun 2023 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686987563; x=1689579563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIdeMrV7gyutB60slM5F7S1vImka4WwXs93FAbGE1gQ=;
        b=VLEX0Ab5PVUEKm2nBbAf9tQBNzkFwn9nHLx6ZI4C+mhrJh0xkzWPvdyC5swD+uj3oc
         yg+xhvrzRj9TV7s/bn5+li772Jf1DfclMVSxYW4oRZMPMTktD9/5llLAilETurC+2TcF
         d7ess5UNH52sbLptLD37Y5y7aXasKsumccGZF4gETCLJpPPP+MGGvH5cenFuiRCyM920
         i+P/rB/ar+PeQrn7+7n8+lGHYzM8urcYghc53u7H4YlR4tRpyVrA5IH8J9TgEfJynJ/R
         sF5Hxjp0VNDX/gaXJtQznMdtsI71TdFvCdu9s5fIj0GuAHIvl31VxZJsURNTbjJ7UZlk
         NwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686987563; x=1689579563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIdeMrV7gyutB60slM5F7S1vImka4WwXs93FAbGE1gQ=;
        b=fzLdcougIbZ8zbBAK5PMGZ6p34qacojsNMtMDp4jBA4A6MuuJz06ZnykdIyn6ZUypI
         MDikR8CvLO3W+lFvOPiVuwso3MKkkrVfQuSbFmkd3o2EpjsLUzty3E5xiDNlCCyv4scv
         pkMYOPApzPzI4oMl309iYXB7tONwtpDAyAu0MovfGCtdn13a4AeYuP71Z1XW22ur0kji
         WEjB8U0xIn53U47smB+sfpp8SjNvPBe0Tsu/ZPHDtf2Fo4E8aIRbITpTfF3IgnNYnw7A
         9v7xNfjw9ccc5OwlB91ojOpmOqfmjyigwQaBhWMgyNlE3ukS6lAWE3jRSldgBaGd3r+s
         AuwQ==
X-Gm-Message-State: AC+VfDzmDhYxJf+89YEOFEffG2D166S1dMPjv90DYHp9SaL48MMEr0bW
        3fsmLTIkgXG2AyKgPZpkDRU=
X-Google-Smtp-Source: ACHHUZ5e3rWd2nxvAUXXdflunP1MwQCYxZ+76Ew7b+IyosbqAsuEl9s4HN4NgZkCl+9TAQsWHwhoKg==
X-Received: by 2002:a2e:9b5a:0:b0:2b4:6b1f:9a6b with SMTP id o26-20020a2e9b5a000000b002b46b1f9a6bmr247903ljj.23.1686987563033;
        Sat, 17 Jun 2023 00:39:23 -0700 (PDT)
Received: from mobilestation ([109.194.233.141])
        by smtp.gmail.com with ESMTPSA id o19-20020a2e9b53000000b002b45b90385asm585830ljj.55.2023.06.17.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 00:39:22 -0700 (PDT)
Date:   Sat, 17 Jun 2023 10:39:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 0/4] RK3588 PCIe2 support
Message-ID: <20230617073919.h6x32caeznx4q6cp@mobilestation>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian

On Fri, Jun 16, 2023 at 07:00:18PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This adds PCIe2 support for RK3588. The series has been tested with the
> onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1) and
> Radxa Rock 5B (&pcie2x1l2). The final patch in this series depends on
> the combo PHY support added by the SATA series [0].

Thanks for submitting the patchset. I'll have a closer look at it on
the next week.

-Sergey(y)

> 
> [0] https://lore.kernel.org/all/20230612171337.74576-1-sebastian.reichel@collabora.com/
> 
> Thanks,
> 
> -- Sebastian
> 
> Sebastian Reichel (4):
>   dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
>   dt-bindings: PCI: dwc: rockchip: Add missing
>     legacy-interrupt-controller
>   dt-bindings: PCI: dwc: rockchip: Update for RK3588
>   arm64: dts: rockchip: rk3588: add PCIe2 support
> 
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  58 +++++++++-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  15 ++-
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  54 +++++++++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 108 ++++++++++++++++++
>  4 files changed, 231 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.2
> 
