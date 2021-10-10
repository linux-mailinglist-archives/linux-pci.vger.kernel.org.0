Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B24427F73
	for <lists+linux-pci@lfdr.de>; Sun, 10 Oct 2021 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJJHB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Oct 2021 03:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhJJHB7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 10 Oct 2021 03:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 486AA60F9D;
        Sun, 10 Oct 2021 07:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633849201;
        bh=IwnNOrz5seXBx4GJflM5rnye6dM754sH681Dnay32OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSTWNjjGve+8OiRUv8wlP7d/V1F2p1jHm3jtCvaqzsLW2dgEwlFo3eErjMjkK1vKi
         x1OMsgif4Z/xUMI+m735yxoVcx2YPaLD1qBERjts1/wlZ1YODTANAIxp/l9sGmYGeL
         42SoFDn6IOC8dTa+T4E5W1/zDA6XNrYA9QkU0Q9pkua/3V5/2hda2NIo3Zgm5Co2C5
         eNDboSrNzmQ1DZrNmZV0li+r/CUN2KfRCZWXD0Otx7aZnieELEzReLHGA18YZ7KkMT
         JA6l4WEx9nLMpiXx3wSCpTyt8fdvFb6lslRG7mz0M1fprL5RKg/6bThXnZagD9QP6R
         R8Gy06k2MC1RA==
Date:   Sun, 10 Oct 2021 09:59:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
Message-ID: <YWKPbEu0k5RiwWYi@unreal>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-3-david.e.box@linux.intel.com>
 <YV1lTMwBSVlvadiG@unreal>
 <668f263e1d2606ad7485c40ce41933300ec4b8a3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <668f263e1d2606ad7485c40ce41933300ec4b8a3.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 01:58:22PM -0700, David E. Box wrote:
> On Wed, 2021-10-06 at 11:58 +0300, Leon Romanovsky wrote:
> > On Thu, Sep 30, 2021 at 06:28:12PM -0700, David E. Box wrote:
> > > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > > structures may also be used by Intel to indicate support for other
> > > capabilities unrelated to PMT.  The Out Of Band Management Services Module
> > > (OOBMSM) is an example of a device that can have both PMT and non-PMT
> > > capabilities. In order to support these capabilities it is necessary to
> > > modify the intel_pmt driver to handle the creation of platform devices more
> > > generically. To that end the following changes are made.
> > > 
> > > Convert the driver and child drivers from MFD to the Auxiliary Bus. This
> > > architecture is more suitable anyway since the driver partitions a
> > > multifunctional PCIe device. This also moves the driver out of the MFD
> > > subsystem and into platform/x86/intel.
> > > 
> > > Before, devices were named by their capability (e.g. pmt_telemetry).
> > > Instead, generically name them by their capability ID (e.g.
> > > intel_extended_cap.2). This allows the IDs to be created automatically,
> > > minimizing the code needed to support future capabilities. However, to
> > > ensure that unsupported devices aren't created, use an allow list to
> > > specify supported capabilities. Along these lines, rename the driver from
> > > intel_pmt to intel_extended_caps to better reflect the purpose.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > > 
> > > V1:     New patch. However incorporates some elements of [1] which was
> > >         dropped. Namely enumerating features generically and creating an
> > >         allow list. Also cleans up probe by moving some code to functions
> > >         and using a bool instead of an int to track whether a device was
> > >         added.
> > > 
> > > [1] https://lore.kernel.org/all/20210922213007.2738388-3-david.e.box@linux.intel.com/
> > 
> > <...>
> > 
> > > +static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +       struct extended_caps_platform_info *info;
> > > +       bool have_devices = false;
> > > +       unsigned long quirks = 0;
> > > +       int ret;
> > > +
> > > +       ret = pcim_enable_device(pdev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       info = (struct extended_caps_platform_info *)id->driver_data;
> > 
> > pci_get_drvdata() in all places and no need to cast void *.
> 
> This is coming from the id not the pdev. The data here is type kernel_ulong_t.

Ohh, this is very unusual.

Thanks
