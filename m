Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCE3ECD22
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHPDSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:18:43 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45302 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhHPDSj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:18:39 -0400
Date:   Sun, 15 Aug 2021 17:40:09 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
Message-ID: <YRmJucYuL0T93huV@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io>
 <fb037103-66d5-477f-ba2e-03da74da97c0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb037103-66d5-477f-ba2e-03da74da97c0@www.fastmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > +/* The hardware exposes 3 ports. Port 0 (WiFi and Bluetooth) is 
> > special, as it
> > + * is power-gated by SMC to facilitate rfkill.
> > + */
> > +enum apple_pcie_port {
> > +	APPLE_PCIE_PORT_RADIO    = 0,
> > +	APPLE_PCIE_PORT_USB      = 1,
> > +	APPLE_PCIE_PORT_ETHERNET = 2,
> > +	APPLE_PCIE_NUM_PORTS
> > +};
> 
> This will also be used for the Thunderbolt ports, where this enum
> won't apply at all. I could also see Apple changing the individual port
> assignments in the future. I'd just remove it here and have this file be
> a generic PCIe driver for Apple SoCs.

Removed in v2.

> As above, I don't think it makes sense to special-case anything for the
> devices on the bus here. These controllers also have hot plug support,
> so the radios don't have to be on by the time it's initialized.
> We could also just turn them on in the bootloader for now.

This should be fixed in v2 with Mark's device tree bindings.
