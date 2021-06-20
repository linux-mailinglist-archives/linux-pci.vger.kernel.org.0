Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B793ADD76
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jun 2021 09:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhFTHrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Jun 2021 03:47:08 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39959 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFTHrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jun 2021 03:47:08 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jun 2021 03:47:08 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9E787300000A6;
        Sun, 20 Jun 2021 09:38:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 92EBE10880; Sun, 20 Jun 2021 09:38:04 +0200 (CEST)
Date:   Sun, 20 Jun 2021 09:38:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210620073804.GA13118@wunner.de>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616221945.GA3010216@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 05:19:45PM -0500, Bjorn Helgaas wrote:
> On Sat, May 01, 2021 at 10:29:00AM +0200, Lukas Wunner wrote:
> > Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> > link upon an error and attempts to re-enable it when instructed by the
> > DPC driver.
> > 
> > A slot which is both DPC- and hotplug-capable is currently brought down
> > by pciehp once DPC is triggered (due to the link change) and brought up
> > on successful recovery.  That's undesirable, the slot should remain up
> > so that the hotplugged device remains bound to its driver.
> 
> I think the slot being "brought down" means slot power is turned off,
> right?
> 
> I reworded it along those lines and applied this to pci/hotplug for
> v5.14, thanks!

Thanks, the reworded commit message LGTM and is more readable.

"Being brought down" is just a colloquial term for pciehp_disable_slot(),
i.e. unbinding and removal of the pci_dev's below the hotplug port,
removing slot power, turning off the power LED and setting the slot's
state to OFF_STATE.

Indeed, turning off slot power concurrently to DPC recovery is wrong
and likely the biggest contributor to the problems seen.

Another issue is that after bringing down the slot due to the Link Change
event, pciehp will notice that Presence Detect State is set and will try
to bring the slot up again, even though DPC recovery may not have completed
yet.

The commit should solve all those synchronization issues between pciehp
and DPC.

Thanks,

Lukas
