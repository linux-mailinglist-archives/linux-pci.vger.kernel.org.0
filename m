Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F741F19D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355174AbhJAP6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 11:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:12729 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355134AbhJAP6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 11:58:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="222274169"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="222274169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:56:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="619229588"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.135.37.9]) ([10.135.37.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:56:31 -0700
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
References: <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com> <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com> <20210930105852-mutt-send-email-mst@kernel.org>
 <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
 <YVXyqBGa5Ix5MzmD@kroah.com>
 <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
 <YVaq0Hm8WHVY46xX@kroah.com> <20211001155143.GB505557@rowland.harvard.edu>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <95b0e0c1-b0a2-944d-0b57-30360ac39a35@linux.intel.com>
Date:   Fri, 1 Oct 2021 08:56:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001155143.GB505557@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Forget about trust for the moment.  Let's say the goal is to prevent
> the kernel from creating any bindings other that those in some small
> "allowed" set.  To fully specify one of the allowed bindings, you
> would have to provide both a device ID and a driver name.  But in
> practice this isn't necessary, since a device with a given ID will
> bind to only one driver in almost all cases, and hence giving just
> the device ID is enough.
>
> So to do what they want, all that's needed is to forbid any bindings
> except where the device ID is "allowed".  Or to put it another way,
> where the device's authorized flag (which can be initialized based on
> the device ID) is set.
>
> (The opposite approach, in which the drivers are "allowed" rather
> than the device IDs, apparently has already been discussed and
> rejected.  I'm not convinced that was a good decision, but...)
>
> Does this seem like a fair description of the situation?

Yes. That's roughly what the patchkit under discussion implements.


-Andi

