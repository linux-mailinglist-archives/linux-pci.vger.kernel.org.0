Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6539176864
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBXpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 18:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBXpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 18:45:30 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C332465E;
        Mon,  2 Mar 2020 23:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583192729;
        bh=c/X8dqneUUuRyLatXXAhfXamunR0CXC9L/SQLnzKQPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hkx/Of1AA1f8uddkTR/qFq3aULeh+EDaHLrSdBGznPXoV7LJYHDc3tB/9LU+ugKPR
         HmFT8QOBFC1vrL40iMjvBRc4fWledqJaacJdOIxrE1Wd/hB6jmbKzOrnXVcvJ4i+u+
         B8x/vw6pHUnOBQLVhYmClnhyBEFmYT2uIlzVGCkA=
Date:   Mon, 2 Mar 2020 17:45:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/4] PCI: Use pci_speed_string() for all
 PCI/PCI-X/PCIe strings
Message-ID: <20200302234527.GA185793@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4592a4cc-8064-2575-3a15-ae61dd03c23e@hisilicon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 29, 2020 at 05:10:38PM +0800, Yicong Yang wrote:
> On 2020/2/29 11:07, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Previously some PCI speed strings came from pci_speed_string(), some came
> > from the PCIe-specific PCIE_SPEED2STR(), and some came from a PCIe-specific
> > switch statement.  These methods were inconsistent:
> >
> >   pci_speed_string()     PCIE_SPEED2STR()     switch
> >   ------------------     ----------------     ------
> >   33 MHz PCI
> >   ...
> >   2.5 GT/s PCIe          2.5 GT/s             2.5 GT/s
> >   5.0 GT/s PCIe          5 GT/s               5 GT/s
> >   8.0 GT/s PCIe          8 GT/s               8 GT/s
> >   16.0 GT/s PCIe         16 GT/s              16 GT/s
> >   32.0 GT/s PCIe         32 GT/s              32 GT/s
> >
> > Standardize on pci_speed_string() as the single source of these strings.
> >
> > Note that this adds ".0" and "PCIe" to some messages, including sysfs
> > "max_link_speed" files, a brcmstb "link up" message, and the link status
> > dmesg logging, e.g.,
> >
> >   nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> >
> > I think it's better to standardize on a single version of the speed text.
> > Previously we had strings like this:
> >
> >   /sys/bus/pci/slots/0/cur_bus_speed: 8.0 GT/s PCIe
> >   /sys/bus/pci/slots/0/max_bus_speed: 8.0 GT/s PCIe
> >   /sys/devices/pci0000:00/0000:00:1c.0/current_link_speed: 8 GT/s
> >   /sys/devices/pci0000:00/0000:00:1c.0/max_link_speed: 8 GT/s
> >
> > This changes the latter two to match the slots files:
> >
> >   /sys/devices/pci0000:00/0000:00:1c.0/current_link_speed: 8.0 GT/s PCIe
> >   /sys/devices/pci0000:00/0000:00:1c.0/max_link_speed: 8.0 GT/s PCIe
> >
> > Based-on-patch by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c |  3 +--
> >  drivers/pci/pci-sysfs.c               | 27 +++++----------------------
> >  drivers/pci/pci.c                     |  6 +++---
> >  drivers/pci/pci.h                     |  9 ---------
> >  4 files changed, 9 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index d20aabc26273..41e88f1667bf 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -823,8 +823,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >  	lnksta = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
> >  	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
> >  	nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> > -	dev_info(dev, "link up, %s x%u %s\n",
> > -		 PCIE_SPEED2STR(cls + PCI_SPEED_133MHz_PCIX_533),
> > +	dev_info(dev, "link up, %s x%u %s\n", pci_speed_string(cls),
> >  		 nlw, ssc_good ? "(SSC)" : "(!SSC)");
> 
> Here comes the problem. cls is not a pci_bus_speed enumerate. The
> PCIe link speed decodes from PCI_EXP_LNKSTA is from 0x000, we'll get
> the *wrong* string if passing cls directly to pci_speed_string().
> pcie_link_speed[](drivers/pci/probe.c, line 662) array should be
> used here to do the conversion.
> 
> + dev_info(dev, "link up, %s x%u %s\n", pci_speed_string(pcie_link_speed[cls]),
>            nlw, ssc_good ? "(SSC)" : "(!SSC)";

Oh, right, thanks!
