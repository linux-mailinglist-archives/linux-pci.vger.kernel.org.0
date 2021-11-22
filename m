Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6237C459094
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhKVOyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 09:54:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:50520 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239546AbhKVOyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 09:54:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="222018899"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="222018899"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 06:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="649471384"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2021 06:51:38 -0800
Received: from malshaye-mobl.amr.corp.intel.com (malshaye-mobl.amr.corp.intel.com [10.212.153.61])
        by linux.intel.com (Postfix) with ESMTP id EB53E5807C8;
        Mon, 22 Nov 2021 06:51:37 -0800 (PST)
Message-ID: <7ba2c0c40b3abeecdef0eacb46d957aaa2fd24bf.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Mon, 22 Nov 2021 06:51:37 -0800
In-Reply-To: <YZs28g87GE3XgAKk@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
         <20211120231705.189969-5-david.e.box@linux.intel.com>
         <YZo8HUxx8LNgOMeK@kroah.com>
         <4d8ba355de09a4a806b6075305ca8d7156dc70ef.camel@linux.intel.com>
         <YZs28g87GE3XgAKk@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-11-22 at 07:21 +0100, Greg KH wrote:
> On Sun, Nov 21, 2021 at 09:18:25AM -0800, David E. Box wrote:
> > > These sysfs attributes are crazy.  Who has audited them to be correct
> > > and work properly? It feels like there are just buffer overflows
> > > waiting to be exploited in them due to the reading/writing of raw memory
> > > buffers all over the place.
> > 
> > Agree with the concern. I can submit the tests that were used. Is selftests
> > the
> > best place?
> 
> Yes.
> 
> > > Where is the userspace tool that uses these files?
> > 
> > The tool will be published in the same github repo as the spec once the
> > driver
> > is ready.
> 
> Isn't the driver "ready" if you are asking for it to be accepted
> here?  Why isn't it published already so we can see if it actually is
> tested?

It will be required for the tests anyway, so I'll submit it with them.

Thanks.

David

