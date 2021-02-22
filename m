Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F0321CA3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhBVQTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 11:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhBVQT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 11:19:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E408964F00;
        Mon, 22 Feb 2021 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614010724;
        bh=AMBQRQMot8D/BNXnh2yZXXqGbG23WVNGGgUemEqj1ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PzEnRXZJCYtJBk0+tvgnwr9m08gczGxevhX0Dp4RYqog9cacvWMxWmtCrnMasn0Or
         k8RmmDPAV/WkxQxONWbNcnclRouRTgsxLIa/YnWB3TPbexm1M500JqJkElhhHKcCLm
         +Ahh960PYj0Aa7kUvDeEPcH6XUILpLov0f37nsEN1aG/K1WP6vpZ58Lb3hOK5xaqPZ
         gjgW76HymGyPnkq/wtuzvc7WVqWYDI9PaFzMCpeLEtetI/RfQ09CdmTqY6SFj6MjMG
         gLn4LuCbJAEpUB13c/OGC9mL+uoFjSkVbY3+F3Ivu2wrvadCKi2V9jAp2bis6wRYk7
         deQY8RYrnq1Cw==
Received: by mail-ot1-f52.google.com with SMTP id h22so4153678otr.6;
        Mon, 22 Feb 2021 08:18:43 -0800 (PST)
X-Gm-Message-State: AOAM533KcrhfofkiKlVn8ZDXBbsGuLZKlyZymV6zoL3lbZ7zRv9+82js
        4O8+of5gm72ZwgOIDDj3Lg1JDiqypqrZTTvaYy0=
X-Google-Smtp-Source: ABdhPJwj0korgguZIBoyGSxc3CZciTXY9kQRCwhL9qyrPlyb7sdZgXfWM7zQyvMgNMceUGzhwBP++9zbYfurHDEhcD0=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr2780937otc.108.1614010723079;
 Mon, 22 Feb 2021 08:18:43 -0800 (PST)
MIME-Version: 1.0
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
In-Reply-To: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Feb 2021 17:18:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG9ALnJcdzgv9805A91x-decqS1eq9oWi7Bb+pa3f6ErQ@mail.gmail.com>
Message-ID: <CAMj1kXG9ALnJcdzgv9805A91x-decqS1eq9oWi7Bb+pa3f6ErQ@mail.gmail.com>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Feb 2021 at 16:48, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi everyone,
> Raspberry Pi 4, a 64bit arm system on chip, contains a PCIe bus that can't
> handle 64bit accesses to its MMIO address space, in other words, writeq() has
> to be split into two distinct writel() operations. This isn't ideal, as it
> misrepresents PCI's promise of being able to treat device memory as regular
> memory, ultimately breaking a bunch of PCI device drivers[1].
>
> I'd like to have a go at fixing this in a way that can be distributed in a
> generic distro without prejudice to other users.
>
> AFAIK there is no way to detect this limitation through generic PCIe
> capabilities, so one solution would be to expose it through firmware
> (devicetree in this case), and pass the limitations through 'struct device' so
> as for the drivers to choose the right access method in a way that doesn't
> affect performance much[2]. All in all, most of this doesn't need to be
> PCI-centric as the property could be applied to any MMIO bus.
>
> Thoughts? Opinions? Is it overkill just for a single SoC?
>

Hi Nicolas,

How does this issue manifest itself? There are other PCIe RC
implementations suffering from the same issue, and some of the drivers
in Linux already work around this, by using split accesses. Look at
this one, for instance:

a310acd7a7ea ("NVMe: use split lo_hi_{read,write}q")

which switches NVMe to lo_hi_readq, which appears to be used in quite
a few other places as well.

-- 
Ard.
