Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510D52F28AD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 08:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391834AbhALHJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 02:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391833AbhALHJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 02:09:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677FC061786;
        Mon, 11 Jan 2021 23:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CYhz2Ww/JXYKS7gTcI5CvohnDk+EDidThWUqwG2Ttlk=; b=pYHgNYbZ4/WygPHbzSXMWCqjHU
        1EtyDbg3RO8A5KqFZMlr/KrvQ+1EOg8B5lrKvxHpb8636SaifgqV2MM4z+4brPmz4mvt4RAJdK2dg
        VDArwdpyAr5ZXxZIe7/6JjSA7/ZDBOXxB8FygyiRE1m5C9ozWu4aYH0BmP4Fh+jv2nIMmMKKa2H0C
        HtVlrNrFednhCJrtkSqcbWhbt7zEZtqdhn+zigsFDa5x54/eFyQ0/4arJgXO8KKKAgozCcyeEqHt5
        uktkarKQ+A14/BzmYM/V4pS20btBhfEuEhllEAWaoLRvII6mx0K/3DnU0de4i7gaYLCp5Tg0KwdSr
        1G6rbqdw==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzDnQ-0003IY-1q; Tue, 12 Jan 2021 07:08:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 04/16] cxl/mem: Introduce a driver for
 CXL-2.0-Type-3 endpoints
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-5-ben.widawsky@intel.com>
Message-ID: <be6456ce-cc57-49fb-1637-00feda6a550c@infradead.org>
Date:   Mon, 11 Jan 2021 23:08:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111225121.820014-5-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/11/21 2:51 PM, Ben Widawsky wrote:
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 68da926ba5b1..0ac5080cd6e0 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -33,4 +33,26 @@ config CXL_ACPI
>  	  specification.
>  
>  	  If unsure say 'm'
> +
> +config CXL_MEM
> +        tristate "CXL.mem: Endpoint Support"
> +        depends on PCI && CXL_BUS_PROVIDER
> +        default CXL_BUS_PROVIDER
> +        help
> +          The CXL.mem protocol allows a device to act as a provider of
> +          "System RAM" and/or "Persistent Memory" that is fully coherent
> +          as if the memory was attached to the typical CPU memory
> +          controller.

All of those indented lines should use one tab (tristate, depends, default,
and help). The help text should be indented with one tab + 2 spaces,
like the lines below are.

> +
> +	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
> +	  a module) that will attach to CXL.mem devices for
> +	  configuration, provisioning, and health monitoring. This
> +	  driver is required for dynamic provisioning of CXL.mem
> +	  attached memory which is a pre-requisite for persistent memory

patch 2 spells this as:              prerequisite
which is preferred IMO.

> +	  support. Typically volatile memory is mapped by platform
> +	  firmware and included in the platform memory map, but in some
> +	  cases the OS is responsible for mapping that memory. See
> +	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> +
> +          If unsure say 'm'.

That last line needs one tab + 2 spaces for indentation.

>  endif


-- 
~Randy

