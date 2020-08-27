Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01AD253DEF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgH0GfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 02:35:22 -0400
Received: from verein.lst.de ([213.95.11.211]:36736 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgH0GfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Aug 2020 02:35:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FC7B68BFE; Thu, 27 Aug 2020 08:35:17 +0200 (CEST)
Date:   Thu, 27 Aug 2020 08:35:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
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
Message-ID: <20200827063517.GA4637@lst.de>
References: <20200824193036.6033-1-james.quinlan@broadcom.com> <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> Hi,
>
> On 8/24/2020 12:30 PM, Jim Quinlan wrote:
>>
>> Patchset Summary:
>>    Enhance a PCIe host controller driver.  Because of its unusual design
>>    we are foced to change dev->dma_pfn_offset into a more general role
>>    allowing multiple offsets.  See the 'v1' notes below for more info.
>
> We are version 11 and counting, and it is not clear to me whether there is 
> any chance of getting these patches reviewed and hopefully merged for the 
> 5.10 merge window.
>
> There are a lot of different files being touched, so what would be the 
> ideal way of routing those changes towards inclusion?

FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
I have a bit of a backlog, but plan to review and if Jim is ok with that
apply the current version.
