Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C055A054
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiFXRfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXRfq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 13:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA55D13E;
        Fri, 24 Jun 2022 10:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC71DB82B00;
        Fri, 24 Jun 2022 17:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E3C34114;
        Fri, 24 Jun 2022 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656092143;
        bh=jNWQgByNPGwt1vuGYhLV57h57DF3v7csL/7CapG0qJ8=;
        h=Date:From:To:Cc:Subject:From;
        b=QjcgpRPkaeb4vmkKrM7HzojQ7QA1S2Y+QHycO8lBVYM4nB84sBUKxoyqINIcCTzC/
         u/AeRZn0WiiUnM50mBwZLWHIZ6NNnH9kWGifcisyMZ4CBRe9sg00AP1z7zUW/CuB+G
         2l/Eh/WMNkO2vFKOPb0Q8tGm16J05+wa3qb2zU53H8iX6eue9i3i+jP6bXYDVZfeUx
         G/t1KzuGZePUnckiLtgo7CLbjULohSJUfrQIe7pZivyt49mrWyjq/irQlRJROOgOmn
         w1twxoqkVjtBBUeAkuYd86Rgk7z6Ormeov5mGZecpDeSJwLbjIV0bl4Ha/G2d0f8ZN
         p1igItfuZzLTw==
Date:   Fri, 24 Jun 2022 12:35:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: pci-exynos.c phy_init() usage
Message-ID: <20220624173541.GA1543581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In exynos_pcie_host_init() [1], we call:

  phy_reset(ep->phy);
  phy_power_on(ep->phy);
  phy_init(ep->phy);

The phy_init() function comment [2] says it must be called before
phy_power_on().  Is exynos doing this backwards?

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-exynos.c?id=v5.19-rc1#n252
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/phy-core.c?id=v5.19-rc1#n233
