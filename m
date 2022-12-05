Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC664384F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 23:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEWqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 17:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiLEWqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 17:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF8EE1C
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 14:46:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B91B8159E
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 22:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D8C433C1;
        Mon,  5 Dec 2022 22:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670280395;
        bh=ux8WPNsyApCrB+cUhkOYLtMa2yA9Pc1Ki92b7RsHbis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QL3G2dWXTanAxW3sJyqZph+lxIPTsulowkGcSOG29TcigvR+hYsnPoh798MQHReZs
         xlq1Dj6prbHYa3cr3P5RBHSmMsAJFtL13T8k9JUNddm21A75ryo4GvQuNN/LBu2Y/p
         d1Ul3JIcc8e/aNjJ8pwIhs4LxLk9lq8yu/w6jy7I4YRfjNxLiW+UpVQ/eMNI8Kyant
         eDkSYlkqAQ38jSwmmfuTrPdjBKC7C4+oP63EGveY+QeiiwH+AvWnGley5rSJwAI2IK
         SFp3xDMp2xiVi16yZ8Hxwg9iX5Oq2vW1+Gxc1xmX6WMtoAeNtypw9mKd65wOHtIdx1
         vwV7X0jNTZpAA==
Date:   Mon, 5 Dec 2022 16:46:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20221205224634.GA1257222@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y42dniafcY76DctG@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 05, 2022 at 09:28:30AM +0200, Mika Westerberg wrote:
> On Fri, Dec 02, 2022 at 05:34:24PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 30, 2022 at 01:22:20PM +0200, Mika Westerberg wrote:
> > > A PCI bridge may reside on a bus with other devices as well. The
> > > resource distribution code does not take this into account properly and
> > > therefore it expands the bridge resource windows too much, not leaving
> > > space for the other devices (or functions a multifunction device) and

> > > +		 * Reduce the space available for distribution by the
> > > +		 * amount required by the other devices on the same bus
> > > +		 * as this bridge.
> > > +		 */
> > > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > > +			int i;
> > > +
> > > +			if (dev == bridge)
> > > +				continue;
> > 
> > Why do we skip "bridge"?  Bridges are allowed to have two BARs
> > themselves, and it seems like they should be included here.
> 
> Good point but then we would need to skip below the bridge window
> resources to avoid accounting them.

Seems like we should handle bridge BARs.  There are definitely bridges
(PCIe for sure, I dunno about conventional PCI) that implement them
and some drivers starting to appear that use them for performance
monitoring, etc.

> > This only happens for buses with a single bridge.  Shouldn't it happen
> > regardless of how many bridges there are?
> 
> This branch specifically deals with the "upstream port" so it gives all
> the spare resources to that upstream port. The whole resource
> distribution is actually done to accommondate Thunderbolt/USB4
> topologies which involve only PCIe devices so we always have PCIe
> upstream port and downstream ports which some of them are able to
> perform native PCIe hotplug. And for those ports we want to distribute
> the available resources so that they can expand to further topologies.
> 
> I'm slightly concerned that forcing this to support the "generic" PCI
> case makes this rather complicated. This is something that never appears
> in the regular PCI based systems because we never distribute resources
> for those in the first place (->is_hotplug_bridge needs to be set).

This code is fairly complicated in any case :)

I understand why this is useful for Thunderbolt topologies, but it
should be equally useful for other hotplug topologies because at this
level we're purely talking about the address space needed by devices
and how that space is assigned and routed through bridges.  Nothing
unique to Thunderbolt here.

I don't think we should make this PCIe-specific.  ->is_hotplug_bridge
is set by a PCIe path (set_pcie_hotplug_bridge()), but also by
check_hotplug_bridge() in acpiphp, which could be any flavor of PCI,
and I don't think there's anything intrinsically PCIe-specific about
it.

> > I don't understand the "bridge" part; it looks like that's basically
> > to use 4K alignment for I/O windows and 1M for memory windows?
> > Using "bridge" seems like a clunky way to figure that out.
> 
> Okay, but if not using "bridge", how exactly you suggest to doing the
> calculation?

I was thinking it would always be 4K or 1M, but I guess that's
actually not true.  There are some Intel bridges that support 1K
alignment for I/O windows, and some powerpc hypervisor stuff that can
also influence the alignment.  And it looks like we still need to
figure out which b_res to use, so we couldn't get rid of the IO/MEM
case analysis.  So never mind, I guess ...

Bjorn
