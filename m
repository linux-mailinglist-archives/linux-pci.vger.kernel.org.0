Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCB7565A3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGQN6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGQN6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 09:58:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA1E1;
        Mon, 17 Jul 2023 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689602295; x=1721138295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZegC5DPpSUub8UmMq/EVEnANqCgyQJ+7uEfWodtWc/M=;
  b=Vvu3Bt5I8Y1CElLctJizdMEtNuu2kr1zl8zFFH7XsnTsh3ZYi0sotLJU
   UCFb3UJ9q0HHF4Bp5vHJJAEmeAcfmEGvY4nl+0F6d43jpU8FW/AwEv69M
   SBm5fwhngDF4utARngisiwyl1xiZFp17seAHjwk4pXjFlpeKyXCYZuIlB
   yaiAi6+GHyazkl8Pd4Xt8IkC+ys8IcFEswb1iZvQ3T0+QTNiUO+o6G3MA
   Ko2QesNHdD/+e+4nsG2Ir8aebXkQJ2s4p1nH++cWN2yBMedvrTOcVzx5N
   yiL6ZBLftbUwUGzxY6D6/eAuPzpWeaD8w6t0ae2rKGyeEGucAB1kJzwob
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="396763921"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396763921"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726554750"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726554750"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 06:58:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qLOjo-00HBxz-1p;
        Mon, 17 Jul 2023 16:58:08 +0300
Date:   Mon, 17 Jul 2023 16:58:08 +0300
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
Message-ID: <ZLVI8NuiIZZrhjRg@smile.fi.intel.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
 <20230717114511.484999-2-amadeuszx.slawinski@linux.intel.com>
 <ZLVIGlpoNsr0RRGE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLVIGlpoNsr0RRGE@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 04:54:34PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 01:44:57PM +0200, Amadeusz Sławiński wrote:
> > Some of the PCI IDs are not sorted correctly, reorder them by growing ID
> > number.
> 
> Hmm... I don't see a cover letter...

Okay, `b4` fetches it. It seems I asked you (or my memory is doing a trick?)
to avoid using my @intel.com for LKML archives...

-- 
With Best Regards,
Andy Shevchenko


