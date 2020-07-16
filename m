Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB4221A62
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGPC5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 22:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGPC5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 22:57:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1740C061755;
        Wed, 15 Jul 2020 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=H3h1bEt0wiAYr6NamZK9YXsksiff+hW7CU5/kyZVC2o=; b=slxjapWcYGT8gDa/1H9TylGLl2
        G3/jmLlZaAqCdUomjsiWl7ttzE1HXhfbscPNY8odZX4T5vQJ8xzeEV7iFxRmWtapF7SvzBzoRV8xF
        lot/tN0SfXTNBnw1SrraENXyKC4xqpN9GFWCY70DDqnw2yT1nN5YHZuL/AMNJBSkqlazoP/E1ygcE
        vwySAP+xgvNZVBwTVZEf5QrbeUdqhR1OaLk0yxYDczxJIrGwpd0n+dM1j79jTTO41rIy1rYc2Q0/D
        qwYUXnSOOiAFiEqvHBwMpjdt5PooFefPnoG/MnpCKj4J4v9Tgl4duVpAKJtSE+c4k4Txr12hnWjNJ
        f2Lcx8CA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvu5n-0006z3-DK; Thu, 16 Jul 2020 02:57:52 +0000
Subject: Re: [PATCH V3 3/3] platform/x86: Intel PMT Telemetry capability
 driver
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
 <20200714062323.19990-4-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8b759604-428c-8df1-e3c2-d8fa2c5f796c@infradead.org>
Date:   Wed, 15 Jul 2020 19:57:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714062323.19990-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/20 11:23 PM, David E. Box wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0581a54cf562..5e1f7ce6e69f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1396,6 +1396,16 @@ config INTEL_TELEMETRY
>  	  directly via debugfs files. Various tools may use
>  	  this interface for SoC state monitoring.
>  
> +config INTEL_PMT_TELEMETRY
> +	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
> +	help
> +	 The Intel Platform Monitory Technology (PMT) Telemetry driver provides
> +	 access to hardware telemetry metrics on devices that support the
> +	 feature.
> +
> +	 For more information, see
> +	 <file:Documentation/ABI/testing/sysfs-class-intel_pmt_telem>
> +
>  endif # X86_PLATFORM_DEVICES
>  
>  config PMC_ATOM

The text under "help" should be indented with one tab + 2 spaces,
as is done in patch 2/3.

-- 
~Randy

