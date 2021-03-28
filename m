Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B41834BC88
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhC1Nt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1Nt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 09:49:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131EC061756;
        Sun, 28 Mar 2021 06:49:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gb6so4782687pjb.0;
        Sun, 28 Mar 2021 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V54Bsftn9AhHdDMdpmEp8JmBOF6GOJkmVF6r6IzLWjw=;
        b=HHxmvhRX1KM17O5dPF8p44ZaRz6XeJW+Vgx00G3o1ZXuSZT5jAVUvnXMSajN7xxlt5
         vmrNpwV1rhkqJNJvh6s/LO7R2q4j3AduneG5+KMYNLeWwqEWuV4EKgn7kxsY32gzXfFS
         T1h4tRC8AWZla11UjR6k2ZJYylCk64xaAii9nQciJjjdXe4uBjQj6tA3vjveSM8PwVUk
         yBaIQoQjRKTFcsa3sGzHgWe6rfwTqR6aDhKRWyzsl8hP8tgIyqDI2RUSPLLBOzMtll5s
         qad+S+7zBCvXM1vHqy0AxRLp00+MtGs3KkJe5v1aevQE137YG0tNm9lsZHEKdI8j8WfX
         7sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V54Bsftn9AhHdDMdpmEp8JmBOF6GOJkmVF6r6IzLWjw=;
        b=g0tnIcD3R/In7qb48s3QOgqug67Syqyw82bjvzPfUmZpA0UCFapTiw2ZYmvytWmK1V
         eNX7FB+EU8BsJPvo5m106eIroIATdqQLdR8ub8pJcNCwB/83rg5Zpb7FgWCXdu4t5TjD
         b/8BAxpUB1HzM7FwvCLxVBZPi/8BYbMi+31gal+3+hqveCR73BqwYtGTtQxaCZo36cWg
         LChNSop0xz+3T/NaKKNZQzfG+9f/4cF3LUCmDApodhzOXfXr5j7iLXvSvT2tQT1Zdr//
         18Xaao9QT/t1J1X9owPpM0Iv5KvYRIqJUydB89nsIOKMJSO10ej7uWNLLNiejhvVJ7Te
         E9jg==
X-Gm-Message-State: AOAM533Kgc4OJttYn6J3IC00fUOUJvu7Mafr1362b7r46uVIjkvi+SO0
        v2WPMeXBb+9+qRCXXJuDElE=
X-Google-Smtp-Source: ABdhPJyu2qggueAMWM0/PFkf0GnfpDOkdVRJkTWzGaWDxUj4pXyO+TF4QqzMpEXo/cRH6eWWN8uyqQ==
X-Received: by 2002:a17:902:ac89:b029:e6:d199:29ac with SMTP id h9-20020a170902ac89b02900e6d19929acmr24326784plr.46.1616939368075;
        Sun, 28 Mar 2021 06:49:28 -0700 (PDT)
Received: from localhost (185.212.56.149.16clouds.com. [185.212.56.149])
        by smtp.gmail.com with ESMTPSA id f15sm13935817pgg.84.2021.03.28.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:49:27 -0700 (PDT)
Date:   Sun, 28 Mar 2021 21:49:25 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: controller: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <20210328134925.GA247508@nuc8i5>
References: <20200602171601.17630-1-zhengdejin5@gmail.com>
 <YF9zQscGC7T/ZsN+@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF9zQscGC7T/ZsN+@xps13.dannf>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 12:02:42PM -0600, dann frazier wrote:
Hi Dann,

I'm so sorry for that, And there is a mistake with my patch that caused
this problem. Thank you very much for telling me this, I will fix it as
soon as possible.

> On Wed, Jun 03, 2020 at 01:16:01AM +0800, Dejin Zheng wrote:
> > Use devm_platform_ioremap_resource_byname() to simplify codes.
> > it contains platform_get_resource_byname() and devm_ioremap_resource().
> > 
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> > v1 -> v2:
> > 	- Discard changes to the file drivers/pci/controller/pcie-xilinx-nwl.c
> > 	  Due to my mistakes, my patch will modify pcie-xilinx-nwl.c,
> > 	  but it still need to use the res variable, but
> > 	  devm_platform_ioremap_resource_byname() funtion can't assign a
> > 	  value to the variable res. kbuild test robot report it. Thanks
> > 	  very much for kbuild test robot <lkp@intel.com>.
> > 
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 3 +--
> >  drivers/pci/controller/cadence/pcie-cadence-host.c | 3 +--
> >  drivers/pci/controller/pci-tegra.c                 | 8 +++-----
> >  drivers/pci/controller/pci-xgene.c                 | 3 +--
> >  drivers/pci/controller/pcie-altera-msi.c           | 3 +--
> >  drivers/pci/controller/pcie-altera.c               | 9 +++------
> >  drivers/pci/controller/pcie-mediatek.c             | 4 +---
> >  drivers/pci/controller/pcie-rockchip.c             | 5 ++---
> >  8 files changed, 13 insertions(+), 25 deletions(-)
> > 
> 
> hey,
>   I found that recent kernels fail to initialize PCI devices on our HP
> m400 Moonshot cartridges, which are based on the X-Gene SoC. I
> bisected the issue down to this commit. I found that just reverting
> this hunk in pci-xgene.c is enough to get v5.12 rcs booting again:
> 
> > diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> > index d1efa8ffbae1..1431a18eb02c 100644
> > --- a/drivers/pci/controller/pci-xgene.c
> > +++ b/drivers/pci/controller/pci-xgene.c
> > @@ -355,8 +355,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
> >  	if (IS_ERR(port->csr_base))
> >  		return PTR_ERR(port->csr_base);
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > -	port->cfg_base = devm_ioremap_resource(dev, res);
> > +	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> >  	if (IS_ERR(port->cfg_base))
> >  		return PTR_ERR(port->cfg_base);
> >  	port->cfg_addr = res->start;
The mistake of this patch is here, port->cfg_addr need the res->start,
But this patch remove the res of get "cfg" resource. here use the wrong
data by get "csr" resource in the previous.

BR,
Dejin
> 
> 
> In case it helps, here's the PCI initialization portion of dmesg when
> it fails:
> 
> [    0.756359] xgene-pcie 1f500000.pcie: host bridge /soc/pcie@1f500000 ranges:
> [    0.756372] xgene-pcie 1f500000.pcie:   No bus range found for /soc/pcie@1f500000, using [bus 00-ff]
> [    0.756387] xgene-pcie 1f500000.pcie:      MEM 0xa130000000..0xa1afffffff -> 0x0030000000
> [    0.756404] xgene-pcie 1f500000.pcie:   IB MEM 0x4000000000..0x7fffffffff -> 0x4000000000
> [    0.756459] xgene-pcie 1f500000.pcie: (rc) x8 gen-2 link up
> [    0.756525] xgene-pcie 1f500000.pcie: PCI host bridge to bus 0000:00
> [    0.756532] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.756538] pci_bus 0000:00: root bus resource [mem 0xa130000000-0xa1afffffff] (bus address [0x30000000-0xafffffff])
> 
> 
> and here's what it looks like when it works:
> 
> [    0.756793] xgene-pcie 1f500000.pcie: host bridge /soc/pcie@1f500000 ranges:
> [    0.756807] xgene-pcie 1f500000.pcie:   No bus range found for /soc/pcie@1f500000, using [bus 00-ff]
> [    0.756822] xgene-pcie 1f500000.pcie:      MEM 0xa130000000..0xa1afffffff -> 0x0030000000
> [    0.756838] xgene-pcie 1f500000.pcie:   IB MEM 0x4000000000..0x7fffffffff -> 0x4000000000
> [    0.756892] xgene-pcie 1f500000.pcie: (rc) x8 gen-2 link up
> [    0.756962] xgene-pcie 1f500000.pcie: PCI host bridge to bus 0000:00
> [    0.756968] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.756974] pci_bus 0000:00: root bus resource [mem 0xa130000000-0xa1afffffff] (bus address [0x30000000-0xafffffff])
> [    0.757006] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
> [    0.757014] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757022] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757032] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757039] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757046] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757052] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757059] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757068] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
> [    0.757094] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
> [    0.757143] pci 0000:00:00.0: supports D1 D2
> [    0.757589] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x3e may corrupt adjacent RW1C bits
> [    0.757968] pci 0000:01:00.0: [15b3:1007] type 00 class 0x020000
> [    0.758381] pci 0000:01:00.0: reg 0x10: [mem 0x00100000-0x001fffff 64bit]
> [    0.758642] pci 0000:01:00.0: reg 0x18: [mem 0x00800000-0x00ffffff 64bit pref]
> [    0.761110] pci 0000:01:00.0: reg 0x134: [mem 0x00000000-0x007fffff 64bit pref]
> [    0.761115] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 8 VFs)
> [    0.762921] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x8 link at 0000:00:00.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
> [    0.773939] pci 0000:00:00.0: BAR 15: assigned [mem 0xa130000000-0xa1347fffff 64bit pref]
> [    0.773947] pci 0000:00:00.0: BAR 14: assigned [mem 0xa134800000-0xa1348fffff]
> [    0.773954] pci 0000:01:00.0: BAR 2: assigned [mem 0xa130000000-0xa1307fffff 64bit pref]
> [    0.774136] pci 0000:01:00.0: BAR 9: assigned [mem 0xa130800000-0xa1347fffff 64bit pref]
> [    0.774203] pci 0000:01:00.0: BAR 0: assigned [mem 0xa134800000-0xa1348fffff 64bit]
> [    0.774384] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.774391] pci 0000:00:00.0:   bridge window [mem 0xa134800000-0xa1348fffff]
> [    0.774397] pci 0000:00:00.0:   bridge window [mem 0xa130000000-0xa1347fffff 64bit pref]
> [    0.774576] pcieport 0000:00:00.0: PME: Signaling with IRQ 89
> [    0.774734] pcieport 0000:00:00.0: AER: enabled with IRQ 89
> 
> 
>   -dann
