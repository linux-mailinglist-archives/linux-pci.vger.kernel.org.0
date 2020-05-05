Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8061C5BE0
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEEPnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:43:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:65384 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgEEPnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:43:05 -0400
IronPort-SDR: JAyVeV3jKepWDxv5h3JxNegSeZtscXMYbpoKwC86hKtbA2YvoX7YpuwbC2a4+L1WPTfiNWvHag
 97TU4YukBSFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:43:04 -0700
IronPort-SDR: 2NfD0YbqpXz9+ccNJGoZM+zfhyBlKN3GwXPUSyk8f60h5w2+xpm944p6lFgxZcoad5LFlLJ1+J
 rXiX7cIh5dlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="263210471"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2020 08:43:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVzir-004qAL-3f; Tue, 05 May 2020 18:43:05 +0300
Date:   Tue, 5 May 2020 18:43:05 +0300
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
Message-ID: <20200505154305.GS185537@smile.fi.intel.com>
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

> + * @function: Parameter to pass to _REG one of ACPI_REG_CONNECT or
> + *            ACPI_REG_DISCONNECT

Is it enum or definitions? If former can we refer to it?


(Sorry, clicked reply to fast with previous mail)

-- 
With Best Regards,
Andy Shevchenko


