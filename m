Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2541DDA2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbhI3Pg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:36:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37989 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344459AbhI3Pgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 11:36:52 -0400
Received: (qmail 472903 invoked by uid 1000); 30 Sep 2021 11:35:09 -0400
Date:   Thu, 30 Sep 2021 11:35:09 -0400
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
Message-ID: <20210930153509.GF464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930104924-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 10:58:07AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > I don't see any point in talking about "untrusted drivers".  If a 
> > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > When you load a driver into your kernel, you are implicitly trusting 
> > it (aside from limitations imposed by security modules).
> 
> Trusting it to do what? Historically a ton of drivers did not
> validate input from devices they drive. Most still don't.

Trusting it to behave properly (i.e., not destroy your system, among 
other things).

The fact that many drivers haven't been trustworthy is beside the 
point.  By loading them into your kernel, you are trusting them 
regardless.  In the end, you may regret having done so.  :-(

Alan Stern
