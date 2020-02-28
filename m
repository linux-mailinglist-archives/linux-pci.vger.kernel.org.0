Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26F172EC1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgB1CS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 21:18:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:64154 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgB1CS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 21:18:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 18:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="437264890"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2020 18:18:55 -0800
Date:   Thu, 27 Feb 2020 18:18:55 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Spassov, Stanislav" <stanspas@amazon.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Message-ID: <20200228021855.GA57330@otc-nc-03>
References: <20200227214534.GA143139@google.com>
 <e162efcd-70fd-3390-2452-4915af1c9171@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e162efcd-70fd-3390-2452-4915af1c9171@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 06:44:56PM -0500, Sinan Kaya wrote:
> On 2/27/2020 4:45 PM, Bjorn Helgaas wrote:
> > The 60 second timeout came from 821cdad5c46c ("PCI: Wait up to 60
> > seconds for device to become ready after FLR") and is probably too
> > long.  We probably should pick a smaller value based on numbers from
> > the spec and make quirks for devices that needed more time.
> 
> If I remember right, there was no time mention about how long to
> wait. Spec says device should send CRS as long as it is not ready.

Not exactly.. there are some requirements to follow for rules after
a conventional reset. 

Look for "The second set of rules addresses requirements placed on the system"

i'm looking a the 5.0 spec (around page 553) :-). 

In general 1s seems good enough for most cases. For ports that support
> 5gt/s transfer speed, it says 100ms after link training completes.
I'm not sure if this means 100ms after getting a DLLSC event?
