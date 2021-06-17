Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873513AAB8C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 08:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQGCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 02:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQGCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 02:02:51 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89161C061574;
        Wed, 16 Jun 2021 23:00:38 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id o3so1676623uaw.5;
        Wed, 16 Jun 2021 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nI7yEuG2ARK23uejO9nhB9zAo4xzWVauJN211Odr0ag=;
        b=S3EyK0G1UBktsOleWFm/MmnmHW2LeOl67vQAXqw+sSV/y6rb5Kzn8/0e/P2xbwqove
         boggjxcWiH4UnbuXOGKNbuBU364gWdeijLrnuQcI0aolnbkvF1MpdshBPi3W5GZI26iZ
         VE9ZJQxmSB86xzPT3SBE+PqwKbppwEuqNlhk8NyjiCGmSJ1ifz8JtJgtojOY+/fgtanv
         MOqv7LVJox0XJ2d1NN6HtmRUwyXaxp5pbsEH0rADbHrlKrejuIDhoW6G+0RbmMIUKvCu
         sDLKjaYJtfQ0HG+UyfHs6y04Ob8slrJFvpRTMSB3UomwoLt+0xr94/dR3ExVLicO83w6
         dxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nI7yEuG2ARK23uejO9nhB9zAo4xzWVauJN211Odr0ag=;
        b=Yyv8EU0czP3abKR+Mgo9oHWGNnoILneJSZluLd6P0zGTzmw+qrTyoGIEdauv3her9Y
         RnGXiPMvDsepY8LUjghHiZyZ6G2C3l+yk1PEcc36v+wGbUGMyOV3bKSwPpabc/FrN3oM
         2QfvX+6Za9gPvIkdwztPOzadCMs1ShM3qQO4K7mb3VNmeBskGRD5+Cvf4FlzmszrNBkE
         dysSZJFukEprQuQgaZbpDBelhaEisrzcvBfXAJnuWFh17gWsxOC7F9aUY1tBXo8La4AZ
         /kirxAckK6jobNr2c9MDKe0h4m4rkiwFVDZFws1Pu+0gtkZe2/56LBZfetVkPSgGaTsX
         +kMA==
X-Gm-Message-State: AOAM533WQ0xMO5WAGi2ThkBow4KSlR7lDkkV8FBKHScKHDZo8Hrntuv+
        jizV53iOkkTyqTyoIIDQlxCNvZZ3D7mjFX8q5PeFajlY2iVwxg==
X-Google-Smtp-Source: ABdhPJyRLlGAMJvGoiPaWvpNElF/xJHOqBPZOWBpR2vkSoib2df0R18MIhqUWtQohPkb7vDP4sEy/87V/xLthopwClk=
X-Received: by 2002:ab0:49aa:: with SMTP id e39mr3733325uad.0.1623909637178;
 Wed, 16 Jun 2021 23:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Jun 2021 08:00:25 +0200
Message-ID: <CAMhs-H9659uAEb9A-xxfOEqcsUuFE1tNTu_VAj+AskwKUUD8dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     linux-pci@vger.kernel.org
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jun 9, 2021 at 4:02 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> Topology is as follows:
>
>                           MT7621 PCIe HOST Topology
>
>                                    .-------.
>                                    |       |
>                                    |  CPU  |
>                                    |       |
>                                    '-------'
>                                        |
>                                        |
>                                        |
>                                        v
>                               .------------------.
>                   .-----------|  HOST/PCI Bridge |------------.
>                   |           '------------------'            |     Type1
>          BUS0     |                     |                     |    Access
>                   v                     v                     v    On Bus0
>           .-------------.        .-------------.       .-------------.
>           | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
>           |    BUS0     |        |    BUS0     |       |    BUS0     |
>           |    DEV0     |        |    DEV1     |       |    DEV2     |
>           '-------------'        '-------------'       '-------------'
>     Type0        |          Type0       |         Type0       |
>    Access   BUS1 |         Access   BUS2|        Access   BUS3|
>    On Bus1       v         On Bus2      v        On Bus3      v
>            .----------.           .----------.          .----------.
>            | Device 0 |           | Device 0 |          | Device 0 |
>            |  Func 0  |           |  Func 0  |          |  Func 0  |
>            '----------'           '----------'          '----------'
>
> This driver has been very long time in staging and I have been cleaning
> it from its first versions where there was code kaos and PCI_LEGACY support.
> Original code came probably from openWRT based on mediatek's SDK code. There
> is no documentation at all about the mt7621 PCI subsystem.
> I have been cleaning it targeting mt7621 SoC which is the one I use in
> my GNUBee PC1 board and HiLink HLK-MT7621A evaluation board.
>
> Now I think is clean enough to be moved into 'drivers/pci/controller'.
> This driver is mips/ralink architecture and need 'mips_cps_numiocu()'
> to properly configure iocu regions for mips.
>
> This driver also uses already mainlined pci phy driver located in
> 'drivers/phy/ralink/phy-mt7621-pci.c'. There are two instances of
> the phy being the first one dual ported for pci0 and pci1, and the
> second one not dual ported dedicated to pci2. Because of writing twice
> some phy registers of the dual-ported one sometimes become in not
> confident boot cycles we have to take care of this when device link
> is checked here in controller driver. We power on the dual ported-phy
> if there is something connected in pcie0 or pcie1. In the same manner
> we have to properly disable it only if nothing is connected in of both
> pcie0 and pcie1 slots.
>
> Another thing that must be mentioned is that this driver uses IO
> in physical address 0x001e160000. IO_SPACE_LIMIT for MIPS is 0xffff
> so some generic PCI functions (like of_pci_range_to_resource) won't
> work and the resource ranges part for IO is set manually.

This has been fixed and now there is no need to set io resources manually.
See [0].

>
> Changes in v2:
>     - Make one commit moving driver directly from staging into
>      'drivers/pci/controllers' instead of two commits making
>      one add and a later remove.
>     - Update binding documentation moving 'clocks', 'resets' and
>      'phys' properties to child root bridge nodes.
>     - Update code to properly be able to use new bindings.
>     - Kconfig: add || (MIPS && COMPILE_TEST).
>     - Use {read/write}_relaxed versions.
>     - Use 'PCI_BASE_ADDRESS_0' instead of a custom definition.
>     - Avoid to set 'PCI_COMMAND_MASTER' and re-do functions
>      'mt7621_pcie_enable_ports' and 'mt7621_pcie_enable_port'.

I forgot to comment that all of these changes are rebased on the top
of staging-next.
Since this is a 'git mv' as I was told to do by Bjorn, last version of
the code is available
here [1] with the following added changes to the ones listed above
from previously submitted v1 series:

- Define PCI_IOBASE for mips (spaces.h) to avoid parsing io resources manually
so 'mt7621_pci_parse_request_of_pci_ranges' is not needed anymore.
- Don't store resources in driver private data but just get them to properly
set io window register and mips iocu memory regions.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-staging/20210614100617.28753-1-sergio.paracuellos@gmail.com/T/#t
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=staging-next

>
> NOTE: Greg, I have maintained your Acked-by from previous series in
> delete driver commit and added in the one which is moving code here
> and delete the remaining stuff. If you are not ok with this, just
> let me now and I'll drop it and resend.
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> Sergio Paracuellos (3):
>   dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
>   PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
>   MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
>     driver
>
>  .../bindings/pci/mediatek,mt7621-pci.yaml     | 142 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  arch/mips/ralink/Kconfig                      |   2 +-
>  drivers/pci/controller/Kconfig                |   8 +
>  drivers/pci/controller/Makefile               |   1 +
>  .../controller}/pci-mt7621.c                  |   0
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/mt7621-pci/Kconfig            |   8 -
>  drivers/staging/mt7621-pci/Makefile           |   2 -
>  drivers/staging/mt7621-pci/TODO               |   4 -
>  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
>  12 files changed, 158 insertions(+), 122 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
>  rename drivers/{staging/mt7621-pci => pci/controller}/pci-mt7621.c (100%)
>  delete mode 100644 drivers/staging/mt7621-pci/Kconfig
>  delete mode 100644 drivers/staging/mt7621-pci/Makefile
>  delete mode 100644 drivers/staging/mt7621-pci/TODO
>  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
>
> --
> 2.25.1
>
