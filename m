Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58643C7AF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 12:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhJ0Kdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 06:33:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:4696 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241409AbhJ0Kdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 06:33:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316334594"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="316334594"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:31:28 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="555242790"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:31:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfgAx-001R6I-De;
        Wed, 27 Oct 2021 13:28:55 +0300
Date:   Wed, 27 Oct 2021 13:28:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: brcmstb: Use GENMASK() as __GENMASK() is for
 internal use only
Message-ID: <YXkp57iDYe7jLZLv@smile.fi.intel.com>
References: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
 <YXkjMO0ULRGqZPbr@rocinante>
 <YXkphydcdD9giKqs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXkphydcdD9giKqs@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 27, 2021 at 01:27:19PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 27, 2021 at 12:00:16PM +0200, Krzysztof Wilczyński wrote:

...

> (and I truly believe the code is very ugly here, because

s/code/generated code/

>  the idea behind GENMASK() is to be used with constants).

-- 
With Best Regards,
Andy Shevchenko


