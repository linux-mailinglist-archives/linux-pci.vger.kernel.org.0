Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54690DA38
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 02:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfD2AgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Apr 2019 20:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfD2AgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 20:36:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E052720675;
        Mon, 29 Apr 2019 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556498180;
        bh=lJoznh71DxyTrORc6sBQL+wEIai6vdomCwoJiWYbiDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCxqiVv4N/0OIGe+uhPAJZbxwI6KYlH41uyxwTmn4ky1qm/dceMGumgeNcumAtl5q
         3DKUKxfzfjw+w4X7eSlGuArFuN7D98ZTnGo69NDpLo9iYNc0YskXsmYQRKmBD6tDS8
         3Cc6idvcYc9Z2rXCrIWAu8kG3OockHSw37RTppVQ=
Date:   Sun, 28 Apr 2019 19:36:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     fred@fredlawl.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 2/4] PCI: pciehp: Replace ctrl_*() with pci_*()
Message-ID: <20190429003618.GN14616@google.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-3-fred@fredlawl.com>
 <20190427200301.tujp2535jxmlqttr@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427200301.tujp2535jxmlqttr@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 10:03:01PM +0200, Lukas Wunner wrote:
> On Sat, Apr 27, 2019 at 02:13:02PM -0500, fred@fredlawl.com wrote:
> > Hotplug useses custom ctrl_*() dev_*() printk wrappers for logging
> > messages. To make hotplug conform to pci logging, replace uses of these
> > wrappers with pci_*() printk wrappers. In addition, replace any
> > printk() calls with pr_*() wrappers.
> 
> A lot of pciehp's messages are preceded by "Slot(%s): ", where %s is
> replaced by the Physical Slot Number in the Slot Capabilities register
> (which is cached in struct controller) plus an optional suffix if the
> same PSN is used by multiple slots.  For some reason (probably a
> historic artefact), this prefix is included only in *some* of the
> messages.
> 
> I think it would be useful to make the messages consistent by *always*
> including the "Slot(%s): " prefix.  However the prefix is unknown until
> pci_hp_initialize() has been called.  I'd solve this by keeping the
> ctrl_*() wrappers and amending them to print the "Slot(%s): " prefix,
> then making sure that ctrl_*() is not called before pci_hp_initialize().
> (pci_*() has to be used instead).

I was hoping to get rid of the ctrl_*() wrappers completely, but the
"Slot(%s)" prefix is actually a pretty good reason to keep them.

Moving the prefix from the call site to the ctrl_*() wrappers should be a
separate patch that doesn't change the output at all (except maybe
adding the prefix to messages that don't currently include it).

So you probably need three steps (each in a separate patch):

  1) Convert ctrl_*() to use pci_dev instead of pcie_device, something
     like this:

        + #define pr_fmt(fmt) "pciehp: " fmt
	+ #define dev_fmt pr_fmt

	  #define ctrl_info(ctrl, format, arg...) \
	-   dev_info(&ctrl->pcie->device, format, ## arg)
	+   pci_info(&ctrl->pcie->port, format, ## arg)

  2) Convert any output before pci_hp_initialize() from ctrl_*() to
     pci_*().

  3) Centralize the "Slot(%s): " prefix, something like this:

	  #define ctrl_info(ctrl, format, arg...) \
	-   pci_info(&ctrl->pcie->port, format, ## arg)
	+   pci_info(&ctrl->pcie->port, "Slot(%s): " format, slot_name(ctrl), ## arg)

	- ctrl_info(ctrl, "Slot(%s): ...", slot_name(ctrl));
	+ ctrl_info(ctrl, "...");

