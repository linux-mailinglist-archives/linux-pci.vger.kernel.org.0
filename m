Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9381AF680
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 06:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDSEBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 00:01:08 -0400
Received: from mail.nic.cz ([217.31.204.67]:45604 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDSEBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Apr 2020 00:01:07 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9AFCB140C9C;
        Sun, 19 Apr 2020 06:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587268865; bh=UrRGZIJijw+vawifGSHtqyzyN2YE4XkTCoN71IMaOm4=;
        h=Date:From:To;
        b=UOmx00znzgZ69fqztOtqoJvuOPXYdgeCVrEBCNuqFWfu+Ur70H51XaCPeJQwNyIwH
         RD7thUVmx4Z2iIstMKFG14ZG5+L/1HQe0xw3OqygsE486fkb+jS2uaoMg7KJsqUoVn
         RrUxEiySBKRSfPzIUrjocSv/Jlx7ZaHkNQCr+KXE=
Date:   Sun, 19 Apr 2020 06:01:05 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200419060105.4c7bc4a5@nic.cz>
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali, I tested this series with Compex WLE900VX and with a ASMedia SATA
card.

Both are visible with these patches.

But if I enable the pci-driver in U-Boot, kernel reports "link
never came up" fo the WLE900VX card. The SATA card works in this case.

advk-pcie d0070000.pcie: issuing PERST via reset GPIO for 1ms
advk-pcie d0070000.pcie: setup link speed to 2
advk-pcie d0070000.pcie: link never came up
advk-pcie d0070000.pcie: setup link speed to 1
advk-pcie d0070000.pcie: link never came up

We should try to somehow reset the whole PCIe controller in Linux. There
are the PCIe Core Warm Reset and PCIe PHY Warm Reset register. I also think
that maybe we should try to reset the whole PCI comphy.

Marek
