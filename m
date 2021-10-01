Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379A141EBE3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353682AbhJAL3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 07:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353446AbhJAL3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 07:29:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A9260EBD;
        Fri,  1 Oct 2021 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633087646;
        bh=E7r1eiQ0HBFn/jhrP3KhoHUhfNqAnpJuoIRZVS0G/gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbNh6hM5NMjiYwKqinX9vOQz9UXePFu3Gkhn/hdI9nSIOlPpe9hcY3uL+cTT7aluL
         hN+abhQF1RUKH5rhVick+VZAmeT8g/02i5JsZJ9h/hkjDolq0UESQdDRW0LhTMZ2go
         zVb7UUSmYmzWHH0IIs4YwRZFY/FYFWcp9c4eCBNY=
Date:   Fri, 1 Oct 2021 13:27:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVbwmxTVE9dRqB3r@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
 <YVa13/iTdZR6xkiq@kroah.com>
 <b3602f18c657765c604531430052efc62f85e83b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3602f18c657765c604531430052efc62f85e83b.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 03:47:23AM -0700, David E. Box wrote:
> On Fri, 2021-10-01 at 09:16 +0200, Greg KH wrote:
> > On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > > activating additional silicon features. Features are enabled through a
> > > license activation process.  The SDSi driver provides a per socket, ioctl
> > > interface for applications to perform 3 main provisioning functions:
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
> > > The ioctl operations perform function specific mailbox commands that
> > > forward the requests to SDSi hardware to perform authentication of the
> > > payloads and enable the silicon configuration (to be made available after
> > > power cycling).
> > > 
> > > The SDSi device itself is enumerated as an auxiliary device from the
> > > intel_extended_caps driver and as such has a build dependency on
> > > CONFIG_INTEL_EXTENDED_CAPS.
> > > 
> > > Link: https://github.com/intel/intel-sdsi
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > 
> > I do not see the "required" review that Intel developers need when
> > sending stuff to me.  What happened here?
> 
> Ah. You were added because of the doc change. Normally, the changes to the driver wouldn't have gone
> through you. So it's just a miss on that. But it been through internal review.

Then where is the "reviewed-by:" line that shows this happened?
