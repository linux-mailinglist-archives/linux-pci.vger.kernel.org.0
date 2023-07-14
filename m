Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC135753954
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjGNLQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNLQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:16:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9D26AE;
        Fri, 14 Jul 2023 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333386; x=1720869386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GYXdmFtvQT38yb1qGuS4fihiMa4mlOiHOLM9SwIpk9M=;
  b=nzqyfJVyd8PkRvr696P9OZui9VzwvlzXq5m2Gu8qalAd3OczroGY2aDs
   GOIOJLK1ZQJbQfn66lLdly/td4ovqB8yiKP6Bme0s7QyL2mxq6D3dKmE+
   EHy6cGf7u3GpIV3FdPZRBTBtYgVY86WJFesgUl9UhQzUqph4aYBd5Uain
   xTy17RkSTNVVl0it54vY1uNfMX7N+CgCaBtZ4Fxi1gxBUUGcmAOdgFSBn
   GIl2QgHf3O5Pi3X3UxHweFdoevQeAu+FUgEByN3/+EFfclQMuXMUOSvQD
   7AL/ST1riVYCWJkVossLps0qvgzlFMrgvnQd4ofY8mulePYayqUcQYxRa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368088710"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="368088710"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716305148"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="716305148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 04:16:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKGma-002dtm-13;
        Fri, 14 Jul 2023 14:16:20 +0300
Date:   Fri, 14 Jul 2023 14:16:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 02/15] PCI: Add Intel Audio DSP devices to pci_ids.h
Message-ID: <ZLEuhComcqmTu/hK@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-3-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714185615.370597-3-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 08:56:02PM +0200, Amadeusz Sławiński wrote:
> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
> Almost every use contains additional comments to identify to which
> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
> there is one place which defines those names.

...

> +#define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
> +#define PCI_DEVICE_ID_INTEL_SST_CHV	0x22a8

In case you need to send a new version for the sake of consistency
either use CHV (CHT) or BSW for both. Basically these are code names
for the same (very similar) platforms/SoCs:
Braswell (BSW),  Cherry View (CHV), Cherry Trail (CHT)

-- 
With Best Regards,
Andy Shevchenko


