Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B226151A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgIHQoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 12:44:32 -0400
Received: from verein.lst.de ([213.95.11.211]:53340 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731773AbgIHQoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 12:44:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 026F868B02; Tue,  8 Sep 2020 14:20:45 +0200 (CEST)
Date:   Tue, 8 Sep 2020 14:20:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Julien Grall <julien.grall@arm.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
Message-ID: <20200908122045.GA31727@lst.de>
References: <20200824193036.6033-1-james.quinlan@broadcom.com> <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com> <20200827063517.GA4637@lst.de> <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com> <20200907091649.GA6428@e121166-lin.cambridge.arm.com> <CA+-6iNzoz3pM2pJksXogeuou6wB9W-59rN-amCLERFLuY5zLMg@mail.gmail.com> <00e49acb-c659-de10-3e87-76bfd82e4a76@gmail.com> <20200908104226.GB22909@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908104226.GB22909@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 11:42:26AM +0100, Lorenzo Pieralisi wrote:
> > Maybe we can parallelize the PCIe driver review while the DMA changes
> > are being worked on in Christoph's branch. Lorenzo, are you fine with
> > the PCIe changes proper?
> 
> I will have a look - the main contentious point was about the DMA
> changes - if Christoph is happy with them I am OK with them
> too - I hope there is not anything controversial in the host
> bridge driver itself but I will look into it.

I'm pretty happy with the overall shape.  Now we just need to squeeze
out the regressions..
