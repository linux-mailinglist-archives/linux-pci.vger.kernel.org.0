Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02CD1C5C11
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEEPoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:44:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:40220 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgEEPoM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:44:12 -0400
IronPort-SDR: QNHILPa7Yw451zAx6VRGBGGop8vRNIXCVl1kJFJjwgGyrrudvdV/HHExRNOgyGT8hQQ00/BcBR
 HzZwot1yE2Qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:44:12 -0700
IronPort-SDR: kPOK3aaheoF9LjWv5luQTp3ETqBAlRJuKXjuvWd30uq2cSmqd5GyOSvzQdzijL6BLTqLmb8jeF
 4lET8Qo46SOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="295871285"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2020 08:44:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVzjw-004qAx-2V; Tue, 05 May 2020 18:44:12 +0300
Date:   Tue, 5 May 2020 18:44:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: cherryview: Use the new acpi_evaluate_reg()
 helper
Message-ID: <20200505154412.GT185537@smile.fi.intel.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505132128.19476-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:28PM +0200, Hans de Goede wrote:
> Use the new acpi_evaluate_reg() helper in the pinctrl-cherryview code.

Will wait for Mika's Ack.

> +	acpi_evaluate_reg(adev->handle, ACPI_ADR_SPACE_GPIO,
> +			  ACPI_REG_CONNECT);

I believe it perfectly one line (perhaps description in kernel doc as well in patch 1).

-- 
With Best Regards,
Andy Shevchenko


