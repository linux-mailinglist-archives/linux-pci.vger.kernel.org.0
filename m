Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC0280DBC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgJBG52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 02:57:28 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:42397 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBG52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 02:57:28 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 60AD02802699F;
        Fri,  2 Oct 2020 08:57:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3F3D823112D; Fri,  2 Oct 2020 08:57:26 +0200 (CEST)
Date:   Fri, 2 Oct 2020 08:57:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario.Limonciello@dell.com
Subject: Re: Enabling d3 support on hotplug bridges
Message-ID: <20201002065726.GA22967@wunner.de>
References: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
 <20200922065434.GA19668@wunner.de>
 <CADnq5_MfkojHbquHq4Le6ioSFOY9XdaNBapAEmyOgf0CGMTaUg@mail.gmail.com>
 <20200923121509.GA25329@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923121509.GA25329@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 02:15:09PM +0200, Lukas Wunner wrote:
> I've just taken a look at the ACPI dumps provided by Michal Rostecki
> and Arthur Borsboom in the Gitlab bugs linked below.  The topology
> looks like this:
> 
> 00:01.1        Root Port         [\_SB.PCI0.GPP0]
>   01:00.0      Switch Upstream   [\_SB.PCI0.GPP0.SWUS]
>     02:00.0    Switch Downstream [\_SB.PCI0.GPP0.SWUS.SWDS]
>       03:00.0  dGPU              [\_SB.PCI0.GPP0.SWUS.SWDS.VGA]
>       03:00.1  dGPU Audio        [\_SB.PCI0.GPP0.SWUS.SWDS.HDAU]
> 
> The Root Port is hotplug-capable but is not suspended because we only
> allow that for Thunderbolt hotplug ports or root ports with Microsoft's
> HotPlugSupportInD3 _DSD property.  However, that _DSD is not present
> in the ACPI dumps and the Root Port is obviously not a Thunderbolt
> port either.

I took another, closer look at the ACPI tables and couldn't find anything
specific about the Root Port or the GPU below, save for Power Resources
and corresponding _PS0 / _PS3 methods in the Root Port's namespace.

If a hotplug port is explicitly power manageable by ACPI through these
methods, it should be safe to suspend it to D3.  I wouldn't be surprised
if that's what Windows does.  So I've just submitted a patch to whitelist
such ports for D3.  It has been tested successfully by two users with
affected laptops:

https://lore.kernel.org/linux-pci/cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de/

Thanks,

Lukas
