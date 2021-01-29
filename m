Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAC3090AA
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 00:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhA2XdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 18:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhA2XdW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 18:33:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4983C64DDB;
        Fri, 29 Jan 2021 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611963161;
        bh=AaRKlEXVYJOSc3OjKg08GiblXJKkQ7/R0lWN+prSR0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pd+lIYP5Hefz6v4Bmzbwfh7zXftmVNY4sjyw3yQcZUL3TyBKGcJzIC25+g6FrE+ge
         OBHxVoe+wTH7s/dff9dB8Gx058uxVBS8klW4aoZATiQUoyVNhzcSJ7hQVHwTeWGd/f
         GbpK/WQ1ESIEFCqgGMRvS//5646ylcn1oTHYa4yRuyd+VeMyUWO7KMvR1fRhedzQVS
         t5BZkJ8dEjN3U+zeXWzSJpU2Y9Jkgqar8H5qgWFAps65mW4MsBlXqJZiHaH2QLACR2
         jPytiBzvx/3kHb2EyjPHj5c9K9iuU2cChlFSPLLTznnAHbeDcELIMm+wI3gZEdBEu5
         sv/F+J9lsYrvg==
Received: by mail-ed1-f42.google.com with SMTP id f1so12463049edr.12;
        Fri, 29 Jan 2021 15:32:41 -0800 (PST)
X-Gm-Message-State: AOAM531y2FwFJIPGXF1Vs9yvimv7l1HYjsRbKUuiYA+MIVaVfqIp1vUm
        ufREwjOfN78V0EVVulZvFoUV/TQZqX5jUogrLw==
X-Google-Smtp-Source: ABdhPJwms2Nw1KYvxqUDL7F1dx844PWxsMYrYaBpi11kZepY8Tmd3rHJ4SJ47icemQHPplkh09UM2I4Ka0OFA29N7Iw=
X-Received: by 2002:aa7:d987:: with SMTP id u7mr7871023eds.62.1611963159943;
 Fri, 29 Jan 2021 15:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20210129173057.30288c9d@coco.lan>
In-Reply-To: <20210129173057.30288c9d@coco.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Jan 2021 17:32:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLN2XESoCW5=uhbzd4EP+dO0xVMmS7W4f6EgMv_j_xTpg@mail.gmail.com>
Message-ID: <CAL_JsqLN2XESoCW5=uhbzd4EP+dO0xVMmS7W4f6EgMv_j_xTpg@mail.gmail.com>
Subject: Re: Enabling PCIe support on Hikey 970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Joey.Gouly@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 10:31 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Bjorn/Rob,
>
> I've been trying to make a Hikey 970 board to work properly upstream.
>
> This specific hardware is similar to a previous model (Hikey 960),
> and it uses the same PCIe driver, with a few additions
> (drivers/pci/controller/dwc/pcie-kirin.c).
>
> The major difference between those two models is that, on Hikey 960,
> the PCIe is mapped as [1]:
>
>         +---------+      +--------+
>         |Kirin 960|----> |PCIe M.2|
>         |  SoC    |      |        |
>         +---------+      +--------+
>
> While, on Hikey 970, the connection is more complex[2]:
>
>         +---------+      +--------+
>         |         |      |        |     +--------+
>         |         |      |        |---->|PCIe M.2|-->M.2 slot
>         |         |      |        |     +--------+
>         |         |      |        |
>         |         |      |        |     +--------+
>         |Kirin 970|----> |Switch  |---->|Mini 1x |-->mini PCIe slot
>         |         |      |PEX 8606|     +--------+
>         |  SoC    |      |        |
>         |         |      |        |     +-------+
>         |         |      |        |---->|RTL8169|---> Ethernet
>         |         |      |        |     +-------+
>         +---------+      +--------+
>
>
>
> [1] see https://www.96boards.org/documentation/consumer/hikey/hikey960/hardware-docs/hardware-user-manual.md.html
> [2] see https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
>
> When the driver is properly loaded, this is what can be seen there:
>
>         $ lspci
>         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
>         01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
>
> (without anything connected to M.2 or mini 1x slots)
>
> All devices after the SoC require a regulator line to be
> enabled (LDO33). Starting the PCIe bus before turning them on
> causes PCIe probe to fail.
>
> There are also separate PERST lines for the switch (Broadcom PEX 8606),
> PCIe M.2, Mini 1x and for the Ethernet hardware (RTL 8169).
>
> To make it a little more fun, the M.2, the Mini 1x and the
> RTL 8169 also requires a clockreq in order to work.

Nice. Yet another case of a 'probeable' bus with non-probeable
additions. Second one recently for PCI[1][2].

> Both the 4 PERST reset lines and the 3 CLOCKREQ lines are initialized
> during the PCIe power on logic, at probing time.
>
> I'm currently thinking about the best way to report this via
> device tree.
>
> It sounds to me that the best would be to add those 4 data at the DTS file:
>
>         reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
>                       <&gpio3 1 0 >, <&gpio27 4 0 >;
>         reset-names = "pcie_switch_reset", "pcie_eth_reset",
>                       "pcie_m_2_reset",    "pcie_mini1_reset";

'reset-names' is paired with 'resets', so this doesn't work. The name
of the gpio is in the property name.

>         clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
>                        <&gpio17 0 0 >;
>         clkreq-names = "pcie_eth_clkreq", "pcie_m_2_clkreq",
>                        "pcie_mini1_clkreq";

The larger problem here is this will work for exactly one board. Soon
as you have a different topology, you'll have to change all this. If
it's just assert/deassert all the GPIOs at once, then it could kind of
work. If you need to know the mapping (which adding the names seems to
imply), then it definitely doesn't work.

You are going to need DT nodes representing the hierarchy you drew
above with GPIO properties added to the appropriate child nodes.

Controlling the regulator should be specific to the device.
Controlling the GPIOs could be done by the PCI core given those are
standard signals for PCI.

Rob

[1] https://lore.kernel.org/linux-devicetree/20210128175225.3102958-1-dmitry.baryshkov@linaro.org/
[2] https://lore.kernel.org/linux-devicetree/CAA8EJpqPONJfQLFQhB3_AEdFYcZ8rKWJw7=wd7KzJRhOEr+w_A@mail.gmail.com/
