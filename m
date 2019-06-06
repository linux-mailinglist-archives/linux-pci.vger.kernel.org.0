Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE6376E7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfFFOgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 10:36:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:8828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfFFOgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jun 2019 10:36:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 07:36:10 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Jun 2019 07:36:07 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Jun 2019 17:36:06 +0300
Date:   Thu, 6 Jun 2019 17:36:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power
 resources
Message-ID: <20190606143606.GN2781@lahna.fi.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-4-mika.westerberg@linux.intel.com>
 <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
 <20190606112640.GA2781@lahna.fi.intel.com>
 <20190606134419.GL2781@lahna.fi.intel.com>
 <CAJZ5v0gHTVPNc_LJzPCOLZpHU=wsbYQs__WabOQHmu8GPCChag@mail.gmail.com>
 <20190606141717.GM2781@lahna.fi.intel.com>
 <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 04:27:21PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 6, 2019 at 4:17 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, Jun 06, 2019 at 04:08:11PM +0200, Rafael J. Wysocki wrote:
> > > That isn't necessary IMO as long as the device are not accessed.  If
> > > the kernel thinks that a given device is in D3cold and doesn't access
> > > it, then it really doesn't matter too much what state the device is in
> > > physically.  On the first access the device should be reinitialized
> > > anyway.
> >
> > But if the device is configured to wake. For example when it detects a
> > hotplug that state is gone when it goes to D0unitialized.
> 
> For this we'll need a pm_runtime_resume() of the dependent device on
> the resource going "on".
> 
> That means we need a list of devices to resume when the resource goes
> "on" after being taken "off".

OK, thanks.
