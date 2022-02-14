Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A94B42CC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbiBNH12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 02:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiBNH10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 02:27:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6405C0F;
        Sun, 13 Feb 2022 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644823639; x=1676359639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3D+QYO7Pwm9FAUWke5CmBKJRJaBzCTD4KK+GctzE02M=;
  b=mnTEk/O6X6ThBSsJfhMrQKGC3ajGqRmoJHPt0jdXy8ooWySswPasiDhN
   PP0J685V2B0Mw13MqvqNtyp2NtRsRL/k215m8LqutEJw133GM0h2AG9tI
   LgTVZ7IMsAaFJPoKrbadHOK/mXr2PrILDymSNFhLotRsQJJujQEqE0r5p
   VWhj9wg4WlG2ipc6DSualXyVcvf6Lex65x1u2FFWl3AiPHruLNUSkqRfp
   deh5K+JCiByoSt6VlrpUJGPzdYz2bQ963ozuZdPbcz2RPKpJFhLTizKAa
   r4xnw8ocA3juN9T/NObJeatBAP3TekpEpsZaFsj7Nkg8P/czihzmAQ9wg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313312832"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="313312832"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:27:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="634979853"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:27:15 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 09:27:13 +0200
Date:   Mon, 14 Feb 2022 09:27:13 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 04/12] PCI: Drop the `is_thunderbolt` attribute from
 PCI core
Message-ID: <YgoEUYLbYUbk5A6Q@lahna>
References: <20220211193250.1904843-1-mario.limonciello@amd.com>
 <20220211193250.1904843-5-mario.limonciello@amd.com>
 <20220213082056.GA23572@wunner.de>
 <0ef8f2cb-1978-f469-71d3-2cf7469eb8b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef8f2cb-1978-f469-71d3-2cf7469eb8b6@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Sun, Feb 13, 2022 at 11:26:56AM -0600, Limonciello, Mario wrote:
> On 2/13/2022 02:20, Lukas Wunner wrote:
> > On Fri, Feb 11, 2022 at 01:32:42PM -0600, Mario Limonciello wrote:
> > > The `is_thunderbolt` attribute is currently a dumping ground for a
> > > variety of things.
> > 
> > It's not as arbitrary as it may seem.  Quite a bit of thought went into
> > the current design.
> > 
> > 
> > > Instead use the driver core removable attribute to indicate the
> > > detail a device is attached to a thunderbolt or USB4 chain.
> > 
> > You're missing the point that "is_thunderbolt" is set on the *controller*
> > (i.e. its upstream and downstream ports).
> > 
> > The controller itself is *not* removable if it's the host controller.
> > 
> > However a device can be assumed to be removable if it has an ancestor
> > which has the "is_thunderbolt" flag set.
> > 
> 
> Ah right... I wonder if really what this series should be about then is
> setting up the the PCIe endpoints for PCIe tunneling and XHCI tunneling to
> be marked as "external" instead then.  It would mean that existing code will
> apply the removable attribute to everything downstream (and presumably at
> least some of those drivers it will continue to make sense to drop
> "pcie_is_thunderbolt_attached" and instead check dev_is_removable.

Yes, I think this is the right thing to do. Anything connected over
PCIe/USB 3.x tunnel is pretty much "removable" whereas the host
controllers may or may not. Typically they are not.
