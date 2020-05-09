Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2204A1CC296
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEIQ1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 12:27:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:5161 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgEIQ1x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 12:27:53 -0400
IronPort-SDR: 0BMjxhmUQSKb8ESE3MBCkddwJaLWhTApPFlXv5iJaxx9E3mN9SfWPUQa1Kh5SgsPloumIB/a6O
 QWsVR8MUeopA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 09:27:53 -0700
IronPort-SDR: f0Ej0AgKIkycLcG4oEdN13rFi3STZwH5ch1AsRPG0Wd3PJFNjagog87PNnrpBJcEl0xcUhZIUN
 j4jG+k08EQpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,372,1583222400"; 
   d="scan'208";a="436142824"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2020 09:27:53 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0EB3C580609;
        Sat,  9 May 2020 09:27:53 -0700 (PDT)
Message-ID: <fe38263290a8731199b8f2473d341911a3cd8086.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] platform/x86: Intel PMT Telemetry capability
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Date:   Sat, 09 May 2020 09:27:52 -0700
In-Reply-To: <CAHp75VcrjFUgUe6Vo8baT969cGzE4MFX6pFL1Vr5HOun=Cm0fA@mail.gmail.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200508021844.6911-4-david.e.box@linux.intel.com>
         <CAHp75VcrjFUgUe6Vo8baT969cGzE4MFX6pFL1Vr5HOun=Cm0fA@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-05-08 at 12:57 +0300, Andy Shevchenko wrote:
> On Fri, May 8, 2020 at 5:18 AM David E. Box <
> david.e.box@linux.intel.com> wrote:
> > PMT Telemetry is a capability of the Intel Platform Monitoring
> > Technology.
> > The Telemetry capability provides access to device telemetry
> > metrics that
> > provide hardware performance data to users from continuous, memory
> > mapped,
> > read-only register spaces.
> > 
> > Register mappings are not provided by the driver. Instead, a GUID
> > is read
> > from a header for each endpoint. The GUID identifies the device and
> > is to
> > be used with an XML, provided by the vendor, to discover the
> > available set
> > of metrics and their register mapping.  This allows firmware
> > updates to
> > modify the register space without needing to update the driver
> > every time
> > with new mappings. Firmware writes a new GUID in this case to
> > specify the
> > new mapping.  Software tools with access to the associated XML file
> > can
> > then interpret the changes.
> > 
> > This module manages access to all PMT Telemetry endpoints on a
> > system,
> > regardless of the device exporting them. It creates a pmt_telemetry
> > class
> > to manage the list. For each endpoint, sysfs files provide GUID and
> > size
> > information as well as a pointer to the parent device the telemetry
> > comes
> > from. Software may discover the association between endpoints and
> > devices
> > by iterating through the list in sysfs, or by looking for the
> > existence of
> 
> ABI needs documentation.

We will be releasing a Linux software spec for PMT. We are waiting on
public release of the PMT spec. For this patch we did document the
sysfs class ABI.

> 
> > the class folder under the device of interest.  A device node of
> > the same
> > name allows software to then map the telemetry space for direct
> > access.
> 
> ...
> 
> > +config INTEL_PMT_TELEM
> 
> TELEMETRY
> 
> ...
> 
> > +obj-$(CONFIG_INTEL_PMT_TELEM)          += intel_pmt_telem.o
> 
> telemetry
> 
> (Inside the file it's fine to have telem)
> 
> ...
> 
> > +       priv->dvsec = dev_get_platdata(&pdev->dev);
> > +       if (!priv->dvsec) {
> > +               dev_err(&pdev->dev, "Platform data not found\n");
> > +               return -ENODEV;
> > +       }
> 
> I don't see how is it being used?

Good catch :). This was initially used to pass the DVSEC info from the
pci device to the telemetry driver. But with changes all of the needed
info is now read from the driver's memory resource. It was unnoticed
that dvsec  fields are no longer used. Will remove in next version.

Okay on other comments.

David

