Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9723129F0C6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 17:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgJ2QJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 12:09:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:24722 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgJ2QJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 12:09:06 -0400
IronPort-SDR: 3VHmjmxBTwcGQdv9gn2muj4XcdN5BLm0lw77xMW8lBBI8tZv1EI+Z5KFv20jpWckf1A0SOzwVJ
 0LIYHodH4FJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="232639714"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="232639714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 09:09:04 -0700
IronPort-SDR: o/Gm7f1y34orcEpElR0LldXFavO2FYXKWwrc/KN/JDHfpgdFsMrq+DOEZ30t2MSrkEOk6ItjnN
 EBHNOZY7epSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="425089580"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 09:09:03 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id B98BB5806E9;
        Thu, 29 Oct 2020 09:09:03 -0700 (PDT)
Message-ID: <a5f95b717ce4a767d10689d54bc166ea534fd98a.camel@linux.intel.com>
Subject: Re: [PATCH V9 0/5] Intel Platform Monitoring Technology
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Thu, 29 Oct 2020 09:09:03 -0700
In-Reply-To: <20201029151633.GB4127@dell>
References: <20201029014449.14955-1-david.e.box@linux.intel.com>
         <20201029151633.GB4127@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lee,

On Thu, 2020-10-29 at 15:16 +0000, Lee Jones wrote:

...

> > Changes from V8:
> >  	- Rebase on 5.10-rc1
> > 	- Add missing changes in MFD patch from V7 that were
> > accidentally
> > 	  dropped in V8
> 
> Which changes are those?
> 
> Do I need to re-review?

Should have mentioned here. Patch 2 is the only one that changed. It
was corrected to be the last patch you reviewed (which was accidentally
reverted in V8) plus I dropped this dev_err:

       if (!found_devices) {
               dev_err(&pdev->dev, "No supported PMT capabilities
found.\n");
               return -ENODEV;
       }

There are no more changes planned for this series and we're still
looking to merge in 5.11. Thanks.

David

