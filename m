Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283D784FCF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 07:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjHWFHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHWFHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 01:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A056E4A
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 22:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692767238; x=1724303238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d7PdSEv7Jwsv3vTkO02exhv7qYxEAvqR08AmLs2hV0g=;
  b=TTdkeUE5U4AQA81/EBFOVWjIJr83t+MVfcDFoS+2cucQnJG3UkhqKQfw
   vAPD1vJsCLGdMkGPkjX5P/VadgJBvQKOTJpGK2RglJW+toHOmEsaJEOUz
   ek2bjexz2XHQKqI9JLwviW9zLRqYsLpaGKOY28L9lIHRrjuGZMlkpsgmM
   h3kDjs5Yk0O2jGOMQvcua3IqizdqwwoxFOYsfyauqEo6cgpvGEmtiAGDO
   JXG6bZGx+S1NCUTuULeHxz5IA/St1yQ1Gr/+da9LozAYLUferUgO3YLLs
   gN7dsL73TyFI+vIdQH1UmemA5PTG3mTWTrfSS8mBU+a/wZlqYLIRKRQiK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405068686"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="405068686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="801963211"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801963211"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 22:07:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DE4DE2FF; Wed, 23 Aug 2023 08:07:14 +0300 (EEST)
Date:   Wed, 23 Aug 2023 08:07:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230823050714.GP3465@black.fi.intel.com>
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com>
 <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Aug 22, 2023 at 06:43:54PM +0200, Kamil Paral wrote:
> On Mon, Aug 21, 2023 at 3:13 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Thanks for the detailed description! There was follow up patch that made
> > the timeout shorter for slow links, I wonder if you could try that first
> > and see if that changes anything? It is this commit in the mainline:
> >
> > 7b3ba09febf4 PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links
> >
> 
> Hello Mika, thanks for a quick response. Please see my reply to Bjorn,
> the resume is just 60+ seconds delayed, not completely failing, I was
> wrong about that. I attached my logs there.
> 
> To respond to your question, I applied 7b3ba09febf4 on top of
> fe15c26ee26e (which is the parent of e8b908146d44) and tested that.
> Hopefully I understood the instructions correctly. That kernel resumes
> just fine, with the expected speed (~5 seconds), no extra delay. (If
> there's a speed-up, I can't really tell).

Okay if I understand correctly with commit 7b3ba09febf4 things works as
before and you don't see any delays in resume?
