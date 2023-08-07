Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A578A771BE5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHGH5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHGH4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:56:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189ADD
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691394997; x=1722930997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a231DJijz7Gk3REhQOgWmFJGCEfRYxlfDoeglnJPJbk=;
  b=FrjuhAheQR+gZSY5+IdnanqTfJQ8SFNBeXvEEsbLpAnvQIRVc+PnYGxP
   qv6UBpBGz6urRqE3AMDMVH3JTZTWsGJvx3jsnh0v7DSzOA+3++V6WKaNl
   S2LQV7Winh/1JqJzwanooGUTSQDeW0y+m7e+LbKqcb0pqFE3hYSc22SQb
   giZ7O7ZvBeZ1DwPlTC/oyDuhx736PAXROi30PHCp2CRDa0887GkXK48I9
   ZVzo5XgbDtcsC4BO8/hQ6FZ9nJUZ/N/YvHcaIQCqAHnmZeXxfrk87VHgu
   J8RQ3VLFY39RDG8Zbii/me47/YIO7QRY8WYiike4P1W71ab+dNmHevUTW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="360559763"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="360559763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 00:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="724414441"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="724414441"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2023 00:56:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 630AE17C; Mon,  7 Aug 2023 10:58:32 +0300 (EEST)
Date:   Mon, 7 Aug 2023 10:58:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <thomas@witt.link>
Cc:     david.e.box@linux.intel.com, Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230807075832.GD14638@black.fi.intel.com>
References: <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
 <20230630104154.GS14638@black.fi.intel.com>
 <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
 <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
 <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
 <20230731150128.GK14638@black.fi.intel.com>
 <5d5dc59d-0ce0-c98c-c6c8-f1d748a8d968@witt.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d5dc59d-0ce0-c98c-c6c8-f1d748a8d968@witt.link>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Sat, Aug 05, 2023 at 09:57:47AM +0200, Thomas Witt wrote:
> On 31/07/2023 17:01, Mika Westerberg wrote:
> > Hi Thomas,
> > 
> > Thanks for trying that. Did you manage to try out the S0ix script David
> > suggested? That should show us hopefully what is draining the battery in
> > s2idle.
> 
> Hi Mika,
> 
> I did, with -s it gives
> 
> Your system does not support low power S0 idle capability.
> Isolation suggestion:
> Please check BIOS low power S0 idle capability setting.
> 
> with -r on
> 
> Your system did not achieve the runtime PC10 state during screen ON

Thanks for trying. Did you change the "mem_sleep" back to "s2idle"
before you run the script?

> additionally, it encounters a syntax error:
> ./s0ix-selftest-tool.sh: line 1182: wc:: syntax error in expression (error
> token is ":")

@David, do you know what might be the issue?

> with -r off, it tries xset which fails due to a lack of xserver.

You do have graphics running right? I mean i915 driver is enabled and
all the firmwares are in place (should come with the distro). I'm asking
because s2idle typically requires that graphics and pretty much all the
devices on the SoC have a driver and the accompanying firmwares, and
that they enter D3 properly.
