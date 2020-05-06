Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B131C67E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEFGJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgEFGJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 02:09:16 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8003DC061A0F;
        Tue,  5 May 2020 23:09:16 -0700 (PDT)
Received: from flygoat-x1e (unknown [IPv6:2409:891e:6b40:4ccf:a277:695f:88be:4123])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 93E731FAF7;
        Wed,  6 May 2020 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588745356; bh=A4jfPl3F7aTVgpe4nLCMijDOi3+pUZ6bmkfPi8BYFEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nl6mdz+KS0BxVJFJBxa1LZPTQUZAo5bbHCM7nC26G8p7Ist/+31lEdGwdjClIFDKd
         rmnaX0ekaflA+fgPWHXHzvv9pYs2LLHbdxp2YKzQtwOtL3FtZjfslGZdiX6+tsXjf7
         hAJHZzKeK2oK1dvTjomBqZtgm1S9bcnJO1pjAnwRh/hfAJ1LFgudwnIy5blsV3Ls4T
         0siqdGX0Q99FOJto60UraRS4SjFhpSyrAS8a/x1q6Oa5mri/I/2F16ex0sNv7KMmSW
         VneT3zgf3/IwXv+Er69AgMnIVfNkcuRH4SxxoDIq3DFIvBR8qF1ej7pJSwUISU5UUG
         7/fpsQ1XHPzvw==
Date:   Wed, 6 May 2020 14:08:52 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200506140852.49bf7d2c@flygoat-x1e>
In-Reply-To: <20200504234329.GA300770@bjorn-Precision-5520>
References: <20200428011429.1852081-3-jiaxun.yang@flygoat.com>
        <20200504234329.GA300770@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 May 2020 18:43:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Apr 28, 2020 at 09:14:17AM +0800, Jiaxun Yang wrote:
> > This controller can be found on Loongson-2K SoC, Loongson-3
> > systems with RS780E/LS7A PCH.
> > 
> > The RS780E part of code was previously located at
> > arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> > driver implementation.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > --
> > v2:
> > 	- Clean up according to rob's suggestions
> > 	- Claim that it can't work as a module
> > v3:
> > 	- Fix a typo
> > v4:
> > 	- More clean-ups: Drop flag check, use devfn
> > v7:
> > 	- Fix ordering according to huacai's suggestion
> > ---
> >  drivers/pci/controller/Kconfig        |  10 +
> >  drivers/pci/controller/Makefile       |   1 +
> >  drivers/pci/controller/pci-loongson.c | 251
> > ++++++++++++++++++++++++++ 3 files changed, 262 insertions(+)
> >  create mode 100644 drivers/pci/controller/pci-loongson.c
> > 
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index 91bfdb784829..ae36edb1d7db
> > 100644 --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -258,6 +258,16 @@ config PCI_HYPERV_INTERFACE
> >  	  The Hyper-V PCI Interface is a helper driver allows
> > other drivers to have a common interface with the Hyper-V PCI
> > frontend driver. 
> > +config PCI_LOONGSON
> > +	bool "LOONGSON PCI Controller"
> > +	depends on MACH_LOONGSON64 || COMPILE_TEST
> > +	depends on OF
> > +	depends on PCI_QUIRKS
> > +	default MACH_LOONGSON64
> > +	help
> > +	  Say Y here if you want to enable PCI controller support
> > on
> > +	  Loongson systems.
> > +
> >  source "drivers/pci/controller/dwc/Kconfig"
> >  source "drivers/pci/controller/mobiveil/Kconfig"
> >  source "drivers/pci/controller/cadence/Kconfig"
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index 158c59771824..fbac4b0190a0
> > 100644 --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> >  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> >  obj-$(CONFIG_VMD) += vmd.o
> >  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> > +obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o  
> 
> This is apparently a PCIe controller, not a Conventional PCI
> controller, since you reference PCIe-specific things like MRRS below.
> 
> If that's the case, I'd name it pcie-loongson.c.
> 

Hi Bjorn,

Thanks for your careful review.

I'll resolve other comments, for the naming as it's exactly a PCI host
bridge with some on-chip devices like AHCI, Ethernet, VGA controller
attached on it, also some PCI to PCIe bridges are attached on it to
provide PCIe port. I'd still prefer pci-loongson as it's name.

--
Jiaxun Yang
