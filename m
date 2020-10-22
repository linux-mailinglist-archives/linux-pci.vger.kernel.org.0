Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9A29666E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372238AbgJVVS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372233AbgJVVS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 17:18:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1050C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5cBekD3bplpW1a2zZ3pgYTutgTj4JBNLHTV3OzaHuJU=; b=17kwLpFuYiVPZJbGK3yWSFeXO
        PmVqOwdFblibk4EatVN2ugDKsrOLe46oQ+6xhT9THep6pw9lTHPzL/JGX+05ymI3aQ7PIZ+D0jtGx
        7Dxxy/8N4WG+Jyj7S2G0dAdc/qkjBx9QlHKX3+AjW/xW2Ot1qz1BwDDGUOOLRmbJK11TCx8+5vu8d
        2OuNenrgksUXr1Y0V/xZcFcnaLYXSBm4UjBDwfU4VHWt9MGr47fuk5uiOfytcMWQYUP0Dx7xCPgC8
        QqaERMEdM9pBLRRXLk5e0QVxpP3r6A8vdQU4YkKOiE9tlLiWXzeMKCZiFIZf7QpGKhIyBzgBkN8wp
        CUXYy96AQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49674)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVhyZ-0002aB-4Q; Thu, 22 Oct 2020 22:18:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVhyX-0007k4-TW; Thu, 22 Oct 2020 22:18:21 +0100
Date:   Thu, 22 Oct 2020 22:18:21 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [BUG] PCIe on Armada 388 broken since 5.9
Message-ID: <20201022211821.GU1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

It appears that PCIe on Armada 388 has been broken in 5.9. Here are
the boot messages:

mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
mvebu-pcie soc:pcie: resource collision: [mem 0xf1080000-0xf1081fff] conflicts with pcie [mem 0xf1080000-0xf1081fff]
mvebu-pcie: probe of soc:pcie failed with error -16

This results in PCIe being entirely non-functional. At a guess, I'd
say it's due to:

commit c322fa0b3fa948010a278794e60c45ec860e4a1e
Author: Rob Herring <robh@kernel.org>
Date:   Fri May 22 17:48:19 2020 -0600

    PCI: mvebu: Use struct pci_host_bridge.windows list directly

    There's no need to create a temporary resource list and then splice it to
    struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
    directly. The necessary clean-up is already handled by the PCI core.

    Link: https://lore.kernel.org/r/20200522234832.954484-3-robh@kernel.org
    Signed-off-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    Cc: Jason Cooper <jason@lakedaemon.net>

Any suggestions?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
