Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3341E2C6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhI3Uqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 16:46:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51569 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229929AbhI3Uqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 16:46:31 -0400
Received: (qmail 483354 invoked by uid 1000); 30 Sep 2021 16:44:47 -0400
Date:   Thu, 30 Sep 2021 16:44:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20210930204447.GA482974@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
 <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 12:23:36PM -0700, Andi Kleen wrote:
> 
> > I don't think the current mitigations under discussion here are about
> > keeping the system working. In fact most encrypted VM configs tend to
> > stop booting as a preferred way to handle security issues.
> 
> Maybe we should avoid the "trusted" term here. We're only really using it
> because USB is using it and we're now using a common framework like Greg
> requested. But I don't think it's the right way to think about it.
> 
> We usually call the drivers "hardened". The requirement for a hardened
> driver is that all interactions through MMIO/port/config space IO/MSRs are
> sanitized and do not cause memory safety issues or other information leaks.
> Other than that there is no requirement on the functionality. In particular
> DOS is ok since a malicious hypervisor can decide to not run the guest at
> any time anyways.
> 
> Someone loading an malicious driver inside the guest would be out of scope.
> If an attacker can do that inside the guest you already violated the
> security mechanisms and there are likely easier ways to take over the guest
> or leak data.
> 
> The goal of the device filter mechanism is to prevent loading unhardened
> drivers that could be exploited without them being themselves malicious.

If all you want to do is prevent someone from loading a bunch of 
drivers that you have identified as unhardened, why not just use a 
modprobe blacklist?  Am I missing something?

Alan Stern
