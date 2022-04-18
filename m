Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC2504B13
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 04:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiDRCno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 22:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiDRCno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 22:43:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA59D5B;
        Sun, 17 Apr 2022 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650249663; x=1681785663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1OnnIxCBy/qTlGtme/3GDFqpeEdoJajfa2fa8H07GEY=;
  b=VSnfExkHRyNd+BCIATVp+3ZPAhBvmwB631D/BgLtvpORAbyrY4u9bkG4
   VtZrCEmwZyOXURyUQMnS5dgovrniHqNDwLYzjEsm/VxVtYgMfck38mNzz
   pMcgWhz58v6yscVGb+GcmMw5+/zhA/HV1hy8mnckPhYn5Uzkgnk3/nOuD
   Mja1K+C2CL7lrQU+kCX+QhT9zklCopuM09bvXhVJYofD/lWyJDyNrYWwv
   Ma8xaBXVKt9aBW4SoUIVwhqMYM7XRm0bnOJKR21h0hAQM52dEKbrbmTpd
   4Fe2b3UwTD6i/DuRlkmO20f0GxvUN0Tp9K0hlCaZUa7K77UGv8+lXVggk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326339714"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="326339714"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 19:41:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="646717427"
Received: from tnguyen-mobl1.amr.corp.intel.com (HELO [10.212.132.8]) ([10.212.132.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 19:41:01 -0700
Message-ID: <0d4e8764-b1ae-ae59-06ff-d5b705891da4@linux.intel.com>
Date:   Sun, 17 Apr 2022 19:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] PCI/DPC: Disable DPC service when link is in L2/L3
 ready, L2 and L3 state
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        baolu.lu@linux.intel.com, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220408153159.106741-1-kai.heng.feng@canonical.com>
 <20220408153159.106741-2-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220408153159.106741-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/8/22 8:31 AM, Kai-Heng Feng wrote:
> On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:
> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> 
> Since AER is disabled in previous patch for a Link in L2/L3 Ready, L2
> and L3, also disable DPC here as DPC depends on AER to work.
> 
> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng<kai.heng.feng@canonical.com>

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
