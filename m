Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F824B4E13
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbiBNLWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 06:22:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiBNLWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:22:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37133A5F0;
        Mon, 14 Feb 2022 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644836301; x=1676372301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqstnbilWmleOnIjJb3aDPlLE84EFgpMrS7YjBM/2dk=;
  b=IvgyhlIAVyqiOEPZXCmb4uonwoA85Jcdc5s/4b7laEPWIUs/+35Mffuu
   S4G+knTiUJKADgopzVw0k+/SHp3N6Jkh8nEuTEqY7r4TMZpKAHqepmtH9
   5jXLXjyIn0HUarHtLgXm4EDrqqBM5QkHc+L0VR375kuThCFVyxAXZt1q7
   4Tkwa1SUNE41sKHB9pf3x5Rhj2VZ80Ow/pSQmr9f/mRLTExA2AhE0b48T
   7OclePP3BUye17yi6yCNCG8EHZwbzde2W7wCRZQTWv9C9aDnovC5UJeM2
   iVMGwEsXeaCexXHvX+F8ps/wksDGGyAW4uo6P/MBT1kyPKjST0kuzlWY+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250012831"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250012831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:58:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="528087732"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:58:15 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 12:56:58 +0200
Date:   Mon, 14 Feb 2022 12:56:58 +0200
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
Message-ID: <Ygo1eoVe8D0b80QF@lahna>
References: <20220211193250.1904843-6-mario.limonciello@amd.com>
 <20220211214546.GA737137@bhelgaas>
 <YgoGAkjZgCob8Mdl@lahna>
 <20220214085202.GA21533@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214085202.GA21533@wunner.de>
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

On Mon, Feb 14, 2022 at 09:52:02AM +0100, Lukas Wunner wrote:
> On Mon, Feb 14, 2022 at 09:34:26AM +0200, Mika Westerberg wrote:
> > On Fri, Feb 11, 2022 at 03:45:46PM -0600, Bjorn Helgaas wrote:
> > > My expectation is that "USB" (like "PCI" and "PCIe") tells me
> > > something about how a device is electrically connected and how
> > > software can operate it.  It doesn't really tell me anything about
> > > whether those electrical connections are permanent, made through an
> > > internal slot, or made through an external connector and cable.
> > 
> > It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
> > DisplayPort). Tunnels are created by software (in Linux it is the
> > Thunderbolt driver) and are dynamic in nature. The USB4 links go over
> > USB Type-C cable which also is something user can plug/unplug freely.
> > 
> > I would say it is reasonable expectation that anything behind these
> > ports can be assumed as "removable".
> 
> USB gadgets may be soldered to the mainboard.  Those cannot be
> unplugged freely.  It is common practice to solder USB Ethernet
> or USB FTDI serial ports and nothing's preventing a vendor to solder
> USB4/Thunderbolt gadgets.

Right, that's why I say it is "reasonable expectation" that anything
behind these ports can be assumed "removable" :) Of course they don't
have to be but if we assume that in the driver where this actually
matters we should be on the safe side, no?
