Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF67227B954
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgI2BYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 21:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2BYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 21:24:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA143C061755;
        Mon, 28 Sep 2020 18:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KvPSUv9R+pMz0Dzvufnll0M5gsWkV0QDn6imu6rPEjk=; b=MiAX6Bl5SpKQryagLT05HOoge+
        7B+iHEAzJYuE26crASPvGyEws7E4Yhxeni3Uhs+XMuDKrgjNT79apZNSXrfWdwp2wOVHtDahFdgt4
        sZWXwjqtfunyD4fdSI+6ONkg0Z3CRINr9HJItCvj9CTOxyC4kEUuTui3i3tZGCFVaSZs2b2yHE8Vm
        +n30qIRgrDtQCjXEtGbtVZUA0JBT/rFcacxJd+TAjiaiKqNG7cBTMQhb4g13KMq0WSXbegSeIkQKa
        S8fVb70eFiDGQR6QM6nxe6VXJn7bWJbVDKshgd5QTpP0BxANSmbY0qXAqeTJ0VHWZYR0VxNw3McEt
        FieYV3zQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN4NM-0003lZ-7I; Tue, 29 Sep 2020 01:24:16 +0000
Subject: Re: [PATCH V6 5/5] platform/x86: Intel PMT Crashlog capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200929005320.14739-1-david.e.box@linux.intel.com>
 <20200929005320.14739-6-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b757ee6-52ba-5b77-5b89-d6bbd5817d11@infradead.org>
Date:   Mon, 28 Sep 2020 18:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929005320.14739-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/28/20 5:53 PM, David E. Box wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 02cb2db11417..675f3396b341 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1377,6 +1377,14 @@ config INTEL_PMT_TELEMETRY
>  	  access to hardware telemetry metrics on devices that support the
>  	  feature.
>  
> +config INTEL_PMT_CRASHLOG
> +	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
> +	select INTEL_PMT_CLASS
> +	help
> +	 The Intel Platform Monitoring Technology (PMT) crashlog driver provides
> +	 access to hardware crashlog capabilities on devices that support the
> +	 feature.
> +

Documentation/process/coding-style.rst, section 10:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

-- 
~Randy

