Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34A41E019
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhI3RZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 13:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhI3RZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 13:25:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AB20613A0;
        Thu, 30 Sep 2021 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633022635;
        bh=5tePxdCWKV6n9abPoiedDR+S/Q6cb3pBjIOwiHhDGUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgXtKWuOlomRjLMXskRL9wb0BnYsyELUL6upXwxZ0TfFVCT89Jt9Y5Q72o+qxmEEO
         GBflVXV4mLsttSTo8bjOuUBHG5ZxGnlXFDM/TnEmlw6kWmVaZqyFyZbvtQVOzir9SG
         NPfh8I8VF2F9QcuitqSzdMgMtz3j61QxifmcEbyo=
Date:   Thu, 30 Sep 2021 19:23:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <YVXyqBGa5Ix5MzmD@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org>
 <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 10:17:09AM -0700, Andi Kleen wrote:
> 
> > > The "it" that I referred to is the claim that no driver should be
> > > touching hardware in their module init call. Andi seems to think
> > > such drivers are worth working around with a special remap API.
> > Andi is wrong.
> 
> While overall it's a small percentage of the total, there are still quite a
> few drivers that do touch hardware in init functions. Sometimes for good
> reasons -- they need to do some extra probing to discover something that is
> not enumerated -- sometimes just because it's very old legacy code that
> predates the modern driver model.

Are any of them in the kernel today?

PCI drivers should not be messing with this, we have had well over a
decade to fix that up.

> The legacy drivers could be fixed, but nobody really wants to touch them
> anymore and they're impossible to test.

Pointers to them?

> The drivers that probe something that is not enumerated in a standard way
> have no choice, it cannot be implemented in a different way.

PCI devices are not enumerated in a standard way???

> So instead we're using a "firewall" the prevents these drivers from doing
> bad things by not allowing ioremap access unless opted in, and also do some
> filtering on the IO ports The device filter is still the primary mechanism,
> the ioremap filtering is just belts and suspenders for those odd cases.

That's horrible, don't try to protect the kernel from itself.  Just fix
the drivers.

If you point me at them, I will be glad to have a look and throw some
interns on them.

But really, you all could have fixed them up by now if Intel really
cared about it :(

> If you want we can send an exact list, we did some analysis using a patched
> smatch tool.

Please do.

thanks,

greg k-h
