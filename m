Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06891604F0A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJSRk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJSRkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 13:40:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548C19DDAF;
        Wed, 19 Oct 2022 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666201254; x=1697737254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MCt32TjPlGarJR5rG8qyjVG72iAEmUkFwrBifFx18wc=;
  b=UlLMWMY7gRuNmjFvFYFI5u5cley/oziF9LgVRCDQGbqpPTK7SRFPfc/5
   RjQpJFTIJ9HtssRA0PLw8iTO0pfE92+FEie7xbtxiNs6Xo6TBjALSNDMH
   2yawwZWvYgOxT5pP5MPLuaxB4tHbWYorZuxZnZn/vRyg4q98OVzl8sG/i
   2Rv6vAoWt6Ozew4vDFZX9MJc19Ewsm3IPIKvmB/LlqoJtlPg3MdmplKlE
   kLhQKeFPIb8+p7KeMv7m1CVhUG87SU3x8Dd0gcWWKNaKvjQRR6rRBL64F
   EIENeK0mx0CwMCWYnj0odOxgIB7Vif4yY5V6IKlIUa0fRd5xqhJl+yJvc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306476583"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306476583"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607207072"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607207072"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga006.jf.intel.com with SMTP; 19 Oct 2022 10:40:50 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 19 Oct 2022 20:40:49 +0300
Date:   Wed, 19 Oct 2022 20:40:49 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in
 acpi_get_pci_dev()
Message-ID: <Y1A2oR02JjXqMOiQ@intel.com>
References: <Y0+7Ug9Yh6J6uHVr@intel.com>
 <20221019165326.GA23726@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019165326.GA23726@bhelgaas>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 11:53:26AM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 19, 2022 at 11:54:42AM +0300, Ville Syrjälä wrote:
> > On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> > > to reference count the device returned by acpi_get_pci_dev() as
> > > expected by its callers which in some cases may cause device objects
> > > to be dropped prematurely.
> > > 
> > > Add the missing get_device() to acpi_get_pci_dev().
> > > 
> > > Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> > 
> > FYI this (and the rtc-cmos regression discussed in
> > https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
> > took down the entire Intel gfx CI.
> 
> >From 1000 miles away and zero background with the gfx CI, this sounds
> like "our CI system, whose purpose is to find bugs, found one", which
> is a good thing.

Mostly. It's certainly better than it going entirely undetected.

Sadly we found it after rc1 because no one was really looking at
linux-next results. Something we need to improve.

But ideally it would have been found by some other CI system
whose primary job is to prevent bugs in those subsystems, rather
than the one whose primary job is to prevent bugs in gfx drivers.
Also ideally it wouldn't have been me bisecting this :P

The biggest downside of bugs reaching our CI via rc1/etc. is that
it pretty much stops everyone from getting premerge results for
their graphics driver patches since the CI keeps tripping over
the already existing bugs. But I guess you can call this one a
somewhat self inflicted wound and we should just try harder to
keep new code out of our tree until it's known to be healthy.

-- 
Ville Syrjälä
Intel
