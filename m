Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E381FF5ED
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgFRO4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 10:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbgFRO4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 10:56:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968082075E;
        Thu, 18 Jun 2020 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492205;
        bh=kuNcnjm0Q8W+waGxPF0G1vY00e5uDW5TVrJqCcu89jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uF5HmNrH6C78eYvYO3anenwMtz+JM2R17ifCoXsbUJ7zgjVgVKuqk1hdls42f7kLb
         /vs2q4SZEiKbfdPOb7DKVtz4odUZBWtA58q5dSzITtIpodtjfZQkS26R+alnnWaxDr
         iU5E67DYFsWib8kFh1TfzErJwFC5hPUmC637lCZU=
Date:   Thu, 18 Jun 2020 16:56:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618145637.GA3017232@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 12:14:41PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > ...
> > >
> > > > (and likely call it "external" instead of "untrusted".
> > >
> > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > chosen by the meaning of it.
> > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > tables, but I can replace it.
> >
> > Then your ACPI tables should show this, there is an attribute for it,
> > right?
> 
> There is a _PLD() method, but it's for the USB devices (or optional
> for others, I don't remember by heart). So, most of the ACPI tables,
> alas, don't show this.

There is something like this for PCI as well, otherwise they wouldn't be
getting this info from "the ether" :)

thanks,

greg k-h
