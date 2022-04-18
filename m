Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66792505C14
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiDRP7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiDRP64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 11:58:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A37B65;
        Mon, 18 Apr 2022 08:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2054B80FF2;
        Mon, 18 Apr 2022 15:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21CBC385A7;
        Mon, 18 Apr 2022 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650297195;
        bh=aYZg1IKIfMQLIL0wtoZyeEOyQnwvMvDnvwNzngzlnjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WK68PO31YI8JAiYMovjg5uNw+os/75YZuU34TXqHwolxI1p74aZtz/bzsBeJS2o6U
         XDCctIZIIFQVilDavTUVHZhHWR2Jt1fHHFWCVOe9rbFvIcc8ciz81dubr4LrAZFhcs
         SMmcS5Wy/5EdOC0yQxaulXswLkjR+E8aaLGtAMAdcyivBNRa82nQFc4vIJExw+623B
         h7vEevp/8sv3hSOxVo0tj8mZXwgaTvgZZXZGbBZAxOvnL36BJrqIfgQ2QdrSyw6wm+
         iGNO7pxMJ59IoujLcls/JavFPbWQgzTXlFp9O+q+v1H1DHwIPfHzX2vDJ6s8kJeCB8
         VWvXOc4T0am/Q==
Date:   Mon, 18 Apr 2022 10:53:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: Re: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
Message-ID: <20220418155313.GA1101563@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-a220fd81-2ee9-474d-bd65-505b9ed904b2-1650186482865@3c-app-gmx-bs58>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 17, 2022 at 11:08:02AM +0200, Frank Wunderlich wrote:
> > On Sat, Apr 16, 2022 at 03:54:56PM +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >
> > > PCIe Lanes can be split to 2 slots with bifurcation.
> > > Add support for this in existing pcie driver.

> > Is the "rockchip,bifurcation" DT property something that should be
> > generalized so it's not rockchip-specific?  Other controllers are
> > likely to support similar functionality.
> 
> I do not know if other controllers support similar functionality,
> but i ack a property without vendor prefix is better. Should i use
> "bifurcation" as name or do you think about a different name which
> is more generic?

Really a question for Rob about what name would be good and where it
should go.
