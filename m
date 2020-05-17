Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7C1D68B6
	for <lists+linux-pci@lfdr.de>; Sun, 17 May 2020 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEQP5K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 17 May 2020 11:57:10 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54937 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQP5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 May 2020 11:57:10 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 39B1F200005;
        Sun, 17 May 2020 15:57:03 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and Compex wifi cards
In-Reply-To: <20200513135643.478ffbda@windsurf.home>
References: <20200430080625.26070-1-pali@kernel.org> <20200513135643.478ffbda@windsurf.home>
Date:   Sun, 17 May 2020 17:57:02 +0200
Message-ID: <87pnb2h7w1.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> Hello,
>
> On Thu, 30 Apr 2020 10:06:13 +0200
> Pali Rohár <pali@kernel.org> wrote:
>
>> Marek Behún (5):
>>   PCI: aardvark: Improve link training
>>   PCI: aardvark: Add PHY support
>>   dt-bindings: PCI: aardvark: Describe new properties
>>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
>>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
>> 
>> Pali Rohár (7):
>>   PCI: aardvark: Train link immediately after enabling training
>>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
>>     read-only register
>>   PCI: of: Zero max-link-speed value is invalid
>>   PCI: aardvark: Issue PERST via GPIO
>>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
>>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
>>     macros
>>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property
>
> Thanks a lot for this work. For a number of reasons, I'm less involved
> in Marvell platform support in Linux, but I reviewed your series and
> followed the discussions around it, and I'm happy to give my:
>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

With this acked-by for the series, the reviewed-by from Rob on the
binding and the tested-by, I am pretty confident so I applied the
patches 10, 11 and 12 on mvebu/dt64.

Thanks,

Gregory


>
> for the whole series. The changes all seem sensible, and have been
> tested by several folks.
>
> Thanks!
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
