Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC267A497B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjIRMXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbjIRMXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 08:23:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778CDBA
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695039778; x=1726575778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=34P6LCMy7MR9sHmTEGsozsuHqaUZg+bAh1kkIm0FO7M=;
  b=PBk9i8c8/nMDBGu4fWSCCw0vWW6gl2yBYHR3OJBZ5StRtcIPxyfDuZ8E
   5PAqArfofYYfYF2/FNH4mkpkUjvX/exe7L3lwP7Pfwm9YXoH7h1zIyQkk
   fS/4sx9UjY3zqoNM41SONzfCgMFrvwrTPNRLOfOIhKG4Rj4GDk3g7fmHw
   FMzZ0Lq6JP+kgHx/pCqBfPhfPvt7JQh0iqllj7zGhWK1LTEVQWiH4moap
   ISEDuKp5zLk0z+wURe7MtqiFjySfAKodtipOqpKrkfIi96QyIuAO+J0Bg
   C68SCDyXHJa3kH4KNnIsJ0gX/zinlTlhNTjJHoCbMRp1dvYDv5BVWa63v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446099606"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446099606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889036582"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="889036582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Sep 2023 05:22:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 959211CA; Mon, 18 Sep 2023 15:22:52 +0300 (EEST)
Date:   Mon, 18 Sep 2023 15:22:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
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
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230918122252.GT1599918@black.fi.intel.com>
References: <20230911073352.3472918-1-mika.westerberg@linux.intel.com>
 <fd414b6e-ebe0-9a2b-b9b0-e0131197b434@linux.intel.com>
 <20230918120916.GS1599918@black.fi.intel.com>
 <28b140a3-8fe9-373d-d66f-20ab104230cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28b140a3-8fe9-373d-d66f-20ab104230cc@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ilpo,

On Mon, Sep 18, 2023 at 03:17:41PM +0300, Ilpo Järvinen wrote:
> > > > +	 */
> > > > +	val = cap[1] & PCI_EXP_LNKCTL_ASPMC;
> 
> Given this line, it just felt pretty obvious because why would the code 
> & PCI_EXP_LNKCTL_* with some random register (value) that isn't LNKCTL :-).

That's a fair point :) Okay I can drop the comment in the next version.
