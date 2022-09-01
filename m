Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786705A8D5C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 07:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiIAFbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiIAFbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 01:31:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEAF1F622
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 22:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662010257; x=1693546257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTTCKAJylI52Ic59G9HR3omTN6wUC4oi1tgpY1Y6eKg=;
  b=Z4ahNIqVDXy5oSxvCxFeIWLr5mjuoCrtAvPSpkKF/msmljyjC7C42hUB
   BI/jR2LyvuiXQCKeDZJYyku8NxoyB9iyc2gsMxEf/UjknIN3pEtozqb1N
   45G44MJAyJrSvUGet1b3iZ5uLyN4ue0fHaMUD/60ZHQKcIqsLFKza/vP8
   u9oDGwRf06A0GiC6UBnWvIHMZH/56Io27SJ0ZZSjNEl67samQ/xfiOI4D
   2A/MoUOJyA8pTplgA0fFNVwaq+c7bSVZAiR5pUGxuo9FrRl3KkUXl5/b8
   aFgr34jpb25wDuDgmVyuAlbkeNO+jaZ3lso3TsrN8VQ6troojmT6Zx0Em
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="293198741"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="293198741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 22:30:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="857700676"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2022 22:30:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8E0B5101; Thu,  1 Sep 2022 08:31:10 +0300 (EEST)
Date:   Thu, 1 Sep 2022 08:31:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: Allow for future resource expansion on initial
 root bus scan
Message-ID: <YxBDnl9/Ium3EcNi@black.fi.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
 <Yw9uHmijqFUckyUr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw9uHmijqFUckyUr@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 05:20:14PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 16, 2022 at 01:07:34PM +0300, Mika Westerberg wrote:
> > Hi,
> > 
> > The series works around an issue found on some Dell systems where
> > booting with Thunderbolt/USB4 devices connected the BIOS leaves some of
> > the PCIe devices unconfigured. If the connected devices that are not
> > configured have PCIe hotplug ports as well the initial root bus scan
> > only reserves the minimum amount of resources to them making any
> > expansion happening later impossible.
> > 
> > We do already distribute the "spare" resources between hotplug ports on
> > hot-add but we have not done that upon the initial scan. The first three
> > patches make the initial root bus scan path to do the same.
> > 
> > The additional three patches are just a small cleanups that can be
> > applied separately too.
> > 
> > The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.
> 
> With split and squash or not, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy!

I will do the changes you suggested in v2.
