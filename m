Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82AF454697
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhKQMvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhKQMvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 07:51:31 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4213C061570;
        Wed, 17 Nov 2021 04:48:32 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p2so5544638uad.11;
        Wed, 17 Nov 2021 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9ZeoZcuM1SFs0ycmV8j+Ly+rX5e3huJuu4Pm4Ap/7E=;
        b=cDMCcPD0iSAiG8zkz1Qjy09UlUjlXYc07J57n5MLgD2rZ5o0ZBIb4gROWlQXntoP6X
         fDmfYtFGq+QaIc7LbDhzaQHq9efIiUkbWxblT2lbgaPsQqjib/dGeJnUdwnJSL/7T7Rl
         a53w8M+FB/gp5MVZGukOwXgqQYrEOIT9WWAcIruCUTdhsBBQyugGn03MC5mLnuLRMmAK
         EGnbVYd+V3aQd5Ugr/NQiUHuS41jPKYjt4PjjFzVDK0Jya7pZlya8xi4SqNXXFx78XCF
         cAYSXGCHFZNltcw6WpvxSaN/TxaW0bd70TsGN4ye7JkAWTiZIT7Ol6+L4Lym2a0CuMZW
         beyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9ZeoZcuM1SFs0ycmV8j+Ly+rX5e3huJuu4Pm4Ap/7E=;
        b=eV2sMFWzUnQowva1gzAZaMYge2UUgXWdQ8tV8lX1b+7bjAjl63386ut/2j9IueeXho
         YBqlOlTJ/wP9ZP8hJ7X3ZYwf9nLTeQAph29VyT24WUntecs3R8BfDA5LCl5bbAQflswb
         stZWuvSoaNmhOeLRCuB80dIpUkmwytpghLPUrVfAMzb1c8AkMajIYNE5lSqXi/BRjpN3
         KJbPawaE32tO1WcXO9nrCfJ+yN41BGVdJioY8Os8HVka2pUnXW0p0b8srtQOfijdsDUr
         3ev8oNGjKR2Xct9GaiKyX/ONMBoHoBcHNCpesHF0ar8L+TRuUhJZ7ZT5pcD5RCc3eO0h
         7FWg==
X-Gm-Message-State: AOAM531qySxRPUJKxrCV0pUeH6x4o1wkYIV8cola5hITd8jehWJh3ND0
        h/k+6a46lAabAY6ursKRzfvU5M8LwXRA2N9K3qQ=
X-Google-Smtp-Source: ABdhPJxXCcMsvAYMIJ6kUEI1Et7ijT/DNk5p7WaE2MPC0BwC177Ktar5VCPS7gdhcTdjefP7Tyebx6idpP5iAZ/YyO8=
X-Received: by 2002:a05:6102:3a11:: with SMTP id b17mr68559905vsu.28.1637153312056;
 Wed, 17 Nov 2021 04:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com> <20211117124120.GA9336@alpha.franken.de>
In-Reply-To: <20211117124120.GA9336@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 17 Nov 2021 13:48:20 +0100
Message-ID: <CAMhs-H_V03ZE8AkdccrmUb+48HDhbDM5i-9G-hhnuHwRq20H3A@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: mt7621: remove specific MIPS code from driver
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 1:41 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Nov 15, 2021 at 08:08:04AM +0100, Sergio Paracuellos wrote:
> > Hi all,
> >
> > MIPS specific code can be removed from driver and put into ralink mt7621
> > instead which is a more accurate place to do this. To make this possible
> > we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
> > which has been implemented for ralink mt7621 platform (there is no real
> > need to implement this for any other platforms since those ones haven't got
> > I/O coherency units). This also allow us to properly enable this driver to
> > completely be enabled for COMPILE_TEST. This patchset appoarch:
> > - Move windows list splice in 'pci_register_host_bridge()' after function
> >   'pcibios_root_bridge_prepare()' is called.
> > - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> > - Avoid custom MIPs code in pcie-mt7621 driver.
> > - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test
> >   module compilation to complain (already sent patch from Yanteng Si that
> >   I have rewrite commit message and long description a bit.
> > - Remove MIPS conditional code from Kconfig.
> >
> > This patchset also fix some errors reported by Kernel Test Robot about
> > implicit mips functions used in driver code and fix errors in driver when
> > is compiled as a module [1] (mips:allmodconfig).
> >
> > There was an ongoing discussion about this here [0] but I preferred to send
> > my proposal for better review and understanding:
>
> so what's the plan with this patchset ? Going in as fix, probably via
> pci tree ? Or is material for next release ? If the latter can we first
> fix the allmodconfig by making the Kconfig symbol bool ?

If the approach is considered valid I guess it should go as a fix to
avoid changing first to 'bool' the Kconfig symbol. If it is not a
valid approach I will send patches with a possible new requested
approach or just making the symbol bool and adding specific mips
includes to driver code to avoid mips implicit functions errors.

Best regards,
    Sergio Paracuellos
>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
