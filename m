Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101EBDA0C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfD2ANF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Apr 2019 20:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfD2ANE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 20:13:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B4620656;
        Mon, 29 Apr 2019 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556496784;
        bh=L2+bIFhyUyXEKeySvVDtwgKi1rnek5ZeXux4GIq/ypo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBPVblIFr1DBbpkttXqoZxh3FAY41fKbQKTgr/duEw9xUW6TPpYlLlhbi3HXowsWx
         eK01orZEEjyR0frhbkpVR2N25hh0sX8sHB7kFZcbC9KgDkwbzn0+v+hUfsP9+MKeUI
         XNrKSIopDocSTVMrYQBqwqoCL8DwWy5B2TT/a0k4=
Date:   Sun, 28 Apr 2019 19:13:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     fred@fredlawl.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 3/4] PCI: pciehp: Remove unused macro definitions
Message-ID: <20190429001302.GL14616@google.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-4-fred@fredlawl.com>
 <20190428155536.GU9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428155536.GU9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 28, 2019 at 06:55:36PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 27, 2019 at 02:13:03PM -0500, fred@fredlawl.com wrote:
> > Now that all uses for the ctrl_*() printk wrappers are removed from
> > files and replaces with pci_*() or pr_*() printk wrappers, remove the
> > unused macro definitions. In addition to that, remove the MY_NAME macro.
> 
> >  extern bool pciehp_debug;
> 
> How it's used after all?
> 
> > -#define dbg(format, arg...)						\
> > -do {									\
> > -	if (pciehp_debug)						\
> > -		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
> > -} while (0)
> 
> > -#define ctrl_dbg(ctrl, format, arg...)					\
> > -	do {								\
> > -		if (pciehp_debug)					\
> > -			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
> > -					format, ## arg);		\
> > -	} while (0)
> 
> Besides ruining the pciehp_debug support this will make unequivalent behaviour.

I'm not super attached to pciehp_debug.  But perhaps pciehp is one
place where it would make sense to use pci_dbg().

There are a lot of uses of ctrl_dbg() and some of them look like
they're too low-level to just convert to pci_info(), e.g., info about
every command we write to the controller.  We probably don't need all
that info all the time.

But if we want to keep it, maybe we could convert it to use pci_dbg()
and the dynamic debug stuff.  I'm pretty sure the dyndbg syntax is
complicated enough to enable pciehp logging specifically.  Then we
could use that instead of the pciehp-specific module parameter.

Bjorn
