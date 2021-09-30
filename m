Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE00E41DD93
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbhI3Peb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:34:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34711 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344428AbhI3PeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 11:34:24 -0400
Received: (qmail 472797 invoked by uid 1000); 30 Sep 2021 11:32:41 -0400
Date:   Thu, 30 Sep 2021 11:32:41 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930153241.GE464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104640-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930104640-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 10:48:54AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > I don't see any point in talking about "untrusted drivers".  If a 
> > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > When you load a driver into your kernel, you are implicitly trusting 
> > it (aside from limitations imposed by security modules).  The code 
> > it contains, the module_init code in particular, runs with full 
> > superuser permissions.
> > 
> > What use is there in loading a driver but telling the kernel "I don't 
> > trust this driver, so don't allow it to probe any devices"?  Why not 
> > just blacklist it so that it never gets modprobed in the first place?
> > 
> > Alan Stern
> 
> When the driver is built-in, it seems useful to be able to block it
> without rebuilding the kernel. This is just flipping it around
> and using an allow-list for cases where you want to severly
> limit the available functionality.

Does this make sense?

The only way to tell the kernel to block a built-in driver is by 
using some boot-command-line option.  Otherwise the driver's init 
code will run before you have a chance to tell the kernel anything at 
all.

So if you change your mind about whether a driver should be blocked, 
all you have to do is remove the blocking option from the command 
line and reboot.  No kernel rebuild is necessary.

Alan Stern
