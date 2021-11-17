Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609B454681
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhKQMo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 07:44:28 -0500
Received: from elvis.franken.de ([193.175.24.41]:54983 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhKQMo1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 07:44:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mnKFj-0000oO-00; Wed, 17 Nov 2021 13:41:27 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AF7F9C2DFA; Wed, 17 Nov 2021 13:41:20 +0100 (CET)
Date:   Wed, 17 Nov 2021 13:41:20 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: mt7621: remove specific MIPS code from driver
Message-ID: <20211117124120.GA9336@alpha.franken.de>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 08:08:04AM +0100, Sergio Paracuellos wrote:
> Hi all,
> 
> MIPS specific code can be removed from driver and put into ralink mt7621
> instead which is a more accurate place to do this. To make this possible
> we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
> which has been implemented for ralink mt7621 platform (there is no real 
> need to implement this for any other platforms since those ones haven't got
> I/O coherency units). This also allow us to properly enable this driver to
> completely be enabled for COMPILE_TEST. This patchset appoarch:
> - Move windows list splice in 'pci_register_host_bridge()' after function 
>   'pcibios_root_bridge_prepare()' is called.
> - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> - Avoid custom MIPs code in pcie-mt7621 driver.
> - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test 
>   module compilation to complain (already sent patch from Yanteng Si that
>   I have rewrite commit message and long description a bit.
> - Remove MIPS conditional code from Kconfig.
> 
> This patchset also fix some errors reported by Kernel Test Robot about
> implicit mips functions used in driver code and fix errors in driver when
> is compiled as a module [1] (mips:allmodconfig).
> 
> There was an ongoing discussion about this here [0] but I preferred to send
> my proposal for better review and understanding:

so what's the plan with this patchset ? Going in as fix, probably via
pci tree ? Or is material for next release ? If the latter can we first
fix the allmodconfig by making the Kconfig symbol bool ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
