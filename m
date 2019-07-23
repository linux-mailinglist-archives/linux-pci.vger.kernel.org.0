Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D757153D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfGWJc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:32:57 -0400
Received: from foss.arm.com ([217.140.110.172]:51764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfGWJc5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 05:32:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D081B337;
        Tue, 23 Jul 2019 02:32:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FCB93F71A;
        Tue, 23 Jul 2019 02:32:55 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:32:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/VMD: Fix config addressing with bus offsets
Message-ID: <20190723093251.GA12867@e121166-lin.cambridge.arm.com>
References: <20190611211538.29151-1-jonathan.derrick@intel.com>
 <20190621142803.GA21807@e121166-lin.cambridge.arm.com>
 <1ec9408fabb2178181f02b7ddbb2b22604c49417.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec9408fabb2178181f02b7ddbb2b22604c49417.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 22, 2019 at 04:02:18PM +0000, Derrick, Jonathan wrote:
> On Fri, 2019-06-21 at 15:28 +0100, Lorenzo Pieralisi wrote:
> > [dropped CC stable]
> > 
> > On Tue, Jun 11, 2019 at 03:15:38PM -0600, Jon Derrick wrote:
> > > VMD config space addressing relies on mapping the BDF of the target into
> > > the VMD config bar. When using bus number offsets to number the VMD
> > > domain, the offset needs to be ignored in order to correctly map devices
> > > to their config space.
> > > 
> > > Fixes: 2a5a9c9a20f9 ("PCI: vmd: Add offset to bus numbers if necessary")
> > > Cc: <stable@vger.kernel.org> # v4.19
> > > Cc: <stable@vger.kernel.org> # v4.18
> > 
> > Hi Jon,
> > 
> > that's not how stable should be handled. You should always start
> > by fixing mainline and if there are backports to be fixed too you
> > should add patch dependencies in the CC area, see:
> > 
> > Documentation/process/stable-kernel-rules.rst
> > 
> > Never add stable to the CC list in the email header, only in the
> > commit log.
> > 
> > When your patch hits mainline it will trickle back into stable,
> > if you specified dependencies as described above there is nothing
> > to do.
> > 
> > Thanks,
> > Lorenzo
> > 
> 
> Besides the stable issue, can we get this into 5.3?

Usually we send fixes at -rc for patches that were merged in the
previous merge window; this fix is not one of those so I think
we will send it for v5.4 unless it is very urgent.

We should still update stable info in the log appropriately
before queuing it.

Thanks,
Lorenzo
