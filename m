Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9F747643
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGDQQG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGDQQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 12:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240610D9
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 09:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57086129E
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 16:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E7C433C8;
        Tue,  4 Jul 2023 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688487362;
        bh=k1DBTIVmtQdmuvViEJWZzhb8aPKMCScd3plhjiJsXXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9y86wx8Eua2Jt/lLwTgu+U1on/jF1Uy7fj3N2Ym2lH7sfkjztuhXmh3PIY/R2gPq
         qp5nvU02K0PY66Q2MOzor5X5XN3+g8/hYhLnvT5dFGKOzvNac8gR+fnwaDKGBlmUXq
         zBS7vmWOfFyNT6AyjxDO2g9KqVqJgVE8dfvT5pAHEK3KOQ9AqEcB46t2B3/p8kUDf+
         LzSPyABYm8FEwdPksgy2lAxBhZatBSvvLZj23H9cJDUBAdaEp6GaFYgUR3Nmwan+mn
         LbwsG0z0TfnN+1vSpBVlrzZSmleMX2SbQRxlMoS53v/JBZdfG7TbQ0ffLmkcK90+X9
         fpSWMdiBeP+hA==
Date:   Wed, 5 Jul 2023 01:16:00 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yue Wang <yue.wang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: meson: Remove cast between incompatible
 function type
Message-ID: <20230704161600.GA435329@rocinante>
References: <20230629165956.237832-1-kwilczynski@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629165956.237832-1-kwilczynski@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> Rather than casting void(*)(struct clk *) to void (*)(void *), that
> forces conversion to an incompatible function type, replace the cast
> with a small local stub function with a signature that matches what
> the devm_add_action_or_reset() function expects.
> 
> The sub function takes a void *, then passes it directly to
> clk_disable_unprepare(), which handles the more specific type.
> 
> Reported by clang when building with warnings enabled:
> 
>   drivers/pci/controller/dwc/pci-meson.c:191:6: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>                                    (void (*) (void *))clk_disable_unprepare,
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> No functional changes are intended.

Applied to controller/remove-void-cast, thank you everyone!

[01/03] PCI: meson: Remove cast between incompatible function type
	https://git.kernel.org/pci/pci/c/60fce60ab7b6
[02/03] PCI: keembay: Remove cast between incompatible function type
	https://git.kernel.org/pci/pci/c/43a2eef7cbba
[03/03] PCI: microchip: Remove cast between incompatible function type
	https://git.kernel.org/pci/pci/c/9e4811ce626f

	Krzysztof
