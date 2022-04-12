Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF694FDDB1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbiDLL0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352781AbiDLLZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:25:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52743275F5;
        Tue, 12 Apr 2022 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758109; x=1681294109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pC4oMCwiVQJHi/ouQqRKkAncvNZ0T2XkSEgopnaDXwk=;
  b=OqL8dcoBrZnmxoe5yZIC/ltuXWtxg83ePG33r/EHXJxf8tP6EnxDekhy
   CEqIOoaZyepPuarkxBzJcTHbNDYOCLDGOFqxe58dwJF/g2nBZKT5LZnsx
   FzhKNTLDg1UqSHVky6EuqTEQoYEeEPbdf01chRgjxWuUR+IT4c9yPIwAM
   cttTzqqZHru79BvdVzltwxGM9a6KGMURo8kAEMemmfJSgfWbzlGLMi4HO
   rSKujCi3+Zaxe/hzRdNc8vYFfdv/jwRQ4onoUGMniAlYH5gPUaaFIIsX5
   M5ZQauDlSbZesS/Tf7FbZ1ADhzsWAVTYv9nTgp1h7ujgAvkiFvTDzX5kk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262517009"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262517009"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:08:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="802174815"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:08:06 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Apr 2022 13:08:04 +0300
Date:   Tue, 12 Apr 2022 13:08:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/9] PCI/PM: Improvements related to device
 transitions into D0
Message-ID: <YlVPhCLcFVbFPN36@lahna>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11975904.O9o76ZdvQC@kreacher>
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

Hi Rafael,

On Mon, Apr 11, 2022 at 04:17:41PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> On Saturday, April 9, 2022 3:03:14 PM CEST Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This series supersedes the one at
> > 
> > https://lore.kernel.org/linux-pm/4198163.ejJDZkT8p0@kreacher
> > 
> > It addresses some potential issues related to PCI device transitions from
> > low-power states into D0 and makes the related code more straightforward
> > and so easier to follow.
> > 
> > Please refer to the patch changelogs for details.
> 
> Here's a v2 of this patch series which is being sent, because I realized that
> one of the checks in pci_power_up() added by patch [4/7] in v1 was redundant
> and can be dropped, but that affected the last 3 patches in the series and
> then I noticed that more improvements were possible and hence the new patches
> [2/9].

I sent a few minor nits separately. The series looks good to me in
general and certainly improves readability :)

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
