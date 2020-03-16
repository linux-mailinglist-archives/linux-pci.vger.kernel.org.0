Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B164518728C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 19:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbgCPSmC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 14:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbgCPSmC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 14:42:02 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E924120679;
        Mon, 16 Mar 2020 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584384122;
        bh=9zgR6W57OkZGBXo8pnBKj0EPmOhDkKcU2mi9V83DSys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SJH/L5WN1dNAYybNtS1HyQ4F2FG7dVWS6tFWhGpTdJXp3OPqAnzFchrAqAkaZT8Z
         E6S9xH3kbt8DoxBs+qU/HXbd6p76+YHVThfWT58yFjHadDUsnCDiR4yz2Oeai5Tk5z
         QYmGu/slKTzECi5ynDMiLjoOvHqeWoBPzj2XkXc0=
Date:   Mon, 16 Mar 2020 11:42:00 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Hoyer, David" <David.Hoyer@netapp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200316184200.GA1089414@dhcp-10-100-145-180.wdl.wdc.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316161543.GB1069861@dhcp-10-100-145-180.wdl.wdc.com>
 <20200316181058.pidouiqrempa6qnq@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316181058.pidouiqrempa6qnq@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 16, 2020 at 07:10:58PM +0100, Lukas Wunner wrote:
> On Mon, Mar 16, 2020 at 09:15:43AM -0700, Keith Busch wrote:
> > I'm not sure why the hard-irq context is even setting the thread running
> > flag while it can still exit without handling anything. Shouldn't it leave
> > the flag cleared until knows it's actually going to do something?
> 
> No, ist_running must be set to true before the invocation of
> atomic_xchg(&ctrl->pending_events, 0).

Okay, I see what you mean.

Even with David's patch, there's still another condition that could exit
with ist_running set. It may make sense to move the setting just above
the atomic_xchg() so that clearing it doesn't need to be duplicated for
the remaining uncommon exit case.
 
> There's a time window between the atomic_xchg() and actually
> turning off the slot when pending_events is 0.  Previously we
> only checked in the sysfs functions that pending_events is 0.
> That was insufficient as we risked returning prematurely from
> the sysfs functions.  The point of ist_running is to prevent
> that.

Oh, right, I'm remembering now. And since we've a polled option for
pciehp, using synchronize_irq() from the sysfs path isn't possible.
