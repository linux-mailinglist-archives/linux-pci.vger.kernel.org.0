Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20A2646E5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgIJNZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 09:25:33 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:55801 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbgIJNY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 09:24:57 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C54E4280009D3;
        Thu, 10 Sep 2020 15:24:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8BFEA13C405; Thu, 10 Sep 2020 15:24:40 +0200 (CEST)
Date:   Thu, 10 Sep 2020 15:24:40 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Myron Stowe <mstowe@redhat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        klimov.linux@gmail.com
Subject: Re: PCIe hot-plug issue: Failed to check link status
Message-ID: <20200910132440.GA1661@wunner.de>
References: <20200908085726.54509090@zim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908085726.54509090@zim>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 08:57:26AM -0600, Myron Stowe wrote:
> On a system with a Mellanox Technologies MT27800 Family [ConnectX-5]
> NIC controller containing a power button, hot-plug fails to function
> properly.
[...]
> https://bugzilla.kernel.org/show_bug.cgi?id=209113

Thanks for the report.

So in the dmesg output you've provided, the card is already inserted
when the machine boots.  At 233 seconds, the Attention Button is pressed
twice within 200 msec (the second press cancels the first).  At 235 sec,
the button is pressed again and after 5 sec the slot is brought down.
So far so good.

At 291 sec the button is pressed but bringup of the slot fails.
What happens here is, pciehp notices that upon the button press,
a card is already present in the slot.  So for convenience,
instead of waiting the full 5 sec, it attempts to bring up the slot
immediately.  That fails because Data Link Layer Link Active isn't
set within 1 sec.

The difference to v4.18 is that back then, pciehp waited the full
5 sec before bringing up the slot.

Per PCIe r4.0 sec 6.7.1.8:

    After turning power on, software must wait for a Data Link Layer
    State Changed event, as described in Section 6.7.3.3.

And per sec 6.7.3.3:

    The Data Link Layer State Changed event must occur within 1 second
    of the event that initiates the hot-insertion. If a power controller
    is supported, the time out interval is measured from when software
    initiated a write to the Slot Control register to turn on the power.
    [...] Software is allowed to time out on a hot add operation if the
    Data Link Layer State Changed event does not occur within 1 second.

So we adhere to the spec regarding the timeout between enabling power
and waiting for DLLLA.  We do not exactly adhere to the spec regarding
the 5 sec delay between button press and acting on it.  But I can't
really imagine that's the problem.

As a shot in the dark, could you amend pcie_wait_for_link_delay()
in drivers/pci/pci.c and increase the "timeout = 1000" a little?
Maybe more than 1 sec is necessary in this case between enabling
power and timing out for lack of a link?

The v4.18 output you've provided in the bugzilla is incomplete and
lacks time stamps.  Could you provide it in full?

Thanks,

Lukas
