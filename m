Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F199189B5C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 12:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRLx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 07:53:58 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:45017 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRLx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 07:53:58 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 47A623000223E;
        Wed, 18 Mar 2020 12:53:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1C3B819A1; Wed, 18 Mar 2020 12:53:56 +0100 (CET)
Date:   Wed, 18 Mar 2020 12:53:56 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Hoyer, David" <David.Hoyer@netapp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200318115356.fttkptdsthjmgye3@wunner.de>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316161543.GB1069861@dhcp-10-100-145-180.wdl.wdc.com>
 <20200316181058.pidouiqrempa6qnq@wunner.de>
 <20200316184200.GA1089414@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316184200.GA1089414@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 16, 2020 at 11:42:00AM -0700, Keith Busch wrote:
> On Mon, Mar 16, 2020 at 07:10:58PM +0100, Lukas Wunner wrote:
> > On Mon, Mar 16, 2020 at 09:15:43AM -0700, Keith Busch wrote:
> > > I'm not sure why the hard-irq context is even setting the thread running
> > > flag while it can still exit without handling anything. Shouldn't it
> > > leave the flag cleared until knows it's actually going to do something?
> > 
> > No, ist_running must be set to true before the invocation of
> > atomic_xchg(&ctrl->pending_events, 0).
> 
> Okay, I see what you mean.
> 
> Even with David's patch, there's still another condition that could exit
> with ist_running set. It may make sense to move the setting just above
> the atomic_xchg() so that clearing it doesn't need to be duplicated for
> the remaining uncommon exit case.

Right, or introduce a goto label before the teardown code at the end of
pciehp_ist() and replace the return statements with gotos.  I've compared
both approaches and the goto solution required the least lines of code
and subjectively looked the nicest, so I went with that.


> > There's a time window between the atomic_xchg() and actually
> > turning off the slot when pending_events is 0.  Previously we
> > only checked in the sysfs functions that pending_events is 0.
> > That was insufficient as we risked returning prematurely from
> > the sysfs functions.  The point of ist_running is to prevent
> > that.
> 
> Oh, right, I'm remembering now. And since we've a polled option for
> pciehp, using synchronize_irq() from the sysfs path isn't possible.

Precisely. :-)

Thanks,

Lukas
