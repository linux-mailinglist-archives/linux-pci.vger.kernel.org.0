Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A6753A3B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjGNLy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjGNLyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:54:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE521995;
        Fri, 14 Jul 2023 04:54:51 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qKHNb-0003C7-KD; Fri, 14 Jul 2023 13:54:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
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
        kernel@collabora.com
Subject: Re: [PATCH v2 0/3] RK3588 PCIe2 support
Date:   Fri, 14 Jul 2023 13:54:34 +0200
Message-ID: <3628628.VLH7GnMWUR@phil>
In-Reply-To: <20230713204844.c4j4lebzj54uj7no@mercury.elektranox.org>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
 <9408492.EvYhyI6sBW@phil>
 <20230713204844.c4j4lebzj54uj7no@mercury.elektranox.org>
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

Am Donnerstag, 13. Juli 2023, 22:48:44 CEST schrieb Sebastian Reichel:
> On Thu, Jul 13, 2023 at 10:09:29PM +0200, Heiko Stuebner wrote:
> > Am Donnerstag, 13. Juli 2023, 19:18:48 CEST schrieb Sebastian Reichel:
> > > This adds PCIe v2 support for RK3588. The series has been tested with
> > > the onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1)
> > > and Radxa Rock 5B (&pcie2x1l2).
> > 
> > Didn't Rob write that he applied patches 1-3 of the v1 series? [0]
> > or did I miss further communication somehow?
> > [0] https://lore.kernel.org/r/20230626193238.GA3553158-robh@kernel.org
> 
> Rob wrote, that he de-applied the first patch:
> 
> https://lore.kernel.org/all/CAL_Jsq+=kBrujhLW_KNRWpj+DQJbnXrA=RS3La5ekbJtji+xiQ@mail.gmail.com/
> 
> It seems the second one was also dropped, since I rebased on top of
> 6.5-rc1, which only had patch 3/4.

thanks for the clarification :-) .

> FWIW the remaining dt-bindings fix issues that also exist for
> RK356x, so I guess there is no strict dependency. It might be
> acceptable to merge the DTS patch already, so that we finally
> get working network on Rock 5B. That would temporarily introduce
> DT warnings though (RK3588 is currently warning-free).

We're still early in the release cycle, so I guess we should
just give Rob(?) time to pick up the binding patches if they
look ok to him. And not introduce new warnings ;-)


Heiko


