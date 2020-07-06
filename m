Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA8215EFF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGFSs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 14:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFSs4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 14:48:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B6A20773;
        Mon,  6 Jul 2020 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594061336;
        bh=TmzFSzpXz/IVyxhzyFOMQr63SdCmzzt9hF2zFcEfusA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+FtnLgdUY+221uDBs5Ha8exDMqail3b7n8Jia7lbUoHBH/GyyUX5isSnxbdpDMfl
         mVA69kh3JU6+46LL4UY7kQ3nrwbAPSFmEZtZE9KDoUTV9TdouG4oB4qeEehE9HG4mH
         LXwLsGTCgO/ih+UHSnsrlItO5tNGvguXMDwGK2tk=
Date:   Mon, 6 Jul 2020 20:48:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20200706184855.GA2335741@kroah.com>
References: <20200630075554.GA619174@kroah.com>
 <20200706164126.GA124329@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706164126.GA124329@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 11:41:26AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 30, 2020 at 09:55:54AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
> > > The "ExternalFacing" devices (root ports) are still internal devices that
> > > sit on the internal system fabric and thus trusted. Currently they were
> > > being marked untrusted.
> > > 
> > > This patch uses the platform flag to identify the external facing devices
> > > and then use it to mark any downstream devices as "untrusted". The
> > > external-facing devices themselves are left as "trusted". This was
> > > discussed here: https://lkml.org/lkml/2020/6/10/1049
> > 
> > {sigh}
> > 
> > First off, please use lore.kernel.org links, we don't control lkml.org
> > and it often times has been down.
> > 
> > Also, you need to put all of the information in the changelog, referring
> > to another place isn't always the best thing, considering you will be
> > looking this up in 20+ years to try to figure out why people came up
> > with such a crazy design.
> > 
> > But, the main point is, no, we did not decide on this.  "trust" is a
> > policy decision to make by userspace, it is independant of "location",
> > while you are tieing it directly here, which is what I explicitly said
> > NOT to do.
> > 
> > So again, no, I will NAK this patch as-is, sorry, you are mixing things
> > together in a way that it should not do at this point in time.
> 
> What do you see being mixed together here?  I acknowledge that the
> name of "pdev->untrusted" is probably a mistake.  But this patch
> doesn't change anything there.  It only changes the treatment of the
> edge case of the "ExternalFacing" ports.  Previously we treated them
> as being external themselves, which does seem wrong.

I don't see the patch here, and it's been a while but I think there is a
mixture of "location" and "trust" happening here with a single value
when they should be separate.

Hopefully the next round of this patch series will be better.

thanks,

greg k-h
