Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEB4B22E6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 11:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiBKKNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 05:13:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 05:13:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA3B38;
        Fri, 11 Feb 2022 02:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644574418; x=1676110418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zlXY5BGr3g4aDi06mZ0WehHz0ylIEs18Z4Mc6cjxans=;
  b=Z3/L49OxB4s3aTm3kENxUnr4bfeWKkFZZc8NE39sekQ1BM7Q66gSoCyY
   y6LVdD3UO8lY710cbnNqsRS8iAxC0mr6uViBYYAmrepAHaBYwHXiO7ovQ
   yPWx7OILtGerw3ebvltjR2ozR/4cFQ61Hz4z/wq1Kc9zcet6ZZ6whPvgU
   hsENWyw2SEHFvIorZIByDI0deAYId69gRSJRSnkEhFbGSjY5DgHtE4lL9
   GD+QZw2A6esdwSvQa90+rKlEF0va0MdrZj8SkFj5X0vH3N5IKemL53G5u
   0kwwNZ99tQqJ3HvEAaBEvKXXo7IltzwolEP/FORwTGHj/XYDr9l4Snnb6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274262017"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="274262017"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:13:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="483275372"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:13:34 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 12:13:31 +0200
Date:   Fri, 11 Feb 2022 12:13:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
Subject: Re: [PATCH v2 1/9] thunderbolt: move definition of
 PCI_CLASS_SERIAL_USB_USB4
Message-ID: <YgY2yzpJ1VFXY9nF@lahna>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224329.2793-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 04:43:21PM -0600, Mario Limonciello wrote:
> This PCI class definition of the USB4 device is currently located only in
> the thunderbolt driver.
> 
> It will be needed by a few other drivers for upcoming changes. Move it into
> the common include file.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
