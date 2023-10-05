Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703167B9F7E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJEOYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjJEOXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 10:23:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553A10D5
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513714; x=1728049714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KzpeFTx8zrn8+AF9NwBkDldV/9DUbJCChCOgqhxZ3gk=;
  b=Q1V3FLdqZU/pHhN/HMhVFOqwvEAUuW9F40Q+xpTMeC7fWy7bBo9Z8lTC
   XJnux7RIlF/H6V4c373RpuNx9FqE9c5pPlSvbYyfsZzD4j0YkwzHEq8w3
   um2i9xu6VJQTYbC8BAfs9fLku2r/fVvPaL3kRVJ6zxNCB7i+zFU+WG+U5
   I3aCIBe02MBcF4t75/tYNzq/YT8h7403dVL0ipH0n19/ODF2bGt9GI6w+
   Bb1hQf0mfxvrc6A7qTN/+Iw37lD3kf52vogqdf781X05H7hRD0FvIzZtc
   oAJHGIZDsFOXr9imxlz3EiM+8wYuvM99WTXiEhJ0vrTKLk6AfLWu5WNbF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469758233"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469758233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781243723"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781243723"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2023 06:09:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 17E8535A; Thu,  5 Oct 2023 16:09:37 +0300 (EEST)
Date:   Thu, 5 Oct 2023 16:09:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20231005130937.GS3208943@black.fi.intel.com>
References: <20230925141930.GA21033@wunner.de>
 <20230926175530.GA418550@bhelgaas>
 <20230927051602.GX3208943@black.fi.intel.com>
 <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
 <20230927135346.GJ3208943@black.fi.intel.com>
 <CA+cBOTfCy-KOptir9yfkVz1=bfOTPQanqe9ofX-jphm7oeBEXg@mail.gmail.com>
 <CA+cBOTdzp+6whm=Sj5nE2=MC4a+45y0CFtk4hDGq0XgF6f0f2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTdzp+6whm=Sj5nE2=MC4a+45y0CFtk4hDGq0XgF6f0f2A@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kamil,

On Thu, Oct 05, 2023 at 02:54:23PM +0200, Kamil Paral wrote:
> On Wed, Sep 27, 2023 at 4:12 PM Kamil Paral <kparal@redhat.com> wrote:
> >
> > On Wed, Sep 27, 2023 at 3:53 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > If you apply the patch from here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=pm&id=6786c2941fe1788035f99c98c932672138b3fbc5
> > >
> > > Does the problem go away with the disconnect case too (and so that you
> > > have "secure" enabled)?
> >
> > Thanks, I'll test it, but I can't do it this week. I'll reply next week.
> 
> Hello Mika, sorry for taking me so long. The URL above gives me a "Bad
> commit reference" error, but I found a patch mentioned in a different
> thread, so I used that one, and I hope it's the correct one :-) It's
> quoted below.
> 
> With the patch applied, I can confirm that disconnecting and
> reconnecting the cable during suspend is no longer a problem. I tested
> both "user" and "secure" Thunderbolt security levels. The resume is
> fast in all cases, and I've found no issues. Thanks for working on it!
> 
> The patch I used:

Yes, that patch is the correct one. Bjorn moved it to his "for-linus"
branch so it got different Commit ID:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=c82458101d5490230d735caecce14c9c27b1010c

Thanks a lot for testing!
