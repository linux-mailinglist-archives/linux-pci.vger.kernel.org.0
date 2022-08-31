Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C175A7FF8
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiHaOTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiHaOTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 10:19:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D38558A
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955583; x=1693491583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2ktLsfbDcLere3XMO80ZSnae1qyNKZuC1TT9nJRJpE=;
  b=TzKiE4D2OtMjKwJGzRYq6j4TPpVVTboHEi+Zj+6ETjfvihSn+otehZaB
   x4S/xuodLsKYmvUdRD8TT0Tsav2ams4g2sQFPOnNJ5LXhMWknopBrBnnH
   klPLHyHOn+LgyNpRKTxlhKrwnwuK4XjXV1W/o093vnBA0cAxtCEkusMu6
   TjxlAPPtDkg6SKuJbPXq2Az8EHKMkdiv5tr/n2UDbTyoAxKJBiblheS/D
   Mp37zPuMrn86EMaBvwcq5aE1ix5gAwCwMgEzGMrZu6No+oUckJsbAUqBp
   SKGQ4uUynQlCql1FAY1lEU2ZkfTsfiS9JUuxinZAOnxh5vh4vHO6ph83m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295460821"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="295460821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:19:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="680432486"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:19:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTOZ9-006Pl4-0M;
        Wed, 31 Aug 2022 17:19:39 +0300
Date:   Wed, 31 Aug 2022 17:19:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/6] PCI: Fix indentation in
 pci_bridge_distribute_available_resources()
Message-ID: <Yw9t+i+1Ljr+mVsK@smile.fi.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
 <20220816100740.68667-7-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816100740.68667-7-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 01:07:40PM +0300, Mika Westerberg wrote:
> Correct the indentation according the coding style.

I believe this can be squashed to patch 4 with combined description about
fixing indentation (blank lines are also kinda indentations).

-- 
With Best Regards,
Andy Shevchenko


