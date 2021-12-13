Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECB4733DA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhLMSTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 13:19:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:52872 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235946AbhLMST3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 13:19:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325066715"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325066715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="603788359"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2021 10:19:27 -0800
Received: from arubio1-mobl.amr.corp.intel.com (unknown [10.212.243.203])
        by linux.intel.com (Postfix) with ESMTP id E543F580A85;
        Mon, 13 Dec 2021 10:19:26 -0800 (PST)
Message-ID: <9c24a8f5b3d1c692fcecadcb1deec93d2018cc15.camel@linux.intel.com>
Subject: Re: [PATCH V3 2/6] driver core: auxiliary bus: Add driver data
 helpers
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 13 Dec 2021 10:19:26 -0800
In-Reply-To: <YbeLLpu80EIQY3R5@smile.fi.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
         <20211213175921.1897860-3-david.e.box@linux.intel.com>
         <YbeLLpu80EIQY3R5@smile.fi.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-12-13 at 20:04 +0200, Andy Shevchenko wrote:
> On Mon, Dec 13, 2021 at 09:59:17AM -0800, David E. Box wrote:
> > Adds get/set driver data helpers for auxiliary devices.
> 
> I though I gave you a tag... Hint: use `b4 am ...` against previous version
> and
> you won't lose the individual tags.

Sorry I did drop it. Thanks for the tip.

David

> 
> Anyway,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Mark Gross <markgross@kernel.org>
> > ---
> > V3
> >   - No changes
> > V2
> >   - No changes
> > 
> >  include/linux/auxiliary_bus.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> > index fc51d45f106b..a8338d456e81 100644
> > --- a/include/linux/auxiliary_bus.h
> > +++ b/include/linux/auxiliary_bus.h
> > @@ -28,6 +28,16 @@ struct auxiliary_driver {
> >  	const struct auxiliary_device_id *id_table;
> >  };
> >  
> > +static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
> > +{
> > +	return dev_get_drvdata(&auxdev->dev);
> > +}
> > +
> > +static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev,
> > void *data)
> > +{
> > +	dev_set_drvdata(&auxdev->dev, data);
> > +}
> > +
> >  static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
> >  {
> >  	return container_of(dev, struct auxiliary_device, dev);
> > -- 
> > 2.25.1
> > 

