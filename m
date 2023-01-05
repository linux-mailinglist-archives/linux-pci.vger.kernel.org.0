Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB665F242
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 18:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAERJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 12:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjAERIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 12:08:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522A59F8A
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 09:04:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B20561B94
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 17:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA16C433F0;
        Thu,  5 Jan 2023 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672938256;
        bh=Wustkw9C7OttGXn1CJVGFnSF0tCf4QVUyMf/QOYqtK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ahr3mvx2VfUYHpc14w0anmXZBbMg+rSK6pl9uX+OLOKnexe8ae7+vC/E/mmrQQ+zi
         nOgwxg0utJFjCdt3ezEXvlhECCY4yvJFTKmVzltbQJxIfrrou3Ieg62dzc7V+IAoGT
         y9N8m9OXyeQfdzaooBJHxXdSNYhY3JHH890Xd3E1sJi2m9KjWjb7Tce8CnUdR1MkD3
         Arpt87bREiM7H+qXKY2SrudaX+A7hQxiesneVgaXFfASM3tJmb0w51Qei5ItKSl0fJ
         Fh3GNngZGZG/Egdp4xsr1rZ+XAIkELv9k6HKqgDJKZBt+RjnzzgF7JaFGIQeycaCOL
         O6ex5H3vMWtEQ==
Date:   Thu, 5 Jan 2023 11:04:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20230105170413.GA1150738@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7bUAaxt6viswdXV@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 03:43:29PM +0200, Mika Westerberg wrote:
> On Thu, Jan 05, 2023 at 11:12:11AM +0200, Mika Westerberg wrote:
> > > What happens in a topology like this:
> > > 
> > >   10:00.0 non-hotplug bridge to [bus 20-3f]
> > >   10:01.0 non-hotplug bridge to [bus 40]
> > >   20:00.0 hotplug bridge
> > >   40:00.0 NIC
> > > 
> > > where we're distributing space on "bus" 10, hotplug_bridges == 0 and
> > > normal_bridges == 2?  Do we give half the extra space to bus 20 and
> > > the other half to bus 40, even though we could tell up front that bus
> > > 20 is the only place that can actually use any extra space?
> > 
> > Yes we split it into half.
> 
> Forgot to reply also that would it make sense here to look at below the
> non-hotplug bridges and if we find hotplug bridges, distribute the space
> equally between those or something like that?

Yes, I do think ultimately it would make sense to keep track at every
bridge whether it or any descendant is a hotplug bridge so we could
distribute extra space only to bridges that could potentially use it.

But I don't know if that needs to be done in this series.  This code
is so complicated and fragile that I think being ruthless about
defining the minimal problem we're solving and avoiding scope creep
will improve our chances of success.

So treat this as a question to improve my understanding more than
anything.

Bjorn
