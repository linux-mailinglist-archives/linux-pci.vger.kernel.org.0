Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BED4B4E8B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351504AbiBNLcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 06:32:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbiBNLaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:30:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6447066AF7;
        Mon, 14 Feb 2022 03:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644837121; x=1676373121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhliuFcKaGT4XB0ts+0U1iHxKFUOKpgSPOQ3kJVrBqw=;
  b=UlwnlLd7Kt5onKh/gt6YHt4vaeoAv2mfWKHqiMKJlm0XTlFhmNw8farZ
   smdR5+QtyKGbtW7hRkyBc22mcd9/nIIHf5jjH0joZJH4gBnydiSdGudJm
   e614cm02q6eDo8QYtwzHc4S5SCG1ww1tqv0Tkzz0xUe/k2gUBPYRglBOR
   Rclx2Besk9IKaDHTaKfKSdo9sVIpJN6vYMOQ6LU92vGA/ROQaQ21LKE+1
   +Y+zyeUxZPv9lVyADmfhMUC+FV8fxGe6Jy6HhhNJbLIbtf4sJWUYt1LRT
   8qD3jX5Q8Sx2De/8GCD90ncDaPmjz/QVITQLazrUSAHprVIp0OPE1MGI8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248901060"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="248901060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:12:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="538542216"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:11:56 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 13:11:54 +0200
Date:   Mon, 14 Feb 2022 13:11:54 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <Ygo4+sfeHhQeSUEa@lahna>
References: <20220211193250.1904843-6-mario.limonciello@amd.com>
 <20220211214546.GA737137@bhelgaas>
 <YgoGAkjZgCob8Mdl@lahna>
 <20220214085202.GA21533@wunner.de>
 <Ygo1eoVe8D0b80QF@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygo1eoVe8D0b80QF@lahna>
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

On Mon, Feb 14, 2022 at 01:11:05PM +0200, Mika Westerberg wrote:
> > > It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
> > > DisplayPort). Tunnels are created by software (in Linux it is the
> > > Thunderbolt driver) and are dynamic in nature. The USB4 links go over
> > > USB Type-C cable which also is something user can plug/unplug freely.
> > > 
> > > I would say it is reasonable expectation that anything behind these
> > > ports can be assumed as "removable".
> > 
> > USB gadgets may be soldered to the mainboard.  Those cannot be
> > unplugged freely.  It is common practice to solder USB Ethernet
> > or USB FTDI serial ports and nothing's preventing a vendor to solder
> > USB4/Thunderbolt gadgets.
> 
> Right, that's why I say it is "reasonable expectation" that anything
> behind these ports can be assumed "removable" :) Of course they don't
> have to be but if we assume that in the driver where this actually
> matters we should be on the safe side, no?

Also the tunnels are not permanent anyway.
