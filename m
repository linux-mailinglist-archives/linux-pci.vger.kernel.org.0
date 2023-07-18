Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B67573E4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 08:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGRGQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjGRGQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 02:16:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48F2103;
        Mon, 17 Jul 2023 23:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BFE6146C;
        Tue, 18 Jul 2023 06:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A470C433C8;
        Tue, 18 Jul 2023 06:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689660944;
        bh=cUbtQFwtfNqfULDCUbv0nOM8BYXs2LTWrJLdZvxDQA8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KJMbAtyc6I4UHt7JFBVCvT14hZFxEuSn4EUlSOeJYjfmbE5T15HppBRoUbJax/Vtm
         869HTzQvKifHDgR2O6mXMZPwr9FNPI53GvIY3GS2y1ZXAk84W5q/JxvSiYhQPN6N/4
         2pdCEkamrgQOIO6ksvmJ1MVA4wNMZ+QvYssZwsUmSTEZCR6yiSJq7yut8GDT5tNhUZ
         hZsMUuT+RqvRZX4kJfQYgJn9iFHaasyZU3hPQPOsoVupT7pDyG2vOzZ7Vv9UMqPMBq
         /POpr7jpl0bocB0WIjrTURwiWpsuZMWyF/GB8IzpM7p8HpMfIDZSJ6on4t0eynysl6
         RRyyt8RJGyA1A==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20230717173512.65169-1-sebastian.reichel@collabora.com>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v2 0/2] RK3588 PCIe3 support
Message-Id: <168966093703.340315.14184672794247667224.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 11:45:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 17 Jul 2023 19:35:10 +0200, Sebastian Reichel wrote:
> This adds PCIe v3 support for RK3588. The series depends on the PCIe
> v2 series [0], since the the same binding is used. It has been tested
> on Rockchip EVB1 and Radxa Rock 5B.
> 
> Note, that the PCIe3 PHY driver is currently missing bifurcation
> support for RK3588. Thus after this series only PCIe3x4 is usable
> (in aggregated x4 mode) without adding support for the PHY's
> "rockchip,pcie30-phymode" DT property, which allows configuring
> how the lanes are distributed. Aggregated 3x4 mode seems to be the
> most common configuration. Both EVB1 and Rock 5B use it, so I
> cannot test anything else anyways.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
      commit: f66782cff479807ad7e98f0cf6a0c0babfe0159b

Best regards,
-- 
~Vinod


