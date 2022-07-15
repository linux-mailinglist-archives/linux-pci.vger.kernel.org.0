Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8257609A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGOLfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGOLfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B694D831;
        Fri, 15 Jul 2022 04:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71BBE622EA;
        Fri, 15 Jul 2022 11:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AEAC34115;
        Fri, 15 Jul 2022 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657884910;
        bh=pYI5okDc37msRqnfKIveqoUw4anLGHg/O2orcG5WOs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hE7/5KV2bbmzxDhOPC6caMqNbd9vrUqJIV/n8xn4n8tKZMlSPs7RdYc4ftu3Abv8x
         yh6nvKed9MsWqf9ijpgkvDHE7VL/Z6XRZrR81M/7dvYaMALqvgx+MnKMnnsl5QLWZ1
         vFK1fA6f+uBNeZcefuIUzY0nIG54IscpPM4KTJxhbxV8HDSSvLf/K9mgWCcn37Fb9c
         kJYk1geU1wBRh/SryJpd01dT4VOLUfKH174WLtbdPh5U22SIUt4vwd8QxZyNSWfT9k
         ix4xLPqdlrB7tWod/Jd8/EVO+TJ4SeDzoD4kLBePAUmm6K93hPgd3RV0lerf9h6rmw
         ndDKeXIuNLGuQ==
Date:   Fri, 15 Jul 2022 17:05:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Message-ID: <YtFQ67MmloipjNzj@matsya>
References: <CGME20220628220437eucas1p2c478751458323f93a71050c4a949f12e@eucas1p2.samsung.com>
 <20220628220409.26545-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-06-22, 00:04, Marek Szyprowski wrote:
> The exynos-pcie driver called phy_power_on() and then phy_init() for some
> historical reasons. However the generic PHY framework assumes that the
> proper sequence is to call phy_init() first, then phy_power_on(). The
> operations done by both functions should be considered as one action and
> as such they are called by the exynos-pcie driver (without doing anything
> between them). The initialization is just a sequence of register writes,
> which cannot be altered, without breaking the hardware operation.
> 
> To match the generic PHY framework requirement, simply move all register
> writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> callbacks. This way the driver will also work with the old (incorrect)
> PHY initialization call sequence.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
