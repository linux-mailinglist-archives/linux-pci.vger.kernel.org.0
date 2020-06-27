Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E215120BEB2
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jun 2020 07:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgF0FC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Jun 2020 01:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgF0FC3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Jun 2020 01:02:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F4A206C0;
        Sat, 27 Jun 2020 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593234148;
        bh=52mxIUaZLoVmxOKx2Gb5mRUH3pwu1njJu8Quot51mAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqimtLyZ8v0ZX6Q98SVgJ9b13idUWAU0lFfM9RXjq6+4AbY8ka6ooCu8eI1+N413a
         hLJZjfsxJQNVpvzt3xSNv9cLHlXpk6xrNQ7whNr2pO4QVz+c2EejPer90/rRMRjnTs
         GaSfg7F32eP4YGanottsIxPOehppWJUkWX6Xal1A=
Date:   Sat, 27 Jun 2020 07:02:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
Message-ID: <20200627050225.GA226238@kroah.com>
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
 <20200626141754.GB4141629@kroah.com>
 <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 26, 2020 at 11:53:34AM -0700, Rajat Jain wrote:
> a) I think what was decided was introducing a device core "location"
> property that can be exposed to userspace to help it to decide whether
> or not to attach a driver to a device. Yes, that is still the plan.

Great, but this patch ignores that and starts to add policy :(

> (Mild sidenote: userspace may not need to distinguish between internal
> and external devices if it can assume that no internal PCI devices
> will show up after "echo 0 > /sys/bus/pci/drivers_autoprobe". But
> nevertheless...)

It can not assume that.

> b) Note that even with (a) in place, we still need a parameter that
> can ensure that drivers are not bound to external devices at boot,
> *before* userspace gets a chance to disable "drivers_autoprobe".

Why do you think you need that?  I kind of doubt you really want this,
but ick, if you really do, make it a policy decision that you bake into
the kernel as a build option, so that no one else has to use it :)

> https://lkml.org/lkml/2020/6/15/1453

Ick, please use lore.kernel.org, we don't control lkml.org and it's not
all that reliable.

> Is it OK to add such a parameter in device core?

You don't have internal/external/wherever in the driver core yet, so
don't start adding policy before you get that...

thanks,

greg k-h
