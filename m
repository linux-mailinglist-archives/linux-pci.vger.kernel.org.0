Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8417298E6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFIMA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFIMA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 08:00:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A9E4A;
        Fri,  9 Jun 2023 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686312056; x=1717848056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGy0tnOsIMO/gl2a+BAJqrOm+qw2zjtT8uyD9gXInPM=;
  b=GaM/VMyvgXmR5rKE7wsWM2ysoMl61SuSHX3nO5c+M+2UFFygV6OFS09y
   bbZ2B97U4cQdX5oHIkrccWIT4F/2Ejx5dhZIXzCVIUwq6+5O+BWwr/yKt
   Zn5Rtb9Wgag4tyChITpit1ayrP9bjkOw+M1W8hT8SDRl8E88+7LC1tYe6
   HKg7QXZ8lIWEJl7LMoEJrATt0UVjrxxeT5iaWCswoH/81+PrByzYeedqb
   49Ul+ww/JjTsRBLxAA2wk6yihcrbN+kBPjr2/Q5B8ZecwieoxBX9IgtEx
   iwdaBcitH1qPZgNzS1HnVDp4Lobr/SSO+t1NfQcq4ZksdEDD/zEwTnYO2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337216305"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337216305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 05:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="743467635"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="743467635"
Received: from lmirabel-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.211.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 05:00:52 -0700
Date:   Fri, 9 Jun 2023 14:00:42 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 4/4] PCI/VGA: Replace full MIT license text with SPDX
 identifier
Message-ID: <ZIMUakQMGI9ugf8M@ashyti-mobl2.lan>
References: <20230609112417.632313-1-suijingfeng@loongson.cn>
 <20230609112417.632313-4-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609112417.632313-4-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 07:24:17PM +0800, Sui Jingfeng wrote:
> Per Documentation/process/license-rules.rst, the SPDX MIT identifier is
> equivalent to including the entire MIT license text from
> LICENSES/preferred/MIT.
> 
> Replace the MIT license text with the equivalent SPDX identifier.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
