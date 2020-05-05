Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B891C5BD1
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgEEPmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:42:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:62573 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgEEPmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:42:06 -0400
IronPort-SDR: yBKiQNa9TYaM0pD2B6b7Ltar/s9D5hCK9p1S0bdnot7OnezU4RjiyZK54+36IopU3KXaB5xNP3
 uPauiTxJi1wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:42:05 -0700
IronPort-SDR: +pXvuXt1GlmrM6e2GVAFJJn4XFt0XFjDU9pUBDBj344RwCxB87CK7m3P/g7pWufI5aRYpk/jwX
 Fuf3evkzOZ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277916809"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 08:42:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVzht-004q9u-6Q; Tue, 05 May 2020 18:42:05 +0300
Date:   Tue, 5 May 2020 18:42:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI / utils: Add acpi_evaluate_reg() helper
Message-ID: <20200505154205.GR185537@smile.fi.intel.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505132128.19476-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:26PM +0200, Hans de Goede wrote:
> With a recent fix to the pinctrl-cherryview driver we know have
> 2 drivers open-coding the parameter building / passing for calling
> _REG on an ACPI handle.
> 
> Add a helper for this, so that these 2 drivers can be converted to this
> helper.

Suggested-by?

-- 
With Best Regards,
Andy Shevchenko


