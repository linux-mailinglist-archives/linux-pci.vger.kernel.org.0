Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69C31D11F5
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgEML4w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 May 2020 07:56:52 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46375 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEML4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 07:56:51 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8655FFF810;
        Wed, 13 May 2020 11:56:44 +0000 (UTC)
Date:   Wed, 13 May 2020 13:56:43 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200513135643.478ffbda@windsurf.home>
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, 30 Apr 2020 10:06:13 +0200
Pali Rohár <pali@kernel.org> wrote:

> Marek Behún (5):
>   PCI: aardvark: Improve link training
>   PCI: aardvark: Add PHY support
>   dt-bindings: PCI: aardvark: Describe new properties
>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
> 
> Pali Rohár (7):
>   PCI: aardvark: Train link immediately after enabling training
>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
>     read-only register
>   PCI: of: Zero max-link-speed value is invalid
>   PCI: aardvark: Issue PERST via GPIO
>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
>     macros
>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property

Thanks a lot for this work. For a number of reasons, I'm less involved
in Marvell platform support in Linux, but I reviewed your series and
followed the discussions around it, and I'm happy to give my:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

for the whole series. The changes all seem sensible, and have been
tested by several folks.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
