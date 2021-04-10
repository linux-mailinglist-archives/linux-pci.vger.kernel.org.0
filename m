Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49535B00F
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhDJTSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJTSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 15:18:07 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA90C06138A
        for <linux-pci@vger.kernel.org>; Sat, 10 Apr 2021 12:17:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AA5D330013709;
        Sat, 10 Apr 2021 21:17:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9E2C91E6B5; Sat, 10 Apr 2021 21:17:49 +0200 (CEST)
Date:   Sat, 10 Apr 2021 21:17:49 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, kbusch@kernel.org,
        sean.v.kelley@intel.com, qiuxu.zhuo@intel.com,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
Message-ID: <20210410191749.GA16240@wunner.de>
References: <1612356795-32505-2-git-send-email-yangyicong@hisilicon.com>
 <20210410152103.GA2043340@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410152103.GA2043340@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 10:21:03AM -0500, Bjorn Helgaas wrote:
> Anybody want to chime in and review this?  Sometimes I feel like a
> one-man band :)

Can't say anything about the object of the patch, but style-wise
this looks cryptic:

> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
> >  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> >  
> > -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> > +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> >  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);

Instead of writing "ctl & 0xfff4", I'd prefer defining macros for the
register bits of interest, then use "ctl &= ~(u16)(bits to clear)"
and in a separate line use "ctl |= (bits to set)".

Obviously, clearing bits that are unconditionally set afterwards is
unnecessary (as is done here).


> >  	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);

This looks superfluous since the IRQ can be found out in /proc/interrupts.

Thanks,

Lukas
