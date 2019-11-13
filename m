Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343FDFAA3E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 07:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfKMGfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 01:35:22 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:36249 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfKMGfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 01:35:22 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id F002B3000D92B;
        Wed, 13 Nov 2019 07:35:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BCF3C30C9DD; Wed, 13 Nov 2019 07:35:19 +0100 (CET)
Date:   Wed, 13 Nov 2019 07:35:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191113063519.ivv2ehejxonkfufe@wunner.de>
References: <20191029170022.57528-2-mika.westerberg@linux.intel.com>
 <20191113031752.GA227753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113031752.GA227753@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 09:17:52PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2019 at 08:00:22PM +0300, Mika Westerberg wrote:
> > parent PCIe downstream port, who got the hot-remove event, starts
> > removing devices below it taking pci_lock_rescan_remove() lock. When the
> > child PCIe port is runtime resumed it calls pciehp_check_presence()
> > which ends up calling pciehp_card_present() and pciehp_check_link_active().
> 
> Oh, I see, pciehp_resume() calls pciehp_check_presence(), which
> schedules the IRQ thread via pciehp_request().  So does this deadlock
> only happen if the port(s) have been runtime suspended?

No, there is a multitude of situations when the deadlock may occur and
this is just one of them.  See my comment on v1 of this patch:

https://patchwork.ozlabs.org/patch/1117870/#2230798

Thanks,

Lukas
