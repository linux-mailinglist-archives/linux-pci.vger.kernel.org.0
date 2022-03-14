Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9474D7FA3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiCNKR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiCNKRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 06:17:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF473CA6E;
        Mon, 14 Mar 2022 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647252998; x=1678788998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSuQ+Ujow8ZSXt27miUblP7rVNzbS+nHiJfwPUvSuj0=;
  b=fXgKisZIMVbG23vNkBST1n1ve8XU3RYLio8rKu3Bo4jEy9y0MLkVDuKj
   fn5uHg2viS2/qf5ebTEbCjxB7A//UhrXzuj4RnHcxC4zmYi++snCBHx2e
   vudOFrhnwXKYozEvwdGZO/1qniIUQlgTe16KmFc9z4/qudLngJ10lJm8t
   0b6bQKUDvYbv37bsQabLY/woAL604sCoHeWohWZ54AOlzp+cXxTK4zIS1
   1xFdPyJxbP+L0qKgOswh9qZl+wd44KWD6cqSI7XWZHqx9VGdXewg6b1Tz
   qNVmG4gSVDIoaDWvh4HnhFWlKuZI17U7KTtZ4cGQ0LJw3LLvIGrM54twc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342412376"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="342412376"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:16:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="782621839"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:16:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nThk4-00H9Jw-Pw;
        Mon, 14 Mar 2022 12:15:56 +0200
Date:   Mon, 14 Mar 2022 12:15:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Disable MSI for ATI PCIe-USB adapter
Message-ID: <Yi8V3D8WrGJo1/L4@smile.fi.intel.com>
References: <20220314101304.89866-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314101304.89866-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 12:13:04PM +0200, Andy Shevchenko wrote:
> ATI PCIe-USB adapter advertises MSI, but it doesn't work by yet unknown reason.
> 
> Disable MSI for these devices.

Please, discard this one, it has wrong subject and commit message. Another
one has just been sent out.

-- 
With Best Regards,
Andy Shevchenko


