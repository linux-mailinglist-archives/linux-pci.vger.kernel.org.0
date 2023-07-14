Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577A8753B18
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjGNMgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjGNMg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:36:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120DE269D;
        Fri, 14 Jul 2023 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689338185; x=1720874185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jtrdQg43uwRw8V/SyWjoA6lDOg9Cy8vdVhZHpyU1RSk=;
  b=YUeD5efDG7xe9gupM9uwbHHEqnhlMHRxreho2tV4kJMOYd3oMR4EokAB
   czBgObVdx+k2e86rP5qxoB6K69asB7xnCFwr5XQiLfrQcqmbnU0BIaQOz
   ZraIkpvA8z7+pmzXSpP3TiRiJXtXYSulmHTaH0uYpr4/e2ftaPbDgnTsD
   CZU6giDfcbvtWeAW83kQpGYguNRqLWWaWsuoE7PY2U5Km1icrl8kvj86r
   X5cLBk+IQLZ4TkinZDSAY8NjU1E1LNWlm6pC/75XSnNR0JfGi9SPsvpE6
   1XHZB/0W0EkIgYSJMuxO1F9Edy/77D45CekB+TyNmFBFTZXiM0mT/LN4I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429228642"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429228642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053039721"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053039721"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:36:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKI1y-002ey7-2b;
        Fri, 14 Jul 2023 15:36:18 +0300
Date:   Fri, 14 Jul 2023 15:36:18 +0300
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
Subject: Re: [PATCH v3 00/15] PCI: Define Intel PCI IDs and use them in
 drivers
Message-ID: <ZLFBQqGzoCjBHChK@smile.fi.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 10:24:42PM +0200, Amadeusz Sławiński wrote:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.
> 
> Simplify things, by adding PCI IDs to global header and make use of them
> in drivers. This allows for removal of comments by having IDs themselves
> being self explanatory. Additionally it allows for removal of existing
> inconsistencies by having one source of truth.

> Changes from v2:
>  - Change CHV to BSW (Andy)
>  - Fix incorrectly rebased patches (Andy)
>  - Fix commit message and add suggestions from Andy to SST patch (Andy)
>  - Rebased on top of Linus tree commit: 4b810bf037e5

Use --base parameter, it will help CIs as well to test your changes against
correct base.

-- 
With Best Regards,
Andy Shevchenko


