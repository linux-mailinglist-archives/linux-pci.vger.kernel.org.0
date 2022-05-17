Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D68529B17
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiEQHjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiEQHjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 03:39:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4AA49CAC;
        Tue, 17 May 2022 00:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77DFBB8173A;
        Tue, 17 May 2022 07:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAE2C385B8;
        Tue, 17 May 2022 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652773049;
        bh=g7kgBkyM4zj9yW1DzflJG2l9JzxOE2iIeZ0vQz0Vo84=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=guY8bfkDmz9XnbIUdyAiOoxdSGMIwVRZQW+TWRBSHGXVldeIPilXmUTjdxJLqgBdz
         y76cA62Q7P7J16m0bPZGE+XnbxuVaqhWBAuSCrrwf+gO5TUDMnp8aBlqEtTf6QPf6V
         DLBlOOYD/KdmiV8N890gnX0VS4opNuU43Wy9zxl1ipRPx2TtbHyUdWDWFy7qY+rMdA
         83XnM/y/aLToW/5EWoFT/St4p7RMlfXFGCsdAIRRTAyxXk4UgYZqOeJUC74g2lIoiX
         qGafMTHj1sRVpDN0BzjOt78zsXMPazIq41YQGhLcW1JaLw+0MqyMYz0t//uxhdgoDq
         Uo/YTg5vjDxRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220503205722.24755-4-Sergey.Semin@baikalelectronics.ru>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru> <20220503205722.24755-4-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 3/4] clk: baikal-t1: Move reset-controls code into a dedicated module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Tue, 17 May 2022 00:37:26 -0700
User-Agent: alot/0.10
Message-Id: <20220517073729.2FAE2C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Serge Semin (2022-05-03 13:57:21)
> Before adding the directly controlled resets support it's reasonable to
> move the existing resets control functionality into a dedicated object for
> the sake of the CCU dividers clock driver simplification. After the new
> functionality is added clk-ccu-div.c would have got to a mixture of the
> weakly dependent clocks and resets methods. Splitting the methods up into
> the two objects will make code easier to read especially seeing it isn't
> that hard to do.
>=20
> As before the CCU reset module will support the trigger-like CCU resets
> only, which are responsible for the AXI-bus, APB-bus and SATA-ref blocks
> reset. The assert/de-assert-capable reset controls support will be added
> in the next commit.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/clk/baikal-t1/Kconfig       |  12 +-
>  drivers/clk/baikal-t1/Makefile      |   1 +
>  drivers/clk/baikal-t1/ccu-rst.c     | 258 ++++++++++++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  60 +++++++
>  drivers/clk/baikal-t1/clk-ccu-div.c |  94 ++--------

Perhaps this should be done via the auxiliary bus by having the clk
driver register the reset driver and have some private API to pass any
data to the reset driver? Then the whole file could be in
drivers/reset/, reviewed and maintained by the reset maintainer.
