Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4511446DAC8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhLHSPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 13:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhLHSPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 13:15:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A540C0617A2;
        Wed,  8 Dec 2021 10:12:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A8BB82069;
        Wed,  8 Dec 2021 18:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC790C341D9;
        Wed,  8 Dec 2021 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638987126;
        bh=e8b9zceWDZyhEKLbSFRbA0XMUUIgJBXDC0K5oLIxzLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTQKZO5xxxrijNZrFgOUyq3cRXaJjueatfoS5I/MlEP1u8m7gJhdGFVRf/pKVgDk6
         p5DaEZMhUL2x6w0vqtZWo/HzkkhWu16joqKDSIFu8bFBKtrO/8ZkSvo+pZMM+Pt0Zx
         Pn+93xgR2/SWcbywhR/v6AjtL4pXua0xnceuoyKc=
Date:   Wed, 8 Dec 2021 19:12:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 4/6] platform/x86: Add Intel Software Defined
 Silicon driver
Message-ID: <YbD1c1UdDd2SswC9@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-5-david.e.box@linux.intel.com>
 <YbDcPipY/SbV3Gvs@kroah.com>
 <f13b3365d5ad7b61194ade7f1baa574964cd47e2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f13b3365d5ad7b61194ade7f1baa574964cd47e2.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 09:49:36AM -0800, David E. Box wrote:
> On Wed, 2021-12-08 at 17:24 +0100, Greg KH wrote:
> > On Tue, Dec 07, 2021 at 05:50:13PM -0800, David E. Box wrote:
> > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > > activating additional silicon features. Features are enabled through a
> > > license activation process.  The SDSi driver provides a per socket, sysfs
> > > attribute interface for applications to perform 3 main provisioning
> > > functions:
> > > 
> > > 1. Provision an Authentication Key Certificate (AKC), a key written to
> > >    internal NVRAM that is used to authenticate a capability specific
> > >    activation payload.
> > > 
> > > 2. Provision a Capability Activation Payload (CAP), a token authenticated
> > >    using the AKC and applied to the CPU configuration to activate a new
> > >    feature.
> > > 
> > > 3. Read the SDSi State Certificate, containing the CPU configuration
> > >    state.
> > > 
> > > The operations perform function specific mailbox commands that forward the
> > > requests to SDSi hardware to perform authentication of the payloads and
> > > enable the silicon configuration (to be made available after power
> > > cycling).
> > > 
> > > The SDSi device itself is enumerated as an auxiliary device from the
> > > intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> > > 
> > > Link: https://github.com/intel/intel-sdsi
> > 
> > There is no code at this link :(
> > 
> 
> Not yet. It's currently just documentation. But sample code was added to this patch series.

Is the sample code "real" and what you are going to use for this api?

thanks,

greg k-h
