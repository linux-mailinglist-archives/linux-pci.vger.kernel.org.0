Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4C124867
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfLRNbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 08:31:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39676 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfLRNbJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 08:31:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so2148645lja.6
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2019 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgYUn0m04y4lziXkPkx+mepQM6rOgURZ4g2WLYIpXFc=;
        b=R/w0lbToBbFBnbypMREu8eTdu/r9CgRc1RM/vZ4DH/XJ7b5h6EP82fJCneA17dE4CB
         vFSPOf+Aw+OVxY4s8rcDkUFT7fEjiUGQV2D172IYM76sbwcSQE/YnXzQz4zFL4r4YEqN
         69qV4M8QlUoDlztHvlPYp88fngnDfONFkLYi2/4VEPl5NxXPgngLP3LL5lUn/xeBGbFG
         pVIpbBJ1t9x2Pe+OVbjBKEmvDnMQ5yRWdJX0+iH2In/7w/5/ShGyMU9E1eZNagcMsL2Z
         Qi6nw6MRNqjlSfOxsDXRoHebdBqELh6MpM7ToB33PP8ZLMduzLvG178NymD1vZO2qt+D
         5UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgYUn0m04y4lziXkPkx+mepQM6rOgURZ4g2WLYIpXFc=;
        b=sbtJ5Ykliw0dQ6K1Sk6xuG+FM106+j9ENyGbmOxs+Ji5I1aqM/Qvk6hBFs7sJ+EMyN
         zJxCo6//kDJSADuOAX8+yHKq54yUySAhfWdNLZS0q0iaqejDSueSmZIbSs/SzOT8eix4
         hK2PIQbmiBxhKAcSL2fc+Lx/a44GYOhxX/WrI/qD1TN5cRzhx+IsfO6QVUcHYGhKqbmt
         gPk5tNf84rEXJmvZdjNziva6uTWJSNe+aLKRtc4ZFiJ0b/Jqj5mV+Hz1l0M4L+Y8TtPQ
         iSWNVgONQo4wrHP87qqBJrJr1o4xhOG9HAD7BvCGYxjJ8endIMEuZrvUrM1+rxJS+p2U
         QWhQ==
X-Gm-Message-State: APjAAAUklFxEAsxrHfCuc/DJNEb14n44VRztH26bf01Ptr59PT4TXxtF
        dEhD+yHMppaWwSOMY2DydFA=
X-Google-Smtp-Source: APXvYqz2Ig0BB4Sjo05mH8EzplpyVhS7rXPIZPIF8B56WrXvb6Ivj8sN3Sw1tmDipoGtZYrtle2aMQ==
X-Received: by 2002:a2e:9987:: with SMTP id w7mr1759131lji.107.1576675867274;
        Wed, 18 Dec 2019 05:31:07 -0800 (PST)
Received: from monakov-y.xu ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id a9sm1148973lfk.23.2019.12.18.05.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 05:31:06 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:31:01 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191218163101.4af92f48@monakov-y.xu>
In-Reply-To: <20191217215436.GA230275@google.com>
References: <20191217193131.2dc1c53c@monakov-y.xu>
        <20191217215436.GA230275@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Dec 2019 15:54:36 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Dec 17, 2019 at 07:31:31PM +0300, Yurii Monakov wrote:
> > On Tue, 17 Dec 2019 08:31:13 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > [+cc Kishon]
> > > 
> > > On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:  
> > > > PCIe window memory start address should be incremented by OB_WIN_SIZE
> > > > megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> > > > 
> > > > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>    
> > > 
> > > I added:
> > > 
> > >   Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
> > >   Acked-by: Andrew Murray <andrew.murray@arm.com>
> > >   Cc: stable@vger.kernel.org      # v4.20+
> > > 
> > > and cc'd Kishon (author of  e75043ad9792) and put this on my
> > > pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
> > > returns.
> > > 
> > > I'd like the commit message to say what this fixes.  Currently it just
> > > restates the code change, which I can see from the diff.  
> > This was my first patch sent to LKML, I'm sorry for inconvenience.
> > Should I take any actions to fix this?  
> 
> Great, welcome!  No need for you to do anything; just let me know if I
> captured this correctly:
Yes, everything is correct. New commit message perfectly describes this patch.

Best Regards,
Yurii Monakov

> 
> commit 93c53da177c9 ("PCI: keystone: Fix outbound region mapping")
> Author: Yurii Monakov <monakov.y@gmail.com>
> Date:   Fri Oct 4 18:48:11 2019 +0300
> 
>     PCI: keystone: Fix outbound region mapping
>     
>     The Keystone outbound Address Translation Unit (ATU) maps PCI MMIO space in
>     8 MB windows.  When programming the ATU windows, we previously incremented
>     the starting address by 8, not 8 MB, so all the windows were mapped to the
>     first 8 MB.  Therefore, only 8 MB of MMIO space was accessible.
>     
>     Update the loop so it increments the starting address by 8 MB, not 8, so
>     more MMIO space is accessible.
>     
>     Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
>     Link: https://lore.kernel.org/r/20191004154811.GA31397@monakov-y.office.kontur-niirs.ru
>     [bhelgaas: commit log]
>     Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Andrew Murray <andrew.murray@arm.com>
>     Cc: stable@vger.kernel.org	# v4.20+
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index af677254a072..f19de60ac991 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  				   lower_32_bits(start) | OB_ENABLEN);
>  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
>  				   upper_32_bits(start));
> -		start += OB_WIN_SIZE;
> +		start += OB_WIN_SIZE * SZ_1M;
>  	}
>  
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);

