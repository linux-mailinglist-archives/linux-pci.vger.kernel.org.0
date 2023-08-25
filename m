Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76439788017
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbjHYGkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbjHYGkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 02:40:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E91FF3;
        Thu, 24 Aug 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692945609; x=1724481609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=etGYANIF6LqY7TvLbzOmTClwc0aVFSmG7bkx+aHoS2s=;
  b=GXWBBhTCQO6k3dVt+PiOKnpB2Ra3PyZ85JTbAG7V3zGsRB0gSWVmOzJX
   abJL5nFBr5iZ2/9nbNNzGgDTODxQm8sgfBBCJICyOLGeQKxojw9Oc3mGz
   fS/QyhAUs/FXSbwZKb4WbXNDyJ3RFJYepB3UfKmfNJ4nT2T4H+zOM69Gp
   exW6UqfYHjhYLWYfqGXwZCm2geUeh6YnlFxURRCUFb5DpDeMSbO1Q5LIM
   Cv1r3Rt7b05D6RKexVlav+yS4hmzq4eJI00hZQYmpMdM+fRbqazOeQaJQ
   sQMNcdnf+b6oN3lH53ZPhyYBh4xA6zBTSkGIeiGUZg1HVaSCvjIQXlUhE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440991156"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440991156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1068133216"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1068133216"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 23:39:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 454961CA; Fri, 25 Aug 2023 09:39:48 +0300 (EEST)
Date:   Fri, 25 Aug 2023 09:39:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
Message-ID: <20230825063948.GY3465@black.fi.intel.com>
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
 <20230824115656.GW3465@black.fi.intel.com>
 <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
 <20230825052946.GX3465@black.fi.intel.com>
 <CAAd53p71gLHq71WtnWBXOaX6K6rXyZ=nrGND5x8ZKXvyNsWBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p71gLHq71WtnWBXOaX6K6rXyZ=nrGND5x8ZKXvyNsWBtw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 01:43:08PM +0800, Kai-Heng Feng wrote:
> On Fri, Aug 25, 2023 at 1:29 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > > Hi,
> > >
> > > On Thu, Aug 24, 2023 at 7:57 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> > > > > In addition to nearest upstream bridge, driver may want to know if the
> > > > > entire hierarchy can be powered off to perform different action.
> > > > >
> > > > > So walk higher up the hierarchy to find out if any device has valid
> > > > > _PR3.
> > > >
> > > > I'm not entirely sure this is good idea. The drivers should expect that
> > > > the power will be turned off pretty soon after device enters D3hot. Also
> > > > _PR3 is not PCI concept it's ACPI concept so API like this would only
> > > > work on systems with ACPI.
> > >
> > > IIUC, Bjorn wants to limit the AER/DPC disablement when device power
> > > is really off.
> > > Is "the power will be turned off pretty soon after device enters
> > > D3hot" applicable to most devices? Since config space is still
> > > accessible when device is in D3hot.
> >
> > Well the device may be part of a topology, say Thunderbolt/USB4 (but can
> > be NVMe or similar) where it initially goes into D3hot but in the end
> > the whole topology is put into D3cold. The device driver really should
> > expect that this happens always and not try to distinguish between the
> > D3hot or D3cold.
> 
> What if the device is not in such topology? There are cases that the
> rootport doesn't have Power Resources associated so the rootport also
> stays in D3hot.

Yes and this is why the driver should not care. Otherwise it just
complicates things.

For instance, a root port may have _PR3 that allows the whole thing to
enter L2/3 (D3cold) but some device has d3cold_allowed set to false or
there may be a device that does not support PME on D3cold which prevents
the power to be turned off.

> I think what Bjorn suggested is to keep AER enabled for D3hot, and
> only disable it for D3cold and S3.
> 
> >
> > > Unless there are cases when device firmware behave differently to
> > > D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> > > and system S3.
> >
> > Yes, this makes sense.
> 
> I agree that differentiate between D3hot and D3cold unnecessarily make
> things more complicated, but Bjorn suggested errors reported by AER
> under D3hot should still be recorded.
> Do you have more compelling data to persuade Bjorn that AER should be
> disabled for both D3 states?

Is there even an AER error that can happen when a device is in D3hot
(link is in L1) or D3cold (link is in L2/3)? I'm not an expert in AER
but AFAICT these errors are reported when the device is in active state
not when it is in low power state.

All that said, Bjorn is the maintainer so he gets to decide. If this is
what he suggested then I'm fine with it. Just wanted to mention this. I
too want to see this issue fixed, one way or another ;-) Thanks for
working on this BTW!
