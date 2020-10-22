Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47A2966EA
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372633AbgJVWEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 18:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372632AbgJVWEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 18:04:37 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1987324641
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603404276;
        bh=lIrQCEY8cu3fDoK3RHvh8AGYiNeilyBVkU1y7IzqFbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HYiVzz/QpaxIniOcYElJ4kPE2IBimN4dJKBhRhCQTuIMj4lU4vXAlecsrzS41aqEq
         rNnIsyjahfhhdr1EHMOr90T+lMw7yyKwe5zCKq1XUXMe1+zE0GgLyBd0fCrfTjueC3
         bYc0yWxH57NBmun7CatLYrFwZpQ/s4Y9XtcUMpUc=
Received: by mail-ot1-f42.google.com with SMTP id m22so3057001ots.4
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 15:04:36 -0700 (PDT)
X-Gm-Message-State: AOAM531N3GJu0P9HOgmWeNkODTEwqOnB7OriOzZz+x8Fa3Q1eCakZc6X
        Sf87ra+U5w8Cd/AEM9Lxlyyk/jhEYcxQukRfQg==
X-Google-Smtp-Source: ABdhPJya0Cjk2qh37zUzdI5TfcvVcp77T4JF5AYwOj+1HyScA+NIbZ94qCqioqg5EkuT/RDl2wzyWV7D7xRtBpoARlA=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3093237oti.107.1603404275279;
 Thu, 22 Oct 2020 15:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201022211821.GU1551@shell.armlinux.org.uk> <20201022213246.GV1551@shell.armlinux.org.uk>
In-Reply-To: <20201022213246.GV1551@shell.armlinux.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Oct 2020 17:04:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+VyGmsk8cm+pd9tBd1dX6SdhYkKMOYQ8Qu_u-ZNDT4JA@mail.gmail.com>
Message-ID: <CAL_Jsq+VyGmsk8cm+pd9tBd1dX6SdhYkKMOYQ8Qu_u-ZNDT4JA@mail.gmail.com>
Subject: Re: [BUG] PCIe on Armada 388 broken since 5.9
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 4:32 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 10:18:21PM +0100, Russell King - ARM Linux admin wrote:
> > Hi,
> >
> > It appears that PCIe on Armada 388 has been broken in 5.9. Here are
> > the boot messages:
> >
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: resource collision: [mem 0xf1080000-0xf1081fff] conflicts with pcie [mem 0xf1080000-0xf1081fff]
> > mvebu-pcie: probe of soc:pcie failed with error -16
> >
> > This results in PCIe being entirely non-functional. At a guess, I'd
> > say it's due to:
> >
> > commit c322fa0b3fa948010a278794e60c45ec860e4a1e
> > Author: Rob Herring <robh@kernel.org>
> > Date:   Fri May 22 17:48:19 2020 -0600
> >
> >     PCI: mvebu: Use struct pci_host_bridge.windows list directly
> >
> >     There's no need to create a temporary resource list and then splice it to
> >     struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
> >     directly. The necessary clean-up is already handled by the PCI core.
> >
> >     Link: https://lore.kernel.org/r/20200522234832.954484-3-robh@kernel.org
> >     Signed-off-by: Rob Herring <robh@kernel.org>
> >     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >     Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> >     Cc: Jason Cooper <jason@lakedaemon.net>
>
> Confirmed. Reverting this commit results in functioning PCIe.

Yes, but really it's broken by 2 commits. The other is 669cbc708122
("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()").

I just sent out a fix, please test.

Rob
