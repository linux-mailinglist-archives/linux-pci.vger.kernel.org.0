Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8048CE09
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 22:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiALVwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 16:52:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiALVwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 16:52:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79689B82141;
        Wed, 12 Jan 2022 21:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F26C36AE9;
        Wed, 12 Jan 2022 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642024325;
        bh=25pZEExodfv3mwmVyIsoxE1mWVWu3L7Z4IG5ySwQWnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u4gEBaV0S/plq3Oy8QX25eIKBJf1e5tzJo8HIFUjAraUXb7etQw+3OjZvvvLJ4/vS
         rk46ygCPXoSsTt64irgpsTIByk9kQmae6l9Y96J0SUzM0PZTCDzAg6RC7TjHXIWs1C
         hrIZTXBlPNw9xUqYONeWSbDqx+zh2DURFgY5ZbEYhL1ws3MrDZ0M9vo5jhBZRtcugA
         mWmaqCUq+yUm6q2g3dqTjKvvrUs6whtxZknyq4gwvCJRYBEqbgaYySzuF60MsgQ7Im
         eBTbsP1neB6OiPZSI2YX/RSfNsiVB0dhIcPWbzP/sxSPfc8Jo8YQipPN/p+J0VOviU
         oQHPO8fommAwQ==
Date:   Wed, 12 Jan 2022 15:52:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
Message-ID: <20220112215203.GA286653@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 11:49:19AM +0100, Sergio Paracuellos wrote:
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
> - Remove MIPS conditional code from Kconfig and mark driver as 'tristate'.
> 
> This patchset is a real fix for some errors reported by Kernel Test Robot about
> implicit mips functions used in driver code and fix errors in driver when
> is compiled as a module [1] (mips:allmodconfig).
> 
> Changes in v3:
>  - Rebase the series on the top of the temporal fix sent for v5.16[3] for
>    the module compilation problem.
>  - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
>     - Address TODO in comment about the hardware does not allow zeros
>       after 1s for the mask and WARN_ON if that's happend.
>     - Be sure mask is real valid upper 16 bits.
> 
> Changes in v2:
>  - Collect Acked-by from Arnd Bergmann for PATCH 1.
>  - Collect Reviewed-by from Krzysztof Wilczyński for PATCH 4.
>  - Adjust some patches commit subject and message as pointed out by Bjorn in review of v1 of the series[2]. 
> 
> This patchset is the good way of properly compile driver as a module removing
> all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmodconfig reported
> problems for v5.16 the following patch has been sent[3]. This series are rebased onto this patch to provide
> a real fix for this problem.
> 
> [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
> [1]: https://lkml.org/lkml/2021/11/14/436
> [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
> [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.paracuellos@gmail.com/T/#u
> 
> Thanks in advance for your time.
> 
> Best regards,
>    Sergio Paracuellos
> 
> Sergio Paracuellos (5):
>   PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
>   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
>   PCI: mt7621: Avoid custom MIPS code in driver code
>   PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
>   PCI: mt7621: Allow COMPILE_TEST for all arches
> 
>  arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
>  drivers/pci/controller/Kconfig       |  4 +--
>  drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
>  drivers/pci/probe.c                  |  4 +--
>  4 files changed, 37 insertions(+), 41 deletions(-)

I tentatively put this on my pci/host/mt7621 branch.  The only
non-mt7621 change is the pci_register_host_bridge() change, which
seems innocuous, so maybe we can still squeeze it in.

I squashed these patches together:

  MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
  PCI: mt7621: Avoid custom MIPS code in driver code

because the first adds the coherency setup to the MIPS
pcibios_root_bridge_prepare(), and the second removes that same code
from pcie-mt7621.c.  I think it makes more sense to do it as a move in
a single patch, both for ease of reviewing and for potential
bisection.
