Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489534B8B5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhC0SDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 14:03:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0SCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 14:02:48 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1lQDGo-0004y2-EV
        for linux-pci@vger.kernel.org; Sat, 27 Mar 2021 18:02:46 +0000
Received: by mail-io1-f71.google.com with SMTP id s6so8412059iom.21
        for <linux-pci@vger.kernel.org>; Sat, 27 Mar 2021 11:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RrC6Uh7mvsY/QGW5SQ0aCeEyQ9jD8LXRdMjHy+gZDqc=;
        b=dfP6dyeO3m0927frsFnA08ZAEBX9mWtrm7WhMa0/26oweGMJSAuPfWQ4voDv6ayJ/D
         dyuMvXT/+PFLGcft6bNuIbkw/487E0JyQRYf88fb7ID+HoCaWQm53/PBX6tELYFReNGN
         V3omcWtTs3DcgrKSw8kSrey8KTa8A9HviDMD2SYL+woZfBjG/AMzMLbWWgGZtnqhUk6q
         Wyq75jPmvMnJ1BUZ00RKybJlUqS0WbHvhtW33/90L1OvRcLJuUiQoTW12fQZ0/WJ/5Nw
         PGLc4DbuhxnT5/cl81gfCM62rMyvG+pxKqqUYR42460bhlU5BWY6zYH75CWzJbra583f
         lZog==
X-Gm-Message-State: AOAM532uOtswj2+AS3nDaHocaV2RfyTAAPLNmJ1zbL+FosxflaUnBJ4h
        Ap3UAxPAksPo9QFU+7dSnlk4kMIptLvxJ13fDVskTPEHPt2Pa83wexDVQe0sQzqIjk73vc/CYWR
        ZJNccjbsPkclSHtCOI9V1IBRPp2NcepzkIlXMcQ==
X-Received: by 2002:a5e:8d05:: with SMTP id m5mr14683157ioj.114.1616868165304;
        Sat, 27 Mar 2021 11:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLxovz317Y+w9ac7lus5lXP82uaNaWOHPuuRXtADcNGxYRw1P1YX0oYpk15R0Yo7aS1hiRfg==
X-Received: by 2002:a5e:8d05:: with SMTP id m5mr14683145ioj.114.1616868165044;
        Sat, 27 Mar 2021 11:02:45 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id x4sm3528324ilm.39.2021.03.27.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 11:02:44 -0700 (PDT)
Date:   Sat, 27 Mar 2021 12:02:42 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: controller: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <YF9zQscGC7T/ZsN+@xps13.dannf>
References: <20200602171601.17630-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602171601.17630-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 01:16:01AM +0800, Dejin Zheng wrote:
> Use devm_platform_ioremap_resource_byname() to simplify codes.
> it contains platform_get_resource_byname() and devm_ioremap_resource().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
> 	- Discard changes to the file drivers/pci/controller/pcie-xilinx-nwl.c
> 	  Due to my mistakes, my patch will modify pcie-xilinx-nwl.c,
> 	  but it still need to use the res variable, but
> 	  devm_platform_ioremap_resource_byname() funtion can't assign a
> 	  value to the variable res. kbuild test robot report it. Thanks
> 	  very much for kbuild test robot <lkp@intel.com>.
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 3 +--
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 3 +--
>  drivers/pci/controller/pci-tegra.c                 | 8 +++-----
>  drivers/pci/controller/pci-xgene.c                 | 3 +--
>  drivers/pci/controller/pcie-altera-msi.c           | 3 +--
>  drivers/pci/controller/pcie-altera.c               | 9 +++------
>  drivers/pci/controller/pcie-mediatek.c             | 4 +---
>  drivers/pci/controller/pcie-rockchip.c             | 5 ++---
>  8 files changed, 13 insertions(+), 25 deletions(-)
> 

hey,
  I found that recent kernels fail to initialize PCI devices on our HP
m400 Moonshot cartridges, which are based on the X-Gene SoC. I
bisected the issue down to this commit. I found that just reverting
this hunk in pci-xgene.c is enough to get v5.12 rcs booting again:

> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index d1efa8ffbae1..1431a18eb02c 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -355,8 +355,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
>  	if (IS_ERR(port->csr_base))
>  		return PTR_ERR(port->csr_base);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> -	port->cfg_base = devm_ioremap_resource(dev, res);
> +	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>  	if (IS_ERR(port->cfg_base))
>  		return PTR_ERR(port->cfg_base);
>  	port->cfg_addr = res->start;


In case it helps, here's the PCI initialization portion of dmesg when
it fails:

[    0.756359] xgene-pcie 1f500000.pcie: host bridge /soc/pcie@1f500000 ranges:
[    0.756372] xgene-pcie 1f500000.pcie:   No bus range found for /soc/pcie@1f500000, using [bus 00-ff]
[    0.756387] xgene-pcie 1f500000.pcie:      MEM 0xa130000000..0xa1afffffff -> 0x0030000000
[    0.756404] xgene-pcie 1f500000.pcie:   IB MEM 0x4000000000..0x7fffffffff -> 0x4000000000
[    0.756459] xgene-pcie 1f500000.pcie: (rc) x8 gen-2 link up
[    0.756525] xgene-pcie 1f500000.pcie: PCI host bridge to bus 0000:00
[    0.756532] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.756538] pci_bus 0000:00: root bus resource [mem 0xa130000000-0xa1afffffff] (bus address [0x30000000-0xafffffff])


and here's what it looks like when it works:

[    0.756793] xgene-pcie 1f500000.pcie: host bridge /soc/pcie@1f500000 ranges:
[    0.756807] xgene-pcie 1f500000.pcie:   No bus range found for /soc/pcie@1f500000, using [bus 00-ff]
[    0.756822] xgene-pcie 1f500000.pcie:      MEM 0xa130000000..0xa1afffffff -> 0x0030000000
[    0.756838] xgene-pcie 1f500000.pcie:   IB MEM 0x4000000000..0x7fffffffff -> 0x4000000000
[    0.756892] xgene-pcie 1f500000.pcie: (rc) x8 gen-2 link up
[    0.756962] xgene-pcie 1f500000.pcie: PCI host bridge to bus 0000:00
[    0.756968] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.756974] pci_bus 0000:00: root bus resource [mem 0xa130000000-0xa1afffffff] (bus address [0x30000000-0xafffffff])
[    0.757006] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    0.757014] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757022] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757032] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757039] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757046] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757052] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757059] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757068] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    0.757094] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    0.757143] pci 0000:00:00.0: supports D1 D2
[    0.757589] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    0.757968] pci 0000:01:00.0: [15b3:1007] type 00 class 0x020000
[    0.758381] pci 0000:01:00.0: reg 0x10: [mem 0x00100000-0x001fffff 64bit]
[    0.758642] pci 0000:01:00.0: reg 0x18: [mem 0x00800000-0x00ffffff 64bit pref]
[    0.761110] pci 0000:01:00.0: reg 0x134: [mem 0x00000000-0x007fffff 64bit pref]
[    0.761115] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 8 VFs)
[    0.762921] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x8 link at 0000:00:00.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
[    0.773939] pci 0000:00:00.0: BAR 15: assigned [mem 0xa130000000-0xa1347fffff 64bit pref]
[    0.773947] pci 0000:00:00.0: BAR 14: assigned [mem 0xa134800000-0xa1348fffff]
[    0.773954] pci 0000:01:00.0: BAR 2: assigned [mem 0xa130000000-0xa1307fffff 64bit pref]
[    0.774136] pci 0000:01:00.0: BAR 9: assigned [mem 0xa130800000-0xa1347fffff 64bit pref]
[    0.774203] pci 0000:01:00.0: BAR 0: assigned [mem 0xa134800000-0xa1348fffff 64bit]
[    0.774384] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.774391] pci 0000:00:00.0:   bridge window [mem 0xa134800000-0xa1348fffff]
[    0.774397] pci 0000:00:00.0:   bridge window [mem 0xa130000000-0xa1347fffff 64bit pref]
[    0.774576] pcieport 0000:00:00.0: PME: Signaling with IRQ 89
[    0.774734] pcieport 0000:00:00.0: AER: enabled with IRQ 89


  -dann
