Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7332286346
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgJGQKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 12:10:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:53238 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGQKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 12:10:44 -0400
IronPort-SDR: OVTLi5NkDmwBnU4+Nw/RXCt6NW2zm1qWLZyufihpN1nRF6rPNcSi2UqMnvfOvlYljEDXFX9yC6
 +cNVs55vLCVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="164232811"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="164232811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:10:42 -0700
IronPort-SDR: GinqcRlHCJ3bDcOfowgcd6oxwxJCVkK26VAmTdBZcwyPGr8L+Ghw7mGxUC5UN+R3lL0iepQI+w
 2IbyxqZ3+Y5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="518897146"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 07 Oct 2020 09:10:41 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 6A1ED580641;
        Wed,  7 Oct 2020 09:10:41 -0700 (PDT)
Message-ID: <09930d0783d6a5f17f9af872b4fc7a244c6dc5e1.camel@linux.intel.com>
Subject: Re: [PATCH V8 2/5] mfd: Intel Platform Monitoring Technology support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        hdegoede@redhat.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 07 Oct 2020 09:10:41 -0700
In-Reply-To: <20201007065751.GA1763265@dell>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
         <20201003013123.20269-3-david.e.box@linux.intel.com>
         <20201007065751.GA1763265@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-10-07 at 07:57 +0100, Lee Jones wrote:
> On Fri, 02 Oct 2020, David E. Box wrote:
> 
> > Intel Platform Monitoring Technology (PMT) is an architecture for
> > enumerating and accessing hardware monitoring facilities. PMT
> > supports
> > multiple types of monitoring capabilities. This driver creates
> > platform
> > devices for each type so that they may be managed by capability
> > specific
> > drivers (to be introduced). Capabilities are discovered using PCIe
> > DVSEC
> > ids. Support is included for the 3 current capability types,
> > Telemetry,
> > Watcher, and Crashlog. The features are available on new Intel
> > platforms
> > starting from Tiger Lake for which support is added. This patch
> > adds
> > support for Tiger Lake (TGL), Alder Lake (ADL), and Out-of-Band
> > Management
> > Services Module (OOBMSM).
> > 
> > Also add a quirk mechanism for several early hardware differences
> > and bugs.
> > For Tiger Lake and Alder Lake, do not support Watcher and Crashlog
> > capabilities since they will not be compatible with future product.
> > Also,
> > fix use a quirk to fix the discovery table offset.
> > 
> > Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com
> > >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  MAINTAINERS             |   5 +
> >  drivers/mfd/Kconfig     |  10 ++
> >  drivers/mfd/Makefile    |   1 +
> >  drivers/mfd/intel_pmt.c | 226
> > ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 drivers/mfd/intel_pmt.c
> 
> I Acked this back in August.
> 
> Any reason why you didn't carry it forward?

So that you could review changes made after the Ack. You did and you
requested fixups which were made. Please let me know if this is not
preferred. Thanks.

David

