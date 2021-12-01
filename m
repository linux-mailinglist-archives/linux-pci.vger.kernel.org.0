Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05E4653B0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbhLARPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351666AbhLARPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 12:15:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B31C061574;
        Wed,  1 Dec 2021 09:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 801B8CE1FEC;
        Wed,  1 Dec 2021 17:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6923FC53FCC;
        Wed,  1 Dec 2021 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638378685;
        bh=r5GVbCBgif2BuWfiq6JB1Kofyuo38uEZhcFhxjQvCzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eLufa8MJOC9NEMeHrIORBnmDklja3BeeqFdl2OUEoL/sxgM75lQT5CpY+XW4RPyy/
         4eSQe8VSw+9tMf1k9dCkH3PQUp/g/w5SiuPloDGnR6WmbSd6SdtA2lX2d0m8RJeiJ6
         UBEZy3YVxwbfOktxbe2PN2G88/Rcm3WtgWCuSotdeDZFz462X4Xkq0zJUZnLBNCLKu
         OZJ9LhS5hEljjKwIMwHsCHMitVRUcpe5pzzboXIhpmbuN7P0Ci5wJXjuxKPXqbhBgA
         fDMK9PS8T0ziE/JgQTkTmG23Y8Jj6mfZ68CrRXNuumDpA1yWQmAUGH3LTD4N8HGsKT
         NR+7qoYsIcTtA==
Date:   Wed, 1 Dec 2021 11:11:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] arm: ioremap: Remove pci_ioremap_io() and
 mvebu_pci_host_probe()
Message-ID: <20211201171124.GA2824425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163827065859.21977.786435593890374586.b4-ty@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 11:11:43AM +0000, Lorenzo Pieralisi wrote:
> On Wed, 24 Nov 2021 16:41:11 +0100, Pali Rohár wrote:
> > This patch series removes ARM specific functions pci_ioremap_io() and
> > mvebu_pci_host_probe() functions.
> > 
> > pci_ioremap_io() is replaced by standard PCI core function pci_remap_iospace()
> > and mvebu_pci_host_probe() by standard PCI core function pci_host_probe().
> > 
> > ARM needs custom implementation of pci_remap_iospace() because of
> > pci_ioremap_set_mem_type() hook used by Marvell Armada 375, 38x and 39x
> > platforms due to HW errata.
> > 
> > [...]
> 
> Applied to pci/mvebu, thanks!
> 
> [1/5] arm: ioremap: Implement standard PCI function pci_remap_iospace()
>       https://git.kernel.org/lpieralisi/pci/c/bc02973a06
> [2/5] PCI: mvebu: Replace pci_ioremap_io() usage by devm_pci_remap_iospace()
>       https://git.kernel.org/lpieralisi/pci/c/c1aa4b55aa
> [3/5] PCI: mvebu: Remove custom mvebu_pci_host_probe() function
>       https://git.kernel.org/lpieralisi/pci/c/de58d49470
> [4/5] arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
>       https://git.kernel.org/lpieralisi/pci/c/9c8facde92
> [5/5] arm: ioremap: Remove unused ARM-specific function pci_ioremap_io()
>       https://git.kernel.org/lpieralisi/pci/c/ea76d27fb3

Beautiful.  I love getting rid of mvebu_pci_host_probe(), thank you!

If there's any occasion to update this branch, typos in the commit
logs:

[3/5]: s/functionn/function/
[4/5]: s/arm march code/ARM mach code/
