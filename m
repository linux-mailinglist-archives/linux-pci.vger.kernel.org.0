Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A2360468D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiJSNOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiJSNOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 09:14:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481E4F38E;
        Wed, 19 Oct 2022 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666184373; x=1697720373;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=TxD76gxWxWY7Vah+aZmHr2ByAHaRPt2R0yoC+T8dfug=;
  b=VozWZAMBp/aIvrFhPhjVxFFrM4WqEEM14pljmbEd+Pq75hiF/B8JlJr9
   QpMgNif4ojKmyuJQzs7M5plFEBpcy2izrGvVQGB51xRO6FinGWkrt+Hrm
   MVNPG7HfMh9BMmdJs3z1+FVSEC2DIrxqs7l2fGPhw3mSZ8xVNsfNkKzp1
   /EslsM180yPRGGZnzBfTS6LVNuE3VgWSQ7+3otdeyWX38m32BSvia+dmA
   50KdyrLYEBAtTfmfG5Wq1/13o53+y8oXqwbmGiO0JDtOB2A51TDRQ6kK4
   JIRD004u88072JroVBF1l3OsaXBFc+0xpT43E5Y72LbFMfP4CeS0lfN1H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306390888"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306390888"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 05:57:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="698059872"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="698059872"
Received: from mosermix-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.50.2])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 05:57:50 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in
 acpi_get_pci_dev()
In-Reply-To: <Y0/sGveKPjuUWOhO@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <12097002.O9o76ZdvQC@kreacher> <Y0+7Ug9Yh6J6uHVr@intel.com>
 <CAJZ5v0gKW9S29xS2+qkcopzYtZKTcM=ZT-Jjc4fnEJfu=oYKaw@mail.gmail.com>
 <Y0/sGveKPjuUWOhO@intel.com>
Date:   Wed, 19 Oct 2022 15:57:48 +0300
Message-ID: <87zgdsgecz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Oct 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Wed, Oct 19, 2022 at 01:35:26PM +0200, Rafael J. Wysocki wrote:
>> If catching things like this early is better, what about pulling my
>> bleeding-edge branch, where all of my changes are staged before going
>> into linux-next, into the CI?
>
> Pretty sure we don't have the resources to become the CI for
> everyone. So testing random trees is not really possible. And=20
> the alternative of pulling random trees into drm-tip is probably
> a not a popular idea either. We used to pull in the sound tree
> since it's pretty closely tied to graphics, but I think we
> stopped even that because it eneded up pulling the whole of
> -rc1 in at random points in time when we were't expecting it.

Basically, we only pull branches to drm-tip that are managed using our
tools and our development model and under our control. It was too much
trouble dealing with conflicts, Linus' master being pulled in at random
points (like in the middle of the merge window), and stuff like that,
with the external trees.

> Ideally each subsystem would have its own CI, or there should
> be some kernel wide thing. But I suppose the progress towards
> something like that is glacial.
>
> That said, we do test linux-next to some degree. And looks like
> at least one of these could have been caught a bit earlier through
> that. Unfortunately no one is really keeping an eye on that so
> things tend to slip through. Probably need to figure out something
> to make better use of that.

Yeah, we need to pay more attention to linux-next test results, as well
as Linus' master during the merge window. It's not necessarily easy with
the volatility of linux-next, you could easily have very broken runs
followed by good ones, but the low hanging fruit is raising more flags
and being louder about it earlier when everything's busted for several
days in linux-next or Linus' master.


BR,
Jani.

--=20
Jani Nikula, Intel Open Source Graphics Center
