Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9046DABD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhLHSOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbhLHSOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 13:14:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B3C0617A1;
        Wed,  8 Dec 2021 10:11:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B25F6CE0DB2;
        Wed,  8 Dec 2021 18:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C276C00446;
        Wed,  8 Dec 2021 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638987065;
        bh=QgoV6e2aIQSqvk2euUblMWbPunbhbGpBkvr/HHcx56A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uA89KPR1ogEE99hrjD3ngclawVcaGHlrPZhYAKw4AD2cO9i0cfhya3+X9S9OYkriE
         kECO59hDzBBV+JfBUBvPRQ8aHWwfHdm4sDz5doc1GCbloR2NyEJ5PGT6QoHlgV51ml
         gPNx7M92n6GT7KM/zuGWJbHuKNlwreaNrMG1DIC8=
Date:   Wed, 8 Dec 2021 19:11:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
Message-ID: <YbD1NsYHbU8FvtTN@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
 <YbDbql39x7Kw6iAC@kroah.com>
 <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > > +static struct pci_driver intel_vsec_pci_driver = {
> > > +       .name = "intel_vsec",
> > > +       .id_table = intel_vsec_pci_ids,
> > > +       .probe = intel_vsec_pci_probe,
> > > +};
> > 
> > So when the PCI device is removed from the system you leak resources and
> > have dangling devices?
> 
> No.
> 
> > 
> > Why no PCI remove driver callback?
> 
> After probe all resources are device managed. There's nothing to explicitly clean up. When the PCI
> device is removed, all aux devices are automatically removed. This is the case for the SDSi driver
> as well.

Where is the "automatic cleanup" happening?  As this pci driver is bound
to the PCI device, when the device is removed, what is called in this
driver to remove the resources allocated in the probe callback?

confused,

greg k-h
