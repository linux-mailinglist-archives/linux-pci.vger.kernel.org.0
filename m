Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEC46DA90
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhLHR7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:59:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:12332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238383AbhLHR7U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 12:59:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224760916"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="224760916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="516315114"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2021 09:49:36 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 43C68580D37;
        Wed,  8 Dec 2021 09:49:36 -0800 (PST)
Message-ID: <f13b3365d5ad7b61194ade7f1baa574964cd47e2.camel@linux.intel.com>
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
Date:   Wed, 08 Dec 2021 09:49:36 -0800
In-Reply-To: <YbDcPipY/SbV3Gvs@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-5-david.e.box@linux.intel.com>
         <YbDcPipY/SbV3Gvs@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-12-08 at 17:24 +0100, Greg KH wrote:
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
> There is no code at this link :(
> 

Not yet. It's currently just documentation. But sample code was added to this patch series.

