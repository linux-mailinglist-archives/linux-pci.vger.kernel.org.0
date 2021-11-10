Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207CC44BD6A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJI7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 03:59:01 -0500
Received: from elvis.franken.de ([193.175.24.41]:40482 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhKJI7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 03:59:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mkjOt-0001M7-01; Wed, 10 Nov 2021 09:56:11 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3DCDCC2C40; Wed, 10 Nov 2021 09:51:29 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:51:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: Re: [PATCH 0/2] Enable PCIE_BRCMSTB on MIPS
Message-ID: <20211110085129.GB5976@alpha.franken.de>
References: <20211108192432.1589507-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108192432.1589507-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 11:24:30AM -0800, Florian Fainelli wrote:
> This patch series allows building the PCIE_BRCMSTB driver for
> BMIPS_GENERIC. This is preliminary work to actually adding support for
> PCIe host bridge changes to the 7425/29/35 MIPS-based SoCs.
> 
> The two patches are largely independent, though it might make more sense
> to merge them via the PCI drivers tree?
> 
> Florian Fainelli (2):
>   MIPS: BMIPS: Enable PCI Kconfig
>   PCI: brcmstb: Allow building for BMIPS_GENERIC
> 
>  arch/mips/Kconfig              | 2 ++
>  drivers/pci/controller/Kconfig | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
