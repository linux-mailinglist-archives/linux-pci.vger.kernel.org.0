Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807982C8ABF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgK3RVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 12:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgK3RVk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 12:21:40 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7372074A;
        Mon, 30 Nov 2020 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606756859;
        bh=CbyJZAykpCyvjLTpCkzzfJ9pt8bGnYt3xwR2qqUfoI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TGw3iJHvgbb+g7diOKMOugr/nuC73+5xTFsD9rPkDlD83W1yHAv7Z9v4H3q8I+h2c
         xfiTLITVOpwfI8mn+Ad8xB8BJQI4zSsYIJBr4W2mHE1j1LovJTR5pfq9Lf1A6rY2iM
         aagN+CcdLl1BicBBB0tVOwQNrEZ9ea5LezYWYgRc=
Date:   Mon, 30 Nov 2020 11:20:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v6 4/5] PCI: vmd: Update type of the __iomem pointers
Message-ID: <20201130172058.GA1088391@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f4ddc2f0524b4b80c8a0bfa2df57fe@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 09:06:56AM +0000, David Laight wrote:
> From: Krzysztof Wilczynski
> > Sent: 29 November 2020 23:08
> > 
> > Use "void __iomem" instead "char __iomem" pointer type when working with
> > the accessor functions (with names like readb() or writel(), etc.) to
> > better match a given accessor function signature where commonly the
> > address pointing to an I/O memory region would be a "void __iomem"
> > pointer.
> 
> ISTM that is heading in the wrong direction.
> 
> I think (form the variable names etc) that these are pointers
> to specific registers.
> 
> So what you ought to have is a type for that register block.
> Typically this is actually a structure - to give some type
> checking that the offsets are being used with the correct
> base address.

In this case, "cfgbar" is not really a pointer to a register; it's the
address of memory-mapped config space.  The VMD hardware turns
accesses to that space into PCI config transactions on its secondary
side.  xgene_pcie_get_cfg_base() and brcm_pcie_map_conf() are similar
situations and use "void *".

Bjorn
