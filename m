Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4AC41D8BD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbhI3L2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 07:28:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:25955 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350372AbhI3L2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 07:28:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225239604"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225239604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 04:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="618080451"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2021 04:26:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Sep 2021 14:26:32 +0300
Date:   Thu, 30 Sep 2021 14:26:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device
 properties
Message-ID: <YVWe6A3TKz5LXNNb@kuha.fi.intel.com>
References: <20210929170804.GA778424@bhelgaas>
 <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
 <YVWL3PyYRanGTlVG@kuha.fi.intel.com>
 <CAHp75Vc9hxqy=vrVfuS_cPLCVxZ=KgxZUaD=-rU9W3KH=tAX9Q@mail.gmail.com>
 <CAJZ5v0gAfWaUXjMrSf7Ei-P=0u7kzHVKQNFY0aSxs6KFd5T6ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gAfWaUXjMrSf7Ei-P=0u7kzHVKQNFY0aSxs6KFd5T6ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 12:37:27PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 30, 2021 at 12:20 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 1:06 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > On Thu, Sep 30, 2021 at 10:33:27AM +0800, Zhangfei Gao wrote:
> >
> > ...
> >
> > > If the device is really never removed, then we could also constify the
> > > node and the properties in it. Then the patch would look like this:
> >
> > I'm not sure the user can't force removal of the device (via PCI
> > rescan, for example,, or via unbind/bind cycle).
> 
> The sysfs unbind doesn't remove the device, though, AFAICS.  It just
> unbinds the driver from it, if any.
> 
> > I guess this way should be really taken carefully.
> 
> But I agree.

OK. Makes sense.

Thanks guys,

-- 
heikki
