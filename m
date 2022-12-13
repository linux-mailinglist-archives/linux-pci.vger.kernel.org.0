Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5E64B7B8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiLMOsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMOr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 09:47:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99B2DE2
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670942874; x=1702478874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wL0dlbsXgtbjPwngZllI47B9eq+PMOkQOC2YYXBU+ec=;
  b=j3taS8WKGBxylwBsB8Oc5KHFAk2sAffVdX55FQJyDbcf9R86tXJwA20u
   4UG9nyf9R3p/FM/5ooq2Wn4m9Gi1/k2Scy2Ncd65aSa6FnMySH5kemCr5
   lksAVhU7TQqoGC7WSgtXE6FZ44OuJ6kDF8ZddbQ5AoZdHMf7/rgsteL/H
   CXPDVsE+t277JUKwvwzHOe3L6LwK4J3hoktPNWprKka6gtuY7OcWVkN4o
   r+U/nIsr6yVy59KCqRKLX7goFTkyobn7aHVwVrm1XA07KcOxL2l/jUxCq
   2N0v5CW0gKyNDrxBuVC1t+lNubACl7bdRVH7GVFPG/tbq/IIzXjmV3427
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315782659"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="315782659"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 06:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737417994"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="737417994"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 06:47:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2829311D; Tue, 13 Dec 2022 16:48:21 +0200 (EET)
Date:   Tue, 13 Dec 2022 16:48:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Message-ID: <Y5iQtaNgr0nMWjAI@black.fi.intel.com>
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
 <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
 <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
 <35208ffe-0aee-b055-0ed7-99b6414af6da@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35208ffe-0aee-b055-0ed7-99b6414af6da@ixsystems.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Dec 13, 2022 at 09:11:12AM -0500, Alexander Motin wrote:
> > I'm also more than happy to test any patches regarding this if someone
> > else wants to work on it ;-)
> 
> I was kind of ready to dive in, I hate hacks and tunables to workaround
> bugs.  But as I have told, I see this code first time, so my solutions may
> appear not right.  But I'll help as I can, if needed.

That's good to hear :) Okay feel free to use any of my previous patches
as base if needed. I can test the Thunderbolt/USB4 and the QEMU PCI/PCIe
topologies so please keep me in the loop when submitting.
