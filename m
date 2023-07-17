Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89BE75658F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGQNyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGQNyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 09:54:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E41C7;
        Mon, 17 Jul 2023 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689602080; x=1721138080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FrmhMcGq6Yw5RIRrByo036Ctus6slD2drwf6+eTiVSs=;
  b=KkJhi+OqnMhuYKPikAeQxnUBPjlFuvNO0aZk5gS5O5tTkbPeA2G09Por
   wE1/akmN24lNk1ir/kBNGvqw47RCXkLpSnMyq0JIVxfoYeK+9l56nGSWr
   5DfDWwpH7BbtMUuEbfQ26WWuK6A2YxAIoMWTuj96LH2ukuXvAD2EmMwdk
   Neu4XI5xBGL1UvhpUyQLujMfCoADYGy/4NVzW6lgsWtN5RwsaTjJQ0jWR
   SI4M2PynlnFEZpW0Zwtq4+i5ri0MzA7cy6sQfHMy85UBwpuUfCpN7D1lq
   CD3ml0HWo6gK10ny3j2XESpxZDCWfNy8NNch9h2CqktpzQ2J1SsmHY3Wa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345525871"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345525871"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752903299"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752903299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 06:54:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qLOgM-00H3tq-1u;
        Mon, 17 Jul 2023 16:54:34 +0300
Date:   Mon, 17 Jul 2023 16:54:34 +0300
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
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 01/15] PCI: Sort Intel PCI IDs by number
Message-ID: <ZLVIGlpoNsr0RRGE@smile.fi.intel.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
 <20230717114511.484999-2-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717114511.484999-2-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 01:44:57PM +0200, Amadeusz Sławiński wrote:
> Some of the PCI IDs are not sorted correctly, reorder them by growing ID
> number.

Hmm... I don't see a cover letter...

-- 
With Best Regards,
Andy Shevchenko


