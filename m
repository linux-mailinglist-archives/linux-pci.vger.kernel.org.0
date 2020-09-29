Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA5927B943
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 03:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgI2BWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 21:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2BWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 21:22:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1EC061755;
        Mon, 28 Sep 2020 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jFhERp+GFlG0mWg6Tw5muCCjUZRI/pucWHGGQksi2ks=; b=RWqdiWRg00fxYa9HW+hLJudl1r
        94+OctWvu3PGfi2/1hrpKp+WLvL5a3ZgXQUcKOjwxDeSS7Y+TLnLTswtRtngtFtUi6Uzglji1+TCO
        gpcfLL4L1tTuHI4+2AyPRFkuRI0ioK9zxcAGEApiQPptA/SnzqvcaE7BZD3KvlXPfRxedY8QdWu4D
        HOyzt+mvGD6MMQfhyLFyyUIB/OpPMJ2icS5nBFLNhzZqt2mx3fJBpy+vKe644nRFrHSFF11ToAlrB
        wmLXcMlFwQVAhfO6oQVIjWYs7GB/m/oXEB4aRiKZAkmhis9xQdTR0BL2RJBOZdx2VKW/IVXsLNevO
        R4BwDNvg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN4L6-0003gg-Uv; Tue, 29 Sep 2020 01:21:58 +0000
Subject: Re: [PATCH V6 3/5] platform/x86: Intel PMT class driver
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200929005320.14739-1-david.e.box@linux.intel.com>
 <20200929005320.14739-4-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d6d59aad-a946-d780-b2d2-9c187fd8303c@infradead.org>
Date:   Mon, 28 Sep 2020 18:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929005320.14739-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/28/20 5:53 PM, David E. Box wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..093c43b63f48 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1360,6 +1360,15 @@ config INTEL_PMC_CORE
>  		- LTR Ignore
>  		- MPHY/PLL gating status (Sunrisepoint PCH only)
>  
> +config INTEL_PMT_CLASS
> +	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
> +	help
> +	  The Intel Platform Monitoring Technology (PMT) class driver provides
> +	  the basic sysfs interface and file heirarchy uses by PMT devices.

	                                     hierarchy
No "heir" involved.

> +
> +	  For more information, see
> +	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> +


-- 
~Randy

