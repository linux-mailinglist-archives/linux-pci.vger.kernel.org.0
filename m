Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9E60F942
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiJ0Nib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiJ0Nia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 09:38:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454B181488;
        Thu, 27 Oct 2022 06:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A036B82633;
        Thu, 27 Oct 2022 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722B2C433C1;
        Thu, 27 Oct 2022 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666877907;
        bh=pllUkLfz45ydi2Wi6jpPnGPo9M25t+6/Kw3UeVHzGdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XA5Ckkqd0MKG04G1je+NRuX1YlckWLju0xK3x3oUFbwBzEWP6CCfNDpPs4an9dpok
         zTBWBixFCPVT6QiWgG06RRjmUVE+7QhKtLZW6B7yG60cj4z+DP30OQiyW+scbCLjhc
         /E23kdKoDTQanhEvTGk+kVSkBlzowin0Wcf+oPMRuHMB4/tpgnkvmmiqqPZ4NF0Vcq
         p942/XBiczoyTBgTKPBfe9CjdC6F5DbIXfIVQwcdzJ4ryHBrcqdU5Jp1Lva0Po2bTn
         L/okQRXRP0jU38kGSHQZ8g9LmY5hxfULdWp2a9lD5utiwTnV0uXe3TVXFuRzmMBt6V
         TjROlYhclurRw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: (subset) [PATCH v1 00/11] Get rid of [devm_]gpiod_get_from_of_node() public APIs
Date:   Thu, 27 Oct 2022 15:38:11 +0200
Message-Id: <166687787352.847482.10005684512699510391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 4 Sep 2022 23:30:52 -0700, Dmitry Torokhov wrote:
> I would like to stop exporting OF-specific [devm_]gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit. We can do that by switching drivers
> to use generic fwnode API ([devm_]fwnode_gpiod_get()). By doing so we open
> the door to augmenting device tree and ACPI information through secondary
> software properties (once we teach gpiolib how to handle those).
> 
> I hope that relevant maintainers will take patches through their trees and
> then we could merge the last one some time after -rc1.
> 
> [...]

Applied to pci/tegra, thanks!

[01/11] PCI: tegra: switch to using devm_fwnode_gpiod_get
        https://git.kernel.org/lpieralisi/pci/c/16e3f4077965

Thanks,
Lorenzo
