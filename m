Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35277F3E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 11:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbjHQJws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349917AbjHQJwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 05:52:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB12D70
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265950; x=1723801950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJi/Q8dj4yi4on93hBoFYDWUTR8/2O0OdhVauE9vWLQ=;
  b=IEtWiE0CBgytfyVkhUhesfjyMO9wyISJe7ZxhDrrtQ/puvigTill5u4t
   zb1cjVlV3kCmykLLfYDNWuhQ+LdGpTffBRkJWh405A+hcn+3vsBhPp+f5
   AEysr8NCEr8XhpWGWt5sLae9GU4XM8ny3UL74C68LU43dyrUWLI5LcpHC
   ZGMlqeoX/yaBWp86Ip0bCSqkW5uUnCrvVxgLcVK8+iAyEZ2RnsxsUfYHd
   QV4UHTVuW0ITEaCUpUKqEID7XYlZkIqSbGF2bQahWT2m2y4bv587V5gQ7
   4Y5EeqHkYVQtbf+VrspM7mopQI4mWhWjggPEH+9mbkicHM3wiADogHOb4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352354084"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="352354084"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878158589"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 02:52:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZg1-005zrv-1u;
        Thu, 17 Aug 2023 12:52:25 +0300
Date:   Thu, 17 Aug 2023 12:52:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        sheenamo@google.com, justai@google.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Message-ID: <ZN3t2eYU09iW/4At@smile.fi.intel.com>
References: <20230816172115.1375716-3-bartosz.pawlowski@intel.com>
 <20230816173906.GA292642@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816173906.GA292642@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 12:39:06PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
> > There is a HW issue in A and B steppings of Intel IPU E2000 that it
> > expects wrong endianness in ATS invalidation message body. This problem
> > can lead to outdated translations being returned as valid and finally
> > cause system instability.
> > 
> > In order to prevent such issues introduce quirk_intel_e2000_no_ats()
> > function to disable ATS for vulnerable IPU E2000 devices.
> > 
> > Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Andy, Alexander, would you please reiterate your reviewed-by on the
> mailing list?  I try to avoid relying on internal reviews collected by
> the author.  Those are great and I'm glad they happen, but it's good
> if they also appear as part of the public conversation on the mailing
> list.

They are legit for my name, I dunno what exactly you want to hear from me.
The internal process of review requires these tags by default, it's hard
to deviate from maintainer to maintainer.

> > Intel Technology Poland sp. z o.o.
> > ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> > Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> > 
> > Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> > This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

What really needs to be dropped is the footer.
Bartosz, consult with the internal resources on how to get rid of it.

-- 
With Best Regards,
Andy Shevchenko


