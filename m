Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3A58841A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiHBWSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiHBWSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 18:18:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618464C3;
        Tue,  2 Aug 2022 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659478734; x=1691014734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=46eujB+5/ILB4xpJ6ANIISZP2uck5Pj6UwNACvgbNjc=;
  b=MmRK1ttVz2Nm3VY0GKCuDArwtOptnOV9xJht8WlA/6ggoxEV1e2giSdk
   0nATb1gRo0NT4jV0UWi1eVgCMzZ10zaHDwPuMtIUQfPeRr/BzSG/MzTpr
   utjhlZPxnwFJ+59P/ZTtfd4P5fwDArwcqbcQ3fdLFqeZsyo+yeFlzF+VR
   pEYqOd+cHGtA1dWIrvmRt7teU651TMAe0tgGjsU/KeaGyha2yT6xWVY8D
   HpLCksNSfKh2R+UEvpwcxjh/d/BkiROMBOevzkCfZPMfvEOcJZgIA3kbK
   SOfajcEmv4wfGKn0b48aoIKDudU+zbJwrjw/b4Fy/H8G+gvGclGcGcbri
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288286381"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="288286381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:18:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="692015304"
Received: from lkeefe-mobl.amr.corp.intel.com (HELO [10.212.232.208]) ([10.212.232.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:18:53 -0700
Message-ID: <6056c6cc-9861-9c29-8e36-48e0dd36c702@linux.intel.com>
Date:   Tue, 2 Aug 2022 15:18:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
 <b5c746db-f6a0-d89e-6db5-e4a206c9237a@linux.intel.com>
 <cfd44d9c-453b-e498-2630-9057947cf3cd@bytedance.com>
 <b54b068b-fe9a-8609-3e9f-170579affc27@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <b54b068b-fe9a-8609-3e9f-170579affc27@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/27/22 2:37 AM, Zhuo Chen wrote:
>>
> Do you mean changing "if ((host->native_aer || pcie_ports_native) && aer)" into "if (pcie_aer_is_native(dev) && aer)" ?
> I thought changing into "if (pcie_aer_is_native(dev))" before.
> 
> One another doubt. Not every pci device support aer. When dev->aer_cap is NULL and root->aer_cap is not NULL in aer_root_reset(), pcie_aer_is_native() will return false and OS cannot operate root register. It's different from just using "(host->native_aer || pcie_ports_native)".
> 
> Or we can change "if ((host->native_aer || pcie_ports_native) && aer)" into "if (pcie_aer_is_native(root))". But in this way, argument NULL pointer check should be added in pcie_aer_is_native().

Looking into it again, I think it is better to leave it as it is. Please ignore my comment.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
