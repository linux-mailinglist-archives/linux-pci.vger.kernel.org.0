Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84D23D2C7D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVSbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhGVSbY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF60760C41;
        Thu, 22 Jul 2021 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626981119;
        bh=H1Amf3Wt5H/tD1y9rG2gSJon3EGCNhg8wr0x+VoiY30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b90CVSWOhHnYK74gLS7R2H+0DjT2CRmtz2zeBmKGAQhna8Mn+wrZak2dGbSYW63bn
         WVoPLo0VKyOmMnVSgTgMQGM8VDdB/BiVelxG6glUPvUGIJE1JWnIpdFrTUQA6f3pLW
         BGCVu8l6Gpq/ArGo6XTroMYtJY7PmpqOudxIYONT/wwIGykr3fcyLs4T0x5WR3Zyvn
         XBrb2RV1WowLCi0sQ6LfzEUjWefj0XD32S6UI8AxKcdnd01ObJSvrVLCUOSvS0XqTi
         99+9tTcFPfmnRLbL060oAHESBe+bp1REQBshnsIN14TFVrmIcjOOalBbrXPrc5CXWD
         sr178h6xqe7Pw==
Date:   Thu, 22 Jul 2021 14:11:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
Message-ID: <20210722191157.GA328153@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210721085026.aue5snnynlqw6r46@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 10:50:26AM +0200, Pali Rohár wrote:
> On Tuesday 20 July 2021 13:50:08 Nirmal Patel wrote:
> > During VT-d passthrough repetitive reboot tests, it was determined that the VMD
> > domain needed to be reset in order to allow downstream devices to reinitialize
> > properly. This is done using a secondary bus reset at each of the VMD root
> > ports and any bridges in the domain.
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 46 ++++++++++++++++++++++++++++++++++++

> > +static void vmd_domain_sbr(struct vmd_dev *vmd)
> > +{
> > +	char __iomem *base;
> > +	u16 ctl;
> > +	int dev_seq;
> > +	int max_devs = resource_size(&vmd->resources[0]) * 32;
> > +
> > +	/*
> > +	* Subdevice config space may or many not be mapped linearly using 4k config
> > +	* space.
> > +	*/
> > +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
> > +		base = VMD_DEVICE_BASE(vmd, dev_seq);
> > +		if (readw(base + PCI_VENDOR_ID) != PCI_VENDOR_ID_INTEL)
> > +			continue;
> > +
> > +		if ((readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK) !=
> > +		    PCI_HEADER_TYPE_BRIDGE)
> > +			continue;
> > +
> > +		if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
> > +			continue;
> > +
> > +		/* pci_reset_secondary_bus() */
> > +		ctl = readw(base + PCI_BRIDGE_CONTROL);
> > +		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
> > +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> > +		readw(base + PCI_BRIDGE_CONTROL);
> > +		msleep(2);
> > +
> > +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> > +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> > +		readw(base + PCI_BRIDGE_CONTROL);
> 
> You cannot unconditionally call secondary bus reset for arbitrary PCIe
> Bridge. Calling it breaks more PCIe devices behind bridge and
> pci_reset_secondary_bus() already handles it and skip reset if reset is
> causing issues.
> 
> I would suggest to use pci_reset_secondary_bus() and extend it
> so you can call it also from your driver.

Are you referring to PCI_DEV_FLAGS_NO_BUS_RESET?  That's handled in
pci_parent_bus_reset(), not pci_reset_secondary_bus().

I would probably agree that PCI_DEV_FLAGS_NO_BUS_RESET *should* be
checked in pci_reset_secondary_bus(), since there are several paths to
get there without going through pci_parent_bus_reset().

> > +	}
> > +	ssleep(1);
> > +}
