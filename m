Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E91C5A23
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgEEOzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 10:55:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:15926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgEEOzN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 10:55:13 -0400
IronPort-SDR: q0OzYQ6AhGRdU+7qih6XKW0VWGDu7GmjffiH+RicukiofPQlB286SXeAS/I0eWHWfanzxL7tP4
 LoWytvZVPYUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 07:55:11 -0700
IronPort-SDR: cdkoVR4zO3IfN7UEXcWHPg+dN81PKHeHv/O8xvNLRn9HPZrU/M65dJuUs6rdXm5Byi6XFHk+/i
 hbjclvgPEujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="434513771"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2020 07:55:11 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 2185758048A;
        Tue,  5 May 2020 07:55:11 -0700 (PDT)
Message-ID: <43976043c0689c985f97dc782d40f2c330a02b7a.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] mfd: Intel Platform Monitoring Technology support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Randy Dunlap <rdunlap@infradead.org>, bhelgaas@google.com,
        andy@infradead.org, alexander.h.duyck@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date:   Tue, 05 May 2020 07:55:11 -0700
In-Reply-To: <531eb6c8-7403-5380-af40-dca229467e6e@infradead.org>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200505023149.11630-1-david.e.box@linux.intel.com>
         <531eb6c8-7403-5380-af40-dca229467e6e@infradead.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-05-04 at 19:53 -0700, Randy Dunlap wrote:
> On 5/4/20 7:31 PM, David E. Box wrote:
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 0a59249198d3..c673031acdf1 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -632,6 +632,16 @@ config MFD_INTEL_MSIC
> >  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
> >  	  devices used in Intel Medfield platforms.
> >  
> > +config MFD_INTEL_PMT
> > +	tristate "Intel Platform Monitoring Technology support"
> > +	depends on PCI
> > +	select MFD_CORE
> > +	help
> > +	  The Intel Platform Monitoring Technology (PMT) is an
> > interface that
> > +	  provides access to hardware monitor registers. This driver
> > supports
> > +	  Telemetry, Watcher, and Crashlog PTM capabilities/devices for
> 
> What is PTM?

s/PTM/PMT

I have the fortune of working on another project involving PCI
Precision Time Management.

