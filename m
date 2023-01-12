Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9F6669CC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjALDst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 22:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjALDst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 22:48:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D844BD43;
        Wed, 11 Jan 2023 19:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673495328; x=1705031328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKvdNpz9TBZtw78c48PaO8ycADozRlkWSBrClcPP9SQ=;
  b=a/R2wnaTC4ksCwD0rnFGxzgyDen7os2Kj41Vz0M/GaTPqK4ZnuvR2bH9
   qrpR84qXaAEqvkgaVJpAnPcaiT9uaMViIFdHYqYq0H90EYfF9aNYgt+9m
   tana/RidqYM2m+uMvoh4G8v3bR0uL228F8OHZmAt6iRCGEn0Cmc99IJiC
   bsExOO8lHtjbPmZS9EgkogQ+kBFq5IYoeHrCq7gr/nFxvGo3AWZ6aY1te
   Jk6Smgy/Qex+UidgvHfpjNZkLkIm+Il5RIjB0uaF+1w6AaJTEusz/WMpp
   pE7SVClybKFbaAblQGtAHg8GXeNBY4fTsJP5436c1gRMA99zqujV5naNq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303301902"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303301902"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 19:48:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657641426"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="657641426"
Received: from mabir-mobl.amr.corp.intel.com (HELO [10.209.115.16]) ([10.209.115.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 19:48:47 -0800
Message-ID: <de13b6bd-813f-d0bb-3a92-ea1ad3db5d54@linux.intel.com>
Date:   Wed, 11 Jan 2023 19:48:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        treding@nvidia.com, jonathanh@nvidia.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vsethi@nvidia.com,
        linuxppc-dev@lists.ozlabs.org, sagar.tv@gmail.com
References: <20230111231033.GA1714672@bhelgaas>
 <880c4d3c-86d2-082c-bb58-8212adc67ff3@linux.intel.com>
 <4ddef2c9-44b6-4a08-dbeb-428cd0864c55@nvidia.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <4ddef2c9-44b6-4a08-dbeb-428cd0864c55@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/11/23 7:33 PM, Vidya Sagar wrote:
> I think we still need bios option. For example, consider a system where BIOS needs to keep ECRC enabled for integrity reasons but if kernel doesn't want it for perf reasons, then, kernel can always use 'ecrc=off' option.

I agree that "on" and "off" option makes sense. Since the kernel defaults ecrc setting to "bios", why again allow it as a command line option?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
