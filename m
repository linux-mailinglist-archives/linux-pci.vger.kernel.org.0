Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B853F1B2545
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDULmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDULmS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 07:42:18 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5812064C;
        Tue, 21 Apr 2020 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587469337;
        bh=3JALSrro+0m6mUY6BLwHQ8lDw/IYPWN6XeRum+fkUWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8/Hi9qy5eSh4u3jE7B3wv+zHI+D12t2nUWvntgKClh8c7GU1ug8A7I+G+DZZIXou
         leCNQ9BBSOmLOcPC+4qnmv4llIqsx9w7fq5CtQ1aIgmnNCALym4wOA2tC42zLANY0x
         FSOa+NgJBWY4CGxH/vcICJs/OGoC9QnLbjcrYyyU=
Received: by pali.im (Postfix)
        id 185E9A4B; Tue, 21 Apr 2020 13:42:15 +0200 (CEST)
Date:   Tue, 21 Apr 2020 13:42:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Subject: Re: [PATCH v2 0/9] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200421114214.pr2mesaum4yb7qbi@pali>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 21 April 2020 13:16:52 Marek Behún wrote:
> Hello,
> 
> this is the second version of the patch series for Armada 3720 PCIe
> controller (aardvark). It's main purpose is to fix some bugs regarding
> buggy ath10k cards, but we also found out some suspicious stuff about
> the driver and the SOC itself, which we try to address.
> 
> Changes since v1:
> - commit titles and messages were reviewed and some of them were rewritten
> - patches 1 and 5 from v1 which touch PCIe speed configuration were
>   reworked into one patch
> - patch 2 from v1 was removed, it is not needed anymore
> - patch 7 from v1 now touches the device tree of armada-3720-db
> - a patch was added that tries to enable PCIe PHY via generic-phy API
>   (if a phandle to the PHY is found in the device tree)
> - a patch describing the new PCIe node DT properties was added
> - a patch was added that moves the PHY phandle from board device trees
>   to armada-37xx.dtsi
> 
> Marek and Pali
> 
> Marek Behún (5):
>   PCI: aardvark: improve link training
>   PCI: aardvark: add PHY support
>   dt-bindings: PCI: aardvark: describe new properties
>   arm64: dts: marvell: armada-37xx: set pcie_reset_pin to gpio function
>   arm64: dts: marvell: armada-37xx: move PCIe comphy handle property
> 
> Pali Rohár (4):
>   PCI: aardvark: train link immediately after enabling training
>   PCI: aardvark: don't write to read-only register
>   PCI: aardvark: issue PERST via GPIO
>   PCI: aardvark: add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
> 
>  .../devicetree/bindings/pci/aardvark-pci.txt  |   4 +
>  .../arm64/boot/dts/marvell/armada-3720-db.dts |   3 +
>  .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +-
>  .../dts/marvell/armada-3720-turris-mox.dts    |   5 -
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   3 +-
>  drivers/pci/controller/pci-aardvark.c         | 219 +++++++++++++++---
>  6 files changed, 203 insertions(+), 33 deletions(-)
> 
> -- 
> 2.24.1
> 

Hello!

I tested whole patch series on Turris MOX with following wifi cards and
all of them are working fine from cold boot and also after board reboot.

WLE1216V5-20 (gen2, ath10k), WLE900VX (gen1, ath10k), WLE200N2 (gen1,
ath9k), WLE200NX (gen1, ath9k)

Tested-by: Pali Rohár <pali@kernel.org>
