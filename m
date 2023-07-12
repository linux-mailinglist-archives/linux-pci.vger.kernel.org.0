Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A169750D2E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjGLPy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjGLPyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 11:54:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0691FE3;
        Wed, 12 Jul 2023 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177261; x=1720713261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ntin9ux60UydRjUjJN52xacdzkihb/yAwVR8rFD8U60=;
  b=Fg6pUJi4BuR4DpaTGx3vrbEgv8Jq6w+p4nFfXl/etNds/Ar5GK38Hjjq
   ANaA1IxOkgmXS7HUqKNS3Ns8U8F0Xk/SwiOLFbXOqGuJuFf2AkUHhVPKO
   WMuJLeL82lhkYpPUnQen1KDVnXIa1/LX3tNK040JE3iTAVbAdNsMpU5rn
   tVE9XO04yMT0pZY1tbbkKxA5MbKwGUvv1wp9cKjxjnxG9jWAjSwUO7AuV
   cSRoWjP6isXMGeTOe9NPhD0Udq8XrAG8ncTvhYW0DehiByAxqX+JpdEUy
   /ZitT3fEZKjqZrQ+ftrcQYDn/LAsqVyraUaOOTSXpIckx41L3MlpiP7pG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395725079"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="395725079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866174784"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866174784"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 08:54:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qJcAS-002AZo-2J;
        Wed, 12 Jul 2023 18:54:16 +0300
Date:   Wed, 12 Jul 2023 18:54:16 +0300
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
Subject: Re: [PATCH 13/13] ASoC: Intel: sst: Convert to PCI device IDs defines
Message-ID: <ZK7MqGyGYJ9eMlH1@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
 <ZK1oKYW0rro4FnNO@smile.fi.intel.com>
 <958f3638-f68a-ebec-29cc-816f823b017f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <958f3638-f68a-ebec-29cc-816f823b017f@linux.intel.com>
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

On Wed, Jul 12, 2023 at 02:19:47PM +0200, Amadeusz Sławiński wrote:
> On 7/11/2023 4:33 PM, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 02:57:26PM +0200, Amadeusz Sławiński wrote:
> > > Use PCI device IDs from pci_ids.h header.

...

> > >   	switch (sst->dev_id) {
> > > -	case SST_MRFLD_PCI_ID:
> > > +	case PCI_DEVICE_ID_INTEL_ADSP_TNG:
> > >   	case SST_BYT_ACPI_ID:
> > >   	case SST_CHV_ACPI_ID:
> > 
> > I think this needs a bit more, i.e. replacing the rest with respective PCI IDs.
> > 
> > All three will be defined with SST prefix, which makes sense to me.
> > 
> > ACPI here is a bit misleading, but correct. The ACPI specification assumes that
> > respective part of the ID space covers 100% of PCI ID space.
> > 
> > I have briefly checked the code and it seems that ID is used externally only
> > for PCI case, so we may simply use the lower 16 bits of the ACPI _HID for the
> > context.
> 
> Do I understand correctly that I should just do:
> #define PCI_DEVICE_ID_INTEL_SST_BYT	0x0F28
> #define PCI_DEVICE_ID_INTEL_SST_CHV	0x22A8
> and use those IDs instead?

Correct!

-- 
With Best Regards,
Andy Shevchenko


