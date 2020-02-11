Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E5159200
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 15:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgBKOcF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 09:32:05 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:45505 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgBKOcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 09:32:05 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 091892800A28D;
        Tue, 11 Feb 2020 15:32:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B9D48286F3E; Tue, 11 Feb 2020 15:32:02 +0100 (CET)
Date:   Tue, 11 Feb 2020 15:32:02 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200211143202.2sgryye4m234pymq@wunner.de>
References: <20200211044940.72z4vcgbgxwbc7po@wunner.de>
 <20200211141443.GA204966@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211141443.GA204966@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 08:14:44AM -0600, Bjorn Helgaas wrote:
> I'm a little confused about why pci_hp_initialize()/
> __pci_hp_initialize()/pci_hp_register()/__pci_hp_register() is such a
> rat's nest with hotplug drivers using a mix of them.

This is modeled after device registration, which can be done either
in two steps (device_initialize() + device_add()) or in 1 step
(device_register()).

So it's either pci_hp_initialize() + pci_hp_add() or pci_hp_register().

The rationale is provided in the commit message of 51bbf9bee34f
("PCI: hotplug: Demidlayer registration with the core").


> Feels like sort of a
> double-negative situation, too.  Obviously the hardware bit has to be
> "1 means disabled" to be compatible with previous spec versions, but
> the code is usually easier to read if we test for something being
> *enabled*.

It's a similar situation with the "DisINTx" bit in the Command
register, which, if disabled, is shown as "DisINTx-" in lspci even
though the more intuitive notion is that INTx is *enabled*.  I think
you did the right thing by showing it as "IbPresDis-" because it's
consistent with how it's done elsewhere for similar bits.

Thanks,

Lukas
