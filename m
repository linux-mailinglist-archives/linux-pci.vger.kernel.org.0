Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E54F95F8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiDHMpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiDHMp2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 08:45:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA9B329AF;
        Fri,  8 Apr 2022 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649421804; x=1680957804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shRsTxOu6z1fDTWKAhDb9aMsN+c5kKMrzbCJid69zTk=;
  b=Udwj9oiZf10ZVTP7hjVPkBB7s5gb9I5Ol5/MwZqVsfhmod5axAXNogWf
   35cmTD2/jVx8oqTXrCNW7xBBzCuACQDZna0RaPUW0aWMfvVJfChCHl8ma
   BAWj/y0wjMYOyhyeUsFIe2hBoxMR4Y5od23CD+DgpXKA2jqExxUV3IL9I
   yBFTb2tpC5T8Pkp3dlqdinYgZTtM5mX/Yo/zDokhScyzRxC0Q+PAr6QKQ
   RxMxwZpo4pzusfNZtztE2hH8egT/2UKHdSa45rQsFBk7uqUJ5ToMAlusd
   hN++pSLaNNjc7Qy8+73m1axWC2Y7iS6FHLJyOXrDxshIhIHPO/BJrLQws
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260417696"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260417696"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:43:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="550489494"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:43:21 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 08 Apr 2022 15:43:18 +0300
Date:   Fri, 8 Apr 2022 15:43:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: PM: Avoid leaving devices in
 D0-uninitialized in pci_power_up()
Message-ID: <YlAt5he5B1SlORMh@lahna>
References: <4198163.ejJDZkT8p0@kreacher>
 <3623886.MHq7AAxBmi@kreacher>
 <YkwRjI0KvpmiJjvK@lahna>
 <CAJZ5v0go9hLqv6Mcc5Ko770AU7sTYJQvgyjhGJ36AO1kURUnYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0go9hLqv6Mcc5Ko770AU7sTYJQvgyjhGJ36AO1kURUnYA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Thu, Apr 07, 2022 at 09:01:59PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 5, 2022 at 1:45 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Apr 04, 2022 at 05:41:13PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In theory, pci_power_up() may leave a device in D0-uninitialized
> > > during a transition from D3cold to D0.
> > >
> > > Say, a PCIe device depending on some ACPI power resources is put into
> > > D3cold, so the power resources in question are all turned off.  Then,
> > > pci_power_up() is called to put it into D0.
> > >
> > > It first calls pci_platform_power_transition() which invokes
> > > platform_pci_set_power_state() to turn on the ACPI power resources
> > > depended on by the device and, if that is successful, it calls
> > > pci_update_current_state() to update the current_state field of
> > > the PCI device object.  If the device's configuration space is
> > > accessible at this point, which is the case if
> > > platform_pci_set_power_state() leaves it in D0-uninitialized (and
> > > there's nothing to prevent it from doing so), current_state will be
> > > set to PCI_D0 and the pci_raw_set_power_state() called subsequently
> > > will notice that the device is in D0 already and do nothing.
> > > However, that is not correct, because it may be still necessary to
> > > restore the device's BARs at this point.
> > >
> > > To address this issue, set current_state temporarily to PCI_D3hot
> > > in the cases in which pci_raw_set_power_state() may need to do more
> > > than just changing the power state of the device.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Thanks, but on second thought, I'm not sure if this is the best way to
> address the issue.
> 
> Basically, pci_power_up() is called in two places, in
> pci_set_power_state() (for the transitions to D0) and in
> pci_pm_default_resume_early().  In the latter case,
> pci_restore_state() is called right after it and that covers BARs
> restoration, so nothing more needs to be done in that case.

I see.

> This means that pci_set_power_state() is the only place needing to
> restore the BARs when going into D0 from D3hot or deeper and it is
> better to move BARs restoration directly into it.  I'll update the
> series accordingly and resend.

Okay sounds good.

> I also think that the mandatory delay is not needed at all when
> pci_raw_set_power_state() is called for transitions D3cold -> D0,
> because in that case either the device has been powered up via
> platform_pci_set_power_state(), or via the bridge resume which takes
> the delay into account.

I agree.
