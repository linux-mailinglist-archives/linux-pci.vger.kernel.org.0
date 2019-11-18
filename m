Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3299A1002E6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfKRKtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 05:49:13 -0500
Received: from foss.arm.com ([217.140.110.172]:59968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfKRKtN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 05:49:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C39030E;
        Mon, 18 Nov 2019 02:49:12 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F273F6C4;
        Mon, 18 Nov 2019 02:49:11 -0800 (PST)
Date:   Mon, 18 Nov 2019 10:49:05 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Message-ID: <20191118104905.GB32355@e121166-lin.cambridge.arm.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
 <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
 <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
 <20191106202712.GA32215@redsun51.ssa.fujisawa.hgst.com>
 <c3327d3eb56f141cb2dbca4e8f69f0beca2fc8dc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3327d3eb56f141cb2dbca4e8f69f0beca2fc8dc.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 08:33:01PM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-11-07 at 05:27 +0900, Keith Busch wrote:
> > On Wed, Nov 06, 2019 at 08:14:41PM +0000, Derrick, Jonathan wrote:
> > > Yes that problem exists today 
> > 
> > Not really, because we're currently using unamanged interrupts which
> > migrate to online CPUs. It's only the managed ones that don't migrate
> > because they have a unchangeable affinity.
> > 
> > > and this set limits the exposure as it's
> > > a rare case where you have a child NVMe device with fewer than 32
> > > vectors.
> > 
> > I'm deeply skeptical that is the case. Even the P3700 has only 31 IO
> > queues, yielding 31 vectors for IO services, so that already won't work
> > with this scheme.
> > 
> Darn you're right. At one point I had VMD vector 1 using NVMe AQ,
> leaving the 31 remaining VMD vectors for NVMe IO queues. This would
> have lined up perfectly. Had changed it last minute and that does break
> the scheme for P3700....
> 
> > But assuming you wanted to only use devices that have at least 32 IRQ
> > vectors, the nvme driver also allows users to carve those vectors up
> > into fully affinitized sets for different services (read vs. write is
> > the one the block stack supports), which would also break if alignment
> > to the parent device's IRQ setup is required.
> 
> Wasn't aware of this. Fair enough.

Marked the series with "Changes Requested", waiting for a new
version.

Lorenzo
