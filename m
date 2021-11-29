Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25AC461A9C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhK2PH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 10:07:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48874 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhK2PF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 10:05:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84DDCB811AB;
        Mon, 29 Nov 2021 15:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE70C53FCB;
        Mon, 29 Nov 2021 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638198156;
        bh=zhRf03lDFc9TSrvVKgxJdUmxw/W+2kxW3IhlVzP8WK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrP+buWbPWtF7SIfkt80LqsCiQOcbSx/+rZHn6c4Dspm5vczOsQffO7tktoFA+/e4
         V/lvbo/U7yHc1xD1VZAJrzrd40SXgSbbY2q3zShEmHglRmHORAejV3/ADJs8osRCBP
         HQw38nmRruf27pIMb5N2MblCdBYi+Oon+EZQppz/QaGBBY5FvaqxsXny+Sy8FjtzjU
         B0ooXczbtNPD8cpiwUOZBzV/0xY36r80Z3La8O864JRIdgwgnFYS/87zbqV2mpvKZE
         onYLtjAxG/sFsokzPQPa4b/rlayOCc++fjxiqKrR6coDxQVb3RC32tb71Eqky6aq2P
         FVziHLhIXRQvg==
Received: by mail-ed1-f50.google.com with SMTP id o20so72818608eds.10;
        Mon, 29 Nov 2021 07:02:36 -0800 (PST)
X-Gm-Message-State: AOAM530ZJh2xNKQwX0s74HbeKEN3a6zPKwCOYED42aNM8O5tQhc5zOlR
        QAivWPm6E5KSKiq5vYWTofp/xmON7ep84Ki94A==
X-Google-Smtp-Source: ABdhPJzSzu6jfOFyArdfwBJO/Ho+R7KjhXG542jIpqcF/QVwAF4bMwMwkXZCl1axXS+wi0VWzmgdCAJlI7DCGEbzQLc=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr74349852edu.327.1638198150830;
 Mon, 29 Nov 2021 07:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20211122111332.72264-1-marcan@marcan.st> <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
 <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st>
In-Reply-To: <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Nov 2021 09:02:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
Message-ID: <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
To:     Hector Martin <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 1:40 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 24/11/2021 11.23, Rob Herring wrote:
> >> +#include "../pci.h"
> >> +/* Apple PCIe is based on DesignWare IP and shares some registers */
> >> +#include "dwc/pcie-designware.h"
> >
> > I'm starting to regret this not being part of the DWC driver...
>
> Main issue is the DWC driver seems to have a pretty hard-coded
> assumption of one port per controller, plus does a bunch of stuff
> differently for the higher layers. It seems Apple used the DWC PHY/LTSSM
> bits, then rolled their own upper layer.

Yeah, it would need some work...

> >> +/* The offset of the PCIe capabilities structure in bridge config space */
> >> +#define PCIE_CAP_BASE          0x70
> >
> > This offset is discoverable, so don't hardcode it.
>
> Sure, it just means I have to reinvent the PCI capability lookup wheel
> again. I'd love to use the regular accessors, but the infrastructure
> isn't up to the point where we can do that yet yere. DWC also reinvents
> this wheel, but we can't reuse that code because it pokes these
> registers through a separate reg range, not config space (even though it
> seems like they should be the same thing? I'm not sure what's going on
> in the DWC devices... for the Apple controller it's just the ECAM).

Since it is just ECAM, can you use the regular config space accessors?

> >> +       max_gen = of_pci_get_max_link_speed(port->np);
> >> +       if (max_gen < 0) {
> >> +               dev_err(port->pcie->dev, "max link speed not specified\n");
> >
> > Better to fail than limp along in gen1? Though you don't check the
> > return value...
> >
> > Usually, the DT property is there to limit the speed when there's a
> > board limitation.
>
> The default *setting* is actually Gen4, but without
> PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make
> more sense to only set the LNKCTL field if max-link-speed is specified,
> and unconditionally poke that bit. That'll get us Gen4 by default (or
> even presumably Gen5 in future controllers, if everything else stays
> compatible).

You already do some setup in firmware for ECAM, right? I think it
would be better if you can do any default setup there and then
max-link-speed is only an override for the kernel.

Rob
