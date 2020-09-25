Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF17278EDB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIYQkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 12:40:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:26777 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYQkm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 12:40:42 -0400
IronPort-SDR: d2yBEuqkY3481dZBXrpTCNz1+8SGLrR4mpuzGk4JX37sbWJ7F+Z3kWYoDNtxcaUDBVwAOdLjXo
 dIKoXeeZTXOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158980020"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="158980020"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:08 -0700
IronPort-SDR: 7Snvcif0RQrruV5i04teGjWGlvgAHxfwMBgqUnBRQ7p0yaeCb/Gdxu7ly69HDuOU7ZJM+UIYEG
 LrAqPJiLBTGA==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="310880095"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kLmwV-001uyQ-Sn; Fri, 25 Sep 2020 15:35:15 +0300
Date:   Fri, 25 Sep 2020 15:35:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 3/5] PCI/ERR: get device before call device driver to
 avoid null pointer reference
Message-ID: <20200925123515.GF3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925023423.42675-4-haifeng.zhao@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:
> During DPC error injection test we found there is race condition between
> pciehp and DPC driver, null pointer reference caused panic as following

null -> NULL

> 
>  # setpci -s 64:02.0 0x196.w=000a
>   // 64:02.0 is rootport has DPC capability
>  # setpci -s 65:00.0 0x04.w=0544
>   // 65:00.0 is NVMe SSD populated in above port
>  # mount /dev/nvme0n1p1 nvme
> 
>  (tested on stable 5.8 & ICX platform)
> 
>  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
>  async page read
>  BUG: kernel NULL pointer dereference, address: 0000000000000050
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page

Same comment about Oops.

-- 
With Best Regards,
Andy Shevchenko


