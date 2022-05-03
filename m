Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B95191EE
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiECW6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiECW6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 18:58:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAC443D0;
        Tue,  3 May 2022 15:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83725B821F1;
        Tue,  3 May 2022 22:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4D7C385A9;
        Tue,  3 May 2022 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651618436;
        bh=MjVuCNNcWZXYf57iNg2O+Xmc5CIZbqZZo07gCpHDjes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gWRC7yU7yRQRDEtiNwaZ28IaQGxNmAxNwQoEaWdR1Q/imm6XlU15T3pHmqaeKz4s6
         maM6tRjOaX4Qu48zV7nO2lHJEuA9xOuTwnje4MDNIIC6Ioh3EhelWkfhddNKwUi59B
         VWaIZaRk+d0Gt0nPB2b0/1ff0Fe5eUe+Jc20C+8Ki8h9+1F1hYSithwXIyNCZt5NHL
         JtmU6zqC2wEaZQzCGbYCLULw2DqdPVVu+mQpXLJh4mwEA/7fC3Fju9uf6yxEH62m8S
         Gpgg75q9S/nuy0a+1I+xyMkyQ1ee/YS9OxU+r4OfKyazjbj5J0+CMqxXQ4ujNP80AT
         dBbfO1vq3tEfQ==
Date:   Tue, 3 May 2022 17:53:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Message-ID: <20220503225353.GA415393@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427094502.456111-3-clement.leger@bootlin.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  PCI: of: Create DT nodes ... if they do not exist

The subject could be read as saying that you're going to create DT
nodes before the PCI devices exist, but I think you mean that when we
enumerate a PCI devices, we're *always* going to create a DT node for
it, even if the DT didn't mention it.

Maybe something like:

  PCI: of: Create DT node for every PCI device

although I see Rob thinks this should be done on demand instead of
doing it for every device, which sounds sensible to me.

On Wed, Apr 27, 2022 at 11:45:01AM +0200, Clément Léger wrote:
> In order to apply overlays to PCI device nodes, the nodes must first
> exist. This commit add support to populate a skeleton tree for PCI bus
> and devices. These nodes can then be used by drivers to apply overlays.

s/This commit add support/Add support/

Bjorn
