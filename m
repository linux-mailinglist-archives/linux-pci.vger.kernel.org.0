Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17C42E9C2F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhADRk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 12:40:27 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:34941 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbhADRk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 12:40:27 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CB7662800B3CC;
        Mon,  4 Jan 2021 18:39:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C1A6450D7B; Mon,  4 Jan 2021 18:39:44 +0100 (CET)
Date:   Mon, 4 Jan 2021 18:39:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
Message-ID: <20210104173944.GA31187@wunner.de>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
 <20201231040735.GA2075@wunner.de>
 <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 31, 2020 at 10:38:12AM +0100, Heiner Kallweit wrote:
> On 31.12.2020 05:07, Lukas Wunner wrote:
> > FWIW, if platform_pci_power_manageable() returns true, it can probably
> > be assumed that allowing runtime PM by default is okay.  So as a first
> > step, you may want to call that instead of adding a new callback.
> 
> I don't think that's sufficient. Most likely all the broken old systems
> return true for platform_pci_power_manageable().

platform_pci_power_manageable() is not a global flag, but rather
a per-device flag whether the platform is capable of power-managing
that device.  E.g. for the ACPI platform, it indicates that objects
such as _PS0 or _PS3 are present in the device's namespace.

My point is that if the platform can power-manage a device,
then it ought to be safe to enable runtime PM by default for it.

If you insist on a "big hammer" approach by turning on runtime PM
by default for everything, you risk regressions.  You can avoid
that by going for a smart approach which enables runtime PM in
cases when it's safe.

Thanks,

Lukas
