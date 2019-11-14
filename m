Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83425FBE01
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 03:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKNCuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 21:50:25 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:37461 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNCuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 21:50:25 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0771B3000452D;
        Thu, 14 Nov 2019 03:50:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D0FD4A3DC9; Thu, 14 Nov 2019 03:50:22 +0100 (CET)
Date:   Thu, 14 Nov 2019 03:50:22 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Message-ID: <20191114025022.wz3gchr7w67fjtzn@wunner.de>
References: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
 <20191113045939.hhmzfbx46vkgmsvn@wunner.de>
 <0712ed46-e4ba-46d0-05b5-81b258829f38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0712ed46-e4ba-46d0-05b5-81b258829f38@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 03:58:51PM -0600, Stuart Hayes wrote:
> The hotplug port I'm seeing the issue with is an AMD "Starship/Matisse GPP
> Bridge" (1022/1483), which uses an MSI interrupt (PCI-MSI chip).
[...]
> And because individual event enable bits in the slot control register aren't
> cleared on each interrupt, I interpret this to mean that an interrupt message
> will be sent every time that the event status bits in the slot status register
> transition from all zeros to at least one event status bit being 1.  Once one
> of those event status bits is 1, the logical AND of the three conditions above
> will not transition from FALSE to TRUE again until all of the (enabled) event
> status bits in the slot status register all go to zero, which is what my patch
> is intended to ensure.

Understood now, thanks.

I'd suggest adding a flag "unsigned int pvm_capable;" to struct controller
below "u32 slot_cap" (in the "capabilities and quirks" section),
setting that flag in pcie_init() from dev->msi_cap + PCI_MSI_FLAGS
(& PCI_MSI_FLAGS_MASKBIT) and amending pciehp_isr() to check for that
flag and re-read / re-write the Slot Status register until it's all zeroes.
That would make the reason for the modifications to pciehp_isr() explicit.
Please try to make the modifications to pciehp_isr() as small and simple
as possible.  Maybe it's worthwhile to put them in a separate static
function which is called from pciehp_isr(), I don't know.

Please mention the PCI vendor / device IDs in the commit message
and provide a reference to the PCIe Base Spec section you've quoted
above.

Thanks,

Lukas
