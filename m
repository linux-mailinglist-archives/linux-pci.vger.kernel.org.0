Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A132AE8B3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 07:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgKKGRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 01:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGRU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 01:17:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993CC0613D1;
        Tue, 10 Nov 2020 22:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kGYmI/Q6Qz0/0VlGhaOnBJBqjqnYbQCh0GWbtl2e1Es=; b=GBtVWmiIT0NgrhKoxSVkVZpC24
        /97KAT4o4d0fOpB5PtVxfzOA8gEh1zZ7+3aezyHPpss6hSbIZ1Bs06njo7p+UBCviitngnjTX3m2M
        AG65JPtruyeK8QU3HaPqIn0EgALUkx4Eqc3oj/oELOVNnBzOhm2ZRJGE68jWRCi0FrRUs1na9ushh
        pAeU7QWFHb+/ig3ToybGI8CpcKJHTpyYJD3ZS1Y+usjF7QC+JUAD/iRmuyB/IL4ahTtVjYoirc19B
        mRU6QzBhE991shqiXe9xYDAxJfPE4vnuf5vGhUaNTgjS1n38eXK05NjBnspS4lJsY3/0rTJWnOY7t
        Sk9vuFbg==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcjRS-00080D-6G; Wed, 11 Nov 2020 06:17:14 +0000
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1dbfc3a3-5f81-90b2-5b0b-5dcb99e2eecd@infradead.org>
Date:   Tue, 10 Nov 2020 22:17:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111054356.793390-4-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/10/20 9:43 PM, Ben Widawsky wrote:
> ---
>  drivers/cxl/Kconfig  | 20 +++++++++++
>  drivers/cxl/Makefile |  2 ++
>  drivers/cxl/mem.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.h    | 15 ++++++++
>  4 files changed, 119 insertions(+)

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index dd724bd364df..15548f5c77ff 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -27,4 +27,24 @@ config CXL_ACPI
>  	  resources described by the CEDT (CXL Early Discovery Table)
>  
>  	  Say 'y' to enable CXL (Compute Express Link) drivers.
> +
> +config CXL_MEM
> +        tristate "CXL.mem Device Support"
> +        depends on PCI && CXL_BUS_PROVIDER != n
> +        default m if CXL_BUS_PROVIDER

The "if CXL_BUS_PROVIDER" should be redundant due to the "depends on" clause.
However, having any default or 'm' or 'y' needs to be justified.

> +        help
> +          The CXL.mem protocol allows a device to act as a provider of
> +          "System RAM" and/or "Persistent Memory" that is fully coherent
> +          as if the memory was attached to the typical CPU memory
> +          controller.
> +
> +          Say 'y/m' to enable a driver named "cxl_mem.ko" that will attach

The builtin driver will not be named cxl-mem.ko.

> +          to CXL.mem devices for configuration, provisioning, and health
> +          monitoring, the so called "type-3 mailbox". Note, this driver
> +          is required for dynamic provisioning of CXL.mem attached
> +          memory, a pre-requisite for persistent memory support, but

	               prerequisite

> +          devices that provide volatile memory may be fully described by
> +          existing platform firmware memory enumeration.
> +
> +          If unsure say 'n'.
>  endif


-- 
~Randy

