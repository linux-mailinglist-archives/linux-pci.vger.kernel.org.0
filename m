Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F282D34EA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgLHVGz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 16:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgLHVGz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 16:06:55 -0500
Date:   Tue, 8 Dec 2020 15:06:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607461575;
        bh=fSoNQRcc0LZ9Vd4mfNnsBvZ5tqGU/FOK1XZtvccEZA0=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=c7AcH56Thqe+4NCEmqVgXEzAwWClmNtrpb8HtX8PCFxHBUz8Fs68Cj+dMGuehEUvc
         19RjHSE/mjUAt9FlbAu7gSUO0l6+zLTWnm1oiVWlK13pSCawfo2A9v5u7Gp9YKQdP5
         Cii+EnPfpluaZhUhZSGOVp63ldAhb0L2IfPzbDPUL7gbtYEr76QGCbuqnWnToi0la6
         vQvXAGU1s3VYsHFMq6LK6AzvArf88/G4IZYY7o6iXlHhvKskJBykRi7Dze0jVTCeWF
         6zncRzClJoP3Ofzut9MEVgANCxGWCl41bJjUQMHjcNabScCR+A4+8LCnl9bqALN0hM
         aiCUVLDOpIjqA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, heiko@sntech.de,
        benh@kernel.crashing.org, shawn.lin@rock-chips.com,
        paulus@samba.org, thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de, Qian Cai <qcai@redhat.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201208210613.GA2420289@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208154150.20978-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Qian]

On Tue, Dec 08, 2020 at 04:41:50PM +0100, Michael Walle wrote:
> Hi Lorenzo, Krzysztof,
> 
> >On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
> >> Unify ECAM-related constants into a single set of standard constants
> >> defining memory address shift values for the byte-level address that can
> >> be used when accessing the PCI Express Configuration Space, and then
> >> move native PCI Express controller drivers to use newly introduced
> >> definitions retiring any driver-specific ones.
> >> 
> >> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> >> PCI Express specification (see PCI Express Base Specification, Revision
> >> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> >> implement it the same way.
> >> 
> >> [...]
> >
> >Applied to pci/ecam, thanks!
> >
> >[1/5] PCI: Unify ECAM constants in native PCI Express drivers
> >      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
> >[2/5] PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
> >      https://git.kernel.org/lpieralisi/pci/c/3c38579263
> >[3/5] PCI: iproc: Convert to use the new ECAM constants
> >      https://git.kernel.org/lpieralisi/pci/c/333ec9d3cc
> >[4/5] PCI: vmd: Update type of the __iomem pointers
> >      https://git.kernel.org/lpieralisi/pci/c/89094c12ea
> >[5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
> >      https://git.kernel.org/lpieralisi/pci/c/3dc62532a5
> 
> Patch 1/5 breaks LS1028A boards:

I temporarily dropped this series while we figure out what went wrong
here.

Bjorn
