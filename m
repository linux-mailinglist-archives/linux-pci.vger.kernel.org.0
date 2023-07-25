Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF0762100
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGYSHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 14:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjGYSHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 14:07:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BA1FDA;
        Tue, 25 Jul 2023 11:07:09 -0700 (PDT)
Received: from [185.230.175.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qOMR0-00067u-HF; Tue, 25 Jul 2023 20:06:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Qu Wenruo <wqu@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Simon Xue <xxm@rock-chips.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, John Clark <inindev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, kernel@collabora.com,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] RK3588 PCIe3 support
Date:   Tue, 25 Jul 2023 20:06:56 +0200
Message-ID: <6404573.MHq7AAxBmi@phil>
In-Reply-To: <20230724192223.5jnu5wgrzmmjz5z5@mercury.elektranox.org>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
 <169022594803.2911118.12432442062352790360.b4-ty@sntech.de>
 <20230724192223.5jnu5wgrzmmjz5z5@mercury.elektranox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, 24. Juli 2023, 21:22:23 CEST schrieb Sebastian Reichel:
> Hi Heiko,
> 
> On Mon, Jul 24, 2023 at 09:12:35PM +0200, Heiko Stuebner wrote:
> > On Mon, 17 Jul 2023 19:35:10 +0200, Sebastian Reichel wrote:
> > > This adds PCIe v3 support for RK3588. The series depends on the PCIe
> > > v2 series [0], since the the same binding is used. It has been tested
> > > on Rockchip EVB1 and Radxa Rock 5B.
> > > 
> > > Note, that the PCIe3 PHY driver is currently missing bifurcation
> > > support for RK3588. Thus after this series only PCIe3x4 is usable
> > > (in aggregated x4 mode) without adding support for the PHY's
> > > "rockchip,pcie30-phymode" DT property, which allows configuring
> > > how the lanes are distributed. Aggregated 3x4 mode seems to be the
> > > most common configuration. Both EVB1 and Rock 5B use it, so I
> > > cannot test anything else anyways.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
> >       commit: 0acf4fa7f187cd7e3dad93f1ee14e9509687621e
> 
> Applying this without the PCIe 2 series being applied introduces
> warnings for the RK3588 dtbs_check, as mentioned in the second
> setence of the text you quoted :)
> 
> (FWIW RK356x already has the same warnings, though)

darn, I didn't do a full binding check, only a "compiles" check
after applying. We're at rc3 now, so I would hope that the pcie2
binding changes get applied soon'ish so I can then also pick up the
dts change from there.


Heiko


