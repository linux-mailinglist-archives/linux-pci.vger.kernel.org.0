Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F329B1567AF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBHUWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 15:22:55 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56803 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHUWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 15:22:55 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 524D930000952;
        Sat,  8 Feb 2020 21:22:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1B22B777F0; Sat,  8 Feb 2020 21:22:53 +0100 (CET)
Date:   Sat, 8 Feb 2020 21:22:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200208202253.ixvnecn52u3rdoas@wunner.de>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 03:00:44PM -0400, Stuart Hayes wrote:
> In older PCIe specs, PDS (presence detect) would come up when the
> "in-band" presence detect pin connected, and would be up before DLLLA
> (link active).
> 
> In PCIe 4.0 (as an ECN) and in PCIe 5.0, there is a new bit to show if
> in-band presence detection can be disabled for the slot, and another bit
> that disables it--and a recommendation that it should be disabled if it
> can be. In addition, certain OEMs disable in-band presence detection
> without implementing these bits.
> 
> This means it is possible to get a "card present" interrupt after the
> link is up and the driver is loaded.  This causes an erroneous removal
> of the device driver, followed by an immediate re-probing.
> 
> This patch set defines these new bits, uses them to disable in-band
> presence detection if it can be, waits for PDS to go up if in-band
> presence detection is disabled, and adds a DMI table that will let us
> know if we should assume in-band presence is disabled on a system.

FWIW, this series is

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Looking at the patches again today, I only spotted a minor cosmetic issue:

In patch [1/3] I would have preferred readout of the PCI_EXP_SLTCAP2
register (hunk #3) to be inserted a little further up in pcie_init(),
perhaps before reading the PCI_EXP_LNKCAP register.  It just looks
a little out of place at the end of the function.  I would have
grouped it together with the other quirks and feature checks further
up in the function and I probably would have amended the ctrl_info()
to print the status of the inband_presence_disabled flag.

In patch [3/3] the DMI check would then likewise have to be moved up
in the function.

Maybe Bjorn can make this change when applying, and if not, it's not
a big deal.

Thanks,

Lukas
