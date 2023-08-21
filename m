Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9C782A38
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHUNO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHUNO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 09:14:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C2113
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692623669; x=1724159669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zB8yzETn3THtXBYT0i2OPbGB+wO93hCaneHbBu4UO+o=;
  b=jrCuxAYMd275jSBxgNJMjkgvEmosjTIyzAZmW6/ih8M4PjgABE6ozQgH
   YrgniKe1QYqFFSqMqjXE+c9LFHSbz12b9UEwvdCLuvtDD5jUMZrcyNHZR
   KT9I6qnRTXZqC4bLv6Z8yu39qg30NnZ439JgUZiEXiIiKhWfdSNX+z1uV
   QUyb+6ueu7l04bsJBRzIKRXdtK5ACD8Xs5vMxHA97kc4yUnc/DSM7jm8l
   m7V33zLT7xh0bdoTGsZu1X8vza6IWKQBbrQTaLBDTegjZz0AzEvTA0Fmc
   H6qNh02tq3Kzs8t1tG7yL5HVD+u65qituLDbwpROlmtHrTT6gePwteBZ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363747562"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="363747562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 06:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="770938849"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="770938849"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 06:12:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A264C2FF; Mon, 21 Aug 2023 16:12:23 +0300 (EEST)
Date:   Mon, 21 Aug 2023 16:12:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230821131223.GJ3465@black.fi.intel.com>
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 12:39:02PM +0200, Kamil Paral wrote:
> = Summary =
> A Thinkpad T480s laptop with a Thinkpad Thunderbolt 3 Dock connected
> can no longer resume from suspend. The problem was introduced in
> e8b908146d44 "PCI/PM: Increase wait time after resume".

Thanks for the detailed description! There was follow up patch that made
the timeout shorter for slow links, I wonder if you could try that first
and see if that changes anything? It is this commit in the mainline:

7b3ba09febf4 PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links

That should at least make the resume faster too but let's see.
