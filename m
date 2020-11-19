Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9407B2B9B9A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgKSTir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 14:38:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:38104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgKSTir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 14:38:47 -0500
IronPort-SDR: m0d7amhQrCoDeZh271UUrBO0RWmXGKDYgBWzc55dwnsIMZC/6UGp1ZX1ZA+L5r3DRxq6yPVbXw
 fy4GZX5piCQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="256060267"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="256060267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 11:38:46 -0800
IronPort-SDR: CXrhoX2v01D3qh5wB1x2MMFrFdSYy6I/H1BFJpcUrVZVDrQC4uePhBAjCIFOKTq4DWfpuJxpFZ
 qbCEX26Msz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="311743140"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2020 11:38:46 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id A0F9E580409;
        Thu, 19 Nov 2020 11:38:46 -0800 (PST)
Message-ID: <2bf771085821fe8c4ea920b6fdb318c09cc3615c.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: Disable Precision Time Measurement during
 suspend
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Nov 2020 11:38:46 -0800
In-Reply-To: <CAJZ5v0gyzYEiFWC4qvQZNDUC4wwcXK60mR=zJ9=Bwb27K1F=Ng@mail.gmail.com>
References: <20201119001822.31617-1-david.e.box@linux.intel.com>
         <20201119001822.31617-2-david.e.box@linux.intel.com>
         <CAJZ5v0hGhyPySUdabwW5_LhyAKC3A4zdgj7H=55R=Xk3jvt3Yw@mail.gmail.com>
         <cdb520abba97ccf083788ed8ccb44fc042939468.camel@linux.intel.com>
         <CAJZ5v0gyzYEiFWC4qvQZNDUC4wwcXK60mR=zJ9=Bwb27K1F=Ng@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-11-19 at 19:13 +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 19, 2020 at 6:45 PM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > On Thu, 2020-11-19 at 13:01 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 19, 2020 at 1:17 AM David E. Box
> > > <david.e.box@linux.intel.com> wrote:

...

> > > > 
> > > > +        */
> > > > +       if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
> > > 
> > > AFAICS the target sleep state doesn't matter here, so I'd skip
> > > the
> > > check above, but otherwise it LGTM.
> > 
> > The target sleep state doesn't matter so much but that it's
> > suspending
> > does. pci_save_state() is called during probe for the root ports
> > (and
> > many other pci devices - I'm curious as to why).
> 
> I tend to forget about this, sorry.
> 
> > So without this check the capability gets disabled on boot.
> > 
> 
> So instead of calling this from here, why don't we invoke the code
> below from pci_prepare_to_sleep() and pci_finish_runtime_suspend(),
> before enabling wakeup (and it needs to be re-done on failures, eg.
> by
> restoring the cap from the saved copy)?

Ok.

