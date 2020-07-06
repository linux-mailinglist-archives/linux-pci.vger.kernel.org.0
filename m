Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14C9215C0A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgGFQl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 12:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbgGFQl2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 12:41:28 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8947B206CD;
        Mon,  6 Jul 2020 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053688;
        bh=GgON5CyUmdCh9gM1yE2zg5keUKFUHjT+R0XZmnw2GG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fT19NkTlPcN7uq4ojyq9w156sXu6RUldP7nJRC3jaxSHLfSzffA928AFQyWOk5Pc7
         IN5sYZathQ3apDu4R+LMjyfml+EflfEl1CVumw8gedIZLqoynzdjgY4oeIICPEk8CO
         SKh8CAuVEivlDQW5jVKkf9ADr2S9hsjabqwMxi3E=
Date:   Mon, 6 Jul 2020 11:41:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
Message-ID: <20200706164126.GA124329@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630075554.GA619174@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 09:55:54AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
> > The "ExternalFacing" devices (root ports) are still internal devices that
> > sit on the internal system fabric and thus trusted. Currently they were
> > being marked untrusted.
> > 
> > This patch uses the platform flag to identify the external facing devices
> > and then use it to mark any downstream devices as "untrusted". The
> > external-facing devices themselves are left as "trusted". This was
> > discussed here: https://lkml.org/lkml/2020/6/10/1049
> 
> {sigh}
> 
> First off, please use lore.kernel.org links, we don't control lkml.org
> and it often times has been down.
> 
> Also, you need to put all of the information in the changelog, referring
> to another place isn't always the best thing, considering you will be
> looking this up in 20+ years to try to figure out why people came up
> with such a crazy design.
> 
> But, the main point is, no, we did not decide on this.  "trust" is a
> policy decision to make by userspace, it is independant of "location",
> while you are tieing it directly here, which is what I explicitly said
> NOT to do.
> 
> So again, no, I will NAK this patch as-is, sorry, you are mixing things
> together in a way that it should not do at this point in time.

What do you see being mixed together here?  I acknowledge that the
name of "pdev->untrusted" is probably a mistake.  But this patch
doesn't change anything there.  It only changes the treatment of the
edge case of the "ExternalFacing" ports.  Previously we treated them
as being external themselves, which does seem wrong.
