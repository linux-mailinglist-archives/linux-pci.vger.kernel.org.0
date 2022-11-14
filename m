Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3D6278D5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 10:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiKNJRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 04:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiKNJRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 04:17:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE464EB
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 01:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668417432; x=1699953432;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OL3EwMwmfvGi3Wdctj7Gosxx5UmerMBDjlJchvC6JcM=;
  b=TLP8tmiKd/At+fMArqvsu5ZX4jF4lMekKoo6ScxIuaw8xatsEh036bfv
   wtbjVVyz5n7uOMwp1PCEieoT+nDU4iLr5CODs0zW/xYyZnn0v4ChpvhGz
   wj6LrvmdQ+PtGh1yXguB/vpSM7fZI7oLdzf2eQLArz4dhft3LBlCaO8Rr
   Ey1RRXdwfksFPQ+EnNh28zgCj0Dl10Sw/HNsg1UOs9HXkZ7iNT4oFHJKJ
   zJMRd5eFHuulAdkUR3dj/+llWE2s68SAh4Bi+HMzNPfbGj4JJDQZJTyye
   8FN0m5G7KTxicTsMdMHMTLfUFjZntubHBLrq1l6bfi48zx8x5vE6rYJ0K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313068557"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313068557"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:17:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="967496548"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967496548"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.214.100]) ([10.254.214.100])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:17:10 -0800
Subject: Re: [helgaas-pci:pci/enumeration 3/3] drivers/pci/probe.c:909:6:
 warning: variable 'err' is used uninitialized whenever 'if' condition is true
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org
References: <20221108130816.GA464595@bhelgaas>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <c8c2f0ee-1f67-cdc0-da21-233dc7df4778@intel.com>
Date:   Mon, 14 Nov 2022 17:17:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221108130816.GA464595@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/8/2022 9:08 PM, Bjorn Helgaas wrote:
> Why did the bot tell me the build was *SUCCESSFUL* even though this is
> clearly a problem?  Here's the "success" message:

Hi Bjorn,

Sorry about that, it's an internal bug in our service.

Best Regards,
Rong Chen

> 
>    https://lore.kernel.org/all/636a47ad.UocsB2qjv%2FcFWvK2%25lkp@intel.com/
> 
> On Tue, Nov 08, 2022 at 03:21:20PM +0800, kernel test robot wrote:
> 
>>>> drivers/pci/probe.c:909:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>>             if (bus->domain_nr < 0)
>>                 ^~~~~~~~~~~~~~~~~~
> 
> I set "err = -EINVAL" here; let me know if you prefer something
> different.
> 
