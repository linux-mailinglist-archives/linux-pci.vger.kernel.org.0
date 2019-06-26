Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39057458
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFZWgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 18:36:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:58508 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfFZWgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 18:36:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5QMZwRi031212;
        Wed, 26 Jun 2019 17:35:59 -0500
Message-ID: <9479a6d4ad7335b1e261081d6802219d53619cf5.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Date:   Thu, 27 Jun 2019 08:35:58 +1000
In-Reply-To: <20190626173505.GB183605@google.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
         <20190622210310.180905-3-helgaas@kernel.org>
         <20190624112449.GJ2640@lahna.fi.intel.com>
         <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
         <20190626173505.GB183605@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-26 at 12:35 -0500, Bjorn Helgaas wrote:
> No argument about it being a mess.
> 
> I agree that tweaks clutter the history, which is definitely a
> downside.  Do you think these actually change the way things work or
> make the code harder to read?
> 
> I think there is value in even minor simplifications that make the
> code easier to understand.  Small improvements compound over time and
> expose opportunities for more significant improvement.

Oh I absolutely agree. And I love that your patches come with more cset
comment than actual patch lines :-)

The main issue I've had so far trying to untangle things is the sheer
amount of subtle changes and tweaks that went in over the year without
any useful explanation as to why things are done.

For example, do you have any idea why this:

d65245c3297ac63abc51a976d92f45f2195d2854
PCI: don't shrink bridge resources

Was added by Yinghai in 2010 ? :-)

The main issue with this is that previous to this commit,
pbus_size_{io,mem} would essentially ignore the previous state of the
bridge resources, and calculate from scratch (provided the resources
are unclaimed).

After this, it has this subtle dependency.

This is what broke Lorenzo attempts at moving pci_read_bridge_bases()
to the geneneric code a couple of years ago for example. There may be a
good reason to do that on x86, though it's not explained, but it's
definitely not right if the platform requires a full re-assignment.

Now I'll "work around" it by making that function look at the
assignment policy set by the arch/platform, but it's a fix on top of a
quirk on top of a band-aid. However, what else can we do without
understanding the root issue that lead to that patch being created ?

Cheers,
Ben.


