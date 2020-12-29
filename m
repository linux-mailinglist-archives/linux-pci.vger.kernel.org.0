Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A012E6FFA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgL2LbJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 06:31:09 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:38233 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2LbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 06:31:08 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7A02E30000CC4;
        Tue, 29 Dec 2020 12:30:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 70562197A; Tue, 29 Dec 2020 12:30:24 +0100 (CET)
Date:   Tue, 29 Dec 2020 12:30:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
Message-ID: <20201229113024.GA7615@wunner.de>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117163817.GA1397220@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
> > With Runtime PM disabled e.g. the PHY on network devices may remain
> > powered up even with no cable plugged in, affecting battery lifetime
> > on mobile devices. Currently we have to rely on the respective distro
> > or user to enable Runtime PM via sysfs (echo auto > power/control).
> > Some devices work around this restriction by calling pm_runtime_allow
> > in their probe routine, even though that's not recommended by
> > https://www.kernel.org/doc/Documentation/power/pci.txt
> > 
> > Disabling Runtime PM per default seems to be a big hammer, a quirk
> > for affected devices / systems may had been better. And we still
> > have the option to disable Runtime PM for selected devices via sysfs.

Removing the recommendation in pci.txt and allowing runtime PM in more
drivers by default seems sensible to me.  Such an incremental approach
is less risky with regards to regressions than a big hammer.  Heiner,
care to submit patches to that effect?

Thanks,

Lukas
