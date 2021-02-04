Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4591530F135
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhBDKvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 05:51:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:51432 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235450AbhBDKvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 05:51:04 -0500
IronPort-SDR: LMqFP5CvGGkjlgpaT+F3LKfheCOq/oeo0VojNL3mZw55olcX9WKGCQCw5rDme5CXlRcXkoo7Uf
 tkfPdl1pKZqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="266048480"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="266048480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:49:19 -0800
IronPort-SDR: oBtOTrEBcnMDj6YM/rubfI6JeNga35laZPE0398vL9kckd2i0rv+5iWv2W0T3ZBaO95VlHjJkl
 xFOeLlB0gyFQ==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="397012491"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:49:15 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Feb 2021 12:49:12 +0200
Date:   Thu, 4 Feb 2021 12:49:12 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "lukas@wunner.de" <lukas@wunner.de>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210204104912.GE2542@lahna.fi.intel.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
 <20210201125523.GN2542@lahna.fi.intel.com>
 <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 08:17:14PM +0000, Sergei Miroshnichenko wrote:
> Hi Mika,
> 
> On Mon, 2021-02-01 at 14:55 +0200, Mika Westerberg wrote:
> > On Thu, Jan 28, 2021 at 09:39:29PM +0100, Lukas Wunner wrote:
> > > On Thu, Jan 28, 2021 at 08:53:16AM -0600, Bjorn Helgaas wrote:
> > > > On Fri, Dec 18, 2020 at 08:39:45PM +0300, Sergei Miroshnichenko
> > > > wrote:
> > > > > ...
> > > 
> > > I intended to review and test this iteration of the series more
> > > closely, but haven't been able to carve out the required time.
> > > I'm adding some Thunderbolt folks to cc in the hope that they
> > > can at least test the series on their development branch.
> > > Getting this upstreamed should really be in the best interest
> > > of Intel and other promulgators of Thunderbolt.
> > 
> > Sure. It seems that this series was submitted in December so probably
> > not applicable to the pci.git/next anymore. Anyways, I can give it a
> > try
> > on a TBT capable system if someone tells me what exactly to test ;-)
> > Probably at least that the existing functionality still works but
> > something else maybe too?
> 
> For setups that worked fine, the only expected change is a possible
> little different BAR layout (in /proc/iomem), and there should the same
> quantity (or more) of BARs assigned than before.
> 
> But if there are any problematic setups, which weren't able to arrange
> new BARs, this patchset may push a bit further.

Got it.

> In a few days I'll provide an updated branch for our mirror of the
> kernel on Github, with a complete and bumped set of patches, reducing
> the steps required to test them.

Sounds good, thanks!
