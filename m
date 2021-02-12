Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811D319F3B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 13:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhBLMzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 07:55:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:3788 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhBLMyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 07:54:32 -0500
IronPort-SDR: ErcYwAn8MhNlrrjBOGbfwxlXTKeDq+isaJX8sYQpAaRrv/9Wz3tD67Tol5qBF93Ujh5mhhJVZy
 C6QWMDzUxWnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="178897944"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="178897944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 04:52:39 -0800
IronPort-SDR: treu0dKDW6JWym5l03XSUDxbLDCy5HiES1YGq6gR/SJ/EcV64Q2cfmJC7JgCgVPBoYQpxUNtP6
 +Q4mxshzW6oA==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="381432167"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 04:52:35 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 12 Feb 2021 14:52:33 +0200
Date:   Fri, 12 Feb 2021 14:52:33 +0200
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
Message-ID: <20210212125233.GS2542@lahna.fi.intel.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
 <20210201125523.GN2542@lahna.fi.intel.com>
 <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
 <20210204104912.GE2542@lahna.fi.intel.com>
 <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
 <20210211113941.GF2542@lahna.fi.intel.com>
 <52dd963fc697059d3db39c25eda222f4b7197761.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52dd963fc697059d3db39c25eda222f4b7197761.camel@yadro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Feb 11, 2021 at 05:45:20PM +0000, Sergei Miroshnichenko wrote:
> What a pity. Yes, please, I would of course like to take a look why
> that happened, and compare, what went wrong (before and after the
> hotplug: lspci -tv, dmesg -t and /proc/iomem with /proc/ioports, if it
> wouldn't be too much trouble).

I just sent these logs to you in a separate email. Let me know if you
need more.

Thanks!
