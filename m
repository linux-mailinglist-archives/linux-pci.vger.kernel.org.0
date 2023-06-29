Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E8742ECD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF2Urh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF2Urg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 16:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10C10F7
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 13:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6226761628
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 20:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705A3C433C8;
        Thu, 29 Jun 2023 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071654;
        bh=8kMGzaIdFkbNUxR3494GfsN7h1xgVubbw97KWSPe1eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwg9tHuf2fGcwsPfY3uK6f/Oal6N5wBfgc1MbAb9QdhvkBxmZm4cLYK3spC8zyzY7
         jQBQJyPFzcDscw/loXhrH0CIIf42hV3UoC+hxP6+/CKCaXXtj7EFYqF30ZGqDHQfz8
         gIdXcnb0ONho5nvqv6eTRFUL7UQktBswSsyANhHAo4k4aG38YburtzuD+V99zWjd0X
         ZLtgIF1CMF64hF0GJTRxdD4+1y99TQYbDiejaYikPlNZdmc0YIkfpcT37SoWNM+FGZ
         nBz2UUzufYureR6iXVQE2LyY7jjGclIE3KaUz6kWOch0Oaxoa7CzVm6gMpC5r70r8B
         RDTQ4TdpYEo1Q==
Date:   Fri, 30 Jun 2023 05:47:32 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH 3/3] PCI: microchip: Remove cast between incompatible
 function type
Message-ID: <20230629204732.GA83442@rocinante>
References: <20230629165956.237832-1-kwilczynski@kernel.org>
 <20230629165956.237832-3-kwilczynski@kernel.org>
 <20230629-smirk-resample-6741dcf9eac5@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629-smirk-resample-6741dcf9eac5@spud>
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

[...]
> > Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> > Co-developed-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Co-developed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 
> This looks to be the same content wise as the patch I previously acked &
> effectively the same as the one I previously reviewed - you could have
> picked up either of those tags from the other submissions tbh.

I had thought about it but decided against it, as I wasn't sure if that
would be OK, given a new series and new author, etc., even though the code
is almost identical. I have seen you offered Reviewed-by and Acked-by once
before, and I appreciate that.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thank you!

	Krzysztof
