Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859C346DAC5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhLHSPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 13:15:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:46997 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238661AbhLHSPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 13:15:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="217920999"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="217920999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="606388523"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2021 10:12:00 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id ECAF4580D37;
        Wed,  8 Dec 2021 10:11:59 -0800 (PST)
Message-ID: <329dcd18b7b92f24f3ded0396ffc66ad17e65885.camel@linux.intel.com>
Subject: Re: [PATCH RESEND V2 4/6] platform/x86: Add Intel Software Defined
 Silicon driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Wed, 08 Dec 2021 10:11:59 -0800
In-Reply-To: <YbDdc3VVI/YgqWxT@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-5-david.e.box@linux.intel.com>
         <YbDdc3VVI/YgqWxT@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-12-08 at 17:29 +0100, Greg KH wrote:
> On Tue, Dec 07, 2021 at 05:50:13PM -0800, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.  The SDSi driver provides a per socket, sysfs
> > attribute interface for applications to perform 3 main provisioning
> > functions:
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
> > The operations perform function specific mailbox commands that forward the
> > requests to SDSi hardware to perform authentication of the payloads and
> > enable the silicon configuration (to be made available after power
> > cycling).
> > 
> > The SDSi device itself is enumerated as an auxiliary device from the
> > intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> > 
> > Link: https://github.com/intel/intel-sdsi
> 
> Also, why not put the documentation that you have currently at that link
> in this commit in the driver itself?  That would make it much more
> self-contained and live longer than some random external web link that
> could go away at any moment.

The documentation describes the hardware interface only. It's not OS specific so it was easier to
add a link. But there's no problem adding a copy to Documentaion in the kernel.

David
> 
> thanks,
> 
> greg k-h


