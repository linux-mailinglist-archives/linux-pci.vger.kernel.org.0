Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6962EC3D2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 20:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAFTUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 14:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbhAFTUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 14:20:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B221C2311B;
        Wed,  6 Jan 2021 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960791;
        bh=U+g+SuPIZ3hN3vmlC/G3kLSsF0KrlCHBBpEFAdw5Ufc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DONdN+za2JdOMS2tkNX8Udx10Mgoz1zTTX4/LKKwowRFEzME2OtA9A7gmmeMPWWqo
         ViCopXvbUuS9KNaQHGfPb2KNJUv2pQY+2eSXaKusAxA1jHrDa7Aw3OVlSSdCjf2F7b
         LUiof3UhPYIzqo04pYAHvwWWdU1jbFg50riZk1G1XuGS38/rFuqksebfc6jnNU84vT
         0QIqwREaJTIxPCw/n2g7XnsER++6GD/SsPJtmOIpPcnX5eGZ0CybB0GsIYWsLc9/Zn
         Jw5P9CuYgde/UB1DwI5gwNDrz8BP+06XjI+7xckZG4jU1Ri2ar71uDh3FYw7LGlzt9
         h2rtn0rv1WNfg==
Date:   Wed, 6 Jan 2021 13:19:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
Message-ID: <20210106191949.GA1328757@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130211145.3012-6-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 04:11:42PM -0500, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  This simple
> handler determines if the PCIe controller was the cause of the abort and if
> so, prints out diagnostic info.
> 
> Example output:
>   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

What does this mean for all the other PCI core code that expects
0xffffffff data returns?  Does it work?  Does it break differently on
STB than on other platforms?

> +/*
> + * Dump out pcie errors on die or panic.

s/pcie/PCIe/
This could be a single-line comment.

> + */
