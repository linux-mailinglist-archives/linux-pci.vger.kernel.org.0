Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F67B04A4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjI0Msk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI0Msj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 08:48:39 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 05:48:38 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81EC0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695818918; x=1727354918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/UCa+XWknrbavQHm577Zgs4yC9pEsv4Gt8Ci9kyH7M=;
  b=ZOTx4z1kogoXq1VDc/ZX6dBE71O0ltFaUVO9wrqL1SGr7FcuF4WOOMsY
   UzC03k8ZPpZIwWbDptXL767du+yQmoETCiOQ/zRMk6J8ZlZAJqa0zrulv
   3gMm7rVYUzXCQE2wYLadhfp2RxxQYq+1EDs+RAvSwoagJWeC3TfP3GA0r
   GBzXhZOI2IWdyXjk2XVT05v659woggV3wXm4CgAsDdJL/vyYyuv8aGPr5
   sYe0X0MZ6ntbeT3lXpipdFJqZVHx94salvCrP5p540ToSyNxnkn1pIB8G
   O94bPcC5qjfsjs3On9a9btwogvtrkySHhxhdEPgsraAm6Vp+E3crXHNPG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="411951"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="411951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="922752971"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="922752971"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2023 05:47:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5756D13AB; Wed, 27 Sep 2023 15:47:32 +0300 (EEST)
Date:   Wed, 27 Sep 2023 15:47:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927124732.GI3208943@black.fi.intel.com>
References: <20230927051602.GX3208943@black.fi.intel.com>
 <20230927115703.GA445616@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927115703.GA445616@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 06:57:03AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 27, 2023 at 08:16:02AM +0300, Mika Westerberg wrote:
> > On Tue, Sep 26, 2023 at 12:55:30PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Sep 25, 2023 at 04:19:30PM +0200, Lukas Wunner wrote:
> > > > On Mon, Sep 25, 2023 at 08:48:41AM -0500, Bjorn Helgaas wrote:
> > > > > Now pciehp thinks the slot is occupied and the link is up, so we
> > > > > re-enumerate the hierarchy.  Is this because thunderbolt did something
> > > > > to 06:00.0 that made the link from 05:01.0 come up?
> > > > 
> > > > PCIe TLPs are encapsulated into Thunderbolt packets and transmitted
> > > > alongside DisplayPort and other data over the same physical link.
> > > > 
> > > > For this to work, PCIe tunnels need to be set up between the Thunderbolt
> > > > host controller and attached devices.  Once a tunnel is established,
> > > > the PCIe link magically goes up and TLPs can be transmitted.
> > > > 
> > > > There are two ways to establish those tunnels:
> > > > 
> > > > 1/ By a firmware in the Thunderbolt host controller.
> > > >    (firmware or "internal" connection manager, drivers/thunderbolt/icm.c)
> > > > 
> > > > 2/ Natively by the kernel.
> > > >    (software connection manager)
> > > > 
> > > > I'm assuming that the laptop in question exclusively uses the firmware
> > > > connection manager, hence the kernel is reliant on that firmware to
> > > > establish tunnels and can't really do anything if it fails to do so.
> > > 
> > > Thanks for the background; that improves my meager understanding a
> > > lot.
> > > 
> > > Since this seems to be a firmware issue, it does sound like this
> > > laptop uses a firmware connection manager.  But there still seems to
> > > be some kernel connection because pre-e8b908146d44, the link came up
> > > in <5 seconds, and after the minor e8b908146d44 change, it takes >60
> > > seconds.
> > 
> > In both cases (with or without) the commit what happens is that after
> > resume is finished the firmware connection manager notices the
> > connection, announces it to the Thunderbolt driver that exposes it to
> > the userspace where boltd re-authorizes the device. This brings up the
> > PCIe tunnel again and things get working.
> > 
> > (What is expected to happen is that during the resume the firmware
> >  connection manager re-connects the PCIe tunnel.)
> > 
> > This took previously the ~5s before resume is complete so that the above
> > steps can happen where as after the commit it got delayed more up to the
> > arbitrary ~60s because we started to use that with the commit
> > e8b908146d44 (PCIE_RESET_READY_POLL_MS).
> 
> Why does the kernel delay affect the timing of when the firmware
> connection manager notices the connection?  It seems like Linux waits
> for the timeout, then Linux does something that kicks the firmware
> connection manager.  That's why I asked about this sequence:
> 
>   [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
>   [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
>   [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
>   [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
>   [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
>   [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> 
> where we wait for the timeout, decide the device is gone, remove
> everything, and then the thunderbolt driver does something, and we
> notice the device is magically back.

Well the delay delays the whole resume and this includes Thunderbolt
driver resume too, and userspace (where the bolt daemon authorizes the
device again).

> > I would also try to change all the BIOS settings back to defaults, see
> > that it works (it is probably in "user" security level then), then
> > switch back to "secure" (only change this one option) and try if it now
> > works. It could be that some setting just did not get commited properly.
> 
> If this might lead to fixing a Linux defect, I'm all for this kind of
> experimentation.  But if it only leads to understanding a firmware
> defect better or figuring out better advice to users, I'm not, because
> I don't want to address this with a release note.

This is not a Linux defect. The firmware is expected to create that
tunnel so regardless of the "delay" the devices are already back. This
is not happening.
