Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0646573F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352978AbhLAUmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbhLAUlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:41:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A924FC061574;
        Wed,  1 Dec 2021 12:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C4F7CE20EC;
        Wed,  1 Dec 2021 20:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7B2C53FCC;
        Wed,  1 Dec 2021 20:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391103;
        bh=gu9nDUmfDpbMdGEv2OTv73D0U4RfRGX9YyAm0A5H0aY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UJougrOWE7+QtJggnqQtzQijIg4xu/qoKkGCMiuSeAiwXKUqijFzNfOt9mgXd2Zxu
         9qXboha1IOER6nFyx+dZZZQduu5UKi+GAJIVnVNoL+S5b1ynzKcrXjpTtewG4WN+gj
         O8TQIEGzkcTE5A+hipOH1LkMEXBiAJ56DpbKnoWRM/4yEht84vcJNXSBazafpVLPvO
         cbdZFn+9HwSMp56m1dbH2Th18Fmc6QoXBGEaaObYJ0egOVjmXohuA7q98PVfqnRRNP
         I/Sn8AyX5gd3bxO/o7yUskVJ/T3vdIUC6rYdx3wzZ1KMMFhMgzCPkm7Xp/TCTD448t
         0iueON+Z+wu2Q==
Date:   Wed, 1 Dec 2021 14:38:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Linux 5.16-rc3
Message-ID: <20211201203822.GA2840039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H-nm1-B8tZejcZPN3jxF_HGr2tWMWmYJUJnz0jau=QcfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Mon, Nov 29, 2021 at 01:18:12PM +0100, Sergio Paracuellos wrote:
> On Mon, Nov 29, 2021 at 5:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 11/28/21 7:07 PM, Randy Dunlap wrote:
> > > On 11/28/21 17:59, Guenter Roeck wrote:
> > >> ...
> > >> Build results:
> > >>     total: 153 pass: 152 fail: 1
> > >> Failed builds:
> > >>     mips:allmodconfig
> > >> Qemu test results:
> > >>     total: 482 pass: 482 fail: 0
> > >>
> > >> Building mips:allmodconfig ... failed
> > >> --------------
> > >> Error log:
> > >> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> > >> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > >>
> > >> There is still no fix for the mips:allmodconfig build problem as far
> > >> as I can see. It is a bit odd, because the fix would be as simple as
> > >>
> > >>   config PCIE_MT7621
> > >> -    tristate "MediaTek MT7621 PCIe Controller"
> > >> -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > >> +    bool "MediaTek MT7621 PCIe Controller"
> > >> +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> > >>       select PHY_MT7621_PCI
> > >>       default SOC_MT7621
> > >>       help
> > >>
> > >> Context: tristate doesn't make sense here because both RALINK and
> > >> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> > >> already depends on it. The compile failure is due to missing exported
> > >> symbols, and it is only seen if PCIE_MT7621=m - which is only possible
> > >> if COMPILE_TEST=y. In other words, the dependencies above are set such
> > >> that test builds, and only test builds, fail.
> > >>
> > >> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> > >> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> > >> those responsible to see if we can expect a solution sometime soon.

Can we do a minimal patch along the lines of the above for v5.16?

We can do the more extensive work as in 
https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
but that would be material for v5.17.

Bjorn
