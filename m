Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE241EB27
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353221AbhJAKtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 06:49:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:2204 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhJAKtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 06:49:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310942535"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="310942535"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="556239341"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2021 03:47:24 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 0B4E1580970;
        Fri,  1 Oct 2021 03:47:24 -0700 (PDT)
Message-ID: <b3602f18c657765c604531430052efc62f85e83b.camel@linux.intel.com>
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Fri, 01 Oct 2021 03:47:23 -0700
In-Reply-To: <YVa13/iTdZR6xkiq@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
         <20211001012815.1999501-6-david.e.box@linux.intel.com>
         <YVa13/iTdZR6xkiq@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-10-01 at 09:16 +0200, Greg KH wrote:
> On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.  The SDSi driver provides a per socket, ioctl
> > interface for applications to perform 3 main provisioning functions:
> > 
> > 1. Provision an Authentication Key Certificate (AKC), a key written to
> >    internal NVRAM that is used to authenticate a capability specific
> >    activation payload.
> > 
> > 2. Provision a Capability Activation Payload (CAP), a token authenticated
> >    using the AKC and applied to the CPU configuration to activate a new
> >    feature.
> > 
> > 3. Read the SDSi State Certificate, containing the CPU configuration
> >    state.
> > 
> > The ioctl operations perform function specific mailbox commands that
> > forward the requests to SDSi hardware to perform authentication of the
> > payloads and enable the silicon configuration (to be made available after
> > power cycling).
> > 
> > The SDSi device itself is enumerated as an auxiliary device from the
> > intel_extended_caps driver and as such has a build dependency on
> > CONFIG_INTEL_EXTENDED_CAPS.
> > 
> > Link: https://github.com/intel/intel-sdsi
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> 
> I do not see the "required" review that Intel developers need when
> sending stuff to me.  What happened here?

Ah. You were added because of the doc change. Normally, the changes to the driver wouldn't have gone
through you. So it's just a miss on that. But it been through internal review.

David

> 
> thanks,
> 
> greg k-h


