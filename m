Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B62232D7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 07:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgGQFUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 01:20:03 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:37031 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGQFUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 01:20:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B51F6300020D3;
        Fri, 17 Jul 2020 07:20:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6B56E87621; Fri, 17 Jul 2020 07:20:00 +0200 (CEST)
Date:   Fri, 17 Jul 2020 07:20:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ian May <ian.may@canonical.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with
 reset_lock and device_lock
Message-ID: <20200717052000.vsyvbnwbhni4iy6y@wunner.de>
References: <20200615143250.438252-1-ian.may@canonical.com>
 <20200615143250.438252-2-ian.may@canonical.com>
 <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
 <0598848d-47ab-f436-04ea-7ef1f348905b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0598848d-47ab-f436-04ea-7ef1f348905b@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 12:13:23PM -0500, Ian May wrote:
> Thanks for the quick reply! I like your solution and have confirmed it
> solves the first deadlock we see between the Hotplug interrupt and AER
> recovery.

Thank you for the confirmation (and sorry for the delay).  I'm cooking
up a proper patch right now.

One question regarding your patch [2/2]:  If, instead of this patch,
you change pci_bus_error_reset() to call "device_lock(bridge)" rather
than "mutex_lock(&pci_slot_mutex)", do you still see deadlocks?

Taking the pci_slot_mutex in pci_bus_error_reset() was actually the
right thing to do because it holds the driver of the hotplug port
in place.  (The hotplug port above the bus being reset.)  Without
that, dereferencing slot->hotplug in pci_slot_reset() wouldn't be
safe.  My fear is that acquiring the device_lock() of the bridge
leading to the bus being reset may cause other deadlocks, in particular
in cascaded topologies such as Thunderbolt, which I suspect may be
what you're dealing with.

Thanks,

Lukas
