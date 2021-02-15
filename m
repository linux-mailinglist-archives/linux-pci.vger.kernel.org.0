Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178B31BBB1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBOO6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 09:58:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:32291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhBOO6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 09:58:06 -0500
IronPort-SDR: XRI2YHDWqF8aa+hTcEIArE6k8iUp3SG+wtluY8jAm3/qdwpxCoak9EXLunCrifu0gOwuNPkKqG
 1O04mI+0fA8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="244178902"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="244178902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 06:56:08 -0800
IronPort-SDR: S7XowDQdxgA5uxRsT+QP62wODlyNuF97EOFONflFt9+Fd5LtAxq1kDpKR582+4G6ld0RQyNdxf
 EDBvWR9/Xu7g==
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="383396088"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 06:56:03 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 15 Feb 2021 16:56:01 +0200
Date:   Mon, 15 Feb 2021 16:56:01 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210215145601.GZ2542@lahna.fi.intel.com>
References: <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
 <20210201125523.GN2542@lahna.fi.intel.com>
 <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
 <20210204104912.GE2542@lahna.fi.intel.com>
 <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
 <20210211113941.GF2542@lahna.fi.intel.com>
 <52dd963fc697059d3db39c25eda222f4b7197761.camel@yadro.com>
 <20210212125233.GS2542@lahna.fi.intel.com>
 <460947ac479281677cdc42e69fc60dccd19dfe94.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460947ac479281677cdc42e69fc60dccd19dfe94.camel@yadro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 12, 2021 at 08:54:18PM +0000, Sergei Miroshnichenko wrote:
> On Fri, 2021-02-12 at 14:52 +0200, mika.westerberg@linux.intel.com
> wrote:
> > Hi,
> > 
> > On Thu, Feb 11, 2021 at 05:45:20PM +0000, Sergei Miroshnichenko
> > wrote:
> > > What a pity. Yes, please, I would of course like to take a look why
> > > that happened, and compare, what went wrong (before and after the
> > > hotplug: lspci -tv, dmesg -t and /proc/iomem with /proc/ioports, if
> > > it
> > > wouldn't be too much trouble).
> > 
> > I just sent these logs to you in a separate email. Let me know if you
> > need more.
> 
> Thanks, from them it's clear that the "full rescan" apprach currently
> doesn't involve the pci_bus_distribute_available_resources(), that's
> why hot-adding a second nested switch breaks: because of non-
> distributed free bus numbers. The first switch seems was hot-added just
> fine, with BARs being moved a bit.
> 
> This is to be fixed in v10, along with the
> mpt3sas+pci_dev_is_disconnected() moment Lukas had found (thanks
> Lukas!), CONFIG_DEBUG_LOCK_ALLOC macro, and a more useful debug
> messages.

Great, thanks! :)
