Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662C6736C4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 12:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjASL2G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 06:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASL2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 06:28:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F126A2;
        Thu, 19 Jan 2023 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674127677; x=1705663677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bccrp8lmZ8ukBj/EyZ3CSpmIYfTSsrD0V3yh5r4NP20=;
  b=h5CHOQLjr7BXR84chydtbnMLgHqT9OQ1e4/4Ery8A+pE2ww9PG3nQYTq
   hft/2VYsSYsq7UirUTGef9yYFTCTu6XOS8OrnlW16+0JsPjOQSCzESTB5
   IxLYumJexMfW3+vz/0AqZdsZgVOjcNQWZpR0QxsHfxQeAz3lYKy0KfeH6
   j+iahKkEDMADowNP8DOUJ7aM46iVXWcwpJbOvKUo4nDtPo+7FDc1w9nr9
   c5UJ0ZxZg3PI8co0uJ/m2YM6sJIi9KbNZb/OSxZcBt/YB7tKz1g5orF1V
   tW1HYtM3gryKQLe33TYc4FzFdsJqRK8QstVFDItA2p9x74L3zthZD/2R6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323947823"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323947823"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728628016"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="728628016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2023 03:27:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIT51-00BcYE-0X;
        Thu, 19 Jan 2023 13:27:39 +0200
Date:   Thu, 19 Jan 2023 13:27:38 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
Message-ID: <Y8kpKm51YryPz9F5@smile.fi.intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119080606.tnjqwkseial7vpyq@pali>
 <BN9PR11MB54839E8851853A4251451719E3C49@BN9PR11MB5483.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB54839E8851853A4251451719E3C49@BN9PR11MB5483.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 08:17:05AM +0000, Zhang, Tianfei wrote:
> > From: Pali Rohár <pali@kernel.org>
> > Sent: Thursday, January 19, 2023 4:06 PM
> > On Wednesday 18 January 2023 20:35:50 Tianfei Zhang wrote:

...

> > > To change the FPGA image, the kernel burns a new image into the flash
> > > on the card, and then triggers the card BMC to load the new image into FPGA.
> > > A new FPGA hotplug manager driver is introduced that leverages the
> > > PCIe hotplug framework to trigger and manage the update of the FPGA
> > > image, including the disappearance and reappearance of the card on the PCIe bus.
> > > The fpgahp driver uses APIs from the pciehp driver.
> > 
> > Just I'm thinking about one thing. PCIe cards can support PCIe hotplug mechanism
> > (via standard PCIe capabilities). So what would happen when FPGA based PCIe card is
> > also hotplug-able? Will be there two PCI hotplug drivers/devices (one fpgahp and
> > one pciehp)? Or just one and which?
> 
> For our Intel PAC N3000 and N6000 FPGA card, there are not support PCIe
> hotplug capability from hardware side now, but from software perspective, the
> process of FPGA image load is very similar with PCIe hotplug, like removing
> all of devices under PCIe bridge, re-scan the PCIe device under the bridge,
> so we are looking for the PCIe hotplug framework and APIs from pciehp driver
> to manager this process, and reduce some duplicate code.

Exactly, from the OS perspective they both should be equivalent.

-- 
With Best Regards,
Andy Shevchenko


