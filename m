Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4F2AE8B7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 07:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKGRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 01:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 01:17:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447AEC0613D1;
        Tue, 10 Nov 2020 22:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LoX8aPc+86Ek8PIchP13rPox1xYYpOQiuiixZJROd8g=; b=KklLE+H+1gveGuiv88igAb1a6x
        3eMIQIH7QwoFR0V3hw05TaxiIYPJXBpuAznT8X4IcsJuKpV8jogtOcvm3ah3zRWF86+/19Fe+pUgZ
        VJW8IC7q0fwK+07iA2ZGLdMUySWTZfz2RDjDqP7n8jCPzQ34tIwcHA2R2xQvOdBU/q7b3b+YTUXv1
        LAwkaGh6tDDj1Y9ddYd9+md/SNHWTh3OFFuk1Xah+M4+nf3z9wv0+4R6JzR8Xe+3O6sj9Rx2fDsUn
        XfR0bMTAB8K9Ye3oEq+fskqA9/WK4MYyUawk6hDDk5XfHddvlOtrr11ScoMViZ9HwgpKmQabRKeoa
        Slu0P4tw==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcjRe-00080a-Vl; Wed, 11 Nov 2020 06:17:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
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
 <20201111054356.793390-2-ben.widawsky@intel.com>
Message-ID: <57238bdc-0dc0-f6df-19b7-cb5e5bc3fc28@infradead.org>
Date:   Tue, 10 Nov 2020 22:17:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111054356.793390-2-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/10/20 9:43 PM, Ben Widawsky wrote:
> ---
>  drivers/Kconfig       |   1 +
>  drivers/Makefile      |   1 +
>  drivers/cxl/Kconfig   |  30 +++++++++++
>  drivers/cxl/Makefile  |   5 ++
>  drivers/cxl/acpi.c    | 119 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.h    |  15 ++++++
>  include/acpi/actbl1.h |  52 ++++++++++++++++++
>  7 files changed, 223 insertions(+)

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..dd724bd364df
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	help
> +	  CXL is a bus that is electrically compatible with PCI-E, but layers
> +	  three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem). The
> +	  CXL.cache protocol allows devices to hold cachelines locally, the
> +	  CXL.mem protocol allows devices to be fully coherent memory targets, the
> +	  CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support for
> +	  the configuration and management of devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_BUS_PROVIDER
> +	tristate
> +
> +config CXL_ACPI
> +	tristate "CXL Platform Support"
> +	depends on ACPI
> +	default CXL_BUS

Please provide some justification for something other than the
default default of 'n'. We try hard not to add drivers/modules that
are not required for bootup.

> +	select CXL_BUS_PROVIDER
> +	help
> +	  CXL Platform Support is a prerequisite for any CXL device driver that
> +	  wants to claim ownership of the component register space. By default
> +	  platform firmware assumes Linux is unaware of CXL capabilities and
> +	  requires explicit opt-in. This platform component also mediates
> +	  resources described by the CEDT (CXL Early Discovery Table)

end sentence with '.'

> +
> +	  Say 'y' to enable CXL (Compute Express Link) drivers.

	  or 'm'

> +endif


-- 
~Randy

