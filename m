Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398A64C66FC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 11:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiB1KQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 05:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiB1KQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 05:16:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8AB41314;
        Mon, 28 Feb 2022 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646043372; x=1677579372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RdVqBf0tmoBquzjCb+ULXPAjKAB37SiTaf8dDfB3HEA=;
  b=ZnqqftT1VLTl0kEiJ89/W5ILwyMgVSRYcghwiuySMhmbMIWsDJLoYcQ8
   FatcxsB46CGg6qOyRqIIH7+opOn7KDK1XorA8khnBB/WzqzTkoCBl9m8j
   1inLZxTIR7GRp+2ra2S/9EhCXugRJPDWKdgmZfZorL8nEmX6j9cSHIJL/
   ahR2M0UaeSnBpv+DRylVgDvTvnJWjueti7jV3MDaFXyVp/DP48JVNg8Na
   6+lKzAFuKafnVmyd6jN22ofHIDUAxAmhBnSsrjoU/H3GirocDIMDmeXDD
   +EK6FvzX0RRnVOja0Ak+Yg0JRhSmsx9Jo33nZarMHRGvPe1rqx1gFhRdr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252778258"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="252778258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 02:16:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="492666694"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 02:16:07 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 28 Feb 2022 12:16:04 +0200
Date:   Mon, 28 Feb 2022 12:16:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        Alexander.Deucher@amd.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <Yhyg5OVL2hCkB+om@lahna>
References: <20220224215116.7138-4-mario.limonciello@amd.com>
 <20220225174224.GA366735@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225174224.GA366735@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Feb 25, 2022 at 11:42:24AM -0600, Bjorn Helgaas wrote:
> That would just leave the "PCI_VSEC_ID_INTEL_TBT implies external-facing"
> assumption above.  Not having a Thunderbolt spec, I have no idea how
> you deal with that.

You can download the spec here:

https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip

Inside the archive there is also the DVSEC spec with name "USB4 DVSEC
Version 1.0.pdf".
