Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12EF73F9AB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjF0KID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjF0KH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 06:07:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B5D35B0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687860282; x=1719396282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1olh7lStFKPiQDbWhFJk3UpB7iLAY244Y77qEyrD9KU=;
  b=BRfDTDjavwixJc/Vqf1mCdy/SAkyCwGg9eQGueBgrk1EhxGR+27AjHu5
   ufrEoBqLN8JNav37PAx6AXFIEhH0K3Jzxl0o1PHCdFfbipbAz/B9gtTj0
   LrhJHVAqFIOQ8sBZYJthQW1wSqkxKZrP1edn83JhS6jlSKl6bbeBv6FUp
   KQ7vfDyYOLzDuh3AopiVqjfWxUslCI9C86mAg91Y4By+khDFcTFAcZDY7
   PO5CEAX3X3D/n1EV8/m+woV6g/jIU4h+bRaPuVBmPy3Cwb2gQAkUk0Lww
   0ownyjucxuEs3pTlrQNSgPsY11zgZmtLprGlywufjDQr0qCcNTqEKd3Bq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425200254"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="425200254"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 03:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840638810"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="840638810"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2023 03:04:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 17EA3370; Tue, 27 Jun 2023 13:04:47 +0300 (EEST)
Date:   Tue, 27 Jun 2023 13:04:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <thomas@witt.link>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230627100447.GC14638@black.fi.intel.com>
References: <20230627062442.54008-1-mika.westerberg@linux.intel.com>
 <61224a0b-ddf7-8348-332c-ec20e7d970e4@witt.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61224a0b-ddf7-8348-332c-ec20e7d970e4@witt.link>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Tue, Jun 27, 2023 at 11:53:33AM +0200, Thomas Witt wrote:
> On 27/06/2023 08:24, Mika Westerberg wrote:
> > Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> > for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> > due to a regression that caused resume from suspend to fail on certain
> > systems. However, we never added this capability back and this is now
> > causing systems fail to enter low power CPU states, drawing more power
> > from the battery.
> 
> Hello Mika,
> 
> I am sorry, but your patch (applied on top of master) triggers the exact
> same behaviour I described in
> <https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi become
> unavailable during suspend/resume)

Thanks for testing! Can you provide the output of dmidecode from that
system? We can add it to the denylist as well to avoid the issue on your
system.
