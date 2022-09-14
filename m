Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB605B8C34
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiINPrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiINPrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 11:47:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3080B74;
        Wed, 14 Sep 2022 08:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C32B8191E;
        Wed, 14 Sep 2022 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23291C433C1;
        Wed, 14 Sep 2022 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663170458;
        bh=Vuv4mlyU327q6kYHLPn8YLNWd6wwgr4aGa8caHJflFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVRxF0URqbKj6vE8FlXeL2bi6W+wzGtUCzISCA+WL2Qa8Kw2CH4UDlBAFgBehHzZY
         g3ypqU0/w0EaX5HxgxM1LCdOZCjcFxPA6vDqGMxQgbRYpyzHripv/JVXlZ6+zE95bI
         Cy9i/H3ZlADJ54kOeOD9gffE/aTEae4ajkGQ8fKys9x1bZjAkqIaEfbWpao6YWldk9
         IjifSHvRauyZz4IISlSUNs09xe14tA8D7cBSIboTYRnRsYvShXS51Xcm8oGD8l/Fo9
         uvHP0UwP0RSKkyN3H5wi1ZyIq+S2dgkEMdViOtATnGFxm3F31+qggbXjJIC9M1k5DL
         NNmW2ej3jkhfQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: do not leak reset GPIO on unbind/unload/error
Date:   Wed, 14 Sep 2022 17:47:31 +0200
Message-Id: <166317043943.2639676.3222680734266270030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YxatO5OaI2RpxQ2M@google.com>
References: <YxatO5OaI2RpxQ2M@google.com>
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

On Mon, 5 Sep 2022 19:15:23 -0700, Dmitry Torokhov wrote:
> The driver allocates reset GPIO in apple_pcie_setup_port() but neither
> releases the resource, nor uses devm API to have it released
> automatically.
> 
> Let's fix this by switching to devm API. While at it let's use generic
> devm_fwnode_gpiod_get() instead of OF-specific gpiod_get_from_of_node()
> - this will allow us top stop exporting the latter down the road.
> 
> [...]

Applied to pci/apple, thanks!

[1/1] PCI: apple: do not leak reset GPIO on unbind/unload/error
      https://git.kernel.org/lpieralisi/pci/c/a6b9ede1f3df

Thanks,
Lorenzo
